#include "\nocebo\defines\scriptDefines.hpp"

// obsolete - moved to OEF launched from clientPostInit.sqf

// broadcast to other clients

params ["_unit"];

[
	[_unit],{
		call horde_fnc_getEachFrameArgs params ["_unit"];
		if (lifeState _unit == "incapacitated") then {
			drawIcon3D ["nocebo\images\skull.paa", [1,1,1,1], _unit modelToWorldVisual [0,0,0.5], 2, 2, 0, "Incapacitated", 1, 0.02, "TahomaB"]
			/*drawIcon3D [
				"nocebo\images\skull.paa",
				[1,1,1,1],
				_unit modelToWorldVisual [0,0,0.5],
				1, // 250 / (_unit distance player) min 1,
				1, // 250 / (_unit distance player) min 1,
				0,
				"Incapacitated",
				2,
				1, // 250 - (_unit distance player) min 0.01,
				"TahomaB"
			]*/
		} else {
			call horde_fnc_removeEachFrame
		}
	},
	0
] call horde_fnc_addEachFrame;

true