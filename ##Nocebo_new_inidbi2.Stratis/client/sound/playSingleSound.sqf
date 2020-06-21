#include "\nocebo\defines\scriptDefines.hpp"

params ["_pos","_type","_duration"];

if (_pos isEqualType objNull) then {
	_pos = getPos _pos
};
private _source = "#particlesource" createVehicleLocal _pos;
_source say3D _type;

[
	[_source],{
		call horde_fnc_getEachFrameArgs params ["_source"];
		deleteVehicle _source;
		call horde_fnc_removeEachFrame
	},
	_duration
] call horde_fnc_addEachFrame;

true