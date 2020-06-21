#include "\nocebo\defines\scriptDefines.hpp"

diag_log "--------------------------------------------------------";
diag("started");
diag(_this);
diag_log "--------------------------------------------------------";


// ran on SERVER

// if any players are in vehicles, then eject them and stop them. (also, save their positions as they will be slung out of game)

// 1 - find all vehicles occupied by players

// 2 - find somewhere safe for them and move them

// 3 - eject all players and put them near their vehicle

// 4 - save and logout all players (except host if hosted)

// 5 - save mission objects (tents, crates etc)

// 6 - save tasks and current status

private _text = "
	<t size='3.2'color='#FFFFFF'align='center'shadow='2'>
	Server is shutting down, Saving and logging out.
	</t>
";
_text remoteExecCall [
	"horde_fnc_displayActionConfMessage",
	allPlayers - entities "HeadlessClient_F"
];

// what about boats????
private _crateTypes = ["Slingload_base_F","B_supplyCrate_F"];
private _ammoBoxes = [];
private _playerVehicles = [];
private _players = [];
{
	_players pushBack _x;
	private _vehicle = objectParent _x;
	if not (isNull _vehicle) then {
		private _index = _playerVehicles pushBackUnique _vehicle;
		if (_index > -1) then {
			if (_vehicle isKindOf "Ship_F") then {
				[_vehicle,[0,0,0]] call horde_fnc_setVelocityGlobal;
				_vehicle enableSimulationGlobal false;
			} else {
				private _position = getPosWorld _vehicle;
				_position resize 2;
				private _found = false;
				for "_radius" from 50 to 5000 step 50 do {
					// https://community.bistudio.com/wiki/Ambient_Parameters
					private _bestPlaces = selectBestPlaces [
						_position,
						_radius,
						"meadow - trees - forest - houses - sea",
						50,
						5
					];
					if not empty(_bestPlaces) then {
						for "_i" from 0 to count _bestPlaces - 1 do {
							private _cand = _bestPlaces select _i select 0;
							private _safePosASL = [_cand,0,50,10,0,0.3,0] call horde_fnc_findSafePosASL;
							if not empty(_safePosASL) exitWith {
								_found = true;
								detach _vehicle; // just in case player is on quad in back of truck etc
								[_vehicle,[0,0,0]] call horde_fnc_setVelocityGlobal;
								_vehicle setPosASL _safePosASL;
								_vehicle setVectorUp surfaceNormal _safePosASL;
								_vehicle enableSimulationGlobal false;
								private _attachedObjects = attachedObjects _vehicle;
								if not (_attachedObjects isEqualTo []) then {
									{
										private _attachedObj = _x;
										if ({if (_attachedObj isKindOf _x) exitWith {1}} count _crateTypes > 0) then {
											_ammoBoxes pushBackUnique _attachedObj;
											detach _attachedObj;
											private _cargoPosASL = [_safePosASL,0,10,3,0,0.3,0] call horde_fnc_findSafePosASL;
											if not (_cargoPosASL isEqualTo []) then {
												_attachedObj setPosASL _cargoPosASL
											} else {
												_attachedObj setPos (ASLtoAGL _safePosASL getPos [4 + random 3,random 360])
											};
										};
									} forEach _attachedObjects;
								};
							};
						};
					};
					if (_found) exitWith {};
				};
			};
		};
	};
} forEach (allPlayers - entities "HeadlessClient_F");

// now eject players

{
	if (not isNull _x and {not isNull objectParent _x}) then {
		moveOut _x
	};
} forEach _players;

// wait until all players are out of their vehicles


/*[
	[_unit],
	{
		call horde_fnc_getEachFrameArgs params ["_unit"];
		systemChat format ["1 sec: %1 %2",time,_unit];
		call horde_fnc_removeEachFrame
	},
	1
] call horde_fnc_updateEachFrame*/


