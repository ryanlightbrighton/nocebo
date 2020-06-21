#include "\nocebo\defines\scriptDefines.hpp"

params ["_sourceObj","_sourceMag","_path","_currentMags","_caller"];
if (_sourceObj turretLocal _path) then {
	{
		if (_x select 0 == _sourceMag) then {
			_sourceObj addMagazineTurret [_x select 0,_path,_x select 1]
		};
	} count _currentMags;
	if (local _caller) then {
		ncb_gv_vehicleAmmoChanged = true
	} else {
		true remoteExecCall [
			"horde_fnc_reloadMenuUpdateVehMags",
			_caller
		]
	}
} else {
	if (isServer) then {
		[_sourceObj,_sourceMag,_path,_currentMags,_caller] remoteExecCall [
			"horde_fnc_reloadMenuAddMagazinesTurret",
			_sourceObj turretOwner _path
		]
	} else {
		[_sourceObj,_sourceMag,_path,_currentMags,_caller] remoteExecCall [
			"horde_fnc_reloadMenuAddMagazinesTurret",
			2
		]
	}
}