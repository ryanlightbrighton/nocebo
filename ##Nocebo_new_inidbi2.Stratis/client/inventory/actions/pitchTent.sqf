#include "\nocebo\defines\scriptDefines.hpp"

params ["_item","_users"];

closeDialog 0;

private _dir = 0;
private _pos = [0,0,0];

if diff(vehicle player,player) exitWith {
	private _text = "
		<t size='3.2'color='#FF0000'align='center'shadow='2'>
		You cannot pitch a tent in a vehicle.
		</t>
	";
	_text call horde_fnc_displayActionRejMessage;
};

if (isNil {getVar(missionNamespace,"playerPerformingAction")}) then {
	setVar(missionNamespace,"playerPerformingAction","IN_PROGRESS");
	player removeItem _item;

	// SPAWN TEST TENT
	private _text = "
		<t size='3.2'color='#FFFFFF'align='center'shadow='2'>
		CTRL + MMB = Confirm.
		</t>
		<br/>
		<t size='3.2'color='#FFFFFF'align='center'shadow='2'>
		Any other Mouse Button = Cancel.
		</t>
	";
	_text call horde_fnc_displayActionConfMessage;
	private _ghost = "ncb_obj_tent_dome" createVehicleLocal getPosATL player;
	private _ghost2 = "Sign_Sphere25cm_F" createVehicleLocal getPosATL player;
	_ghost2 attachTo [player,[0,2.5,1.9]];

	private _frameHandlerID = (findDisplay 46) displayAddEventHandler ["MouseButtonDown",{
		if (sel(_this,1) == 2 and {sel(_this,5)}) then { // CTRL + MMB
			setVar(missionNamespace,"playerPerformingAction","FINISHED");
		} else {
			setVar(missionNamespace,"playerPerformingAction","ABORTED");
		};
		true
	}];
	private _OK = false;
	waitUntil {
		_pos = player ModelToWorld [0,2.5,0];
		_pos set [2,0];
		_dir = getDir player;
		_dir = _dir - 90;
		_dir = _dir call horde_fnc_normalDir;
		_ghost setDir _dir;
		_ghost setPosATL _pos;
		_ghost setVectorUp surfaceNormal _pos;

		private _posASL = ATLtoASL _pos;
		_posASL set [2,(_posASL select 2) + 0.3];
		private _rad = 1.56;
		private _intersect = false;
		scopeName "INDENT_2";
		for "_i" from 0 to 355 step 5 do {
			private _testPosASL = [
				sel(_posASL,0) + _rad * sin _i,
				sel(_posASL,1) + _rad * cos _i,
				sel(_posASL,2)
			];

			{
				if (typeOf _x != "GroundWeaponHolder") exitWith {
					_intersect = true;
					breakTo "INDENT_2";
				};
			} forEach (lineIntersectsWith[_posASL,_testPosASL,_ghost]);
		};
		private _underPosASL = [sel(_posASL,0),sel(_posASL,1),sel(_posASL,2) - 5];
		private _surf = toLower surfaceType _pos;
		/*diag_log format ["surfaceNormal _pos vectorCos [0,0,1]		%1",surfaceNormal _pos vectorCos [0,0,1]];
		diag_log format ["surfaceNormal _pos vectorCos [0,0,1] > 0.86		%1",surfaceNormal _pos vectorCos [0,0,1] > 0.94];
		diag_log format ["not (surfaceIsWater _pos)		%1",not (surfaceIsWater _pos)];
		diag_log format ["not (getTerrainHeightASL _pos < 0)		%1",not (getTerrainHeightASL _pos < 0)];
		diag_log format ["not (getTerrainHeightASL _pos < 0)		%1",not (getTerrainHeightASL _pos < 0)];
		diag_log format ["_surf		%1",_surf];
		diag_log format ["{if (_surf find _x > -1) exitWith {1}} count [dirt,forest,grass,beach,thorn,rocky] > 0		%1",{if (_surf find _x > -1) exitWith {1}} count ["dirt","forest","grass","beach","thorn","rocky"] > 0];
		diag_log format ["not (lineIntersects[_posASL,_underPosASL,_ghost])		%1",not (lineIntersects[_posASL,_underPosASL,_ghost])];
		diag_log format ["not _intersect		%1",not _intersect];
		diag_log "-----------------------------------------";*/
		if (surfaceNormal _pos vectorCos [0,0,1] > 0.94
			and {not (surfaceIsWater _pos)}
			and {not (getTerrainHeightASL _pos < 0)}
			and {{if (_surf find _x > -1) exitWith {1}} count ["dirt","forest","grass","beach","thorn","rocky","volcano"] > 0}
			and {not (lineIntersects[_posASL,_underPosASL,_ghost])}
			and {not _intersect}
		) then {
			_ghost2 setObjectTexture [0, "#(rgb,8,8,3)color(0,1,0,1)"];
			_OK = true;
		} else {
			_ghost2 setObjectTexture [0, "#(rgb,8,8,3)color(1,0,0,1)"];
			_OK = false;
		};
		sleep 0.01;
		not alive player
		or {isNil {getVar(missionNamespace,"playerPerformingAction")}}
		or {diff(getVar(missionNamespace,"playerPerformingAction"),"IN_PROGRESS")}
	};

	(findDisplay 46) displayRemoveEventHandler ["MouseButtonDown",_frameHandlerID];
	deleteVehicle _ghost2;
	deleteVehicle _ghost;
	if (not alive player
		or {getVar(missionNamespace,"playerPerformingAction") == "ABORTED"}
	) exitWith {
		player addItem _item;
		private _text = "
			<t size='3.2'color='#FF0000'align='center'shadow='2'>
			Action aborted.
			</t>
		";
		_text call horde_fnc_displayActionRejMessage;
		setVar(missionNamespace,"playerPerformingAction",nil);
	};

	if (_OK and {alive player}) then {
		10000 cutText ["","PLAIN DOWN"];
		setVar(missionNamespace,"playerPerformingAction","IN_PROGRESS");
		[player,true] call horde_fnc_selectActionAnim;
		sleep 0.5;
		[player,"CfgWeapons",_item] call horde_fnc_broadcastActionSound;
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
			private _tent = spawnVeh("ncb_obj_tent_dome",_pos);
			_tent setDir _dir;
			_tent setPosATL [sel(_pos,0),sel(_pos,1),-0.07];
			_tent setVectorUp surfaceNormal _pos;
			player reveal [_tent,4];
			// set up variables (each tent will have a var so we know the UID of the player that created it. (var exists on server only)
			[player,_tent,_users] remoteExecCall [
				"horde_fnc_serverSetTentOwner",
				2
			];

			0 call horde_fnc_updateLogisticsSkill;
			private _text = "
				<t size='3.2'color='#FFFFFF'align='center'shadow='2'>
				You pitched a tent.
				</t>
			";
			_text call horde_fnc_displayActionConfMessage;
		} else {
			player addItem _item;
			private _text = "
				<t size='3.2'color='#FF0000'align='center'shadow='2'>
				Action aborted.
				</t>
			";
			_text call horde_fnc_displayActionRejMessage;
		};
		setVar(missionNamespace,"playerPerformingAction",nil);
	} else {
		// no message if dead - also tent not added back to inv if killed.
		if (alive player) then {
			private _text = "
				<t size='3.2'color='#FF0000'align='center'shadow='2'>
				You cannot place a tent here.
				</t>
			";
			_text call horde_fnc_displayActionRejMessage;
			player addItem _item;
		};
		setVar(missionNamespace,"playerPerformingAction",nil);
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
