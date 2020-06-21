#include "\nocebo\defines\scriptDefines.hpp"

closeDialog 0;
getVar(uiNamespace,"uiInteractionInfo") params ["_object","_type","_cfgObject","_cfgActions","_intersectPos"];
private _cfgAction = sel(_cfgActions,_this);
private _conditions = getArray (_cfgAction >> "conditions");
_conditions set [7,["lifeState _object == 'incapacitated'","%1 is not incapacitated"]];  // workaround - update interactionInfo config!!
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
	0 call horde_fnc_selectReviveAnim;
	sleep 0.5;
	/*[player,"CfgVehicles",_type] call horde_fnc_broadcastActionSound;*/
	private _idx = -1;
	if ("ItemDefibrillator" in (items player)) then {
		_idx = player addEventHandler ["AnimDone",{
			if (sel(_this,1) == getVar(missionNamespace,"playerActionAnim")) then {
				setVar(missionNamespace,"playerPerformingAction","FINISHED")
			};
		}];
	} else {
		ncb_gv_playerReviveAnimIndex = 1;
		_idx = player addEventHandler ["AnimDone",{
			if (sel(_this,1) == getVar(missionNamespace,"playerActionAnim")) then {
				setVar(missionNamespace,"playerPerformingAction","FINISHED")
			} else {
				player playMoveNow ("AinvPknlMstpSnonWnonDnon_medic" + (str ncb_gv_playerReviveAnimIndex));
				ncb_gv_playerReviveAnimIndex = ncb_gv_playerReviveAnimIndex + 1;
			};
		}];
	};
	private _displayEHID = (findDisplay 46) displayAddEventHandler ["KeyDown",{
		_this call horde_fnc_abortAction
	}];

	// spawn items around player

	private _actionItems = ["medical","ItemDefibrillator"] call horde_fnc_spawnActionItems;

	// update conditions

	_conditions set [0,["not isNil {missionNamespace getVariable 'playerPerformingAction'}",""]];
	_conditions set [1,["missionNamespace getVariable 'playerPerformingAction' == 'IN_PROGRESS'",""]];
	/*_conditions deleteAt 8;*/ // HMM <<<<<<<<<<<<<<<<<< why I can't remember.....

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
	(findDisplay 46) displayRemoveEventHandler ["KeyDown",_displayEHID];

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
		player remoteExecCall [
			"horde_fnc_opReviveComplete",
			_object
		];
		private _text = format [
			"
				<t size='3.2'color='#FFFFFF'align='center'shadow='2'>
				You revived %1.
				</t>
			",
			name _object
		];
		_text call horde_fnc_displayActionConfMessage;
	};
	{
		deleteVehicle _x
	} count _actionItems;
	setVar(missionNamespace,"playerPerformingAction",nil);
};

true