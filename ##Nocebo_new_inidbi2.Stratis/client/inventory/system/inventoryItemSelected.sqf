#include "\nocebo\defines\scriptDefines.hpp"

"" call horde_fnc_closeItemMenu;

private _mouseButton = getVar(uiNamespace,"Horde_MouseButton");
if diff(_mouseButton,0) exitWith {};
private _idc = ctrlIDC sel(_this,0);
private _itemIndex = sel(_this,1);
private _item = lbData [_idc,_itemIndex];
private _name = lbText [_idc,_itemIndex];
private _config = configNull;
scopeName "0";
if same(_item,"") then {
	for "_i" from 0 to count cfgWeap - 1 do {
		private _cfgEntry = sel(cfgWeap,_i);
		if (isClass _cfgEntry) then {
			private _scope = getNumber (_cfgEntry >> "scope");
			if same(_scope,2) then {
				if same(getText (_cfgEntry >> "displayname"),_name) then {
					_item = configName _cfgEntry;
					_config = _cfgEntry;
					breakTo "0"
				};
			};
		};
	};
} else {
	_config = cfgMag >> _item;
	if (not (isClass _config)) then {
		_config = cfgWeap >> _item;
	};
};

private _cfgActions = _config >> "ItemActions";
private _numActions = count _cfgActions;
// actions in config (ie: anything except magazines)
if (_numActions > 0) then {
	ctrlPosition ((findDisplay 602) displayCtrl 1001) params ["_buttonX","_buttonY","_buttonW","_buttonH"];
	private _background = findDisplay 602 ctrlCreate ["Horde_BackGround",1620];
	_background ctrlSetPosition [_buttonX,_buttonY,_buttonW,_buttonH];
	_background ctrlSetBackgroundColor [0,0,0,1];
	_background ctrlCommit 0;
	private _menuH = _buttonH / _numActions;
	for "_i" from 0 to _numActions - 1 do {
		private _cfgAction = sel(_cfgActions,_i);
		private _subIDC = 1621 + _i;
		private _ctrl = findDisplay 602 ctrlCreate ["RscButtonActionMenu",_subIDC];
		_ctrl ctrlSetPosition [_buttonX,_buttonY,_buttonW,_menuH];
		_buttonY = _menuH + _buttonY;
		private _type = getText	(_cfgAction >> "text");
		private _script = getText (_cfgAction >> "script");
		_ctrl ctrlSetText _type;
		_ctrl ctrlRemoveAllEventHandlers "ButtonClick";
		private _id = _ctrl ctrlAddEventHandler [
			"ButtonClick",
			format [
				"_thisEventHandler = '%1' %2;",
				_item,
				_script
			]
		];

		_ctrl ctrlCommit 0;

		private _id = _ctrl ctrlAddEventHandler [
			"MouseEnter",
			format [
				"['Horde_GearDialogReference',%1,1,0.05] call horde_fnc_ctrlSetScale;",
				_subIDC
			]
		];
		private _id = _ctrl ctrlAddEventHandler [
			"MouseExit",
			format [
				"['Horde_GearDialogReference',%1,0.8,0.05] call horde_fnc_ctrlSetScale;",
				_subIDC
			]
		];
		["Horde_GearDialogReference",_subIDC,0.8,0] call horde_fnc_ctrlSetScale;
	};
} else {
	// mag actions
	if (_item isKindOf ["CA_Magazine",cfgMag]) then {
		private _ammoClassName = getText (_config >> "ammo");
		private _compatibleMags = +(uiNamespace getVariable ["ncb_uv_ammoMags_" + _ammoClassName,[]]);
		private _numActions = count _compatibleMags;
		if (_numActions > 0) then {
			_compatibleMags deleteAt (_compatibleMags find _item);
			_compatibleMags = [_item] + _compatibleMags;
			ctrlPosition ((findDisplay 602) displayCtrl 1001) params ["_buttonX","_buttonY","_buttonW","_buttonH"];
			private _background = findDisplay 602 ctrlCreate ["Horde_BackGround",1620];
			_background ctrlSetPosition [_buttonX,_buttonY,_buttonW,_buttonH];
			_background ctrlSetBackgroundColor [0,0,0,1];
			_background ctrlCommit 0;
			for "_i" from 0 to _numActions - 1 do {
				private _mag = _compatibleMags select _i;
				private _menuH = _buttonH / _numActions;
				private _subIDC = 1621 + _i;
				private _ctrl = findDisplay 602 ctrlCreate ["RscButtonActionMenu",_subIDC];
				_ctrl ctrlSetPosition [_buttonX,_buttonY,_buttonW,_menuH];
				_buttonY = _menuH + _buttonY;
				private _cfgAction = cfgMag >> _mag;
				if (_mag == _item) then {
					// consolidate
					_ctrl ctrlSetText "Consolidate";
					private _id = _ctrl ctrlAddEventHandler [
						"ButtonClick",
						format [
							"'%1' spawn horde_fnc_packSameType;",
							_item
						]
					];
				} else {
					// recombine
					_ctrl ctrlSetText (">> " + (getText (_cfgAction >> "displayName")));
					private _id = _ctrl ctrlAddEventHandler [
						"ButtonClick",
						format [
							"['%1','%2'] spawn horde_fnc_packDiffType;",
							_item,
							_mag
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
				private _id = _ctrl ctrlAddEventHandler [
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
};
true