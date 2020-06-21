#include "\nocebo\defines\scriptDefines.hpp"

// example

/*_myArray = [1,2,3,4,5];

_code = {
	{
		systemChat format ["%1 - %2",_x,diag_frameno]
	} forEach _this
};

[_myArray,_code] call horde_fnc_iterateArrayEachFrame*/

if (isNil "ncb_gv_iterateData") then {
	ncb_gv_iterateData = []
};
params ["_array","_code"];
private _idx = addMissionEventHandler [
	'EachFrame',
	{
		{
			_x params ["_id","_array","_data"];
			if (_id isEqualTo _thisEventHandler) exitWith {
				_data params ["_code","_frame","_index"];
				if (diag_frameno > _frame) then {
					if (_index < count _array) then {
						[_array select _index] call _code;
						ncb_gv_iterateData set [_forEachIndex,[_thisEventHandler,_array,[_code,diag_frameno,_index + 1]]];
					} else {
						removeMissionEventHandler ["EachFrame",_thisEventHandler];
						ncb_gv_iterateData deleteAt _forEachIndex;
					}
				}
			}
		} forEach ncb_gv_iterateData
	}
];
ncb_gv_iterateData pushBack [
	_idx,
	+_array,
	[_code,diag_frameno,0]
];
true