#include "\nocebo\defines\scriptDefines.hpp"
scriptName "reloadMain";

// this is defined in commoninit.sqf ==> ncb_gv_refillMagTypes

horde_fnc_reloadMenuDragStarted = {
	scriptName "dragStarted";
	params ["_ctrl","_data"];
	_data = _data select 0;
	_data params ["","","_entry"];
	_entry = call compile _entry;
	_entry params ["_mag","_count"];

	_display = uiNamespace getVariable "reloadMenu";

	// log a variable to tell us where the item came from

	_display setVariable ["ncb_itemFrom", [
		_ctrl getVariable ["ncb_object",objNull],
		ctrlIDC _ctrl
	]];

	// add EH to enable controls when mouse button is unclicked

	_display displayAddEventHandler ["mouseButtonUp",{
		_display = uiNamespace getVariable "reloadMenu";
		{
			_ct = _display displayCtrl _x;
			if not (ctrlEnabled _ct) then {
				_ct ctrlEnable true
			}
		} forEach [1001,1002,1003];

		for "_i" from 1600 to 1700 do {
			_ct = _display displayCtrl _i;
			if (isNull _ct) exitWith {};
			if not (ctrlEnabled _ct) then {
				_ct ctrlEnable true
			}
		};
		_display displayRemoveAllEventHandlers "mouseButtonUp"
	}];

	// if this came from a vehicle, then change the class to refill class
	if (ctrlIDC _ctrl >= 1600) then {
		_mag = (_ctrl getVariable ["ncb_linkClasses",["",""]]) select 1
	};

	// disable any containers that have no room
	{
		_ct = _display displayCtrl _x;
		_canAdd = _ct getVariable ["ncb_object",objNull] canAdd _mag;
		if (isNil "_canAdd") then {
			_canAdd = false
		};
		if (not _canAdd
		    or {_ct isEqualTo _ctrl}
		    or {_count == 0}
		) then {
			_ct ctrlEnable false;
		}
	} forEach [1001,1002,1003];

	// disable any weapons that will not accept this mag.
	// also, disable any weapons that have enough (or too many mags)

	for "_i" from 1600 to 1700 do {
		_ct = _display displayCtrl _i;
		if (isNull _ct) exitWith {};
		call {
			if (ctrlIDC _ctrl >= 1600) exitWith {
				_ct ctrlEnable false;
			};
			if not (_ct getVariable ["ncb_canAdd",true]) exitWith {
				_ct ctrlEnable false;
			};
			_ct getVariable ["ncb_linkClasses",["",""]] params ["_defaultMag","_magToAdd"];
			if (_magToAdd != _mag) then {
				_ct ctrlEnable false;
			}
		}
	}
};

// LITTLE FUNCTIONS TO REMOVE & ADD MAGS REMOTELY (THESE WILL NEED TO BE COMMON)

horde_fnc_reloadMenuRemoveMagazinesTurret = {
	diag_log "horde_fnc_reloadMenuRemoveMagazinesTurret";
	diag(_this);
	params ["_sourceObj","_data"];
	// if (local _sourceObj) then {
	if (_sourceObj turretLocal (_data select 1)) then {
		_sourceObj removeMagazinesTurret _data
	} else {
		if (isServer) then {
			[_sourceObj,_data] remoteExecCall [
				"horde_fnc_reloadMenuRemoveMagazinesTurret",
				_sourceObj turretOwner (_data select 1)
			]
		} else {
			[_sourceObj,_data] remoteExecCall [
				"horde_fnc_reloadMenuRemoveMagazinesTurret",
				2
			]
		}
	}
};

horde_fnc_reloadMenuAddMagazinesTurret = {
	diag_log "horde_fnc_reloadMenuAddMagazinesTurret";
	diag(_this);
	params ["_sourceObj","_sourceMag","_path","_currentMags"];
	/*if (local _sourceObj) then {*/
	if (_sourceObj turretLocal _path) then {
		{
			if (_x select 0 == _sourceMag) then {
				_sourceObj addMagazineTurret [_x select 0,_path,_x select 1]
			};
		} count _currentMags;
	} else {
		if (isServer) then {
			[_sourceObj,_sourceMag,_path,_currentMags] remoteExecCall [
				"horde_fnc_reloadMenuAddMagazinesTurret",
				_sourceObj turretOwner _path
			]
		} else {
			[_sourceObj,_sourceMag,_path,_currentMags] remoteExecCall [
				"horde_fnc_reloadMenuAddMagazinesTurret",
				2
			]
		}
	}
};

