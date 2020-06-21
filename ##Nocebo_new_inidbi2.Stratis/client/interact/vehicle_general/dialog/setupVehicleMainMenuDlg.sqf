#include "\nocebo\defines\scriptDefines.hpp"

_handle = (uiNamespace getVariable 'Horde_InteractionMenu') displayAddEventHandler ["KeyDown", "
	if ((_this select 1) in (actionKeys 'User13')) then {
		(uiNamespace getVariable 'Horde_InteractionMenu') displayRemoveEventHandler ['Keydown',(uiNamespace getVariable 'Horde_InteractionMenu') getVariable 'handle'];
		closeDialog 0;
	};
	false
"];
(uiNamespace getVariable 'Horde_InteractionMenu') setVariable ["handle",_handle];

uiNamespace getVariable "uiInteractionInfo" params ["_object","_cfgEntry","_cfgObject"];

private _display = uiNamespace getVariable "Horde_InteractionMenu";
private _loc = "ncb_" + configName _cfgEntry;

/*required repair item*/

private _saveData = if (isNil {_object getVariable _loc}) then {true} else {false};

_object getVariable [_loc,[getText (_cfgEntry >> "parts"),selectRandom (getArray (_cfgEntry >> "tools"))]] params ["_partPrefix","_reqdItem"];

private _nameItem = getText(configFile >> "CfgWeapons" >> _reqdItem >> "displayname");

if (_saveData) then {
	_object setVariable [_loc,[_partPrefix, _reqdItem],true]
};

/*assigned tool*/

private _assignedItem = "";
private _assignedItemName = "Tool not available";
private _assignedItemPic = "client\gui\images\banned.paa";

/*{
	if (_x isKindOf ["ItemWatch",configFile >> "CfgWeapons"]) exitWith {
		_assignedItem = _x;
		private _cfgAssignedItem = configFile >> "CfgWeapons" >> _assignedItem;
		_assignedItemName = getText (_cfgAssignedItem >> "displayname");
		_assignedItemPic = getText (_cfgAssignedItem >> "picture");
	};
} forEach assignedItems player;*/

{
	if (_x == _reqdItem) exitWith {
		_assignedItem = _x;
		private _cfgAssignedItem = configFile >> "CfgWeapons" >> _assignedItem;
		_assignedItemName = getText (_cfgAssignedItem >> "displayname");
		_assignedItemPic = getText (_cfgAssignedItem >> "picture");
	};
} forEach items player;

uiNamespace setVariable ["ncb_uv_playerAssignedItemInfo", [_assignedItem,_assignedItemName,_assignedItemPic]];

/*set up reset zones*/

for "_i" from 0 to 3 do {
	private _ctrl = 1500 + _i;
	private _button = _display displayCtrl _ctrl;
	_button ctrlShow true;
	_button ctrlSetEventHandler ["MouseEnter", "_handle = 0 call horde_fnc_resetVehicleMainMenuDlg;"];
	_button ctrlCommit 0;
};

/*set up buttons*/

private _cfgActions = _cfgEntry >> "actions";
private _countActions = count _cfgActions;

if (_countActions > 0) then {
	private _gcPosArr = [0.507292 * safezoneW + safezoneX,0.276 * safezoneH + safezoneY,0.2625 * safezoneW,0.616 * safezoneH];
	private _gcX = sel(_gcPosArr,0);
	private _gcY = sel(_gcPosArr,1);
	private _gcW = sel(_gcPosArr,2);
	private _gcH = sel(_gcPosArr,3);

	private _menuH = _gcH / _countActions;

	for "_i" from 0 to _countActions - 1 do {
		private _ctrl = 1600 + _i;
		private _cfgAction = _cfgActions select _i;
		private _time = getNumber (_cfgAction >> "baseTime");
		private _script = getText (_cfgAction >> "script");
		private _setupType = getText (_cfgAction >> "type");
		private _text = getText (_cfgAction >> "text");
		private _button = _display displayCtrl _ctrl;
		_button ctrlSetText _text;
		_button ctrlShow true;
		_button ctrlSetPosition [_gcX,_gcY,_gcW,_menuH];
		_gcY = _menuH + _gcY;
		_button ctrlSetEventHandler ["MouseEnter", format ["_handle = %1 %2;" ,[_i,_ctrl,_partPrefix,_reqdItem],_setupType]];
		if (configName _cfgAction == "reload") then {
			_button ctrlSetEventHandler ["ButtonClick", "createDialog 'reloadMenu'"];
		};
		_button ctrlCommit 0;
	};
};

(_display displayCtrl 1000) ctrlSetText (getText (_cfgObject >> "displayname"));
(_display displayCtrl 1002) ctrlSetText (name player);
(_display displayCtrl 1003) ctrlSetText (getText (_cfgEntry >> "text"));
true