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
	[
		[0,_object],{
			call horde_fnc_getEachFrameArgs params ["_count","_object"];
			if (_count < 50) then {
				_count = _count + 1;
				_object setPosWorld (getPosWorld _object vectorAdd [0,0,-0.03]);
				[_count,_object] call horde_fnc_updateEachFrameArgs;
			} else {
				deleteVehicle _object;
				call horde_fnc_removeEachFrame
			};
		},
		0.1
	] call horde_fnc_addEachFrame;

	private _text = "
		<t size='3.2'color='#FFFFFF'align='center'shadow='2'>
		You hid the fire.
		</t>
	";
	_text call horde_fnc_displayActionConfMessage;
} else {
	private _text = "
		<t size='3.2'color='#FF0000'align='center'shadow='2'>
		You are already doing something.
		</t>
	";
	_text call horde_fnc_displayActionRejMessage;
};

true