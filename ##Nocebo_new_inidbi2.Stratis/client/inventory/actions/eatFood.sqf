#include "\nocebo\defines\scriptDefines.hpp"

closeDialog 0;
if (isNil {getVar(missionNamespace,"playerPerformingAction")}) then {
	if (ncb_gv_playerFood > 90) exitWith {
		private _text = "
			<t size='3.2'color='#FF0000'align='center'shadow='2'>
			You are too full to eat right now
			</t>
		";
		_text call horde_fnc_displayActionRejMessage;
	};
	private _cfgWeap = cfgWeap >> _this;
	private _incFood = getNumber (_cfgWeap >> "horde_increase_food");
	private _decDamage = getNumber (_cfgWeap >> "horde_restore_health");
	player removeItem _this;
	if diff(vehicle player,player) exitWith {
		ncb_gv_playerFood = ncb_gv_playerFood + _incFood min 100;
		private _damage = damage player;
		private _minHealth = ncb_gv_playerLodgedBullets * 0.07;
		private _newDamage = _damage - _decDamage;
		if (_newDamage < _minHealth) then {
			_newDamage = _minHealth;
		};
		player setDamage _newDamage;
		private _text = "
			<t size='3.2'color='#FFFFFF'align='center'shadow='2'>
			You ate some food.
			</t>
		";
		_text call horde_fnc_displayActionConfMessage;
	};
	setVar(missionNamespace,"playerPerformingAction","IN_PROGRESS");
	[player,true] call horde_fnc_selectActionAnim;
	private _actionItems = ["eat",_this] call horde_fnc_spawnActionItems;
	sleep 0.5;
	[player,"CfgWeapons",_this] call horde_fnc_broadcastActionSound;
	private _idx = player addEventHandler ["AnimDone",{
		if (sel(_this,1) == getVar(missionNamespace,"playerActionAnim")) then {
			setVar(missionNamespace,"playerPerformingAction","FINISHED")
		};
	}];
	private _frameHandlerID = (findDisplay 46) displayAddEventHandler ["KeyDown",{
		_this call horde_fnc_abortAction
	}];

	private _playerDir = getDir player;

	waitUntil {
		if diff(getDir player,_playerDir) then {
			player setDir _playerDir
		};
		not alive player
		or {isNil {getVar(missionNamespace,"playerPerformingAction")}}
		or {diff(getVar(missionNamespace,"playerPerformingAction"),"IN_PROGRESS")}
	};
	{
		deleteVehicle _x
	} forEach _actionItems;
	player removeEventHandler ["AnimDone",_idx];
	(findDisplay 46) displayRemoveEventHandler ["KeyDown",_frameHandlerID];
	if (alive player
		and {not isNil {getVar(missionNamespace,"playerPerformingAction")}}
		and {getVar(missionNamespace,"playerPerformingAction") == "FINISHED"}
	) then {
		ncb_gv_playerFood = ncb_gv_playerFood + _incFood min 100;
		private _damage = damage player;
		private _minHealth = ncb_gv_playerLodgedBullets * 0.07;
		private _newDamage = _damage - _decDamage;
		if (_newDamage < _minHealth) then {
			_newDamage = _minHealth;
		};
		player setDamage _newDamage;
		private _text = "
			<t size='3.2'color='#FFFFFF'align='center'shadow='2'>
			You ate some food.
			</t>
		";
		_text call horde_fnc_displayActionConfMessage;
	} else {
		player addItem _this;
		private _text = "
			<t size='3.2'color='#FF0000'align='center'shadow='2'>
			Action aborted.
			</t>
		";
		_text call horde_fnc_displayActionRejMessage;
	};
	setVar(missionNamespace,"playerPerformingAction",nil);
} else {
	private _text = "
		<t size='3.2'color='#FF0000'align='center'shadow='2'>
		You are already doing something.
		</t>
	";
	_text call horde_fnc_displayActionRejMessage;
};
true