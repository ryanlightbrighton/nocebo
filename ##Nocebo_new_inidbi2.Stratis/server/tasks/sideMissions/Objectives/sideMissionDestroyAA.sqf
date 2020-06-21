#include "\nocebo\defines\scriptDefines.hpp"
scriptName "sideMissionDestroyAA";
private _notStarted = true;
private _fnc_taskDefend = {
	params ["_index","_grp","_pos","_statics"];
	_grp setBehaviour "SAFE";
	private _units = (units _grp) - [leader _grp];
	{
		if ((count _units) > 0) then {
			private _unit = _units deleteAt ((count _units) - 1);
			_unit assignAsGunner _x;
			_unit moveInTurret [_x,[0]]
		};
	} forEach (_pos nearEntities ["StaticWeapon",100] select {_x emptyPositions "gunner" > 0});

	private _wp = _grp addWaypoint [_pos, 20];
	_wp setWaypointType "GUARD";

	private _campers = if (_index == 0) then {[_units select 0]} else {[]};
	{
		if (random 1 > 0.3) then {
			_campers pushBackUnique _x
		} else {
			_x doMove (_x getPos [random 10,random 360])
		}
	} forEach _units;

	if not ([] isEqualTo _campers) then {
		_campPosASL = [_position,10,40,5,0,1,0] call horde_fnc_findSafePosASL;
		if not ([] isEqualTo _campPosASL) then {
			private _fire = createVehicle ["Campfire_burning_F",ASLtoATL _campPosASL,[],0,"can_collide"];
			_fire setDir random 360;
			_fire setPosASL _campPosASL;
			_fire setVectorUp surfaceNormal _campPosASL;
			private _tentPos = _campPosASL getPos [4.4,random 360];
			private _tent = createVehicle ["ncb_obj_tent_aFrame",_tentPos,[],0,"can_collide"];
			_tent setDir (_fire getDir _tent);
			_tent setPos _tentPos;
			_statics pushBack netID _tent;
			_statics pushBack netID _fire;
			_tent enableDynamicSimulation true;
			_fire enableDynamicSimulation true;
			if (_index == 0) then {
				_tent addItemCargoGlobal [
					selectRandom [
						"ghosthawkCASAccessCode",
						"ghosthawkCASAccessCode",
						"wipeoutCASAccessCode",
						"greyhawkCASAccessCode",
						"blackfishCASAccessCode"
					],
					1
				]
			};
			[
				_tent,
				[0,2,0,2],	// optics
				[0,2,0,2],	// vests
				[0,2,0,2],	// helmets
				[0,2,0,2],	// guns
				[0,2,0,2],	// backpacks
				[0,2,0,2],	// charges
				[0,2,0,2],	// medical
				[0,2,0,2],	// food
				[0,2,0,2],	// tools
				[0,2,0,2],	// tents
				[0,2,0,2],	// fuel
				[0,2,1,2],	// vehicle ammo
				[0,2,1,2],	// launchers
				[]			// vehicle parts
			] call horde_fnc_fillCrate;
			[_campers,_position,_fire] spawn {
				scriptName "sideMissionDestroyAA";
				params ["_campers","_position","_fire"];
				scriptName "taskDefend";
				sleep 3;
				private _division = 360 / (count _campers);
				private _angle = random 360;
				{
					_x addEventHandler ["firedNear",{
						params ["_unit","_shooter"];
						if (group _shooter == group _unit) then {
							_unit doFollow leader _unit;
							_unit removeAllEventHandlers "firedNear"
						};
					}];
					doStop _x;
					_x setPos (_fire getPos [2 + (random 1.2),_angle]);
					_x setDir (_x getDir _fire);
					_x doWatch _fire;
					sleep 1;
					_x action ["SitDown",_x];
					_angle = (_angle + _division) % 360;
				} forEach _campers;
			}
		}
	};
	_statics
};

