#include "\nocebo\defines\scriptDefines.hpp"

private _clear = "weapon" call horde_fnc_closeItemMenu;

if diff(sel(_this,1),0) exitWith {false};
if (_clear) exitWith {false};

private _item = sel(_this,7);

// make sure player can only holster the right weapon (can't click on the wrong weapon)

if (currentWeapon player != "" and {_item != currentWeapon player}) exitWith {};

if diff(_item,"") then {
	private _cfgActions = configFile >> "CfgWeapons" >> _item >> "ItemActions";
	private _numActions = count _cfgActions;
	if (_numActions > 0) then {
		ctrlPosition ((findDisplay 602) displayCtrl 1001) params ["_buttonX","_buttonY","_buttonW","_buttonH"];
		private _background = findDisplay 602 ctrlCreate ["Horde_BackGround",1620];
		_background ctrlSetPosition [_buttonX,_buttonY,_buttonW,_buttonH];
		_background ctrlSetBackgroundColor [0,0,0,1];
		_background ctrlCommit 0;
		_background setVariable ["weapon",true];
		private _menuH = _buttonH / _numActions;
		for "_i" from 0 to _numActions - 1 do {
			private _cfgAction = sel(_cfgActions,_i);
			private _subIDC = 1621 + _i;
			private _ctrl = findDisplay 602 ctrlCreate ["RscButtonActionMenu",_subIDC];
			_ctrl ctrlSetPosition [_buttonX,_buttonY,_buttonW,_menuH];
			_buttonY = _menuH + _buttonY;
			if (currentWeapon player != "") then {
				_ctrl ctrlSetText getText (_cfgAction >> "text");
				private _id = _ctrl ctrlAddEventHandler [
					"ButtonClick",
					"player action ['SwitchWeapon',player,player,100]"
				];
			} else {
				_ctrl ctrlSetText "Ready Weapon";
				private _muzzles = getArray (configFile >> "CfgWeapons" >> _item  >> "muzzles");
				if (count _muzzles > 1) then {
					_item = _muzzles select 0
				};
				private _id = _ctrl ctrlAddEventHandler [
					"ButtonClick",
					format [
						"player selectWeapon '%1'",
						_item
					]
				];
			};
			_ctrl ctrlCommit 0;
			private _id = _ctrl ctrlAddEventHandler [
			"MouseEnter",
				format [
					"['Horde_GearDialogReference',%1,1,0.05] call horde_fnc_ctrlSetScale;",
					_subIDC
				]
			];
			_id = _ctrl ctrlAddEventHandler [
				"MouseExit",
				format [
					"['Horde_GearDialogReference',%1,0.8,0.05] call horde_fnc_ctrlSetScale;",
					_subIDC
				]
			];
			["Horde_GearDialogReference",_subIDC,0.8,0] call horde_fnc_ctrlSetScale;
		};
	};
};

true