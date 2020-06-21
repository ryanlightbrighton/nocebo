#include "\nocebo\defines\scriptDefines.hpp"

disableSerialization;

params ["_element"];
private _cargo = getVar(uiNamespace,"uiCargoObject");
getVar(uiNamespace,"uiInteractionInfo") params ["_object","_cfgEntry","_cfgObject"];
private _location = getText (_cfgEntry >> "location");
closeDialog 0;
"dynamicBlur" ppEffectAdjust [0];
"dynamicBlur" ppEffectCommit 0.75;

private _failAction = false;
private _text = "";
private _lockSlots = [];
call {
	if (isNull player) exitWith {
		_text = "You are null!";
		_failAction = true;
	};
	if (not alive player) exitWith {
		_text = "You are dead.";
		_failAction = true;
	};
	if (isNull _object) exitWith {
		_text = "Vehicle is null!";
		_failAction = true;
	};
	if (not alive _object) exitWith {
		_text = "You can't interact with destroyed vehicles.";
		_failAction = true;
	};
	if (isNull _cargo) exitWith {
		_text = "Cargo is null!";
		_failAction = true;
	};
	if (isPlayer (_object getVariable ["vehiclePlayerInteracting",objNull])) exitWith {
		_text = "Only one person can work on a vehicle at a time.";
		_failAction = true;
	};
	if (vectorMagnitude velocity _object > 0.1) exitWith {
		_text = "You can't unload cargo while the vehicle is moving.";
		_failAction = true;
	};
	private _index = -1;
	{
		private _var = _x getVariable ["crateCfgSlotData",[]];
		if not empty(_var) then {
			private _cargoIndex = sel(_var,2);
			if (_cargoIndex > _index) then {
				_index = _cargoIndex;
				_cargo = _x;
				/*if (_cargoIndex == 0) then {*/
					_lockSlots = getArray (configFile >> "CfgVehicles" >> typeOf _object >> "Logistics" >> sel(_var,0) >> sel(_var,1) >> "cargoLockIndices");
				/*};*/
			};
		};
	} forEach attachedObjects _object;
	if (isNull _cargo) exitWith {
		_text = "There is no cargo to unload.";
		_failAction = true;
	};
};

if (_failAction) then {
	private _msg = format [
		"<t size='3.2'color='#FF0000'align='center'shadow='2'>%1</t>",
		_text
	];
	_msg call horde_fnc_displayActionRejMessage;
} else {
	setVarPlc(_object,"vehiclePlayerInteracting",player);
	// unlock veh cargo
	{
		[_object,[_x,false]] call horde_fnc_lockCargoGlobal
	} forEach _lockSlots;
	player playActionNow "PutDown";
	[player,_object,_cargo] remoteExecCall [
		"horde_fnc_serverUnloadCargo",
		2
	];
};
