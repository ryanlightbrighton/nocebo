#include "\nocebo\defines\scriptDefines.hpp"

closeDialog 0;
if (isNil {getVar(missionNamespace,"playerPerformingAction")}) then {
	player removeItem _this;
	if diff(vehicle player,player) exitWith {
		setVar(missionNamespace,"ncb_gv_playerBleedingRate",0);
		private _dam = damage player;
		private _minHealth = ncb_gv_playerLodgedBullets * 0.07;
		_dam = (_dam - 0.6) max _minHealth;
		player setDamage _dam;
		private _text = "
			<t size='3.2'color='#FFFFFF'align='center'shadow='2'>
			You used a Med Pack.
			</t>
		";
		_text call horde_fnc_displayActionConfMessage;
	};
	setVar(missionNamespace,"playerPerformingAction","IN_PROGRESS");
	[player,true] call horde_fnc_selectActionAnim;
	private _actionItems = ["medical",_this] call horde_fnc_spawnActionItems;
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
		setVar(missionNamespace,"ncb_gv_playerBleedingRate",0);
		private _dam = damage player;
		private _minHealth = ncb_gv_playerLodgedBullets * 0.07;
		_dam = (_dam - 0.6) max _minHealth;
		player setDamage _dam;
		private _text = "
			<t size='3.2'color='#FFFFFF'align='center'shadow='2'>
			You used a Med Pack.
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