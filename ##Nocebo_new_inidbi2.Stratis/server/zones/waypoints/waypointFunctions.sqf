#include "\nocebo\defines\scriptDefines.hpp"

horde_fnc_setAdvanceWp = {
	params ["_grp","_pos"];
	[_grp,1] setWaypointPosition [_pos,0];
	[_grp,2] setWaypointPosition [_pos,0];
	_grp setCurrentWaypoint [_grp,1];
	true
};

horde_fnc_startSearchWp = {
	params ["_grp","_centerPos","_rad","_ang","_inc","_pos"];
	if (not isNil {_grp getVariable "searchingHouse"}) then {
		_grp setVariable ["searchingHouse",nil];
	};
	_ang = random 359;
	_inc = 90;
	if (random 2 > 1) then {
		_inc = -90
	};
	for "_i" from 3 to 6 step 1 do {
		_pos = _centerPos getPos [100 + random 250,_ang];
		if (surfaceIsWater _pos) then {
			_pos = _centerPos;
		};
		[_grp,_i] setWaypointPosition [_pos,0];
		if same(_i,3) then {
			[_grp,7] setWaypointPosition [_pos,0];
		};
		_ang = (_ang + _inc) call horde_fnc_normalDir;
	};
	_grp setCurrentWaypoint [_grp,3];
	true
};

horde_fnc_startHouseSearchWp = {
	params ["_grp","_positions","_targetPosAGL"];
	_grp setVariable ["searchingHouse",true];
	// diag_log format ["pos 1 (start) %1",_positions];
	private _amended = false;
	for "_i" from 1 to 4 do {
		if (count _positions > 3) exitWith {_amended = true};
		_positions pushBack (selectRandom _positions)
	};
	// diag_log format ["pos 2 (added extra) %1",_positions];
	// sort
	if not (_amended) then {
		_positions = [_positions,_targetPosAGL] call horde_fnc_sortByDistance;
	};

	// diag_log format ["pos 3 (sorted) %1",_positions];

	// diag_log format ["_positions 2 %1", _positions];
	for "_i" from 3 to 6 step 1 do {
		private _posIndex = _i - 3;
		/*diag_log format ["pos index %1",_posIndex];*/
		_housePos = _positions select _posIndex;
		/*diag_log format ["housepos %1",_housePos];*/
		// diag_log format ["_housePos %1",_housePos];
		[_grp,_i] setWaypointPosition [_housePos,0];
		if same(_i,3) then {
			[_grp,7] setWaypointPosition [_housePos,0];
		};
	};
	_grp setCurrentWaypoint [_grp,3];
	true
};

horde_fnc_setHoldWp = {
	params ["_grp","_pos"];
	[_grp,8] setWaypointPosition [_pos,0];
	_grp setCurrentWaypoint [_grp,8];
	true
};

horde_fnc_setGetinWp = {
	params ["_grp","_pos"];
	[_grp,9] setWaypointPosition [_pos,0];
	[_grp,10] setWaypointPosition [_pos,0];
	_grp setCurrentWaypoint [_grp,9];
	true
};

horde_fnc_startPatrolWp = {
	_this setCurrentWaypoint [_this,11];
	true
};

// query current waypoint

horde_fnc_currWp = {
	[_this,currentWaypoint _this]
};

horde_fnc_currWpPos = {
	waypointPosition (_this call horde_fnc_currWp)
};

horde_fnc_currWpType = {
	waypointType (_this call horde_fnc_currWp)
};

// test for states

horde_fnc_isGroupAdvancing = {
	same(currentWaypoint _this,1)
};

horde_fnc_isGroupSearching = {
	currentWaypoint _this in [3,4,5,6]
};

horde_fnc_isGroupWaiting = {
	currentWaypoint _this in [2,10]
};

horde_fnc_isGroupHolding = {
	same(currentWaypoint _this,8)
};

horde_fnc_isGroupEmbarking = {
	same(currentWaypoint _this,9)
};

horde_fnc_isGroupPatrolling = {
	currentWaypoint _this > 10
};

horde_fnc_debugWPType = {
	private _ret = "Patrol";
	call {
		if (_this isEqualTo 1) exitWith {
			_ret = "Advance"
		};
		if (_this in [3,4,5,6,7]) exitWith {
			_ret = "Search"
		};
		if (_this isEqualTo 8) exitWith {
			_ret = "Hold"
		};
		if (_this isEqualTo 9) exitWith {
			_ret = "Get In"
		};
		if (_this in [2,10]) exitWith {
			_ret = "Waiting"
		};
	};
	_ret
};

horde_fnc_groupSwitchWaypoints = {
	params ["_grp","_zone"];
	// get new set of random waypoints
	if ([_zone,ncb_gv_zoneRadius] call horde_fnc_playerIsNear) then {
	   _closestWaypoints = selectRandom (getArray (configFile >> "CfgZones" >> worldName >> (str _zone) >> "PatrolData" >> "patrolLandASL"));
		if not (_closestWaypoints isEqualTo []) then {
			// delete old wp's
			private _waypoints = waypoints _grp;
			for "_i" from count _waypoints -1 to 11 step -1 do {
				deleteWaypoint (_waypoints select _i)
			};
			// add new ones
			_waypoints = _closestWaypoints select 1;

			private _cyclePos = [];
			private _countWps = count _waypoints;
			{
				private _wp = _grp addWaypoint [_x, 0];
				if same(_forEachIndex,0) then {
					_wp setWaypointBehaviour "AWARE";
					_wp setWaypointCombatMode "YELLOW";
					_wp setWaypointCompletionRadius 50;
					_wp setWaypointFormation "WEDGE";
					_wp setWaypointSpeed "NORMAL";
					_wp setWaypointStatements ["true",""];
					_wp setWaypointTimeout [0,5,20];
					_wp setWaypointType "MOVE";
					_cyclePos = _x;
				} else {
					if (_forEachIndex isEqualTo (_countWps - 1)) then {
						_wp setWaypointStatements [
							"true",
							format [
								"if (isServer) then {
									_type = (group this getVariable 'groupData') select 0;
									if (_type == 'infantry'
										and {random 1 < 0.1}
									) then {
										[group this,missionNamespace getVariable '%1'] call horde_fnc_groupSwitchWaypoints
									};
								}",
								sel(getVar(_grp,"groupData"),6)
							]
						]
					}
				};
			} forEach _waypoints;

			private _wp = _grp addWaypoint [_cyclePos, 0];
			_wp setWaypointType "CYCLE";

			_grp call horde_fnc_startPatrolWp;
		};
	};
	true
};