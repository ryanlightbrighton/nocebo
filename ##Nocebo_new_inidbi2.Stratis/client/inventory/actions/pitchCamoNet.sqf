#include "\nocebo\defines\scriptDefines.hpp"

closeDialog 0;

if diff(vehicle player,player) exitWith {
	private _text = "
		<t size='3.2'color='#FF0000'align='center'shadow='2'>
		You cannot pitch a tent in a vehicle.
		</t>
	";
	_text call horde_fnc_displayActionRejMessage;
};

private _classNet = "";
private _rad = 6;
call {
	if (_this == "ItemCamoNet") exitWith {
		_classNet = "ncb_obj_camonet"
	};
	if (_this == "ItemCamoNetOpen") exitWith {
		_classNet = "ncb_obj_camonet_open"
	};
	if (_this == "ItemVehicleCamoNet") exitWith {
		_classNet = "ncb_obj_camonet_large"
	}
};

private _dir = 0;
private _pos = [0,0,0];

if (isNil {getVar(missionNamespace,"playerPerformingAction")}) then {
	setVar(missionNamespace,"playerPerformingAction","IN_PROGRESS");
	player removeItem _this;

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
	private _ghost = _classNet createVehicleLocal getPosATL player;

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
		_pos = player ModelToWorld [0,_rad + 3,0];
		_pos set [2,0];
		_dir = getDir player;
		_ghost setPosATL _pos;
		_ghost setDir _dir;
		_ghost setVectorUp surfaceNormal _pos;
		_posASL = ATLtoASL _pos;
		_posASL set [2,(_posASL select 2) + 0.3];
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
			} forEach (lineIntersectsWith [_posASL,_testPosASL,_ghost]);
		};
		private _underPosASL = [sel(_posASL,0),sel(_posASL,1),sel(_posASL,2) - 5];

		if (surfaceNormal _pos vectorCos [0,0,1] > 0.94
			and {not (surfaceIsWater _pos)}
			and {not (getTerrainHeightASL _pos < 0)}
			and {{if (toLower surfaceType _pos find _x > -1) exitWith {1}} count ["dirt","forest","grass","beach","thorn","rocky","volcano"] > 0}
			and {not (lineIntersects[_posASL,_underPosASL,_ghost])}
			and {not _intersect}
		) then {
			_ghost setObjectTexture [0, "#(rgb,8,8,3)color(0,1,0,1)"];
			_OK = true;
		} else {
			_ghost setObjectTexture [0, "#(rgb,8,8,3)color(1,0,0,1)"];
			_OK = false;
		};
		/*sleep 0.01;*/
		not alive player
		or {isNil {getVar(missionNamespace,"playerPerformingAction")}}
		or {diff(getVar(missionNamespace,"playerPerformingAction"),"IN_PROGRESS")}
	};

	(findDisplay 46) displayRemoveEventHandler ["MouseButtonDown",_frameHandlerID];
	deleteVehicle _ghost;
	if (
		not alive player
		or {getVar(missionNamespace,"playerPerformingAction") == "ABORTED"}
	) exitWith {
		player addItem _this;
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
			private _tent = spawnVeh(_classNet,_pos);
			_tent setDir _dir;
			_tent setPosATL [sel(_pos,0),sel(_pos,1),-0.07];
			_tent setVectorUp surfaceNormal _pos;
			player reveal [_tent,4];
			_tent allowDamage false;
			0 call horde_fnc_updateLogisticsSkill;
			private _text = "
				<t size='3.2'color='#FFFFFF'align='center'shadow='2'>
				You pitched a camo net.
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
		// no message if dead - also tent not added back to inv if killed.
		if (alive player) then {
			private _text = "
				<t size='3.2'color='#FF0000'align='center'shadow='2'>
				You cannot place a camo net here.
				</t>
			";
			_text call horde_fnc_displayActionRejMessage;
			player addItem _this;
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
