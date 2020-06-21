#include "\nocebo\defines\scriptDefines.hpp"

/*Executed only on server when a player joins mission (includes both mission start and JIP). See initialization order for details about when the script is exactly executed.*/

params ["_player","_JIP"];

diag(_player);
diag(_JIP);

private _UID = getPlayerUID _player;
private _name = name _player;

diag(_UID);
diag(_name);
diag(netID _player);

// exit if HC

if (toLower _UID find "hc" > -1 or {_player isKindOf "HeadlessClient_F"}) exitWith {
	_player setVariable ["droneLoaded",true];
};

["write",[_UID,"Name",_name]] call ncb_gv_iniDbiPlayer;

private _position = ["read",[_UID,"position",[0,0,0]]] call ncb_gv_iniDbiPlayer;
private _direction = ["read",[_UID,"direction",0]] call ncb_gv_iniDbiPlayer;
private _stance = ["read",[_UID,"stance","amovpknlmstpsnonwnondnon"]] call ncb_gv_iniDbiPlayer;
private _muzzle = ["read",[_UID,"currentMuzzle",""]] call ncb_gv_iniDbiPlayer;
private _playerKills = ["read",[_UID,"playerKills",0]] call ncb_gv_iniDbiPlayer;
private _aiKills = ["read",[_UID,"aiKills",0]] call ncb_gv_iniDbiPlayer;
private _uniform = ["read",[_UID,"uniform",["",[[],[],[]]]]] call ncb_gv_iniDbiPlayer;
private _vest = ["read",[_UID,"vest",["",[[],[],[]]]]] call ncb_gv_iniDbiPlayer;
private _backpack = ["read",[_UID,"backpack",["",[[],[],[]]]]] call ncb_gv_iniDbiPlayer;
private _weapons = ["read",[_UID,"weapons",[]]] call ncb_gv_iniDbiPlayer;
private _assignedItems = ["read",[_UID,"assignedItems",[]]] call ncb_gv_iniDbiPlayer;
private _headgear = ["read",[_UID,"headgear",""]] call ncb_gv_iniDbiPlayer;
private _goggles = ["read",[_UID,"goggles",""]] call ncb_gv_iniDbiPlayer;
private _food = ["read",[_UID,"food",0]] call ncb_gv_iniDbiPlayer;
private _water = ["read",[_UID,"water",0]] call ncb_gv_iniDbiPlayer;
private _bleeding = ["read",[_UID,"bleeding",0]] call ncb_gv_iniDbiPlayer;
private _lodgedBullets = ["read",[_UID,"lodgedBullets",0]] call ncb_gv_iniDbiPlayer;
private _damage = ["read",[_UID,"damage",0]] call ncb_gv_iniDbiPlayer;
private _hitPoints = ["read",[_UID,"hitPoints",[["HitFace",0],["HitNeck",0],["HitHead",0],["HitPelvis",0],["HitAbdomen",0],["HitDiaphragm",0],["HitChest",0],["HitBody",0],["HitArms",0],["HitHands",0],["HitLegs",0]]]] call ncb_gv_iniDbiPlayer;
private _skillCook = ["read",[_UID,"skillCook",[0,0]]] call ncb_gv_iniDbiPlayer;
private _skillEngineer = ["read",[_UID,"skillEngineer",[0,0]]] call ncb_gv_iniDbiPlayer;
private _skillFuelling = ["read",[_UID,"skillFuelling",[0,0]]] call ncb_gv_iniDbiPlayer;
private _skillLogistics = ["read",[_UID,"skillLogistics",[0,0]]] call ncb_gv_iniDbiPlayer;
private _skillSurgeon = ["read",[_UID,"skillSurgeon",[0,0]]] call ncb_gv_iniDbiPlayer;
private _skillTyreFitter = ["read",[_UID,"skillTyreFitter",[0,0]]] call ncb_gv_iniDbiPlayer;
private _skillMagazineFitter = ["read",[_UID,"skillMagazineFitter",[0,0]]] call ncb_gv_iniDbiPlayer;
private _skillWeaponFitter = ["read",[_UID,"skillWeaponFitter",[0,0]]] call ncb_gv_iniDbiPlayer;
private _distanceData = ["read",[_UID,"distanceData",[true,0,[0,0,0]]]] call ncb_gv_iniDbiPlayer;

_player setVariable ["playerKills",_playerKills];
_player setVariable ["aiKills",_aiKills];

ncb_pv_playerPersistenceInfo = [_position,_direction,_stance,_muzzle,_playerKills,_aiKills,_uniform,_vest,_backpack,_weapons,_assignedItems,_headgear,_goggles,_food,_water,_bleeding,_lodgedBullets,_damage,_hitPoints,_skillCook,_skillEngineer,_skillFuelling,_skillLogistics,_skillSurgeon,_skillTyreFitter,_skillMagazineFitter,_skillWeaponFitter,_distanceData];

(owner _player) publicVariableClient "ncb_pv_playerPersistenceInfo";

// now wipe the entry (player can resave data legally at a tent - if they disconnect before that then they start on the beach as new player with no equipment or skills)

["deleteSection",_UID] call ncb_gv_iniDbiPlayer;

if (ncb_param_weatherSystemSelect == 1) then {
	publicVariable "ncb_gv_currentWeather";
};

{
	private _details = _x getVariable ["tentOwnerDetails",["uid","markerName","personal"]];
	if (_UID == _details select 0
	    and {_details select 2 != "side"}
	) then {
		[_player,_x,_details select 2] call horde_fnc_serverSetTentOwner
	};
} forEach ((allMissionObjects "ncb_obj_tent_dome") + (allMissionObjects "ncb_obj_para_beacon"));



/*_index = ncb_gv_connectedPlayerList pushBackUnique _UID;

if (_index > -1) then {
	// first time connection this session
} else {
	// welcome back
};*/

