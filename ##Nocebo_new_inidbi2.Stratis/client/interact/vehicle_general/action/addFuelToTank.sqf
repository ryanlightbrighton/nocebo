#include "\nocebo\defines\scriptDefines.hpp"

disableSerialization;

params ["_element"];
getVar(uiNamespace,"uiInteractionInfo") params ["_object","_cfgEntry","_cfgObject"];

private _location = getText (_cfgEntry >> "location");
private _fixingAnim = "Horde_anim_fixVehicleKneel";
closeDialog 0;
"dynamicBlur" ppEffectAdjust [0];
"dynamicBlur" ppEffectCommit 0.75;

if not (_object call horde_fnc_checkInteractionValid) exitWith {};

private _objectName = getText (_cfgObject >> "displayname");
private _locationName = getText (_cfgEntry >> "text");
private _currentFuel = fuel _object;
private _capacity = getNumber(_cfgObject >> "fuelCapacity");

if (_currentFuel < 1) then {
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
	private _skillName = "skillFuelling";
	private _jobTime = [getNumber (_cfgAction >> "baseTime"),_skillName] call horde_fnc_factorSkillTime;
	private _timeout = time + _jobTime;
	private _startTime = time;

	private _actionItems = ["fuel","ItemJerryCan"] call horde_fnc_spawnActionItems;

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
	} forEach _actionItems;
	if (isNull _display or {time < _timeOut}) then {
		private _msg = "
			<t size='3.2'color='#FF0000'align='center'shadow='2'>
			Interaction aborted.
			</t>
		";
		_msg call horde_fnc_displayActionRejMessage;
	} else {
		// jerry can holds 20 litres
		private _currentCapacity = _currentFuel * _capacity;
		_currentCapacity = _currentCapacity + 20;
		if (_currentCapacity > _capacity) then {
			_currentCapacity = _capacity;
		};
		private _newFuel = _currentCapacity / _capacity;
		/*player unlinkItem "ItemJerryCan";
		player linkItem "ItemJerryCanEmpty";*/
		player removeItem "ItemJerryCan";
		player addItem "ItemJerryCanEmpty";
		[_object,_newFuel] call horde_fnc_setFuelGlobal;
		_skillName call horde_fnc_updateFuelSkill;
		private _msg = "
			<t size='3.2'color='#FFFFFF'align='center'shadow='2'>
			You added fuel to the tank.
			</t>
		";
		_msg call horde_fnc_displayActionConfMessage;
	};
	ncb_layer_fixVehProgBar cutText ["","plain"];
	setVarPlc(_object,"vehiclePlayerInteracting",nil);
};
true

