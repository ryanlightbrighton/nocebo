#include "\nocebo\defines\scriptDefines.hpp"

closeDialog 0;

getVar(uiNamespace,"uiInteractionInfo") params ["_object","_type","_cfgObject","_cfgActions","_intersectPos"];
private _cfgAction = sel(_cfgActions,_this);
private _conditions = getArray (_cfgAction >> "conditions");
private _assignedItem = getText (_cfgAction >> "assigneditem");
private _distance = getNumber (_cfgAction >> "distance");
private _input = getArray (_cfgAction >> "input");
private _items = getArray (_cfgAction >> "items");
private _magazines = getArray (_cfgAction >> "magazines");
private _proceed = [
	_object,
	_cfgObject,
	_conditions,
	_assignedItem,
	_intersectPos,
	_distance,
	_input,
	_items,
	_magazines
] call horde_fnc_testInteractionConditions;
if (_proceed) then {
	// open gear and inform other player
	private _delay = 0;
	if (isPlayer _object and {alive _object}) then {
		private _text = format [
			"
				<t size='3.2'color='#FF0000'align='center'shadow='2'>
				%1 is accessing your inventory.
				</t>
			",
			name player
		];
		_text remoteExecCall [
			"horde_fnc_displayActionRejMessage",
			_object
		];

		if ((group player) isEqualTo (group _object)) then {
			_delay = 1.5
		};
	};

	[
		[_object],{
			call horde_fnc_getEachFrameArgs params ["_object"];
			if (_object isKindOf "WeaponHolderSimulated") then {
				private _nHolders = nearestObjects [
					_object,
					["CAManBase"],
					3
				];
				{
					if (alive _x) then {
						_nHolders set [_forEachIndex,objNull]
					};
				} forEach _nHolders;
				_nHolders = _nHolders - [objNull];
				if not (empty(_nHolders)) then {
					_object = sel(_nHolders,0);
				};
			};
			player action ["gear",_object];
			call horde_fnc_removeEachFrame
		},
		_delay
	] call horde_fnc_addEachFrame;
};
true

