#include "\nocebo\defines\scriptDefines.hpp"

params ["_grp","_zoneTargets"];

private _groupData = getVar(_grp,"groupData"); // eg ["infantry",objNull,600,0,200,owner];
if (isNil "_groupData") exitWith {
	diag("ERROR IN NEARTARGETS");
	diag(_grp);
	diag(leader _grp);
	diag(typeOf leader _grp);
	diag(vehicle leader _grp);
	diag(typeOf vehicle leader _grp);
	[false,false]
};
_groupData params ["_groupType","_groupVehicle","_scanDist","_threatIndex"];
private _leader = leader _grp;
private _closestValidTgt = [];
private _unengageableTgts = false;

{
	private _targetData = _x;
	_targetData params ["_targetObject","_targetPos","_posError"];
	private _targetType = typeOf _targetObject;
	private _doNotChase = false;
	// can group engage?
	if (not isNull _targetObject
	    and {_posError <= 20}
	) then {
		private _threatArr = getArray (cfgVeh >> _targetType >> "threat");
		private _threat = sel(_threatArr,_threatIndex);
		if not (_targetType isKindOf "ParachuteBase") then {
			if (_targetType isKindOf "Air" or {_targetType isKindOf "Ship"}) then {
				_doNotChase = true;
			};
		};
		// check if this unit causes unit to hide
		private _canEngage = true;
		scopeName "indent_2";

		if (same(_threatIndex,0) and {_threat >= 0.5}) then {
			if not (_targetType isKindOf "CAManBase") then {
				private _lockType = if (_targetType isKindOf "Air") then {
					[1,2]
				} else {
					[0]
				};
				_canEngage = false;
				{
					private _unit = _x;
					private _veh = vehicle _unit;
					if diff(_veh,_unit) then {
						// assume all vehicle weapons can engage (exception might be 40mm GL's vs heli)
						if not empty(currentWeapon _veh) then {
							_canEngage = true;
							breakTo "indent_2";
						};
					};
					private _primaryLoadedMag = primaryWeaponMagazine _unit;
					if (not empty(_primaryLoadedMag) and {_unit ammo primaryWeapon _unit > 0}) then {
						// compare "hit" to minCalLevel
						if ((getNumber (cfgAmmo >> (getText (cfgMag >> sel(_primaryLoadedMag,0) >> "ammo")) >> "hit") / 6) max 1 >= (getNumber (cfgVeh >> _targetType >> "horde_primWeapMinCalLevel"))) then {
							_canEngage = true;
							breakTo "indent_2";
						} else {
							private _secLoadedMag = secondaryWeaponMagazine _unit;
							if not empty(_secLoadedMag) then {
								_secLoadedMag = _secLoadedMag select 0;
								if (getNumber (cfgAmmo >> (getText (cfgMag >> _secLoadedMag >> "ammo")) >> "airLock") in _lockType) then {
									_canEngage = true;
									breakTo "indent_2";
								};
							};
						};
					};
					true
				} count units _grp;
			};
		};

		if (_canEngage) then {
			if empty(_closestValidTgt) then {
				_closestValidTgt = [_targetData,_doNotChase];
			} else {
				if (_targetPos distance _leader < sel2(_closestValidTgt,0,1) distance _leader) then {
					_closestValidTgt = [_targetData,_doNotChase];
				};
			};
		} else {
			_unengageableTgts = true;
		};
	};
	true
} count _zoneTargets;
_anyTargets = false;
if (empty(_closestValidTgt)) then {
	setVar(_grp,"groupCurrentTargetData",nil);
} else {
	setVar(_grp,"groupCurrentTargetData",_closestValidTgt);
	_anyTargets = true;
};

[_anyTargets,_unengageableTgts]

// maybe redo this with findNearestEnemy OR assignedTarget!

/*

private _leader = leader _grp;
private _closestValidTgt = [];
private _unengageableTgts = false;
private _groupTargets = [];
{
	private _t = assignedTarget _x;
	if (not isNull _t) then {
		_groupTargets pushBackUnique _t
	};
	nil
} count units _grp;
{
	private _tgt = _x;
	if not (_tgt in _groupTargets) then {
		_unengageableTgts = true
	};
	{
		_x params ["_targetObject","_targetPos"];
		if (_tgt isEqualTo _targetObject) then {
			private _doNotChase = false;
			if not (_targetObject isKindOf "ParachuteBase") then {
				if (_targetObject isKindOf "Air" or {_targetObject isKindOf "Ship"}) then {
					_doNotChase = true;
				};
			};
			if ([] isEqualTo _closestValidTgt) then {
				_closestValidTgt = [_x,_doNotChase];
			} else {
				if (_targetPos distance _leader < sel2(_closestValidTgt,0,1) distance _leader) then {
					_closestValidTgt = [_x,_doNotChase];
				};
			}
		};
		nil
	} count _zoneTargets;
	nil
} count _groupTargets;
private _anyTargets = false;
if (empty(_closestValidTgt)) then {
	setVar(_grp,"groupCurrentTargetData",nil);
} else {
	setVar(_grp,"groupCurrentTargetData",_closestValidTgt);
	_anyTargets = true;
};

[_anyTargets,_unengageableTgts]*/