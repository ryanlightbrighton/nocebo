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
	player playActionNow "PutDown";
	getArray (_cfgAction >> "output") params ["_class"];
	private _logic = "logic" createVehicleLocal [100,100,100];
	_logic attachTo [_object,[0,0,0]];
	detach _logic;
	deleteVehicle _object;
	private _fire = createVehicle [_class,[100,100,100],[],0,"can_collide"];
	_fire attachTo [_logic,[0,0,0]];
	deleteVehicle _logic;

	private _text = "
		<t size='3.2'color='#FFFFFF'align='center'shadow='2'>
		You lit the fire.
		</t>
	";
	_text call horde_fnc_displayActionConfMessage;
} else {
	_text = "
		<t size='3.2'color='#FF0000'align='center'shadow='2'>
		You are already doing something.
		</t>
	";
	_text call horde_fnc_displayActionRejMessage;
};

true