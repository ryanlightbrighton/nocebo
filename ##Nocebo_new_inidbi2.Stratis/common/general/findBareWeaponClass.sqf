#include "\nocebo\defines\scriptDefines.hpp"

private _cfgParent = inheritsFrom (configFile >> "CfgWeapons" >> _this);
if (getNumber (_cfgParent >> "scope") == 2) then {
	_this = configName _cfgParent;
	_this = _this call horde_fnc_findBareWeaponClass;
};
_this