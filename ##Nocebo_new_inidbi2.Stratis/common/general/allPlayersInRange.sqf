#include "\nocebo\defines\scriptDefines.hpp"

// example: array = ([logic1,100] call horde_fnc_allPlayersInRange);

// lists ALL players within range of obj/pos
params ["_origin","_range"];

private _players = [];
{
	_players pushBack _x;
} forEach (_origin nearEntities [
	"ncb_player_base",
	_range
]);
{
	{
		if (isPlayer _x) then {
			_players pushBack _x;
		};
	} forEach crew _x;
} forEach (_origin nearEntities [
	["LandVehicle","Air","Ship_F"],
	_range
]);

_players

