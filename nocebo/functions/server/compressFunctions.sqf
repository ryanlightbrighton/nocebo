#include "\nocebo\defines\scriptDefines.hpp"

// NOTE: SERVER ONLY

with uiNamespace do {
	_fnc_compress = {
		//            !  %  "  '  ^  *  (  )  {    }  [  ]  ;  :  <  >  /  +  -  =  .   |  !  &  ,  _
		// characters 33,37,34,39,94,42,40,41,123,125,91,93,59,58,60,62,47,43,45,61,46,124,33,38,44,95
		private _fnc_arrayShuffle = {
			private _result = [];
			for "_i" from 1 to count _this do {
				_result pushBack (_this deleteAt floor random count _this);
			};
			_result
		};
		// setup variables
		private _symbolChars = [33,37,34,39,94,42,40,41,123,125,91,93,59,58,60,62,47,43,45,61,46,124,33,38,44];
		private _wsChars = [9,10,13,32];
		private _alphabet = (toArray "_abcdefghijklmnopqrstuvwxyz0123456789") call _fnc_arrayShuffle;
		#define idx(a) (_forEachIndex + a)
		#define lowerNum(a) (toArray toLower toString [a]) select 0

		private _array = toArray _this;
		diag_log format ["Char count start: %1", count _array];

		private _variables = [];
		private _stringCharIndexes = [];
		private _end = -1;
		private _maxIndex = count _array -1;
		{
			private _start = 0;
			private _isVariable = true;
			// don't add strings we have already added
			if (_forEachIndex > _end) then {
				if (34 isEqualTo _x) then {
					scopeName "pluto";
					_start = _forEachIndex;
					// is this string a variable or true string?
					if (_array select idx(1) isEqualTo 95) then {
						// test if this is a variable ex: (could be "_nul = 1 + 2" or "_myVar")
						for "_i" from idx(1) to count _array -1 do {
							private _lowerChar = lowerNum(_array select _i);
							if not (34 isEqualTo _lowerChar) then {
								if not (_lowerChar in _alphabet) then {
									_isVariable = false;
								}
							} else {
								_end = _i;
								// reached the end
								breakTo "pluto"
							}
						}
					} else {
						// definitely a string
						_isVariable = false;
						for "_i" from idx(1) to count _array -1 do {
							private _lowerChar = lowerNum(_array select _i);
							if (34 isEqualTo _lowerChar) then {
								_end = _i;
								// reached the end
								breakTo "pluto"
							}
						}
					};
					// add to respective array (if a var, then log the var to main var names array)
					if (_isVariable) then {
						private _variable = [];
						for "_i" from _start to _end do {
							_array set [_i,lowerNum(_array select _i)];
							if (_i > _start and {_i < _end}) then {
								_variable pushBack (_array select _i)
							}
						};
						if not ([] isEqualTo _variable) then {
							_variables pushBackUnique _variable
						}
					} else {
						for "_i" from _start to _end do {
							_stringCharIndexes pushBack _i
						}
					}
				} else {
					_array set [_forEachIndex,lowerNum(_x)];
					_x = lowerNum(_x);
					call {
						// or
						if (_x isEqualTo 111
						    and {_forEachIndex < _maxIndex - 2}
						    and {not(_array select idx(-1) in _alphabet)}
						    and {lowerNum(_array select idx(1)) isEqualTo 114}
						    and {not(lowerNum(_array select idx(2)) in _alphabet)}
						) exitWith {
							_end = idx(1);
							_array set [_forEachIndex,124];
							_array set [idx(1),124]
						};
						// and
						if (_x isEqualTo 97
						    and {_forEachIndex < _maxIndex - 3}
						    and {not(_array select idx(-1) in _alphabet)}
						    and {lowerNum(_array select idx(1)) isEqualTo 110}
						    and {lowerNum(_array select idx(2)) isEqualTo 100}
						    and {not(lowerNum(_array select idx(3)) in _alphabet)}
						) exitWith {
							_end = idx(2);
							_array set [_forEachIndex,38];
							_array set [idx(1),38];
							_array set [idx(2),10];
						};
						// not [110,111,116]
						if (_x isEqualTo 110
						    and {_forEachIndex < _maxIndex - 3}
						    and {not(_array select idx(-1) in _alphabet)}
						    and {lowerNum(_array select idx(1)) isEqualTo 111}
						    and {lowerNum(_array select idx(2)) isEqualTo 116}
						    and {not(lowerNum(_array select idx(3)) in _alphabet)}
						) exitWith {
							_end = idx(2);
							_array set [_forEachIndex,33];
							_array set [idx(1),10];
							_array set [idx(2),10];
						};

						// moved up from next loop
						private _lastChar = "ws";
						private _nextChar = "ws";
						if (_x in _wsChars) then {
							_start = _forEachIndex;
							scopeName "mercury";
							// get range to delete
							for "_i" from _forEachIndex - 1 to 0 step - 1 do {
								call {
									if (lowerNum(_array select _i) in _alphabet) exitWith {
										_lastChar = "alphabet";
										_start = _i + 1;
										breakTo "mercury"
									};
									if (_array select _i in _symbolChars) exitWith {
										_lastChar = "symbol";
										_start = _i + 1;
										breakTo "mercury"
									};
								}
							};
							for "_i" from idx(1) to count _array - 1 do {
								call {
									if (lowerNum(_array select _i) in _alphabet) exitWith {
										_nextChar = "alphabet";
										_end = _i - 1;
										breakTo "mercury"
									};
									if (_array select _i in _symbolChars) exitWith {
										_nextChar = "symbol";
										_end = _i - 1;
										breakTo "mercury"
									};
								}
							};
							// how many can we delete?
							private _ok = true;
							if (_lastChar == "alphabet" and {_nextChar == "alphabet"}) then {
								// leave a space
								_start = _start + 1;
								if not (_start < _end) then {
									_ok = false
								}
							};
							if (_ok) then {
								for "_i" from _start to _end do {
									_array set [_i,-1]
								}
							}
						}
					}
				}
			}
		} forEach _array;

		_array = _array - [-1];

		// now gather variables in format "private _myVar" (also, log positions of "_" character so its a faster search on the next run through)
		private _maxIndex = count _array - 1;
		private _variableIndexes = [];
		private _start = 0;
		private _end = -1;
		{
			scopeName "neptune";
			if (_forEachIndex > _end) then {
				if (_x isEqualTo 112
					and {_array select idx(1) isEqualTo 114}
					and {_array select idx(2) isEqualTo 105}
					and {_array select idx(3) isEqualTo 118}
					and {_array select idx(4) isEqualTo 97}
					and {_array select idx(5) isEqualTo 116}
					and {_array select idx(6) isEqualTo 101}
					and {_array select idx(7) isEqualTo 32}
					and {_array select idx(8) isEqualTo 95}
				) then {
					private _variable = [_array select idx(8)];
					private _indexes = [idx(8)];
					for "_i" from idx(9) to count _array -1 do {
						if not (_array select _i in _alphabet) then {
							_end = _i;
							_variables pushBackUnique _variable;
							_variableIndexes pushBack _indexes;
							breakTo "neptune"
						} else {
							_variable pushBack (_array select _i);
							_indexes pushBack _i;
						}
					};
				} else {
					if (_x isEqualTo 95) then {
						if (_forEachIndex == 0 or {not(_array select idx(-1) in _alphabet)}) then {
							if (_array select idx(1) in _alphabet) then {
								private _indexes = [_forEachIndex,idx(1)];
								for "_i" from idx(2) to count _array - 1 do {
									if (_array select _i in _alphabet) then {
										_indexes pushBack _i;
										if (_i == _maxIndex) then {
											_variableIndexes pushBack _indexes;
											breakTo "neptune"
										}
									} else {
										_end = _i;
										_variableIndexes pushBack _indexes;
										breakTo "neptune"
									}
								}
							}
						}
					} else {
						if (_forEachIndex > 0
						    and {_x isEqualTo 125}
						    and {_array select idx(-1) isEqualTo 59}
						) then {
							_array set [idx(-1),-1]
						}
					}
				}
			}
		} forEach _array;

		// now we have logged all variable names (and got their starting positions), we can shorten them down.  Also, we can delete unneeded ";" characters

		// note - do not change variables with two characters (like _i for example).  They could get changed to _x

		private _alphaMaxIndex = (count _alphabet) -1;
		private _indexCounter = [0,0];
		{
			private _variable = _x;
			// generate code
			if (count _variable > 2) then {
				if (_indexCounter select 1 == _alphaMaxIndex) then {
					_indexCounter = [(_indexCounter select 0) + 1,0];
				};
				private _code = [_alphabet select (_indexCounter select 0),_alphabet select (_indexCounter select 1)];
				_indexCounter = [_indexCounter select 0,(_indexCounter select 1) + 1];
				{
					private _variableToChange = [];
					{
						_variableToChange pushBack (_array select _x);
					} forEach _x;
					if (_variableToChange isEqualTo _variable) then {
						{
							if (_forEachIndex > 2) then {
								_array set [_x,-1]
							} else {
								if (_forEachIndex == 1) then {
									_array set [_x,_code select 0]
								};
								if (_forEachIndex == 2) then {
									_array set [_x,_code select 1]
								};
							}
						} forEach _x;
					}
				} forEach _variableIndexes;
			}
		} forEach _variables;

		_array = _array - [-1];
		diag_log format ["Char count end: %1", count _array];
		toString _array
	};
	_time1 = diag_tickTime;
	_count = 0;
	private _functions = [];
	{
		_x params ["_cfgName","_public"];
		{
			private _fncName = "horde_fnc_" + configName _x;
			diag_log format ["%1",_fncName];
			_text = (preprocessFile (getText (_x >> "file"))) call _fnc_compress;
			diag_log "------------------";
			uiNameSpace setVariable [_fncName,compileFinal _text];
			_functions pushBack [_fncName,_public];
			_count = _count + 1;
		} forEach ("true" configClasses (configFile >> "CfgCompressFunctions" >> "Horde" >> _cfgName));
	} forEach [
		["client",true],
		["common",true],
		["server",false]
	];
	diag_log format ["%1 functions compressed in %2 seconds",_count,diag_tickTime - _time1];
	uiNameSpace setVariable ["ncb_uv_compressedFunctionsList",_functions];


	// files affected serverPreInit, clientPostInit, (common\init) loading.fsm, description.ext
};

true