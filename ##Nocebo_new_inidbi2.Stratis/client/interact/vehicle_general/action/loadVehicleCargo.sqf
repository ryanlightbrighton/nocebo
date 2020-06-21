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
	if (not alive _cargo) exitWith {
		_text = "You can't load destroyed cargo.";
		_failAction = true;
	};
	if (isPlayer (_object getVariable ["vehiclePlayerInteracting",objNull])) exitWith {
		_text = "Only one person can work on a vehicle at a time.";
		_failAction = true;
	};
	if (vectorMagnitude velocity _object > 0.1) exitWith {
		_text = "You can't load cargo while the vehicle is moving.";
		_failAction = true;
	};
	{
		if (not isNull _x
			and {alive _x}
			and {not (_x isEqualTo _object)}
			and {isNull attachedTo _x}
			and {[getPosATL _object,((getDir _object) + 180) mod 360,30,getPosATL _x] call BIS_fnc_inAngleSector}
		) exitWith {
			_cargo = _x;
		};
	} count (_object nearEntities [
		[
			"ncb_boat_inflatable",
			"ncb_veh_quadbike",
			"ncb_obj_ammobox_m",
			"ncb_obj_ammobox_l",
			"ncb_obj_fuel_supply_m",
			"ncb_obj_repair_parts_box_m"
		],
		7
	]);
	if (isNull _cargo) exitWith {
		_text = "There is no suitable cargo behind the vehicle.";
		_failAction = true;
	};
	// is there space?

	// count cargo
	private _attachedCargo = [];
	private _configuration = "";
	{
		_var = _x getVariable ["crateCfgSlotData",[]];
		if not empty(_var) then {
			_attachedCargo pushBack _x;
			// also define the configuration
			if ("" == _configuration) then {
				_configuration = _var select 0;
			};
		};
	} forEach attachedObjects _object;

	scopeName "1";
	private _attachData = [];
	private _someFreeSpace = false;
	if not empty(_attachedCargo) then {
		// check where cargo is assigned and look for empty slot

		private _cfgConfig = configFile >> "CfgVehicles" >> typeOf _object >> "Logistics" >> _configuration;
		private _numbSlots = count _cfgConfig;
		for "_slotIndex" from 0 to _numbSlots - 1 do {
			private _cfgSlot = _cfgConfig select _slotIndex;
			private _freeIndex = true;
			{
				if (configName _cfgConfig == (_x getVariable "crateCfgSlotData") select 0
					and {configName _cfgSlot == (_x getVariable "crateCfgSlotData") select 1}
					and {_slotIndex == (_x getVariable "crateCfgSlotData") select 2}
				) exitWith {
					_freeIndex = false;
				};
			} forEach _attachedCargo;
			if (_freeIndex) then {
				// check this class can fit
				{
					if (typeOf _cargo == _x select 0) then {
						_attachData = [
							_x,
							configName _cfgConfig,
							configName _cfgSlot,
							_slotIndex
						];
						_lockSlots = getArray (_cfgSlot >> "cargoLockIndices");
						_someFreeSpace = true;
						breakTo "1"
					};
				} forEach getArray (_cfgSlot >> "choices");
			};
		};
	} else {
		_someFreeSpace = true;
		// no cargo so cycle through configs (default)
		scopeName "2";
		private _cfgLog = configFile >> "CfgVehicles" >> typeOf _object >> "logistics";
		for "_configNumber" from 0 to count _cfgLog - 1 do {
			private _cfgConfiguration = _cfgLog select _configNumber;
			for "_slotIndex" from 0 to count _cfgConfiguration - 1 do {
				private _cfgSlot = _cfgConfiguration select _slotIndex;
				private _choices  = getArray (_cfgSlot >> "choices");
				{
					if (sel(_x,0) == typeOf _cargo) then {
						_attachData = [
							_x,
							configName _cfgConfiguration,
							configName _cfgSlot,
							_slotIndex
						];
						_lockSlots = getArray (_cfgSlot >> "cargoLockIndices");
						breakTo "2"
					};
				} forEach _choices;
			};
		};
	};

	if not (_someFreeSpace) exitWith {
		_failText = "There is no free cargo space in the vehicle.";
		_failAction = true;
	};
	if (not empty(_attachedCargo)
		and {not _someFreeSpace}
	) exitWith {
		_failText = "You may need to repack the vehicle to fit this cargo.";
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
	{
		private _slot = _x;
		{
			if (_object getCargoIndex _x == _slot) exitWith {
				_x action ["eject", _object]
			};
		} forEach assignedCargo _object;
		[_object,[_slot,true]] call horde_fnc_lockCargoGlobal
	} forEach _lockSlots;
	player playActionNow "PutDown";
	[player,_object,_cargo] remoteExecCall [
		"horde_fnc_serverLoadCargo",
		2
	];
};