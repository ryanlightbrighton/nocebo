#include "\nocebo\defines\scriptDefines.hpp"

// tent functions serverSetTentOwner/tentKilled handled only on server!

params ["_owner","_tent","_users"];

private _time = round (time % 1000000);
private _markerName = "respawn_west_tent_personal_";
private _markerText = "Personal respawn tent";
private _color = "colorWhite";

call {
	if (_users == "personal") exitWith {
		_markerName = "respawn_west_tent_personal_" + str _time + str (round random 99999);
		_color = "colorWhite";
		_markerText = "Personal respawn tent";
		if (_tent isKindOf "ncb_obj_para_beacon") then {
			_markerText = "Personal para respawn beacon"
		};

		_tent setVariable ["tentOwnerDetails",[getPlayerUID _owner,_markerName,_users],true];

		// create marker locally

		[_tent,_markerName,_markerText,_color] remoteExecCall [
			"horde_fnc_playerAddTentMarker",
			_owner
		];
	};
	if (_users == "group") exitWith {
		_markerName = "respawn_west_tent_group_" + (getPlayerUID _owner) + "_" + (str _time) + (str (round random 99999));
		_color = "colorGreen";
		_markerText = "Group respawn tent";
		if (_tent isKindOf "ncb_obj_para_beacon") then {
			_markerText = "Group para respawn beacon"
		};

		_tent setVariable ["tentOwnerDetails",[getPlayerUID _owner,_markerName,_users],true];

		// create markers on group members PC's

		[_tent,_markerName,_markerText,_color] remoteExecCall [
			"horde_fnc_playerAddTentMarker",
			units group _owner
		];
	};
	if (_users == "side") exitWith {
		_markerName = "respawn_west_tent_side_" + str _time + str (round random 99999);
		_color = "colorBlue";
		_markerText = "Side respawn tent";
		if (_tent isKindOf "ncb_obj_para_beacon") then {
			_markerText = "Side para respawn beacon"
		};

		_tent setVariable ["tentOwnerDetails",["server",_markerName,_users],true];

		// create marker

		private _mkr = createMarker [_markerName,position _tent];
		_mkr setMarkerSize [1, 1];
		_mkr setMarkerType "respawn_inf";
		_mkr setMarkerColor _color;
		_mkr setMarkerAlpha 1;
		_mkr setMarkerText _markerText;
		_mkr setMarkerDir 0;
	};
};

// used to track tents if leaving group later on

private _tents = missionNamespace getVariable ["ncb_gv_playerTentList",[]];
_tents = _tents - [objNull];
_tents pushBack _tent;
missionNamespace setVariable ["ncb_gv_playerTentList",_tents];

// dynamic simululation

_tent enableDynamicSimulation true;

true