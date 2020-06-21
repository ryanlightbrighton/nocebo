#include "\nocebo\defines\scriptDefines.hpp"

// note: accepts ASL only

params ["_holder","_objectPosASL","_objectDirAndUp"];

private _upPos = _objectPosASL;
waitUntil {
	_objectPosASL = _upPos;
	_upPos = [
		sel(_objectPosASL,0),
		sel(_objectPosASL,1),
		sel(_objectPosASL,2) + 0.01
	];
	not lineIntersects [_objectPosASL,_upPos,_holder]
	and {not terrainIntersectASL [_objectPosASL,_upPos]}
};
private _downPos = _objectPosASL;
waitUntil {
	_objectPosASL = _downPos;
	_downPos = [
		sel(_objectPosASL,0),
		sel(_objectPosASL,1),
		sel(_objectPosASL,2) - 0.01
	];
	lineIntersects [_objectPosASL,_downPos,_holder]
	or {terrainIntersectASL [_objectPosASL,_downPos]}
};

_holder setPosASL _objectPosASL;
[_holder,_objectDirAndUp] call horde_fnc_setVectorDirAndUpGlobal;

true

// DEPRECIATED.  USING WEAPONHOLDERSIMULATED RATHER THAN THIS NOW