#include "\nocebo\defines\scriptDefines.hpp"

params ["_targetObj","_targetMag","_path","_currentMags","_caller"];
if (_targetObj turretLocal _path) then {
	_targetObj removeMagazinesTurret [_targetMag,_path];
	{
		_targetObj addMagazineTurret [_x select 0,_path,_x select 1]
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
		[_targetObj,_targetMag,_path,_currentMags,_caller] remoteExecCall [
			"horde_fnc_reloadMenuUpdateMagazinesTurret",
			_targetObj turretOwner _path
		]
	} else {
		[_targetObj,_targetMag,_path,_currentMags,_caller] remoteExecCall [
			"horde_fnc_reloadMenuUpdateMagazinesTurret",
			2
		]
	}
}