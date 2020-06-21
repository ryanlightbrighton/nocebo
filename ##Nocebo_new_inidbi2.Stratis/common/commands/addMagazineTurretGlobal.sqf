#include "\nocebo\defines\scriptDefines.hpp"

params ["_object","_mag","_turret"];

if not (isNull _object) then {
	if (_object turretLocal _turret) then {
		_object addMagazineTurret [_mag,_turret];
	} else {
		if (isServer) then {
			_this remoteExecCall [
				"horde_fnc_addMagazineTurretGlobal",
				_object turretOwner _turret
			];
		} else {
			_this remoteExecCall [
				"horde_fnc_addMagazineTurretGlobal",
				2
			];
		};
	};
};
true