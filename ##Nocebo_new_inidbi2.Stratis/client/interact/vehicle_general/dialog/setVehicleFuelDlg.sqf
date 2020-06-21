#include "\nocebo\defines\scriptDefines.hpp"

private _display = uiNamespace getVariable "Horde_InteractionMenu";
uiNamespace getVariable "uiInteractionInfo" params ["_object","_cfgEntry","_cfgObject"];
params ["_actionIndex","_ctrl","_partPrefix","_reqdItem"];

private _cfgActions = _cfgEntry >> "actions";
private _cfgAction = _cfgActions select _actionIndex;

private _button = _display displayCtrl _ctrl;

// blank the destroyed overlay

private _overlay = _display displayCtrl 1204;
_overlay ctrlSetText "";

private _time = getNumber (_cfgAction >> "basetime");

private _tooltip = "Job time is " + (str _time) + " seconds";
_button ctrlSetTooltip _tooltip;
_button ctrlSetTooltipColorBox [1, 1, 1, 0.8];
_button ctrlSetTooltipColorShade [0, 0, 0, 1];

private _reqdItem = getText (_cfgAction >> "item");
private _cfgReqdItem = configFile >> "CfgWeapons" >> _reqdItem;
private _reqdItemName = getText (_cfgReqdItem >> "displayname");
private _reqdItemPic = getText (_cfgReqdItem >> "picture");
private _assignedItem = "";
private _assignedItemName = "No Fuel Container";
private _assignedItemPic = "client\gui\images\banned.paa";
{
	if (_x == _reqdItem) exitWith {
		_assignedItem = _x;
		private _cfgAssignedItem = configFile >> "CfgWeapons" >> _assignedItem;
		_assignedItemName = getText (_cfgAssignedItem >> "displayname");
		_assignedItemPic = getText (_cfgAssignedItem >> "picture");
	};
} forEach items player;

private _currentFuel = fuel _object;
private _capacity = getNumber(configfile >> "CfgVehicles" >> (typeOf _object) >> "fuelCapacity");
// jerry can holds 20 litres
private _currentCapacity = _currentFuel * _capacity;
_currentCapacity = floor _currentCapacity;

private _fuelDisplay = str _currentCapacity + "/" + str _capacity;

// setup some specific conditions

private _actionType = configName _cfgAction;
private _locStatus = false;
private _hasPart = false;
call {
	If (_actionType == "fillFuelTank") exitWith {
		_locStatus = _currentFuel < 1;
		_hasPart = _assignedItem == _reqdItem;
	};
	If (_actionType == "syphonFuelTank") exitWith {
		_locStatus = _currentCapacity >= 20;
		_hasPart = _assignedItem == _reqdItem;
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
		_text = "Only one person can work on a vehicle at a time.";
		_failAction = true;
	};
	if (not _locStatus) exitWith {
		_failText = getText (_cfgAction >> "failTextLocStatus");
		_failAction = true;
	};
	if (not _hasPart) exitWith {
		_failText = getText (_cfgAction >> "failTextHasPart");
		_failAction = true;
	};
};

if (_failAction) then {
	_button ctrlSetEventHandler ["ButtonClick", format ["_thisEventHandler = %1 call horde_fnc_setTooltip;", [_ctrl,_failText,[1, 0, 0, 0.8]]]];
} else {
	private _script = getText (_cfgAction >> "script");
	_button ctrlSetEventHandler ["ButtonClick", format ["_handle = %1 %2;", [_actionIndex], _script]];
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
(_display displayCtrl 1004) ctrlSetText "Fuel level";
(_display displayCtrl 1200) ctrlSetText "";
(_display displayCtrl 1005) ctrlSetText "Litres";
// panel #2
(_display displayCtrl 1006) ctrlSetText "Required Can";
(_display displayCtrl 1201) ctrlSetText _reqdItemPic;
(_display displayCtrl 1007) ctrlSetText _reqdItemName;
// panel #3
(_display displayCtrl 1008) ctrlSetText "";
(_display displayCtrl 1202) ctrlSetText "";
(_display displayCtrl 1009) ctrlSetText "";
// panel #4
(_display displayCtrl 1010) ctrlSetText "Available Item";
(_display displayCtrl 1203) ctrlSetText _assignedItemPic;
(_display displayCtrl 1011) ctrlSetText _assignedItemName;

(_display displayCtrl 1013) ctrlSetText _fuelDisplay; // FUEL DISPLAY BUTTON (panel #1)
(_display displayCtrl 1204) ctrlSetText ""; // DESTROYED ICON (panel #1)

ctrlSetFocus _button;
true