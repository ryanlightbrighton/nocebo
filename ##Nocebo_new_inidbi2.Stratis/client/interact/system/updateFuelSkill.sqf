#include "\nocebo\defines\scriptDefines.hpp"

(player getVariable [_this,[0,0]]) params ["_skillLevel","_fuelTotal"];

_fuelTotal = _fuelTotal + 1;

if (_fuelTotal >= _skillLevel ^ 2) then {
	_skillLevel = _skillLevel + 1;
	["fuel handling",_skillLevel] call horde_fnc_displayActionSkillMessage;
};
player setVariable [_this,[_skillLevel,_fuelTotal]];

true