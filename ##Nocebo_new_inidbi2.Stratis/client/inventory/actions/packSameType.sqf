#include "\nocebo\defines\scriptDefines.hpp"

closeDialog 0;
if (isNil {getVar(missionNamespace,"playerPerformingAction")}) then {
	if diff(vehicle player,player) exitWith {
		private _magCapacity = getNumber (cfgMag >> _this >> "count");
		private _looseBullets = 0;
		{
			_x params ["_type","_count"];
			if same(_type,_this) then {
				_looseBullets = _looseBullets + _count;
			};
			true
		} count (magazinesAmmo player);

		private _newMagAmount = floor (_looseBullets / _magCapacity);
		private _lastMagCount = _looseBullets % _magCapacity;

		player removeMagazines _this;
		if (_newMagAmount > 0) then {
			player addMagazines [_this, _newMagAmount];
		};
		if (_lastMagCount > 0) then {
			player addMagazine [_this, _lastMagCount];
		};

		private _text = format [
			"<t size='3.2'color='#FFFFFF'align='center'shadow='2'>
			You consolidated all your<br />
			%1 mags</t>",
			getText (cfgMag >> _this >> "displayname")
		];
		_text call horde_fnc_displayActionConfMessage;
	};
	setVar(missionNamespace,"playerPerformingAction","IN_PROGRESS");
	[player,true] call horde_fnc_selectActionAnim;
	private _actionItems = ["ammo",""] call horde_fnc_spawnActionItems;
	sleep 0.5;
	/*[player,"CfgMagazines",_this] call horde_fnc_broadcastActionSound;*/
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
		private _magCapacity = getNumber (cfgMag >> _this >> "count");
		_looseBullets = 0;
		{
			_x params ["_type","_count"];
			if same(_type,_this) then {
				_looseBullets = _looseBullets + _count;
			};
			true
		} count (magazinesAmmo player);

		private _newMagAmount = floor (_looseBullets / _magCapacity);
		private _lastMagCount = _looseBullets % _magCapacity;

		player removeMagazines _this;
		if (_newMagAmount > 0) then {
			player addMagazines [_this, _newMagAmount];
		};
		if (_lastMagCount > 0) then {
			player addMagazine [_this, _lastMagCount];
		};

		private _text = "
			<t size='3.2'color='#FFFFFF'align='center'shadow='2'>
			You consolidated the ammunition.
			</t>
		";
		_text call horde_fnc_displayActionConfMessage;
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