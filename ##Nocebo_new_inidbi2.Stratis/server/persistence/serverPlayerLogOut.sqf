#include "\nocebo\defines\scriptDefines.hpp"

params ["_serverShutdown","_player","_food","_water","_bleeding","_lodgedBullets","_skillCook","_skillEngineer","_skillFuelling","_skillLogistics","_skillSurgeon","_skillTyreFitter","_skillMagazineFitter","_skillWeaponFitter","_distanceData"];

diag_log "--------------------------------------------------------";
diag("started");
diag(_this);
diag_log "--------------------------------------------------------";

private _UID = getPlayerUID _player;

["write",[_UID,"Name",name _player]] call ncb_gv_iniDbiPlayer;
["write",[_UID,"position",getPosWorld _player]] call ncb_gv_iniDbiPlayer;
["write",[_UID,"direction",getDir _player]] call ncb_gv_iniDbiPlayer;
["write",[_UID,"stance",animationState _player]] call ncb_gv_iniDbiPlayer;
["write",[_UID,"currentMuzzle",currentMuzzle _player]] call ncb_gv_iniDbiPlayer;
["write",[_UID,"playerKills",_player getVariable ["playerKills",0]]] call ncb_gv_iniDbiPlayer;
["write",[_UID,"aiKills",_player getVariable ["aiKills",0]]] call ncb_gv_iniDbiPlayer;
private _uniform = uniform _player;
if (isNil "_uniform") then {
	_uniform = ""
};
private _items = itemCargo uniformContainer _player;
if (isNil "_items") then {
	_items = []
};
private _mags = magazinesAmmoCargo uniformContainer _player;
if (isNil "_mags") then {
	_mags = []
};
private _weaps = weaponsItemsCargo uniformContainer _player;
if (isNil "_weaps") then {
	_weaps = []
};
["write",[_UID,"uniform",[_uniform,[_items,_mags,_weaps]]]] call ncb_gv_iniDbiPlayer;
private _vest = vest _player;
if (isNil "_vest") then {
	_vest = ""
};
private _items = itemCargo vestContainer _player;
if (isNil "_items") then {
	_items = []
};
private _mags = magazinesAmmoCargo vestContainer _player;
if (isNil "_mags") then {
	_mags = []
};
private _weaps = weaponsItemsCargo vestContainer _player;
if (isNil "_weaps") then {
	_weaps = []
};
["write",[_UID,"vest",[_vest,[_items,_mags,_weaps]]]] call ncb_gv_iniDbiPlayer;
private _backpack = backpack _player;
if (isNil "_backpack") then {
	_backpack = ""
};
private _items = itemCargo backpackContainer _player;
if (isNil "_items") then {
	_items = []
};
private _mags = magazinesAmmoCargo backpackContainer _player;
if (isNil "_mags") then {
	_mags = []
};
private _weaps = weaponsItemsCargo backpackContainer _player;
if (isNil "_weaps") then {
	_weaps = []
};
["write",[_UID,"backpack",[_backpack,[_items,_mags,_weaps]]]] call ncb_gv_iniDbiPlayer;
["write",[_UID,"weapons",weaponsItems _player]] call ncb_gv_iniDbiPlayer;
["write",[_UID,"assignedItems",assignedItems _player]] call ncb_gv_iniDbiPlayer;
["write",[_UID,"headgear",headgear _player]] call ncb_gv_iniDbiPlayer;
["write",[_UID,"goggles",goggles _player]] call ncb_gv_iniDbiPlayer;
["write",[_UID,"food",_food]] call ncb_gv_iniDbiPlayer;
["write",[_UID,"water",_water]] call ncb_gv_iniDbiPlayer;
["write",[_UID,"bleeding",_bleeding]] call ncb_gv_iniDbiPlayer;
["write",[_UID,"lodgedBullets",_lodgedBullets]] call ncb_gv_iniDbiPlayer;
["write",[_UID,"damage",damage _player]] call ncb_gv_iniDbiPlayer;
private _hitPointList = [["HitFace",0],["HitNeck",0],["HitHead",0],["HitPelvis",0],["HitAbdomen",0],["HitDiaphragm",0],["HitChest",0],["HitBody",0],["HitArms",0],["HitHands",0],["HitLegs",0]];
{
	_x set [1,_player getHitPointDamage (_x select 0)]
} forEach _hitPointList;
["write",[_UID,"hitPoints",_hitPointList]] call ncb_gv_iniDbiPlayer;
["write",[_UID,"skillCook",_skillCook]] call ncb_gv_iniDbiPlayer;
["write",[_UID,"skillEngineer",_skillEngineer]] call ncb_gv_iniDbiPlayer;
["write",[_UID,"skillFuelling",_skillFuelling]] call ncb_gv_iniDbiPlayer;
["write",[_UID,"skillLogistics",_skillLogistics]] call ncb_gv_iniDbiPlayer;
["write",[_UID,"skillSurgeon",_skillSurgeon]] call ncb_gv_iniDbiPlayer;
["write",[_UID,"skillTyreFitter",_skillTyreFitter]] call ncb_gv_iniDbiPlayer;
["write",[_UID,"skillMagazineFitter",_skillMagazineFitter]] call ncb_gv_iniDbiPlayer;
["write",[_UID,"skillWeaponFitter",_skillWeaponFitter]] call ncb_gv_iniDbiPlayer;
["write",[_UID,"skillWeaponFitter",_skillWeaponFitter]] call ncb_gv_iniDbiPlayer;
["write",[_UID,"distanceData",_distanceData]] call ncb_gv_iniDbiPlayer;

// add variable to player object.  This tells the missionEventHandler that player has logged out correctly.  If not, then delete DB entry for player (player has ALT F4/crashed etc)

_player setVariable ["correctLogOut",true];

// this is the exception so that if a player parks a vehicle he has just taken from a zone and then logs out in that zone it will not be deleted.

diag(_serverShutdown);
if not (_serverShutdown) then {
	if (not isNull (nearestObject [getPos _player,"ncb_obj_tent_dome"])) then {
		// set any near empty vehicles to be excluded if they are empty
		private _vehicles = _player nearEntities [["LandVehicle","Air","Ship_F"],50];
		_vehicles = _vehicles select {{alive _x} count crew _x == 0};
		{
			_x setVariable ["ncb_garbageExcluded",true]
		} forEach _vehicles;
	}
};

// log all clients out except host on hosted server
private _type = if (_serverShutdown) then {"serverShutDown"} else {"savedPlayerStats"};
if not (player isEqualTo _player) then {
	_type remoteExecCall [
		"endMission",
		_player
	];
};

true