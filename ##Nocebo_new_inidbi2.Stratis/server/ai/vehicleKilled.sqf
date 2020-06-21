#include "\nocebo\defines\scriptDefines.hpp"

// server runs this

params ["_veh","_killer"];

if (dynamicSimulationEnabled _veh) then {
	_veh enableDynamicSimulation false
};

{
	if (_x isKindOf "AllVehicles") then {
		detach _x;
		[_x,[random 20 - 10, random 20 - 10,random 20]] call horde_fnc_setVelocityGlobal;
		_x setDamage 1;
	} else {
		deleteVehicle _x
	};
	true
} count attachedObjects _veh;

[
	[_veh],{
		call horde_fnc_getEachFrameArgs params ["_veh"];
		_veh removeAllEventHandlers "Dammaged";
		_veh removeAllEventHandlers "GetIn";
		_veh removeAllEventHandlers "GetOut";
		_veh removeAllEventHandlers "HandleDamage";
		_veh setVariable ["deadDeleteTime",(round time) + ncb_param_removeDeadTimeout];
		call horde_fnc_removeEachFrame
	},
	(random 5) + 2
] call horde_fnc_addEachFrame;

true




