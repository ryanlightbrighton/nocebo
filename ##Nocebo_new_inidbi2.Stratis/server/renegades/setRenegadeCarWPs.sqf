#include "\nocebo\defines\scriptDefines.hpp"

params ["_grp","_centerPos","_height","_currentRadius"];

private _chopper = vehicle leader _grp isKindOf "air";
private _exp = if (_chopper) then {"meadow + houses + trees + forest + hills + sea"} else {"meadow + houses"};
private _rad = if (_chopper) then {_currentRadius + randInteg(150,300)} else {_currentRadius + randInteg(70,150)};

private _searchPositions = [];
{
	_x params ["_pos","_suitability"];
	if (count _searchPositions isEqualTo 4) exitWith {};
	// check for nearby roads
	if (not _chopper) then {
		private _rds = _pos nearRoads 40;
		if not ([] isEqualTo _rds) then {
			_pos = getPos selectRandom _rds
		};
	};
	if (_suitability > 0
		and {if (_chopper) then {true} else {not surfaceIsWater _pos}}
		and {{_x distance2D _pos < 50} count _searchPositions == 0}
	) then {
		_pos set [2,_height];
		_searchPositions pushBack _pos
	};
	true
} count ((selectBestPlaces [
	_centerPos,
	_rad,
	_exp,
	10,
	15
]) call horde_fnc_arrayShuffle);

for "_i" from 1 to 4 step 1 do {
	if (_i > count _searchPositions) exitWith {};
	[_grp,_i] setWaypointPosition [_searchPositions select (_i - 1),0];
};
_grp setCurrentWaypoint [_grp,1];
_grp setVariable ["searchData",[_grp,_centerPos,_height,_rad]];
true