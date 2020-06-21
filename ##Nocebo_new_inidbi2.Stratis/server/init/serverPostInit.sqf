#include "\nocebo\defines\scriptDefines.hpp"

if not (isServer) exitWith {};

if not (isNil "ncb_gv_ranPostInit") exitWith {
	diag_log "/**************************************/";
	diag("trying to read server post-init twice");
	diag_log "/**************************************/";
};

if (isFilePatchingEnabled or {not (isClass (configFile >> "CfgPatches" >> "inidbi2"))}) exitWith {};

ncb_gv_ranPostInit = true;

// get blacklisted spawn locations
_blackListed = [];
{
	if (toLower _x find "blacklist" > -1) then {
		_blackListed pushBack _x
	};
} forEach allMapMarkers;

{
	_x params ["_pos","_dir"];
	if ({_pos inArea _x} count _blackListed > 0) then {
		ncb_pv_playerSpawnPlaces set [_forEachIndex,objNull]
	};
} forEach ncb_pv_playerSpawnPlaces;
ncb_pv_playerSpawnPlaces = ncb_pv_playerSpawnPlaces - [objNull];
publicVariable "ncb_pv_playerSpawnPlaces";
diag(count ncb_pv_playerSpawnPlaces);
publicVariable "ncb_gv_crateRiflesTier_0";
publicVariable "ncb_gv_crateRiflesTier_1";
publicVariable "ncb_gv_cratePistolsTier_0";

_fnc_roundArray = {
	{
		_this set [_forEachIndex,round (_this select _forEachIndex)];
	} forEach _this;
	_this
};

ncb_gv_allLocationTypes = [];
"ncb_gv_allLocationTypes pushBack configName _x;true" configClasses (
	configFile >> "CfgLocationTypes"
);

// setup on player connect (for later use in ranks etc)

// http://forums.bistudio.com/showthread.php?187692-onPlayerConnected-deriving-player-object&p=2859455&viewfull=1#post2859455


// SETUP TASKS

/*
	what I'd like to do is have each base as a mini-task

	and have 3 tasks on top of that

	all radio-bases destroyed
	all air-bases destroyed
	all artillery-bases destroyed

	and also the main task (storm the government building)

	MUST REMEMBER THAT MISSION EDITOR CAN SWITCH OFF THESE TASKS SO EITHER DON'T SET
	THEM OR MARK AS COMPLETE IF SWITCHED OFF IN PARAMS
*/

_totalBaseZones = []; // temp var to make sure bases aren't too close together

// AIR BASES

// set up helipad zones
ncb_gv_missionAirBaseZones = [];
ncb_gv_AirBasePositions = [];
if (ncb_gv_savedGame) then {
	_entry = "airbases";
	_zones = ["read",[_entry,"zones",[]]] call ncb_gv_iniDbiAirBases;
	if not ([] isEqualTo _zones) then {
		{
			_x params ["_zoneName","_taskID","_locName","_posASL","_objectData","_vehicleData"];
			_zone = missionNamespace getVariable _zoneName;
			_objects = [];
			_vehicles = [];

			{
				// spawn
				_x params ["_class","_posWorld","_dir"];
				_obj = spawnVeh(_class,_posWorld);
				_obj setDir _dir;
				_obj setPosWorld _posWorld;
				_obj allowDamage false;
				_obj setVectorUp surfaceNormal _posWorld;
				_objects pushBack _obj;
				_obj enableDynamicSimulation true;
			} forEach _objectData;
			{

				_x params ["_class","_posWorld","_dir","_damage"];
				if (_damage < 1) then {
					_veh = spawnVeh(_class,_posWorld);
					_veh setDir _dir;
					_veh setPosWorld _posWorld;
					_veh allowDamage false;
					_veh setDamage _damage;
					_veh lock true; // maybe change this
					_veh addEventHandler ["killed",
						format [
							"[
								_this,
								%1,
								'%2'
							] call horde_fnc_checkAirBaseTaskComplete",
							_zone,
							_locName
						]
					];
					_veh enableDynamicSimulation true;
					_vehicles pushBack _veh
				};
			} forEach _vehicleData;

			_totalBaseZones pushBack _zone;

			ncb_gv_AirBasePositions pushBack [_zone,_taskID,_locName,_posASL,_objects,_vehicles];
			[_zone,_taskID,_locName,_posASL,_vehicles] call horde_fnc_setupAirbases;
		} forEach _zones;
	};
	// delete section
	["deleteSection",_entry] call ncb_gv_iniDbiAirBases;
} else {
	if (ncb_param_govHelipads > 0) then {
		for "_i" from 1 to ncb_param_govHelipads do {
			if not empty(ncb_gv_zoneMapHelipads) then {
				private _foundAirport = false;
				for "_i" from 0 to count ncb_gv_zoneMapHelipads - 1 do {
					if (_foundAirport) exitWith {};
					_zone = ncb_gv_zoneMapHelipads deleteAt (floor random count ncb_gv_zoneMapHelipads);
					// Make sure not too close together
					if (({if (_x distance _zone < 3000) exitWith {1}} count _totalBaseZones) isEqualTo 0) then {
						_totalBaseZones pushBack _zone;
						_posASL = getPosASL (getVar(_zone,"zoneMapHelipads") select 0);
						_taskID = "AB" + (str _zone);
						_locs = [];
						{
							if not (text _x isEqualTo "") then {
								_locs pushBack [_x,position _x]
							};
						} forEach nearestLocations [ASLtoAGL _posASL,ncb_gv_allLocationTypes,1000];


						_locName = "in the Wilderness";
						_bestDist = 9999;
						{
							/*_x params ["_type","_name","_pos"];*/
							_x params ["_name","_pos"];
							_testDist = _pos distance2D _posASL;
							if (_testDist < _bestDist) then {
								_bestDist = _testDist;
								_locName = text _name;
							};
						/*} forEach (getArray (configFile >> "CfgZones" >> worldName >>  str _zone >> "ClosestLocations" >> "locations"));*/
						} forEach _locs;

						if (_locName find "'" > -1) then {
							_locName = _locName splitString "'" joinstring " ";
						};

						// set up repair/refuel/rearm objects

						// spawn temp heli (so net isn't too close)
						_tmpSpn = ASLtoAGL _posASL;
						_tempHeli = spawnVeh("I_Heli_Transport_02_F",_tmpSpn);

						_objects = [];
						_vehicles = [];
						_centerPosASL = _posASL vectorAdd [0,0,0.1];
						for "_i" from 1 to 2 do {
							_angleCheck = 10;
							_foundSpace = false;
							_dist = 20;
							while {not _foundSpace and {_dist < 60}} do {
								_candPosASL = [
									sel(_centerPosASL,0) + _dist * sin _angleCheck,
									sel(_centerPosASL,1) + _dist * cos _angleCheck,
									sel(_centerPosASL,2)
								];
								_angleCheck = _angleCheck + 10;
								if (_angleCheck == 370) then {
									_angleCheck = 10;
									_dist = _dist + 10;
								};
								_candPosASL = [_candPosASL,0,20,12,0,1.2,0] call horde_fnc_findSafePosASL;
								if (not empty(_candPosASL)
									and {(_candPosASL nearRoads 10) isEqualTo []}
								) then {
									if not(lineIntersects[_centerPosASL,_candPosASL]) then {
										// spawn object
										_candPos = ASLtoATL _candPosASL;
										_candPos set [2,0];
										_obj = spawnVeh("CamoNet_OPFOR_big_F",_candPos);
										_obj allowDamage false;
										_objects pushBack _obj;
										_angleCheck = (_angleCheck + 50) % 360;
										_dir = _candPos getDir _centerPosASL;
										_obj setDir ((_dir + 180) % 360);
										_obj setVectorUp surfaceNormal _candPos;
										_obj enableDynamicSimulation true;
										_foundSpace = true;
									};
								};
							};
						};

						deleteVehicle _tempHeli;

						call {
							if (count _objects == 0) exitWith {
								diag(_zone);
								diag("no positions for air base vehicles");
							};
							_foundAirport = true;
							_classes = ["O_Truck_02_Ammo_F","O_Truck_02_fuel_F"];
							if (count _objects == 1) exitWith {
								// 2 vehicles
								for "_i" from 0 to 1 do {
									_obj = sel(_objects,0);
									_class = sel(_classes,_i);
									_objPos = getPosATL _obj;
									_objDir = getDir _obj;
									// opposite to trucks
									_dir = -90;
									if (_i == 1) then {
										_dir = 90;
									};
									_pos = _objPos getPos [3.5,_dir];
									_veh = spawnVeh(_class,_pos);
									_veh allowDamage false;
									_vehicles pushBack _veh;
									_veh setDir ((_objDir + 180) % 360);
									_veh lock true; // maybe change this
									_veh addEventHandler ["killed",
										format [
											"[
												_this,
												%1,
												'%2'
											] call horde_fnc_checkAirBaseTaskComplete",
											_zone,
											_locName
										]
									];
									_veh enableDynamicSimulation true;
								};
							};
							if (count _objects == 2) exitWith {
								for "_i" from 0 to 1 do {
									_obj = sel(_objects,_i);
									_class = sel(_classes,_i);
									_objPos = getPosATL _obj;
									_objDir = getDir _obj;
									// opposite to trucks
									_dir = -90;
									if (_i == 1) then {
										_dir = 90;
									};
									_veh = spawnVeh(_class,_objPos);
									_veh allowDamage false;
									_vehicles pushBack _veh;
									_veh setDir ((_objDir + 180) % 360);
									_veh lock true; // maybe change this
									_veh addEventHandler ["killed",
										format [
											"[
												_this,
												%1,
												'%2'
											] call horde_fnc_checkAirBaseTaskComplete",
											_zone,
											_locName
										]
									];
									_veh enableDynamicSimulation true;
								};
							};
						};
						if (_foundAirport) then {
							ncb_gv_AirBasePositions pushBack [_zone,_taskID,_locName,_posASL,_objects,_vehicles];

							[_zone,_taskID,_locName,_posASL,_vehicles] call horde_fnc_setupAirbases;
						};
					};
				};
			};
		};
	};
};

