#include "\nocebo\defines\scriptDefines.hpp"


private _chargeData = missionNamespace getVariable [
	"horde_gvar_currentChargeType",
	["StickyCharge_Remote_Mag","DemoCharge_Remote_Ammo_Scripted"]
];

if empty(_chargeData) exitWith {
	private _text = "
		<t size='3.2'color='#FF0000'align='center'shadow='2'>
		Select a sticky item from your inventory.
		</t>
	";
	_text call horde_fnc_displayActionRejMessage;
};

private _mags = magazines player;
private _foundMag = false;
private _magType = sel(_chargeData,0);
private _ammoType = sel(_chargeData,1);
if (_magType in _mags) then {
	_foundMag = true;
} else {
	_ammoType = getText(cfgMag >> _magType >> "ammo");
	if (_ammoType isKindOf "SmokeShell") then {
		horde_gvar_currentChargeType = [_magType,getText(cfgMag >> _magType >> "ammo")];
	} else {
		{
			if (_mags find _x > -1) exitWith {
				_magType = _x;
				call {
					if (_magType == "StickyCharge_Remote_Mag") exitWith {
						horde_gvar_currentChargeType = [_magType,"DemoCharge_Remote_Ammo_Scripted"]
					};
					if (_magType == "BreachingCharge_Remote_Mag") exitWith {
						horde_gvar_currentChargeType = [_magType,"BreachingCharge_Remote_Ammo_Scripted"]
					};
				};
				_foundMag = true;
			};
		} forEach [
			"StickyCharge_Remote_Mag",
			"BreachingCharge_Remote_Mag"
		];
	};
};

(objNull call horde_fnc_intersectionData) params ["_object","_intersectPosASL","_normal","_isCharge"];

if (not _isCharge
	and {_magType == "" or {not _foundMag}}
) exitWith {};


