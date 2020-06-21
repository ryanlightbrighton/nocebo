#include "\nocebo\defines\scriptDefines.hpp"

params ["_grp","_spawnPosASL","_waypointData"];

private _spawnPosATL = ASLtoATL _spawnPosASL;
private _cyclePos = [];
if not (surfaceIsWater _spawnPosATL) then {

	// SPAWN 0

	[_grp,0] setWaypointPosition [ASLToAGL getPosASL (missionNamespace getVariable ((_grp getVariable "groupData") select 6)),0];

	// ADVANCE 1

	private _wp = _grp addWaypoint [_spawnPosATL, 0];
	_wp setWaypointBehaviour "AWARE";
	_wp setWaypointCombatMode "RED";
	_wp setWaypointCompletionRadius 30;
	_wp setWaypointFormation "WEDGE";
	_wp setWaypointSpeed "FULL";
	/*if ((_grp getVariable 'groupData') select 0 in ['technical','apc']) then {
		_wp setWaypointStatements [
			"true",
			"if (isServer) then {
				_house = group this getVariable ['groupAdvanceHouseTarget',objNull];
				if (not isNull _house) then {
					gunner vehicle this doSuppressiveFire _house;
					group this setVariable ['groupAdvanceHouseTarget',nil]
				};
			}"
		];
	} else {
		_wp setWaypointStatements ["true",""];
	};*/
	_wp setWaypointStatements [
		"true",
		"if (isServer) then {
			_type = (group this getVariable ['groupData','none']) select 0;
			if (_type in ['technical','apc']) then {
				_house = group this getVariable ['groupAdvanceHouseTarget',objNull];
				if (not isNull _house) then {
					gunner vehicle this doSuppressiveFire _house;
					group this setVariable ['groupAdvanceHouseTarget',nil]
				};
			}
		}"
	];
	_wp setWaypointTimeout [0,0,0];
	_wp setWaypointType "MOVE";

	// WAIT 2

	_wp = _grp addWaypoint [_spawnPosATL, 0];
	_wp setWaypointType "HOLD";
	_wp setWaypointStatements ["true",""];

	// SEARCH 3

	_wp = _grp addWaypoint [_spawnPosATL, 0];
	_wp setWaypointType "MOVE";

	// SEARCH 4

	_wp = _grp addWaypoint [_spawnPosATL, 0];
	_wp setWaypointType "MOVE";

	// SEARCH 5

	_wp = _grp addWaypoint [_spawnPosATL, 0];
	_wp setWaypointType "MOVE";

	// SEARCH 6

	_wp = _grp addWaypoint [_spawnPosATL, 0];
	_wp setWaypointType "MOVE";

	// CYCLE 7

	_wp = _grp addWaypoint [_spawnPosATL, 0];
	_wp setWaypointType "CYCLE";

	// HOLD 8

	_wp = _grp addWaypoint [_spawnPosATL, 0];
	_wp setWaypointType "HOLD";


	// GET IN 9

	_wp = _grp addWaypoint [_spawnPosATL, 0];
	_wp setWaypointType "GETIN";

	// WAIT 10

	_wp = _grp addWaypoint [_spawnPosATL, 0];
	_wp setWaypointType "MOVE";  // ISSUE, maybe del this waypoint was "HOLD"

	// NOW ADD PATROL WAYPOINTS 11+
	private _speed = if (sel(getVar(_grp,"groupData"),0) == "infantry") then {"NORMAL"} else {"LIMITED"};
	private _countWps = count _waypointData;
	{

		private _pos = _x;
		_wp = _grp addWaypoint [_pos, 0];
		if same(_forEachIndex,0) then {
			_wp setWaypointBehaviour "AWARE";
			_wp setWaypointCombatMode "YELLOW";
			_wp setWaypointCompletionRadius 50;
			_wp setWaypointFormation "WEDGE";
			_wp setWaypointSpeed _speed;
			_wp setWaypointStatements ["true",""];
			_wp setWaypointTimeout [0,5,20];
			_wp setWaypointType "MOVE";
			_cyclePos = _pos;
		} else {
			if same(_forEachIndex,_countWps - 1) then {
				_wp setWaypointStatements [
					"true",
					format [
						"if (isServer) then {
							_type = (group this getVariable ['groupData',['none']]) select 0;
							if (_type == 'infantry') then {
								[group this,11] setWaypointSpeed 'NORMAL';
								if (random 1 < 0.1) then {
									[group this,missionNamespace getVariable '%1'] call horde_fnc_groupSwitchWaypoints
								};
							} else {
								[group this,11] setWaypointSpeed 'LIMITED'
							};
						}",
						(_grp getVariable ["groupData",["","","","","","",""]]) select 6
					]
				];
			}
		};
	} forEach _waypointData;

	_wp = _grp addWaypoint [_cyclePos, 0];
	_wp setWaypointType "CYCLE";
} else {
	diag("removed code for water spawns - nothing should be going here");
	/*_wp = [
		_grp,
		sel2(_waypointData,0,0),
		"AWARE",
		"YELLOW",
		50,
		"WEDGE",
		"FULL",
		["true",""],
		[0,0,0],
		"MOVE"
	] call horde_fnc_addWaypoint;
	{
		_pos = sel(_x,0);
		if same(_forEachIndex,0) then {
			_cyclePos = _pos;
		};
		_wp = [
			_grp,
			_pos,
			"AWARE",
			"YELLOW",
			50,
			"WEDGE",
			"NORMAL",
			["true",""],
			[0,5,15],
			"MOVE"
		] call horde_fnc_addWaypoint;
	} forEach _waypointData;
	_wp = [
		_grp,
		_cyclePos,
		"AWARE",
		"YELLOW",
		50,
		"WEDGE",
		"NORMAL",
		["true",""],
		[0,0,0],
		"CYCLE"
	] call horde_fnc_addWaypoint;*/
};

// follows leader
if (ncb_param_debugMode == 1) then {
	{
		_x call horde_fnc_addIcon
	} forEach units _grp;
};
true