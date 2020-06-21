#include "\nocebo\defines\scriptDefines.hpp"

/*vehicle = _this

checks whether engine is damaged and selects appropriate smoke effect to attach

0.25 none
0.25 - 0.5 Horde_EngineSmokeAmmo1
0.5 - 0.75 Horde_EngineSmokeAmmo2
0.75 - 1 Horde_EngineSmokeAmmo3

calling script needs to quit out if vehicle is totalled (smoke will be deleted anyway by vehicleKilled)*/

params ["_veh","_hitpoint"];

private _hit = _veh getHitPointDamage _hitpoint;
private _attachedAmmo = objNull;
private _ammoType = "";
private _ammoModPos = getArray (cfgVeh >> typeOf _veh >> "VehicleInteractionInfo" >> "Engine" >> "modelposition");
// make it go towards center of vehicle
private _maxDiff = 0;
private _biggestAxis = 0;
{
	if (abs _x > _maxDiff) then {
		_biggestAxis = _forEachIndex;
		_maxDiff = abs _x
	}
} forEach _ammoModPos;
// make it reduced by 0.3 (30cm)
private _valueAxis = _ammoModPos select _biggestAxis;
if (_valueAxis == 0) then {
	_valueAxis = 0.01
};
private _factor = if (_valueAxis > 0) then {0.3} else {-0.3};
_ammoModPos = _ammoModPos vectorMultiply ((_valueAxis - _factor) / _valueAxis);

private _found = false;
{
	if (_x isKindOf "Horde_EngineSmokeAmmo1") then {
		if (_found) then {
			detach _x;
			deleteVehicle _x
		} else {
			_attachedAmmo = _x;
			_ammoType = typeOf _attachedAmmo;
			_found = true;
		};
	};
} count attachedObjects _veh;
private _changedDamage = false;
call {
	if (_hit <= 0.25) exitWith {
		if (_ammoType != "") then {
			detach _attachedAmmo;
			deleteVehicle _attachedAmmo;
			_changedDamage = true
		};
	};
	if (_hit <= 0.5) exitWith {
		if (_ammoType != "Horde_EngineSmokeAmmo1") then {
			detach _attachedAmmo;
			deleteVehicle _attachedAmmo;
			private _smoke = spawnVeh("Horde_EngineSmokeAmmo1",createUnitPos);
			_smoke attachTo [_veh,_ammoModPos];
			_changedDamage = true
		};
	};
	if (_hit <= 0.75) then {
		if (_ammoType != "Horde_EngineSmokeAmmo2") then {
			detach _attachedAmmo;
			deleteVehicle _attachedAmmo;
			private _smoke = spawnVeh("Horde_EngineSmokeAmmo2",createUnitPos);
			_smoke attachTo [_veh,_ammoModPos];
			_changedDamage = true
		};
	} else {
		if (_ammoType != "Horde_EngineSmokeAmmo3") then {
			detach _attachedAmmo;
			deleteVehicle _attachedAmmo;
			private _smoke = spawnVeh("Horde_EngineSmokeAmmo3",createUnitPos);
			_smoke attachTo [_veh,_ammoModPos];
			_changedDamage = true
		};
	};
};

[_changedDamage,_ammoModPos]

/*call {
	if (_hit <= 0.25) exitWith {
		if (_ammoType != "") then {
			deleteVehicle _attachedAmmo
		};
	};
	if (_hit <= 0.5) exitWith {
		if (_ammoType != "Horde_EngineSmokeAmmo1") then {
			deleteVehicle _attachedAmmo
		};
		_smoke = spawnVeh("Horde_EngineSmokeAmmo1",createUnitPos);
		_smoke attachTo [_veh,_ammoModPos];
	};
	if (_hit <= 0.75) then {
		if (_ammoType != "Horde_EngineSmokeAmmo2") then {
			deleteVehicle _attachedAmmo
		};
		_smoke = spawnVeh("Horde_EngineSmokeAmmo2",createUnitPos);
		_smoke attachTo [_veh,_ammoModPos];
	} else {
		if (_ammoType != "Horde_EngineSmokeAmmo3") then {
			deleteVehicle _attachedAmmo
		};
		_smoke = spawnVeh("Horde_EngineSmokeAmmo3",createUnitPos);
		_smoke attachTo [_veh,_ammoModPos];
	};
};

_ammoModPos*/
