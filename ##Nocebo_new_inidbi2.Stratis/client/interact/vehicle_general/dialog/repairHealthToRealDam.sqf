#include "\nocebo\defines\scriptDefines.hpp"

// ex: ["ncb_veh_varsuk","engine",55] call horde_fnc_realDamToRepairHealth

params ["_class","_cfgName","_value"];
linearConversion [
	0,
	100,
	_value,
	getNumber (configFile >> "CfgVehicles" >> _class >> "VehicleInteractionInfo" >> _cfgName >> "maxDamage"),
	0,
	true
]