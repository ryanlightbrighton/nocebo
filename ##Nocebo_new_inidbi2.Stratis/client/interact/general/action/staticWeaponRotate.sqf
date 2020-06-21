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
	setVar(missionNamespace,"playerPerformingAction",true);
	private _rot = getNumber (_cfgAction >> "rot");
	private _objectPosASL = getPosASL _object;
	private _dir = getDir _object;
	player playActionNow "PutDown";
	sleep 0.5;
	//[player,"CfgVehicles",_type] call horde_fnc_broadcastActionSound;
	detach _object;
	/*for "_i" from 1 to 30 do {
		_dir = _dir + (_rot/30);
		_dir = _dir call horde_fnc_normalDir;
		_object setPosASL _objectPosASL;
		_object setDir _dir;
		sleep 0.02;
	};*/
	_newDir = (_dir + _rot) call horde_fnc_normalDir;
	_object setVelocityTransformation [
		_objectPosASL,
		_objectPosASL,
		[0,0,0],
		[0,0,0],
		[sin _dir,cos _dir,0],
		[sin _newDir,cos _newDir,0],
		[0,0,1],
		[0,0,1],
		1
	];
	setVar(missionNamespace,"playerPerformingAction",nil);
};