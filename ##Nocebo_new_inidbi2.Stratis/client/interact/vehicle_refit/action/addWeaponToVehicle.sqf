#include "\nocebo\defines\scriptDefines.hpp"

disableSerialization;

getVar(uiNamespace,"uiInteractionInfo") params ["_object","_cfgEntry","_cfgObject"];

params ["","","_classNewVehicle","",""];

private _fixingAnim = "Horde_anim_fixVehicleKneel";
closeDialog 0;
"dynamicBlur" ppEffectAdjust [0];
"dynamicBlur" ppEffectCommit 0.75;

if not (_object call horde_fnc_checkInteractionValid) exitWith {};

// ADD IN JOB TIME HERE
setVarPlc(_object,"vehiclePlayerInteracting",player);
ncb_gv_interactionResetWeapon = "AmovPknlMstpSrasWnonDnon";
call {
	if same(currentWeapon player,primaryWeapon player) exitWith {
		ncb_gv_interactionResetWeapon = "AmovPknlMstpSrasWrflDnon";
	};
	if same(currentWeapon player,handgunWeapon player) exitWith {
		ncb_gv_interactionResetWeapon = "AmovPknlMstpSrasWpstDnon";
	};
	if same(currentWeapon player,secondaryWeapon player) exitWith {
		ncb_gv_interactionResetWeapon = "AmovPknlMstpSrasWlnrDnon";
	};
};
ncb_layer_fixVehProgBar cutRsc ["FixVehProgressBar","plain"];
waitUntil {
	not isNil {getVar(uiNamespace,"ncb_ui_fixVehProgressBar")}
};
private _id1 = (findDisplay 46) displayAddEventHandler ["KeyDown",{
	_this call horde_fnc_abortInteraction
}];
inGameUISetEventHandler ["Action","true"];
inGameUISetEventHandler ["PrevAction","true"];
inGameUISetEventHandler ["NextAction","true"];

player playMoveNow _fixingAnim;
private _display = getVar(uiNamespace,"ncb_ui_fixVehProgressBar");
private _readout = _display displayCtrl 2;
private _id0 = addEH(player,"AnimDone",horde_fnc_animLoopVehicleRepair);
private _actionItems = ["repair",sel(getVar(_object,"AddWeapon"),1)] call horde_fnc_spawnActionItems;
private _skillName = "skillEngineer";
private _jobTime = [30,_skillName] call horde_fnc_factorSkillTime;
private _timeout = time + _jobTime;
private _startTime = time;

playSound3D [
	"A3\Missions_F_EPA\data\sounds\Acts_carFixingWheel.wss",
	player,
	false,
	getPosASL player,
	1,
	1,
	200
];
sleep 0.5;
private _animName = animationState player;
private _playerDir = getDir player;

waitUntil {
	if diff(getDir player,_playerDir) then {
		player setDir _playerDir
	};
	private _cent = (time - _startTime) / _jobTime;
	_readout progressSetPosition _cent;
	isNull _display
	or {not isNull (findDisplay 602)}
	or {not isNull (findDisplay 6666)}
	or {time >= _timeout}
	or {not alive player}
	or {diff(animationState player,_animName)}
	or {not alive _object}
	or {isEngineOn _object}
	or {diff({alive _x} count crew _object,0)}
};

player playMoveNow ncb_gv_interactionResetWeapon;
player removeEventHandler ["AnimDone",_id0];
(findDisplay 46) displayRemoveEventHandler ["KeyDown",_id1];
inGameUISetEventHandler ["Action",""];
inGameUISetEventHandler ["PrevAction",""];
inGameUISetEventHandler ["NextAction",""];
{
	deleteVehicle _x
} count _actionItems;
if (isNull _display or {time < _timeOut}) then {
	private _msg = "
		<t size='3.2'color='#FF0000'align='center'shadow='2'>
		Interaction aborted.
		</t>
	";
	_msg call horde_fnc_displayActionRejMessage;
} else {
	// END JOB TIME
	private _pos = getPosATL _object;
	private _dir = getDir _object;
	private _norm = surfaceNormal _pos;

	// get anims

	private _animsArr = [];
	{
		_animsArr pushBack [_x,_object animationPhase _x];
	} forEach ["HidePolice","HideServices","HideBumper1","HideBumper2","HideConstruction","HideDoor1","HideDoor2","HideDoor3"];

	private _textures = getObjectTextures _object;
	if (isNil "_textures") then {
		_textures = [];
	};

	// also need to get damage for all hitpoints

	private _damageArr = [];
	private _type = typeOf _object;

	getAllHitPointsDamage _object params ["_hps","","_vals"];
	{
		_damageArr pushBack [_x,_vals select _forEachIndex]
	} forEach _hps;

	// now get fuel

	private _fuel = fuel _object;

	// cargo

	private _cargo = [_object,true] call horde_fnc_totalContents;

	// NOW REMOVE BACKPACKS

	{
		_x params ["_bagClass","_carrier"];
		if (_carrier isEqualTo player) then {
			removeBackpackGlobal player;
		} else {
			{
				if (sel(_x,0) isEqualTo _bagClass) exitWith {
					sel(_cargo,0) deleteAt _forEachIndex;
				};
			} forEach sel(_cargo,0);
		};
	} forEach (uiNamespace getVariable ["ncb_uv_addWeaponBagData",[]]);

	// veh name

	_vehName = getText (configFile >> "CfgVehicles" >> _type >> "displayname");

	deleteVehicle _object;

	private _spawnPos = [0,0,5000];
	private _object = spawnVeh(_classNewVehicle,_spawnPos);

	if not empty(_textures) then {
		[_object,_textures] remoteExecCall [
			"horde_fnc_serverSetTexture",
			2
		];
	};
	{
		_x params ["_anim","_phase"];
		_object animate [_anim,_phase];
	} count _animsArr;

	// do backpacks separately ,"HideBackpacks" 0 = bp's shown on model

	if empty(everyBackpack _object) then {
		_object animate ["HideBackpacks",1]
	} else {
		_object animate ["HideBackpacks",0]
	};
	{
		[_object,[sel(_x,0),sel(_x,1)]] call horde_fnc_setHitPointDamageGlobal;
	} forEach _damageArr;

	[_object,_fuel] call horde_fnc_setFuelGlobal;

	[_object,_cargo,true] call horde_fnc_fillCargo;

	[_object,"GetIn","horde_fnc_getInVehicle"] call horde_fnc_addServerEventHandler;
	[_object,"GetOut","horde_fnc_getOutVehicle"] call horde_fnc_addServerEventHandler;

	_object setPosATL _pos;
	_object setVectorUp _norm;
	_object setDir _dir;

	// ammo
	[_object,0] call horde_fnc_setVehicleAmmoGlobal;

	private _failText = format ["You added a weapon to the %1 but broke the %2",_vehName];
	private _repairText = format ["You fitted the weapon to the %1",_vehName];
	[_cfgEntry,_skillName,_failText,_repairText] call horde_fnc_updateVehicleSkill;
};
ncb_layer_fixVehProgBar cutText ["","plain"];
setVarPlc(_object,"vehiclePlayerInteracting",nil);

true