#include "\nocebo\defines\scriptDefines.hpp"

params ["_caller","_object","_cargo"];

[
	[_caller,_object,_cargo],{
		call horde_fnc_getEachFrameArgs params ["_caller","_object","_cargo"];
		if (not isNull _caller
			and {alive _caller}
			and {not isNull _cargo}
			and {alive _cargo}
			and {not isNull _object}
			and {alive _object}
			and {isNull attachedTo _cargo}
			and {vectorMagnitude velocity _object <= 0.1}
			and {[getPosATL _object,((getDir _object) + 180) mod 360,30,getPosATL _cargo] call BIS_fnc_inAngleSector}
		) then {
			// is there space?
			// count cargo
			private _attachedCargo = [];
			private _configuration = "";
			{
				private _var = _x getVariable ["crateCfgSlotData",[]];
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

			if (not empty(_attachData)) then {
				_cargo setVariable [
					"crateCfgSlotData",
					[
						sel(_attachData,1),
						sel(_attachData,2),
						sel(_attachData,3)
					],
					true
				];

				[
					[_caller,_object,_cargo,_attachData,1],
					{
						call horde_fnc_getEachFrameArgs params ["_caller","_object","_cargo","_attachData","_loops"];
						_attachPos = _attachData select 0 select 1;
						_vDirAndUp = _attachData select 0 select 2;
						if (_loops < 9) then {
							_loops = _loops + 1;
							_modelPos = _object worldToModel (ASLtoATL getPosWorld _cargo);
							_diff = _attachPos vectorDiff _modelPos;
							_newDiff = _diff vectorMultiply 0.2;
							_newModPos = _modelPos vectorAdd _newDiff;
							_cargo attachTo [_object,_newModPos];
							[_caller,_object,_cargo,_attachData,_loops] call horde_fnc_updateEachFrameArgs;
						} else {
							_cargo attachTo [_object,_attachPos];
							[_cargo,_vDirAndUp] call horde_fnc_setVectorDirAndUpGlobal;
							_text = format [
								"<t size='3.2'color='#FFFFFF'align='center'shadow='2'>You loaded the %1<br />in the %2.</t>",
								getText (configFile >> "CfgVehicles" >> typeOf _cargo >> "displayname"),
								getText (configFile >> "CfgVehicles" >> typeOf _object >> "displayname")
							];
							_text remoteExecCall [
								"horde_fnc_displayActionConfMessage",
								_caller
							];
							setVarPlc(_object,"vehiclePlayerInteracting",nil);
							call horde_fnc_removeEachFrame
						};
					},
					0.2
				] call horde_fnc_updateEachFrame
			} else {
				private _text = "<t size='3.2'color='#FF0000'align='center'shadow='2'>There is no space left in this vehicle<br />for this configuration.<br />(Try loading vehicles first).</t>";
				_text remoteExecCall [
					"horde_fnc_displayActionRejMessage",
					_caller
				];
				setVarPlc(_object,"vehiclePlayerInteracting",nil);
				call horde_fnc_removeEachFrame
			}
		} else {
			setVarPlc(_object,"vehiclePlayerInteracting",nil);
			call horde_fnc_removeEachFrame
		}
	},
	0.5
] call horde_fnc_addEachFrame;

true