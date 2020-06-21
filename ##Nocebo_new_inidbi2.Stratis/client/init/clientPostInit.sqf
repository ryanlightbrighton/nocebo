#include "\nocebo\defines\scriptDefines.hpp"

if not (hasInterface) exitWith {};

if not (isNil "ncb_gv_ranClientPostInit") exitWith {
	diag_log "/**************************************/";
	diag("trying to read client post-init twice");
	diag_log "/**************************************/";
};

ncb_gv_ranClientPostInit = true;

waitUntil {
	uiSleep 0.1;
	not isNil "ncb_fnc_init"
};

waitUntil {
	uiSleep 0.1;
	not isNil "ncb_pv_paramsArray" and {ncb_pv_paramsArray isEqualType []}
};

// test (some code is in serverPostInit as well)

/*"ncb_pv_clientFunctions" addPublicVariableEventHandler {
	params ["","_array"];
	diag("client received fncs from server");
	diag(count _array);
	{
		_x params ["_fncName","_code"];
		diag(_fncName);
		missionNameSpace setVariable [_fncName,_code]
	} forEach _array;
	ncb_gv_functionsReceived = true;
};

ncb_pv_requestClientFunctions = player;
publicVariableServer "ncb_pv_requestClientFunctions";

if (isServer and {hasInterface}) then {
	ncb_gv_functionsReceived = true
};
waitUntil {
	uiSleep 0.1;
	not isNil "ncb_gv_functionsReceived"
};*/

// end test

// set up params if not server
if not (isServer) then {
	diag_log "/**************************************/";
	diag("params check (client)");
	for "_i" from 0 to count ncb_pv_paramsArray - 1 do {
		_args = ncb_pv_paramsArray select _i;
		missionNamespace setVariable _args;
		diag(_args);
	};
	diag_log "/**************************************/";
};

// https://community.bistudio.com/wiki/disableRemoteSensors
if not (isServer) then {
	disableRemoteSensors true
};

// add custom locations (sent from server in pre-init)
if not (isServer) then {
	call ncb_pv_customLocations;
};

// [] call compile preprocessFileLineNumbers "fn_advancedSlingLoadingInit.sqf";

/*[
	["weatherSync"],{
		if (time > 0.1) then {
			simulWeatherSync;
			call horde_fnc_removeEachFrame
		};
	},
	0.1
] call horde_fnc_addEachFrame;*/

if (ncb_param_weatherSystemSelect == 1) then {
	ncb_gv_weatherStart = true;
	"ncb_gv_currentWeather" addPublicVariableEventHandler {
		// first JIP synchronization
		if (ncb_gv_weatherStart) then {
			diag_log format ["start weather %1", ncb_gv_weatherStart];
			ncb_gv_weatherStart = false;
			skipTime -24;
			86400 setFog (ncb_gv_currentWeather select 0);
			86400 setOvercast (ncb_gv_currentWeather select 1);
			86400 setRain (ncb_gv_currentWeather select 2);
			skipTime 24;
			setWind (ncb_gv_currentWeather select 3);
			setDate (ncb_gv_currentWeather select 5);
			0 setRain (ncb_gv_currentWeather select 2);
		} else {
			private _oldRain = ncb_gv_currentWeather select 2;
			ncb_gv_currentWeather = _this select 1;
			if (fog < (ncb_gv_currentWeather select 0) - 0.01
				or {fog > (ncb_gv_currentWeather select 0) + 0.01}
			) then {
				60 setFog (ncb_gv_currentWeather select 0);
			};
			if (overcast < (ncb_gv_currentWeather select 1) - 0.01
				or {overcast > (ncb_gv_currentWeather select 1) + 0.01}
			) then {
				60 setOvercast (ncb_gv_currentWeather select 1);
			};
			if (rain < (ncb_gv_currentWeather select 2) - 0.01
				or {rain > (ncb_gv_currentWeather select 2) + 0.01}
			) then {
				60 setRain (ncb_gv_currentWeather select 2);
			};
			if (wind select 0 < (ncb_gv_currentWeather select 3 select 0) - 0.01
				or {wind select 0 > (ncb_gv_currentWeather select 3 select 0) + 0.01}
				or {wind select 1 < (ncb_gv_currentWeather select 3 select 1) - 0.01}
				or {wind select 1 > (ncb_gv_currentWeather select 3 select 1) + 0.01}
			) then {
				setWind (ncb_gv_currentWeather select 3);
			};
			setDate (ncb_gv_currentWeather select 5);
			if (_oldRain > 0.3 and {(ncb_gv_currentWeather select 2) < 0.3}) then {
				// try and make lovely rainbows
				120 setRainbow 1;
			};
		};
	};
};

if not (ncb_param_personalWaypoint) then {
	onMapSingleClick {_shift};
};

