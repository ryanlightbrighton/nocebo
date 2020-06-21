#include "\nocebo\defines\scriptDefines.hpp"

private _handled = false;
private _allKeys = [];
{
	_allKeys = _allKeys + (actionKeys _x);
	true
} count ["MoveForward","TurnLeft","TurnRight","MoveBack","ReloadMagazine","ShowMap","Gear","Binocular","GetOver","EvasiveLeft","EvasiveRight","Stand","Crouch","Prone","LeanLeft","LeanRight","LeanLeftToggle","LeanRightToggle","WalkRunToggle","TackToggle"];

if (sel(_this,1) in _allKeys) then {
	if (not isNull getVar(uiNamespace,"ncb_ui_fixVehProgressBar")) then {
		ncb_layer_fixVehProgBar cutText ["","plain"];
	};
	/*player playMoveNow ncb_gv_interactionResetWeapon*/
};
_handled