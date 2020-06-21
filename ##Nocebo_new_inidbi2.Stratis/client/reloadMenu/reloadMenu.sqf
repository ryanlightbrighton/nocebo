#include "\nocebo\defines\scriptDefines.hpp"
scriptName "reloadMain";

_handle = (uiNamespace getVariable 'reloadMenu') displayAddEventHandler ["KeyDown", "
	if ((_this select 1) in (actionKeys 'User13')) then {
		(uiNamespace getVariable 'reloadMenu') displayRemoveEventHandler ['Keydown',(uiNamespace getVariable 'reloadMenu') getVariable 'handle'];
		closeDialog 0;
	};
	false
"];
(uiNamespace getVariable 'reloadMenu') setVariable ["handle",_handle];

// this is defined in commoninit.sqf ==> ncb_gv_refillMagTypes

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
		or {isNull _display}
		or {not (toLower lifeState player in ["healthy","injured"])}
		or {not alive player}
	};
	setVarPlc(_veh,"vehiclePlayerInteracting",nil);
};
