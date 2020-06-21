#include "\nocebo\defines\scriptDefines.hpp"

params ["_unit","_weap"];

if not (isNull _unit) then {
	if (local _unit) then {
		_unit addWeapon _weap
	} else {
		_this remoteExecCall [
			"horde_fnc_addWeaponGlobal",
			_unit
		];
	};
};

true