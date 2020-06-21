#include "\nocebo\defines\scriptDefines.hpp"

// owner of unit runs this (sends request to server to do deadbody/unitpool stuff)
params ["_unit","_killer","_instigator","_vehKiller","_vehUnit","_grp"];

/*if (isNull _instigator) then {
	_instigator = UAVControl vehicle _killer select 0
}; // UAV/UGV player operated road kill
if (isNull _instigator) then {
	_instigator = _killer
}; // player driven vehicle road kill*/
_vehKiller = vehicle _killer;
_vehUnit = vehicle _unit;

if (dynamicSimulationEnabled _unit) then {
	_unit enableDynamicSimulation false
};

if (_vehUnit != _unit) then {
	if (_vehUnit isKindOf "StaticWeapon") then {
		detach _vehUnit;
		_unit setPosWorld getPosWorld _unit;
		[_unit,getText (configFile >> "CfgVehicles" >> (typeOf _vehUnit) >> "Turrets" >> "MainTurret" >> "gunnerAction")] remoteExecCall [
			"horde_fnc_switchMoveGlobal",
			0
		];
	} else {
		_unit setPosWorld getPosWorld _unit;
		// this triggers the getout EH
	};
};

if (_vehKiller != _killer
	and {_unit distance _vehKiller < 10}
	and {vectorMagnitude velocity _vehKiller > 7}
) then {
	{
		deleteVehicle _x;
	} count (nearestObjects [_unit,["WeaponHolder"],3]);
	removeAllContainers _unit;
	removeAllWeapons _unit;
	removeHeadgear _unit;
	removeGoggles _unit;
	{
		_unit unlinkItem _x;
	} count assignedItems _unit;
};

_grp = group _unit;
[_unit] joinSilent (group deadUnits);

if (not isNull _grp and {({if (alive _x) exitWith {1}} count units _grp) isEqualTo 0}) then {
	_grp call horde_fnc_deleteGroupGlobal;
};

// add unit back into unitpool on server

_unit remoteExecCall [
	"horde_fnc_addNewUnitToPool",
	2
];

true