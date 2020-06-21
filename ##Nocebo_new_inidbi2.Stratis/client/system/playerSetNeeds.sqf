#include "\nocebo\defines\scriptDefines.hpp"

if (not isNull player and {alive player} and {lifeState player != "incapacitated"}) then {
	private _baseRate = 0.015;
	private _incapacitated = false;
	if (isNil {getVar(missionNamespace,"playerPerformingAction")}) then {
		if (same(vehicle player,player)
				and {isTouchingGround player}
		) then {
			velocity player params ["_velX","_velY","_velZ"];
			private _product = abs (_velX * _velY);
			private _rate = _product * 0.02;
			private _climbRate = 1;
			if (_velZ > 0) then {
				_climbRate = _climbRate + (_velZ * 0.027);
			};
			private _drugRate = 1;
			if (not isNil {getVar(missionNamespace,"playerOnTruckerPills")}) then {
				_drugRate = 1.5;
			};
			_rate = _rate + _baseRate * _climbRate * _drugRate;
			ncb_gv_playerFood = (ncb_gv_playerFood - _rate) max 0;
			ncb_gv_playerWater = (ncb_gv_playerWater - (_rate * 2)) max 0;
		} else {
			ncb_gv_playerFood = (ncb_gv_playerFood - _baseRate) max 0;
			ncb_gv_playerWater = ((ncb_gv_playerWater - (_baseRate * 2)) max 0);
		};
	};
	call {
		private _damage = damage player;
		/*note: heal if enough food & water and damage is low enough.
		only heal down to number based on amount of lodged bullets*/
		if (ncb_gv_playerFood > 80 and {ncb_gv_playerWater > 80} and {_damage < 0.5}) exitWith {
			_damage = ((_damage - 0.0004) max (0 + (ncb_gv_playerLodgedBullets * 0.07)));
			player setDamage _damage;
		};
		// note: hurt if no food or water
		private _noFood = same(ncb_gv_playerFood,0);
		private _noWater = same(ncb_gv_playerWater,0);
		if (_noFood or {_noWater}) exitWith {
			private _addDamage = 0;
			if (_noFood) then {
				_addDamage = 0.0004
			};
			if (_noWater) then {
				_addDamage = _addDamage + 0.0004
			};
			_damage = (_damage + _addDamage) min 1;
			if (_damage < 0.99) then {
				player setDamage _damage
			} else {
				// trigger revive if applicable
				_incapacitated = true;
				player setDamage 0.95;
				private _veh = vehicle player;

				ncb_gv_playerBleedingRate = 0;
				if (surfaceIsWater getPosASL player
				    or {not (isTouchingGround _veh) and {getPosATL _veh select 2 > 2}}
				) exitWith {
					setVar(missionNamespace,"playerRespawnType","NO_REVIVE");
					_damage = 1;
				};
				if (not isNull objectParent player) then {
					player setPosWorld getPosWorld player;
				};
				player switchMove "";
				player setUnconscious true;
				openMap [false,false];
				closeDialog 0;
				clearRadio;
				enableRadio false;
				"dynamicBlur" ppEffectEnable false;
				player allowDamage false;
				player setCaptive true;
				[player,player] call  horde_fnc_handleRespawn;
				call horde_fnc_removeEachFrame
			};
		};
	};
	if not (_incapacitated) then {
		// workaround for damage to legs preventing running
		if (player getHitPointDamage "HitLegs" > 0.49) then {
			player setHitPointDamage ["HitLegs",0.49]
		};
		ncb_gv_distanceData params ["_onFootLast","_distOnFoot","_posLast","_proneLast","_distProne"];
		private _onFootNow = isNull objectParent player;
		private _posNow = getPosWorld vehicle player;
		if (_onFootLast and {_onFootNow} and {isTouchingGround player or {player call horde_fnc_isUnitSwimming}}) then {
			_distOnFoot = _distOnFoot + (_posNow distance _posLast);
		};
		private _proneNow = if (stance player == "prone") then {true} else {false};
		if (_proneLast and {_proneNow}) then {
			_distProne = _distProne + (_posNow distance _posLast)
		};
		ncb_gv_distanceData = [_onFootNow,_distOnFoot,_posNow,_proneNow,_distProne];

		// now update running skill + stealth (prone) skill
		if (_onFootNow) then {
			call {
				if (_distOnFoot > 40000) exitWith {
					if (player getUnitTrait "loadCoef" > 0.1) then {
						player setUnitTrait ["loadCoef",0.1];
						["Stamina",6] call horde_fnc_displayActionSkillMessage
					}
				};
				if (_distOnFoot > 15000) exitWith {
					if (player getUnitTrait "loadCoef" > 0.2) then {
						player setUnitTrait ["loadCoef",0.2];
						["Stamina",5] call horde_fnc_displayActionSkillMessage
					}
				};
				if (_distOnFoot > 5000) exitWith {
					if (player getUnitTrait "loadCoef" > 0.4) then {
						player setUnitTrait ["loadCoef",0.4];
						["Stamina",4] call horde_fnc_displayActionSkillMessage
					}
				};
				if (_distOnFoot > 2000) exitWith {
					if (player getUnitTrait "loadCoef" > 0.6) then {
						player setUnitTrait ["loadCoef",0.6];
						["Stamina",3] call horde_fnc_displayActionSkillMessage
					}
				};
				if (_distOnFoot > 1000) exitWith {
					if (player getUnitTrait "loadCoef" > 0.8) then {
						player setUnitTrait ["loadCoef",0.8];
						["Stamina",2] call horde_fnc_displayActionSkillMessage
					}
				}
			};
			if (_proneNow) then {
				private _coef = 0.5;
				call {
					_coef = 0.5;
					if (_distProne > 25200) exitWith {
						if (player getUnitTrait "audibleCoef" > _coef) then {
							player setUnitTrait ["audibleCoef",_coef];
							["Sneaking",11] call horde_fnc_displayActionSkillMessage
						}
					};
					_coef = 0.55;
					if (_distProne > 12800) exitWith {
						if (player getUnitTrait "audibleCoef" > _coef) then {
							player setUnitTrait ["audibleCoef",_coef];
							["Sneaking",10] call horde_fnc_displayActionSkillMessage
						}
					};
					_coef = 0.6;
					if (_distProne > 6400) exitWith {
						if (player getUnitTrait "audibleCoef" > _coef) then {
							player setUnitTrait ["audibleCoef",_coef];
							["Sneaking",9] call horde_fnc_displayActionSkillMessage
						}
					};
					_coef = 0.65;
					if (_distProne > 3200) exitWith {
						if (player getUnitTrait "audibleCoef" > _coef) then {
							player setUnitTrait ["audibleCoef",_coef];
							["Sneaking",8] call horde_fnc_displayActionSkillMessage
						}
					};
					_coef = 0.7;
					if (_distProne > 1600) exitWith {
						if (player getUnitTrait "audibleCoef" > _coef) then {
							player setUnitTrait ["audibleCoef",_coef];
							["Sneaking",7] call horde_fnc_displayActionSkillMessage
						}
					};
					_coef = 0.75;
					if (_distProne > 800) exitWith {
						if (player getUnitTrait "audibleCoef" > _coef) then {
							player setUnitTrait ["audibleCoef",_coef];
							["Sneaking",6] call horde_fnc_displayActionSkillMessage
						}
					};
					_coef = 0.8;
					if (_distProne > 400) exitWith {
						if (player getUnitTrait "audibleCoef" > _coef) then {
							player setUnitTrait ["audibleCoef",_coef];
							["Sneaking",5] call horde_fnc_displayActionSkillMessage
						}
					};
					_coef = 0.85;
					if (_distProne > 200) exitWith {
						if (player getUnitTrait "audibleCoef" > _coef) then {
							player setUnitTrait ["audibleCoef",_coef];
							["Sneaking",4] call horde_fnc_displayActionSkillMessage
						}
					};
					_coef = 0.9;
					if (_distProne > 100) exitWith {
						if (player getUnitTrait "audibleCoef" > _coef) then {
							player setUnitTrait ["audibleCoef",_coef];
							["Sneaking",3] call horde_fnc_displayActionSkillMessage
						}
					};
					_coef = 0.95;
					if (_distProne > 50) exitWith {
						if (player getUnitTrait "audibleCoef" > _coef) then {
							player setUnitTrait ["audibleCoef",_coef];
							["Sneaking",2] call horde_fnc_displayActionSkillMessage
						}
					}
				}
			};
			// check all the time for now - I can't think as I'm too tired.
			private _ghillied = uniform player in ncb_gv_ghillieSuits;
			call {
				private _coef = 0.5;
				private _factor = 0.5;
				if (_distProne > 25200) exitWith {
					if (_proneNow and {_ghillied}) then {
						if (player getUnitTrait "camouflageCoef" != _coef * _factor) then {
							player setUnitTrait ["camouflageCoef",_coef * _factor]
						}
					} else {
						if (player getUnitTrait "camouflageCoef" != _coef) then {
							player setUnitTrait ["camouflageCoef",_coef]
						}
					}
				};
				_coef = 0.55;
				if (_distProne > 12800) exitWith {
					if (_proneNow and {_ghillied}) then {
						if (player getUnitTrait "camouflageCoef" != _coef * _factor) then {
							player setUnitTrait ["camouflageCoef",_coef * _factor]
						}
					} else {
						if (player getUnitTrait "camouflageCoef" != _coef) then {
							player setUnitTrait ["camouflageCoef",_coef]
						}
					}
				};
				_coef = 0.6;
				if (_distProne > 6400) exitWith {
					if (_proneNow and {_ghillied}) then {
						if (player getUnitTrait "camouflageCoef" != _coef * _factor) then {
							player setUnitTrait ["camouflageCoef",_coef * _factor]
						}
					} else {
						if (player getUnitTrait "camouflageCoef" != _coef) then {
							player setUnitTrait ["camouflageCoef",_coef]
						}
					}
				};
				_coef = 0.65;
				if (_distProne > 3200) exitWith {
					if (_proneNow and {_ghillied}) then {
						if (player getUnitTrait "camouflageCoef" != _coef * _factor) then {
							player setUnitTrait ["camouflageCoef",_coef * _factor]
						}
					} else {
						if (player getUnitTrait "camouflageCoef" != _coef) then {
							player setUnitTrait ["camouflageCoef",_coef]
						}
					}
				};
				_coef = 0.7;
				if (_distProne > 1600) exitWith {
					if (_proneNow and {_ghillied}) then {
						if (player getUnitTrait "camouflageCoef" != _coef * _factor) then {
							player setUnitTrait ["camouflageCoef",_coef * _factor]
						}
					} else {
						if (player getUnitTrait "camouflageCoef" != _coef) then {
							player setUnitTrait ["camouflageCoef",_coef]
						}
					}
				};
				_coef = 0.75;
				if (_distProne > 800) exitWith {
					if (_proneNow and {_ghillied}) then {
						if (player getUnitTrait "camouflageCoef" != _coef * _factor) then {
							player setUnitTrait ["camouflageCoef",_coef * _factor]
						}
					} else {
						if (player getUnitTrait "camouflageCoef" != _coef) then {
							player setUnitTrait ["camouflageCoef",_coef]
						}
					}
				};
				_coef = 0.8;
				if (_distProne > 400) exitWith {
					if (_proneNow and {_ghillied}) then {
						if (player getUnitTrait "camouflageCoef" != _coef * _factor) then {
							player setUnitTrait ["camouflageCoef",_coef * _factor]
						}
					} else {
						if (player getUnitTrait "camouflageCoef" != _coef) then {
							player setUnitTrait ["camouflageCoef",_coef]
						}
					}
				};
				_coef = 0.85;
				if (_distProne > 200) exitWith {
					if (_proneNow and {_ghillied}) then {
						if (player getUnitTrait "camouflageCoef" != _coef * _factor) then {
							player setUnitTrait ["camouflageCoef",_coef * _factor]
						}
					} else {
						if (player getUnitTrait "camouflageCoef" != _coef) then {
							player setUnitTrait ["camouflageCoef",_coef]
						}
					}
				};
				_coef = 0.9;
				if (_distProne > 100) exitWith {
					if (_proneNow and {_ghillied}) then {
						if (player getUnitTrait "camouflageCoef" != _coef * _factor) then {
							player setUnitTrait ["camouflageCoef",_coef * _factor]
						}
					} else {
						if (player getUnitTrait "camouflageCoef" != _coef) then {
							player setUnitTrait ["camouflageCoef",_coef]
						}
					}
				};
				_coef = 0.95;
				if (_distProne > 50) exitWith {
					if (_proneNow and {_ghillied}) then {
						if (player getUnitTrait "camouflageCoef" != _coef * _factor) then {
							player setUnitTrait ["camouflageCoef",_coef * _factor]
						}
					} else {
						if (player getUnitTrait "camouflageCoef" != _coef) then {
							player setUnitTrait ["camouflageCoef",_coef]
						}
					}
				};
			}
		}
	};
} else {
    call horde_fnc_removeEachFrame
};

true



