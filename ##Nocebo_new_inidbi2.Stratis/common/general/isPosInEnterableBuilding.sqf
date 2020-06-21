#include "\nocebo\defines\scriptDefines.hpp"

// checks if ASL position is in a building - returns building if found, null if not.

private _object = objNull;
scopeName "0";
for "_i" from 5 to -5 step -10 do {
	private _testPos = [
		sel(_this,0),
		sel(_this,1),
		sel(_this,2) + _i
	];
	private _objects = lineIntersectsWith [
		_this,
		_testPos
	];

	{
		if diff(_x buildingPos 0,zeroPos) then {
			_object = _x;
			breakTo "0"
		};
		true
	} count _objects;
};

_object