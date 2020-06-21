#include "\nocebo\defines\scriptDefines.hpp"

params ["_object","_mag","_turret"];

if not (isNull _object) then {
	if (_object turretLocal _turret) then {
		_object removeMagazineTurret [_mag,_turret];
	} else {
		if (isServer) then {
			_this remoteExecCall [
				"horde_fnc_removeMagazineTurretGlobal",
				_object turretOwner _turret
			];
		} else {
			_this remoteExecCall [
				"horde_fnc_removeMagazineTurretGlobal",
				2
			];
		};
	};
};
true