if (not empty(_intersectPosASL)
	and {_intersectPosASL distance eyePos vehicle player < 2}
) then {
	player playActionNow "PutDown";
	private _type = typeOf _object;
	if (_isCharge
		and {toLower _type in ["breachingcharge_remote_ammo_scripted","democharge_remote_ammo_scripted"]}
	) then {
		deleteVehicle _object;
		call {
			if(_type == "BreachingCharge_Remote_Ammo_Scripted") exitWith {
				_type = "BreachingCharge_Remote_Mag"
			};
			if(_type == "DemoCharge_Remote_Ammo_Scripted") exitWith {
				_type = "StickyCharge_Remote_Mag"
			};
		};
		player addMagazine _type;
		sleep 0.5;
		getVar(missionNamespace,"ncb_gv_playerCharges") params ["_charges","_indexes"];
		{
			if (isNull _x) then {
				player removeAction sel(_indexes,_forEachIndex);
				_indexes set[_forEachIndex,objNull];
			};
		} forEach _charges;
		_charges = _charges - [objNull];
		_indexes = _indexes - [objNull];
		missionNamespace setVariable ["ncb_gv_playerCharges",[_charges,_indexes]];
	} else {
		_charge = spawnVeh(_ammoType,zeroPos);
		player removeMagazine _magType;
		_charge disableCollisionWith _object;
		private _vDir = vectorDir _charge;

		if (typeOf _object == ""
			or {_object isKindOf "Static"}
			or {not (simulationEnabled _object)}
		) then {
			_charge setPosASL _intersectPosASL;
		} else {
			_charge attachTo [_object,_object worldToModel (ASLToAGL _intersectPosASL)];
		};

		_charge setVectorUp _normal;
		private _cfgObject = configFile >> "CfgVehicles" >> typeOf _object;
		private _objectName = getText (_cfgObject >> "displayname");
		if (isNull _object) then {
			_objectName = surfaceType _intersectPosASL;
			if (toLower _objectName find "#gdt" > -1) then {
				_objectName = _objectName select [4,99]
			};
			if ("ItemGPS" in assignedItems player) then {
				_objectName = (mapGridPosition _intersectPosASL) + " " + _objectName
			};
		};
		private _mag = getText (configFile >> "CfgAmmo" >> (typeOf _charge) >> "defaultmagazine");
		_chargeName = getText (configFile >> "CfgMagazines" >> _mag >> "displayname");
		if (sel(horde_gvar_currentChargeType,1) isKindOf "TimeBombCore") then {
			private _action = player addAction [
				format ["<t shadow='2' color='#FF0000' size='1'>Detonate <t color='#FFFFFF' size='0.75'> //<t color='#FF0000' size='1'> %1 <t color='#FFFFFF' size='0.75'> // <t color='#FF0000' size='1'> %2</t>", _objectName, _chargeName],
				{
					private _id = sel(_this,2);
					private _args = sel(_this,3);

					[
						[_args],{
							call horde_fnc_getEachFrameArgs params ["_args"];
							_args params ["_charge","_object"];
							private _type = typeOf _object;
							if (_type == "") then {
								if (typeOf _charge == "DemoCharge_Remote_Ammo_Scripted") then {
									/*private _obj = "FLAY_fireGeom" createVehicleLocal [0,0,0];
									_obj setMass 999999;
									_obj allowDamage false;
									_objPos =  (getPosASL _charge) vectorAdd [0,0,2];
									_obj setPosASL _objPos;
									_obj setVelocity [0,0,-10];
									[
										[_obj],{
											call horde_fnc_getEachFrameArgs params ["_obj"];
											deleteVehicle _obj;
											call horde_fnc_removeEachFrame
										},
										0.5
									] call horde_fnc_addEachFrame;*/
								};
							} else {
								// open doors if house
								private _cfgUserActions = (configFile >> "CfgVehicles" >> _type >> "UserActions");
								if not empty(_cfgUserActions) then {
									for "_i" from 0 to count _cfgUserActions - 1 do {
										private _cfgEntry = sel(_cfgUserActions,_i);
										if (isClass _cfgEntry) then {
											private _displayName = toLower getText (_cfgEntry >> "displayname");
											if (_displayName in ["open hatch","open door"]) then {
												private _selectionName = getText (_cfgEntry >> "position");
												private _modelPos = _object selectionPosition _selectionName;
												private _worldPos = _object modelToWorld _modelPos;
												if (_worldPos distance _charge < 1.5) then {
													if (_displayName == "open door") then {
														private _strNumb = _selectionName select [5];
														private _numb = parseNumber _strNumb;
														private _door = "door_" + str _numb + "_rot";
														_object animate [_door, 1];
													} else {
														private _strNumb = _selectionName select [6];
														private _numb = parseNumber _strNumb;
														private _door = "hatch_" + str _numb + "_rot";
														_object animate [_door, 1];
													};
												};
											};
										};
									};
								};
							};
							_charge setDamage 1;
							{
								if (_x isKindOf "TimeBombCore") then {
									_x setDamage 1
								};
							} count (nearestObjects [
								_charge,
								[],
								2
							]);

							[
								{
									ncb_gv_playerCharges params ["_charges","_indexes"];
									{
										if (isNull _x) then {
											player removeAction sel(_indexes,_forEachIndex);
											_indexes set[_forEachIndex,objNull];
										};
									} forEach _charges;
									_charges = _charges - [objNull];
									_indexes = _indexes - [objNull];
									ncb_gv_playerCharges = [_charges,_indexes];
									call horde_fnc_removeEachFrame
								},
								0.5
							] call horde_fnc_updateEachFrameData
						},
						0.2
					] call horde_fnc_addEachFrame;
				},
				[_charge,_object]
			];
			// NOTE: ARRAY IS IN FORMAT: [[charges],[id's]]
			private _var = getVar(missionNamespace,"ncb_gv_playerCharges");
			sel(_var,0) pushBack _charge;
			sel(_var,1) pushBack _action;
			setVar(missionNamespace,"ncb_gv_playerCharges",_var);
		};
	};
};