#include "\nocebo\defines\scriptDefines.hpp"

params ["_grp","_centerPos","_height","_currentRadius"];

private _rad = _currentRadius + randInteg(70,150);

private _fnc_noLand = {
	private _noLand = true;
	for "_i" from 0 to 315 step 45 do {
		if (getTerrainHeightASL (_this getPos [100,_i]) > 0) exitWith {
			_noLand = false
		};
	};
	_noLand
};

private _searchPositions = [];

for "_i" from 1 to 15 do {
	if (count _searchPositions isEqualTo 4) exitWith {};
	private _testPos = _centerPos getPos [200 + random _rad,round random 360];
	if (getTerrainHeightASL _testPos < -6
		and {surfaceIsWater _testPos}
		and {{_x distance2D _testPos < 150} count _searchPositions == 0}
		and {_testPos call _fnc_noLand}
	) then {
		_searchPositions pushBack _testPos
	};
};

for "_i" from 1 to 4 step 1 do {
	if (_i > count _searchPositions) exitWith {};
	[_grp,_i] setWaypointPosition [_searchPositions select (_i - 1),0];
};
_grp setCurrentWaypoint [_grp,1];
_grp setVariable ["searchData",[_grp,_centerPos,_height,_rad]];

true