#include "\nocebo\defines\scriptDefines.hpp"

// SET UP THE DIALOG WHEN MOUSE HOVERS OVER BUTTON

private _display = uiNamespace getVariable "Horde_InteractionMenu";
uiNamespace getVariable "uiInteractionInfo" params ["_object","_cfgEntry","_cfgObject"];
params ["_actionIndex","_ctrl","_partPrefix","_reqdItem"];

private _cfgActions = _cfgEntry >> "actions";
private _cfgAction = _cfgActions select _actionIndex;

private _button = _display displayCtrl _ctrl;

private _time = getNumber (_cfgAction >> "basetime");

private _tooltip = "Job time is " + (str _time) + " seconds";
_button ctrlSetTooltip _tooltip;
_button ctrlSetTooltipColorBox [1, 1, 1, 0.8];
_button ctrlSetTooltipColorShade [0, 0, 0, 1];

private _location = getArray (_cfgEntry >> "location");
private _hitPointDamage = 0;
{
	private _dam = _object getHitPointDamage _x;
	if (not isNil "_dam" and {_dam > _hitPointDamage}) then {
		_hitPointDamage = _dam
	}
} forEach _location;
private _partHealthNumb = [typeOf _object,configName _cfgEntry,_hitPointDamage] call horde_fnc_realDamToRepairHealth;
private _partHealth = str round _partHealthNumb + "% Health";
private _reqdPart = _partPrefix + str 100;
private _cfgReqdPart = configFile >> "CfgVehicles" >> _reqdPart;
private _reqdPartName = getText (_cfgReqdPart >> "horde_displayname");
private _reqdPartPic = getText (_cfgReqdPart >> "picture");
private _cfgReqdItem = configFile >> "CfgWeapons" >> _reqdItem;
private _reqdItemName = getText (_cfgReqdItem >> "displayname");
private _reqdItemPic = getText (_cfgReqdItem >> "picture");
private _assignedItemArr = uiNamespace getVariable "ncb_uv_playerAssignedItemInfo";
private _assignedItem = _assignedItemArr select 0;
private _assignedItemName = _assignedItemArr select 1;
private _assignedItemPic = _assignedItemArr select 2;

// player compatible parts

private _availableParts = "";
private _availablePartsName = "No parts";
private _availablePartsPic = "client\gui\images\banned.paa";
private _availablePartsClassPrefix = "";
private _bag = backpack player;



if (_bag isKindOf "Horde_VehiclePartsBag_Base"
	or {_bag isKindOf "Horde_AircraftPartsBag_Base"}
) then {
	private _cfgAvailableParts = configFile >> "CfgVehicles" >> _bag;
	_availablePartsName = getText (_cfgAvailableParts >> "horde_displayName");
	_availablePartsName = getText (_cfgAvailableParts >> "descriptionshort");
	_availablePartsPic = getText (_cfgAvailableParts >> "picture");
	_availablePartsClassPrefix = getText (_cfgAvailableParts >> "horde_classPrefix");
};

private _isDestroyed = false;
private _destroyedIcon = "";
if (_partHealthNumb == 0) then {
	_reqdPartPic = "";
	_destroyedIcon = "client\gui\images\banned.paa";
	_isDestroyed = true;
};

// setup some specific conditions

private _actionType = configName _cfgAction;
private _locStatus = false;
private _hasPart = false;

call {
	If (_actionType == "addTyre") exitWith {
		_locStatus = _isDestroyed;
		_hasPart = _availablePartsClassPrefix == _partPrefix;
	};
	If (_actionType == "addParts") exitWith {
		_locStatus = _hitPointDamage != 0;
		_hasPart = _availablePartsClassPrefix == _partPrefix;
	};
	If (_actionType == "swapParts") exitWith {
		_locStatus = not _isDestroyed;
		_hasPart = _availablePartsClassPrefix == _partPrefix;
	};
	If (_actionType == "takeParts") exitWith {
		_locStatus = not _isDestroyed;
		_hasPart = true;
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
	if ({alive _x} count crew _object > 0) exitWith {
		_failText = "You can't work on a vehicle while it is occupied.";
		_failAction = true;
	};
	if (isPlayer (_object getVariable ["vehiclePlayerInteracting",objNull])) exitWith {
		_failText = "Only one person can work on a vehicle at a time.";
		_failAction = true;
	};
	if (_assignedItem != _reqdItem) exitWith {
		_failText = "You do not have the right item for the job.";
		_failAction = true;
	};
	if (not _locStatus) exitWith {
		_failText = getText (_cfgAction >> "failTextLocStatus");
		_textParts = getText (_cfgEntry >> "text");
		_failText = format [_failText, _textParts];
		_failAction = true;
	};
	if (not _hasPart) exitWith {
		_failText = getText (_cfgAction >> "failTextHasPart");
		_textParts = getText (_cfgEntry >> "textparts");
		_failText = format [_failText, _textParts];
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
(_display displayCtrl 1004) ctrlSetText _reqdPartName;
(_display displayCtrl 1200) ctrlSetText _reqdPartPic;
(_display displayCtrl 1005) ctrlSetText _partHealth;
// panel #2
(_display displayCtrl 1006) ctrlSetText "Required Tool";
(_display displayCtrl 1201) ctrlSetText _reqdItemPic;
(_display displayCtrl 1007) ctrlSetText _reqdItemName;
// panel #3
(_display displayCtrl 1008) ctrlSetText "Available Parts";
(_display displayCtrl 1202) ctrlSetText _availablePartsPic;
(_display displayCtrl 1009) ctrlSetText _availablePartsName;
// panel #4
(_display displayCtrl 1010) ctrlSetText "Available Item";
(_display displayCtrl 1203) ctrlSetText _assignedItemPic;
(_display displayCtrl 1011) ctrlSetText _assignedItemName;

(_display displayCtrl 1013) ctrlSetText ""; // FUEL DISPLAY BUTTON (panel #1)
(_display displayCtrl 1204) ctrlSetText _destroyedIcon; // DESTROYED ICON (panel #1)

ctrlSetFocus _button;
true