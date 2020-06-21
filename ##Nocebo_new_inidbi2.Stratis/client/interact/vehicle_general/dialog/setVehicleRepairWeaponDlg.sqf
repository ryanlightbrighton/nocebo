#include "\nocebo\defines\scriptDefines.hpp"

private _display = uiNamespace getVariable "Horde_InteractionMenu";
uiNamespace getVariable "uiInteractionInfo" params ["_object","_cfgEntry","_cfgObject"];
params ["_actionIndex","_ctrl","_partPrefix","_reqdItem"];

private _assignedItemArr = uiNamespace getVariable "ncb_uv_playerAssignedItemInfo";
private _assignedItem = _assignedItemArr select 0;
private _assignedItemName = _assignedItemArr select 1;
private _assignedItemPic = _assignedItemArr select 2;

private _cfgActions = _cfgEntry >> "actions";
private _cfgAction = _cfgActions select _actionIndex;

private _button = _display displayCtrl _ctrl;

private _time = getNumber (_cfgAction >> "basetime");

private _tooltip = "Job time is " + (str _time) + " seconds";
_button ctrlSetTooltip _tooltip;
_button ctrlSetTooltipColorBox [1, 1, 1, 0.8];
_button ctrlSetTooltipColorShade [0, 0, 0, 1];

private _location = getText (_cfgEntry >> "location");
private _hitPointDamage = _object getHitPointDamage _location;
private _partHealth = str round((1 - _hitPointDamage) * 100) + "% Health";

private _cfgReqdItem = configFile >> "CfgWeapons" >> _reqdItem;
private _reqdItemName = getText (_cfgReqdItem >> "displayname");
private _reqdItemPic = getText (_cfgReqdItem >> "picture");

private _classWeaponBag = getText (_cfgEntry >> "parts");


// THIS IS BOLLOCKS AND WILL ONLY WORK PROPERLY FOR TURRETS WITH ONE WEAPON IN THEM
// MOVE THE REQUIRED PARTS/BAG INFO TO THE CFGWEAPON ENTRY AND ACCESS FROM THERE
// IN THE NEXT WINDOW (WHICH ISN'T SET UP YET!!!!!)

private _cfgReqdWeapBag = configfile >> "CfgVehicles" >> _classWeaponBag;
private _reqdWeapBagPic = getText (_cfgReqdWeapBag >> "picture");
private _reqdWeapBagName = getText (_cfgReqdWeapBag >> "displayname");

private _availableWeapBagPic = "client\gui\images\banned.paa";
private _availableWeapBagName = "";

private _gotWeapBag = false;

private _backpack = backpack player;
if (_backpack != "") then {
	if (_backpack == _classWeaponBag) then {
		_availableWeapBagPic = _reqdWeapBagPic;
		_availableWeapBagName = _reqdWeapBagName;
		_gotWeapBag = true;
	} else {
		_availableWeapBagPic = getText (configfile >> "CfgVehicles" >> _backpack >> "picture");
		_availableWeapBagName = getText (configfile >> "CfgVehicles" >> _backpack >> "displayname");
	};
};

// setup some specific conditions

private _actionType = configName _cfgAction;
private _locStatus = false;
private _hasPart = false;

call {
	If (_actionType == "repairWeapons") exitWith {
		_locStatus = _hitPointDamage >= 0.9;
		_hasPart = _gotWeapBag;
	};
	If (_actionType == "repairWeaponMount") exitWith {
		_locStatus = _hitPointDamage >= 0.9;
		_hasPart = _gotWeapBag;
	};
};

// check for fails

private _failAction = false;
private _failText = "";
call {
	if (isEngineOn _object) exitWith {
		_failText = "You can't work on a vehicle while the engine is running.";
		_failAction = true;
	};
	if (not ((crew _object) isEqualTo [])) exitWith {
		_failText = "You can't work on a vehicle while it is occupied.";
		_failAction = true;
	};
	if (isPlayer (_object getVariable ["vehiclePlayerInteracting",objNull])) exitWith {
		_failText = "Only one person can work on a vehicle at a time.";
		_failAction = true;
	};
	if (not _locStatus) exitWith {
		_failText = getText (_cfgAction >> "failTextLocStatus");
		_failAction = true;
	};
	if (not _hasPart) exitWith {
		_text = getText (_cfgEntry >> "text");
		_failText = "You need a " + _reqdWeapBagName + " to repair this " + _text;
		_failAction = true;
	};
	if (_assignedItem != _reqdItem) exitWith {
		_failText = "You do not have the right item for the job.";
		_failAction = true;
	};
};

if (_failAction) then {
	_button ctrlSetEventHandler ["ButtonClick", format ["_thisEventHandler = %1 call horde_fnc_setTooltip;", [_ctrl,_failText,[1, 0, 0, 0.8]]]];
} else {
	private _script = getText (_cfgAction >> "script");
	_button ctrlSetEventHandler ["ButtonClick", format ["_handle = %1 %2;", [_actionIndex,_reqdItem], _script]];
};

/*
	WINDOWS KEY FOR DIALOG:

	HEADER  #1 = 1004	|	HEADER  #2 = 1006
	PICTURE #1 = 1200	|	PICTURE #2 = 1201
	FOOTER  #1 = 1005	|	FOOTER  #2 = 1007
						|
	--------------------|--------------------
						|
	HEADER  #3 = 1008	|	HEADER  #4 = 1010
	PICTURE #3 = 1202	|	PICTURE #4 = 1203
	FOOTER  #3 = 1009	|	FOOTER  #4 = 1011
*/

// panel #1
(_display displayCtrl 1004) ctrlSetText _reqdWeapBagName;
(_display displayCtrl 1200) ctrlSetText _reqdWeapBagPic;
(_display displayCtrl 1005) ctrlSetText _partHealth;
// panel #2
(_display displayCtrl 1006) ctrlSetText "Required Tool";
(_display displayCtrl 1201) ctrlSetText _reqdItemPic;
(_display displayCtrl 1007) ctrlSetText _reqdItemName;
// panel #3
(_display displayCtrl 1008) ctrlSetText "Backpack";
(_display displayCtrl 1202) ctrlSetText _availableWeapBagPic;
(_display displayCtrl 1009) ctrlSetText _availableWeapBagName;
// panel #4
(_display displayCtrl 1010) ctrlSetText "Available Item";
(_display displayCtrl 1203) ctrlSetText _assignedItemPic;
(_display displayCtrl 1011) ctrlSetText _assignedItemName;

(_display displayCtrl 1013) ctrlSetText ""; // FUEL DISPLAY BUTTON (panel #1)
(_display displayCtrl 1204) ctrlSetText ""; // DESTROYED ICON (panel #1)

ctrlSetFocus _button;
true