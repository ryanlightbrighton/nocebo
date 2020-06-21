#include "\nocebo\defines\scriptDefines.hpp"

// open this when respawn menu opens - update on each frame

[
	[],{
		private _menu = getVar(uiNamespace,"Horde_respawnMenu");
		if (isNil {_menu} or {isNull _menu}) then {
			// map is closed - set marker dirs back to 0 and delete group markers
			{
				if (_x find "respawn_west_tent_" > -1) then {
					_x setMarkerDirLocal 0;
				};
				if (_x find "respawn_west_grp_player_" > -1) then {
					deleteMarkerLocal _x;
				};
			} count allMapMarkers;
			call horde_fnc_removeEachFrame
		} else {
			// rotate markers
			{
				if (_x find "respawn_west_tent_" > -1) then {
					_x setMarkerDirLocal ((time * 60) % 360)
				};
			} count allMapMarkers;

			// check for group markers = if none then generate otherwise update
			private _group = group player;
			private _units = units _group;
			_units = _units - [player];
			if (count _units > 0) then {
				// generate markers if not already there
				{
					_mkrName = "respawn_west_grp_player_" + getPlayerUID _x;
					if !(_mkrName in allMapMarkers) then {
						// create it
						_mkr = createMarkerLocal [_mkrName,position _x];
						_mkr setMarkerSizeLocal [1, 1];
						_mkr setMarkerTypeLocal "b_inf";
						_mkr setMarkerColorLocal "ColorBlue";
						_mkr setMarkerAlphaLocal 1;
					} else {
						// set position & dir
						if (alive _x) then {
							_mkrName setMarkerPosLocal position _x;
							_mkrName setMarkerDirLocal direction _x;
						} else {
							_mkrName setMarkerPosLocal [-10000,-10000,0];
						}
					}
				} forEach _units;
			}
		}
	},
	0
] call horde_fnc_addEachFrame;

true



/*[
	[],{
		private _menu = getVar(uiNamespace,"Horde_respawnMenu");
		if (isNil {_menu} or {isNull _menu}) then {
			// map is closed - set marker dirs back to 0
			{
				if (_x find "respawn_west_tent_" > -1) then {
					_x setMarkerDirLocal 0;
				};
			} count allMapMarkers;
			call horde_fnc_removeEachFrame
		} else {
			// rotate markers
			{
				if (_x find "respawn_west_tent_" > -1) then {
					_x setMarkerDirLocal ((time * 60) % 360)
				};
			} count allMapMarkers;
		};

	},
	0
] call horde_fnc_addEachFrame;

true*/