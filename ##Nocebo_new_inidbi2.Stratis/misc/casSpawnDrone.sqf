#include "\nocebo\defines\scriptDefines.hpp"

params ["_casType","_item"];

player removeItem _item;

// find spawn place at edge of map.  Base it somewhere near where player is (in same quadrant)

_playerPos = getPosWorld player;
_playerPos params ["_xP","_yP"];


_xSpnMin = 0;
_xSpnMax = worldSize / 2;
_ySpnMin = 0;
_ySpnMax = worldSize / 2;
if (_xP > worldSize / 2) then {
	// start somewhere on the right
	_xSpnMin = worldSize / 2;
	_xSpnMax = worldSize;
};
if (_yP > worldSize / 2) then {
	// start somewhere on the top
	_ySpnMin = worldSize / 2;
	_ySpnMax = worldSize;
};
_spawnPos = if (random 1 > 0.5) then {
	[if (_xP > worldSize / 2) then {worldSize} else {0},_ySpnMin + random (_ySpnMax - _ySpnMin),200]
} else {
	[_xSpnMin + random (_xSpnMax - _xSpnMin),if (_yP > worldSize / 2) then {worldSize} else {0},200]
};

_class = "B_UAV_02_dynamicLoadout_F";
_uav = createVehicle [_class,_spawnPos,[],0,"fly"];
createVehicleCrew _uav;
{
	_x addAction ["View Dist: 1500m", "setViewDistance 1500;setObjectViewDistance [1500,ncb_param_shadowRenderDistance]"];
	_x addAction ["View Dist: 2000m", "setViewDistance 2000;setObjectViewDistance [2000,ncb_param_shadowRenderDistance]"];
	_x addAction ["View Dist: 3000m", "setViewDistance 3000;setObjectViewDistance [3000,ncb_param_shadowRenderDistance]"];
	_x addAction ["View Dist: 4000m", "setViewDistance 4000;setObjectViewDistance [4000,ncb_param_shadowRenderDistance]"];
	nil
} count (crew _uav);
inGameUISetEventHandler ["Action","
	if (_this select 3 == 'BackFromUAV') exitWith {
		setViewDistance 1500;
		setObjectViewDistance [1500,ncb_param_shadowRenderDistance];
		false
	};
"];
_UAV addEventHandler ["killed",{
	setViewDistance 1500;
	setObjectViewDistance [1500,ncb_param_shadowRenderDistance];
}];
_grp = group driver _uav;
_grp addWaypoint [ASLtoAGL _playerPos,0];
_uav setDir (_uav getDir player);
_uav setVelocityModelSpace [0,200,0];
player connectTerminalToUAV _uav;
{_x disableUAVConnectability [_uav,true]} forEach (allPlayers - [player]);
showUAVFeed true;
