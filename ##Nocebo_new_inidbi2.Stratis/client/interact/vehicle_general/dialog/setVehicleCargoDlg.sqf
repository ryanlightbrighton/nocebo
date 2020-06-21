#include "\nocebo\defines\scriptDefines.hpp"

uiNamespace getVariable "uiInteractionInfo" params ["_object","_cfgEntry","_cfgObject"];
params ["_actionIndex","_ctrl"];

private _display = uiNamespace getVariable "Horde_InteractionMenu";

private _cfgActions = _cfgEntry >> "actions";
private _cfgAction = sel(_cfgActions,_actionIndex);
private _button = _display displayCtrl _ctrl;
// blank the destroyed overlay
private _overlay = _display displayCtrl 1204;
_overlay ctrlSetText "";

private _tooltip = "TOOLTIP";
_button ctrlSetTooltip _tooltip;
_button ctrlSetTooltipColorBox [1,1,1,0.8];
_button ctrlSetTooltipColorShade [0,0,0,1];

// check for fails
private _failText = "";
private _failAction = false;
private _cargo = objNull;
call {
	if (isNull _object) exitWith {
		_failText = "Vehicle is null!";
		_failAction = true;
	};
	if (not alive _object) exitWith {
		_failText = "You can't interact with destroyed vehicles.";
		_failAction = true;
	};
	if (isPlayer (_object getVariable ["vehiclePlayerInteracting",objNull])) exitWith {
		_text = "Only one person can work on a vehicle at a time.";
		_failAction = true;
	};
	if (vectorMagnitude velocity _object > 1) exitWith {
		_failText = "You can't handle cargo while the vehicle is moving.";
		_failAction = true;
	};
};

if (configName _cfgAction == "loadVehicle") then {
	// fail loading conds
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
		_failText = "There is no suitable cargo behind the vehicle.";
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
} else {
	// fail unloading conds
	private _index = -1;
	{
		_var = _x getVariable ["crateCfgSlotData",[]];
		if not empty(_var) then {
			private _cargoIndex = sel(_var,2);
			if (_cargoIndex > _index) then {
				_index = _cargoIndex;
				_cargo = _x
			};
		};
	} forEach attachedObjects _object;
	if (isNull _cargo) exitWith {
		_failText = "There is no cargo to unload.";
		_failAction = true;
	};
};

if (_failAction) then {
	_button ctrlSetEventHandler [
		"ButtonClick",
		format [
			"_thisEventHandler = %1 call horde_fnc_setTooltip;",
			[_ctrl,_failText,[1, 0, 0, 0.8]]
		]
	];
} else {
	setVar(uiNamespace,"uiCargoObject",_cargo);
	private _script = getText (_cfgAction >> "script");
	_button ctrlSetEventHandler [
		"ButtonClick",
		format [
			"_handle = %1 %2;",
			[_actionIndex],
			_script
		]
	];
};

private _cargoName = getText (configFile >> "CfgVehicles" >> typeOf _cargo >> "displayname");
private _mssg = "";
if (configName _cfgAction == "loadVehicle") then {
	_mssg = "load";
} else {
	_mssg = "unload";
};

/*
	WINDOWS KEY FOR DIALOG:

	HEADER  #1 = 1004	|	HEADER  #2 = 1006
	PICTURE #1 = 1200	|	PICTURE #2 = 1201
	FOOTER  #1 = 1005	|	FOOTER  #2 = 1007
						|
	--------------------|--------------------
						|
	HEADER  #3 = 1008	|	HEADER  #4 = 1010
	PICTURE #3 = 1202	|	PICTURE #4 = 1203
	FOOTER  #3 = 1009	|	FOOTER  #4 = 1011
*/

// panel #1
(_display displayCtrl 1004) ctrlSetText "Header_1";
(_display displayCtrl 1200) ctrlSetText "";
(_display displayCtrl 1005) ctrlSetText "";
// panel #2
(_display displayCtrl 1006) ctrlSetText _mssg;
(_display displayCtrl 1201) ctrlSetText "";
(_display displayCtrl 1007) ctrlSetText _cargoName;
// panel #3
(_display displayCtrl 1008) ctrlSetText "Header 3";
(_display displayCtrl 1202) ctrlSetText "";
(_display displayCtrl 1009) ctrlSetText "";
// panel #4
(_display displayCtrl 1010) ctrlSetText "Header 4";
(_display displayCtrl 1203) ctrlSetText "";
(_display displayCtrl 1011) ctrlSetText "";

(_display displayCtrl 1013) ctrlSetText ""; 		// FUEL DISPLAY BUTTON (panel #1)
(_display displayCtrl 1204) ctrlSetText "";			// DESTROYED ICON (panel #1)

ctrlSetFocus _button;
true