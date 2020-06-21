#include "\nocebo\defines\scriptDefines.hpp"

[
	[],{
		if (not dialog) then {
			createDialog "Horde_respawnMenu";
			call horde_fnc_removeEachFrame
		}
	},
	0
] call horde_fnc_addEachFrame;

true