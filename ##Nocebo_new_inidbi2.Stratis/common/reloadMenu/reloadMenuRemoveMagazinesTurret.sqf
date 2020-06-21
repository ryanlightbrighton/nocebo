#include "\nocebo\defines\scriptDefines.hpp"

params ["_sourceObj","_data","_caller"];
if (_sourceObj turretLocal (_data select 1)) then {
	_sourceObj removeMagazinesTurret _data;
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
		[_sourceObj,_data,_caller] remoteExecCall [
			"horde_fnc_reloadMenuRemoveMagazinesTurret",
			_sourceObj turretOwner (_data select 1)
		]
	} else {
		[_sourceObj,_data,_caller] remoteExecCall [
			"horde_fnc_reloadMenuRemoveMagazinesTurret",
			2
		]
	}
}