#include "\nocebo\defines\scriptDefines.hpp"
scriptName "sideMissionHumanBomb";
private _notStarted = true;
private _grps = [];
private _hostageGrp = grpNull;
private _position = [];
private _zone = objNull;
private _building = objNull;
private _buildingPosition = [];
private _cfgVeh = configFile >> "CfgVehicles";
if not empty(ncb_gv_zonesWithEmptySpace) then {
	scopeName "root";
	_zonesWithEmptySpace = + ncb_gv_zonesWithEmptySpace;
	for "_i" from 0 to count _zonesWithEmptySpace - 1 do {
		_zone = _zonesWithEmptySpace deleteAt (floor random count _zonesWithEmptySpace);
		private _cfgZone = configFile >> "CfgZones" >> worldName >> str _zone;
		private _landMassCount = getNumber (_cfgZone >> "landMassCount");
		private _locations = getArray (_cfgZone >> "ClosestLocations" >> "locations");
		_locations = _locations select {not (toLower (_x select 0) in ["namemarine","hill","mount"])};
		if not ([] isEqualTo _locations) then {
			for "_j" from 0 to count _locations - 1 do {
				(_locations deleteAt (floor random count _locations)) params ["","_locName","_position"];
				if (not ([_position,1000] call horde_fnc_playerIsNear)) then {
					private _buildings = nearestTerrainObjects [_position getPos [random 200,random 360],["BUILDING","HOUSE","CHURCH","CHAPEL","BUNKER","FORTRESS","FUELSTATION","HOSPITAL","POWERSOLAR","POWERWAVE","POWERWIND"],100,false];
					_buildings = _buildings select {count getArray (_cfgVeh >> typeOf _x >> "unitData") > 6};
					_buildings = _buildings select {count (_x buildingPos -1) > 2};
					if not ([] isEqualTo _buildings) then {
						_building = _buildings deleteAt (floor random count _buildings);
						_buildingPosition = ASLToAGL getPosASL _building;
						// hostages
						_fnc_clearPos = {
							params ["_pos","_obj"];
							private _free = true;
							if (lineIntersects [
								AGLtoASL _pos,
								AGLtoASL _pos vectorAdd [0,0,2],
								_obj
							]) exitWith {
								false
							};
							private _dist = 1.5;
							for "_ang" from 0 to 315 step 45 do {
								if (lineIntersects [
									AGLtoASL _pos vectorAdd [0,0,1],
									AGLtoASL _pos vectorAdd [(sin _ang) * _dist,(cos _ang) * _dist,1]
								]) exitWith {
									_free = false
								}
							};
							_free
						};
						_buildingPositions = _building buildingPos -1;
						_buildingPositions = _buildingPositions select {[_x,_building] call _fnc_clearPos};
						if (count _buildingPositions > 2) exitWith {
							_notStarted = false;
							_hostageGrp = createGroup [civilian,false];
							for "_k" from 1 to 3 do {
								_hostagePos = _buildingPositions deleteAt (floor random count _buildingPositions);
								private _hostage = _hostageGrp createUnit [
									"ncb_unit_hostage",
									_hostagePos,
									[],
									0,
									"can_collide"
								];
								{
									_hostage disableAI _x
								} forEach ["target","path","autotarget","fsm","weaponaim","teamswitch","suppression","cover","checkvisible","autocombat","minedetection"];

								_hostage setDir (random 360);
								_hostage setPosASL AGLToASL _hostagePos;
							};
							_hostageGrp enableDynamicSimulation true;

							_hostageGrp setGroupIDGlobal [format ["sm_humanBomb_%1",_hostageGrp]];

							// static units

							private _buildingPositions = getArray (_cfgVeh >> typeOf _building >> "unitData");

							private _grp = createGroup east;

							private _count = (count _buildingPositions - 1) min 6;

							for "_i" from 0 to _count do {
								(_buildingPositions deleteAt (floor random count _buildingPositions)) params ["_spawnPos","_dir","_lookAroundData"];
								_spawnPos = _building modelToWorld _spawnPos;
								private _unit = ncb_gv_enemySniperPool deleteAt 0;
								[_unit] joinSilent _grp;
								_unit enableSimulationGlobal true;
								_unit hideObjectGlobal false;
								_unit doWatch (_building getPos [400,(_dir + getDir _building)]);
								_unit setPosASL AGLToASL _spawnPos;
								[_unit,true] call horde_fnc_allowDamageGlobal;
								_unit disableAI "path";
								_unit enableAI "checkVisible";
								_unit doWatch ((_building getPos [300,_building getDir _unit]) vectorAdd [0,0,10])
							};
							_grps pushBack (netID _grp);
							_grp enableDynamicSimulation true;
							_grp setGroupIDGlobal [format ["sm_humanBomb_%1",_grp]];

							// defensive squads

							for "_i" from 0 to (floor random 1) + 1 do {
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
								_grp setGroupIDGlobal [format ["sm_humanBomb_%1",_grp]];
								sleep 1
							};
							breakTo "root"
						}
					}
				}
			}
		}
	};
	if not (isNull _hostageGrp) then {

		// task

		private _statement = format ["Antagonists have taken some prisoners and rigged bombs to explode if anyone gets too close too fast.  They are believed to be at Grid: %1.", mapGridPosition _buildingPosition];
		private _taskID = [
			"HB" + (str _zone), // params
			true, // target
			[_statement,"Disarm human bombs",_statement], // desc
			_buildingPosition, // dest
			"CREATED", // state
			0, // priority
			true, // showNotification
			true, // isGlobal
			"help", // type
			false // shared
		] call BIS_fnc_setTask;
		hint parsetext "<t align='center'><t size='2.2'>New Side Mission</t><br/><t size='1.5' color='#00B2EE'>Disarm the human bombs</t><br/>____________________<br/>Antagonists have taken some prisoners and strapped bombs to them.  Disarm the bombs to free them.</t>";

		// conds

		private _bombs = [];

		{
			// setVectorDirAndUp is execed over the network because it does not broadcast on ammo classes spawned as vehicles.
			_bomb1 = "DemoCharge_Remote_Ammo_Scripted" createVehicle (position _x);
			_bomb1 attachTo [_x, [-0.1,0.1,0.15],"Pelvis"];
			[_bomb1,[[0.5,0.5,0],[-0.5,0.5,0]]] remoteExecCall [
				"setVectorDirAndUp",
				0,
				_bomb1
			];
			_bomb2 = "DemoCharge_Remote_Ammo_Scripted" createVehicle (position _x);
			_bomb2 attachTo [_x, [0,0.15,0.15],"Pelvis"];
			[_bomb2,[[1,0,0],[0,1,0]]] remoteExecCall [
				"setVectorDirAndUp",
				0,
				_bomb2
			];
			_bomb3 = "DemoCharge_Remote_Ammo_Scripted" createVehicle (position _x);
			_bomb3 attachTo [_x, [0.1,0.1,0.15],"Pelvis"];
			[_bomb3,[[0.5,-0.5,0],[0.5,0.5,0]]] remoteExecCall [
				"setVectorDirAndUp",
				0,
				_bomb3
			];
			{_bombs pushBack _x,true} count[_bomb1,_bomb2,_bomb3];
			// first EH relates to blowing up and triggering the other bombs
			// only if there are bombs on this man then it triggers the others
			_x addEventHandler ["killed",
				format [
					"[_this select 0,%1] call {
						params ['_unit','_data'];
						_data params ['_building','_buildingPosition'];
						_building = objectFromNetId _building;
						private _grp = group _unit;
						private _bombs = attachedObjects _unit;
						_bombs = _bombs - [objNull];
						if not (_bombs isEqualTo []) then {
							{_x removeAllEventHandlers 'killed'} count units _grp;
							{
								_unit = _x;
								private _startPos = getPosASL _unit;
								private _bombs = attachedObjects _unit;
								_bombs = _bombs - [objNull];
								if not (_bombs isEqualTo []) then {
									{_x setDamage 1} count _bombs;
									deleteVehicle _unit;
									private _cfgBuilding = configFile >> 'CfgVehicles' >> typeOf _building;
									if (not isClass (_cfgBuilding >> 'DestructionEffects' >> 'Ruin1')
										and {getText(_cfgBuilding >> 'replacedamaged') == ''}
									) then {
										private _pool = createVehicle [selectRandom ['BloodPool_01_Large_New_F','BloodSplatter_01_Large_New_F'],_startPos,[],0,'can_collide'];
										_pool setDir random 360;
										_pool setPosASL (_startPos vectorAdd [0,0,0.005]);
										_pool setVariable ['deadDeleteTime',(round time) + 300];
										ncb_gv_garbageContents pushBack _pool;
										for '_i' from 0 to ((round random 12) + 24) do {
											private _intersects = lineIntersectsSurfaces [
												_startPos vectorAdd [0,0,0.2],
												_startPos vectorAdd [random 40 - 20,random 40 - 20,random 30 max 0.5],
												objNull,
												objNull,
												true,
												1,
												'FIRE',
												'NONE'
											];
											if not ([] isEqualTo _intersects) then {
												_intersects select 0 params ['_posASL','_normal','','_object'];
												if (_object isKindOf 'static') then {
													_pool = createVehicle [selectRandom ['BloodPool_01_Medium_New_F','BloodSplatter_01_Small_New_F'],ASLtoAGL _posASL,[],0,'can_collide'];
													_pool setDir (random 360);
													_pool setPosASL _posASL;
													_pool setVectorUp _normal;
													_pool setVariable ['deadDeleteTime',(round time) + 300];
													ncb_gv_garbageContents pushBack _pool;
												}
											}
										}
									}
								}
							} forEach units _grp;
						}
					}",
					[netId _building,_buildingPosition]
				]
			];
		} forEach units _hostageGrp;

		[_hostageGrp,_bombs,_building,_taskID,_grps,_buildingPosition] spawn {
			params ["_grp","_bombs","_building","_taskID","_grps","_buildingPosition"];
			scriptName "sideMissionHumanBomb";
			waitUntil {
				sleep 0.1;
				{
					private _unit = _x;
					if (alive _unit) then {
						private _entities = (_unit nearEntities ["AllVehicles",7]) - [_unit];
						if not (_entities isEqualTo []) then {
							_entities = _entities apply {[_x distance _unit,_x]};
							_entities sort true;
							_entities = _entities apply {_x select 1};
							_unit setDir (_unit getDir (_entities select 0));
						};
						if (not (attachedObjects _unit isEqualTo [])
							and {{vectorMagnitude velocity _x > 200 and {not lineIntersects [eyePos _unit,getPosASL _x,_x]}} count (_entities) > 0}
						) then {
							_unit setDamage 1
						}
					}
				} forEach units _grp;
				{alive _x} count _bombs == 0 or {{alive _x} count units _grp < 3}
			};
			if ({alive _x} count units _grp == 3) then {
				{_x removeAllEventHandlers 'killed'} count units _grp;
				// task succeeded
				[_taskID,"succeeded"] call BIS_fnc_taskSetState;
				[
					[_buildingPosition,_grps,_grp],{
						call horde_fnc_getEachFrameArgs params ["_buildingPosition","_grps","_grp"];
						if not ([_buildingPosition,1000] call horde_fnc_playerIsNear) then {
							{
								(groupFromNetId _x) call horde_fnc_cacheGroup
							} count _grps;
							{
								{
									deleteVehicle _x
								} count attachedObjects _x;
								deleteVehicle _x;
							} count units _grp;
							_grp call horde_fnc_deleteGroupGlobal;
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
				// give players a cookie
				private _nearestPlayer = objNull;
				private _unit = objNull;
				private _dist = 9999;
				{
					private _players = _x nearEntities ["ncb_player_base",10];
					if not ([] isEqualTo _players) then {
						if (_x distance (_players select 0) < _dist) then {
							_dist = _x distance (_players select 0);
							_unit = _x;
							_nearestPlayer = _players select 0
						}
					}
				} forEach ((units _grp) select {alive _x});
				_unit doWatch _nearestPlayer;
				if (not isNull _nearestPlayer) then {
					_unit setDir (_unit getDir _nearestPlayer);
					_unit SwitchMove "";
					_unit playActionNow "PutDown";
					_nearestPlayer addItem selectRandom [
						"ghosthawkCASAccessCode",
						"ghosthawkCASAccessCode",
						"wipeoutCASAccessCode",
						"greyhawkCASAccessCode",
						"blackfishCASAccessCode"
					];
					["TaskSucceeded",["You received a document","You received a document"]] remoteExecCall [
						"BIS_fnc_showNotification",
						_nearestPlayer
					];
					{
					private _unit = _x;
					{
						_unit enableAI _x
					} count ["target","path","autotarget","fsm","weaponaim","teamswitch","suppression","cover","checkvisible","autocombat","minedetection"];
					_unit doMove [0,0,0]
				} count units _grp;
				}
			} else {
				[_taskID,"failed"] call BIS_fnc_taskSetState;
				[
					[_buildingPosition,_grps,_grp],{
						call horde_fnc_getEachFrameArgs params ["_buildingPosition","_grps","_grp"];
						if not ([_buildingPosition,1000] call horde_fnc_playerIsNear) then {
							{
								(groupFromNetId _x) call horde_fnc_cacheGroup
							} count _grps;
							{
								{
									deleteVehicle _x
								} count attachedObjects _x;
								deleteVehicle _x;
							} count units _grp;
							_grp call horde_fnc_deleteGroupGlobal;
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
			}
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


// {_x removeEventHandler ['killed',1]} count units _grp;