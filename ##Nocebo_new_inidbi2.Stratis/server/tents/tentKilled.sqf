#include "\nocebo\defines\scriptDefines.hpp"

// ran on server from config EventHandler when tent is killed

params ["_tent"];

private _dets = getVarDef(_tent,"tentOwnerDetails",[]);
diag(_dets);
if not empty(_dets) then {
	_dets params ["_uid","_markerName","_users"];
	call {
		if (_users == "personal") exitWith {
			{
				if (getPlayerUID _x == _uid) exitWith {
					_markerName remoteExecCall [
						"horde_fnc_playerRemoveTentMarker",
						_x
					];
				};
			} forEach allPlayers;
		};
		if (_users == "group") exitWith {
			diag(_markerName);
			_markerName remoteExecCall [
				"horde_fnc_playerRemoveTentMarker",
				0
			];
		};
		if (_users == "side") exitWith {
			deleteMarker _markerName
		};
	};

};

_tent setVariable ["deadDeleteTime",(round time) + 60];
ncb_gv_garbageContents pushBack _tent;
true
