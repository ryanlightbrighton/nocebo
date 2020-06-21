#include "\nocebo\defines\scriptDefines.hpp"

params ["_veh","_position","_unit","_path"];

// fired on server

if same({alive _x} count crew _veh,1) then {
	_veh setVariable ["vehicleAbandonedTime",nil];
	_veh enableDynamicSimulation false;
};

if not (isPlayer _unit) then {
	setVar(_veh,"vehicleAllCombatantsOrderedOut",nil);
	private _cfgTurrets = configfile >> "CfgVehicles" >> (typeOf _veh) >> "Turrets";
	{
	    _cfgTurrets = _cfgTurrets >> configName (_cfgTurrets select _x);
	} forEach _path;
	if not (getArray (_cfgTurrets >> "TurnOut" >> "limitsArrayBottom") isEqualTo []) then {
	    _unit action ["TurnOut",_veh];
	};
} else {
    if (ncb_param_enableChannelVehicleChat or {ncb_param_enableChannelVehicleRadio}) then {
    	[4,[ncb_param_enableChannelVehicleChat,ncb_param_enableChannelVehicleRadio]] remoteExecCall [
    		"enableChannel",
    		_unit
    	]
    }
};

if (vectorMagnitude velocity _veh < 0.1) then {
	[_veh,[0,0,-0.5]] call horde_fnc_setVelocityGlobal;
};

true