#include "\nocebo\defines\scriptDefines.hpp"

// gets highest buildingpos in a building.  Returns [] if no positions.

scopeName "0";

private _pos = [];
private _height = -999;
{
	if (sel(_x,2) > _height) then {
		_height = sel(_x,2);
		_pos = _x
	};
} forEach (_this buildingPos -1);

_pos

