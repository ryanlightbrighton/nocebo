#include "\nocebo\defines\scriptDefines.hpp"

// (similar to playSingleSound, but for particles)
// ex : [_spawnPos,_class,0.1] call horde_fnc_timedParticleEffect;

params ["_spawnPos","_class","_duration"];

private _effect = "#particlesource" createVehicleLocal _spawnPos;
_effect setParticleClass _class;

[
	[_effect],{
		call horde_fnc_getEachFrameArgs params ["_effect"];
		deleteVehicle _effect;
		call horde_fnc_removeEachFrame
	},
	_duration
] call horde_fnc_addEachFrame;

true