horde_fnc_reloadMenuUpdateMagazinesTurret = {
	diag_log "horde_fnc_reloadMenuUpdateMagazinesTurret";
	diag(_this);
	params ["_targetObj","_targetMag","_path","_currentMags"];
	/*if (local _targetObj) then {*/
	if (_targetObj turretLocal _path) then {
		_targetObj removeMagazinesTurret [_targetMag,_path];
		{
			_targetObj addMagazineTurret [_x select 0,_path,_x select 1]
		} count _currentMags
	} else {
		if (isServer) then {
			[_targetObj,_targetMag,_path,_currentMags] remoteExecCall [
				"horde_fnc_reloadMenuUpdateMagazinesTurret",
				_targetObj turretOwner _path
			]
		} else {
			[_targetObj,_targetMag,_path,_currentMags] remoteExecCall [
				"horde_fnc_reloadMenuUpdateMagazinesTurret",
				2
			]
		}
	}
};



horde_fnc_reloadMenuDragDropped = {
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
		ncb_gv_vehicleAmmoChanged = true;
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
			/*[_sourceObj,[_sourceMag,_path]] remoteExecCall [
				"removeMagazinesTurret",
				_sourceObj
			];*/
			[_sourceObj,[_sourceMag,_path]] call horde_fnc_reloadMenuRemoveMagazinesTurret;
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
				/*{
					if (_x select 0 == _sourceMag) then {
						[_sourceObj,[_x select 0,_path,_x select 1]] remoteExecCall [
							"addMagazineTurret",
							_sourceObj
						]
					};
				} forEach _currentMags;*/
				[_sourceObj,_sourceMag,_path,_currentMags] call horde_fnc_reloadMenuAddMagazinesTurret;
				_stillThere = true;
				ncb_gv_vehicleAmmoChanged = true;
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
				/*[_targetObj,[_targetMag,_path]] remoteExecCall [
					"removeMagazinesTurret",
					_targetObj
				];
				{
					[_targetObj,[_x select 0,_path,_x select 1]] remoteExecCall [
						"addMagazineTurret",
						_targetObj
					]
				} forEach _currentMags*/
				[_targetObj,_targetMag,_path,_currentMags] call horde_fnc_reloadMenuUpdateMagazinesTurret
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
};

