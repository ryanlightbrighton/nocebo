#include "\nocebo\defines\scriptDefines.hpp"

params ["_ctrl","_button","_xVal","_yVal"];

private _screenCoords = [_xVal,_yVal];
if same(_button,0) then {
	private _worldPos = _ctrl ctrlMapScreenToWorld _screenCoords;
	_worldPos set [2,0];
	private _nearPlayers = _worldPos nearEntities [
		["ncb_player_base"],
		100
	];
	_nearPlayers = _nearPlayers select {(group _x) isEqualTo (group player) and {alive _x} and {!(_x isEqualTo player)}};
	private _nearSpawns = nearestObjects [_worldPos, ["ncb_obj_tent_dome","ncb_obj_para_beacon"],100];
	_nearSpawns = _nearSpawns select {
		private _ok = false;
		private _var = _x getVariable ["tentOwnerDetails",["dummy"]];
		private _uid = _var#0;
		if (_uid == "server" or {{getPlayerUID _x == _uid} count units group player > 0}) then {
			_ok = true
		};
		_ok
	};
	_nearSpawns = _nearSpawns + _nearPlayers;
	// now get closest
	private _closest = objNull;
	private _distance = 999999;
	{
		if (_x distance _worldPos < _distance) then {
			_closest = _x;
			_distance = _x distance _worldPos;
		}
	} forEach _nearSpawns;
	diag(_closest);
	if (_closest isKindOf "ncb_player_base") exitWith {
		missionNamespace setVariable ["playerRespawnType","paradrop"];
		missionNameSpace setVariable ["playerOkToCloseRespawnMenu",true];
		missionNamespace setVariable ["playerParaRespawnBeacon",_closest];
		forceRespawn player
	};
	if (_closest isKindOf "ncb_obj_para_beacon") exitWith {
		missionNamespace setVariable ["playerRespawnType","paradrop"];
		missionNameSpace setVariable ["playerOkToCloseRespawnMenu",true];
		missionNamespace setVariable ["playerParaRespawnBeacon",_closest];
		forceRespawn player
	};
	if (_closest isKindOf "ncb_obj_tent_dome") exitWith {
		missionNamespace setVariable ["playerRespawnType","tent"];
		missionNameSpace setVariable ["playerOkToCloseRespawnMenu",true];
		missionNamespace setVariable ["playerTentRespawnPosASL",AGLtoASL (_closest modelToWorld [-2.7,0,0])];
		forceRespawn player
	}
};
true



/*params ["_ctrl","_button","_xVal","_yVal"];

private _screenCoords = [_xVal,_yVal];
if same(_button,0) then {
	private _worldPos = _ctrl ctrlMapScreenToWorld _screenCoords;
	_worldPos set [2,0];
	private _nearSpawns = nearestObjects [_worldPos, ["ncb_obj_tent_dome","ncb_obj_para_beacon"],100];
	if not empty(_nearSpawns) then {
		private _spawn = sel(_nearSpawns,0);
		if (_spawn isKindOf "ncb_obj_para_beacon") then {
			private _retPos = AGLtoASL getPos _spawn;
			missionNamespace setVariable ["playerRespawnType","paradrop"];
			missionNameSpace setVariable ["playerOkToCloseRespawnMenu",true];
			missionNamespace setVariable ["playerParaRespawnBeacon",_spawn];
			forceRespawn player;
		} else {
			private _retPos = _spawn modelToWorld [-2.7,0,0];
			_retPos = AGLtoASL _retPos;
			missionNamespace setVariable ["playerRespawnType","tent"];
			missionNameSpace setVariable ["playerOkToCloseRespawnMenu",true];
			missionNamespace setVariable ["playerTentRespawnPosASL",_retPos];
			forceRespawn player;
		};

	};
};
true*/