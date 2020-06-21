#include "\nocebo\defines\scriptDefines.hpp"

{
	private _mkr = _x;
	if (_mkr find "respawn_west_tent_group" > -1) then {
		if (({if (_mkr find (getPlayerUID _x) > -1) exitWith {1}} count units group player) isEqualTo 0) then {
			// this is a group marker but the creator is not in group so delete
			deleteMarkerLocal _mkr;
		};
	};
} forEach allMapMarkers;

true