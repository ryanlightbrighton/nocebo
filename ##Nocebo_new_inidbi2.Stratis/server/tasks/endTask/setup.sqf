#include "\nocebo\defines\scriptDefines.hpp"

/*"B_Ship_Gun_01_F" [-0.0175781,-78.95,11.9841];
"B_Ship_MRLS_01_F" [0.000976563,-62.2217,0.62267];
"B_AAA_System_01_F" [-0.180664,-48.1677,1.86881];
"B_AAA_System_01_F" [-9.62402,9.52246,0.50216];
"B_AAA_System_01_F" [9.69238,9.31494,0.622216];
"B_SAM_System_02_F" [0.0341797,35.4907,0.433431];
"B_SAM_System_01_F" [-0.0546875,50.6006,0.433254];*/

scriptName "replace_me_ark_mission";

waitUntil {
	sleep 10;
	count ncb_gv_missionAirBaseZones == 0 and {count ncb_gv_missionArtilleryEmplacementZones == 0} and {count ncb_gv_missionRadioTransZones == 0}
};


_spawnShip = {

	// [Object to attach, Position coef. in position array([0,0,0] if you skip), Defense systems in classNames(["B_AAA_System_01_F","B_AAA_System_01_F","B_SAM_System_01_F"] if you skip), Disable helipad(true if you skip)]
	if (!isServer) exitWith {} ;
	params [
		["_obj",player,[objNull]],
		["_posCoef",[0,0,0],[[]]],
		["_turrets",[],[[],true]],
		["_disableAirport",true,[true]]
	] ;

	if (typeName _turrets == "ARRAY") then {
		_turrets resize 3 ;
		{
			if (isNil {_x} or {typeName _x != "STRING"}) then {
				_turrets set [_forEachIndex,call {
					if (_forEachIndex in [2]) exitWith {"B_SAM_System_01_F"} ;
					if (_forEachIndex in [0,1]) exitWith {"B_AAA_System_01_F"} ;
				}] ;
			} ;
		} forEach _turrets ;

		_turrets = ["B_Ship_Gun_01_F","B_Ship_MRLS_01_F"] + _turrets ;

		_turretsData = [
			[[0,79.6,12.7],[0,0,0],180],
			[[0,62.5,10.0],[0,0,0],0],
			[[0,47.3,14.86],[0,0.7,0],180],
			[[0,-35.3,19.003],[0,-0.7,0],0],
			[[0,-50.6,15.55],[0,-0.6,0],0]
		] ;
		{
			_x params ["_pos","_posAAA","_dir"] ;
			_class = _turrets select _forEachIndex ;
			_heightCoef = call {
				if (_class == "B_AAA_System_01_F") exitWith {0.73} ;
				if (_class == "B_SAM_System_02_F") exitWith {0.2} ;
				0
			};
			/*_turret = createVehicle [_class,[0,0,0],[],0,"CAN_COLLIDE"];
			_turret attachTo [_obj,_pos vectorAdd [0,0,_heightCoef] vectorAdd ([[0,0,0],_posAAA] select (_class == "B_AAA_System_01_F")) vectorAdd _posCoef];
			_turret setDir _dir+180;*/
			_logic = createVehicle ["LOGIC",[0,0,0],[],0,"CAN_COLLIDE"];
			_logic attachTo [_obj,_pos vectorAdd [0,0,_heightCoef] vectorAdd ([[0,0,0],_posAAA] select (_class == "B_AAA_System_01_F")) vectorAdd _posCoef];
			_turret = createVehicle [_class,[0,0,0],[],0,"CAN_COLLIDE"];
			_turret attachTo [_logic,[0,0,0]];
			_turret setDir _dir+180;
			createVehicleCrew _turret;
		} forEach _turretsData ;
	} ;
	_base = createSimpleObject ["Land_Destroyer_01_base_F",[0,0,0]] ;
	_data = (getArray (configfile >> "CfgVehicles" >> "Land_Destroyer_01_base_F" >> "multiStructureParts")) apply {
		_pos = _base selectionPosition (_x select 1) ;
		[
			_x select 0,
			[
				-(_pos select 0),
				-(_pos select 1),
				(_pos select 2) - 2
			]
		]
	};

	{
		_x params ["_class","_pos"] ;
		//if (!_disableAirport or _class != "Land_HelipadEmpty_F") then {
		if (true) then {
			_part = createVehicle [_class,[0,0,0],[],0,"CAN_COLLIDE"] ;
			_part attachTo [_obj,_pos vectorAdd _posCoef] ;
			_part setDir 180 ;
		} ;
	} forEach _data;

	deleteVehicle _base;
};

