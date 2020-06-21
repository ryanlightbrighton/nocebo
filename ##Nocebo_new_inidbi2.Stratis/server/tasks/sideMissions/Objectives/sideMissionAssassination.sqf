#include "\nocebo\defines\scriptDefines.hpp"
scriptName "sideMissionAssassination";
private _notStarted = true;
private _grps = [];
private _hvtGrp = grpNull;
private _hvt = objNull;
private _position = [];
private _zone = objNull;
private _building = objNull;
private _buildingPosition = [];
private _cfgVeh = configFile >> "CfgVehicles";
private _zones = + ncb_gv_zoneList;
_zones = _zones - ncb_gv_missionAirBaseZones;
_zones = _zones select {
	not (_x getVariable ["zoneHasRadioInstallation",false])
	and {not (_x getVariable ["zoneHasArtilleryEmplacement",false])}
};
if not empty(_zones) then {
	scopeName "root";
	for "_i" from 0 to count _zones - 1 do {
		_zone = _zones deleteAt (floor random count _zones);
		if (not ([_zone,1000] call horde_fnc_playerIsNear)) then {
			private _cfgZone = configFile >> "CfgZones" >> worldName >> str _zone;
			private _landMassCount = getNumber (_cfgZone >> "landMassCount");
			private _milBuildings = _zone getVariable ["zoneMilBuildings",[]];
			if not ([] isEqualTo _milBuildings) then {
				_milBuildings = _milBuildings select {count getArray (_cfgVeh >> typeOf _x >> "unitData") > 5};
				_milBuildings = _milBuildings select {count (_x buildingPos -1) > 2};
				if not ([] isEqualTo _milBuildings) then {
					_building = _milBuildings deleteAt (floor random count _milBuildings);
					_buildingPosition = ASLToAGL getPosASL _building;
					// officer + retinue
					_buildingPositions = _building buildingPos -1;
					// if any building positions are covered, then use them in preference
					_coveredPositions = _buildingPositions select {lineIntersects [(AGLtoASL _x) vectorAdd [0,0,0.5],(AGLtoASL _x) vectorAdd [0,0,10]]};
					_hvtPos = if not ([] isEqualTo _coveredPositions) then {
						_coveredPositions = _coveredPositions apply {[_x select 2,_x]};
						_coveredPositions sort false;
						_coveredPositions select 0 select 1
					} else {
						_buildingPositions = _buildingPositions apply {[_x select 2,_x]};
						_buildingPositions sort false;
						_buildingPositions select 0 select 1
					};

					_hvtGrp = createGroup [east,false];
					_notStarted = false;

					// officer

					_hvt = ncb_gv_enemySniperPool deleteAt 0;
					[_hvt] joinSilent _hvtGrp;
					_hvt enableSimulationGlobal true;
					_hvt hideObjectGlobal false;
					_hvt doWatch (_building getPos [400,(_building getDir _hvt)]);
					_hvt setPosASL AGLToASL _hvtPos;
					[_hvt,true] call horde_fnc_allowDamageGlobal;
					_hvt disableAI "path";
					_hvt enableAI "checkVisible";
					removeAllWeapons _hvt;
					removeAllItems _hvt;
					removeAllAssignedItems _hvt;
					removeUniform _hvt;
					removeVest _hvt;
					removeBackpack _hvt;
					removeHeadgear _hvt;
					removeGoggles _hvt;

					_hvt forceAddUniform "U_O_OfficerUniform_ocamo";
					for "_k" from 1 to 2 do {_hvt addItemToUniform "SmokeShell";};
					for "_k" from 1 to 2 do {_hvt addItemToUniform "Chemlight_blue";};
					_hvt addItemToUniform "BreachingCharge_Remote_Mag";
					for "_k" from 1 to 2 do {_hvt addItemToUniform "30Rnd_762x39_Mag_F";};
					_hvt addVest "V_PlateCarrier2_rgr_noflag_F";
					_hvt addItemToVest selectRandom [
						"ghosthawkCASAccessCode",
						"ghosthawkCASAccessCode",
						"wipeoutCASAccessCode",
						"greyhawkCASAccessCode",
						"blackfishCASAccessCode"
					];
					_hvt addItemToVest "HandGrenade";
					_hvt addItemToVest "30Rnd_762x39_Mag_F";
					for "_k" from 1 to 6 do {_hvt addItemToVest "1Rnd_HE_Grenade_shell";};
					_hvt addHeadgear "H_Beret_blk";
					_hvt addGoggles "G_Aviator";

					_hvt addWeapon "arifle_AK12_GL_F";
					_hvt addPrimaryWeaponItem "acc_flashlight";
					_hvt addPrimaryWeaponItem "optic_DMS";

					_hvt linkItem "ItemMap";
					_hvt linkItem "ItemCompass";
					_hvt linkItem "ItemRadio";

					// retinue

					private _buildingPositions = getArray (_cfgVeh >> typeOf _building >> "unitData");

					private _count = (count _buildingPositions - 1) min 6;

					for "_k" from 0 to _count do {
						(_buildingPositions deleteAt (floor random count _buildingPositions)) params ["_spawnPos","_dir","_lookAroundData"];
						_spawnPos = _building modelToWorld _spawnPos;
						private _unit = ncb_gv_enemySniperPool deleteAt 0;
						[_unit] joinSilent _hvtGrp;
						_unit enableSimulationGlobal true;
						_unit hideObjectGlobal false;
						_unit doWatch (_building getPos [400,(_dir + getDir _building)]);
						_unit setPosASL AGLToASL _spawnPos;
						[_unit,true] call horde_fnc_allowDamageGlobal;
						_unit disableAI "path";
						_unit enableAI "checkVisible";
					};

					_buildings = (nearestTerrainObjects [_building,["BUILDING","HOUSE","BUNKER","FORTRESS","FUELSTATION","POWERSOLAR","POWERWAVE","POWERWIND"],100,false]) - [_building];
					_buildings = _buildings select {count getArray (_cfgVeh >> typeOf _x >> "unitData") > 1};
					// add a few other units in other buildings
					if not ([] isEqualTo _buildings) then {
						for "_k" from 0 to ((count _buildings - 1) min (randInteg(3,6))) do {
							_nearBuilding = _buildings deleteAt (floor random count _buildings);
							_buildingPositions = getArray (_cfgVeh >> typeOf _nearBuilding >> "unitData");
							(_buildingPositions deleteAt (floor random count _buildingPositions)) params ["_spawnPos","_dir","_lookAroundData"];
							_spawnPos = _nearBuilding modelToWorld _spawnPos;
							private _unit = ncb_gv_enemySniperPool deleteAt 0;
							[_unit] joinSilent _hvtGrp;
							_unit enableSimulationGlobal true;
							_unit hideObjectGlobal false;
							_unit doWatch (_nearBuilding getPos [400,(_dir + getDir _nearBuilding)]);
							_unit setPosASL AGLToASL _spawnPos;
							[_unit,true] call horde_fnc_allowDamageGlobal;
							_unit disableAI "path";
							_unit enableAI "checkVisible"
						}
					};

					_grps pushBack (netID _hvtGrp);
					_hvtGrp enableDynamicSimulation true;
					_hvtGrp setGroupIDGlobal [format ["sm_assassination_%1",_hvtGrp]];

					// defensive squads

					for "_i" from 0 to (floor random 1) + 1 do {
						/*private _spawnPos = _buildingPosition getPos [10,random 360];*/
						private _spawnPos = ASLtoAGL ([_buildingPosition,0,100,2,0,1,0] call horde_fnc_findSafePosASL);
								if ([] isEqualTo _spawnPos) then {
									_spawnPos = (_building buildingPos 1);
								};
						_grp = createGroup east;
						for "_j" from 1 to (floor random 4) + 3 do {
							private _unit = if (_landMassCount < 2) then {ncb_gv_enemyUnitPool deleteAt 0} else {ncb_gv_enemyDiverPool deleteAt 0};
							[_unit] joinSilent _grp;
							_unit enableSimulationGlobal true;
							_unit hideObjectGlobal false;
							_unit setPosASL AGLToASL _spawnPos;
							[_unit,true] call horde_fnc_allowDamageGlobal;
							_unit enableAI "checkVisible";
						};

						[_grp,_buildingPosition,30,150,true] call horde_fnc_taskPatrol;
						_grps pushBack (netID _grp);
						_grp enableDynamicSimulation true;
						_grp setGroupIDGlobal [format ["sm_assassination_%1",_grp]];
						sleep 1
					};
					breakTo "root"
				}
			}
		}
	};
	if not (isNull _hvtGrp) then {

		// task

		private _statement = format ["A high ranking officer is believed to be at Grid: %1.  Kill him and retrive any information he may have on him.  He is wearing a beret, aviators, and dressed in officer fatigues", mapGridPosition _buildingPosition];
		private _taskID = [
			"HVT" + (str _zone), // params
			true, // target
			[_statement,"Assassinate officer","smMarker"], // desc
			_buildingPosition, // dest
			"CREATED", // state
			0, // priority
			true, // showNotification
			true, // isGlobal
			"kill", // type
			false // shared
		] call BIS_fnc_setTask;
		hint parsetext "<t align='center'><t size='2.2'>New Side Mission</t><br/><t size='1.5' color='#00B2EE'>Assassination</t><br/>____________________<br/>A high-ranking officer is on the island with important information.  Kill him and acquire the info.</t>";

		// conds

		_hvt addEventHandler ["killed",
			format [
				"[_this select 0,%1] call {
					params ['_unit','_data'];
					_data params ['_buildingPosition','_grps','_id'];
					[_id,'succeeded'] call BIS_fnc_taskSetState;
					_unit removeAllEventHandlers 'killed';
					[
						[_buildingPosition,_grps,_id],{
							call horde_fnc_getEachFrameArgs params ['_buildingPosition','_grps','_id'];
							if not ([_buildingPosition,1000] call horde_fnc_playerIsNear) then {
								{
									(groupFromNetId _x) call horde_fnc_cacheGroup
								} count _grps;
								[
									[],
									{
										call horde_fnc_sideMissionManager;
										call horde_fnc_removeEachFrame
									},
									ncb_param_sideMissionInterval
								] call horde_fnc_updateEachFrame
							}
						},
						60
					] call horde_fnc_addEachFrame;
				}",
				[_buildingPosition,_grps,_taskID]
			]
		]
	}
};

if (_notStarted) then {
	[
		[],
		{
			call horde_fnc_sideMissionManager;
			call horde_fnc_removeEachFrame
		},
		ncb_param_sideMissionInterval
	] call horde_fnc_addEachFrame
};

true