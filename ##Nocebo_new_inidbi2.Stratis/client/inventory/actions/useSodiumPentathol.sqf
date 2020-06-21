#include "\nocebo\defines\scriptDefines.hpp"

closeDialog 0;
if (isNil {getVar(missionNamespace,"playerPerformingAction")}) then {
	player removeItem _this;
	if diff(vehicle player,player) exitWith {
		private _imbibe = {
			private _timeOut = time + 30 + random 30;
			waitUntil {
				sleep random 5;
				if (random 4 > 1) then {
					private _spawn = {
						sleep random 1.5;
						private _blur = ppEffectCreate ["dynamicBlur", 200];
						_blur ppEffectEnable true;
						private _rand2 = random 2;
						_blur ppEffectAdjust [random 5];
						_blur ppEffectCommit _rand2;
						sleep _rand2;
						_blur ppEffectAdjust [0];
						private _rand = random 3;
						_blur ppEffectCommit _rand;
						sleep _rand;
						_blur ppEffectEnable false;
					};
					0 spawn _spawn;
				};
				if (random 4 > 1) then {
					private _spawn = {
						sleep random 1.5;
						private _blur = ppEffectCreate ["wetDistortion", 300];
						_blur ppEffectEnable true;
						private _rand = random 2;
						_blur ppEffectAdjust [0, random 3, random 0.8,random 8,random 8, 0.2, 1, 0, 0, 0.08, 0.08, 0, 0, 0, 0.77];
						_blur ppEffectCommit _rand;
						sleep _rand;
						_blur ppEffectAdjust [0, 0, 0,0,0, 0, 1, 0, 0, 0.08, 0.08, 0, 0, 0, 0.77];
						private _rand = random 3;
						_blur ppEffectCommit _rand;
						sleep _rand;
						_blur ppEffectEnable false;
					};
					0 spawn _spawn;
				};
				time > _timeOut
			};
		};
		0 spawn _imbibe;
		private _text = "
			<t size='3.2'color='#FFFFFF'align='center'shadow='2'>
			You took the Sodium Pentathol.
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
			private _timeOut = time + 30 + random 30;
			waitUntil {
				sleep random 5;
				if (random 4 > 1) then {
					private _spawn = {
						sleep random 1.5;
						private _blur = ppEffectCreate ["dynamicBlur", 200];
						_blur ppEffectEnable true;
						private _rand2 = random 2;
						_blur ppEffectAdjust [random 5];
						_blur ppEffectCommit _rand2;
						sleep _rand2;
						_blur ppEffectAdjust [0];
						private _rand = random 3;
						_blur ppEffectCommit _rand;
						sleep _rand;
						_blur ppEffectEnable false;
					};
					0 spawn _spawn;
				};
				if (random 4 > 1) then {
					private _spawn = {
						sleep random 1.5;
						private _blur = ppEffectCreate ["wetDistortion", 300];
						_blur ppEffectEnable true;
						private _rand = random 2;
						_blur ppEffectAdjust [0, random 3, random 0.8,random 8,random 8, 0.2, 1, 0, 0, 0.08, 0.08, 0, 0, 0, 0.77];
						_blur ppEffectCommit _rand;
						sleep _rand;
						_blur ppEffectAdjust [0, 0, 0,0,0, 0, 1, 0, 0, 0.08, 0.08, 0, 0, 0, 0.77];
						private _rand = random 3;
						_blur ppEffectCommit _rand;
						sleep _rand;
						_blur ppEffectEnable false;
					};
					0 spawn _spawn;
				};
				time > _timeOut
			};
		};
		0 spawn _imbibe;
		private _text = "
			<t size='3.2'color='#FFFFFF'align='center'shadow='2'>
			You took the Sodium Pentathol.
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