[
	[_playerVehicles,_ammoBoxes,_crateTypes],{
		private _allPlayers = allPlayers - entities "HeadlessClient_F";
		if (count _allPlayers == count (_allPlayers select {isNull objectParent _x})) then {
			// everyone is out so request their stats
			["horde_fnc_serverPlayerLogOut","Server shutdown - Logging out",true] remoteExecCall [
				"horde_fnc_getPlayerStats",
				_allPlayers
			];
			// now wait until stats received (serverPlayerLogOut will log all clients out except host on hosted server)
			[
				{
					_allPlayers = allPlayers - entities "HeadlessClient_F";
					if (count _allPlayers == count (_allPlayers select {_x getVariable ["correctLogOut",false]})) then {
						call horde_fnc_getEachFrameArgs params ["_playerVehicles","_ammoBoxes","_crateTypes"];
						// continue with tents now all players are accounted for
						_camoNets = [];
						/*_staticObjects = [];*/
						{
							if (not isNull _x
								and {alive _x}
							) then {
								private _name = "tent_" + str _forEachIndex;
								private _details = _x getVariable ["tentOwnerDetails",["uid","markerName","personal"]];
								["write",[_name,"class",typeOf _x]] call ncb_gv_iniDbiTents;
								["write",[_name,"users",_details select 2]] call ncb_gv_iniDbiTents;
								["write",[_name,"owner",_details select 0]] call ncb_gv_iniDbiTents;
								["write",[_name,"position",getPosWorld _x]] call ncb_gv_iniDbiTents;
								["write",[_name,"direction",getDir _x]] call ncb_gv_iniDbiTents;
								["write",[_name,"vectorUp",vectorUp _x]] call ncb_gv_iniDbiTents;
								["write",[_name,"cargo",[_x,true] call horde_fnc_totalContents]] call ncb_gv_iniDbiTents;
								["write",[_name,"damage",damage _x]] call ncb_gv_iniDbiTents;

								// find near vehicles, crates/ammoboxes and camo-nets
								{
									_playerVehicles pushBackUnique _x
								} forEach (_x nearEntities [["LandVehicle","Air","Ship_F"],50]);
								{
									_ammoBoxes pushBackUnique _x
								} forEach (_x nearEntities [_crateTypes,50]);
								{
									_camoNets pushBackUnique _x
								} forEach (nearestObjects [_x,["CamoNet_BLUFOR_F"],50]);
								/*private _nearTerrainObjs = nearestTerrainObjects [_x,[],50,false];
								{
									_staticObjects pushBackUnique _x
								} forEach (nearestObjects [_x,["Static"],50] select {not (_x in _nearTerrainObjs) and {not (_x in _camoNets)}});*/
							};
						} forEach ((allMissionObjects "ncb_obj_tent_dome") + (allMissionObjects "ncb_obj_para_beacon"));

						//  air wrecks & crates

						{
							if (not isNull _x
								and {alive _x}
							) then {
								private _name = "airwreck_" + str _forEachIndex;
								["write",[_name,"class",typeOf _x]] call ncb_gv_iniDbiAirWrecks;
								["write",[_name,"position",getPosWorld _x]] call ncb_gv_iniDbiAirWrecks;
								["write",[_name,"direction",getDir _x]] call ncb_gv_iniDbiAirWrecks;
								["write",[_name,"vectorUp",vectorUp _x]] call ncb_gv_iniDbiAirWrecks;
								["write",[_name,"wreckSalvageItem",_x getVariable ["wreckSalvageItem","ItemWrench"]]] call ncb_gv_iniDbiAirWrecks;

								// find near crates/ammoboxes

								{
									_ammoBoxes pushBackUnique _x
								} forEach (_x nearEntities [_crateTypes,50]);
							};
						} forEach (allMissionObjects "ncb_obj_wreck_blackfoot"
							+ allMissionObjects "ncb_obj_wreck_kajman"
							+ allMissionObjects "ncb_obj_wreck_samson"
						);

						// now process vehicles etc

						{
							private _veh = _x;
							if (not isNull _veh
							    and {alive _veh}
							) then {
								private _type = typeOf _veh;
								private _cfgType = configFile >> "cfgVehicles" >> _type;
								// damage & repairs
								private _cfgHitPoints = _cfgType >> "HitPoints";
								private _hitPointArr = [];
								private _toolPartArr = [];
								for "_i" from 0 to count _cfgHitPoints - 1 do {
									private _cfgEntry = sel(_cfgHitPoints,_i);
									if (isClass _cfgEntry) then {
										private _configName = configName _cfgEntry;
										private _hitPoints = _veh getHitPointDamage _configName;
										_hitPointArr pushBack [_configName,_hitPoints];
										private _repairInfo = getVar(_veh,_configName);
										if not (isNil "_repairInfo") then {
											_part = sel(_repairInfo,0);
											_tool = sel(_repairInfo,1);
											_toolPartArr pushBack [_configName,_part,_tool];
										};
									};
								};
								/*AMMO*/

								private _mags = (magazinesAllTurrets _veh) apply {[_x select 0,_x select 1,_x select 2]};
								_mags = _mags select {_x select 2 != 0};

								/*CARGO*/

								private _cargoDataArr = [_veh,true] call horde_fnc_totalContents;

								/*TEXTURE*/

								private _textures = getObjectTextures _veh;
								if (isNil "_textures") then {
									_textures = [];
								};

								/*LOCKED*/

								private _locked = locked _veh;

								private _name = "vehicle_" + str _forEachIndex;
								["write",[_name,"class",_type]] call ncb_gv_iniDbiVehicles;
								["write",[_name,"position",getPosWorld _veh]] call ncb_gv_iniDbiVehicles;
								["write",[_name,"direction",getDir _veh]] call ncb_gv_iniDbiVehicles;
								["write",[_name,"vectorUp",vectorUp _veh]] call ncb_gv_iniDbiVehicles;
								["write",[_name,"fuel",fuel _veh]] call ncb_gv_iniDbiVehicles;
								["write",[_name,"damage",damage _veh]] call ncb_gv_iniDbiVehicles;
								["write",[_name,"hitPoints",_hitPointArr]] call ncb_gv_iniDbiVehicles;
								["write",[_name,"cargo",_cargoDataArr]] call ncb_gv_iniDbiVehicles;
								["write",[_name,"magazines",_mags]] call ncb_gv_iniDbiVehicles;
								["write",[_name,"tools",_toolPartArr]] call ncb_gv_iniDbiVehicles;
								["write",[_name,"textures",_textures]] call ncb_gv_iniDbiVehicles;
								["write",[_name,"locked",_locked]] call ncb_gv_iniDbiVehicles;
							};
						} forEach _playerVehicles;

						{
							if (not isNull _x
								and {alive _x}
							) then {
								private _name = "camoNet_" + str _forEachIndex;
								["write",[_name,"class",typeOf _x]] call ncb_gv_iniDbiCamoNets;
								["write",[_name,"position",getPosWorld _x]] call ncb_gv_iniDbiCamoNets;
								["write",[_name,"direction",getDir _x]] call ncb_gv_iniDbiCamoNets;
								["write",[_name,"vectorUp",vectorUp _x]] call ncb_gv_iniDbiCamoNets;
								["write",[_name,"damage",damage _x]] call ncb_gv_iniDbiCamoNets;
							};
						} forEach _camoNets;

						{
							if (not isNull _x
								and {alive _x}
							) then {
								private _name = "ammoBoxes_" + str _forEachIndex;
								["write",[_name,"class",typeOf _x]] call ncb_gv_iniDbiAmmoBoxes;
								["write",[_name,"position",getPosWorld _x]] call ncb_gv_iniDbiAmmoBoxes;
								["write",[_name,"direction",getDir _x]] call ncb_gv_iniDbiAmmoBoxes;
								["write",[_name,"vectorUp",vectorUp _x]] call ncb_gv_iniDbiAmmoBoxes;
								["write",[_name,"damage",damage _x]] call ncb_gv_iniDbiAmmoBoxes;
								["write",[_name,"cargo",[_x,true] call horde_fnc_totalContents]] call ncb_gv_iniDbiAmmoBoxes;
							};
						} forEach _ammoBoxes;

						/*{
							if (not isNull _x
								and {alive _x}
							) then {
								private _name = "staticObjects_" + str _forEachIndex;
								["write",[_name,"class",typeOf _x]] call ncb_gv_iniDbiStaticObjects;
								["write",[_name,"position",getPosWorld _x]] call ncb_gv_iniDbiStaticObjects;
								["write",[_name,"direction",getDir _x]] call ncb_gv_iniDbiStaticObjects;
								["write",[_name,"vectorUp",vectorUp _x]] call ncb_gv_iniDbiStaticObjects;
								["write",[_name,"damage",damage _x]] call ncb_gv_iniDbiStaticObjects;
							};
						} forEach _staticObjects;*/

						// save tasks (phew)!

						// artillery
						private _saveData = [];
						private _abandonedBuildings = [];
						{
							_x params ["_zone","_taskID","_siteData","_samSiteData"];
							private _saveData2 = [];
							private _saveDataSams = [];
							{
								_x params ["_posWorld","_direction","_saveVehs","_buildings"];
								private _damage = 1;
								private _veh = objNull;
								if not ([] isEqualTo _saveVehs) then {
									_veh = _saveVehs select 0;
									if (not isNil "_veh"
									    and {not isNull _veh}
									    and {alive _veh}
									) then {
										_damage = damage _veh
									}
								};
								if (damage _veh < 1) then {
									private _type = typeOf _veh;
									private _cfgType = configFile >> "cfgVehicles" >> _type;
									// damage & repairs
									private _cfgHitPoints = _cfgType >> "HitPoints";
									private _hitPointArr = [];
									for "_i" from 0 to count _cfgHitPoints - 1 do {
										_cfgEntry = sel(_cfgHitPoints,_i);
										if (isClass _cfgEntry) then {
											private _configName = configName _cfgEntry;
											private _hitPoints = _veh getHitPointDamage _configName;
											_hitPointArr pushBack [_configName,_hitPoints];
										};
									};
									_saveData2 pushBack [_posWorld,_direction,_damage,_hitPointArr];
								} else {
									_abandonedBuildings append _buildings
								}
							} forEach _siteData;
							{
								// if sam is not destroyed, then save the position etc and rebuild on restart
								_sam = _x select 2;
								if (not isNull _sam and {damage _sam < 1}) then {
									_saveDataSams pushBack [
										_x select 0,
										_x select 1,
										typeOf _sam
									]
								}
							} forEach _samSiteData;
							if not ([] isEqualTo _saveData2) then {
								_saveData pushBack [str _zone,_taskID,_saveData2,_saveDataSams]
							};
						} forEach ncb_gv_ArtilleryPositions;
						diag_log format ["ncb_gv_ArtilleryPositions %1",ncb_gv_ArtilleryPositions];
						diag_log format ["_saveData %1",_saveData];
						["write",["artillery_0","zones",_saveData]] call ncb_gv_iniDbiArtillery;

						// air bases
						private _saveData = [];
						{
							_x params ["_zone","_taskID","_locName","_posASL","_objects","_vehicles"];
							private _zoneName = str _zone;
							private _objectData = [];
							{
								_objectData pushBack [
									typeOf _x,
									getPosWorld _x,
									getDir _x
								]
							} forEach _objects;
							private _vehicleData = [];
							{
								if (not isNull _x and {alive _x}) then {
									_vehicleData pushBack [
										typeOf _x,
										getPosWorld _x,
										getDir _x,
										damage _x
									]
								}
							} forEach _vehicles;
							if not ([] isEqualTo _vehicleData) then {
								_saveData pushBack [_zoneName,_taskID,_locName,_posASL,_objectData,_vehicleData]
							};
						} forEach ncb_gv_AirBasePositions;
						diag_log format ["ncb_gv_AirBasePositions %1",ncb_gv_AirBasePositions];
						diag_log format ["_saveData %1",_saveData];
						["write",["airbases","zones",_saveData]] call ncb_gv_iniDbiAirBases;

						// radio transmitters

						diag_log "DOING RADIO STUFF";

						private _saveData = [];
						{
							_x params ["_zone","_taskID","_taskBuildings","_siteData"];
							_siteData params ["_emplacementPos","_emplacementDir","_radioStationBuildings"];
							// siteData is [_emplacementPos,_emplacementDir,_radioStationBuildings]
							diag(_zone);
							diag(_taskID);
							diag(_taskBuildings);
							_aliveTaskBuildings = [];
							{
								diag(_x);
								diag(isNull _x);
								diag(alive _x);
								diag(typeOf _x);
								diag(damage _x);
								if (not isNull _x and {alive _x}) then {
									_aliveTaskBuildings pushBack [typeOf _x, damage _x]
								};
							} forEach _taskBuildings;
							diag(_aliveTaskBuildings);
							if not ([] isEqualTo _aliveTaskBuildings) then {
								_radioStationBuildings = _radioStationBuildings apply {typeOf _x};
								_siteData = [_emplacementPos,_emplacementDir,_radioStationBuildings];
								_saveData pushBack [str _zone,_taskID,_aliveTaskBuildings,_siteData];
							} else {
								_abandonedBuildings append _radioStationBuildings
							}
						} forEach ncb_gv_RadioTransPositions;
						diag(_saveData);
						["write",["radiotransmitters","zones",_saveData]] call ncb_gv_iniDbiRadioTransmitters;

						// abandoned buildings

						_count = 0;
						{
							if (not isNull _x and {alive _x} and {not (_x in _ammoBoxes)}) then {
								private _name = "abandonedBases_" + str _count;
								["write",[_name,"class",typeOf _x]] call ncb_gv_iniDbiAbandonedBases;
								["write",[_name,"position",getPosWorld _x]] call ncb_gv_iniDbiAbandonedBases;
								["write",[_name,"direction",getDir _x]] call ncb_gv_iniDbiAbandonedBases;
								["write",[_name,"vectorUp",vectorUp _x]] call ncb_gv_iniDbiAbandonedBases;
								["write",[_name,"damage",damage _x]] call ncb_gv_iniDbiAbandonedBases;
								_count = _count + 1;
							};
						} forEach _abandonedBuildings;

						//saveGame
						["write",["saveGame","saved",true]] call ncb_gv_iniDbiSaveGame;

						// remove from oef
						call horde_fnc_removeEachFrame;
						// end mission on server
						forceEnd;
						endMission "serverShutDown";
						serverCommand "#shutdown";
					};
				},
				0.001
			] call horde_fnc_updateEachFrameData
		}
	},
	0.001
] call horde_fnc_addEachFrame;