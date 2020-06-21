#include "\nocebo\defines\scriptDefines.hpp"

/*
	File: taskPatrol.sqf
	Author: Joris-Jan van 't Land - modified by Das Attorney

	Description:
	Create a random patrol of several waypoints around a given position.

	Parameter(s):
	_this select 0: the group to which to assign the waypoints (Group)
	_this select 1: the position on which to base the patrol (Array)
	_this select 2: the minimum distance between waypoints (Number)
	_this select 3: the max distance from center pos (Number)
	_this select 4: (optional) waypoints must be within this distance from origin (boolean)

	Returns:
	Boolean - success flag
*/

params ["_grp","_pos","_minDistWP","_maxDist",["_stay",false]];

_wp = [_grp,0];
_wp setWaypointBehaviour "aware";
_wp setWaypointSpeed "full";
_wp setWaypointFormation "line";
_wp setWaypointCombatMode "red";

_wp = _grp addWaypoint [[0,0,0],0];
_wp setWaypointType "hold";

//Create a string of randomly placed waypoints.
private _prevPos = _pos;
private _positions = [];
for "_i" from 0 to (2 + (floor random 3)) do {
	private _newPos = if (_stay) then {
		for "_j" from 1 to 1000 do {
			_newPos = [_pos,_minDistWP,_maxDist,1,0,1,0] call horde_fnc_findSafePosASL;
			if ({_x distance2D _newPos < _minDistWP} count _positions == 0) exitWith {
				_newPos
			}
		}
	} else {
		[_prevPos,_minDistWP,_maxDist,1,0,1,0] call horde_fnc_findSafePosASL
	};
	_prevPos = _newPos;
	_positions pushBack _prevPos;

	private _wp = _grp addWaypoint [_newPos, 0];
	_wp setWaypointType "MOVE";
	_wp setWaypointCompletionRadius 20;

	//Set the group's speed and formation at the first waypoint.
	if (_i == 0) then {
		_wp setWaypointBehaviour "safe";
		_wp setWaypointSpeed "limited";
		_wp setWaypointFormation "stag column";
		_wp setWaypointCombatMode "green";
		_grp setCurrentWaypoint [_grp,2]
	}
};

//Cycle back to the first position.
_wp = _grp addWaypoint [if ([] isEqualTo _positions) then {_pos} else {_positions select 0},0];
_wp setWaypointType "CYCLE";
_wp setWaypointCompletionRadius 20;

_grp spawn {
	_attackWP = [_this,0];
	_holdWP = [_this,1];
	_sleep = 10;
	waitUntil {
		sleep _sleep;
		_leader = leader _this;

		if (isNull (_leader findNearestEnemy _leader)) then {
			_sleep = 10;
			if (currentWaypoint _this < 2) then {
				_this setCurrentWaypoint [_this,2]
			}
		} else {
			_sleep = 40;
			_targets = _leader targets [true,500];
			if not ([] isEqualTo _targets) then {
				_target = _targets select 0;
				_targets = (_leader nearTargets ((_leader distance2D _target) + 100)) select {_x select 4 isEqualTo _target};
				if not ([] isEqualTo _targets) then {
					_position = _targets select 0 select 0;
					_attackWP setWaypointPosition [_position,0];
					_holdWP setWaypointPosition [_position,0];
					_this setCurrentWaypoint _attackWP
				}
			}
		};
		units _this isEqualTo []
	}
};

/*_grp spawn {
	waitUntil {
		sleep 10;
		_leader = leader _this;
		if isNull (_leader findNearestEnemy _leader) then {
			if (behaviour _leader != "safe") then {
				_this lockWP false;
				_this setBehaviour "safe";
				_this setSpeedMode "limited";
				_this setFormation "stag column";
				_this setCombatMode "green";
			}
		} else {
			if (behaviour _leader != "aware") then {
				_this lockWP true;
				_this setBehaviour "aware";
				_this setSpeedMode "full";
				_this setFormation "line";
				_this setCombatMode "red";
			}
		};
		units _this isEqualTo []
	}
};*/

true



// ORIG CODE

/*params ["_grp","_pos","_minDistWP","_maxDist",["_stay",false]];

_grp setBehaviour "SAFE";

//Create a string of randomly placed waypoints.
private _prevPos = _pos;
private _positions = [];
for "_i" from 0 to (2 + (floor random 3)) do {
	private _newPos = if (_stay) then {
		for "_j" from 1 to 1000 do {
			_newPos = [_pos,_minDistWP,_maxDist,1,0,1,0] call horde_fnc_findSafePosASL;
			if ({_x distance2D _newPos < _minDistWP} count _positions == 0) exitWith {
				_newPos
			}
		}
	} else {
		[_prevPos,_minDistWP,_maxDist,1,0,1,0] call horde_fnc_findSafePosASL
	};
	_prevPos = _newPos;
	_positions pushBack _prevPos;

	private _wp = _grp addWaypoint [_newPos, 0];
	_wp setWaypointType "MOVE";
	_wp setWaypointCompletionRadius 20;

	//Set the group's speed and formation at the first waypoint.
	if (_i == 0) then {
		_wp setWaypointSpeed "LIMITED";
		_wp setWaypointFormation "STAG COLUMN"
	}
};

//Cycle back to the first position.
_wp = _grp addWaypoint [if ([] isEqualTo _positions) then {_pos} else {_positions select 0},0];
_wp setWaypointType "CYCLE";
_wp setWaypointCompletionRadius 20;*/
