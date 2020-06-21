#include "\nocebo\defines\scriptDefines.hpp"

if (ncb_gv_playerLodgedBullets isEqualTo 0) exitWith {
	private _text = "
		<t size='3.2'color='#FF0000'align='center'shadow='2'>
		You do not have any lodged bullets.
		</t>
	";
	_text call horde_fnc_displayActionRejMessage;
	false
};

closeDialog 0;
if (isNil {getVar(missionNamespace,"playerPerformingAction")}) then {
	if diff(vehicle player,player) exitWith {
		// chance of injury during procedure & chance of removing
		private _removed = false;
		if (random 1 > 0.333) then {
			ncb_gv_playerLodgedBullets = ncb_gv_playerLodgedBullets - 1;
			_removed = true;
		};
		private _damage = damage player;
		_damage = _damage + 0.1;
		player setDamage _damage;
		if (alive player) then {
			if (_removed) then {
				private _text = "
					<t size='3.2'color='#FFFFFF'align='center'shadow='2'>
					You removed a bullet.
					</t>
				";
				_text call horde_fnc_displayActionConfMessage;
			} else {
				private _text = "
					<t size='3.2'color='#FF0000'align='center'shadow='2'>
					You tried to remove a bullet but failed.
					</t>
				";
				_text call horde_fnc_displayActionRejMessage;
			};
		};
	};
	setVar(missionNamespace,"playerPerformingAction","IN_PROGRESS");
	[player,true] call horde_fnc_selectActionAnim;
	private _actionItems = ["medical",_this] call horde_fnc_spawnActionItems;
	sleep 0.5;
	/*[player,"CfgWeapons",_this] call horde_fnc_broadcastActionSound;*/
	private _idx = player addEventHandler ["AnimDone",{
		if (sel(_this,1) == getVar(missionNamespace,"playerActionAnim")) then {
			setVar(missionNamespace,"playerPerformingAction","FINISHED")
		};
	}];
	private _frameHandlerID = (findDisplay 46) displayAddEventHandler ["KeyDown",{
		_this call horde_fnc_abortAction
	}];

	// rotate

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
		and {same(getVar(missionNamespace,"playerPerformingAction"),"FINISHED")}
	) then {
		// chance of injury during procedure & chance of removing
		private _removed = false;
		if (random 1 > 0.5) then {
			ncb_gv_playerLodgedBullets = ncb_gv_playerLodgedBullets - 1;
			_removed = true;
		};
		private _damage = damage player;
		_damage = _damage + 0.1;
		player setDamage _damage;
		if (alive player) then {
			if (_removed) then {
				private _text = "
					<t size='3.2'color='#FFFFFF'align='center'shadow='2'>
					You removed a bullet.
					</t>
				";
				_text call horde_fnc_displayActionConfMessage;
			} else {
				private _text = "
					<t size='3.2'color='#FF0000'align='center'shadow='2'>
					You tried to remove a bullet but failed.
					</t>
				";
				_text call horde_fnc_displayActionRejMessage;
			};
		};
	} else {
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