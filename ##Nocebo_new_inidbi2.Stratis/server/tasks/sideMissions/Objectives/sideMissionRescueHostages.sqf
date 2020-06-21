#include "\nocebo\defines\scriptDefines.hpp"
scriptName "sideMissionRescueHostages";
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

								[_hostage,"Acts_ExecutionVictim_Loop"] remoteExecCall [
									"horde_fnc_switchMoveGlobal",
									0
								];
								_hostage setDir (random 360);
								_hostage setPosASL AGLToASL _hostagePos;
							};
							_hostageGrp enableDynamicSimulation true;

							_hostageGrp setGroupIDGlobal [format ["sm_rescueHostages_%1",_hostageGrp]];

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
							};
							_grps pushBack (netID _grp);
							_grp enableDynamicSimulation true;
							_grp setGroupIDGlobal [format ["sm_rescueHostages_%1",_grp]];

							// defensive squads

							for "_i" from 0 to (floor random 1) + 1 do {
								/*private _spawnPos = _buildingPosition getPos [8,random 360];*/
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
								_grp setGroupIDGlobal [format ["sm_rescueHostages_%1",_grp]];
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

		private _statement = format ["Antagonists have taken some hostages.  They are believed to be at Grid: %1.", mapGridPosition _buildingPosition];
		private _taskID = [
			"HR" + (str _zone), // params
			true, // target
			[_statement,"Rescue Hostages",_statement], // desc
			_buildingPosition, // dest
			"CREATED", // state
			0, // priority
			true, // showNotification
			true, // isGlobal
			"help", // type
			false // shared
		] call BIS_fnc_setTask;
		hint parsetext "<t align='center'><t size='2.2'>New Side Mission</t><br/><t size='1.5' color='#00B2EE'>Free the hostages</t><br/>____________________<br/>Antagonists have taken some hostages with important information.  Free them to get the information.</t>";

		// conds

		{
			_x addEventHandler ["killed",
				format [
					"[_this select 0,%1] call {
						params ['_unit','_data'];
						_data params ['_buildingPosition','_grps','_id'];
						[_id,'failed'] call BIS_fnc_taskSetState;
						{_x removeAllEventHandlers 'animChanged'} count units group _unit;
						{_x removeAllEventHandlers 'killed'} count units group _unit;
						[
							[_buildingPosition,_grps,_id,group _unit],{
								call horde_fnc_getEachFrameArgs params ['_buildingPosition','_grps','_id','_grp'];
								if not ([_buildingPosition,1000] call horde_fnc_playerIsNear) then {
									{
										(groupFromNetId _x) call horde_fnc_cacheGroup
									} count _grps;
									{
										deleteVehicle _x
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
					}",
					[_buildingPosition,_grps,_taskID]
				]
			];
			_x addEventHandler ["animChanged",
				format [
					"if (alive (_this select 0)) then {
						[_this select 0,%1] call {
							params ['_unit','_data'];
							_data params ['_buildingPosition','_grps','_id'];
							_unit setVariable ['ncb_freed',true];
							_unit removeAllEventHandlers 'animChanged';
							_unit removeAllEventHandlers 'killed';
							if ({_x getVariable ['ncb_freed',false]} count units group _unit == count units group _unit) then {
								_unit addEventHandler ['animDone',{
									params ['_unit','_anim'];
									private _nearestPlayer = (_unit nearEntities ['ncb_player_base',10]) select 0;
									_unit doWatch _nearestPlayer;
									if (alive _unit) then {
										if (_anim == 'Acts_ExecutionVictim_Unbow') then {
											_unit setDir (_unit getDir _nearestPlayer);
											_unit SwitchMove '';
											_unit playActionNow 'PutDown';
										};
										if (_anim == 'ainvpercmstpsnonwnondnon_putdown_amovpercmstpsnonwnondnon') then {
											{_x removeAllEventHandlers 'animChanged'} count units group _unit;
											_nearestPlayer addItem selectRandom [
												'ghosthawkCASAccessCode',
												'ghosthawkCASAccessCode',
												'wipeoutCASAccessCode',
												'greyhawkCASAccessCode',
												'blackfishCASAccessCode'
											];
											['TaskSucceeded',['You received a document','You received a document']] remoteExecCall [
												'BIS_fnc_showNotification',
												_nearestPlayer
											];
											{
												_unit enableAI _x
											} count ['target','path','autotarget','fsm','weaponaim','teamswitch','suppression','cover','checkvisible','autocombat','minedetection'];
											_unit doMove [0,0,0]
										};
									}
								}];
								[_id,'Succeeded'] call BIS_fnc_taskSetState;
								[
									[_buildingPosition,_grps,group _unit],{
										call horde_fnc_getEachFrameArgs params ['_buildingPosition','_grps','_grp'];
										if not ([_buildingPosition,1000] call horde_fnc_playerIsNear) then {
											{
												(groupFromNetId _x) call horde_fnc_cacheGroup
											} count _grps;
											{
												deleteVehicle _x
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
							} else {
								{
									_unit enableAI _x
								} count ['target','path','autotarget','fsm','weaponaim','teamswitch','suppression','cover','checkvisible','autocombat','minedetection'];
								_unit doMove [0,0,0]
							}
						}
					}",
					[_buildingPosition,_grps,_taskID]
				]
			];
		} forEach units _hostageGrp;
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