diag(ncb_gv_AirBasePositions);

// RADIO TRANSMITTERS


_fnc_checkAboveASL = {
	private _open = true;
	for "_direction" from 0 to 270 step 90 do {
		private _testPosASL = [
			sel(_this,0) + 10 * sin _direction,
			sel(_this,1) + 10 * cos _direction,
			sel(_this,2) + 10 * tan 65
		];
		if (lineIntersects [_this vectorAdd [0,0,0.2],_testPosASL]) exitWith {
			_open = false;
		};
	};
	_open
};

ncb_gv_missionRadioTransZones = [];
ncb_gv_RadioTransPositions = [];
if (ncb_gv_savedGame) then {
	// CODE HERE PLEASE!
	_entry = "radiotransmitters";
	_zones = ["read",[_entry,"zones",[]]] call ncb_gv_iniDbiRadioTransmitters;
	if not ([] isEqualTo _zones) then {
		{
			//[str _zone,_taskID,_aliveTaskBuildings]
			_x params ["_zoneName","_taskID","_aliveTaskBuildingData","_siteData"];
			_zone = missionNamespace getVariable _zoneName;
			_siteData params ["_emplacementPos","_emplacementDir","_radioStationBuildingClasses"];
			if ({_x select 1 < 1} count _aliveTaskBuildingData > 0) then {
				([
					_emplacementPos,
					_emplacementDir,
					ncb_gv_radioTransmitterObjects
				] call horde_fnc_ObjectsMapper) params ["_radioStationBuildings"];

				// set damage to the two objects
				{
					private _b = _x;
					_b enableDynamicSimulation true;
					{
						if (typeOf _b == _x select 0) then {
							_b setDamage (_x select 1)
						}
					} forEach _aliveTaskBuildingData
				} forEach _radioStationBuildings;

				// location

				_locs = [];
				{
					if not (text _x isEqualTo "") then {
						_locs pushBack [_x,position _x]
					};
				} forEach nearestLocations [_emplacementPos,ncb_gv_allLocationTypes,1000];


				_locName = "in the Wilderness";
				_bestDist = 9999;
				{
					_x params ["_name","_pos"];
					_testDist = _pos distance2D _emplacementPos;
					if (_testDist < _bestDist) then {
						_bestDist = _testDist;
						_locName = text _name;
					};
				} forEach _locs;

				if (_locName find "'" > -1) then {
					_locName = _locName splitString "'" joinstring " ";
				};

				// static positions

				_radioTransmitterVantagePointsLow = [];
				_radioTransmitterVantagePointsHigh = [];
				_radioTransmitterStaticWeaponBuildings = [];
				_radioTransmitterStaticPoints = [];
				_taskBuildings = [];

				{
					_building = _x;
					_buildingDir = getDir _building;
					_buildingClass = typeOf _building;
					_cfgBuilding = (cfgVeh >> _buildingClass);
					_alarmBuilding = if ({_buildingClass isKindOf _x} count ncb_gv_alarmBuildingBaseClasses > 0) then {true} else {false};


					// snipers first

					{
						_x params ["_modelPos","_relDir","_posArr"]; // format of each element is [pos,relDir,[["middle",_modelAnglesMiddle],["up",_modelAnglesUp]]];
						_worldPos = _building modelToWorld _modelPos;
						_worldDir = (_relDir + _buildingDir) call horde_fnc_normalDir;
						_targetPositions = [];
						{
							_x params ["_text","_relAngles"];
							{
								_targetPos = _worldPos getPos [100,(_x + _buildingDir) call horde_fnc_normalDir];
								_targetPos = _targetPos vectorAdd [0,0,sel(_worldPos,2)];
								if (not lineIntersects [AGLtoASL _worldPos,AGLtoASL _targetPos,_building]
									and {not terrainIntersect [_worldPos,_targetPos]}
								) then {
									_targetPositions pushBack [_targetPos call _fnc_roundArray,_text];
								};
								true
							} count _relAngles;
							true
						} count _posArr;

						call {
							if (sel(_worldPos,2) > 15) exitWith {
								_radioTransmitterVantagePointsHigh pushBack [_worldPos,_worldDir,_targetPositions,_alarmBuilding,surfaceIsWater _worldPos];
							};
							if (sel(_worldPos,2) > 3) exitWith {
								_radioTransmitterVantagePointsLow pushBack [_worldPos,_worldDir,_targetPositions,_alarmBuilding,surfaceIsWater _worldPos];
							};
						};
						true
					} count (getArray (_cfgBuilding >> "unitData"));

					// now statics (the statics will be spawned in addition to normal zone ones - thay can be attached to the buildings as the buildings are not map objects)

					_staticWeaponData = getArray (_cfgBuilding >> "staticWeaponData");
					if not empty(_staticWeaponData) then {
						_radioTransmitterStaticWeaponBuildings pushBack _building;
						{
							// [modelPos,gunDir,gunString,worldAngles,vectorUpAndDir]
							_x params ["_modelPos","_relDir","_gunTypes","_relAngles","_vectorDirAndUp"];
							_vectorDirAndUp params ["_vectorDir","_vectorUp"];
							_worldPos = _building modelToWorld _modelPos;
							_attachPos = _building worldToModel _worldPos;
							_worldDir = (_relDir + _buildingDir) call horde_fnc_normalDir;
							_targetPositions = [];
							{
								_targetPos = _worldPos getPos [250,(_x + _buildingDir) call horde_fnc_normalDir];
								/*_targetPos = _targetPos vectorAdd [0,0,sel(_worldPos,2)];*/
								if (sel(AGLtoASL _targetPos,2) < sel(AGLtoASL _worldPos,2)) then {
									_targetPos = _targetPos vectorAdd [0,0,sel(AGLtoASL _worldPos,2) - sel(AGLtoASL _targetPos,2)];
								} else {
									_targetPos = _targetPos vectorAdd [0,0,10];
								};
								if (not lineIntersects [AGLtoASL _worldPos,AGLtoASL _targetPos,_building]
									and {not terrainIntersect [_worldPos,_targetPos]}
								) then {
									_targetPositions pushBack (_targetPos call _fnc_roundArray);
								};
								true
							} count _relAngles;

							if not empty(_targetPositions) then {
								/*_vectorDirAndUp = [vectorDir _zone vectorDiff (_vectorDir vectorDiff (vectorDir _building)),_vectorUp];*/
								_vectorDirAndUp = [[sin _worldDir,cos _worldDir,0],_vectorUp];
								_radioTransmitterStaticPoints pushBack [_gunTypes,_attachPos,_vectorDirAndUp,_worldDir,_targetPositions,_alarmBuilding,ATLtoASL _worldPos call _fnc_checkAboveASL];
							};
							true
						} count _staticWeaponData;
					};

					// if this is a mission building radio pole/generator then add EH for tasks
					if (_buildingClass isEqualTo "Land_spp_Transformer_F"
						or {_buildingClass isEqualTo "Land_Communication_F"}
						/*or {_buildingClass isEqualTo "WaterPump_01_forest_F"}*/
					) then {
						/*_building addEventHandler ["handledamage", {
							if (sel(_this,4) isKindOf "TimeBombCore") then {sel(_this,2)} else {0}
						}];*/
						_building addEventHandler ["killed",
							format [
								"[
									_this,
									%1,
									'%2'
								] call horde_fnc_checkRadioTransTaskComplete",
								_zone,
								_locName
							]
						];
						_taskBuildings pushBack _building;

						_building enableDynamicSimulation true;
					};
				} forEach _radioStationBuildings;

				// task buildings

				// whoops - done in section above!!!!!!
				/*{
					private _building = _x;
					private _buildingClass = typeOf _building;
					if (_buildingClass isEqualTo "Land_spp_Transformer_F"
						or {_buildingClass isEqualTo "Land_Communication_F"}
					) then {
						_building addEventHandler ["handledamage", {
							if (sel(_this,4) isKindOf "TimeBombCore") then {sel(_this,2)} else {0}
						}];
						_building addEventHandler ["killed",
							format [
								"[
									_this,
									%1,
									'%2'
								] call horde_fnc_checkRadioTransTaskComplete",
								_zone,
								_locName
							]
						];
						_taskBuildings pushBack _building;

						_building enableDynamicSimulation true;
					};
				} forEach _radioStationBuildings;*/

				// set tasks up

				if not empty(_taskBuildings) then {
					setVar(_zone,"zoneHasRadioInstallation",true);
					setVar(_zone,"zoneVantagePointsRadioTransmitterLow",_radioTransmitterVantagePointsLow);
					setVar(_zone,"zoneVantagePointsRadioTransmitterHigh",_radioTransmitterVantagePointsHigh);
					setVar(_zone,"zoneStaticBuildingsRadioTransmitter",_radioTransmitterStaticWeaponBuildings);
					setVar(_zone,"zoneStaticPointsRadioTransmitter",_radioTransmitterStaticPoints);
					setVar(_zone,"zoneTaskBuildingsRadioTransmitter",_taskBuildings);
					setVar(_zone,"zoneTriggerRadius",ncb_gv_zoneBaseTriggerRad);
					setVar(_zone,"zoneMaxSquadCount",ncb_param_zoneLocationValueRadioTransmitters);
					// set parent task (destroy all radio stations)
					if empty(ncb_gv_missionRadioTransZones) then {
						_return = [
							/*params*/"ncb_task_destroyRadioTransmitters",
							/*target*/true,
							/*desc*/["Destroy each Radio Transmitter to allow you to attack the governmental palace unharrassed.","Destroy all Radio Transmitters","Destroy All Radio Transmitters"],
							/*dest*/objNull,
							/*state*/"CREATED",
							/*priority*/0,
							/*showNotification*/false,
							/*isGlobal*/true,
							/*type*/"",
							/*shared*/false
						] call BIS_fnc_setTask;
					};

					_statement = "";
					if (_locName == "in the Wilderness") then {
						_statement = "Destroy the Radio Transmitter in the Wilderness";
					} else {
						_statement = format ["Destroy the Radio Transmitter near %1",_locName];
					};

					_return = [
						/*params*/[_taskID,"ncb_task_destroyRadioTransmitters"],
						/*target*/true,
						/*desc*/["Blow up the aerial and transformer.  You must use demo charges","Destroy radio-transmitter",_statement],
						/*dest*/ASLtoAGL _emplacementPos,
						/*state*/"CREATED",
						/*priority*/0,
						/*showNotification*/false,
						/*isGlobal*/true,
						/*type*/"destroy",
						/*shared*/false
					] call BIS_fnc_setTask;

					_saveData = [_emplacementPos,_emplacementDir,_radioStationBuildings];
					diag(_zone);
					diag(_taskID);
					diag(_taskBuildings);
					diag(_saveData);
					ncb_gv_RadioTransPositions pushBack [_zone,_taskID,_taskBuildings,_saveData];
					ncb_gv_missionRadioTransZones pushBack _zone;
				};
			}
		} forEach _zones;
	}
} else {
	if (ncb_param_govRadioTransmitters > 0) then {
		for "_i" from 1 to ncb_param_govRadioTransmitters do {
			if not empty(ncb_gv_zonesWithEmptySpace) then {
				for "_i" from 0 to count ncb_gv_zonesWithEmptySpace - 1 do {
					_zone = ncb_gv_zonesWithEmptySpace deleteAt (floor random count ncb_gv_zonesWithEmptySpace);
					if (({if (_x distance _zone < 3000) exitWith {1}} count _totalBaseZones) isEqualTo 0) exitWith {
						_totalBaseZones pushBack _zone;
						_taskID = "RT" + (str _zone);

						// set up radio station

						// select one of the empty spaces
						_emptyPlacesASL = getArray (configFile >> "CfgZones" >> worldName >>  str _zone >> "EmptyPlaces" >> "EmptyPlacesASL_20");
						_emptyPlacesASL = _emptyPlacesASL select {[] isEqualTo (nearestObjects [_x select 0,["All"],_x select 1])};
						if not empty(_emptyPlacesASL) then {
							_ret = _emptyPlacesASL deleteAt (floor random count _emptyPlacesASL);
							private _emplacementPos = ASLtoATL sel(_ret,0);
							private _emplacementDir = round random 360;
							_return = [
								ASLtoATL _emplacementPos,
								_emplacementDir,
								ncb_gv_radioTransmitterObjects
							] call horde_fnc_ObjectsMapper;

							_radioStationBuildings = sel(_return,0);
							/*_gunPlaces = sel(_return,1);
							_unitPlaces = sel(_return,2);
							_vehPlaces = sel(_return,3);*/

							_radioTransmitterVantagePointsLow = [];
							_radioTransmitterVantagePointsHigh = [];
							_radioTransmitterStaticWeaponBuildings = [];
							_radioTransmitterStaticPoints = [];
							_taskBuildings = [];

							// loc name

							_locs = [];
							{
								if not (text _x isEqualTo "") then {
									_locs pushBack [_x,position _x]
								};
							} forEach nearestLocations [_emplacementPos,ncb_gv_allLocationTypes,1000];


							_locName = "in the Wilderness";
							_bestDist = 9999;
							{
								_x params ["_name","_pos"];
								_testDist = _pos distance2D _emplacementPos;
								if (_testDist < _bestDist) then {
									_bestDist = _testDist;
									_locName = text _name;
								};
							} forEach _locs;

							if (_locName find "'" > -1) then {
								_locName = _locName splitString "'" joinstring " ";
							};

							// now set up the static positions and snipers for each building (patrol wps are okay - shouldn't need to modify)


							{
								_building = _x;
								_buildingDir = getDir _building;
								_buildingClass = typeOf _building;
								_cfgBuilding = (cfgVeh >> _buildingClass);
								_alarmBuilding = if ({_buildingClass isKindOf _x} count ncb_gv_alarmBuildingBaseClasses > 0) then {true} else {false};


								// snipers first

								{
									_x params ["_modelPos","_relDir","_posArr"]; // format of each element is [pos,relDir,[["middle",_modelAnglesMiddle],["up",_modelAnglesUp]]];
									_worldPos = _building modelToWorld _modelPos;
									_worldDir = (_relDir + _buildingDir) call horde_fnc_normalDir;
									_targetPositions = [];
									{
										_x params ["_text","_relAngles"];
										{
											_targetPos = _worldPos getPos [100,(_x + _buildingDir) call horde_fnc_normalDir];
											_targetPos = _targetPos vectorAdd [0,0,sel(_worldPos,2)];
											if (not lineIntersects [AGLtoASL _worldPos,AGLtoASL _targetPos,_building]
												and {not terrainIntersect [_worldPos,_targetPos]}
											) then {
												_targetPositions pushBack [_targetPos call _fnc_roundArray,_text];
											};
											true
										} count _relAngles;
										true
									} count _posArr;

									call {
										if (sel(_worldPos,2) > 15) exitWith {
											_radioTransmitterVantagePointsHigh pushBack [_worldPos,_worldDir,_targetPositions,_alarmBuilding,surfaceIsWater _worldPos];
										};
										if (sel(_worldPos,2) > 3) exitWith {
											_radioTransmitterVantagePointsLow pushBack [_worldPos,_worldDir,_targetPositions,_alarmBuilding,surfaceIsWater _worldPos];
										};
									};
									true
								} count (getArray (_cfgBuilding >> "unitData"));

								// now statics (the statics will be spawned in addition to normal zone ones - thay can be attached to the buildings as the buildings are not map objects)

								_staticWeaponData = getArray (_cfgBuilding >> "staticWeaponData");
								if not empty(_staticWeaponData) then {
									_radioTransmitterStaticWeaponBuildings pushBack _building;
									{
										// [modelPos,gunDir,gunString,worldAngles,vectorUpAndDir]
										_x params ["_modelPos","_relDir","_gunTypes","_relAngles","_vectorDirAndUp"];
										_vectorDirAndUp params ["_vectorDir","_vectorUp"];
										_worldPos = _building modelToWorld _modelPos;
										_attachPos = _building worldToModel _worldPos;
										_worldDir = (_relDir + _buildingDir) call horde_fnc_normalDir;
										_targetPositions = [];
										{
											_targetPos = _worldPos getPos [250,(_x + _buildingDir) call horde_fnc_normalDir];
											/*_targetPos = _targetPos vectorAdd [0,0,sel(_worldPos,2)];*/
											if (sel(AGLtoASL _targetPos,2) < sel(AGLtoASL _worldPos,2)) then {
												_targetPos = _targetPos vectorAdd [0,0,sel(AGLtoASL _worldPos,2) - sel(AGLtoASL _targetPos,2)];
											} else {
												_targetPos = _targetPos vectorAdd [0,0,10];
											};
											if (not lineIntersects [AGLtoASL _worldPos,AGLtoASL _targetPos,_building]
												and {not terrainIntersect [_worldPos,_targetPos]}
											) then {
												_targetPositions pushBack (_targetPos call _fnc_roundArray);
											};
											true
										} count _relAngles;

										if not empty(_targetPositions) then {
											/*_vectorDirAndUp = [vectorDir _zone vectorDiff (_vectorDir vectorDiff (vectorDir _building)),_vectorUp];*/
											_vectorDirAndUp = [[sin _worldDir,cos _worldDir,0],_vectorUp];
											_radioTransmitterStaticPoints pushBack [_gunTypes,_attachPos,_vectorDirAndUp,_worldDir,_targetPositions,_alarmBuilding,ATLtoASL _worldPos call _fnc_checkAboveASL];
										};
										true
									} count _staticWeaponData;
								};

								// if this is a mission building radio pole/generator then add EH for tasks
								if (_buildingClass isEqualTo "Land_spp_Transformer_F"
									or {_buildingClass isEqualTo "Land_Communication_F"}
									/*or {_buildingClass isEqualTo "WaterPump_01_forest_F"}*/
								) then {
									/*_building addEventHandler ["handledamage", {
										if (sel(_this,4) isKindOf "TimeBombCore") then {sel(_this,2)} else {0}
									}];*/
									_building addEventHandler ["killed",
										format [
											"[
												_this,
												%1,
												'%2'
											] call horde_fnc_checkRadioTransTaskComplete",
											_zone,
											_locName
										]
									];
									_taskBuildings pushBack _building;

									_building enableDynamicSimulation true;
								};
							} forEach _radioStationBuildings;

							_saveData = [_emplacementPos,_emplacementDir,_radioStationBuildings];

							if not empty(_taskBuildings) then {
								setVar(_zone,"zoneHasRadioInstallation",true);
								setVar(_zone,"zoneVantagePointsRadioTransmitterLow",_radioTransmitterVantagePointsLow);
								setVar(_zone,"zoneVantagePointsRadioTransmitterHigh",_radioTransmitterVantagePointsHigh);
								setVar(_zone,"zoneStaticBuildingsRadioTransmitter",_radioTransmitterStaticWeaponBuildings);
								setVar(_zone,"zoneStaticPointsRadioTransmitter",_radioTransmitterStaticPoints);
								setVar(_zone,"zoneTaskBuildingsRadioTransmitter",_taskBuildings);
								setVar(_zone,"zoneTriggerRadius",ncb_gv_zoneBaseTriggerRad);
								setVar(_zone,"zoneMaxSquadCount",ncb_param_zoneLocationValueRadioTransmitters);
								// set parent task (destroy all radio stations)
								if empty(ncb_gv_missionRadioTransZones) then {
									_return = [
										/*params*/"ncb_task_destroyRadioTransmitters",
										/*target*/true,
										/*desc*/["Destroy each Radio Transmitter to allow you to attack the governmental palace unharrassed.","Destroy all Radio Transmitters","Destroy All Radio Transmitters"],
										/*dest*/objNull,
										/*state*/"CREATED",
										/*priority*/0,
										/*showNotification*/false,
										/*isGlobal*/true,
										/*type*/"",
										/*shared*/false
									] call BIS_fnc_setTask;
								};

								_statement = "";
								if (_locName == "in the Wilderness") then {
									_statement = "Destroy the Radio Transmitter in the Wilderness";
								} else {
									_statement = format ["Destroy the Radio Transmitter near %1",_locName];
								};

								_return = [
									/*params*/[_taskID,"ncb_task_destroyRadioTransmitters"],
									/*target*/true,
									/*desc*/["Blow up the aerial and transformer.  You must use demo charges","Destroy radio-transmitter",_statement],
									/*dest*/ASLtoAGL sel(_ret,0),
									/*state*/"CREATED",
									/*priority*/0,
									/*showNotification*/false,
									/*isGlobal*/true,
									/*type*/"destroy",
									/*shared*/false
								] call BIS_fnc_setTask;
								diag(_zone);
								diag(_taskID);
								diag(_taskBuildings);
								diag(_saveData);
								ncb_gv_RadioTransPositions pushBack [_zone,_taskID,_taskBuildings,_saveData];
								ncb_gv_missionRadioTransZones pushBack _zone;
							};
						};
					};
				};
			};
		};
	};
};

