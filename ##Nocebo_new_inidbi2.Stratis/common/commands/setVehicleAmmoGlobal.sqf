#include "\nocebo\defines\scriptDefines.hpp"

params ["_unit","_ammo"];

if not (isNull _unit) then {
	if (local _unit) then {
		_unit setVehicleAmmo _ammo
	} else {
		_this remoteExecCall [
			"horde_fnc_setVehicleAmmoGlobal",
			_unit
		];
	};
};
true