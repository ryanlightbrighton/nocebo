#include "\nocebo\defines\scriptDefines.hpp"

diag_log format ["setupDisabledAI running on %1", _this];
diag_log format ["test to see if params exist on this machine 'ncb_param_aiAimingError': %1", ncb_param_aiAimingError];

diag_log format ["test to see if stamina needs to be set up locally - ncb_param_aiStamina: %1 isStaminaEnabled for this unit %2", ncb_param_aiStamina,isStaminaEnabled _this];

if (ncb_param_aiAimingError isEqualTo 0) then {
	_this disableAI "aimingerror"
};
if (ncb_param_aiAutoCombat isEqualTo 0) then {
	_this disableAI "autocombat"
};
if (ncb_param_aiCover isEqualTo 0) then {
	_this disableAI "cover"
};
if (ncb_param_aiFSM isEqualTo 0) then {
	_this disableAI "fsm"
};
if (ncb_param_aiStamina isEqualTo 0) then {
	_this enableStamina false
};
if (ncb_param_aiSuppression isEqualTo 0) then {
	_this disableAI "suppression"
};

// if transferred back to server and in pool then disable AI "checkVisible" (also done in _horde_fnc_cacheGroup but don't know if it works) - test it there first and enable this if it does not

/*if (isServer and {_this distance unitPoolGuy < 500}) then {
	_this disableAI "checkVisible"
};*/

true