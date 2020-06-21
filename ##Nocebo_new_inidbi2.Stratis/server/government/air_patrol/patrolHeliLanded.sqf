#include "\nocebo\defines\scriptDefines.hpp"

params ["_veh","_on"];

if (alive _veh) then {
	if (({if (isPlayer _x) exitWith {1}} count crew _veh) isEqualTo 0) then {
		private _pos = getPos _veh;
		if (not _on
			and {_pos select 2 < 5}
			and {not (surfaceIsWater _pos)}
		) then {
			_veh setVariable ["vehicleRefitting",true];
			[_veh,0] call horde_fnc_setFuelGlobal;
			_veh spawn {
				scriptName "patrolHeliLanded";
				sleep 60;
				// do checks again - may have been blown up
				private _pilot = driver _this;
				if (not isNull _this
					and {alive _this}
					and {not isNull _pilot}
					and {alive _pilot}
				) then {
					private _grp = group _pilot;
					[_this,1] call horde_fnc_setFuelGlobal;
					_this setDamage 0;
					{
						private _oldUnit = _this turretUnit _x;
						if ((isNull _oldUnit or {not (alive _oldUnit)})
							and {not (ncb_gv_enemyUnitPool isEqualTo [])}
						) then {
							private _unit = ncb_gv_enemyUnitPool deleteAt 0;
							[_unit] joinSilent _grp;
							_unit enableSimulationGlobal true;
							_unit hideObjectGlobal false;
							if not (isNull _oldUnit) then {
								_oldUnit setPosWorld getPosWorld _this;
								waitUntil {
									sleep 0.1;
									vehicle _oldUnit == _oldUnit
								};
							};
							_unit moveInTurret [_this,_x];
							[_unit,true] call horde_fnc_allowDamageGlobal;
							_unit enableAI "checkVisible";
							sleep 1;
						};
					} forEach allTurrets [_this,true];
					_this setVariable ["vehicleIsGoingToAirBase",false];
					_this setVariable ["vehicleRefitting",false];
					// reset patrol
					if not (isNull _pilot) then {
						(group _pilot) setVariable ["groupZonePatrolTimeout",0];
					};
				};
			};
		};
	} else {
		_veh removeAllEventHandlers "engine"
	};
};
