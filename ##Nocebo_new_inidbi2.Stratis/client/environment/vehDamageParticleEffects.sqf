#include "\nocebo\defines\scriptDefines.hpp"

private _sources = [];
{
	private _source = "#particlesource" createVehicleLocal _this;
	_sources pushBack _source;
	_source setParticleClass _x;
} count [
	"Horde_vehiclePartDestroyed_1",
	"Horde_vehiclePartDestroyed_2",
	"Horde_vehiclePartDestroyed_3"
];

[
	[_sources],{
		call horde_fnc_getEachFrameArgs params ["_sources"];
		{
			deleteVehicle _x
		} count _sources;
		call horde_fnc_removeEachFrame
	},
	0.2
] call horde_fnc_addEachFrame;

true