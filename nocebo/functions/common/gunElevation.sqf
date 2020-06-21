#include "\nocebo\defines\scriptDefines.hpp"

// EX: player sideChat format ["%1",[vehicle player,true] call horde_fnc_gunElevation];
params ["_veh","_dir","_azimuth","_elevation"];

_dir = _veh weaponDirection currentWeapon _veh;
_azimuth = (_dir select 0) atan2 (_dir select 1);
_azimuth = _azimuth call horde_fnc_normalDir;
_elevation = asin (_dir select 2);
if (_round) then {
	[round _azimuth,round _elevation]
} else {
	[_azimuth,_elevation]
};