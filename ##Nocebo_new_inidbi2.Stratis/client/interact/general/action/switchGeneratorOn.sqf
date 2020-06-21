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
	_object setVariable ["generatorRunning",[true,round time],true];

	{
		deleteVehicle _x;
	} count attachedObjects _object;
	private _pos = getPosATL _object;

	[_pos,"horde_sound_generatorStart",7] remoteExecCall [
		"horde_fnc_playSingleSound",
		_pos nearEntities ["ncb_player_base",50]
	];
	sleep 2;
	private _sound = createSoundSource [
		"Sound_Generator",
		_pos,
		[],
		0
	];
	_sound attachTo [_object,[0,0,0]];
};
true