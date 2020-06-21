#include "\nocebo\defines\scriptDefines.hpp"

// EX: [1,4] call horde_fnc_randomInteger

params ["_min","_max"];
if (_min > 0) then {
	(floor random (_max - _min + 1)) + _min;
} else {
	floor random (_max + 1);
};