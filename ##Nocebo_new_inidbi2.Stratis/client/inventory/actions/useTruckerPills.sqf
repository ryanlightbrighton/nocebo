#include "\nocebo\defines\scriptDefines.hpp"

closeDialog 0;
if (isNil {getVar(missionNamespace,"playerPerformingAction")}) then {
	player removeItem _this;
	if diff(vehicle player,player) exitWith {
		private _imbibe = {
			scriptName "useTruckerPills";
			if (isNil {getVar(missionNamespace,"playerOnTruckerPills")}) then {
				sleep 2;
				private _blur = ppEffectCreate ["dynamicBlur", 200];
				_blur ppEffectEnable true;
				_blur ppEffectAdjust [3];
				_blur ppEffectCommit 2;
				sleep 2;
				_blur ppEffectAdjust [0];
				_blur ppEffectCommit 8;
				sleep 8;
				_blur ppEffectEnable false;
				setVar(missionNamespace,"playerOnTruckerPills",true);
				if (ncb_param_playerStaminaEnabled == 1) then {
					player enableStamina false
				};
				_time = time;
				sleep 180 + (random 200);
				private _lastSpawnTime = getVar(missionNamespace,"playerLastRespawnTime");
				if (_time > _lastSpawnTime) then {
					if (ncb_param_playerStaminaEnabled == 1) then {
						player enableStamina true
					};
					_blur ppEffectEnable true;
					_blur ppEffectAdjust [3];
					_blur ppEffectCommit 2;
					sleep 2;
					_blur ppEffectAdjust [0];
					_blur ppEffectCommit 8;
					sleep 8;
					ppEffectDestroy _blur;
					setVar(missionNamespace,"playerOnTruckerPills",nil);
				};
			} else {
				sleep 2;
				private _blur = ppEffectCreate ["dynamicBlur", 200];
				_blur ppEffectEnable true;
				_blur ppEffectAdjust [8];
				_blur ppEffectCommit 2;
				sleep 2;
				private _damage = damage player;
				_damage = _damage + 0.2;
				player setDamage _damage;
				_blur ppEffectAdjust [0];
				_blur ppEffectCommit 8;
				sleep 8;
				ppEffectDestroy _blur;
				private _text = "
					<t size='3.2'color='#FFFFFF'align='center'shadow='2'>
					You took too many pills.
					</t>
				";
				_text call horde_fnc_displayActionRejMessage;
			};
		};
		0 = 0 spawn _imbibe;
		private _text = "
			<t size='3.2'color='#FFFFFF'align='center'shadow='2'>
			You took the pills.
			</t>
		";
		_text call horde_fnc_displayActionConfMessage;
	};
	setVar(missionNamespace,"playerPerformingAction","IN_PROGRESS");
	[player,true] call horde_fnc_selectActionAnim;
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

	player removeEventHandler ["AnimDone",_idx];
	(findDisplay 46) displayRemoveEventHandler ["KeyDown",_frameHandlerID];
	if (alive player
		and {not isNil {getVar(missionNamespace,"playerPerformingAction")}}
		and {getVar(missionNamespace,"playerPerformingAction") == "FINISHED"}
	) then {
		private _imbibe = {
			scriptName "useTruckerPills2";
			if (isNil {getVar(missionNamespace,"playerOnTruckerPills")}) then {
				sleep 2;
				private _blur = ppEffectCreate ["dynamicBlur", 200];
				_blur ppEffectEnable true;
				_blur ppEffectAdjust [3];
				_blur ppEffectCommit 2;
				sleep 2;
				_blur ppEffectAdjust [0];
				_blur ppEffectCommit 8;
				sleep 8;
				_blur ppEffectEnable false;
				setVar(missionNamespace,"playerOnTruckerPills",true);
				if (ncb_param_playerStaminaEnabled == 1) then {
					player enableStamina false
				};
				private _time = time;
				sleep 180 + (random 200);
				private _lastSpawnTime = getVar(missionNamespace,"playerLastRespawnTime");
				if (_time > _lastSpawnTime) then {
					if (ncb_param_playerStaminaEnabled == 1) then {
						player enableStamina true
					};
					_blur ppEffectEnable true;
					_blur ppEffectAdjust [3];
					_blur ppEffectCommit 2;
					sleep 2;
					_blur ppEffectAdjust [0];
					_blur ppEffectCommit 8;
					sleep 8;
					ppEffectDestroy _blur;
					setVar(missionNamespace,"playerOnTruckerPills",nil);
				};
			} else {
				sleep 2;
				private _blur = ppEffectCreate ["dynamicBlur", 200];
				_blur ppEffectEnable true;
				_blur ppEffectAdjust [8];
				_blur ppEffectCommit 2;
				sleep 2;
				private _damage = damage player;
				_damage = _damage + 0.5;
				player setDamage _damage;
				_blur ppEffectAdjust [0];
				_blur ppEffectCommit 8;
				sleep 8;
				ppEffectDestroy _blur;
				private _text = "
					<t size='3.2'color='#FFFFFF'align='center'shadow='2'>
					You took too many pills.
					</t>
				";
				_text call horde_fnc_displayActionRejMessage;
			};
		};
		0 = 0 spawn _imbibe;
		private _text = "
			<t size='3.2'color='#FFFFFF'align='center'shadow='2'>
			You took the pills.
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