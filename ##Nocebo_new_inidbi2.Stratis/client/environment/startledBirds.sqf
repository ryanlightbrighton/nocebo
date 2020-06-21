#include "\nocebo\defines\scriptDefines.hpp"

params ["_treePos","_startPos","_ascendPos","_destinationPos","_roostPos","_numbBirds","_flockDiameter","_birdClass","_spawnPos","_bird","_class"];

[_startPos,"horde_sound_startledBirds",5] call horde_fnc_playSingleSound;

for "_i" from 1 to _numbBirds do {
	_spawnPos = [
		sel(_startPos,0) - 2 + (random 4),
		sel(_startPos,1) - 2 + (random 4),
		sel(_startPos,2) - 0.6 + (random 1.2)
	];
	_bird = _birdClass camCreate _spawnPos;
	_bird setDir (_startPos getDir _bird);
	_bird setVelocity [0,0,5];

	_class = selectRandom ["LeavesFall","LeavesFallDead","LeavesFallPine"];
	[_spawnPos,_class,0.1] call horde_fnc_timedParticleEffect;

	[
		_bird,
		_ascendPos,
		_destinationPos,
		_roostPos,
		_flockDiameter
	] call horde_fnc_birdWaypoints;
};




