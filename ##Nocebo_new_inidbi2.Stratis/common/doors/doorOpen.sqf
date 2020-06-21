#include "\nocebo\defines\scriptDefines.hpp"

params ["_house","_selectionName","_doorType","_door","_handle1"];

[_house,_doorType,_selectionName] call horde_fnc_canOpenDoor params ["_worldPos","_sesame","_nearPlayers","_houseKeyName"];

if not (isNull _sesame) then {
	// exit if AI is already opening the door (they seem to spam it as they walk towards)
	if (not isPlayer _sesame and {_house animationSourcePhase _door > 0}) exitWith {true};
	_house animateSource [_handle1,1];
	_house animateSource [_door,1];
	_house animateSource [format ["Door_%1_noSound_source", parseNumber (_door select [5,99])],1]; // new bodge for double doors
	if not (isPlayer _sesame) then {
		[
			[_this],{
				call horde_fnc_getEachFrameArgs params ["_doorInfo"];
				_doorInfo call horde_fnc_doorClose;
				call horde_fnc_removeEachFrame
			},
			5
		] call horde_fnc_addEachFrame;
	};
} else {
	if not empty(_nearPlayers) then {
		[_houseKeyName,_doorType,_worldPos] call horde_fnc_doorLocked;
		_house animateSource [_handle1,1];
		[
			[_house,_door,_handle1,0],{
				call horde_fnc_getEachFrameArgs params ["_house","_door","_handle1","_slams"];
				if (_house animationSourcePhase _door == 0) then {
					_house animateSource [_door,0.11];
				} else {
					_house animateSource [_door,0];
					_slams = _slams + 1;
					[_house,_door,_handle1,_slams] call horde_fnc_updateEachFrameArgs;
					if (_slams > 1) then {
						call horde_fnc_removeEachFrame
					}
				}
			},
			0.15
		] call horde_fnc_addEachFrame;
	};
};

true