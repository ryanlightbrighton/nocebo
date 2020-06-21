#include "\nocebo\defines\scriptDefines.hpp"

private _blacklist = ncb_pv_airbaseBlacklistPositions + ncb_pv_artilleryBlacklistPositions + ncb_pv_radioBlacklistPositions;

private _spawnData = [];
{
	private _radius = _x;
	{
		_x params ["_pos","_dir"];
		private _ok = true;
		{
			if (_pos distance2D _x < _radius) exitWith {
				_ok = false
			}
		} forEach _blacklist;
		if (_ok) exitWith {
			_spawnData = [_pos,_dir]
		}
	} forEach (+ncb_pv_playerSpawnPlaces call horde_fnc_arrayShuffle);

	if not ([] isEqualTo _spawnData) exitWith {
		diag(_spawnData);
		diag(_radius)
	};
} forEach [
	3000,
	2500,
	2000,
	1500,
	1000
];

if empty(_spawnData) then {
	_spawnData = [markerPos "respawn_west",0];
	diag("no respawn places found - using default (marker)");
	diag("count of 'ncb_pv_playerSpawnPlaces' (beachheads)");
	diag(count ncb_pv_playerSpawnPlaces);
};

_spawnData params ["_respawnPosASL","_respawnDir"];

[ASLtoATL _respawnPosASL,_respawnDir]