// ARTILLERY

ncb_gv_ArtilleryPositions = [];
ncb_gv_missionArtilleryEmplacementZones = [];
if (ncb_gv_savedGame) then {
	// load artillery (save the pos/dir of sites and also veh details (damage etc))
	_entry = "artillery_0";
	_zones = ["read",[_entry,"zones",[]]] call ncb_gv_iniDbiArtillery;
	if not ([] isEqualTo _zones) then {
		_allVehicles = []; // maybe this needs moving - doesn't look like it does anything though!
		{
			_x params ["_zoneName","_taskID","_siteData","_samSiteData"];
			_zone = missionNamespace getVariable _zoneName;
			_totalBaseZones pushBack _zone;
			_allGuns = [];
			_allMen = [];
			_saveData = [];
			_saveDataSamSites = [];
			_taskVehicles = [];

			{
				_x params ["_posWorld","_direction","_damage","_hitPoints"];

				([
					_posWorld,
					_direction,
					ncb_gv_artilleryObjects
				] call horde_fnc_ObjectsMapper) params ["_artilleryBuildings","_gunPlaces","_unitPlaces","_vehPlaces"];

				{_x enableDynamicSimulation true} count _artilleryBuildings;

				diag(_vehPlaces);

				_allGuns = _allGuns + _gunPlaces;
				_allMen = _allMen + _unitPlaces;
				if (_damage < 1) then {
					_allVehicles = _allVehicles + _vehPlaces;
					private _saveVehs = [];
					{
						// spawn
						_x params ["_typ","_pos","_dir"];
						_crewType = getText (cfgVeh >> _typ >> "crew");
						_veh = spawnVeh(_typ,_pos);
						_veh setDir _dir;
						_veh enableSimulationGlobal false;
						_veh spawn {
							scriptName "serverPostInitLoadArtillery";
							waitUntil {
								uiSleep 1;
								time > 0
							};
							_this enableSimulationGlobal true;
						};
						_veh allowCrewInImmobile true;
						[_veh,0] call horde_fnc_setFuelGlobal;
						_veh setVehicleLock "LOCKED";
						if (ncb_param_aiDisableVehicleVisionNV) then {
							_veh disableNVGEquipment true
						};
						if (ncb_param_aiDisableVehicleVisionTI) then {
							_veh disableTIEquipment true
						};
						_taskVehicles pushBack _veh;
						_saveVehs pushBack _veh;
						_veh addEventHandler ["reloaded", {
							_this call horde_fnc_autoReloadVehWeap
						}];
						_veh call horde_fnc_addExtraVehicleMags;
						_veh addEventHandler ["Fired", {
							params ["_veh","_weapon","","","","","_proj"];
							if (_weapon == "mortar_155mm_AMOS") then {
								[_veh,[0,0,-1]] call horde_fnc_setVelocityGlobal;
								deleteVehicle _proj;
							};
						}];
						_veh setDamage _damage;
						{
							_veh setHitPointDamage _x;
						} count _hitPoints;
						_veh setVariable ["ncb_garbageExcluded",true];
						_veh enableDynamicSimulation true;
					} forEach _vehPlaces;
					_saveData pushBack [_posWorld,_direction,_saveVehs,_artilleryBuildings];
				}
			} forEach _siteData;

			{
				_x params ["_samSitePos","_samSiteDir","_samType"];
				([
					_samSitePos,
					_samSiteDir,
					ncb_gv_samSiteObjects
				] call horde_fnc_objectsMapper) params ["_samObjects","_sams"];

				{_x enableDynamicSimulation true} count _samObjects;
				private _veh = objNull;
				{
					_veh = createVehicle [_samType,_x select 1,[],0,"can_collide"];
					_veh setDir (_x select 2);
					_veh setPosASL AGLtoASL (_x select 1);
					[_veh,(_samObjects select 0)] call BIS_fnc_attachToRelative;
					_veh spawn {
						scriptName "staticTurretSetup";
						waitUntil {
							sleep 3;
							time > 1
						};
						detach _this
					};
					_veh addEventHandler ["reloaded", {
						_this call horde_fnc_autoReloadVehWeap
					}];
					_veh call horde_fnc_addExtraVehicleMags;
					createVehicleCrew _veh;
					_grp = group gunner _veh;
					_grp setCombatMode "red";
					_grp setBehaviour "combat";
					_veh enableDynamicSimulation true;
				} forEach _sams;

				_saveDataSamSites pushBack [_samSitePos,_samSiteDir,_veh];

			} forEach _samSiteData;

			ncb_gv_ArtilleryPositions pushBack [_zone,_taskID,_saveData,_saveDataSamSites];

			setVar(_zone,"zoneHasArtilleryEmplacement",true);
			setVar(_zone,"zoneArtilleryGunPositions",_allGuns);
			setVar(_zone,"zoneArtilleryMenPositions",_allMen);
			setVar(_zone,"zoneArtilleryVehicles",_taskVehicles);
			setVar(_zone,"zoneTriggerRadius",ncb_gv_zoneBaseTriggerRad);
			setVar(_zone,"zoneMaxSquadCount",ncb_param_zoneLocationValueGovArtilleryEmplacements);

			[_zone,_taskID,_taskVehicles] call horde_fnc_setupArtillery;
		} forEach _zones;
	};
	// delete section
	["deleteSection",_entry] call ncb_gv_iniDbiArtillery;
} else {
	if (ncb_param_govArtilleryEmplacements > 0) then {
		for "_i" from 1 to ncb_param_govArtilleryEmplacements do {
			if not empty(ncb_gv_zonesWithEmptySpace) then {
				for "_i" from 0 to count ncb_gv_zonesWithEmptySpace - 1 do {
					_zone = ncb_gv_zonesWithEmptySpace deleteAt (floor random count ncb_gv_zonesWithEmptySpace);
					if (({if (_x distance _zone < 3000) exitWith {1}} count _totalBaseZones) isEqualTo 0) exitWith {
						_totalBaseZones pushBack _zone;
						_taskID = "AY" + (str _zone);
						// set up artillery (up to 3 emplacements)
						_emptyPlacesASL = getArray (configFile >> "CfgZones" >> worldName >> str _zone >> "EmptyPlaces" >> "EmptyPlacesASL_20");
						_emptyPlacesASL = _emptyPlacesASL select {[] isEqualTo (nearestObjects [_x select 0,["All"],_x select 1])};
						if not empty(_emptyPlacesASL) then {
							_allBuildings = [];
							_allGuns = [];
							_allMen = [];
							_allVehicles = [];
							_taskVehicles = [];
							_saveData = [];
							_saveDataSamSites = [];

							for "_count" from 1 to 3 do {
								if not empty(_emptyPlacesASL) then {
									_ret = _emptyPlacesASL deleteAt (floor random count _emptyPlacesASL);
									private _emplacementPos = ASLtoATL sel(_ret,0);
									private _emplacementDir = round random 360;
									_return = [
										_emplacementPos,
										_emplacementDir,
										ncb_gv_artilleryObjects
									] call horde_fnc_objectsMapper;

									_artilleryBuildings = sel(_return,0);
									_gunPlaces = sel(_return,1);
									_unitPlaces = sel(_return,2);
									_vehPlaces = sel(_return,3);

									_allBuildings = _allBuildings + _artilleryBuildings;
									_allGuns = _allGuns + _gunPlaces;
									_allMen = _allMen + _unitPlaces;
									_allVehicles = _allVehicles + _vehPlaces;

									{_x enableDynamicSimulation true} count _artilleryBuildings;

									private _saveVehs = [];

									{
										// spawn
										_x params ["_typ","_pos","_dir"];
										_crewType = getText (cfgVeh >> _typ >> "crew");
										_veh = spawnVeh(_typ,_pos);
										_veh setDir _dir;
										_veh enableSimulationGlobal false;
										_veh setPos _pos;
										_veh spawn {
											scriptName "serverPostInitLoadArtillery";
											waitUntil {
												uiSleep 1;
												time > 1
											};
											_this enableSimulationGlobal true;
											_this enableDynamicSimulation true;
										};
										_veh allowCrewInImmobile true;
										[_veh,0] call horde_fnc_setFuelGlobal;
										_veh setVehicleLock "LOCKED";
										if (ncb_param_aiDisableVehicleVisionNV) then {
											_veh disableNVGEquipment true
										};
										if (ncb_param_aiDisableVehicleVisionTI) then {
											_veh disableTIEquipment true
										};
										_taskVehicles pushBack _veh;
										_saveVehs pushBack _veh;
										_veh addEventHandler ["reloaded", {
											_this call horde_fnc_autoReloadVehWeap
										}];
										_veh call horde_fnc_addExtraVehicleMags;
										_veh addEventHandler ["Fired", {
											params ["_veh","_weapon","","","","","_proj"];
											if (_weapon == "mortar_155mm_AMOS") then {
												[_veh,[0,0,-1]] call horde_fnc_setVelocityGlobal;
												deleteVehicle _proj;
											};
										}];
										_veh setVariable ["ncb_garbageExcluded",true];
									} forEach _vehPlaces;

									// new bit to spawn in some AA (will need to save this shit in db)

									_samPos = ASLtoATL ([_emplacementPos,30,70,7,0,1,0] call horde_fnc_findSafePosASL);
									_samDir = random 360;
									_return = [
										_samPos,
										_samDir,
										ncb_gv_samSiteObjects
									] call horde_fnc_objectsMapper;

									{_x enableDynamicSimulation true}count (_return select 0);
									private _veh = objNull;
									{
										_veh = createVehicle [selectRandom ["ncb_static_spartan_system","ncb_static_goalkeeper_system"],_x select 1,[],0,"can_collide"];
										_veh setDir (_x select 2);
										_veh setPos (_x select 1);
										[_veh,(_return select 0 select 0)] call BIS_fnc_attachToRelative;
										_veh spawn {
											scriptName "staticTurretSetup";
											waitUntil {
												sleep 3;
												time > 1
											};
											detach _this
										};
										_veh addEventHandler ["reloaded", {
											_this call horde_fnc_autoReloadVehWeap
										}];
										_veh call horde_fnc_addExtraVehicleMags;
										createVehicleCrew _veh;
										_grp = group gunner _veh;
										_grp setCombatMode "red";
										_grp setBehaviour "combat";
										_veh enableDynamicSimulation true;
									} forEach (_return select 1);

									_saveDataSamSites pushBack [_samPos,_samDir,_veh];


									// end new bit

									_saveData pushBack [_emplacementPos,_emplacementDir,_saveVehs,_artilleryBuildings];
								};
							};

							setVar(_zone,"zoneHasArtilleryEmplacement",true);
							setVar(_zone,"zoneArtilleryGunPositions",_allGuns);
							setVar(_zone,"zoneArtilleryMenPositions",_allMen);
							setVar(_zone,"zoneArtilleryVehicles",_taskVehicles);
							setVar(_zone,"zoneTriggerRadius",ncb_gv_zoneBaseTriggerRad);
							setVar(_zone,"zoneMaxSquadCount",ncb_param_zoneLocationValueGovArtilleryEmplacements);

							ncb_gv_ArtilleryPositions pushBack [_zone,_taskID,_saveData,_saveDataSamSites];

							[_zone,_taskID,_taskVehicles] call horde_fnc_setupArtillery;
						};
					};
				};
			};
		};
	};
};

