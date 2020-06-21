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
	playerPerformingAction = "IN_PROGRESS";
	player playActionNow "PutDown";
	private _vect = getPosASL player vectorFromTo getPosASL _object;
	_vect = _vect vectorMultiply 5;

	[
		[_object,_vect],{
			call horde_fnc_getEachFrameArgs params ["_object","_vect"];
			[_object,_vect] call horde_fnc_setVelocityGlobal;
			private _text = "
				<t size='3.2'color='#FFFFFF'align='center'shadow='2'>
				You pushed the boat.
				</t>
			";
			_text call horde_fnc_displayActionConfMessage;
			playerPerformingAction = nil;
			call horde_fnc_removeEachFrame
		},
		0.5
	] call horde_fnc_addEachFrame;
} else {
	private _text = "
		<t size='3.2'color='#FF0000'align='center'shadow='2'>
		You are already doing something.
		</t>
	";
	_text call horde_fnc_displayActionRejMessage;
};