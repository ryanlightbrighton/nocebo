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
	setVar(missionNamespace,"playerPerformingAction","IN_PROGRESS");
	player removeItem (_items # 0);
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

	// spawn items around player

	private _actionItems = ["medical",(_items # 0)] call horde_fnc_spawnActionItems;

	// update conditions

	_conditions set [0,["not isNil {missionNamespace getVariable 'playerPerformingAction'}",""]];
	_conditions set [1,["missionNamespace getVariable 'playerPerformingAction' == 'IN_PROGRESS'",""]];
	_conditions deleteAt 9;

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
		// gah!  lodged bullets! (complete on other players machine)
		player remoteExecCall [
			"horde_fnc_opBloodBagComplete",
			_object
		];
		private _text = format [
			"
				<t size='3.2'color='#FFFFFF'align='center'shadow='2'>
				You gave a bloodbag to %1.
				</t>
			",
			name _object
		];
		_text call horde_fnc_displayActionConfMessage;
	} else {
		player addItem (_items # 0);
	};
	{
		deleteVehicle _x
	} count _actionItems;
	setVar(missionNamespace,"playerPerformingAction",nil);
};

true