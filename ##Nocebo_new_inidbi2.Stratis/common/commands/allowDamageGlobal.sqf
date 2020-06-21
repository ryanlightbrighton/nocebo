#include "\nocebo\defines\scriptDefines.hpp"

params ["_unit","_bool"];

if not (isNull _unit) then {
	if (local _unit) then {
		_unit allowDamage _bool
	} else {
		_this remoteExecCall [
			"horde_fnc_allowDamageGlobal",
			_unit
		];
	};
};

true