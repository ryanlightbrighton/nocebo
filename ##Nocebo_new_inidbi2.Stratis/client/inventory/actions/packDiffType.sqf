#include "\nocebo\defines\scriptDefines.hpp"

closeDialog 0;

params [
	"_oldMagType",
	"_newMagType"
];

if (isNil {playerPerformingAction}) then {
	private _finishAction = true;
	if same(vehicle player,player) then {
		playerPerformingAction = "IN_PROGRESS";
		[player,true] call horde_fnc_selectActionAnim;
		private _actionItems = ["ammo",""] call horde_fnc_spawnActionItems;
		sleep 0.5;
		/*[player,"CfgMagazines",_this] call horde_fnc_broadcastActionSound;*/
		private _idx = player addEventHandler ["AnimDone",{
			if (sel(_this,1) == playerActionAnim) then {
				playerPerformingAction = "FINISHED"
			};
		}];
		private _displayEHID = (findDisplay 46) displayAddEventHandler ["KeyDown",{
			_this call horde_fnc_abortAction
		}];

		private _playerDir = getDir player;

		waitUntil {
			if diff(getDir player,_playerDir) then {
				player setDir _playerDir
			};
			not alive player
			or {diff(getVarDef(missionNamespace,"playerPerformingAction","CX"),"IN_PROGRESS")}
		};
		{
			deleteVehicle _x
		} forEach _actionItems;
		player removeEventHandler ["AnimDone",_idx];
		(findDisplay 46) displayRemoveEventHandler ["KeyDown",_displayEHID];
		if (not alive player
			or {diff(getVarDef(missionNamespace,"playerPerformingAction","CX"),"FINISHED")}
		) then {
			_finishAction = false;
		};
	};

	if (_finishAction) then {
		private _magCapacity = getNumber (cfgMag >> _newMagType >> "count");
		private _looseBullets = 0;
		{
			_x params ["_type","_count"];
			if same(_type,_oldMagType) then {
				_looseBullets = _looseBullets + _count;
			};
			// new
			if same(_type,_newMagType) then {
				_looseBullets = _looseBullets + _count;
			};
			//
			true
		} count (magazinesAmmo player);

		private _newMagAmount = floor (_looseBullets / _magCapacity);
		private _lastMagCount = _looseBullets % _magCapacity;

		player removeMagazines _oldMagType;
		player removeMagazines _newMagType;
		private _holder = objNull;
		if (_newMagAmount > 0) then {
			for "_i" from 1 to _newMagAmount do {
				if (player canAdd _newMagType) then {
					player addMagazines [_newMagType,1];
				} else {
					if (isNull _holder) then {
						_holder = spawnVeh("GroundWeaponHolder",position player);
					};
					_holder addMagazineCargoGlobal [_newMagType,1];
				};
			};
		};
		if (_lastMagCount > 0) then {
			if (player canAdd _newMagType) then {
				player addMagazine [_newMagType,_lastMagCount];
			} else {
				if (isNull _holder) then {
					_holder = spawnVeh("GroundWeaponHolder",position player);
				};
				_holder addMagazineAmmoCargo [_newMagType,1,_lastMagCount];
			};
		};

		private _text = format [
			"<t size='3.2'color='#FFFFFF'align='center'shadow='2'>
			You repacked all your<br />
			%1 mags<br />
			into %2 mags</t>",
			getText (cfgMag >> _oldMagType >> "displayname"),
			getText (cfgMag >> _newMagType >> "displayname")
		];
		_text call horde_fnc_displayActionConfMessage;
	} else {
		private _text = "
			<t size='3.2'color='#FF0000'align='center'shadow='2'>
			Action aborted.
			</t>
		";
		_text call horde_fnc_displayActionRejMessage;
	};
	playerPerformingAction = nil;
} else {
	private _text = "
		<t size='3.2'color='#FF0000'align='center'shadow='2'>
		You are already doing something.
		</t>
	";
	_text call horde_fnc_displayActionRejMessage;
};
true