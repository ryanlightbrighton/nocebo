#include "\nocebo\defines\scriptDefines.hpp"

// determine where we place marker (aggregate of artillery positions)
params ["_zone","_taskID","_taskVehicles"];

private _taskMarkerPos = [0,0,0];
if not empty(_taskVehicles) then {
	{
		private _vehPos = getPos _x;
		for "_i" from 0 to 2 do {
			_taskMarkerPos set [_i,(_taskMarkerPos select _i) + (_vehPos select _i)]
		};
	} count _taskVehicles;

	for "_i" from 0 to count _taskVehicles - 1 do {
		_taskMarkerPos set [_i,(_taskMarkerPos select _i) * (1 / count _taskVehicles)]
	};
} else {
	_taskMarkerPos = getPos _zone
};

private _locs = [];
{
	if not (text _x isEqualTo "") then {
		_locs pushBack [_x,position _x]
	};
} forEach nearestLocations [ASLtoAGL _taskMarkerPos,ncb_gv_allLocationTypes,1000];


private _locName = "in the Wilderness";
private _bestDist = 9999;
{
	_x params ["_name","_pos"];
	private _testDist = _pos distance2D _taskMarkerPos;
	if (_testDist < _bestDist) then {
		_bestDist = _testDist;
		_locName = text _name;
	};
} forEach _locs;

if (_locName find "'" > -1) then {
	_locName = _locName splitString "'" joinstring " ";
};

// add killed eh to vehicles
{
	_x addEventHandler ["killed",
		format [
			"[_this,%1,'%2',%3] call horde_fnc_checkArtilleryTaskComplete",
			_zone,
			_locName,
			_taskMarkerPos
		]
	];
} forEach _taskVehicles;

// setup task

if empty(ncb_gv_missionArtilleryEmplacementZones) then {
	private _return = [
		/*params*/"ncb_task_destroyArtillery",
		/*target*/true,
		/*desc*/["Destroy all Artillery","Destroy each Artillery Emplacement to cripple Antagonist Artillery support.","Destroy All Artillery"],
		/*dest*/objNull,
		/*state*/"CREATED",
		/*priority*/0,
		/*showNotification*/false,
		/*isGlobal*/true,
		/*type*/"",
		/*shared*/false
	] call BIS_fnc_setTask;
};

private _statement = "";
if (_locName == "in the Wilderness") then {
	_statement = "Destroy Mobile Artillery Pieces in the Wilderness";
} else {
	_statement = format ["Destroy Mobile Artillery Pieces near %1",_locName];
};
private _return = [
	/*params*/[_taskID,"ncb_task_destroyArtillery"],
	/*target*/true,
	/*desc*/["Blow up each Mobile Artillery Piece.  There are up to three per squadron.",_statement,_statement],
	/*dest*/_taskMarkerPos,
	/*state*/"CREATED",
	/*priority*/0,
	/*showNotification*/false,
	/*isGlobal*/true,
	/*type*/"destroy",
	/*shared*/false
] call BIS_fnc_setTask;

ncb_gv_missionArtilleryEmplacementZones pushBack _zone;

true