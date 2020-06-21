#include "\nocebo\defines\scriptDefines.hpp"

// fires when a sochor is destroyed
params ["","_zone","_locationName","_markerPos"];

private _vehs = getVar(_zone,"zoneArtilleryVehicles");
private _count = {alive _x} count _vehs;
if (_locationName == "in the Wilderness") then {
	_locationName = format ["in The Wilderness near (%1)",mapGridPosition _markerPos]
} else {
	_locationName = "near " + _locationName
};

private _text = "error!";
call {
	if (_count > 1) exitWith {
		_text = format ["%1 Sochors %2 remain",_count,_locationName]
	};
	if (_count == 1) then {
		_text = format ["Only %1 Sochor %2 remains",_count,_locationName]
	} else {
		_text = format ["All Sochors %1 are destroyed",_locationName]
	};
};

["TaskUpdated",["",_text]] remoteExecCall [
	"BIS_fnc_showNotification",
	if (isDedicated) then {-2} else {0}
];

[
	[_this],{
		call horde_fnc_getEachFrameArgs params ["_args"];
		_args params ["_killedInfo","_zone","_locName"];
		_killedInfo params ["_vehicle","_killer"];
		private _taskID = "AY" + (str _zone);

		private _vehicles = getVarDef(_zone,"zoneArtilleryVehicles",[]);
		if ({alive _x} count _vehicles isEqualTo 0) then {
			ncb_gv_missionArtilleryEmplacementZones = ncb_gv_missionArtilleryEmplacementZones - [_zone];
			ncb_pv_artilleryBlacklistPositions = ncb_gv_missionArtilleryEmplacementZones apply {ASLtoAGL getPosASL _x};
			publicVariable "ncb_pv_artilleryBlacklistPositions";
			[_taskID,"Succeeded"] call BIS_fnc_taskSetState;
			setVar(_zone,"zoneHasArtilleryEmplacement",false);
			setVar(_zone,"zoneArtilleryGunPositions",nil);
			setVar(_zone,"zoneArtilleryMenPositions",nil);
			setVar(_zone,"zoneArtilleryVehicles",nil);
			setVar(_zone,"zoneTriggerRadius",ncb_gv_zoneTriggerRad);
			private _squads = getVarDef(_zone,"zoneOrigSquadCount",1);
			setVar(_zone,"zoneMaxSquadCount",_squads);
			// hmm, what about the other static gun and leftover group (maybe change task to destroy artillery squad)
		};

		call horde_fnc_removeEachFrame;

		if (ncb_gv_missionArtilleryEmplacementZones isEqualTo []) then {
			// all bases destroyed
			[
				[],{
					["ncb_task_destroyArtillery","Succeeded"] call BIS_fnc_taskSetState;
					call horde_fnc_removeEachFrame
				},
				3
			] call horde_fnc_addEachFrame;
		}
	},
	3
] call horde_fnc_addEachFrame;