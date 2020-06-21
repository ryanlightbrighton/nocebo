#include "\nocebo\defines\scriptDefines.hpp"

private _handled = false;
private _keys = [];
{
	_keys = _keys + (actionKeys _x);
} forEach ["MoveForward","TurnLeft","TurnRight","ReloadMagazine","ShowMap","Gear","Binocular","GetOver","EvasiveLeft","EvasiveRight","Stand","Crouch","Prone","LeanLeft","LeanRight","LeanLeftToggle","LeanRightToggle","WalkRunToggle","TackToggle"];

if (sel(_this,1) in _keys) then {
	closeDialog 0;
	call {
		detach player;
		player switchMove "";
		if (currentWeapon player == primaryWeapon player) exitWith {
			player playMoveNow "amovpknlmstpsraswrfldnon";
		};
		if (currentWeapon player == secondaryWeapon player) exitWith {
			player playMoveNow "amovpknlmstpsraswlnrdnon";
		};
		if (currentWeapon player == handGunWeapon player) then {
			player playMoveNow "amovpknlmstpsraswpstdnon";
		} else {
			player playMoveNow "amovpknlmstpsnonwnondnon";
		};
	};
	private _text = "
		<t size='3.2'color='#FF0000'align='center'shadow='2'>
		Object dropped.
		</t>
	";
	_text call horde_fnc_displayActionRejMessage;
	setVar(missionNamespace,"playerPerformingAction",nil);
	private _var = getVar(missionNamespace,"ncb_gv_abortDragInfo");
	if (not isNil "_var") then {
		(findDisplay 46) displayRemoveEventHandler ["KeyDown",sel(_var,0)];
		detach sel(_var,1);
		player removeEventHandler ["Killed",sel(_var,2)];
		player removeEventHandler ["AnimChanged",sel(_var,3)];
		setVar(missionNamespace,"ncb_gv_abortDragInfo",nil);
	}
};
_handled