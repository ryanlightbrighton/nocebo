#include "\nocebo\defines\scriptDefines.hpp"

params ["_vehClass","_spawnPosASL","_age","_crewPoolVarName","_cargoPoolVarName","_grp"];

private _cfgVeh = cfgVeh >> _vehClass;
private _veh = if (_vehClass isKindOf "Air") then {
	createVehicle [_vehClass,ASLtoAGL _spawnPosASL,[],0,"fly"];
} else {
	spawnVeh(_vehClass,ASLtoAGL _spawnPosASL);
};

if same(getNumber(_cfgVeh >> "hasDriver"),1) then { // maybe this line is redundant - they all have drivers!
	private _unit = getVar(missionNamespace,_crewPoolVarName) deleteAt 0;
	[_unit] joinSilent _grp;
	_unit enableSimulationGlobal true;
	_unit hideObjectGlobal false;
	_unit moveInDriver _veh;
	[_unit,true] call horde_fnc_allowDamageGlobal;
	_unit enableAI "checkVisible";
};

// now turrets

{
	private _unit = getVar(missionNamespace,_crewPoolVarName) deleteAt 0;
	[_unit] joinSilent _grp;
	_unit enableSimulationGlobal true;
	_unit hideObjectGlobal false;
	_unit moveInTurret [_veh,_x];
	[_unit,true] call horde_fnc_allowDamageGlobal;
	_unit enableAI "checkVisible";
} count allTurrets [_veh,true];

scopeName "0";
if diff(_cargoPoolVarName,"no_passengers") then {
	for "_i" from 1 to 8 do {
		if (diff(_veh emptyPositions "cargo",0)
			and {diff(count units _grp,8)}
		) then {
			private _unit = getVar(missionNamespace,_cargoPoolVarName) deleteAt 0;
			[_unit] joinSilent _grp;
			_unit enableSimulationGlobal true;
			_unit hideObjectGlobal false;
			_unit moveInCargo _veh;
			[_unit,true] call horde_fnc_allowDamageGlobal;
			_unit enableAI "checkVisible";
		} else {
			breakTo "0"
		};
	};
};

_grp addVehicle _veh;
_grp allowFleeing 0;

// _veh call horde_fnc_vehicleDamageAnimSetup; - why?  these are all new vehicles!
_initScript = getText (_cfgVeh >> "initScript");
if diff(_initScript,"") then {
	[_veh,_age] remoteExecCall [
		_initScript,
		2
	];
};
_veh addEventHandler ["GetIn", {
	_this call horde_fnc_getInVehicle
}];
_veh addEventHandler ["GetOut", {
	_this call horde_fnc_getOutVehicle
}];
_veh addEventHandler ["reloaded", {
	_this call horde_fnc_autoReloadVehWeap
}];
_veh call horde_fnc_addExtraVehicleMags;
if (ncb_param_lockEnemyVehicles) then {
	_veh setVehicleLock "LOCKED"
};
if (ncb_param_aiDisableVehicleVisionNV) then {
	_veh disableNVGEquipment true
};
if (ncb_param_aiDisableVehicleVisionTI) then {
	_veh disableTIEquipment true
};

[_veh,_grp]