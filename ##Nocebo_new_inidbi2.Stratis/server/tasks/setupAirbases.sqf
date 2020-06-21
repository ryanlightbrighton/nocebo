#include "\nocebo\defines\scriptDefines.hpp"

params ["_zone","_taskID","_locName","_posASL","_vehicles"];

if not empty(_vehicles) then {
	setVar(_zone,"zoneAirBaseResources",_vehicles);
	setVar(_zone,"zoneTriggerRadius",ncb_gv_zoneBaseTriggerRad);
	setVar(_zone,"zoneMaxSquadCount",ncb_param_zoneLocationValueAirBases);
	setVar(_zone,"zoneHasAirBase",true);
	// set master task
	if empty(ncb_gv_missionAirBaseZones) then {
		// set parent task (destroy all airbases)
		private _return = [
			/*params*/"ncb_task_destroyAirBases",
			/*target*/true,
			/*desc*/["Destroy each air base to allow you to attack the governmental palace unharrassed.","Destroy all Air Bases","Destroy All Air Bases"],
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
		_statement = "Destroy the Air Base in the Wilderness";
	} else {
		_statement = format ["Destroy the Air Base near %1",_locName];
	};
	private _return = [
		/*params*/[_taskID,"ncb_task_destroyAirBases"],
		/*target*/true,
		/*desc*/["Blow up the refuelling and rearming vehicles.",_statement,_statement],
		/*dest*/ASLtoAGL _posASL,
		/*state*/"CREATED",
		/*priority*/0,
		/*showNotification*/false,
		/*isGlobal*/true,
		/*type*/"destroy",
		/*shared*/false
	] call BIS_fnc_setTask;

	ncb_gv_missionAirBaseZones pushBack _zone;
	[
		[_vehicles],{
			call horde_fnc_getEachFrameArgs params ["_vehicles"];
			{
				_x allowDamage true
			} count _vehicles;
			call horde_fnc_removeEachFrame
		},
		5
	] call horde_fnc_addEachFrame;

};

true