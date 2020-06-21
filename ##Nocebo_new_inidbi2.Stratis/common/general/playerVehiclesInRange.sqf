#include "\nocebo\defines\scriptDefines.hpp"

// example: array = ([logic1,100] call horde_fnc_allPlayersInRange);

// allPlayersInRange(logic1,100)

// lists players on foot and vehicles carrying players only within range of obj/pos.  The returned array will not include crew of vehicles, but the vehicles themselves.

private _players = [];
{
	if (isPlayer _x) then {
		_players pushBack _x;
	};
} forEach ((_this select 0) nearEntities [
	["ncb_player_base","LandVehicle","Air","Ship_F"],
	(_this select 1)
]);

_players

