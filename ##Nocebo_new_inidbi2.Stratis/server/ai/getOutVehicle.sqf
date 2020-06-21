#include "\nocebo\defines\scriptDefines.hpp"

params ["_veh","","_unit"];

// fired on server

if (isPlayer _unit) then {
    if (ncb_param_enableChannelVehicleChat or {ncb_param_enableChannelVehicleRadio}) then {
    	[4,false] remoteExecCall [
    		"enableChannel",
    		_unit
    	]
    }
};

if (alive _veh and {{if (alive _x) exitWith {1}} count crew _veh isEqualTo 0}) then {
	_veh setVariable ["vehicleAbandonedTime",round time];
	ncb_gv_abandonedVehicles pushBackUnique _veh;
	_veh enableDynamicSimulation true;
};

if (alive _unit) then {
	if (isPlayer _unit) then {
		[_veh,_unit] remoteExecCall [
			"horde_fnc_antiGetOutCheat",
			_unit
		];
	} else {
		if (not (_veh isKindOf "Air")
			and {isNil {getVar(_veh,"vehicleAllCombatantsOrderedOut")}}
		) then {
			setVar(_veh,"vehicleAllCombatantsOrderedOut",true);
			scopeName "2";
			private _weap = "SmokeLauncher";
			private _commander = commander _veh;

			if (not isNull _commander ) then {
				private _role = assignedVehicleRole _commander;
				if not empty(_role) then {
					private _weapons = _veh weaponsTurret sel(_role,1);
					_idx = _weapons find _weap;
					if (_idx > -1) then {
						_veh action ["UseWeapon",_veh,_commander,_idx];
						/*_commander forceWeaponFire [_weap,_weap];*/
					};
				};
			};
			private _driver = driver _veh;
			if (not isNull _driver) then {
				private _weapons = _veh weaponsTurret [-1];
				if (_weap in _weapons) then {
					_driver forceWeaponFire [_weap,_weap];
					breakTo "2";
				};
			};
			private _grp = group _unit;
			private _grpType = getVar(_grp,"groupData");
			if not (isNil "_grpType") then {
				private _type = sel(_grpType,0);
				call{
					if (_type in ["car","truck"]) exitWith {
						units _grp allowGetIn false;
						{_x action ["getout",_veh]} count units _grp
					};
					if (_type in ["apc","technical"]) exitWith {
						private _passengers = [_unit];
						{
							if (same(sel(_x,1),"cargo")
								or {
									same(sel(_x,1),"turret")
									and {
										sel(_x,4)
									}
								}
							) then {
								_passengers pushBack sel(_x,0);
							};
							true
						} count fullCrew _veh;
						_passengers allowGetIn false;
						{_x action ["getout",_veh]} count _passengers
					};
				};
			};
		};
	};
};

if (vectorMagnitude velocity _veh < 0.1) then {
	[_veh,[0,0,0.5]] call horde_fnc_setVelocityGlobal;
};
true