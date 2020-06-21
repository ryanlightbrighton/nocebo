#include "\nocebo\defines\scriptDefines.hpp"

(player getVariable ["skillLogistics",[0,0]]) params ["_skillLevel","_pitchedTotal"];

_pitchedTotal = _pitchedTotal + 1;

if (_pitchedTotal >= _skillLevel ^ 2) then {
	_skillLevel = _skillLevel + 1;
	["logistics",_skillLevel] call horde_fnc_displayActionSkillMessage;
};

player setVariable ["skillLogistics",[_skillLevel,_pitchedTotal]];

true