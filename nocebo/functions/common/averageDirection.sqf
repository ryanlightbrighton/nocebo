#include "\nocebo\defines\scriptDefines.hpp"

// EX: _dir = [100, 250, 325] call horde_fnc_averageDirection;

if empty(_this) exitWith {
	diag("error - empty array passed");
	0
};

private _aggVect = [0,0];
{
	private _posX = 1 * (sin _x);
	private _posY = 1 * (cos _x);
	_aggVect set [0,sel(_aggVect,0) + _posX];
	_aggVect set [1,sel(_aggVect,1) + _posY];
} count _this;
private _count = count _this;
_aggVect set [0,sel(_aggVect,0) / _count];
_aggVect set [1,sel(_aggVect,1) / _count];
private _avDir = sel(_aggVect,0) atan2 sel(_aggVect,1);

_avDir = _avDir call horde_fnc_normalDir;

_avDir