// broadcast zone positions (for use as blacklist in horde_fnc_selectRespawnPos)

ncb_pv_airbaseBlacklistPositions = ncb_gv_missionAirBaseZones apply {ASLtoAGL getPosASL _x};
ncb_pv_artilleryBlacklistPositions = ncb_gv_missionArtilleryEmplacementZones apply {ASLtoAGL getPosASL _x};
ncb_pv_radioBlacklistPositions = ncb_gv_missionRadioTransZones apply {ASLtoAGL getPosASL _x};

publicVariable "ncb_pv_airbaseBlacklistPositions";
publicVariable "ncb_pv_artilleryBlacklistPositions";
publicVariable "ncb_pv_radioBlacklistPositions";

// ADD PATROL HELIS

if not (ncb_gv_missionAirBaseZones isEqualTo []) then {
	[
		[],{
			if (getClientState == "BRIEFING READ" and {time > 5}) then {
				[
					[1],
					{
						call horde_fnc_getEachFrameArgs params ["_numb"];
						if (_numb <= ncb_param_initialNumberHeliPatrols) then {
							0 execFSM "server\government\air_patrol\helicopterManager.fsm";
							_numb = _numb + 1;
							[_numb] call horde_fnc_updateEachFrameArgs
						} else {
							call horde_fnc_removeEachFrame
						}
					},
					1
				] call horde_fnc_updateEachFrame
			}
		},
		5
	] call horde_fnc_addEachFrame;
};

