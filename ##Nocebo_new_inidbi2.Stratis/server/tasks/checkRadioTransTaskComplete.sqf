#include "\nocebo\defines\scriptDefines.hpp"

// fires when a building is destroyed
// sleep a little bit to allow everything to update

{
	if (_x isKindOf "TimeBombCore") then {
		_x setDamage 1
	} else {
		deleteVehicle _x
	};
} count attachedObjects (_this select 0 select 0);

[
	[_this],{
		call horde_fnc_getEachFrameArgs params ["_args"];
		_args params ["_killedInfo","_zone","_locName"];
		_killedInfo params ["_vehicle","_killer"];
		private _taskID = "RT" + (str _zone);

		private _buildings = getVar(_zone,"zoneTaskBuildingsRadioTransmitter");
		if ({alive _x and {(getPosATL _x) select 2 > -5}} count _buildings isEqualTo 0) then {
			ncb_gv_missionRadioTransZones = ncb_gv_missionRadioTransZones - [_zone];
			ncb_pv_radioBlacklistPositions = ncb_gv_missionRadioTransZones apply {ASLtoAGL getPosASL _x};
			publicVariable "ncb_pv_radioBlacklistPositions";
			[_taskID,"Succeeded"] call BIS_fnc_taskSetState;
			setVar(_zone,"zoneHasRadioInstallation",false);
			setVar(_zone,"zoneVantagePointsRadioTransmitterLow",nil);
			setVar(_zone,"zoneVantagePointsRadioTransmitterHigh",nil);
			setVar(_zone,"zoneStaticBuildingsRadioTransmitter",nil);
			setVar(_zone,"zoneTaskBuildingsRadioTransmitter",nil);
			setVar(_zone,"zoneTriggerRadius",ncb_gv_zoneTriggerRad);
			private _squads = getVarDef(_zone,"zoneOrigSquadCount",1);
			setVar(_zone,"zoneMaxSquadCount",_squads);
		};

		call horde_fnc_removeEachFrame;

		if (ncb_gv_missionRadioTransZones isEqualTo []) then {
			// all bases destroyed
			[
				[],{
					["ncb_task_destroyRadioTransmitters","Succeeded"] call BIS_fnc_taskSetState;
					call horde_fnc_removeEachFrame
				},
				3
			] call horde_fnc_addEachFrame;
		}
	},
	3
] call horde_fnc_addEachFrame;