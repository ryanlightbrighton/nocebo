#include "\nocebo\defines\scriptDefines.hpp"

params ["_caller","_object","_cargo"];

[
	[_caller,_object,_cargo],{
		call horde_fnc_getEachFrameArgs params ["_caller","_object","_cargo"];
		if (not isNull _caller
			and {alive _caller}
			and {not isNull _cargo}
			and {not isNull _object}
			and {alive _object}
			and {_object isEqualTo (attachedTo _cargo)}
			and {vectorMagnitude velocity _object <= 0.1}
		) then {
			[
				[_caller,_object,_cargo,1],{
					call horde_fnc_getEachFrameArgs params ["_caller","_object","_cargo","_loops"];
					private _worldPos = _object modelToWorld [0,-7,0];
					_worldPos set [2,((ASLtoATL getPosWorld _cargo) select 2) - ((getPos _cargo) select 2)];
					private _moveToPos = _object worldToModel _worldPos;
					if (_loops < 9) then {
						_loops = _loops + 1;
						private _modelPos = _object worldToModel (ASLtoATL getPosWorld _cargo);
						private _diff = _moveToPos vectorDiff _modelPos;
						private _newDiff = _diff vectorMultiply 0.2;
						private _newModPos = _modelPos vectorAdd _newDiff;
						_cargo attachTo [_object,_newModPos];
						[_caller,_object,_cargo,_loops] call horde_fnc_updateEachFrameArgs
					} else {
						detach _cargo;
						_cargo setVariable ["crateCfgSlotData",nil,true];
						[_cargo,[vectorDir _cargo,[0,0,1]]] call horde_fnc_setVectorDirAndUpGlobal;

						private _text = format [
							"<t size='3.2'color='#FFFFFF'align='center'shadow='2'>You unloaded the %1<br />from the %2.</t>",
							getText (configFile >> "CfgVehicles" >> typeOf _cargo >> "displayname"),
							getText (configFile >> "CfgVehicles" >> typeOf _object >> "displayname")
						];
						_text remoteExecCall [
							"horde_fnc_displayActionConfMessage",
							_caller
						];
						setVarPlc(_object,"vehiclePlayerInteracting",nil);
						call horde_fnc_removeEachFrame
					}
				},
				0.2
			] call horde_fnc_updateEachFrame
		} else {
			setVarPlc(_object,"vehiclePlayerInteracting",nil);
			call horde_fnc_removeEachFrame
		}
	},
	0.5
] call horde_fnc_addEachFrame;

true