#define allied 1
#define adversary 0

// create group for static weapon logics

ncb_grp_staticWeapons = createGroup sideLogic;
_log = spawnUnit(ncb_grp_staticWeapons,"StaticWeapon_Logic",zeroPos);

addMissionEventHandler ["HandleDisconnect", {
	private ["_unit","_grp","_pos","_wholder"];
	_unit  = _this select 0;

	// reset vars (not sure if this is needed)

	_unit setVariable ["playerKills",0];
	_unit setVariable ["aiKills",0];

	_grp = group _unit;
	_pos = getPosATL _unit;
	{
		detach _x;
		deleteVehicle _x
	} forEach attachedObjects _unit;
	_wholder = nearestObjects [
		_pos,
		["weaponHolderSimulated","weaponHolder"],
		2
	];
	{
		deleteVehicle _x;
	} count (_wholder + [_unit]);

	if (not isNull _grp and {({if (alive _x) exitWith {1}} count units _grp) isEqualTo 0}) then {
		_grp call horde_fnc_deleteGroupGlobal;
	};

	true remoteExecCall [
		"horde_fnc_playerRemoveNonGroupTentMarkers",
		0
	];

	// check if logout is correct (at tent).  If not, then del db entry
	// this does not trip on hoisted as the missionEventHandler does not fire....
	// (don't need this now as the player entry in the DB is cleared after load)
	/*diag_log format ["did unit log out at tent: %1", _unit getVariable ["correctLogOut",false]];
	if not (_unit getVariable ["correctLogOut",false]) then {
		["deleteSection",getPlayerUID _unit] call ncb_gv_iniDbiPlayer;
	} else {
		_unit setVariable ["correctLogOut",nil]
	};*/

	false
}];

