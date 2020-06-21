#include "\nocebo\defines\scriptDefines.hpp"

private _return = [objNull,[0,0,0],[0,0,1],false];

private _intersects = lineIntersectsSurfaces [
	AGLToASL positionCameraToWorld [0,0,0],
	AGLToASL positionCameraToWorld [0,0,10],
	vehicle player,
	objNull,
	true,
	1,
	"FIRE",
	"NONE"
];
private _isCharge = false;
if not empty(_intersects) then {
	_intersects select 0 params ["_posASL","_normal","","_parent"];
	if not (_parent isKindOf "WeaponHolder") then {
		_this = _parent;
		if (_this isKindOf "TimeBombCore"
			or {_this isKindOf "SmokeShell"}
		) then {
			_isCharge = true
		};
		_return = [_this,_posASL,_normal,_isCharge];
	};
};
_return
