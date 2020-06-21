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
	player playActionNow "PutDown"; // check what happens if lying down
	private _item = sel(_items,0);
	player removeItem _item;
	// complete on other players machine
	[missionNamespace,["ncb_gv_playerBleedingRate",0]] remoteExecCall [
		"setVariable",
		_object
	];
	private _text = format [
		"
			<t size='3.2'color='#FFFFFF'align='center'shadow='2'>
			You applied Medigel to %1.
			</t>
		",
		name _object
	];
	_text call horde_fnc_displayActionConfMessage;
};

true