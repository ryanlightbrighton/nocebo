#include "\nocebo\defines\scriptDefines.hpp"

private _handled = false;
private _allKeys = [];
{
	_allKeys = _allKeys + (actionKeys _x);
} forEach ["MoveForward","TurnLeft","TurnRight","MoveBack","ReloadMagazine","ShowMap","Gear","Binocular","GetOver","EvasiveLeft","EvasiveRight","Stand","Crouch","Prone","LeanLeft","LeanRight","LeanLeftToggle","LeanRightToggle","WalkRunToggle","TackToggle"];

if (sel(_this,1) in _allKeys) then {
	setVar(missionNamespace,"playerPerformingAction","ABORTED");
	0 call horde_fnc_resetAnims;
};
_handled