player createDiaryRecord ["Diary",["Mission","Line 1.<br /><br />Line 2"]];
player createDiaryRecord ["Diary",["Situation","Line 1.<br /><br />Line 2"]];
player createDiaryRecord ["Diary",["Intelligence Revealed","Line 1.<br /><br />Line 2"]];
player createDiaryRecord ["Diary",["Global Background","Line 1.<br /><br />Line 2"]];
player createDiaryRecord ["Diary",["Radio Stations","Destroy the radio mast and power transformer at each base to cripple reinforcements.<br /><br /><img image='nocebo\images\radio_station.paa' />"]];

playerRespawnType = "LOGIN";

player addEventHandler ["put",{_this call horde_fnc_playerPut}];
player addEventHandler ["take",{_this call horde_fnc_playerTake}];
player addEventHandler ["handleDamage",{_this call horde_fnc_playerHandleDamage}];
player addEventHandler ["handleRating",{0}];
// moved to playerSetNeeds or this and that will try to overwrite each other
/*player addEventHandler ["animStateChanged",{
	params ["_unit","_anim"];
	if (_anim select [4,4] == "ppne"
	    and {uniform _unit in ncb_gv_ghillieSuits}
	) then {
		if (_unit getUnitTrait "camouflageCoef" != 0.5) then {
			_unit setUnitTrait ["camouflageCoef",0.5]
		}
	} else {
		if (_unit getUnitTrait "camouflageCoef" != 1) then {
			_unit setUnitTrait ["camouflageCoef",1]
		}
	}
}];*/

{
	_x setMarkerAlphaLocal 0
} count (allMapMarkers select {toLower _x find "blacklist" > -1 or {toLower _x find "shipping_lane" > -1}});
if !(ncb_param_mapMarkers) then {
	addMissionEventHandler ["map",{
		params ["_opened","_forced"];
		if (_opened) then {
			//if not ("itemgps" in assignedItems player) then { // hmm perhaps contentious....
				{
					if (_x find "respawn_west_tent_" > -1) then {
						_x setMarkerAlphaLocal 0
					};
				} count allMapMarkers
			//}
		} else {
			[
				[diag_frameno],{
					call horde_fnc_getEachFrameArgs params ["_frame"];
					if (diag_frameno > _frame) then {
						{
							if (_x find "respawn_west_tent_" > -1) then {
								_x setMarkerAlphaLocal 1
							};
						} count allMapMarkers;
						call horde_fnc_removeEachFrame
					}
				},
				0
			] call horde_fnc_addEachFrame
		}
	}];
};

0 spawn {
	// this disables the UAVs if player has loaded from DB with a UAV terminal.  There is also a check for take EH in case player picks up a terminal
	sleep 10;
	{
		player disableUAVConnectability [_x,true];
	} forEach [
		ncb_obj_destroyer_hammer,
		ncb_obj_destroyer_vls,
		ncb_obj_destroyer_praetorian_fwd,
		ncb_obj_destroyer_praetorian_port,
		ncb_obj_destroyer_praetorian_starboard,
		ncb_obj_destroyer_centurion,
		ncb_obj_destroyer_spartan
	];
};

// group 3d markers

[
	[],{
		if (alive player and {lifeState player != "INCAPACITATED"}) then {
			private _units = units group player - [player];
			if ! (_units isEqualTo []) then {
				{
					if (alive _x) then {
						_size = 12 / (((positionCameraToWorld [0,0,0]) distance _x) max 0.1);
						_color = [1,1,1,1];
						private _progress = 1 - (damage _x);
						if (_progress > 0.5) then {
							_color = [
								linearConversion [0.5,1,_progress,1,0,true],
								1,
								0,
								1
							];
						} else {
							_color = [
								1,
								linearConversion [0,0.5,_progress,0,1,true],
								0,
								1
							];
						};
						if (lifeState _x != "INCAPACITATED") then {
							drawIcon3D ["\a3\ui_f\data\igui\cfg\cursors\select_ca.paa", _color, _x modelToWorldVisual (_x selectionPosition "body"), _size, _size, 0, name _x + endl + format ["%1m", round (player distance _x)], 1, 0.02, "EtelkaMonospaceProBold", "center", true];
							if (_x isEqualTo leader group player) then {
								drawIcon3D ["\a3\ui_f\data\igui\cfg\cursors\leader_ca.paa", _color, _x modelToWorldVisual (_x selectionPosition "body"), _size, _size, 0, "", 1, 0.02, "EtelkaMonospaceProBold", "center", true];
							}
						} else {
							// integrate the downed icon here
							drawIcon3D ["nocebo\images\skull.paa", [1,1,1,1], _x modelToWorldVisual (_x selectionPosition "body"), 2, 2, 0, name _x + endl + format ["%1m", round (player distance _x)], 1, 0.02, "EtelkaMonospaceProBold", "center", true]
						}
					}
				} count _units;
			}
		}
	},
	0
] call horde_fnc_addEachFrame;

diag_log "/**************************************/";
diag("client post-init done");
diag_log "/**************************************/";