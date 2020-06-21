#include "\nocebo\defines\scriptDefines.hpp"


if (not isNull player and {alive player} and {lifeState player != 'incapacitated'}) then {
    private _display = getVar(uiNamespace,"ncb_ui_playerMonitor");
	if not (isNil "_display") then {

		//**************************HEALTH*****************************

		private _progress = 1 - (damage player);
		private _ctrl = _display displayCtrl 5;
		_ctrl progressSetPosition _progress;
		call {
			if (_progress > 0.5) then {
				_ctrl ctrlSetTextColor [
					linearConversion [0.5,1,_progress,1,0,true],
					1,
					0,
					1
				];
			} else {
				_ctrl ctrlSetTextColor [
					1,
					linearConversion [0,0.5,_progress,0,1,true],
					0,
					1
				];
			};
		};

		//**************************LODGED BULLETS*****************************

		for "_slot" from 0 to 13 do {
			private _idc = 9 + _slot;
			if (ncb_gv_playerLodgedBullets + 9 > _idc) then {
				if (isNull (_display displayCtrl _idc)) then {
					// create (work out where from r to l and display)
					private _ctrl = _display ctrlCreate ["horde_RscPicture",_idc];
					private _path = configfile >> "RscTitles" >> "playerMonitor" >> "Controls" >> "HealthProgress";
					private _width = getNumber (_path >> "w");
					private _xCoord = getNumber (_path >> "x");
					_xCoord = _xCoord + (_width - ((_width / 14) * (_slot + 1)));
					_ctrl ctrlSetPosition [
						_xCoord,
						getNumber (_path >> "y"),
						_width / 14,
						getNumber (_path >> "h")
					];
					_ctrl ctrlSetText "\nocebo\images\lodged_bullet.paa";
					_ctrl ctrlCommit 0;
				};
			} else {
				// delete others
				if  not (isNull (_display displayCtrl _idc)) then {
					ctrlDelete (_display displayCtrl _idc)
				};
			};
		};
		if not (ncb_gv_playerLodgedBullets isEqualTo 0) then {
			// flash up warning.
			if ((floor round time % 2) isEqualTo 0) then {
				if (isNull (_display displayCtrl 26)) then {
					private _ctrl = _display ctrlCreate ["horde_RscText",26];
					private _path = configfile >> "RscTitles" >> "playerMonitor" >> "Controls" >> "HealthProgress";
					_ctrl ctrlSetPosition [
						getNumber (_path >> "x"),
						getNumber (_path >> "y"),
						getNumber (_path >> "w"),
						getNumber (_path >> "h")
					];
					_ctrl ctrlSetBackgroundColor [1,0,0,0.5];
					if (((floor round time) + 1) % 4 < 3) then {
						_ctrl ctrlSetText "LODGED";
					} else {
						if (ncb_gv_playerLodgedBullets == 1) then {
							_ctrl ctrlSetText "BULLET";
						} else {
							_ctrl ctrlSetText "BULLETS";
						};
					};
					_ctrl ctrlCommit 0;
				};
			} else {
				if not (isNull (_display displayCtrl 26)) then {
					ctrlDelete (_display displayCtrl 26);
				};
			};
		} else {
			if not (isNull (_display displayCtrl 26)) then {
				ctrlDelete (_display displayCtrl 26);
			};
		};

		//**************************BLEEDING*****************************

		(_display displayCtrl 6) progressSetPosition (20 * ncb_gv_playerBleedingRate);
		if not (ncb_gv_playerBleedingRate isEqualTo 0) then {
			// flash up warning.
			if ((floor round time % 2) isEqualTo 0) then {
				if (isNull (_display displayCtrl 23)) then {
					private _ctrl = _display ctrlCreate ["horde_RscText",23];
					private _path = configfile >> "RscTitles" >> "playerMonitor" >> "Controls" >> "BleedingProgress";
					_ctrl ctrlSetPosition [
						getNumber (_path >> "x"),
						getNumber (_path >> "y"),
						getNumber (_path >> "w"),
						getNumber (_path >> "h")
					];
					_ctrl ctrlSetText "BLEEDING";
					_ctrl ctrlCommit 0;
				};
			} else {
				if not (isNull (_display displayCtrl 23)) then {
					ctrlDelete (_display displayCtrl 23);
				};
			};
		} else {
			if not (isNull (_display displayCtrl 23)) then {
				ctrlDelete (_display displayCtrl 23);
			};
		};

		//**************************FOOD*****************************

		private _ctrl = _display displayCtrl 7;
		private _progress = ncb_gv_playerFood / 100;
		_ctrl progressSetPosition _progress;
		call {
			if (_progress > 0.5) then {
				_ctrl ctrlSetTextColor [
					linearConversion [0.5,1,_progress,1,0,true],
					1,
					0,
					1
				];
			} else {
				_ctrl ctrlSetTextColor [
					1,
					linearConversion [0,0.5,_progress,0,1,true],
					0,
					1
				];
			};
		};
		if (_progress isEqualTo 0) then {
			// flash up warning.
			if ((floor round time % 2) isEqualTo 0) then {
				if (isNull (_display displayCtrl 24)) then {
					private _ctrl = _display ctrlCreate ["horde_RscText",24];
					private _path = configfile >> "RscTitles" >> "playerMonitor" >> "Controls" >> "FoodProgress";
					_ctrl ctrlSetPosition [
						getNumber (_path >> "x"),
						getNumber (_path >> "y"),
						getNumber (_path >> "w"),
						getNumber (_path >> "h")
					];
					_ctrl ctrlSetText "NO FOOD";
					_ctrl ctrlCommit 0;
				};
			} else {
				if not (isNull (_display displayCtrl 24)) then {
					ctrlDelete (_display displayCtrl 24);
				};
			};
		} else {
			if not (isNull (_display displayCtrl 24)) then {
				ctrlDelete (_display displayCtrl 24);
			};
		};

		//**************************WATER*****************************

		private _ctrl = _display displayCtrl 8;
		private _progress = ncb_gv_playerWater / 100;
		_ctrl progressSetPosition _progress;
		call {
			if (_progress > 0.5) then {
				_ctrl ctrlSetTextColor [
					linearConversion [0.5,1,_progress,1,0,true],
					1,
					0,
					1
				];
			} else {
				_ctrl ctrlSetTextColor [
					1,
					linearConversion [0,0.5,_progress,0,1,true],
					0,
					1
				];
			};
		};
		if (_progress isEqualTo 0) then {
			// flash up warning.
			if ((floor round time % 2) isEqualTo 0) then {
				if (isNull (_display displayCtrl 25)) then {
					private _ctrl = _display ctrlCreate ["horde_RscText",25];
					private _path = configfile >> "RscTitles" >> "playerMonitor" >> "Controls" >> "WaterProgress";
					_ctrl ctrlSetPosition [
						getNumber (_path >> "x"),
						getNumber (_path >> "y"),
						getNumber (_path >> "w"),
						getNumber (_path >> "h")
					];
					_ctrl ctrlSetText "NO WATER";
					_ctrl ctrlCommit 0;
				};
			} else {
				if not (isNull (_display displayCtrl 25)) then {
					ctrlDelete (_display displayCtrl 25);
				};
			};
		} else {
			if not (isNull (_display displayCtrl 25)) then {
				ctrlDelete (_display displayCtrl 25);
			};
		};
	};
	// debug
	if (ncb_param_debugMode == 1) then {
		private _groundUnits = [];
		private _airUnits = [];
		{
			if (not isPlayer _x and {simulationEnabled _x}) then {
				call {
					if ((vehicle _x) isKindOf "Helicopter_Base_F") exitWith {
						_airUnits pushBack _x
					};
					_groundUnits pushBack _x;
				};
			};
			true
		} count allUnits;
		private _nearestZones = player nearEntities ["Zone_Logic",1000];
		private _zone = "none near";
		private _lastTime = "---";
		private _zoneGroups = "---";
		private _zoneVehs = "---";
		private _zoneUAVs = "---";
		private _zoneValue = "---";
		private _zoneTickets = "---";
		if not (_nearestZones isEqualTo []) then {
			_zone = _nearestZones select 0;
			_lastTime = getVarDef(_zone,"zoneTimeLastSpawned",-1);
			_zoneGroups = +getVarDef(_zone,"zoneCurrentGroups",[]);
			{
				if (not isNull _x) then {
					_zoneGroups set [_forEachIndex,str _x]
				} else {
					_zoneGroups set [_forEachIndex,"NULL GRP"]
				};
			} forEach _zoneGroups;
			_zoneVehs = getVarDef(_zone,"zoneCurrentVehicles",[]);
			_zoneUAVs = getVarDef(_zone,"zoneCurrentUAVs",[]);
			_zoneValue = getVarDef(_zone,"zoneMaxSquadCount",-1);
			_zoneTickets = getVarDef(_zone,"zoneReinforceTickets",-1);
		};
		private _oef = [];
		{
			_oef pushBack (_x select 0)
		} forEach (missionNamespace getVariable ["BIS_stackedEventHandlers_onEachFrame",[]]);
		hintSilent parseText format [
			"
				<t size='0.7'color='#FFFFFF'align='center'shadow='2'>-- ENEMY --<br />
				Enemy groups: %1<br />
				Enemy units: %2<br />
				Dead units: %3<br />
				Uncached grd units and uavs %4<br />
				Uncached heli units: %5<br />
				Empty groups: %6<br />
				<br />
				-- NEAR ZONE --<br />
				Nearest zone: %7<br />
				Time spawned/reinf: %8<br />
				Value: %9<br />
				Tickets: %10<br />
				Groups: %11<br />
				Grp count: %12<br />
				Veh count: %13<br />
				UAV count: %14<br />
				<br />
				-- ACTIVE SCRIPTS --<br />
				Spawned scripts: %15<br />
				Active FSM's: %16<br />
				Active OEF: %17<br />
				<br />
				</t>
			",
			{not isPlayer leader _x} count allGroups,
			{not isPlayer _x} count allUnits,
			count allDead,
			count _groundUnits,
			count _airUnits,
			{({if (alive _x) exitWith {1}} count units _x) isEqualTo 0} count allGroups,
			_zone,
			_lastTime,
			_zoneValue,
			_zoneTickets,
			_zoneGroups,
			count _zoneGroups,
			count _zoneVehs,
			count _zoneUAVs,
			count diag_activeSQFScripts,
			count diag_activeMissionFSMs,
			_oef
		];
	};
} else {
	hintSilent "";
	ncb_layer_playerMonitor cutText ["","PLAIN"];
    call horde_fnc_removeEachFrame
};




true

