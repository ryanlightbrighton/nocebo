#include "\nocebo\defines\scriptDefines.hpp"

params ["_house","_selectionName","_doorType","_doorA","_doorB"];

[_house,_doorType,_selectionName] call horde_fnc_canOpenDoor params ["_worldPos","_sesame","_nearPlayers","_houseKeyName"];

if not (isNull _sesame) then {
	// exit if AI is already opening the door (they seem to spam it as they walk towards)
	if (not isPlayer _sesame and {_house animationSourcePhase _doorA > 0}) exitWith {true};
	_house animateSource [_doorA, 1];
	_house animateSource [_doorB, 1];
	if not (isPlayer _sesame) then {
		[
			[_this],{
				call horde_fnc_getEachFrameArgs params ["_doorInfo"];
				_doorInfo call horde_fnc_twoWingSlideDoorClose;
				call horde_fnc_removeEachFrame
			},
			5
		] call horde_fnc_addEachFrame;
	};
} else {
	if not empty(_nearPlayers) then {
		[_houseKeyName,_doorType,_worldPos] call horde_fnc_doorLocked;
	};
};

true