_return = 0 call horde_fnc_unitPoolManager; // spawn all units/vehs in init :)

/*_wreckSites = +ncb_gv_mapRoadSegments;
for "_i" from 1 to ncb_param_roadWrecks do {
	if empty(_wreckSites) exitWith {};
	_randomIndex = floor random count _wreckSites;
	_randomSiteData = sel(_wreckSites,_randomIndex);
	_roadID = sel(_randomSiteData,0);
	_roadPosASL = sel(_randomSiteData,1);
	_roadDir = sel(_randomSiteData,2);

	_nearObs = nearestObjects [ASLtoATL _roadPosASL,["House_F","Wreck_Base"],50];
	if empty(_nearObs) then {
		_wreckClass = selectRandom ncb_gv_wreckTypes;
		_roadPosASL set[0,sel(_roadPosASL,0) + (random 2.5) - 1.25];
		_roadPosASL set[1,sel(_roadPosASL,1) + (random 2.5) - 1.25];
		_wreck = spawnVeh(_wreckClass,ASLtoATL _roadPosASL);
		_items = getArray (cfgVeh >> _wreckClass >> "InteractionInfo" >> "Salvage" >> "tools");
		_item = selectRandom _items;
		setVarPlc(_wreck,"wreckSalvageItem",_item);
		_wreck setDir random 360;
		_wreck setPosASL _roadPosASL;
		_wreck setVectorUp surfaceNormal _roadPosASL;
		_wreck enableSimulationGlobal false;
		_wreck allowDamage false;
	};
	_wreckSites deleteAt _randomIndex;
};*/