_this spawn {
	_fnc_turretsCfg = {
		private _vehConfig = configFile >> "CfgVehicles" >> typeOf _this;
		private _vehTurretsCfg = [_vehConfig];
		private _fnc_getTurretsCfg = {
			{
				_vehTurretsCfg pushBack _x;
				if (isClass (_x >> "Turrets")) then {_x call _fnc_getTurretsCfg};
			} forEach ("true" configClasses (_this >> "Turrets"));
		};
		_vehConfig call _fnc_getTurretsCfg;
		_vehTurretsCfg
	};
	disableSerialization; // get rid of this later
	params ["_display"];
	_ctrlPlayerLB = _display displayCtrl 1001;
	_ctrlCargoLB = _display displayCtrl 1002;
	_ctrlGroundLB = _display displayCtrl 1003;
	_veh = (uiNamespace getVariable "uiInteractionInfo") select 0;
	if (isNull _veh) exitWith {
		closeDialog 0
	};
	setVarPlc(_veh,"vehiclePlayerInteracting",player);
	_cfgVeh = configFile >> "CfgVehicles" >> typeOf _veh;
	_cfgWeaps = configFile >> "CfgWeapons";
	_cfgMags = configFile >> "CfgMagazines";
	// populate vehicle listbox

	/*private _mags = (magazinesAllTurrets _veh) apply {[toLower (_x select 0),_x select 1,_x select 2]};
	_mags = _mags select {_x select 2 != 0};*/
	_paths = [[-1]] + allTurrets [_veh,true];
	_weaponsList = [];
	_defaultMagCount = 0;
	{
		_cfgTurret = _x;
		_index = _forEachIndex;
		{
			_weap = toLower _x;
			if (_weap find "horn" == -1 and {_weap find "fake" == -1}) then {
				private _compatibleMags = getArray(_cfgWeaps >> _weap >> "magazines");
				if (_compatibleMags isEqualTo []) then {
					{
						_compatibleMags append getArray(_cfgWeaps >> _weap >> _x >> "magazines");
					} forEach getArray(_cfgWeaps >> _weap >> "muzzles");
				};
				_compatibleMags = _compatibleMags apply {toLower _x};
				_defaultMags = (getArray(_cfgTurret >> "magazines")) select {toLower _x in _compatibleMags};
				_defaultMags = _defaultMags apply {toLower _x};
				_defaultMagCount = _defaultMagCount + count _defaultMags;
				_weaponsList pushBack [_weap,_paths select _index,_defaultMags,_compatibleMags];
			}
		} forEach (getArray (_cfgTurret >> "weapons"))
	} forEach (_veh call _fnc_turretsCfg);
	_fnc_updateVehicleMenu = {
		if not ([] isEqualTo _weaponsList) then {
			private _mags = (magazinesAllTurrets _veh) apply {[toLower (_x select 0),_x select 1,_x select 2]};
			_mags = _mags select {_x select 2 != 0};
			_cfgCtrlVeh = missionConfigFile >> "reloadMenu" >> "Controls" >> "Vehicle";
			_ctrlX = getNumber(_cfgCtrlVeh >> "x");
			_ctrlY = getNumber(_cfgCtrlVeh >> "y");
			_ctrlW = getNumber(_cfgCtrlVeh >> "w");
			_ctrlH = getNumber(_cfgCtrlVeh >> "h");
			_headerHeight = 0.03 * safeZoneH;
			_ctrlHeight = 0.0653333 * safeZoneH;
			_ctrlHeight = (_ctrlH - ((count _weaponsList) *_headerHeight)) / _defaultMagCount;
			_idcIndex = 1600;
			{
				_x params ["_weap","_path","_defaultMags","_compatibleMags"];
				_missingMagTypes = +_defaultMags;
				// create header
				_ct = _display ctrlCreate ["ncb_reloadMenuRscTextCenter",1500 + _forEachIndex];
				_ct ctrlSetText (getText (_cfgWeaps >> _weap >> "displayName") + format [" (Max: %1)",count _defaultMags]);
				_ct ctrlSetPosition [_ctrlX,_ctrlY,_ctrlW,_headerHeight];
				_ctrlY = _headerHeight + _ctrlY;
				_ct ctrlCommit 0;
				// now create listbox for each default mag
				_listBoxIndex = 0;
				_defaultMagType = "";
				{
					_defaultMag = _x;
					if (_defaultMag != _defaultMagType) then {
						_defaultMagType = _defaultMag;
						_listBoxIndex = 0;
					};
					_ct = _display ctrlCreate ["ncb_reloadMenuRscVehicle",_idcIndex];
					_ct ctrlSetPosition [_ctrlX,_ctrlY,_ctrlW,_ctrlHeight];
					_ctrlY = _ctrlHeight + _ctrlY;
					_ct ctrlCommit 0;
					// now populate the listbox (find a compatible mag - then remove it from the array)
					_magInfo = [_defaultMag,0];
					private _canAdd = true;
					{
						_x params ["_mag","_path2","_ammo"];
						if (_path isEqualTo _path2
							and {_mag == _defaultMag}
						) exitWith {
							_magInfo = [_mag,_ammo];
							_index = _ct lbAdd getText(_cfgMags >> _mag >> "displayName");
							_tooltip = getText(_cfgMags >> _mag >> "descriptionshort");
							_tooltip = _tooltip splitString "<" select 0;
							_tooltip = _tooltip + endl + format ["Rounds: %1",_ammo];
							_ct lbSetTooltip [_index,_tooltip];
							_ct lbSetPictureRight [_index,getText(_cfgMags >> _mag >> "picture")];
							// ammo count - get % of ammo left
							_capacity = getNumber(_cfgMags >> _mag >> "count");
							if (_ammo == _capacity) then {
								_canAdd = false;
							};
							_count = ceil ((_ammo / _capacity) * 30);
							_ct lbSetPicture [_index,"client\gui\images\bulletcount\" + str _count + ".paa"];
							_ct lbSetData [_index,str _magInfo];
							_ct lbSetValue [_index,_idcIndex];
							_mags set [_forEachIndex,["",[-10],""]]
						}
					} forEach _mags;
					// if not found, then populate with empty
					if (_magInfo select 1 == 0) then {
						_index = _ct lbAdd (getText(_cfgMags >> _defaultMag >> "displayName")) + " (EMPTY)";
						_ct lbSetTooltip [_index,"EMPTY"];
						_ct lbSetPictureRight [_index,getText(_cfgMags >> _x >> "picture")];
						_ct lbSetPicture [_index,"client\gui\images\bulletcount\0.paa"];
						_ct lbSetData [_index,str _magInfo];
						_ct lbSetValue [_index,_idcIndex];
						_ct lbSetColor [_index, [1,0,0,0.5]];
					};
					_magToAdd = "";
					/*_ammoClass = getText (configFile >> "CfgMagazines" >> _defaultMag >> "ammo");
					{
						if (_ammoClass isKindOf (_x select 1)) exitWith {
							_magToAdd = (_x select 0)
						}
					} forEach ncb_gv_refillMagTypes;*/
					{
						if (getText (configFile >> "CfgMagazines" >> _defaultMag >> "ncb_refillclass") == getText (configFile >> "CfgMagazines" >> (_x select 0) >> "ncb_refillclass")) exitWith {
							_magToAdd = (_x select 0)
						}
					} forEach ncb_gv_refillMagTypes;
					_ct setVariable ["ncb_linkClasses",[_defaultMag,_magToAdd]];
					_ct setVariable ["ncb_object",_veh];
					_ct setVariable ["ncb_turretInfo",[_weap,_path,_defaultMags,_compatibleMags]];
					_ct setVariable ["ncb_currentMag",_magInfo];
					_ct setVariable ["ncb_canAdd",_canAdd];
					_ct setVariable ["ncb_listBoxIndex",_listBoxIndex];
					_listBoxIndex = _listBoxIndex + 1;
					_idcIndex = _idcIndex + 1;

				} forEach _defaultMags;
			} forEach _weaponsList;
		};
	};

	// now populate the player menu
	_ctrlPlayerLB setVariable ["ncb_object",player];
	_fnc_updatePlayerMenu = {
		lbClear _ctrlPlayerLB;
		{
			_x params ["_mag","_ammo"];
			if (getNumber(_cfgMags >> _mag >> "ncb_refill") == 1) then {
				_index = _ctrlPlayerLB lbAdd getText(_cfgMags >> _mag >> "displayName");
				_tooltip = getText(_cfgMags >> _mag >> "descriptionshort");
				_tooltip = _tooltip splitString "<" select 0;
				_tooltip = _tooltip + endl + format ["Rounds: %1",_ammo];
				_ctrlPlayerLB lbSetTooltip [_index,_tooltip];
				_ctrlPlayerLB lbSetPictureRight [_index,getText(_cfgMags >> _mag >> "picture")];
				// ammo count
				// get % of ammo left
				_capacity = getNumber(_cfgMags >> _mag >> "count");
				_count = floor ((_ammo / _capacity) * 30);
				_ctrlPlayerLB lbSetPicture [_index,"client\gui\images\bulletcount\" + str _count + ".paa"];
				_data = str [_mag,_ammo];
				_ctrlPlayerLB lbSetData [_index,_data];
				_ctrlPlayerLB lbSetValue [_index,_forEachIndex];
			}
		} forEach magazinesAmmoFull player;
	};

	// now populate the cargo menu
	_ctrlCargoLB setVariable ["ncb_object",_veh];
	_fnc_updateCargoMenu = {
		lbClear _ctrlCargoLB;
		{
			_x params ["_mag","_ammo"];
			if (getNumber(_cfgMags >> _mag >> "ncb_refill") == 1) then {
				_index = _ctrlCargoLB lbAdd getText(_cfgMags >> _mag >> "displayName");
				_tooltip = getText(_cfgMags >> _mag >> "descriptionshort");
				_tooltip = _tooltip splitString "<" select 0;
				_tooltip = _tooltip + endl + format ["Rounds: %1",_ammo];
				_ctrlCargoLB lbSetTooltip [_index,_tooltip];
				_ctrlCargoLB lbSetPictureRight [_index,getText(_cfgMags >> _mag >> "picture")];
				// ammo count
				// get % of ammo left
				_capacity = getNumber(_cfgMags >> _mag >> "count");
				_count = floor ((_ammo / _capacity) * 30);
				_ctrlCargoLB lbSetPicture [_index,"client\gui\images\bulletcount\" + str _count + ".paa"];
				_data = str [_mag,_ammo];
				_ctrlCargoLB lbSetData [_index,_data];
				_ctrlCargoLB lbSetValue [_index,_forEachIndex];
			}
		} forEach magazinesAmmoCargo _veh;
	};

	// now populate the ground menu (test code)

	/*_holder = holder1;*/
	_holder = objNull;
	_holders  = nearestObjects [player,["GroundWeaponHolder"],2];
	if ([] isEqualTo _holders) then {
		_holder = createVehicle ["GroundWeaponHolder_Scripted",ASLtoAGL getPosASL player,[],0,"can_collide"]
	} else {
		_holder = _holders select 0;
		if (count _holders > 1) then {
			{
				if (_forEachIndex > 0) then {
					{
						_holder addMagazineAmmoCargo [_x select 0,1,_x select 1]
					} forEach magazinesAmmoCargo _x;
					deleteVehicle _x
				}
			} forEach _holders
		}
	};
	_ctrlGroundLB setVariable ["ncb_object",_holder];
	_fnc_updateGroundMenu = {
		lbClear _ctrlGroundLB;
		{
			_x params ["_mag","_ammo"];
			if (getNumber(_cfgMags >> _mag >> "ncb_refill") == 1) then {
				_index = _ctrlGroundLB lbAdd getText(_cfgMags >> _mag >> "displayName");
				_tooltip = getText(_cfgMags >> _mag >> "descriptionshort");
				_tooltip = _tooltip splitString "<" select 0;
				_tooltip = _tooltip + endl + format ["Rounds: %1",_ammo];
				_ctrlGroundLB lbSetTooltip [_index,_tooltip];
				_ctrlGroundLB lbSetPictureRight [_index,getText(_cfgMags >> _mag >> "picture")];
				// ammo count
				// get % of ammo left
				_capacity = getNumber(_cfgMags >> _mag >> "count");
				_count = floor ((_ammo / _capacity) * 30);
				_ctrlGroundLB lbSetPicture [_index,"client\gui\images\bulletcount\" + str _count + ".paa"];
				_data = str [_mag,_ammo];
				_ctrlGroundLB lbSetData [_index,_data];
				_ctrlGroundLB lbSetValue [_index,_forEachIndex];
			}
		} forEach magazinesAmmoCargo _holder;
	};

	call _fnc_updateVehicleMenu;
	call _fnc_updatePlayerMenu;
	call _fnc_updateCargoMenu;
	call _fnc_updateGroundMenu;

	ncb_gv_vehicleAmmoChanged = false;
	ncb_gv_playerAmmoChanged = false;
	ncb_gv_cargoAmmoChanged = false;
	ncb_gv_groundAmmoChanged = false;
	waitUntil {
		if (ncb_gv_vehicleAmmoChanged) then {
			ncb_gv_vehicleAmmoChanged = false;
			for "_i" from 1500 to 1599 do {
				_ctrlVehicleMenu = _display displayCtrl _i;
				if isNull (_ctrlVehicleMenu) exitWith {};
				ctrlDelete _ctrlVehicleMenu
			};
			for "_i" from 1600 to 1700 do {
				_ctrlVehicleMenu = _display displayCtrl _i;
				if isNull (_ctrlVehicleMenu) exitWith {};
				ctrlDelete _ctrlVehicleMenu
			};
			call _fnc_updateVehicleMenu
		};
		if (ncb_gv_playerAmmoChanged
		    or {count (magazines player select {getNumber(_cfgMags >> _x >> "ncb_refill") == 1}) != lbSize _ctrlPlayerLB}
		) then {
			call _fnc_updatePlayerMenu
		};
		if (ncb_gv_cargoAmmoChanged
		    or {count (magazineCargo _veh select {getNumber(_cfgMags >> _x >> "ncb_refill") == 1}) != lbSize _ctrlCargoLB}
		) then {
			ncb_gv_cargoAmmoChanged = false;
			call _fnc_updateCargoMenu
		};
		if (ncb_gv_groundAmmoChanged
		    or {count (magazineCargo _holder select {getNumber(_cfgMags >> _x >> "ncb_refill") == 1}) != lbSize _ctrlGroundLB}
		) then {
			ncb_gv_groundAmmoChanged = false;
			call _fnc_updateGroundMenu
		};
		not dialog
		or {not (toLower lifeState player in ["healthy","injured"])}
		or {not alive player}
	};
	setVarPlc(_veh,"vehiclePlayerInteracting",nil);
};
