#include "\nocebo\defines\scriptDefines.hpp"

closeDialog 0;
if (isNil {getVar(missionNamespace,"playerPerformingAction")}) then {
	/*_cfgWeap = cfgWeap >> _this;*/
	if diff(vehicle player,player) exitWith {
		private _text = "
			<t size='3.2'color='#FF0000'align='center'shadow='2'>
			You cannot build a fire in a vehicle.
			</t>
		";
		_text call horde_fnc_displayActionRejMessage;
	};
	setVar(missionNamespace,"playerPerformingAction","IN_PROGRESS");
	[player,true] call horde_fnc_selectActionAnim;
	private _actionItems = ["chopwood",""] call horde_fnc_spawnActionItems;
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
		// place fire

		private _intersects = lineIntersectsSurfaces [
			player modelToWorldWorld [0,2,2],
			player modelToWorldWorld [0,2,-10],
			vehicle player,
			objNull,
			true,
			1,
			"VIEW",
			"GEOM"
		];
		if not empty(_intersects) then {
			_intersects select 0 params ["_posASL","_normal","",""];
			private _intersectPos = ASLtoAGL _posASL;

			/*_output = getArray (_cfgAction >> "output");
			_class = sel(_output,0);*/
			// workaround (this should be determined in config)
			private _class = "ncb_obj_smallFireEmbers";
			if (_this == "ItemFireWood") then {
				_class = "ncb_obj_campFireEmbers"
			};
			private _fire = spawnVeh(_class,_intersectPos);
			_fire setVectorDirAndUp [vectorDir player,_normal];
			player removeItem _this;
			private _text = "
				<t size='3.2'color='#FFFFFF'align='center'shadow='2'>
				You built a fire.
				</t>
			";
			_text call horde_fnc_displayActionConfMessage;
		} else {
			private _text = "
				<t size='3.2'color='#FF0000'align='center'shadow='2'>
				You cannot build a fire here.
				</t>
			";
			_text call horde_fnc_displayActionRejMessage;
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
