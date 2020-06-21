#include "\nocebo\defines\scriptDefines.hpp"

private _object = objNull;
private _intersectPos = [0,0,0];
if (isNull objectParent player
	and {isNil {getVar(missionNamespace,"playerPerformingAction")}}
) then {
	private _intersects = lineIntersectsSurfaces [
		AGLToASL positionCameraToWorld [0,0,0],
		AGLToASL positionCameraToWorld [0,0,10],
		vehicle player,
		objNull,
		true,
		1,
		"FIRE",
		"GEOM"
	];
	if not empty(_intersects) then {
		_intersects select 0 params ["_posASL","","","_parent"];
		_intersectPos = ASLtoAGL _posASL;
		if not (isNull _parent) then {
			_object = _parent;
		} else {
			scopeName "3";
			{
				player reveal [_x,4];
				private _classStr = toLower (typeOf _x) select [0,9];
				call {
					if (_classStr isEqualTo "chemlight") exitWith {
						_object = _x;
						breakTo "3"
					};
					if (_classStr isEqualTo "smokeshel") exitWith {
						_object = _x;
						breakTo "3"
					};
					/*if (_x isKindOf "IRStrobeBase") exitWith {
						_object = _x;
						breakTo "3"
					};*/
				};
				true
			} count nearestObjects [_intersectPos,[],1];
		};
	};
	if (not isNull _object) then {
		private _type = typeOf _object;
		if (_type == "") then {
			// NOTE: MAP OBJECT - NEED TO GET A CLASS
			getModelInfo _object params ["_modelName","_modelPath","_skeleton"];
			private _types = format ["toLower (getText (_x >> 'model')) == '\' + '%1'",_modelPath] configClasses (configFile >> "CfgVehicles");
			if not empty(_types) then { // in case object isn't classed
				_type = configName sel(_types,0);
			} else {
				// no modelInfo so need to find if is a tree or bush
				call {
					if (str _object find ": t_" > -1) exitWith {
						_type = "AllTrees"
					};
					if (str _object find ": b_" > -1) exitWith {
						_type = "AllBushes"
					};
				}
			}
		};
		private _cfgObject = cfgVeh >> _type;
		if (_type isKindOf ["RopeSegment",configfile >> "CfgNonAIVehicles"]) then {
			_cfgObject = configfile >> "CfgNonAIVehicles" >> _type;
			diag(_cfgObject);
		};

		if not (isClass _cfgObject) then {
			_cfgObject = cfgAmmo >> _type;
		};
		call {
			private _cfgInteract = _cfgObject >> "InteractionInfo";
			// OBJECTS
			if (isClass _cfgInteract) exitWith {
					private _data = [_object,_type,_cfgObject,_cfgInteract,_intersectPos];
					setVar(uiNamespace,"uiInteractionInfo",_data);
					createDialog "Horde_interactionMenu_general";
			};
			private _cfgInteract = _cfgObject >> "VehicleInteractionInfo";
			// VEHICLES
			if (isClass _cfgInteract) exitWith {

				if (damage _object < 1) then {
					private _nearestCfgEntry = [];
					for "_i" from 0 to count _cfgInteract - 1 do {
						private _cfgEntry = sel(_cfgInteract,_i);
						private _worldPos = _object modelToWorld (getArray (_cfgEntry >> "modelposition"));
						if not empty(_nearestCfgEntry) then {
							if (_worldPos distance _intersectPos < sel(_nearestCfgEntry,1) distance _intersectPos) then {
								_nearestCfgEntry = [_cfgEntry,_worldPos];
							};
						} else {
							_nearestCfgEntry = [_cfgEntry,_worldPos];
						};
					};

					if not empty(_nearestCfgEntry) then {
						private _cfgEntry = sel(_nearestCfgEntry,0);
						private _worldPos = sel(_nearestCfgEntry,1);
						if (_worldPos distance (ASLtoAGL eyePos player) < 2) then {
							private _data = [_object,_cfgEntry,_cfgObject];
							setVar(uiNamespace,"uiInteractionInfo",_data);
							if (configName _cfgEntry == "AddWeapon") then {
								createDialog "Horde_interactionMenu_refit";
							} else  {
								createDialog "Horde_interactionMenu_vehicleParts";
							};
						} else {
							[_worldPos,_object,_cfgEntry] call horde_fnc_spawnInteractionHelper;
						};
					};
				} else {
					private _text = "
						<t size='3.2'color='#FF0000'align='center'shadow='2'>
						You can't interact with destroyed objects.
						</t>
					";
					_text call horde_fnc_displayActionRejMessage;
				};
			};
			private _text = "
				<t size='3.2'color='#FF0000'align='center'shadow='2'>
				You can't interact with this object.
				</t>
			";
			_text call horde_fnc_displayActionRejMessage;
		};
	} else {
		private _text = "
			<t size='3.2'color='#FF0000'align='center'shadow='2'>
			No object detected.
			</t>
		";
		_text call horde_fnc_displayActionRejMessage;
	};
};
true