// try and spawn at side of road

_wreckSites = +ncb_gv_mapRoadSegments;
for "_i" from 1 to ncb_param_roadWrecks do {
	if empty(_wreckSites) exitWith {};
	private _found = false;
	for "_j" from 0 to 99999 do {
		if (_found) exitWith {};
		(_wreckSites deleteAt (floor random count _wreckSites)) params ["","_roadPosASL","_roadDir"];
		// check both sides
		private _reverse = if (random 1 > 0.5) then {true} else {false};
		for "_k" from 90 to 270 step 180 do {
			if (_found) exitWith {};
			if (_reverse) then {_k = _k + 180};
			_nearObs = (nearestObjects [ASLtoATL _roadPosASL getPos [6,_roadDir + _k],["All"],6]) - (ASLtoATL _roadPosASL getPos [6,_roadDir + _k] nearRoads 6);
			if empty(_nearObs) then {
				_wreckClass = selectRandom ncb_gv_wreckTypes;
				_roadPosASL = ASLtoATL _roadPosASL getPos [6,_roadDir + _k];
				_wreck = spawnVeh(_wreckClass,_roadPosASL);
				_items = getArray (cfgVeh >> _wreckClass >> "InteractionInfo" >> "Salvage" >> "tools");
				_item = selectRandom _items;
				setVarPlc(_wreck,"wreckSalvageItem",_item);
				_wreck setDir (_roadDir - 20 + random 40);
				_wreck setPosASL AGLtoASL _roadPosASL;
				_wreck setVectorUp surfaceNormal _roadPosASL;
				_wreck allowDamage false;
				[
					_wreck,
					[0,1,0,1],	// optics
					[0,1,0,1],	// vests
					[0,1,0,1],	// helmets
					[0,1,0,1],	// guns
					[0,1,0,1],	// backpacks
					[0,1,0,1],	// charges
					[0,1,0,1],	// medical
					[0,1,0,1],	// food
					[0,1,0,1],	// tools
					[0,1,0,1],	// tents
					[0,1,0,1],	// fuel
					[0,1,0,2],	// vehicle ammo
					[0,1,0,1],	// launchers
					[]			// vehicle parts
				] call horde_fnc_fillCrate;
				_wreck enableDynamicSimulation true;
				_found = true
			};
		};
	}
};
// wrecked aircraft in fields
if (ncb_param_airWrecks > 0) then {
	ncb_param_airWrecks execFSM "server\wrecks\air_wreck.fsm";
};

