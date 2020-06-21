#include "\nocebo\defines\scriptDefines.hpp"

scriptName "dragDropped";
params ["_targetCtrl","","","","_data"];
_data = _data select 0;
_data params ["","","_entry"];
_entry = call compile _entry;
_entry params ["_sourceMag","_sourceAmmo"];

if (_sourceAmmo == 0) exitWith {true}; // no action for empty mags

_cfgMagazines = configFile >> "CfgMagazines";
_display = uiNamespace getVariable "reloadMenu";
_display getVariable ["ncb_itemFrom",[objNull,controlNull]] params ["_sourceObj","_sourceIDC"];
_targetObj = _targetCtrl getVariable ["ncb_object",objNull];
_sourceCtrl = _display displayCtrl _sourceIDC;

// check to make sure it is still where it came from
// do not need to check weapon as vehicle already has no-one in it
// and only one person can interact
_targetMag = _sourceMag;
_targetAmmo = _sourceAmmo;
_stillThere = false;
_magsToAddBack = [];
_path = (_targetCtrl getVariable ["ncb_turretInfo",["",[-1],[]]]) select 1;

// find out if mag will be consumed or partial (only applies to adding to turret - not cargo etc)
_currentMags = [];
if (ctrlIDC _targetCtrl >= 1600) then {
	_targetMagInfo = _targetCtrl getVariable ["ncb_currentMag",["",0]];
	// don't use params as it makes variables private to this scope
	_targetMag = _targetMagInfo select 0;
	_targetAmmo = _targetMagInfo select 1;
	_targetMagCapacity = getNumber(_cfgMagazines >> _targetMag >> "count");
	_remainder = _targetAmmo + _sourceAmmo - _targetMagCapacity;
	_targetAmmo = (_targetAmmo + _sourceAmmo) min _targetMagCapacity;
	if (_remainder > 0) then {
		_magsToAddBack = [[_sourceMag,_remainder]];
		call {
			if (_sourceIDC == 1001) exitWith {
				ncb_gv_playerAmmoChanged = true
			};
			if (_sourceIDC == 1002) exitWith {
				ncb_gv_cargoAmmoChanged = true
			};
			if (_sourceIDC == 1003) exitWith {
				ncb_gv_groundAmmoChanged = true
			};
		}
	};
	_addIndex = _targetCtrl getVariable ["ncb_listBoxIndex",0];
	diag(_addIndex);
	// get array of current mags for this turret and modify array with new ammo count etc
	_currentMags = (magazinesAllTurrets _targetObj) select {_x select 2 != 0 and {_x select 1 isEqualTo _path} and {_targetMag == _x select 0}};
	_currentMags = _currentMags apply {[toLower (_x select 0),_x select 2]};
	diag(_currentMags);
	_maxIndex = count _currentMags - 1;
	if  (_addIndex > _maxIndex) then {
		_currentMags pushBack [_targetMag,_targetAmmo]
	} else {
		_currentMags set [_addIndex,[_targetMag,_targetAmmo]]
	};
	diag(_currentMags);
	/*ncb_gv_vehicleAmmoChanged = true;*/
};
call {
	if (_sourceIDC == 1001) exitWith {
		//check it's still there - and generate list of mags to add back to source after we remove them
		_notFound = true;
		{
			_x params ["_mag","_ammo"];
			if (_sourceMag == _mag and {_sourceAmmo == _ammo} and {_notFound}) then {
				_notFound = false;
				_stillThere = true
			} else {
				if (_sourceMag == _mag) then {
					_magsToAddBack pushBack [_mag,_ammo]
				}
			}
		} forEach magazinesAmmoFull _sourceObj;

		if (_stillThere) then {
			// update source mags (don't need to run remotely as player is sourceObj)
			_sourceObj removeMagazines _sourceMag;
			{
				_sourceObj addMagazine _x
			} count _magsToAddBack;
		}
	};
	if (_sourceIDC in [1002,1003]) exitWith {
		_notFound = true;
		{
			_x params ["_mag","_ammo"];
			if (_sourceMag == _mag and {_sourceAmmo == _ammo} and {_notFound}) then {
				_stillThere = true;
				_notFound = false;
			} else {
				_magsToAddBack pushBack [_mag,_ammo];
			}
		} forEach magazinesAmmoCargo _sourceObj;
		if (_stillThere) then {
			// both of these commands are global
			clearMagazineCargoGlobal _sourceObj;
			{
				_sourceObj addMagazineAmmoCargo [_x select 0,1,_x select 1]
			} count _magsToAddBack;
		}
	};
	if (_sourceIDC >= 1600) exitWith {
		_path = (_sourceCtrl getVariable ["ncb_turretInfo",["",[-1],[]]]) select 1;
		_currentMags = (magazinesAllTurrets _sourceObj) select {_x select 2 != 0 and {_x select 1 isEqualTo _path}};
		_currentMags = _currentMags apply {[toLower (_x select 0),_x select 2]};
		_targetMag = _sourceCtrl getVariable ["ncb_linkClasses",["",""]] select 1;
		[_sourceObj,[_sourceMag,_path],player] call horde_fnc_reloadMenuRemoveMagazinesTurret;
		_delete = [toLower _sourceMag,_sourceAmmo];
		_index = _currentMags find _delete;
		if (_index > -1) then {
			_targetAmmo = getNumber (configFile >> "CfgMagazines" >> _targetMag >> "count");
			_remainder = _sourceAmmo - _targetAmmo;
			if (_remainder > 0) then {
				_currentMags set [_index,[_sourceMag,_remainder]];
			} else {
				_currentMags deleteAt _index;
				_targetAmmo = _targetAmmo + _remainder;
			};
			[_sourceObj,_sourceMag,_path,_currentMags,player] call horde_fnc_reloadMenuAddMagazinesTurret;
			_stillThere = true;
			/*ncb_gv_vehicleAmmoChanged = true;*/
		} else {
			diag_log "problem - mag not found on turret"
		};
	}
};


if (_stillThere) then {
	call {
		if (ctrlIDC _targetCtrl == 1001) exitWith {
			_targetObj addMagazine [_targetMag,_targetAmmo]
		};
		if (ctrlIDC _targetCtrl in [1002,1003]) exitWith {
			_targetObj addMagazineAmmoCargo [_targetMag,1,_targetAmmo]
		};
		if (ctrlIDC _targetCtrl >= 1600) exitWith {
			[_targetObj,_targetMag,_path,_currentMags,player] call horde_fnc_reloadMenuUpdateMagazinesTurret
		};
	};
	// dodgy reload
	/*closeDialog 0;
	[] spawn {
		waitUntil {not dialog};
		createDialog "reloadMenu"
	}*/
};
// delete at from object