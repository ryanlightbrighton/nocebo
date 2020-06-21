#include "\nocebo\defines\scriptDefines.hpp"

// set parameters

params [
	["_grp",grpNull,[grpNull]],
	["_startPosASL",[0,0,0],[objNull,"",[]]],
	["_endPosASL",[0,0,0],[objNull,"",[]]],
	["_nodeStep",1000,[0]],
	["_minDepth",5,[0]],
	["_debug",false,[false]],
	["_whiteLists",[],[[]]]
];

private _obj1 = objNull;
call {
	if (_startPosASL isEqualType objNull) exitWith {
		_obj1 = _startPosASL;
		_startPosASL = getPosASL _startPosASL
	};
	if (_startPosASL isEqualType "") then {
		_startPosASL = markerPos _startPosASL;
		_startPosASL set [2,0]
	}
};
private _obj2 = objNull;
call {
	if (_endPosASL isEqualType objNull) exitWith {
		_obj2 = _endPosASL;
		_endPosASL = getPosASL _endPosASL
	};
	if (_endPosASL isEqualType "") then {
		_endPosASL = markerPos _endPosASL;
		_endPosASL set [2,0]
	}
};

// define local functions

_fnc_nearCoast = {
	private _near = false;
	for "_i" from 0 to 315 step 45 do {
		if ! (lineIntersectsSurfaces [_this,_this vectorAdd [sin _i * 250,cos _i * 250,0]] isEqualTo []) exitWith {
			_near = true
		}
	};
	_near
};

_fnc_closestLogic = {
	params ["_pos","_logics"];
	private _currentDist = 999999;
	private _closestLogic = objNull;
	{
		if (_x distance _pos < _currentDist) then {
			_currentDist = _x distance _pos;
			_closestLogic = _x;
		}
	} forEach _logics;
	_closestLogic
};

private _fnc_lowestDist = {
	private _lowest = _this select 0;
	{
		if (_x getVariable "cost" < _lowest getVariable "cost") then {
			_lowest = _x;
		}
	} forEach _this;
	_lowest
};


_surrLogs = {
	private _surrLogs = nearestObjects [_this,["Logic"],1200];
	_surrLogs = _surrLogs select {!(_x getVariable "visited")};
	_surrLogs
};

// now create nodes on map around the shores

private _nodeCoords = [];
_logics = [];
for "_width" from 0 to worldSize step 150 do {
	for "_length" from 0 to worldSize step 150 do {
		private _coord = [_width,_length,0];
		if (surfaceIsWater _coord and {abs getTerrainHeightASL _coord > 10} and {_coord call _fnc_nearCoast}) then {
			_nodeCoords pushBack _coord;
			private _log = "Logic" createVehicleLocal _coord;
			_log setPosASL _coord;
			_logics pushBack _log;
			_log setVariable ["cost",999999];
			_log setVariable ["visited",false];
			_log setVariable ["pathToOrigin",[]];
		}
	};
};

// add modes every 1 km

for "_width" from 0 to worldSize step 1000 do {
	for "_length" from 0 to worldSize step 1000 do {
		private _coord = [_width,_length,0];
		if (surfaceIsWater _coord and {abs getTerrainHeightASL _coord > 10}) then {
			private _index = _nodeCoords pushBackUnique _coord;
			if (_index > -1) then {
				private _log = "Logic" createVehicleLocal _coord;
				_log setPosASL _coord;
				_logics pushBack _log;
				_log setVariable ["cost",999999];
				_log setVariable ["visited",false];
				_log setVariable ["pathToOrigin",[]];
			}
		}
	};
};

// now get closest logic to start position

private _logic = [_startPosASL,_logics] call _fnc_closestLogic;
_logic setVariable ["cost", _startPosASL distance2D _logic];
_logic setVariable ["pathToOrigin", [_logic]];

// now loop through all logics

_unvisitedLogics = +_logics;

for "_i" from 0 to 999999 step 1 do {
	if (_unvisitedLogics isEqualTo []) exitWith {};
	private _log = _unvisitedLogics call _fnc_lowestDist;
	_log setVariable ["visited", true];
	private _totalDist = _log getVariable ["cost",999999];
	private _logicPath = _log getVariable ["pathToOrigin",[]];
	{
		if (_x in _logics
			and {lineIntersectsSurfaces [getPosASL _log,getPosASL _x] isEqualTo []}
		) then {
			private _localDist = _log distance2D _x;
			private _currentDist = _x getVariable ["cost",999999];
			if (_totalDist + _localDist < _currentDist) then {
				_totalDist = _totalDist + _localDist;
				_x setVariable ["cost",_totalDist];
				private _locArr = +_logicPath;
				_locArr pushBack _x;
				_x setVariable ["pathToOrigin",_locArr];
			}
		};
	} forEach (_log call _surrLogs);
	_unvisitedLogics = _unvisitedLogics - [_log]
};

// now find closest logic to destination

_logic = [_endPosASL,_logics] call _fnc_closestLogic;

_path = _logic getVariable ["pathToOrigin",[]];

if (_path isEqualTo []) then {
	diag_log "error - no path";
} else {
	// now we can delete unnecessary waypoints by checking intersects along path

	private _waypointsASL = [_startPosASL] + (_path apply {getPosASL _x});
	_waypointsASL pushBack _endPosASL;

	private _newPath = [_waypointsASL select 0];
	private _currentWpIndex = 0;
	{
		private _wp = _x;
		private _index = _forEachIndex;
		if (_index == count _waypointsASL - 1) exitWith {};
		if (_index >= _currentWpIndex) then {
			private _nextWp = [];
			scopeName "indent_2";
			{
				private _newIndex = _forEachIndex;
				if (_newIndex >= _index) then {
					if (lineIntersectsSurfaces [_wp,_x] isEqualTo []) then {
						_nextWp = _waypointsASL select _newIndex;
						_currentWpIndex = _newIndex;
					} else {
						breakTo "indent_2";
					};
				};
			} forEach _waypointsASL;

			if not ([] isEqualTo _nextWp) then {
				_newPath pushBack  _nextWp
			};
		};
	} forEach _waypointsASL;

	// get rid of starting position (will not need wp for it)

	_newPath deleteAt 0;

	// if destination has been deleted, then add it back

	_newPath pushBackUnique _endPosASL;

	// now compare the final position to penultimate.  If further away from endpos, then delete it

	if (count _newpath > 2) then {
		_last = _newpath select (count _newpath - 2);
		_penultimate = _newpath select (count _newpath - 3);
		if (_penultimate distance _last > _penultimate distance _endPosASL) then {
			_newPath deleteAt (count _newpath - 2);
		}
	};

	// now move the boat along the wps

	if not (isNull _grp) then {
		[_grp,0] setWaypointPosition [getPosASL vehicle leader _grp,0];
		{
			[
				_grp,
				_x,
				"aware",
				"yellow",
				if (count _newPath - 1 == _forEachIndex) then {50} else {100},
				"column",
				"full",
				["true",""],
				[0,0,0],
				"move"
			]  call horde_fnc_addWaypoint;
		} forEach _newPath;

		_grp setCurrentWaypoint [_grp,1]
	};
};

{
	deleteVehicle _x
} count _logics;

