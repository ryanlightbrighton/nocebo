#include "\nocebo\defines\scriptDefines.hpp"

params ["_leader","_zonePosATL","_zoneTargets","_players","_playersInAdjZones"];

// change back from calculating positional error to using _posAccuracy

{
	private _player = _x;
	/*_tgtData = _leader targetKnowledge _player;
	_tgtData params ["_knownByGroup","_knownByUnit","","","_tgtSide","_posAccuracy","_tgtPosASL"];
	if (_knownByUnit or {_knownByGroup}) then {*/
	private _tgtData = (_leader nearTargets ((_leader distance vehicle _player) + 100)) select {_x select 4 == vehicle _player};
	// diag_log format ["tgtdata: %1",_tgtData];
	if not (_tgtData isEqualTo []) then {
		_tgtData select 0 params ["_tgtPosAGL","","","","","_posAccuracy"];
		if (_tgtPosAGL distance _zonePosATL < ncb_gv_zoneRadius) then {
			scopeName "indent_3";
			private _inArray = false;
			private _knowsAbout = _leader knowsAbout _player;
			_tgtData = [
				_player,
				_tgtPosAGL,
				_posAccuracy,
				_knowsAbout
			];

			{
				_x params ["_player2","","_error2"];
				if same(_player,_player2) then {
					if (_posAccuracy < _error2) then {
						_zoneTargets set [_forEachIndex,_tgtData];
					};
					_inArray = true;
					breakTo "indent_3";
				};
			} forEach _zoneTargets;
			if (not _inArray) then {
				_zoneTargets pushBack _tgtData;
			};
		} else {
			_playersInAdjZones = true;
		};
	};
	true
} count _players;

[_zoneTargets,_playersInAdjZones]

// old version

/*private ["_zonePosATL","_zoneTargets","_playersInAdjZones","_tgtData","_tgtPos","_tgtType","_tgtSide","_tgtObject","_posAccuracy","_inArray"];

_leader = sel(_this,0);
_zonePosATL = sel(_this,1);
_zoneTargets = sel(_this,2);
_playersInAdjZones = sel(_this,3);

{
	_tgtData = _x;
	_tgtPos = sel(_tgtData,0);
	_tgtType = sel(_tgtData,1);
	_tgtSide = sel(_tgtData,2);
	_tgtObject = sel(_tgtData,4);
	_posAccuracy = sel(_tgtData,5);

	if (isPlayer _tgtObject) then {
		_dist = _tgtPos distance _zonePosATL;
		if (_dist < ncb_gv_zoneRadius) then {
			scopeName "indent_3";
			_inArray = false;
			{
				if same(_tgtObject,sel(_x,4)) then {
					if (_posAccuracy < sel(_x,5)) then {
						_zoneTargets set [_forEachIndex,_tgtData];
					};
					_inArray = true;
					breakTo "indent_3";
				};
			} forEach _zoneTargets;
			if (not _inArray) then {
				_zoneTargets pushBack _tgtData;
			};
		} else {
			_playersInAdjZones = true;
		};
	};
	true
} count (_leader nearTargets ((_leader distance _zonePosATL) + (ncb_gv_zoneRadius / 2)));

[_zoneTargets,_playersInAdjZones]*/
