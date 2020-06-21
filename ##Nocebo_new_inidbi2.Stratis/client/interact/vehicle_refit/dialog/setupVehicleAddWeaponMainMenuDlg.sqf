#include "\nocebo\defines\scriptDefines.hpp"

_handle = (uiNamespace getVariable 'Horde_InteractionMenu') displayAddEventHandler ["KeyDown", "
	if ((_this select 1) in (actionKeys 'User13')) then {
		(uiNamespace getVariable 'Horde_InteractionMenu') displayRemoveEventHandler ['Keydown',(uiNamespace getVariable 'Horde_InteractionMenu') getVariable 'handle'];
		closeDialog 0;
	};
	false
"];
(uiNamespace getVariable 'Horde_InteractionMenu') setVariable ["handle",_handle];


// set this up so it is neutral (mousing over the buttons will fill in the data)
getVar(uiNamespace,"uiInteractionInfo") params ["_object","_cfgEntry","_cfgObject"];

private _display = getVar(uiNamespace,"Horde_InteractionMenu");

private _locationName = getText (_cfgEntry >> "text");
private _displayName = getText (_cfgObject >> "displayname");
private _playerName = name player;

private _locData = getVar(_object,"ncb_AddWeapon");
If (isNil "_locData") then {
	_object setVariable ["ncb_AddWeapon",["",selectRandom (getArray (_cfgEntry >> "tools"))],true]
};

private _tool = sel(getVar(_object,"ncb_AddWeapon"),1);

private _cfgTool = configFile >> "CfgWeapons" >> _tool;
private _toolModel = getText (_cfgTool >> "model");
private _toolName = getText (_cfgTool >> "displayname");
private _toolPic = getText (_cfgTool >> "picture");

private _reqdWeapBagPic = "client\gui\images\banned.paa";
private _reqdWeapBagModel = "\A3\Weapons_f\empty";
private _reqdWeapBagName = "";

private _reqdStandBagPic = "client\gui\images\banned.paa";
private _reqdStandBagModel = "\A3\Weapons_f\empty";
private _reqdStandBagName = "";

private _availableWeapBagPic = "client\gui\images\banned.paa";
private _availableWeapBagModel = "\A3\Weapons_f\empty";
private _availableWeapBagName = "";

private _availableStandBagPic = "client\gui\images\banned.paa";
private _availableStandBagModel = "\A3\Weapons_f\empty";
private _availableStandBagName = "";


// assigned tool

private _assignedTool = "";
private _assignedToolModel = "\A3\Weapons_f\empty";
private _assignedToolName = "No tool available";
private _assignedToolPic = "client\gui\images\banned.paa";

private _gotTool = false;

/*{
	if (_x isKindOf ["ItemWatch",configFile >> "CfgWeapons"]) exitWith {
		_assignedTool = _x;
		_cfgTool = configFile >> "CfgWeapons" >> _assignedTool;
		_assignedToolModel = getText (_cfgTool >> "model");
		_assignedToolName = getText (_cfgTool >> "displayname");
		_assignedToolPic = getText (_cfgTool >> "picture");
		if (_x isEqualTo _tool) then {
			_gotTool = true;
		};
	};
} forEach assignedItems player;*/

{
	if (_x == _tool) exitWith {
		_assignedTool = _x;
		_cfgTool = configFile >> "CfgWeapons" >> _assignedTool;
		_assignedToolModel = getText (_cfgTool >> "model");
		_assignedToolName = getText (_cfgTool >> "displayname");
		_assignedToolPic = getText (_cfgTool >> "picture");
		_gotTool = true;
	};
} forEach items player;

// set up reset zones

for "_i" from 0 to 3 do {
	private _ctrl = 1500 + _i;
	private _button = _display displayCtrl _ctrl;
	_button ctrlShow true;
	_button ctrlSetEventHandler ["MouseEnter", "_thisEventHandler = 0 call horde_fnc_resetVehicleAddWeaponMainMenuDlg;"];
	_button ctrlCommit 0;
};

// set up dialog buttons

private _actionsArr = getArray (_cfgEntry >> "weaponconfig");
private _countActions = count _actionsArr;

if (_countActions > 0) then {
	[0.645833 * safezoneW + safezoneX,0.262 * safezoneH + safezoneY,0.123958 * safezoneW,0.63 * safezoneH] params ["_gcX","_gcY","_gcW","_gcH"];
	private _menuH = _gcH / _countActions;

	for "_i" from 0 to _countActions - 1 do {
		private _ctrl = 1600 + _i;
		private _action = sel(_actionsArr,_i);
		private _script = sel(_action,3);
		private _text = sel(_action,1);
		private _button = _display displayCtrl _ctrl;
		_button ctrlSetText _text;
		_button ctrlShow true;
		_button ctrlSetPosition [_gcX,_gcY,_gcW,_menuH];
		_gcY = _menuH + _gcY;
		_action pushBack _ctrl;
		if (_gotTool) then {
			_button ctrlSetEventHandler ["ButtonClick", format ["_handle = %1 %2;",_action,_script]];
		} else {
			_button ctrlSetEventHandler ["ButtonClick", format ["_handle = %1 call horde_fnc_setTooltip;", [_ctrl,"You do not have the right tool for the job",[1, 0, 0, 0.8]]]];
		};
		_button ctrlSetEventHandler ["MouseEnter", format ["_handle = %1 call horde_fnc_setVehicleAddWeaponDlg;" , _action]];
		_button ctrlCommit 0;
	};
};
// objects
(_display displayCtrl 6666) ctrlSetModel _reqdWeapBagModel;
(_display displayCtrl 6667) ctrlSetModel _reqdStandBagModel;
(_display displayCtrl 6669) ctrlSetModel _availableWeapBagModel;
(_display displayCtrl 6670) ctrlSetModel _availableStandBagModel;
(_display displayCtrl 6668) ctrlSetModel _toolModel;
(_display displayCtrl 6671) ctrlSetModel _assignedToolModel;

(_display displayCtrl 1000) ctrlSetText _displayName;
(_display displayCtrl 1002) ctrlSetText "Current Items";
(_display displayCtrl 1006) ctrlSetText _reqdWeapBagName;
(_display displayCtrl 1007) ctrlSetText _reqdStandBagName;
(_display displayCtrl 1008) ctrlSetText _availableWeapBagName;
(_display displayCtrl 1009) ctrlSetText ""; // LOCATION_WEAPONBAG
(_display displayCtrl 1010) ctrlSetText _availableStandBagName;
(_display displayCtrl 1011) ctrlSetText "";  // LOCATION_STANDBAG
(_display displayCtrl 1013) ctrlSetText _toolName;
(_display displayCtrl 1015) ctrlSetText _assignedToolName;
/*(_display displayCtrl 1200) ctrlSetText _reqdWeapBagPic;
(_display displayCtrl 1201) ctrlSetText _reqdStandBagPic;
(_display displayCtrl 1202) ctrlSetText _availableWeapBagPic;
(_display displayCtrl 1203) ctrlSetText _availableStandBagPic;
(_display displayCtrl 1204) ctrlSetText _toolPic;
(_display displayCtrl 1205) ctrlSetText _assignedToolPic;*/

ctrlSetFocus (_display displayCtrl 1599);
true