#include "\nocebo\defines\scriptDefines.hpp"

params ["_object"];

if not (alive _object) then {
	[
		[_object],{
			call horde_fnc_getEachFrameArgs params ["_object"];
			hideBody _object;
			[
				{
					call horde_fnc_getEachFrameArgs params ["_object"];
					deleteVehicle _object;
					call horde_fnc_removeEachFrame
				},
				5
			] call horde_fnc_updateEachFrameData
		},
		0.5
	] call horde_fnc_addEachFrame;
} else {
	diag_log format ["ATTEMPTED ILLEGAL USE OF SERVERHIDEBODY ON %1",_object]
};

true

/*params ["_object"];

if not (alive _object) then {
	[
		[_object,1,getPosWorld _object],{
			call horde_fnc_getEachFrameArgs params ["_object","_iteration","_currentPos"];
			if (_iteration < 500) then {
				_currentPos = _currentPos vectorAdd [0,0,-0.002];
				_object setPosWorld _currentPos;
				_iteration = _iteration + 1;
				[_object,_iteration,_currentPos] call horde_fnc_updateEachFrameArgs
			} else {
				deleteVehicle _object;
				call horde_fnc_removeEachFrame
			}
		},
		0.01
	] call horde_fnc_addEachFrame;
} else {
	diag_log format ["ATTEMPTED ILLEGAL USE OF SERVERHIDEBODY ON %1",_object]
};

true*/