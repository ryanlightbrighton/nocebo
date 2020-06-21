#include "\nocebo\defines\scriptDefines.hpp"

// remember EH is local/local
// this must run on server or turretOwner will not work

params ["_veh","_weap","","","_old"];

if ({isPlayer _x} count crew _veh > 0
	or {not isNil {_veh getVariable "vehiclePlayerInteracting"}}
) exitWith {
	false
};

{
	if (_weap in (_veh weaponsTurret _x)) exitWith {
		[_veh,[_old select 0,_x]] remoteExecCall [
			"addMagazineTurret",
			_veh turretOwner _x
		];
	}
} forEach ([[-1]] + allTurrets _veh);

true