// fires when all main tasks are complete (what if no other tasks selected??)

// need to spawn the ark somewhere the players need to collect

// how will they know where it is???

// task

//   model from https://www.cgtrader.com/items/70696/download-page

// list of positions in importnant buildings (churches maybe)  ncb_gv_zoneList  getVar(_zone,"zoneMilBuildings",[]);
// private _rescuePos = ????   // position on beach somewhere?? ncb_pv_playerSpawnPlaces

// filter zones with mil buildings

private _zones = [];
{
	private _structures = _x getVariable ["zoneMilBuildings",[]];
	if ({count (_x  buildingPos -1) > 0} count _structures > 0) then {
		_zones pushBack _x;
	}
} forEach ncb_gv_zoneList;

// now select a zone

private _arkZone = selectRandom _zones;
private _milBuildings = _arkZone getVariable ["zoneMilBuildings",[]];
private _arkBuildings = [];
{
	if (count (_x buildingPos -1) > 0) then {
		_arkBuildings pushBack _x
	};
} forEach _milBuildings;
private _arkBuilding = selectRandom _arkBuildings;
private _spawnPos = selectRandom (_arkBuilding buildingPos -1);
private _ark = createVehicle ["ncb_obj_ammobox_m",_spawnPos,[],0,"can_collide"];
_ark allowDamage false;
_ark spawn {
	sleep 10;
	_this allowDamage true;
};

private _statement = format ["There is an artefact at Grid: %1.  Get it then deliver it to the USS Liberty", mapGridPosition _spawnPos];
private _taskID = [
	"ncb_task_stealArk", // params
	true, // target
	[_statement,"Steal ark",""], // desc
	_ark, // dest
	"CREATED", // state
	0, // priority
	true, // showNotification
	true, // isGlobal
	"takeoff", // type
	true // 3d marker
] call BIS_fnc_setTask;


_ark addEventHandler ["killed", {
	0 spawn {
		['ncb_task_stealArk','Failed'] call BIS_fnc_taskSetState;
		sleep 7;
		"arkDestroyed" remoteExecCall [
			"endMission",
			0
		]
	}
}];

// make all the other zones have minimal resistance

{
	if (_x isEqualTo _arkZone) then {
		_x setVariable ["zoneMaxSquadCount", 4];
	} else {
		_x setVariable ["zoneMaxSquadCount", 1];
	}
} forEach ncb_gv_zoneList;

// now we need a way of checking if the ark is near the extraction zone

// this script is spawned currently so we can loop & sleep in here


/*_scan = getNumber (configFile >> "CfgWorlds" >> worldName >> "mapSize");

_spawnPositions = [];
for "_xval" from 0 to _scan step 500 do {
	for "_yval" from 0 to _scan step 500 do {
		private _coords = [_xval,_yval];
		if (surfaceIsWater _coords and {abs getTerrainHeightASL _coords > 30}) then {
			_spawnPositions pushBack _coords;
		}
	}
};

private _coord = selectRandom _spawnPositions;



_height = abs getTerrainHeightASL _coord;
_coord pushBack _height;
_mkr = createMarkerLocal ["MR_MARKER",_coord];
_mkr setMarkerSizeLocal [1, 1];
_mkr setMarkerTypeLocal "b_inf";
_mkr setMarkerColorLocal "ColorRed";
_mkr setMarkerAlphaLocal 1;*/


// find the helipad

_objs = nearestObjects [ncb_obj_destroyer_base,["Land_HelipadEmpty_F"], 300, true];

player globalChat format ["_objs %1", _objs];

if !(_objs isEqualTo []) then {
	_pad = _objs # 0;
	private _statement = format ["Deliver the artefact to the USS Liberty at Grid: %1.", mapGridPosition _pad];
	private _taskID = [
		"ncb_task_deliverArk", // params
		true, // target
		[_statement,"Deliver ark",""], // desc
		_pad, // dest
		"CREATED", // state
		0, // priority
		true, // showNotification
		true, // isGlobal
		"land", // type
		true // 3d marker
	] call BIS_fnc_setTask;

	waitUntil {
		sleep 1;
		_pad distance _ark < 5
		and {vectorMagnitude velocity _ark == 0}
	};

	['ncb_task_stealArk','Succeeded'] call BIS_fnc_taskSetState;
	['ncb_task_deliverArk','Succeeded'] call BIS_fnc_taskSetState;

	sleep 30;

	"arkRecovered" remoteExecCall [
		"endMission",
		0
	];



} else {
	// error
	diag_log "error helipad not found";
};