[
	ncb_param_removeDeadTimeout,
	ncb_param_removeAbandonedVehicleTimeout,
	ncb_param_removeAbandonedBoatTimeout
] execFSM "server\garbage\clearGarbage.fsm";
call {
	if (ncb_param_weatherSystemSelect == 0) exitWith {
		if (ncb_param_realTime == 1) then {
			[
				["serverPostInitSetDate"],{
					if (time > 1) then {
						setDate (missionStart select [0,5]);
						call horde_fnc_removeEachFrame
					}
				},
				0.1
			] call horde_fnc_addEachFrame;
		} else {
			setDate [
				ncb_param_startingYear,
				ncb_param_startingMonth,
				ncb_param_startingDay,
				ncb_param_startingHour,
				ncb_param_startingMinute
			];
			// set time multiplier
			if (ncb_param_dayTimeRatio < 0) then {
				ncb_param_dayTimeRatio = abs ncb_param_dayTimeRatio * 0.1
			};
			if (ncb_param_nightTimeRatio < 0) then {
				ncb_param_nightTimeRatio = abs ncb_param_nightTimeRatio * 0.1
			};
			if (ncb_param_fullMoon) then {
				ncb_pv_originalDate = date;
				publicVariable "ncb_pv_originalDate";
				if (date select 2 != 13
					and {date select 1 != 7}
					and {date select 0 != 4804}
				) then {
					setDate [4804,7,13,date select 3,date select 4]
				};
			};

			// only change weather if needed (starting with clear weather is in editor mission parameters)
			if (ncb_param_startingWeather > 0) then {
				ncb_param_startingWeather call horde_fnc_setNewWeather;
				skipTime -24;
				86400 setFog (ncb_gv_intendedWeather select 0);
				86400 setOvercast (ncb_gv_intendedWeather select 1);
				86400 setRain (ncb_gv_intendedWeather select 2);
				// 86400 setWaves (ncb_gv_intendedWeather select 4);
				skipTime 24;
				setWind (ncb_gv_intendedWeather select 3);
				0 setRain (ncb_gv_intendedWeather select 2);
				[
					[],{
						if (time > 1) then {
							forceWeatherChange;
							//simulWeatherSync;
							call horde_fnc_removeEachFrame
						};
					},
					0.1
				] call horde_fnc_addEachFrame;
			};

			// end new bit

			[
				["timeMultiplier"],{
					if (sunOrMoon > 0) then {
						if (timeMultiplier != ncb_param_dayTimeRatio) then {
							setTimeMultiplier ncb_param_dayTimeRatio
						};
					} else {
						if (timeMultiplier != ncb_param_nightTimeRatio) then {
							setTimeMultiplier ncb_param_nightTimeRatio
						};
					};
					// set full moon if selected in params
					if (ncb_param_fullMoon) then {
						if (date select 2 != 13
							and {date select 1 != 7}
							and {date select 0 != 4804}
						) then {
							setDate [4804,7,13,0,0]
						}
					}
				},
				60
			] call horde_fnc_addEachFrame;

		};
	};
	if (ncb_param_weatherSystemSelect == 1) exitWith {
		_handle = [
			ncb_param_startingWeather,
			ncb_param_startingHour,
			ncb_param_startingMinute,
			ncb_param_realTime,
			ncb_param_dayTimeRatio,
			ncb_param_nightTimeRatio
		] execFSM "server\weather\weather.fsm";
	};
};


enableDynamicSimulationSystem true;
"prop" setDynamicSimulationDistance 1500;
"group" setDynamicSimulationDistance 1500;
"vehicle" setDynamicSimulationDistance 3000;
"EmptyVehicle" setDynamicSimulationDistance 1500;

/*execVM "server\tasks\sideMissions\sideMissionManager.sqf";*/
0 spawn {
	scriptName "sideMissionManagerStart";
	waitUntil {
		time > 30
	};
	isNil {call horde_fnc_sideMissionManager}
};

// dodgy start for final mission here

0 = 0 spawn compile preprocessFileLineNumbers "server\tasks\endtask\setup.sqf";
publicVariable "ncb_pv_paramsArray";
saveProfileNamespace; // was at end of preinit

// test (some code is in clientPostInit as well)

/*ncb_pv_clientFunctions = [];
_cfgFncs = missionConfigFile >> "CfgFunctions" >> "Horde" >> "test"; // change to "client"
for "_i" from 0 to count _cfgFncs -1 do {
	_cfgFnc = _cfgFncs select _i;
	_fncName = "horde_fnc_" + (configName _cfgFnc);
	ncb_pv_clientFunctions pushBack [_fncName,missionNameSpace getVariable _fncName];
};
"ncb_pv_requestClientFunctions" addPublicVariableEventHandler {
	params ["","_player"];
	(owner _player) publicVariableClient "ncb_pv_clientFunctions"
};*/

// end test  (new test for compressed fncs in server preInit)

diag_log "/**************************************/";
diag("server post-init done");
diag_log "/**************************************/";

