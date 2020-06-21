#include "\nocebo\defines\scriptDefines.hpp"

params ["_worldPos","_object","_cfgEntry"];

private _helper = "Sign_Sphere25cm_F" createVehicleLocal _worldPos;
_helper setObjectTexture [0,'#(argb,8,8,3)color(1,0,0,1)'];
private _pos = [sel(_worldPos,0),sel(_worldPos,1),sel(_worldPos,2) + 0.3];

private _name = getText (_cfgEntry >> "text");
private _loc = "ncb_" + configName _cfgEntry;
private _location = getArray (_cfgEntry >> "location");
private _hitPointDamage = 0;
{
	private _dam = _object getHitPointDamage _x;
	if (not isNil "_dam" and {_dam > _hitPointDamage}) then {
		_hitPointDamage = _dam
	}
} forEach _location;
private _partHealthNumb = [typeOf _object,configName _cfgEntry,_hitPointDamage] call horde_fnc_realDamToRepairHealth;
private _partHealth = str round _partHealthNumb + "% Health";
// 1 - helper only
// 2 - helper & name
// 3 - helper, name & damage
// 4 - helper, name, damage and tool

/*if (SKILL IS LOW)*/
private _saveData = if (isNil {_object getVariable _loc}) then {true} else {false};

_object getVariable [_loc,[getText (_cfgEntry >> "parts"),selectRandom (getArray (_cfgEntry >> "tools"))]] params ["_partPrefix","_reqdItem"];

private _nameItem = getText(configFile >> "CfgWeapons" >> _reqdItem >> "displayname");

if (_saveData) then {
	_object setVariable [_loc,[_partPrefix, _reqdItem],true]
};

private _skill = "skillEngineer";
call {
	if (_partPrefix == "ItemTyre_") exitWith {
		_skill = "skillTyreFitter";
	};
	if (_partPrefix isKindOf "Bag_Base") exitWith {
		_skill = "skillWeaponFitter";
	};
};
private _handle = -1;
// get skill
player getVariable [_skill,[0,0]] params ["_skillLevel"];

call {
	if (_skillLevel > 4) exitWith {
		private _colour = [1,0,0,1];
		if (_reqdItem in items player) then {
			_colour = [0,1,0,1];
		};
		_handle = addMissionEventHandler ["Draw3D",compile format ["drawIcon3D ['', %5, %1, 0, 0, 0, '%2 - %3 - %4', 1, 0.03, 'PuristaMedium'];",_pos,_name,_partHealth,_nameItem,_colour]];
	};
	if (_skillLevel > 3) exitWith {
		_handle = addMissionEventHandler ["Draw3D",compile format ["drawIcon3D ['', [1,0,0,1], %1, 0, 0, 0, '%2 - %3 - %4', 1, 0.03, 'PuristaMedium'];",_pos,_name,_partHealth,_nameItem]];
	};
	if (_skillLevel > 2) exitWith {
		_handle = addMissionEventHandler ["Draw3D",compile format ["drawIcon3D ['', [1,0,0,1], %1, 0, 0, 0, '%2 - %3', 1, 0.03, 'PuristaMedium'];",_pos,_name,_partHealth]];
	};
	if (_skillLevel > 1) exitWith {
		_handle = addMissionEventHandler ["Draw3D",compile format ["drawIcon3D ['', [1,0,0,1], %1, 0, 0, 0, '%2', 1, 0.03, 'PuristaMedium'];",_pos,_name]];
	};
};
_helper setPosATL _worldPos;

// fade it out

[
	[_helper,_handle,9],{
		call horde_fnc_getEachFrameArgs params ["_helper","_handle","_index"];
		if (_index == 0) then {
			if (_handle > -1) then {
				removeMissionEventHandler ["Draw3D",_handle];
			};
			deleteVehicle _helper;
			call horde_fnc_removeEachFrame
		} else {
			private _col = str (_index / 10);
			private _str = "#(argb,8,8,3)color(" + _col + ",0,0," + _col + ")";
			_helper setObjectTexture [0,format ["%1",_str]];
			_index = _index - 1;
			[_helper,_handle,_index] call horde_fnc_updateEachFrameArgs
		}
	},
	0.1
] call horde_fnc_addEachFrame;

true
