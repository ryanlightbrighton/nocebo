#include "\nocebo\defines\scriptDefines.hpp"
scriptName "sideMissionDestroyArmouredColumn";
private _notStarted = true;
private _convoyGrp = grpNull;
private _vehicles = [];
private _startZone = objNull;
private _endZone = objNull;
private _startRoads = [];
private _endRoad = objNull;
private _startLocName = "";
private _endLocName = "";
if not empty(ncb_gv_zonesWithEmptySpace) then {
	scopeName "root";
	_zonesWithEmptySpace = + ncb_gv_zonesWithEmptySpace;
	for "_i" from 0 to count _zonesWithEmptySpace - 1 do {
		_startZone = _zonesWithEmptySpace deleteAt (floor random count _zonesWithEmptySpace);
		private _cfgZone = configFile >> "CfgZones" >> worldName >> str _startZone;
		private _locations = getArray (_cfgZone >> "ClosestLocations" >> "locations");
		_locations = _locations select {not (toLower (_x select 0) in ["namemarine","hill","mount"])};
		if not ([] isEqualTo _locations) then {
			for "_j" from 0 to count _locations - 1 do {
				(_locations deleteAt (floor random count _locations)) params ["","_locName","_position"];
				_startLocName = _locName;
				if (not ([_position,1000] call horde_fnc_playerIsNear)) then {
					// find a free section of road
					_startRoads = [];
					{
						_connectedRoads = roadsConnectedTo _x;
						if (count _connectedRoads == 2) exitWith {
							_startRoads = [_connectedRoads select 0,_x,_connectedRoads select 1]
						}
					} forEach ((_position getPos [random 300,random 360]) nearRoads 500);

					if not ([] isEqualTo _startRoads) then {
						// now look for end positions
						_otherZones = + ncb_gv_zonesWithEmptySpace;
						_otherZones = _otherZones - [_startZone];
						for "_k" from 0 to count _otherZones - 1 do {
							/*_endZone = selectRandom _otherZones;*/
							_endZone = _otherZones deleteAt (floor random count _otherZones);
							private _cfgZone = configFile >> "CfgZones" >> worldName >> str _endZone;
							private _locations = getArray (_cfgZone >> "ClosestLocations" >> "locations");
							_locations = _locations select {not (toLower (_x select 0) in ["namemarine","hill","mount"])};
							if not ([] isEqualTo _locations) then {
								for "_l" from 0 to count _locations - 1 do {
									(_locations deleteAt (floor random count _locations)) params ["","_locName","_position"];
									_endLocName = _locName;
									if not ([getPos (_startRoads select 0),_position,500] call horde_fnc_waterBetweenPoints) then {
										// find a free section of road
										_endRoads = ((_position getPos [random 300,random 360]) nearRoads 500);
										if not ([] isEqualTo _endRoads) exitWith {
											_notStarted = false;
											_endRoad = selectRandom _endRoads;

											_startRoads = [_startRoads,_endRoad] call horde_fnc_sortByDistance;

											// spawn convoy (2 vehicles)

											_classes = selectRandom [
												[
													"ncb_veh_kamysh"
												],
												[
													"ncb_veh_tigris"
												],
												[
													"ncb_veh_varsuk"
												]
											];

											for "_m" from 0 to 1 do {
												_road = _startRoads select _m;

												// veh

												_veh = createVehicle [selectRandom _classes,(ASLtoAGL getPosASL _road) vectorAdd [0,0,1],[],0,"can_collide"];
												_connRoads = roadsConnectedTo _road;
												if (count _connRoads == 1) then {
													_ret = [[_road,(_connRoads select 0)],_endRoad] call horde_fnc_sortByDistance;
													_veh setDir ((_ret select 1) getDir (_ret select 0));
												} else {
													_ret = [[(_connRoads select 0),(_connRoads select 1)],_endRoad] call horde_fnc_sortByDistance;
													_veh setDir ((_ret select 1) getDir (_ret select 0));
												};
												/*_veh setVehicleLock "LOCKED";*/
												if (ncb_param_aiDisableVehicleVisionNV) then {
													_veh disableNVGEquipment true
												};
												if (ncb_param_aiDisableVehicleVisionTI) then {
													_veh disableTIEquipment true
												};
												_veh addEventHandler ["getout", {
													params ["_veh","","_unit"];
													if (alive _veh and {{if (alive _x) exitWith {1}} count crew _veh isEqualTo 0}) then {
														_veh setVariable ["vehicleAbandonedTime",round time];
														ncb_gv_abandonedVehicles pushBackUnique _veh;
													};
												}];
												_veh addEventHandler ["getin", {
													params ["_veh"];
													if same({alive _x} count crew _veh,1) then {
														_veh setVariable ["vehicleAbandonedTime",nil];
													};
												}];
												_veh addEventHandler ["reloaded", {
													_this call horde_fnc_autoReloadVehWeap
												}];
												_veh call horde_fnc_addExtraVehicleMags;
												_veh allowCrewInImmobile true;
												_veh setUnloadInCombat [false,false];

												_vehicles pushBack _veh;

												// crew
												if (isNull _convoyGrp) then {
													_convoyGrp = createGroup east;
												};
												{
													private _unit = ncb_gv_enemyUnitPool deleteAt 0;
													[_unit] joinSilent _convoyGrp;
													_unit enableSimulationGlobal true;
													_unit hideObjectGlobal false;
													if (_x isEqualTo [-1]) then {
														_unit moveInDriver _veh
													} else {
														_unit moveInTurret [_veh,_x]
													};
													[_unit,true] call horde_fnc_allowDamageGlobal;
													_unit enableAI "checkVisible";
												} count [[-1]] + allTurrets [_veh,true];
											};

											_convoyGrp setGroupIDGlobal [format ["sm_destroyArmrdCnvy_%1",_convoyGrp]];

											private _wp = _convoyGrp addWaypoint [getPos _endRoad,40];
											_wp setWaypointBehaviour "careless";
											_wp setWaypointFormation "column";
											_wp setWaypointSpeed "normal";
											_wp setWaypointType "move";

											breakTo "root"
										}
									}
								}
							}
						}
					}
				}
			}
		}
	};
	if not (isNull _convoyGrp) then {

		// task

		_convoyName = toUpper (selectRandom ncb_gv_alphabet + selectRandom ncb_gv_alphabet + "-" + str floor random 10 + str floor random 10);
		_statement = format ["Armoured column en-route from %1 to %2.  Stop the vehicles and kill all the occupants.  They may have important documents on the vehicles so be sure to search them if you can.",_startLocName,_endLocName];
		private _taskID = [
			"DC" + (str _startZone) + (str _endZone), // params
			true, // target
			[_statement,format ["Destroy Armoured Column %1",_convoyName],"convoyMkr"], // desc
			objNull, // no marker
			"CREATED", // state
			0, // priority
			true, // showNotification
			true, // isGlobal
			"destroy", // type
			false // shared
		] call BIS_fnc_setTask;
		hint parsetext "<t align='center'><t size='2.2'>New Side Mission</t><br/><t size='1.5' color='#00B2EE'>Destroy Armoured Column</t><br/>____________________<br/>There is an ememy armoured column on the island possibly containing useful materiel.  Destroy it to liberate the useful equipment.</t>";

		// conds

		[_vehicles,_convoyGrp,_endRoad,_taskID,_convoyName,round time + 1200] spawn {
			params ["_vehicles","_convoyGrp","_endRoad","_taskID","_convoyName","_timeout"];
			scriptName "sideMissionDestroyArmouredColumn";

			// create marker

			private _mkr = createMarker [str _convoyGrp + (str round time),getPosWorld leader _convoyGrp];
			_mkr setMarkerSize [1,1];
			_mkr setMarkerType "o_armor";
			_mkr setMarkerAlpha 1;
			_mkr setMarkerColor "ColorRed";
			_mkr setMarkerText format ["%1",_convoyName];

			private _mkr2 = createMarker [str _convoyGrp + (str round time) + str 2,getPosWorld _endRoad];
			_mkr2 setMarkerSize [0.9,0.9];
			_mkr2 setMarkerType "o_unknown";
			_mkr2 setMarkerAlpha 1;
			_mkr2 setMarkerColor "ColorRed";
			_mkr2 setMarkerText format ["%1 destination",_convoyName];

			_allDead = false;
			_arrived = false;
			_tooLong = false;
			// save track names as a variable on the tank - makes it easier to check later on in this script

			{
				private _tracks = [];
				{
					if (toLower _x find "track" > -1) then {
						_tracks pushBack _x
					}
				} forEach ((getAllHitPointsDamage _x) select 0);
				_x setVariable ["ncb_tracks",_tracks]
			} count _vehicles;
			waitUntil {
				sleep 5;
				_mkr setMarkerPos (getPosWorld leader _convoyGrp);
				_numAlive = {alive _x} count units _convoyGrp;
				_allDead = _numAlive == 0;
				_arrived = {alive _x and {_x distance _endRoad < 200}} count units _convoyGrp == _numAlive;
				_tooLong = time > _timeout;
				if not (_allDead) then {
					{
						private _veh = _x;
						if (alive _veh
						    and {{alive _x and {not isPlayer _x}} count crew _veh > 0}
							and {not ([_x,1000] call horde_fnc_playerIsNear)}
						) then {
							{
								if (_veh getHitPointDamage _x > 0) exitWith {
									_veh setHitPointDamage [_x,0,false]
								}
							} count (_veh getVariable ["ncb_tracks",[]])
						};
						true
					} count _vehicles;
				};
				_allDead or {_arrived} or {_tooLong}
			};
			deleteMarker _mkr;
			deleteMarker _mkr2;
			if (_allDead) exitWith {
				// task complete
				[_taskID,"succeeded"] call BIS_fnc_taskSetState;
				{
					if (alive _x) exitWith {
						_x addWeaponCargoGlobal (selectRandom [
							["ghosthawkCASAccessCode",1],
							["ghosthawkCASAccessCode",1],
							["wipeoutCASAccessCode",1],
							["greyhawkCASAccessCode",1],
							["blackfishCASAccessCode",1]
						])
					}
				} count (_vehicles call horde_fnc_arrayShuffle);
				[
					[],
					{
						call horde_fnc_sideMissionManager;
						call horde_fnc_removeEachFrame
					},
					ncb_param_sideMissionInterval
				] call horde_fnc_addEachFrame
			};
			if (_arrived) exitWith {
				// task failed
				[_taskID,"failed"] call BIS_fnc_taskSetState;
				[
					[_vehicles,_convoyGrp,_endRoad],{
						call horde_fnc_getEachFrameArgs params ["_vehicles","_convoyGrp","_endRoad"];
						if not ([getPos _endRoad,1000] call horde_fnc_playerIsNear) then {
							_convoyGrp call horde_fnc_cacheGroup;
							{if ({isPlayer _x} count crew _x == 0) then {deleteVehicle _x}} count _vehicles;
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
			};
			if (_tooLong) exitWith {
				// task abandoned
				[
					[_vehicles,_convoyGrp,_endRoad],{
						call horde_fnc_getEachFrameArgs params ["_vehicles","_convoyGrp","_endRoad"];
						if not ([getPos leader _convoyGrp,1000] call horde_fnc_playerIsNear) then {
							_convoyGrp call horde_fnc_cacheGroup;
							{if ({isPlayer _x} count crew _x == 0) then {deleteVehicle _x}} count _vehicles;
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
				[_taskID,"canceled"] call BIS_fnc_taskSetState;
			};
		}
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