private _grps = [];
private _statics = [];
private _veh = objNull;
private _position = [];
private _zone = objNull;
if not empty(ncb_gv_zonesWithEmptySpace) then {
	scopeName "root";
	_zonesWithEmptySpace = + ncb_gv_zonesWithEmptySpace;
	for "_i" from 0 to count _zonesWithEmptySpace - 1 do {
		_zone = _zonesWithEmptySpace deleteAt (floor random count _zonesWithEmptySpace);
		private _cfgZone = configFile >> "CfgZones" >> worldName >> str _zone;
		private _landMassCount = getNumber (_cfgZone >> "landMassCount");
		private _emptyPlacesASL = getArray (_cfgZone >> "EmptyPlaces" >> "EmptyPlacesASL_20");
		_emptyPlacesASL = _emptyPlacesASL apply {_x select 0};
		for "_k" from 0 to count _emptyPlacesASL - 1 do {
			_position = ASLtoATL (_emptyPlacesASL deleteAt (floor random count _emptyPlacesASL));
			if (not ([_position,1000] call horde_fnc_playerIsNear)
				and {nearestObjects [_position,["All"],8] isEqualTo []}
			) exitWith {

				// veh

				_notStarted = false;

				_veh = createVehicle ["ncb_veh_tigris",_position,[],0,"can_collide"];
				_veh setDir random 360;
				_veh setVehicleLock "LOCKED";
				if (ncb_param_aiDisableVehicleVisionNV) then {
					_veh disableNVGEquipment true
				};
				if (ncb_param_aiDisableVehicleVisionTI) then {
					_veh disableTIEquipment true
				};
				_veh addEventHandler ["reloaded", {
					_this call horde_fnc_autoReloadVehWeap
				}];
				_veh call horde_fnc_addExtraVehicleMags;
				_veh setVariable ["ncb_garbageExcluded",true];
				_veh allowCrewInImmobile true;

				_veh enableDynamicSimulation true;

				// crew

				private _grp = createGroup east;
				{
					private _unit = ncb_gv_enemyUnitPool deleteAt 0;
					[_unit] joinSilent _grp;
					_unit enableSimulationGlobal true;
					_unit hideObjectGlobal false;
					if (_x isEqualTo [-1]) then {
						_unit moveInDriver _veh
					} else {
						_unit moveInTurret [_veh,_x]
					};
					[_unit,true] call horde_fnc_allowDamageGlobal;
					_unit enableAI "checkVisible";
					_unit setVariable ["lookAroundData", ["antiair",[_veh,_x]]];
					_unit setSpeaker "NoVoice";
				} count [[-1]] + allTurrets [_veh,true];

				_grps pushBack (netID _grp);

				[_zone,_grp] execFSM "server\ai\look_around.fsm";

				_grp enableDynamicSimulation true;
				_grp setGroupIDGlobal [format ["sm_destroyAA_%1",_grp]];

				// defensive squads

				for "_i" from 0 to (floor random 3) + 1 do {
					private _spawnPos = _position getPos [8,random 360];
					_grp = createGroup east;
					for "_j" from 1 to (floor random 4) + 3 do {
						private _unit = if (_landMassCount < 2) then {ncb_gv_enemyUnitPool deleteAt 0} else {ncb_gv_enemyDiverPool deleteAt 0};
						[_unit] joinSilent _grp;
						_unit enableSimulationGlobal true;
						_unit hideObjectGlobal false;
						_unit setPos _spawnPos;
						[_unit,true] call horde_fnc_allowDamageGlobal;
						_unit enableAI "checkVisible";
					};
					_grps pushBack (netID _grp);
					if (_i == 0 or {random 1 > 0.5}) then {
						_spawnPosASL = [_position,10,40,5,0,1,0] call horde_fnc_findSafePosASL;
						if not ([] isEqualTo _spawnPosASL) then {
							private _gun = createVehicle [selectRandom ncb_gv_enemyStaticMGHiTypes,ASLtoATL _spawnPosASL,[],0,"can_collide"];
							_gun setDir (_veh getDir _gun);
							_gun addEventHandler ["reloaded", {
								_this call horde_fnc_autoReloadVehWeap
							}];
							_gun call horde_fnc_addExtraVehicleMags;
							if (ncb_param_aiDisableVehicleVisionNV) then {
								_gun disableNVGEquipment true
							};
							if (ncb_param_aiDisableVehicleVisionTI) then {
								_gun disableTIEquipment true
							};
							_gun enableDynamicSimulation true;
							_statics pushBack (netID _gun)
						};
						_statics = [_i,_grp,_position,_statics] call _fnc_taskDefend;
					} else {
						/*[_grp,_position,500] call BIS_fnc_taskPatrol;*/
						[_grp,_position,50,500,true] call horde_fnc_taskPatrol;
					};
					_grp enableDynamicSimulation true;
					_grp setGroupIDGlobal [format ["sm_destroyAA_%1",_grp]];
					sleep 1
				};
				breakTo "root"
			}
		}
	};
	if not (isNull _veh) then {
		private _statement = format ["Antagonists have deployed a %1 . In order to keep the skies safe, it must be destroyed. It is believed to be at Grid: %2.",getText(configFile >> "cfgVehicles" >> (typeOf _veh) >> "displayName"), mapGridPosition _veh];
		private _id = [
			/*params*/"DT" + (str _zone),
			/*target*/true,
			/*desc*/[_statement,"Destroy AA",_statement],
			/*dest*/_position,
			/*state*/"CREATED",
			/*priority*/0,
			/*showNotification*/true,
			/*isGlobal*/true,
			/*type*/"destroy",
			/*shared*/false
		] call BIS_fnc_setTask;
		hint parsetext "<t align='center'><t size='2.2'>New Side Mission</t><br/><t size='1.5' color='#00B2EE'>Destroy AA</t><br/>____________________<br/>Antagonists have deployed a Tigris to shoot down any friendly airborne units.  Destroy it so it is safe to fly.</t>";
		_veh addEventHandler ["killed",
			format [
				"[_this,%1] call {
					params ['','_data'];
					_data params ['_position','_grps','_statics','_id'];
					[_id,'Succeeded'] call BIS_fnc_taskSetState;
					[
						[_position,_grps,_statics,_id],{
							call horde_fnc_getEachFrameArgs params ['_position','_grps','_statics','_id'];
							if not ([_position,1000] call horde_fnc_playerIsNear) then {
								{
									{_x removeAllEventHandlers 'firedNear'} count units (groupFromNetId _x);
									(groupFromNetId _x) call horde_fnc_cacheGroup
								} count _grps;
								{
									deleteVehicle (objectFromNetId _x)
								} count _statics;
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
				[_position,_grps,_statics,_id]
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

