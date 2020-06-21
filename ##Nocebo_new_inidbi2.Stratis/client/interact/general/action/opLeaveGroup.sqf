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
	private _grp = group player;
	player remoteExecCall [
		"horde_fnc_serverConfirmLeaveGroup",
		2
	];
	private _text = format [
		"
			<t size='3.2'color='#FFFFFF'align='center'shadow='2'>
			%1 has left the group
			</t>
		",
		name player
	];
	_text remoteExecCall [
		"horde_fnc_displayActionConfMessage",
		units _grp
	];
	_text = format [
		"
			<t size='3.2'color='#FFFFFF'align='center'shadow='2'>
			You have left %1
			</t>
		",
		groupID _grp
	];
	_text remoteExecCall [
		"horde_fnc_displayActionConfMessage",
		player
	];
};
true

