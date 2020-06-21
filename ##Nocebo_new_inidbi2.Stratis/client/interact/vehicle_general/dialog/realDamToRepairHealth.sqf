#include "\nocebo\defines\scriptDefines.hpp"

// ex: ["ncb_veh_varsuk","engine",0.5] call horde_fnc_realDamToRepairHealth

params ["_class","_cfgName","_value"];
linearConversion [
	0,
	getNumber ( configFile >> "CfgVehicles" >> _class >> "VehicleInteractionInfo" >> _cfgName >> "maxDamage"),
	_value,
	100,
	0,
	true
]