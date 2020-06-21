#include "\nocebo\defines\scriptDefines.hpp"

closeDialog 0;

getVar(uiNamespace,"uiInteractionInfo") params ["_object","_type","_cfgObject","_cfgActions","_intersectPos"];

diag(_object);
diag(_type);
diag(_cfgObject);
diag(_cfgActions);
diag(_intersectPos);
diag(_this);
private _cfgAction = sel(_cfgActions,_this);
private _conditions = getArray (_cfgAction >> "conditions");
private _assignedItem = getText (_cfgAction >> "assigneditem");
private _distance = getNumber (_cfgAction >> "distance");
private _input = getArray (_cfgAction >> "input");
private _items = getArray (_cfgAction >> "items");
private _magazines = getArray (_cfgAction >> "magazines");

diag(_cfgAction);
diag(_conditions);
diag(_assignedItem);
diag(_distance);
diag(_input);
diag(_items);
diag(_magazines);

// setup variables for next script

private _arr = [
	_object,
	_cfgObject,
	_conditions,
	_assignedItem,
	_intersectPos,
	_distance,
	_input,
	_items,
	_magazines
];

setVar(missionNamespace,"NETWORK_ACTION_ARGS",_arr);

if (_arr call horde_fnc_testInteractionConditions) then {
	private _item = sel(_items,0);
	diag(_item);

	[player,_object,0,"REQUEST",_item] remoteExec [
	 	"horde_fnc_opBandage",
		_object
	];
};
true

