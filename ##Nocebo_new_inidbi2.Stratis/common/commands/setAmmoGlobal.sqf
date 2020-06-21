#include "\nocebo\defines\scriptDefines.hpp"

params ["_object","_weap","_count"];

if not (isNull _object) then {
	if (local _object) then {
		_object setAmmo [_weap,_count];
	} else {
		_this remoteExecCall [
			"horde_fnc_setAmmoGlobal",
			_object
		];
	};
};
true