#include "\nocebo\defines\scriptDefines.hpp"

_handle = (uiNamespace getVariable 'Horde_InteractionMenu') displayAddEventHandler ["KeyDown", "
	if ((_this select 1) in (actionKeys 'User13')) then {
		(uiNamespace getVariable 'Horde_InteractionMenu') displayRemoveEventHandler ['Keydown',(uiNamespace getVariable 'Horde_InteractionMenu') getVariable 'handle'];
		closeDialog 0;
	};
	false
"];
(uiNamespace getVariable 'Horde_InteractionMenu') setVariable ["handle",_handle];

getVar(uiNamespace,"uiInteractionInfo") params ["_object","_type","_cfgObject","_cfgActions","_intersectPos"];
private _display = getVar(uiNamespace,"Horde_InteractionMenu");

{
	if (not isNull (findDisplay 46 displayCtrl _x)) then {
		ctrlDelete (findDisplay 46 displayCtrl _x)
	};
} count [1929,1930,1931];

/*set up buttons*/

private _countActions = count _cfgActions;
private _failReason = "empty";
if (_countActions > 0) then {
	private _cfgControl = (missionConfigFile >> "Horde_interactionMenu_general" >> "Controls" >> "buttonTemplate");
	private _ctrlPosX = getNumber(_cfgControl >> "x");
	private _ctrlPosY = getNumber(_cfgControl >> "y");
	private _ctrlPosW = getNumber(_cfgControl >> "w");
	private _ctrlPosH = getNumber(_cfgControl >> "h");

	private _validActionIndexes = [];
	for "_i" from 0 to _countActions - 1 do {
		private _cfgAction = _cfgActions select _i;
		private _conditions = getArray (_cfgAction >> "conditions");
		private _assignedItem = getText (_cfgAction >> "assigneditem");
		private _distance = getNumber (_cfgAction >> "distance");
		private _input = getArray (_cfgAction >> "input");
		private _items = getArray (_cfgAction >> "items");
		private _magazines = getArray (_cfgAction >> "magazines");
		private _proceed = true;
		scopeName "indent_2";
		{
			private _cond = format [
				sel(_x,0),
				_assignedItem,
				_distance,
				_input,
				_items,
				_magazines
			];

			if (not (call compile _cond)) then {
				diag(_x);
				_proceed = false;
				private _objName = getText (_cfgObject >> "displayname");
				if (_object isKindOf "CAManBase" and {alive _object}) then {
					_objName = name _object;
				};
				_failReason = format [sel(_x,1),_objName];
				breakTo "indent_2";
			};
		} forEach _conditions;
		if (_proceed) then {
			_validActionIndexes pushBack _i;
		};
	};
	if (not empty(_validActionIndexes)) then {
		private _menuH = _ctrlPosH / (count _validActionIndexes);
		{
			private _actionIndex = _x;
			private _idc = 1600 + _actionIndex;
			private _cfgAction = _cfgActions select _actionIndex;
			private _button = _display ctrlCreate ["horde_RscButton",_idc];
			private _script = getText (_cfgAction >> "script");
			private _text = getText (_cfgAction >> "text");
			private _tooltip = call compile getText (_cfgAction >> "tooltip");
			_button ctrlSetText _text;
			_button ctrlShow true;
			_button ctrlSetPosition [
				_ctrlPosX,
				_ctrlPosY,
				_ctrlPosW,
				_menuH
			];
			_button ctrlCommit 0;
			["Horde_InteractionMenu",_idc,0.8,0] call horde_fnc_ctrlSetScale;
			_ctrlPosY = _menuH + _ctrlPosY;
			_button ctrlSetTooltip _tooltip;
			_button ctrlSetEventHandler [
				"MouseEnter",
				format ["%1 call horde_fnc_ctrlSetScale",["Horde_InteractionMenu",_idc,1,0.05]]
			];
			_button ctrlSetEventHandler [
				"MouseExit",
				format ["%1 call horde_fnc_ctrlSetScale",["Horde_InteractionMenu",_idc,0.8,0.05]]
			];
			_button ctrlSetEventHandler [
				"ButtonClick",
				format ["%1 %2;",_actionIndex,_script]
			];
			_button ctrlCommit 0;
		} forEach _validActionIndexes;
		setMousePosition [0.5,0.5];
	} else {
		[
			[_failReason],{
				call horde_fnc_getEachFrameArgs params ["_failReason"];
				if (dialog) then {
					closeDialog 0;
					private _text = format [
						"
							<t size='3.2'color='#FF0000'align='center'shadow='2'>
							%1
							</t>
						",
						_failReason
					];
					_text call horde_fnc_displayActionRejMessage;
					call horde_fnc_removeEachFrame
				}
			},
			0
		] call horde_fnc_addEachFrame;
	};
};

true