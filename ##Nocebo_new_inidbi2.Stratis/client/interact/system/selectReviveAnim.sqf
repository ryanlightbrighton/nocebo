#include "\nocebo\defines\scriptDefines.hpp"

private _anim = "AinvPknlMstpSnonWnonDnon_medic0";
private _animFinish = "AinvPknlMstpSnonWnonDnon_medic5";
if ("ItemDefibrillator" in (items player)) then {
	_anim = "AinvPknlMstpSlayWrflDnon_medicOther";
	_animFinish = "AinvPknlMstpSlayWrflDnon_medicOther";
};

private _weapStr = "non";
call {
	if (currentWeapon player == primaryWeapon player) exitWith {
		_weapStr = "rfl";
	};
	if (currentWeapon player == secondaryWeapon player) exitWith {
		_weapStr = "lnr";
	};
	if (currentWeapon player == handgunWeapon player) then {
		_weapStr = "pst";
	};
};
private _arr = ["knl",_weapStr];
player playMoveNow _anim;
setVar(missionNamespace,"playerActionAnim",_animFinish);
setVar(missionNamespace,"playerResetAnim",_arr);
true