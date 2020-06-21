/*#define diag(a,b) (diag_log format [prefix + "editorVehsInit.sqf"" - " + a + ": %1",b])
#include "\nocebo\defines\scriptDefines.hpp"*/

if (isServer) then {
	if (ncb_param_debugMode == 0) then {
		deleteVehicle _this
	} else {
		_this addEventHandler ["killed",{
			(_this select 0) spawn horde_fnc_startVehicleFire;
			_this call horde_fnc_vehicleKilled
		}];
		_this allowDamage true;
		_this addBackpackCargo ["ncb_weaponbag_hmg_low",1];
		_this addBackpackCargo ["ncb_weaponbag_tripod",1];
		_this addEventHandler ["GetIn", {
			_this call horde_fnc_getInVehicle
		}];
		_this addEventHandler ["GetOut", {
			_this call horde_fnc_getOutVehicle
		}];
		if (ncb_param_lockEnemyVehicles) then {
			_this setVehicleLock "LOCKED"
		};
		if (ncb_param_aiDisableVehicleVisionNV) then {
			_this disableNVGEquipment true
		};
		if (ncb_param_aiDisableVehicleVisionTI) then {
			_this disableTIEquipment true
		};
		_this call horde_fnc_vehicleDamageAnimSetup
	};
};

true