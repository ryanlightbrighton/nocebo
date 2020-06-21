#include "\nocebo\defines\scriptDefines.hpp"

params ["_testPos","_radius"];
private _waypointPositions = [];
{
	_x params ["_position","_suitability"];
	if (_suitability > 0
		and {not (surfaceIsWater _position)}
		and {({if (_x distance2D _position < _radius * 0.3) exitWith {1}} count _waypointPositions) isEqualTo 0}
	) then {
		_position set [2,0];

		// new bit
		if (random 1 > 0.8) then {
			private _buildings = nearestTerrainObjects [
				_position,
				["HOUSE","CHURCH"],
				50,
				false
			];
			if not ([] isEqualTo _buildings) then {
				_position = getPos selectRandom _buildings
			};
		};

		//

		private _building = (ATLtoASL _position) call horde_fnc_isPosInEnterableBuilding;
		private _buildingPositions = _building buildingPos -1;
		if (isNull _building or {_buildingPositions isEqualTo []}) then {
			_waypointPositions pushBack _position
		} else {
			_waypointPositions pushBack (selectRandom _buildingPositions)
		};
	};
	true
} count (selectBestPlaces [
	_testPos,
	_radius,
	"houses + meadow + forest - sea",
	100,
	12
]);

_waypointPositions