#include "\nocebo\defines\scriptDefines.hpp"

params ["_jobtime","_skill"];

getVar(player,_skill) params ["_skillLevel"];

private _multiplier = 1;
if diff(_skillLevel,0) then {
	_multiplier = 1 - (_skillLevel / 20);
};

(_jobTime * _multiplier) max 3