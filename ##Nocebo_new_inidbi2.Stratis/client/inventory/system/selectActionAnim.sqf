#include "\nocebo\defines\scriptDefines.hpp"

params ["_player","_allowedProne"];

private _stanceStr = "knl";
if (stance _player == "PRONE" and {_allowedProne}) then {
	_stanceStr = "pne";
};

private _weapStr = "non";
call {
	if (currentWeapon _player == primaryWeapon _player) exitWith {
		_weapStr = "rfl";
	};
	/*if (currentWeapon _player == secondaryWeapon _player) exitWith {
		_weapStr = "lnr";
	};*/
	if (currentWeapon _player == handgunWeapon _player) then {
		_weapStr = "pst";
	};
};
private _arr = [_stanceStr,_weapStr];
private _anim = "AinvP" + _stanceStr + "MstpSlayW" + _weapStr + "Dnon_medic";
_player playMoveNow _anim;
setVar(missionNamespace,"playerActionAnim",_anim);
setVar(missionNamespace,"playerResetAnim",_arr);
_anim