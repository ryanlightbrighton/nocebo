#include "\nocebo\defines\scriptDefines.hpp"
scriptName "sideMissionDestroyConvoyBoat";
private _notStarted = true;
private _convoyGrp = grpNull;
private _vehicles = [];
private _startZone = objNull;
private _endZone = objNull;
private _startLocName = "";
private _endLocName = "";
private _startPosition = [];
private _endPosition = [];
private _cfgWorld = configFile >> "CfgZones" >> worldName;
private _zones = + ncb_gv_zoneList;
_zones = _zones - ncb_gv_missionAirBaseZones;
_zones = _zones select {
	not (_x getVariable ["zoneHasRadioInstallation",false])
	and {not (_x getVariable ["zoneHasArtilleryEmplacement",false])}
	and {not ([] isEqualTo getArray (_cfgWorld >> str _x >> "VehicleSpawnData" >> "mooringDataASL"))}
	and {not ([] isEqualTo getArray (_cfgWorld >> str _x >> "ClosestLocations" >> "locations"))}
};
if not empty(_zones) then {
	scopeName "root";
	for "_i" from 0 to count _zones - 1 do {
		_zone = _zones deleteAt (floor random count _zones);
		if not ([_zone,1000] call horde_fnc_playerIsNear) then {
			private _cfgZone = configFile >> "CfgZones" >> worldName >> str _zone;
			scopeName "mooring";
			{
				private _name = _x select 1;
				private _mooringPos = _x select 2;
				{
					if (_mooringPos distance2D (_x select 1) < 250) exitWith {
						_startZone = _zone;
						_startLocName = _name;
						_startPosition = _x select 1;
						_startPosition set [2,0];
						breakTo "mooring"
					}
				} count getArray (_cfgZone >> "VehicleSpawnData" >> "mooringDataASL");
				nil
			} count getArray (_cfgZone >> "ClosestLocations" >> "locations");
			if not ([] isEqualTo _startPosition) then {
				// hmm this startposition is rubbish (boats crash like idiots)
				private _fnc_noLand = {
					private _noLand = true;
					for "_i" from 0 to 350 step 10 do {
						if (getTerrainHeightASL (_this getPos [100,_i]) > 0) exitWith {
							_noLand = false
						};
					};
					_noLand
				};
				for "_c" from 0 to 350 step 10 do {
					_tPos = _startPosition getPos [110,_c];
					if (_tPos call _fnc_noLand
						and {getTerrainHeightASL _tPos < -10}
					) exitWith {
						_startPosition = _tPos
					}
				};
				_startPosition set [2,0];
				// find end zone
				_otherZones = _zones - [_startZone];
				_zone = _otherZones deleteAt (floor random count _otherZones);
				private _cfgZone = configFile >> "CfgZones" >> worldName >> str _zone;
				scopeName "mooring2";
				{
					private _name = _x select 1;
					private _mooringPos = _x select 2;
					{
						if (_mooringPos distance2D (_x select 1) < 250) exitWith {
							_endZone = _zone;
							_endLocName = _name;
							_endPosition = _x select 1;
							_endPosition set [2,0];
							breakTo "mooring2"
						}
					} count getArray (_cfgZone >> "VehicleSpawnData" >> "mooringDataASL");
					nil
				} count getArray (_cfgZone >> "ClosestLocations" >> "locations");
				if not ([] isEqualTo _endPosition) then {

					_notStarted = false;

					// spawn convoy (3 vehicles)

					_classes =  [
						"ncb_boat_speedboat_minigun",
						"ncb_boat_speedboat_hmg"
					];

					private _cfgVehicles = configFile >> "CfgVehicles";
					for "_m" from 0 to 2 do {

						// veh

						_veh = createVehicle [selectRandom _classes,([_startPosition,10,100,10,2,0,0] call bis_fnc_findSafePos),[],0,"can_collide"];
						_veh setDir (_startPosition getDir _veh);
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
						private _initScript = getText (_cfgVehicles >> (typeOf _veh) >> "initScript");
						if not (_initScript isEqualTo "") then {
							[_veh,"new"] call (missionNamespace getVariable _initScript);
						};
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

						/*_veh setConvoySeparation 50;*/
					};

					_convoyGrp setGroupIDGlobal [format ["sm_destroyConvoyBoat_%1",_convoyGrp]];

					private _shippingLanes = [];
					{
						if (_x find "shipping_lane" > -1) then {
							_shippingLanes pushBack _x
						};
						nil
					} count allMapMarkers;

					_endPosition = [_endPosition,10,100,10,2,0,0] call bis_fnc_findSafePos;
					_endPosition set [2,0];

					private _handle = [
						_convoyGrp,
						_startPosition,
						_endPosition,
						1000,
						5,
						false,
						_shippingLanes
					] spawn horde_fnc_waypointFinder;

					waitUntil {
						sleep 1;
						scriptDone _handle
					};

					/*{
						_x setDir (_x getDir (waypointPosition [_convoyGrp,1]));
					} forEach _vehicles;*/

					breakTo "root"
				}
			}
		}
	};
	if not (isNull _convoyGrp) then {

		// task

		_convoyName = toUpper (selectRandom ncb_gv_alphabet + selectRandom ncb_gv_alphabet + "-" + str floor random 10 + str floor random 10);
		_statement = format ["Naval convoy en-route from %1 to %2.  Stop the convoy and kill all the occupants.",_startLocName,_endLocName];
		private _taskID = [
			"DB" + (str _startZone) + (str _endZone), // params
			true, // target
			[_statement,format ["Destroy Naval Convoy %1",_convoyName],"convoyMkr"], // desc
			objNull, // no marker
			"CREATED", // state
			0, // priority
			true, // showNotification
			true, // isGlobal
			"destroy", // type
			false // shared
		] call BIS_fnc_setTask;
		hint parsetext "<t align='center'><t size='2.2'>New Side Mission</t><br/><t size='1.5' color='#00B2EE'>Destroy Naval Convoy</t><br/>____________________<br/>There is an ememy naval convoy possibly containing useful materiel.  Destroy it to liberate the useful equipment.</t>";

		// conds

		[_vehicles,_convoyGrp,_endPosition,_taskID,_convoyName,round time + 900] spawn {
			params ["_vehicles","_convoyGrp","_endPosition","_taskID","_convoyName","_timeout"];
			scriptName "sideMissionDestroyConvoyBoat";

			// create marker

			private _mkr = createMarker [str _convoyGrp + (str round time),getPosWorld leader _convoyGrp];
			_mkr setMarkerSize [1,1];
			_mkr setMarkerType "o_naval";
			_mkr setMarkerAlpha 1;
			_mkr setMarkerColor "ColorRed";
			_mkr setMarkerText format ["%1",_convoyName];

			private _mkr2 = createMarker [str _convoyGrp + (str round time) + str 2,_endPosition];
			_mkr2 setMarkerSize [0.9,0.9];
			_mkr2 setMarkerType "o_unknown";
			_mkr2 setMarkerAlpha 1;
			_mkr2 setMarkerColor "ColorRed";
			_mkr2 setMarkerText format ["%1 destination",_convoyName];

			_allDead = false;
			_arrived = false;
			_tooLong = false;
			_deleted = false;
			// save wheel names as a variable on the vehicle - makes it easier to check later on in this script
			private _fnc_isIntersect = {
				private _stuck = false;
				for "_i" from 0 to 315 step 45 do {
					private _intersects = lineIntersectsSurfaces [
						getPosASL _x,
						getPosASL _x vectorAdd [
							(sin _i) * 15,
							(cos _i) * 15,
							0
						],
						_this
					];
					if not ([] isEqualTo _intersects) exitWith {
						_stuck = true
					};
				};
				_stuck
			};
			waitUntil {
				sleep 5;
				_deleted = false;
				{
					if (vectorMagnitude velocity _x < 1
					    and {_x distance _endPosition > 200}
					    and {_x call _fnc_isIntersect}
					    and {not ([getPosASL _x,1000] call horde_fnc_playerIsNear)}
					) then {
						_deleted = true;
						{
							_x setDamage 1
						} count crew _x;
						deleteVehicle _x
					}
				} count _vehicles;
				_mkr setMarkerPos (getPosWorld leader _convoyGrp);
				_numAlive = {alive _x} count units _convoyGrp;
				_allDead = _numAlive == 0;
				_arrived = {alive _x and {_x distance _endPosition < 200}} count units _convoyGrp == _numAlive;
				_tooLong = time > _timeout;
				_allDead or {_arrived} or {_tooLong}
			};
			deleteMarker _mkr;
			deleteMarker _mkr2;
			if (_allDead and {not _deleted}) exitWith {
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
					[_vehicles,_convoyGrp,_endPosition],{
						call horde_fnc_getEachFrameArgs params ["_vehicles","_convoyGrp","_endPosition"];
						if not ([_endPosition,1000] call horde_fnc_playerIsNear) then {
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
			if (_tooLong or {_deleted}) exitWith {
				// task abandoned
				[
					[_vehicles,_convoyGrp,_endPosition],{
						call horde_fnc_getEachFrameArgs params ["_vehicles","_convoyGrp","_endPosition"];
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