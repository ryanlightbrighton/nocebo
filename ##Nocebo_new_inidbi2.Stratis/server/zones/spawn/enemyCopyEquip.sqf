#include "\nocebo\defines\scriptDefines.hpp"

params ["_unit","_loadout"];

_unit setUnitLoadout _loadout;

// skills

ncb_gv_aiSkills params ["_gen","_acc","_steady","_spd","_comm","_crge","_end","_reload","_sptDist","_spotTime"];
_unit setSkill _gen;
_unit setSkill ["aimingAccuracy",_acc];
_unit setSkill ["aimingShake",_steady];
_unit setSkill ["aimingSpeed",_spd];
_unit setSkill ["commanding",_comm];
_unit setSkill ["courage",_crge];
_unit setSkill ["endurance",_end];
_unit setSkill ["reloadSpeed",_reload];
_unit setSkill ["spotDistance",_sptDist];
_unit setSkill ["spotTime",_spotTime];

// params

if (ncb_param_aiAimingError isEqualTo 0) then {
	_unit disableAI "aimingerror"
};
if (ncb_param_aiAutoCombat isEqualTo 0) then {
	_unit disableAI "autocombat"
};
if (ncb_param_aiCover isEqualTo 0) then {
	_unit disableAI "cover"
};
if (ncb_param_aiFSM isEqualTo 0) then {
	_unit disableAI "fsm"
};
if (ncb_param_aiStamina isEqualTo 0) then {
	_unit enableStamina false
};
if (ncb_param_aiSuppression isEqualTo 0) then {
	_unit disableAI "suppression"
};

//disable this as unit spawns in pool

_unit disableAI "checkvisible";

true
