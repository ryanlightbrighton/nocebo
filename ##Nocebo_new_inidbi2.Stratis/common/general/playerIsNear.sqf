#include "\nocebo\defines\scriptDefines.hpp"

// example: bool = ([logic1,100] call horde_fnc_playerIsNear);

// playerIsNear(logic1,100)

// for arrays that aren't players use: (({if (_x distance obj1 < 100) exitWith {1}} count MYARRAY) isEqualTo 0)

/*vehicles return as player (when in a heli, isPlayer vehicle player is true)*/
{
	if (isPlayer _x) exitWith {
		1
	}
} count ((_this select 0) nearEntities [
		["ncb_player_base","LandVehicle","Air","Ship_F"],
		(_this select 1)
	]
) isEqualTo 1
