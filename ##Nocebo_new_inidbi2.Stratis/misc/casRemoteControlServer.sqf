#include "\nocebo\defines\scriptDefines.hpp"

params ["_height","_radius","_followTerrain","_targetPos","_spawnPos","_class","_player"];

// ac130

_veh = createVehicle [_class,_spawnPos,[],0,"fly"];
_veh setDir (_veh getDir _targetPos);
_veh setPos _spawnPos;
_veh call horde_fnc_addExtraVehicleMags;
_veh addEventHandler ["reloaded", {
	_this call horde_fnc_autoReloadVehWeap
}];
_veh addEventHandler ["getout", {
	_this select 2 setDamage 1;
	_this select 0 setDamage 1
}];
_veh lockTurret [[-1],true];
_veh lockTurret [[0],true];

// pilot

_grp = createGroup [west,true];
_pilot = _grp createUnit ["B_helicrew_F",_spawnPos,[],0,"none"];
_pilot assignAsDriver _veh;
_pilot moveInDriver _veh;
_pilot disableAI "fsm";
_pilot disableAI "cover";
_pilot disableAI "aimingerror";
_pilot disableAI "suppression";
_pilot setSkill 1;
_pilot setSkill ["aimingAccuracy",1];
_pilot setSkill ["aimingShake",1];
_pilot setSkill ["aimingSpeed",1];
_pilot setSkill ["commanding",1];
_pilot setSkill ["courage",1];
_pilot setSkill ["endurance",1];
_pilot setSkill ["reloadSpeed",1];
_pilot setSkill ["spotDistance",1];
_pilot setSkill ["spotTime",1];

// gunners

_grp2 = createGroup [west,true];
{
	_unit = _grp2 createUnit ["B_helicrew_F",_spawnPos,[],0,"none"];
	_unit setSkill 1;
	_unit setSkill ["aimingAccuracy",1];
	_unit setSkill ["aimingShake",1];
	_unit setSkill ["aimingSpeed",1];
	_unit setSkill ["commanding",1];
	_unit setSkill ["courage",1];
	_unit setSkill ["endurance",1];
	_unit setSkill ["reloadSpeed",1];
	_unit setSkill ["spotDistance",1];
	_unit setSkill ["spotTime",1];
	_unit assignAsTurret [_veh,_x];
	_unit moveInTurret [_veh,_x];
	_unit linkItem "NVGogglesB_blk_F";
} count (allTurrets [_veh,true]);
_grp2 setBehaviour "combat";
_grp2 setCombatMode "red";


if (_followTerrain) then {
	private _terrainHeightASL = getTerrainHeightASL _targetPos;
	_veh flyInHeightASL [_terrainHeightASL + _height,_terrainHeightASL + _height,_terrainHeightASL + _height]
} else {
	_veh flyInHeight _height
};

// move

private _ingressPos = _spawnPos getPos [(_spawnPos distance2D _targetPos) - _radius,_spawnPos getDir _targetPos];
_ingressPos set [2,_height];

_wp = _grp addWaypoint [_ingressPos, 0];
_wp setWaypointBehaviour "careless";
_wp setWaypointCombatMode "yellow";
_wp setWaypointCompletionRadius 30;
_wp setWaypointFormation "wedge";
_wp setWaypointSpeed "normal";
_wp setWaypointTimeout [0,0,0];
_wp setWaypointType "move";

// loiter

_wp = _grp addWaypoint [_targetPos, 0];
_wp setWaypointBehaviour "careless";
_wp setWaypointCombatMode "yellow";
_wp setWaypointCompletionRadius 30;
_wp setWaypointFormation "wedge";
_wp setWaypointSpeed "limited";
_wp setWaypointTimeout [0,0,0];
_wp setWaypointType "loiter";
_wp setWaypointLoiterType "circle_l";
_wp setWaypointLoiterRadius _radius;

/*ncb_pv_casInProgress = true;
publicVariable "ncb_pv_casInProgress";*/
[
	[_grp,_spawnPos],{
		call horde_fnc_getEachFrameArgs params ["_grp","_spawnPos"];
		if (not isNull _grp) then {
			private _wp = _grp addWaypoint [_spawnPos,0];
			_wp setWaypointBehaviour "careless";
			_wp setWaypointSpeed "full";
			_wp setWaypointType "move";
			_statement = "
				if (isServer) then {
					_veh = vehicle this;
					{
						deleteVehicle _x
					} count crew _veh;
					deleteVehicle _veh;
				};
			";
			_wp setWaypointStatements ["true",_statement];
			_grp setCurrentWaypoint _wp
		};
		/*ncb_pv_casInProgress = nil;
		publicVariable "ncb_pv_casInProgress";*/
		call horde_fnc_removeEachFrame
	},
	500 + (random 240)
] call horde_fnc_addEachFrame;

call {
	if (_class == "ncb_vtol_blackfish_gunship") exitWith {
		[_veh,_grp] remoteExec [
			"horde_fnc_casRemoteControlClient",
			_player
		];
	};
	if (_class == "ncb_heli_ghostHawk") exitWith {
		[_veh,_grp] remoteExec [
			"horde_fnc_casRemoteControlClient",
			_player
		];
	};
};