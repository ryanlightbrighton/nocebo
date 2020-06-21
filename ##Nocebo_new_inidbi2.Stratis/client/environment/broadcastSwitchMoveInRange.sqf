#include "\nocebo\defines\scriptDefines.hpp"

params ["_player","_range","_anim"];

[_player,_anim] remoteExecCall [
	"horde_fnc_switchMoveGlobal",
	[_player,_range] call horde_fnc_allPlayersInRange
];

true