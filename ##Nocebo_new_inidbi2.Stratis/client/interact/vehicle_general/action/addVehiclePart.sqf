#include "\nocebo\defines\scriptDefines.hpp"

disableSerialization;

params ["_element","_item"];
getVar(uiNamespace,"uiInteractionInfo") params ["_object","_cfgEntry","_cfgObject"];

private _location = getArray (_cfgEntry >> "location");
private _modelPos = getArray (_cfgEntry >> "modelposition");
private _fixingAnim = "Horde_anim_fixVehicleKneel";
closeDialog 0;
"dynamicBlur" ppEffectAdjust [0];
"dynamicBlur" ppEffectCommit 0.75;

if not (_object call horde_fnc_checkInteractionValid) exitWith {};

private _hitPointDamage = 0;
{
	private _dam = _object getHitPointDamage _x;
	if (not isNil "_dam" and {_dam > _hitPointDamage}) then {
		_hitPointDamage = _dam
	}
} forEach _location;

if (_hitPointDamage > 0) then {
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

	private _cfgActions = _cfgEntry >> "actions";
	private _cfgAction = sel(_cfgActions,_element);
	private _skillName = "skillEngineer";
	private _jobTime = [getNumber (_cfgAction >> "baseTime"),_skillName] call horde_fnc_factorSkillTime;
	private _timeout = time;
	private _startTime = time;

	private _actionItems = ["repair",_item] call horde_fnc_spawnActionItems;

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
	private _generators = nearestObjects [_object, ["ncb_obj_portable_generator"], 6];
	if (same(_skillName,"skillEngineer")
		and count _generators > 0
	) then {
		private _generator = sel(_generators,0);
		_jobTime = _jobTime * 0.5;
		_timeout = _timeout + _jobTime;
		_timeout = time + _jobTime;
		waitUntil {
			if diff(getDir player,_playerDir) then {
				player setDir _playerDir
			};
			if (same(_skillName,"skillEngineer")
				and {random 1 > 0.993}
			) then {
				private _pos = _object modelToWorld _modelPos;
				_pos = _pos vectorAdd [(random 4) - 2,(random 4) - 2,0];
				_pos set [2,0];
				private _slick = createVehicle ["ncb_obj_oil_spill",_pos,[],0,"can_collide"];
				_slick setVectorUp surfaceNormal _pos;
				_slick setDir random 360;
			};
			private _cent = (time - _startTime) / _jobTime;
			_readout progressSetPosition _cent;
			isNull _display
			or {not isNull findDisplay 602}
			or {not isNull findDisplay 6666}
			or {time >= _timeout}
			or {not alive player}
			or {diff(animationState player,_animName)}
			or {not alive _object}
			or {isEngineOn _object}
			or {diff({alive _x} count crew _object,0)}
			or {isNull _generator}
			or {not sel(getVar(_generator,"generatorIsRunning"),0)}
		};
	} else {
		_timeout = _timeout + _jobTime;
		waitUntil {
			if diff(getDir player,_playerDir) then {
				player setDir _playerDir
			};
			if (same(_skillName,"skillEngineer")
				and {random 1 > 0.993}
			) then {
				private _pos = _object modelToWorld _modelPos;
				_pos = _pos vectorAdd [(random 4) - 2,(random 4) - 2,0];
				_pos set [2,0];
				private _slick = createVehicle ["ncb_obj_oil_spill",_pos,[],0,"can_collide"];
				_slick setVectorUp surfaceNormal _pos;
				_slick setDir random 360;
			};
			private _cent = (time - _startTime) / _jobTime;
			_readout progressSetPosition _cent;
			isNull _display
			or {not isNull (findDisplay 602)}
			or {not isNull (findDisplay 6666)}
			or {time >= _timeout}
			or {not alive player}
			or {not alive player}
			or {diff(animationState player,_animName)}
			or {not alive _object}
			or {isEngineOn _object}
			or {diff({alive _x} count crew _object,0)}
		};
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
		private _addHealth = getNumber (configfile >> "CfgVehicles" >> (backpack player) >> "horde_health");
		_currHealth = [typeOf _object,configName _cfgEntry,_hitPointDamage] call horde_fnc_realDamToRepairHealth;
		private _newHealth = _currHealth + _addHealth min 100;
		private _damage = [typeOf _object,configName _cfgEntry,_newHealth] call horde_fnc_repairHealthToRealDam;
		{
			[_object,[_x,_damage]] call horde_fnc_setHitPointDamageGlobal;
		} count _location;
		[_object,[0,0,0.1]] call horde_fnc_setVelocityGlobal;
		private _animArr = getArray (_cfgEntry >> "anim");
		if not empty(_animArr) then {
			_animArr params ["_animType","_animPartsArr"];
			{
				_x params ["_part","_threshold"];
				private _phase = 0;
				if same(_animType,"animate") then {
					_phase = _object animationPhase _part;
				} else {
					_phase = _object doorPhase _part;
				};
				if (diff(_phase,0) and {_damage < _threshold}) then {
					if same(_animType,"animate") then {
						_object animate [_part,0];
					} else {
						_object animateDoor [_part,0,false];
					};
				};
				true
			} count _animPartsArr;
		};
		if ("HitEngine" in _location) then {
			[_object,"HitEngine"] call horde_fnc_selectEngineSmoke;
		};
		if diff(backpack player,"") then {
			removeBackpack player;
		};
		_object setVariable ["ncb_" + configName _cfgEntry,nil,true];
		private _failText = "You added parts to the %1 but broke the %2";
		private _repairText = "You added parts to the %1";
		[_cfgEntry,_skillName,_failText,_repairText] call horde_fnc_updateVehicleSkill;
	};

	ncb_layer_fixVehProgBar cutText ["","plain"];
	setVarPlc(_object,"vehiclePlayerInteracting",nil);
};

true