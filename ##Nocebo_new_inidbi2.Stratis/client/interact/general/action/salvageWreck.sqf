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

private _item = getVar(_object,"wreckSalvageItem");
private _displayNameItem = getText (cfgWeap >> _item >> "displayname");

private _cond = format [
	"'%1' in items player",
	_item
];
private _failText = format [
	"You need a %1 to salvage parts from this wreck",
	_displayNameItem
];
private _itemCond = [_cond,_failText];
_conditions pushBack _itemCond;

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
	setVar(missionNamespace,"playerPerformingAction","IN_PROGRESS");
	private _objectPosASL = getPosASL _object;
	private _objectDirAndUp = [vectorDir _object,vectorUp _object];
	[player,false] call horde_fnc_selectActionAnim;
	sleep 0.5;
	/*[player,"CfgVehicles",_type] call horde_fnc_broadcastActionSound;*/
	private _idx = player addEventHandler ["AnimDone",{
		if (sel(_this,1) == getVar(missionNamespace,"playerActionAnim")) then {
			setVar(missionNamespace,"playerPerformingAction","FINISHED")
		};
	}];
	private _frameHandlerID = (findDisplay 46) displayAddEventHandler ["KeyDown",{
		_this call horde_fnc_abortAction
	}];

	// update conditions

	_conditions set [0,["not isNil {missionNamespace getVariable 'playerPerformingAction'}",""]];
	_conditions set [1,["missionNamespace getVariable 'playerPerformingAction' == 'IN_PROGRESS'",""]];

	private _playerDir = getDir player;

	waitUntil {
		if diff(getDir player,_playerDir) then {
			player setDir _playerDir
		};
		_proceed = [
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
		if (not _proceed
			and {diff(getVar(missionNamespace,"playerPerformingAction"),"ABORTED")}
			and {diff(getVar(missionNamespace,"playerPerformingAction"),"FINISHED")}
		) then {
			0 call horde_fnc_resetAnims
		};
		not _proceed
	};

	player removeEventHandler ["AnimDone",_idx];
	(findDisplay 46) displayRemoveEventHandler ["KeyDown",_frameHandlerID];

	// update conditions

	_conditions set [0,["not isNil {missionNamespace getVariable 'playerPerformingAction'}",""]];
	_conditions set [1,["missionNamespace getVariable 'playerPerformingAction' == 'FINISHED'","Action aborted"]];

	_proceed = [
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
		private _output = getArray (_cfgAction >> "output");
		{
			_x call horde_fnc_deleteTestObj
		} count (nearestObjects [_object,["test_EmptyObjectForSmoke"],10]);
		{
			deleteVehicle _x;
		} count (nearestObjects [_object,["CraterLong"],50]);
		deleteVehicle _object;

		private _holder = _objectPosASL call horde_fnc_returnNearestHolder;
		if (isNull _holder) then {
			private _holderSpawnPos = (ASLtoATL _objectPosASL) vectorAdd [0,0,0.5];
			_holder = spawnVeh("WeaponHolderSimulated",_holderSpawnPos);
		};
		{
			private _number = 30 + ((round random 6) * 10);
			private _partClass = _x + str _number;
			_holder addBackpackCargoGlobal [_partClass,1];
		} forEach _output;

		private _text = "
			<t size='3.2'color='#FFFFFF'align='center'shadow='2'>
			You salvaged parts from the wreck.
			</t>
		";
		_text call horde_fnc_displayActionConfMessage;
	};
	setVar(missionNamespace,"playerPerformingAction",nil);
};