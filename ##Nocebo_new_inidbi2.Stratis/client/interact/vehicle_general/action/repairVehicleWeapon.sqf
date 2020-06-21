#include "\nocebo\defines\scriptDefines.hpp"

getVar(uiNamespace,"uiInteractionInfo") params ["_object","_cfgEntry","_cfgObject"];
private _fixingAnim = "Horde_anim_fixVehicleKneel";
closeDialog 0;
"dynamicBlur" ppEffectAdjust [0];
"dynamicBlur" ppEffectCommit 0.75;

if not (_object call horde_fnc_checkInteractionValid) exitWith {};

private _location = getText (_cfgEntry >> "location");
private _hitPointDamage = _object getHitPointDamage _location;

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

private _actionItems = ["repair",sel(_this,1)] call horde_fnc_spawnActionItems;

private _skillName = "skillEngineer";
private _jobTime = 60; // workaround for now...
_jobTime = [_jobTime,_skillName] call horde_fnc_factorSkillTime;
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
	[_object,[_location,0]]call horde_fnc_setHitPointDamageGlobal;
	[_object,[0,0,0.1]] call horde_fnc_setVelocityGlobal;
	private _animArr = getArray (_cfgEntry >> "anim");
	if not empty(_animArr) then {
		_animArr params ["_animType","_animPartsArr"];
		{
			_x params ["_part","_threshold"];
			if same(_animType,"animate") then {
				_phase = _object animationPhase _part;
			} else {
				_phase = _object doorPhase _part;
			};
			if  diff(_phase,0) then {
				if same(_animType,"animate") then {
					_object animate [_part,0];
				} else {
					_object animateDoor [_part,0,false];
				};
			};
			true
		} count _animPartsArr;
	};
	removeBackpack player;
	private _failText = "You added a %1 but broke the %2";
	private _repairText = "You fitted the %1 to the vehicle";
	[_cfgEntry,_skillName,_failText,_repairText] call horde_fnc_updateVehicleSkill;
	setVarPlc(_object,_location,nil);
};
ncb_layer_fixVehProgBar cutText ["","plain"];
setVarPlc(_object,"vehiclePlayerInteracting",nil);
true