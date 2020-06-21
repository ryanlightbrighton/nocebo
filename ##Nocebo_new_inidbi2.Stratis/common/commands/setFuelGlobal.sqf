#include "\nocebo\defines\scriptDefines.hpp"

params ["_object","_fuel"];

if not (isNull _object) then {
	if (local _object) then {
		_object setFuel _fuel;
	} else {
		_this remoteExecCall [
			"horde_fnc_setFuelGlobal",
			_object
		];
	};
};
true