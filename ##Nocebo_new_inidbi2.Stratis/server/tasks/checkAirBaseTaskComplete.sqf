#include "\nocebo\defines\scriptDefines.hpp"

// fires when a vehicle is killed
// sleep a little bit to allow everything to update
[
	[_this],{
		call horde_fnc_getEachFrameArgs params ["_args"];
		_args params ["_killedInfo","_zone","_locName"];
		_killedInfo params ["_vehicle","_killer"];
		private _taskID = "AB" + (str _zone);

		// if all vehicles for this air base have been destroyed, then remove the base from the global array of bases (the array is used by heli.fsm to check where they can spawn etc.)

		private _vehs = getVar(_zone,"zoneAirBaseResources");
		if ({alive _x} count _vehs isEqualTo 0) then {
			ncb_gv_missionAirBaseZones = ncb_gv_missionAirBaseZones - [_zone];
			ncb_pv_airbaseBlacklistPositions = ncb_gv_missionAirBaseZones apply {ASLtoAGL getPosASL _x};
			publicVariable "ncb_pv_airbaseBlacklistPositions";
			[_taskID,"Succeeded"] call BIS_fnc_taskSetState;
			setVar(_zone,"zoneHasAirBase",false);
			setVar(_zone,"zoneAirBaseResources",nil);
			setVar(_zone,"zoneTriggerRadius",ncb_gv_zoneTriggerRad);
			_squads = getVarDef(_zone,"zoneOrigSquadCount",1);
			setVar(_zone,"zoneMaxSquadCount",_squads);
		};

		call horde_fnc_removeEachFrame;

		if (ncb_gv_missionAirBaseZones isEqualTo []) then {
			// all bases destroyed
			[
				[],{
					["ncb_task_destroyAirBases","Succeeded"] call BIS_fnc_taskSetState;
					call horde_fnc_removeEachFrame
				},
				3
			] call horde_fnc_addEachFrame
		}
	},
	3
] call horde_fnc_addEachFrame;