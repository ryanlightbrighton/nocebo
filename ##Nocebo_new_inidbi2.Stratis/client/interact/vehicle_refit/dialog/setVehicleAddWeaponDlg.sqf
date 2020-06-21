#include "\nocebo\defines\scriptDefines.hpp"

// SET UP THE DIALOG WHEN MOUSE HOVERS OVER BUTTON
getVar(uiNamespace,"uiInteractionInfo") params ["_object","_cfgEntry","_cfgObject"];
private _display = getVar(uiNamespace,"Horde_InteractionMenu");

params ["_classWeaponBagArr","_text","_vehicle","_script","_time","_ctrl"];

private _button = _display displayCtrl _ctrl;

private _tooltip = "Job time is " + (str _time) + " seconds";
_button ctrlSetTooltip _tooltip;
_button ctrlSetTooltipColorBox [1,1,1,0.8];
_button ctrlSetTooltipColorShade [0,0,0,1];

private _classWeaponBag = sel(_classWeaponBagArr,0);
private _cfgReqdWeapBag = configfile >> "CfgVehicles" >> _classWeaponBag;
private _reqdWeapBagPic = getText (_cfgReqdWeapBag >> "picture");
private _reqdWeapBagName = getText (_cfgReqdWeapBag >> "displayname");
private _reqdWeapBagModel = getText (_cfgReqdWeapBag >> "model");

private _classTripodBagArr = getArray (_cfgEntry >> "bagstand");
private _classTripodBag = sel(_classTripodBagArr,0);
private _cfgTripodBag = configfile >> "CfgVehicles" >> _classTripodBag;
private _reqdTripodBagName = getText (_cfgTripodBag >> "displayname");
private _reqdTripodBagPic = getText (_cfgTripodBag >> "picture");
private _reqdTripodBagModel = getText (_cfgTripodBag >> "model");

private _gotWeapBag = false;
private _weaponData = ["",objNull];

private _availableWeapBagPic = "client\gui\images\banned.paa";
private _availableWeapBagName = "";
private _availableWeapBagModel = "\A3\Weapons_f\empty";
private _locationWeaponBag = "";
private _backpack = backpack player;
if (_backpack in _classWeaponBagArr) then {
	private _cfgAvailableWeapBag = configfile >> "CfgVehicles" >> _backpack;
	_availableWeapBagPic = getText (_cfgAvailableWeapBag >> "picture");
	_availableWeapBagName = getText (_cfgAvailableWeapBag >> "displayname");
	_availableWeapBagModel = getText (_cfgAvailableWeapBag >> "model");
	_locationWeaponBag = name player;
	_gotWeapBag = true;
	_weaponData = [_backpack,player];
} else {
	{
		if (_x in _classWeaponBagArr) exitWith {
			private _cfgAvailableWeapBag = configfile >> "CfgVehicles" >> _x;
			_availableWeapBagPic = getText (_cfgAvailableWeapBag >> "picture");
			_availableWeapBagName = getText (_cfgAvailableWeapBag >> "displayname");
			_availableWeapBagModel = getText (_cfgAvailableWeapBag >> "model");
			_locationWeaponBag = getText (_cfgObject >> "displayname");
			_gotWeapBag = true;
			_weaponData = [_x,_object];
		};
	} forEach (backpackCargo _object);
};

private _gotTripodBag = false;
private _tripodData = ["",objNull];

private _availableTripodBagPic = "client\gui\images\banned.paa";
private _availableTripodBagModel = "\A3\Weapons_f\empty";
private _availableTripodBagName = "";
private _locationTripodBag = "";
if (_backpack == _classTripodBag) then {
	private _cfgAvailableTripodBag = configfile >> "CfgVehicles" >> _backpack;
	_availableTripodBagPic = getText (_cfgAvailableTripodBag >> "picture");
	_availableTripodBagName = getText (_cfgAvailableTripodBag >> "displayname");
	_availableTripodBagModel = getText (_cfgAvailableTripodBag >> "model");
	_locationTripodBag = name player;
	_gotTripodBag = true;
	_tripodData = [_backpack,player];
} else {
	{
		if (_x in _classTripodBagArr) exitWith {
			private _cfgAvailableTripodBag = configfile >> "CfgVehicles" >> _x;
			_availableTripodBagPic = getText (_cfgAvailableTripodBag >> "picture");
			_availableTripodBagName = getText (_cfgAvailableTripodBag >> "displayname");
			_availableTripodBagModel = getText (_cfgAvailableTripodBag >> "model");
			_locationTripodBag = getText (_cfgObject >> "displayname");
			_gotTripodBag = true;
			_tripodData = [_x,_object];
		};
	} forEach (backpackCargo _object);
};

uiNamespace setVariable ["ncb_uv_addWeaponBagData",[_weaponData,_tripodData]];

call {
	if (not _gotWeapBag) exitWith {
		_button ctrlRemoveEventHandler ["ButtonClick",0];
		_button ctrlSetEventHandler ["ButtonClick", format ["_thisEventHandler = %1 call horde_fnc_setTooltip;", [_ctrl,"You need the right weapon bag on your back or in the car's cargo",[1, 0, 0, 0.8]]]];
	};
	if (not _gotTripodBag) exitWith {
		_button ctrlRemoveEventHandler ["ButtonClick",0];
		_button ctrlSetEventHandler ["ButtonClick", format ["_thisEventHandler = %1 call horde_fnc_setTooltip;", [_ctrl,"You need a tripod bag on your back or in the car's cargo",[1, 0, 0, 0.8]]]];
		/*_button ctrlSetEventHandler ["ButtonClick", format ["_thisEventHandler = %1 call horde_fnc_setTooltip;", [_ctrl,_text]]];*/
	};
};

(_display displayCtrl 6666) ctrlSetModel _reqdWeapBagModel;
(_display displayCtrl 6667) ctrlSetModel _reqdTripodBagModel;
(_display displayCtrl 6669) ctrlSetModel _availableWeapBagModel;
(_display displayCtrl 6670) ctrlSetModel _availableTripodBagModel;

/*(_display displayCtrl 6668) ctrlSetText _toolModel;
(_display displayCtrl 6671) ctrlSetText _assignedToolModel;*/

(_display displayCtrl 1006) ctrlSetText _reqdWeapBagName;
(_display displayCtrl 1007) ctrlSetText _reqdTripodBagName;
(_display displayCtrl 1008) ctrlSetText _availableWeapBagName;
(_display displayCtrl 1009) ctrlSetText _locationWeaponBag;
(_display displayCtrl 1010) ctrlSetText _availableTripodBagName;
(_display displayCtrl 1011) ctrlSetText _locationTripodBag;
(_display displayCtrl 1200) ctrlSetText _reqdWeapBagPic;
(_display displayCtrl 1201) ctrlSetText _reqdTripodBagPic;
(_display displayCtrl 1202) ctrlSetText _availableWeapBagPic;
(_display displayCtrl 1203) ctrlSetText _availableTripodBagPic;
true