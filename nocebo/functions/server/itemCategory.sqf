#include "\nocebo\defines\scriptDefines.hpp"

// 0 = 0 execVM "server\init\itemCategory.sqf";

// log some stuff

_numbs = [];
_list = "_numbs pushBackUnique getNumber (_x >> 'ItemInfo' >> 'HitpointsProtectionInfo' >> 'Head' >> 'armor');true" configClasses (configFile >> "CfgWeapons");
_numbs sort true;
diag_log format ["helmet armor ranges: %1",_numbs];

_numbs = [];
_list = "_numbs pushBackUnique getNumber (_x >> 'ItemInfo' >> 'HitpointsProtectionInfo' >> 'Chest' >> 'armor');true" configClasses (configFile >> "CfgWeapons");
_numbs sort true;
diag_log format ["vest armor ranges: %1",_numbs];

// local funcs

_fnc_getUniformArmour = {
    private _manClass = getText(configfile >> "CfgWeapons" >> _this >> "ItemInfo" >> "uniformClass");
    private _armor = 0;
    {
        _armor = _armor + (getNumber (_x >> "armor"));
    } forEach configproperties [configFile >> "CfgVehicles">> _manClass >> "HitPoints","isclass _x"];
    _armor
};

_numbs = [];
_list = "_numbs pushBackUnique ((configName _x) call _fnc_getUniformArmour);true" configClasses (configFile >> "CfgWeapons");
_numbs sort true;
diag_log format ["uniform armor ranges: %1",_numbs];

_fnc_isWeaponAccCompatible = {
	scopeName "root";
	params ["_weaponClass","_accClass",["_typeNumb", -1]];
	private _compatible = false;
	{
		private _cfgCompatibleItems = _x >> "compatibleItems";
		if (isArray _cfgCompatibleItems) then {
			private _items = getArray _cfgCompatibleItems;
			if (not (_items isEqualTo []) and {_typeNumb == -1 or {_typeNumb == getNumber (_cfgWeapons >>  (_items select 0) >> "ItemInfo" >> "type")}}) then {
				{
					if (_accClass == _x) exitWith {
						_compatible = true;
						breakTo "root"
					};
				} forEach _items
			};
		} else {
			if (isClass _cfgCompatibleItems) then {
				{
					if (getNumber _x > 0 and {configName _x == _accClass}) then {
						_compatible = true;
						breakTo "root"
					};
				} forEach configProperties [
					_cfgCompatibleItems,
					"isNumber _x"
				];
			};
		};
	} forEach configProperties [
		configFile >> "CfgWeapons" >> _weaponClass >> "WeaponSlotsInfo",
		"isClass _x",
		true
	];
	_compatible
};

_fnc_greaterOrEqualRange = {
	private _found = false;
	private _dist = 0;
	for "_modeIndex" from 0 to count _cfgOpticsModes - 1 do {
		private _cfgMode = _cfgOpticsModes select _modeIndex;
		/*_dist = getNumber (_cfgMode >> 'distanceZoomMax');*/
		private _discreteDists = getArray (_cfgMode >> 'discreteDistance');
		if not empty(_discreteDists) then {
			_dist = _discreteDists select (count _discreteDists - 1)
		} else {
			_dist = getNumber (_cfgMode >> 'distanceZoomMax')
		};

		if (_dist >= _this) exitWith {
			_found = true
		};
	};
	_found
};

_fnc_scopeType = {
	private _found = false;
	for "_ind1" from 0 to count _cfgOpticsModes - 1 do {
		_cfgMode = _cfgOpticsModes select _ind1;
		_modes = getArray (_cfgMode >> 'visionMode');
		if ({if (_x == _this) exitWith {1}} count _modes > 0) exitWith {
			_found = true
		}
	};
	_found
};
_fnc_getWeaponParent = {
	private _cfgParent = inheritsFrom (configFile >> "CfgWeapons" >> _this);
	if (getNumber (_cfgParent >> "scope") == 2) then {
		_this = configName _cfgParent;
		_this = _this call _fnc_getWeaponParent;
	};
	_this
};

_fnc_getMagazineParent = {
	private _cfgParent = inheritsFrom (configFile >> "CfgMagazines" >> _this);
	if (getNumber (_cfgParent >> "scope") == 2) then {
		_this = configName _cfgParent;
		_this = _this call _fnc_getMagazineParent;
	};
	_this
};

_fnc_getVehicleParent = {
	private _cfgParent = inheritsFrom (configFile >> "CfgVehicles" >> _this);
	if (getNumber (_cfgParent >> "scope") == 2) then {
		_this = configName _cfgParent;
		_this = _this call _fnc_getVehicleParent;
	};
	_this
};

_fnc_getGlassesParent = {
	private _cfgParent = inheritsFrom (configFile >> "CfgGlasses" >> _this);
	if (getNumber (_cfgParent >> "scope") == 2) then {
		_this = configName _cfgParent;
		_this = _this call _fnc_getGlassesParent;
	};
	_this
};

_cfgVehicles = configFile >> "CfgVehicles";
_cfgWeapons = configFile >> "CfgWeapons";
_cfgMagazines = configFile >> "CfgMagazines";
_cfgGlasses = configFile >> "CfgGlasses";

_riflesTier0 = [];
_riflesTier1 = [];
_riflesTier2 = [];
_riflesTier3 = [];
_riflesTier4 = [];
_pistolsTier0 = [];
_pistolsTier1 = [];
_launchersTier0 = [];
_launchersTier1 = [];
_launchersTier2 = [];
_barrelAttach = [];
_scopesTier0 = [];
_scopesTier1 = [];
_scopesTier2 = [];
_scopesTier3 = [];
_sideAttachTier0 = [];
_sideAttachTier1 = [];
_underAttach = [];
_headOpticsTier0 = [];
_headOpticsTier1 = [];
_helmetsTier0 = [];
_helmetsTier1 = [];
_helmetsTier2 = [];
_helmetsTier3 = [];
_helmetsTier4 = [];
_helmetsTier5 = [];
_vestsTier0 = [];
_vestsTier1 = [];
_vestsTier2 = [];
_vestsTier3 = [];
_vestsTier4 = [];
_vestsTier5 = [];
_vestsTier6 = [];
_uniformsTier0 = [];
_uniformsTier1 = [];
_uniformsTier2 = [];
_uniformsTier3 = [];
_uniformsTier4 = [];
_binosTier0 = [];
_binosTier1 = [];
_binosTier2 = [];
_backpacksTier0 = [];
_backpacksTier1 = [];
_backpacksTier2 = [];
_backpacksTier3 = [];
_backpacksTier4 = [];
_badGuyShades = [];
_shades = [];
_grenades = [];
_ugls = [];
_smokes = [];
_chemLights = [];
_flares = ["autoAdd"];
_rockets = [];
_vehicleMagsTier0 = ["autoAdd"];
_vehicleMagsTier1 = ["autoAdd"];
_vehicleMagsTier2 = ["autoAdd"];
_vehicleMagsTier3 = ["autoAdd"];
_magsTier0 = [];
_magsTier1 = [];
_magsTier2 = [];
_magsTier3 = [];
_magsTier4 = [];
_medicalTier0 = ["autoAdd"];
_medicalTier1 = ["autoAdd"];
_foodTier0 = ["autoAdd"];
_foodTier1 = ["autoAdd"];
_foodTier2 = ["autoAdd"];
_drink = ["autoAdd"];
_rubbish = ["autoAdd"];
_toolsTier0 = ["autoAdd"];
_toolsTier1 = ["autoAdd"];
_toolsTier2 = ["autoAdd"];
_tents = ["autoAdd"];
_fuel = ["autoAdd"];
_passesTier0 = ["autoAdd"];
_passesTier1 = ["autoAdd"];
_miscItems = ["autoAdd"];
_sticky = ["autoAdd"];
_vehiclePartsTier0 = ["autoAdd"];
_vehiclePartsTier1 = ["autoAdd"];
_vehiclePartsTier2 = ["autoAdd"];
_vehiclePartsTier3 = ["autoAdd"];
_aircraftPartsTier0 = ["autoAdd"];
_aircraftPartsTier1 = ["autoAdd"];
_aircraftPartsTier2 = ["autoAdd"];
_aircraftPartsTier3 = ["autoAdd"];
_weaponBags = ["autoAdd"];


for "_i" from 0 to count _cfgWeapons - 1 do {
	_cfgEntry = _cfgWeapons select _i;
	if (isClass _cfgEntry
		and {getNumber (_cfgEntry >> "scope") == 2}
		and {getText (_cfgEntry >> "model") != ""}
		and {getText (_cfgEntry >> "picture") != ""}
	) then {
		_class = configName _cfgEntry;
		call {
			if (_class isKindOf ["Rifle",_cfgWeapons]) exitWith {
				/*if (toLower _class find "base" == -1
					and {count (_cfgEntry >> "LinkedItems") < 1
						or {count (_cfgEntry >> "LinkedItems") == 1
							//and {configName ((_cfgEntry >> "LinkedItems") select 0) == "LinkedItemsUnder"}
							and {toLower configName ((_cfgEntry >> "LinkedItems") select 0) in ["linkeditemsunder","linkeditemsmuzzle"]}
						}
					}
				) then {*/
				private _classBase = getText (_cfgEntry >> "baseweapon");
				if (_classBase != "") then {
					_class = _classBase;
					_cfgEntry = _cfgWeapons >> _class;
				};
				private _text = toLower getText (_cfgEntry >> 'descriptionShort');
				private _mags = getArray (_cfgEntry >> 'magazines');
				private _mag = _mags select 0;
				private _ammo = toLower getText (_cfgMagazines >> _mag >> "ammo");
				if (_classBase == ""
				  	and {count (_cfgEntry >> "LinkedItems") > 1}
				  	or {count (_cfgEntry >> "LinkedItems") == 1 and {not (toLower configName ((_cfgEntry >> "LinkedItems") select 0) in ["linkeditemsunder","linkeditemsmuzzle"])}}
				) then {
					_text = ""
				};
				if ({if (_text find _x > -1) exitWith {1}} count ['9x19','.45 acp','9x21','.32','9x18','303','9.3x62','4.6x30','pp-2000','submachine gun'] > 0 or {{if (_ammo find _x > -1) exitWith {1}} count ['9x21','45acp','570x28','45gap','45super','357m','303'] > 0}) exitWith {
					_riflesTier0 pushBackUnique _class
				};
				if ({if (_text find _x > -1) exitWith {1}} count ['5.45x39','5.56x45','5.8x42','12 gauge'] > 0 or {{if (_ammo find _x > -1) exitWith {1}} count ['545x39','556x45','580x42','12g'] > 0}) exitWith {
					_riflesTier1 pushBackUnique _class
				};
				if ({if (_text find _x > -1) exitWith {1}} count ['6.5x39','7.62x39'] > 0 or {{if (_ammo find _x > -1) exitWith {1}} count ['65x39','762x39'] > 0}) exitWith {
					_riflesTier2 pushBackUnique _class
				};
				if ({if (_text find _x > -1) exitWith {1}} count ['7.62x51','7.62x54','12.7x54','9x39','.308'] > 0 or {{if (_ammo find _x > -1) exitWith {1}} count ['762x51','762x54','127x54'] > 0}) exitWith {
					_riflesTier3 pushBackUnique _class
				};
				if ({if (_text find _x > -1) exitWith {1}} count ['12.7x99','12.7x108','.408','9.3x64','.338','25mm payload'] > 0 or {{if (_ammo find _x > -1) exitWith {1}} count ['127x108','408','338','93x64','25mm'] > 0}) exitWith {
					_riflesTier4 pushBackUnique _class
				};
			};
			if (_class isKindOf ["Pistol",_cfgWeapons]) exitWith {
				if (count (_cfgEntry >> "LinkedItems") < 1) then {
					private _text = toLower getText (_cfgEntry >> 'descriptionShort');
					private _mags = getArray (_cfgEntry >> 'magazines');
					private _mag = _mags select 0;
					private _ammo = toLower getText (_cfgMagazines >> _mag >> "ammo");
					if ({if (_text find _x > -1) exitWith {1}} count ['9x19','9x21','.32','9x18'] > 0 or {{if (_ammo find _x > -1) exitWith {1}} count ['9x19','9x21','9x18'] > 0}) exitWith {
						_pistolsTier0 pushBack _class
					};
					if ({if (_text find _x > -1) exitWith {1}} count ['.45 acp','40mm','pp-2000'] > 0 or {{if (_ammo find _x > -1) exitWith {1}} count ['45acp','357','45gap','45super'] > 0}) exitWith {
						_pistolsTier1 pushBack _class
					};
				};
			};
			if (_class isKindOf ["Launcher",_cfgWeapons]) exitWith {
				if (toLower _class find "base" == -1) then {
					if (getNumber (_cfgEntry >> 'canLock') == 0) exitWith {
						_launchersTier0 pushBack _class
					};
					private _mag = (getArray (_cfgEntry >> 'magazines') select 0);
					private _ammo = getText (_cfgMagazines >> _mag >> "ammo");
					if (getNumber (configfile >> "CfgAmmo" >> _ammo >> "airLock") == 2) then {
						_launchersTier2 pushBack _class
					} else {
						_launchersTier1 pushBack _class
					};
					/*if (getNumber (_cfgEntry >> 'canLock') > 0) exitWith {
						_launchersTier1 pushBack _class
					};*/
				};
			};
			if (isClass (_cfgWeapons >> _class >> "ItemInfo")) exitWith {
				_cfgInfo = _cfgWeapons >> _class >> "ItemInfo";
				if (getNumber (_cfgInfo >> "type") == 101) exitWith {
					_barrelAttach pushBack _class
				};
				if (getNumber (_cfgInfo >> "type") == 201) exitWith {
					if (isClass (_cfgEntry >> "ItemInfo" >> "OpticsModes")) then {
						_cfgOpticsModes = _cfgEntry >> "ItemInfo" >> "OpticsModes";
						if (2000 call _fnc_greaterOrEqualRange
							or {'ti' call _fnc_scopeType}
							or {'nvg' call _fnc_scopeType}
						) exitWith {
							_scopesTier3 pushBack _class
						};
						if (1200 call _fnc_greaterOrEqualRange
							and {not (_class in _scopesTier3)}
						) exitWith {
							_scopesTier2 pushBack _class
						};
						if (300 call _fnc_greaterOrEqualRange
							and {not (_class in _scopesTier3)}
							and {not (_class in _scopesTier2)}
						) exitWith {
							_scopesTier1 pushBack _class
						};
						if (51 call _fnc_greaterOrEqualRange
							and {not (_class in _scopesTier3)}
							and {not (_class in _scopesTier2)}
							and {not (_class in _scopesTier1)}
						) exitWith {
							_scopesTier0 pushBack _class
						};
					};
				};
				if (getNumber (_cfgInfo >> "type") == 301) exitWith {
					if (isClass (configfile >> "CfgWeapons" >> _class >> "ItemInfo" >> "Pointer")) then {
						_sideAttachTier1 pushBack _class
					} else {
						_sideAttachTier0 pushBack _class
					};
				};
				if (getNumber (_cfgInfo >> "type") == 302) exitWith {
					_underAttach pushBack _class
				};
				if (getNumber (_cfgInfo >> "type") == 616) exitWith {
					_modes = getArray (_cfgEntry >> "visionMode");
					call {
						if ({_x == "ti"} count _modes > 0) exitWith {
							_headOpticsTier1 pushBack _class
						};
						_headOpticsTier0 pushBack _class
					};
				};
				if (getNumber (_cfgInfo >> "type") == 605) exitWith {
					_armour = getNumber (_cfgInfo >> 'HitpointsProtectionInfo' >> 'Head' >> 'armor');
					call {
						if (_armour >= 12) exitWith {
							_helmetsTier5 pushBack _class
						};
						if (_armour >= 10) exitWith {
							_helmetsTier4 pushBack _class
						};
						if (_armour >= 8) exitWith {
							_helmetsTier3 pushBack _class
						};
						if (_armour >= 6) exitWith {
							_helmetsTier2 pushBack _class
						};
						if (_armour >= 4) exitWith {
							_helmetsTier1 pushBack _class
						};
						if (_armour >= 0) exitWith {
							_helmetsTier0 pushBack _class
						};
					};
				};
				if (getNumber (_cfgInfo >> "type") == 701) exitWith {
					_armour = getNumber(_cfgInfo >> 'HitpointsProtectionInfo' >> 'Chest' >> 'armor');
					call {
						if (_armour >= 78) exitWith {
							_vestsTier6 pushBack _class
						};
						if (_armour >= 24) exitWith {
							_vestsTier5 pushBack _class
						};
						if (_armour >= 20) exitWith {
							_vestsTier4 pushBack _class
						};
						if (_armour >= 16) exitWith {
							_vestsTier3 pushBack _class
						};
						if (_armour >= 12) exitWith {
							_vestsTier2 pushBack _class
						};
						if (_armour >= 8) exitWith {
							_vestsTier1 pushBack _class
						};
						if (_armour >= 0) exitWith {
							_vestsTier0 pushBack _class
						};
					};
				};
				if (getNumber (_cfgInfo >> "type") == 801) exitWith {
					_armour = _class call _fnc_getUniformArmour;
					call {
						if (_armour >= 2064) exitWith {
							_uniformsTier4 pushBack _class
						};
						if (_armour >= 2048) exitWith {
							_uniformsTier3 pushBack _class
						};
						if (_armour >= 2030) exitWith {
							_uniformsTier2 pushBack _class
						};
						if (_armour >= 2024) exitWith {
							_uniformsTier1 pushBack _class
						};
						_uniformsTier0 pushBack _class
					};
				};
				if (_class isKindOf ["ItemBaseMedical",_cfgWeapons]) exitWith {
					if (_class == "ItemDefibrillator") then {
						_medicalTier1 pushBack _class
					} else {
						_medicalTier0 pushBack _class
					}
				};
				if (_class isKindOf ["ItemBaseFood",_cfgWeapons]) exitWith {
					_value = getNumber (_cfgWeapons >>  _class >> "horde_restore_health");
					call {
						if (_value >= 0.2) exitWith {
							_foodTier2 pushBack _class
						};
						if (_value >= 0.1) then {
							_foodTier1 pushBack _class
						} else {
							_foodTier0 pushBack _class
						};
					};
				};
				if (_class isKindOf ["ItemBaseDrink",_cfgWeapons]) exitWith {
					_drink pushBack _class
				};
				if (_class isKindOf ["ItemBaseTool",_cfgWeapons]) exitWith {
					_value = getNumber (_cfgInfo >> "mass");
					call {
						if (_value >= 30) exitWith {
							_toolsTier2 pushBack _class
						};
						if (_value >= 10) then {
							_toolsTier1 pushBack _class
						} else {
							_toolsTier0 pushBack _class
						};
					};
				};
				if (_class isKindOf ["ItemBaseTent",_cfgWeapons]) exitWith {
					_tents pushBack _class
				};
				if (_class isKindOf ["ItemSupply_Base",_cfgWeapons]) exitWith {
					_fuel pushBack _class
				};
				if (_class isKindOf ["ItemBasePass",_cfgWeapons]) exitWith {
					if (getText (_cfgWeapons >>  _class >> "horde_pass_color") == "master") then {
						_passesTier1 pushBack _class
					} else {
						_passesTier0 pushBack _class
					};
				};
				if (_class isKindOf ["ItemBaseRubbish",_cfgWeapons]) exitWith {
					_rubbish pushBack _class
				};
				// misc
				if (_class in ["ItemCompass","ItemGPS","ItemRadio","ItemMap","B_UavTerminal"]) exitWith {
					_miscItems pushBack _class
				};
			};
			if (_class isKindOf ["Binocular",_cfgWeapons]) exitWith {
				_modes = getArray (_cfgEntry >> "visionMode");
				call {
					if ({_x == "ti"} count _modes > 0) exitWith {
						_binosTier2 pushBack _class
					};
					if ({_x == "nvg"} count _modes > 0) exitWith {
						_binosTier1 pushBack _class
					};
					_binosTier0 pushBack _class
				};
			};
		};
	};
};

for "_i" from 0 to count _cfgMagazines - 1 do {
	_cfgEntry = _cfgMagazines select _i;
	if (isClass _cfgEntry
		and {getNumber (_cfgEntry >> "scope") == 2}
		and {getText (_cfgEntry >> "model") != ""}
		and {getText (_cfgEntry >> "picture") != ""}
	) then {
		_class = configName _cfgEntry;
		call {
			if (_class isKindOf ["StickyCharge_Remote_Mag",_cfgMagazines]) exitWith {
				_sticky pushBack _class
			};
			if (_class isKindOf ["CA_LauncherMagazine",_cfgMagazines]) exitWith {
				_rockets pushBack _class
			};
			if (getNumber (_cFgEntry >> "ncb_refill") == 1) exitWith {
				private _ammoType = getText (_cFgEntry >> "ammo");
				call{
					// bombs rockets
					if ({_ammoType isKindOf _x} count ["BombCore","RocketCore","MissileCore"] > 0) exitWith {
						_vehicleMagsTier3 pushBack _class
					};
					// cannon
					if ({_ammoType isKindOf _x} count ["ShellCore","B_19mm_HE","B_20mm","B_25mm","B_30mm_AP","Gatling_30mm_HE_Plane_CAS_01_F","B_35mm_AA"] > 0 or {{_class isKindOf [_x,_cfgMagazines]} count ["32Rnd_155mm_Mo_shells"] > 0}) exitWith {
						_vehicleMagsTier2 pushBack _class
					};
					// mg / grenades BulletCore GrenadeCore but not SmokeLauncherAmmo CMflareAmmo
					if ({_ammoType isKindOf _x} count ["BulletCore","GrenadeCore"] > 0 and {_ammoType isKindOf _x} count ["SmokeLauncherAmmo","CMflareAmmo"] == 0) exitWith {
						_vehicleMagsTier1 pushBack _class
					};
					// flares chaff laser etc 60Rnd_CMFlareMagazine
					_vehicleMagsTier0 pushBack _class
				};
			};
			if ({if ((getText (_cfgEntry >> 'descriptionShort')) find _x > -1) exitWith {1}} count ['9x19','.45 ACP','9x21','.32','9x18','303','9.3x62','5.7x28'] > 0 and {not (_class isKindOf ["VehicleMagazine",_cfgMagazines])}) exitWith {
				_magsTier0 pushBack _class
			};
			if ({if ((getText (_cfgEntry >> 'descriptionShort')) find _x > -1) exitWith {1}} count ['5.45x39','5.56x45','12 gauge'] > 0 and {not (_class isKindOf ["VehicleMagazine",_cfgMagazines])}) exitWith {
					_magsTier1 pushBack _class
			};
			if ({if ((getText (_cfgEntry >> 'descriptionShort')) find _x > -1) exitWith {1}} count ['6.5x39','7.62x39'] > 0 and {not (_class isKindOf ["VehicleMagazine",_cfgMagazines])}) exitWith {
				_magsTier2 pushBack _class
			};
			if ({if ((getText (_cfgEntry >> 'descriptionShort')) find _x > -1) exitWith {1}} count ['7.62x51','7.62x54','12.7x54','9x39','.308'] > 0 and {not (_class isKindOf ["VehicleMagazine",_cfgMagazines])}) exitWith {
				_magsTier3 pushBack _class
			};
			if ({if ((getText (_cfgEntry >> 'descriptionShort')) find _x > -1) exitWith {1}} count ['12.7x99','12.7x108','.408','9.3x64','.338','25mm caseless'] > 0 and {not (_class isKindOf ["VehicleMagazine",_cfgMagazines])}) exitWith {
				_magsTier4 pushBack _class
			};
			if (_class isKindOf ["Chemlight_green",_cfgMagazines]) exitWith {
				_chemlights pushBack _class
			};
			if (_class isKindOf ["SmokeShell",_cfgMagazines]) exitWith {
				_smokes pushBack _class
			};
			// (also includes smokeshells and chemlights so grabbed above
			if (_class isKindOf ["HandGrenade",_cfgMagazines]) exitWith {
				_grenades pushBack _class
			};
			if (_class isKindOf ["MiniGrenade",_cfgMagazines]) exitWith {
				_grenades pushBack _class
			};
			if (_class isKindOf ["UGL_FlareWhite_F",_cfgMagazines]) exitWith {
				_flares pushBack _class
			};
			// also includes flares
			if (_class isKindOf ["1Rnd_HE_Grenade_shell",_cfgMagazines]) exitWith {
				_ugls pushBack _class
			};
		};
	};
};

for "_i" from 0 to count _cfgVehicles - 1 do {
	_cfgEntry = _cfgVehicles select _i;
	if (isClass _cfgEntry
		and {getNumber (_cfgEntry >> "scope") == 2}
		and {getText (_cfgEntry >> "model") != ""}
		and {getText (_cfgEntry >> "picture") != ""}
	) then {
		_class = configName _cfgEntry;
		call {
			if (_class isKindOf "Bag_Base") exitWith {
				// filter for
				if (getNumber (_cfgEntry >> 'maximumLoad') > 0) then {
					if (count (_cfgEntry >> 'TransportItems') == 0
						and {count (_cfgEntry >> 'TransportMagazines') == 0}
						and {count (_cfgEntry >> 'TransportWeapons') == 0}
					) then {
						_load = getNumber (_cfgEntry >> 'maximumLoad');
						call {
							if (_load >= 320) exitWith {
								_backpacksTier4 pushBack _class
							};
							if (_load >= 280) exitWith {
								_backpacksTier3 pushBack _class
							};
							if (_load >= 240) exitWith {
								_backpacksTier2 pushBack _class
							};
							if (_load >= 200) exitWith {
								_backpacksTier1 pushBack _class
							};
							/*if (_load >= 160) exitWith {*/
								_backpacksTier0 pushBack _class
							/*};*/
						};
					};
				} else {
					if (_class == "PortableGenerator_backpack_F"
						or {_class == "ParaBeacon_backpack_F"}
					) then {
						_miscItems pushBack _class
					} else {
						if (_class isKindOf "Horde_VehiclePartsBag_Base") then {
							_value = parseNumber (_class select [(_class find "_") + 1,99]);
							call {
								if (_value >= 80) exitWith {
									_vehiclePartsTier3 pushBack _class
								};
								if (_value >= 50) exitWith {
									_vehiclePartsTier2 pushBack _class
								};
								if (_value >= 30) exitWith {
									_vehiclePartsTier1 pushBack _class
								};
								if (_value >= 10) exitWith {
									_vehiclePartsTier0 pushBack _class
								};
							};
						};
						if (_class isKindOf "Horde_AircraftPartsBag_Base") then {
							_value = parseNumber (_class select [(_class find "_") + 1,99]);
							call {
								if (_value >= 80) exitWith {
									_aircraftPartsTier3 pushBack _class
								};
								if (_value >= 50) exitWith {
									_aircraftPartsTier2 pushBack _class
								};
								if (_value >= 30) exitWith {
									_aircraftPartsTier1 pushBack _class
								};
								if (_value >= 10) exitWith {
									_aircraftPartsTier0 pushBack _class
								};
							};
						};
						if (_class isKindOf "ncb_weaponbag_base") then {
							_weaponBags pushBack _class
						};
						if (_class isKindOf "ncb_weaponbag_tripod") then {
							_weaponBags pushBack _class
						};
					};
				};
			};
		};
	};
};

for "_i" from 0 to count _cfgGlasses - 1 do {
	_cfgEntry = _cfgGlasses select _i;
	if (isClass _cfgEntry
		and {getNumber (_cfgEntry >> "scope") == 2}
		and {getText (_cfgEntry >> "model") != ""}
		and {getText (_cfgEntry >> "picture") != ""}
	) then {
		_class = configName _cfgEntry;
		if (getNumber (_cfgEntry >> "scopeArsenal") == 2) then {
			_badGuyShades pushBack _class
		} else {
			_shades pushBack _class
		};
	};
};

// test section (add sides to each class) - so array would look like

// [["class1",[0,1,2]],["class1",[0]]]

// only need to do this for rifles,pistols,launchers,attachments


// build array of east, indy and west units

// update this!  need to do mags after weaps assigned?  also

_fnc_getConfig = {
	if (isClass (_cfgWeapons >>  _this)) exitWith {
		_cfgWeapons >>  _this
	};
	if (isClass (_cfgMagazines >> _this)) exitWith {
		_cfgMagazines >> _this
	};
	if (isClass (_cfgVehicles >> _this)) exitWith {
		_cfgVehicles >> _this
	};
	if (isClass (_cfgGlasses >> _this)) exitWith {
		_cfgGlasses >> _this
	};
};

_eastMenCfgArr = "configName _x isKindOf 'CAManBase' and {getNumber (_x >> 'scope') == 2} and {getNumber (_x >> 'side') == 0} and {getText (_x >> 'model') != ''} and {not (getText (_x >> 'faction') == 'OPF_G_F')}" configClasses (configFile >> "CfgVehicles");

_eastEquipment = [];
{
	{
		private _weap = _x call _fnc_getWeaponParent;
		_eastEquipment pushBackUnique _weap;
		{
			_eastEquipment pushBackUnique _x
		} forEach (getArray (_cfgWeapons >> _x >> "magazines"));
		_cfgLinkedItems = _cfgWeapons >> _x  >> "LinkedItems";
		if (count _cfgLinkedItems > 0) then {
			for "_i" from 0 to count _cfgLinkedItems - 1 do {
				_slot = _cfgLinkedItems select _i;
				/*diag_log format ["slot %1",_slot];*/
				/*diag_log format ["slot %1",configName _slot];*/
				/*_txt = getText (_slot >> "item");*/
				/*diag_log format ["item %1",configName _txt];*/
				_eastEquipment pushBackUnique (getText (_slot >> "item"));
			};
		};
		_muzzles = getArray (_cfgWeapons >> _x  >> "muzzles");
		if (count _muzzles > 1) then {
			{
				_eastEquipment pushBackUnique _x;
			} forEach (getArray (_cfgWeapons >> _x >> (_muzzles select 1) >> "magazines"));
		}
	} forEach (getArray (_x >> "weapons"));
	{
		_eastEquipment pushBackUnique _x;
	} forEach (getArray (_x >> "magazines"));
	{
		_eastEquipment pushBackUnique _x;
	} forEach (getArray (_x >> "linkedItems"));
	{
		_eastEquipment pushBackUnique _x;
	} forEach (getArray (_x >> "allowedHeadgear")); // headgearList
	_eastEquipment pushBackUnique (getText (_x >> "backpack"));
	_eastEquipment pushBackUnique (getText (_x >> "uniformClass"));
} forEach _eastMenCfgArr;

_westMenCfgArr = "configName _x isKindOf 'CAManBase' and {getNumber (_x >> 'scope') == 2} and {getNumber (_x >> 'side') == 1} and {getText (_x >> 'model') != ''} and {not (getText (_x >> 'faction') == 'BLU_G_F')}" configClasses (configFile >> "CfgVehicles");

_westEquipment = [];
{
	{
		private _weap = _x call _fnc_getWeaponParent;
		_westEquipment pushBackUnique _weap;
		{
			_westEquipment pushBackUnique _x
		} forEach (getArray (_cfgWeapons >> _x >> "magazines"));
		_cfgLinkedItems = _cfgWeapons >> _x  >> "LinkedItems";
		if (count _cfgLinkedItems > 0) then {
			for "_i" from 0 to count _cfgLinkedItems - 1 do {
				_slot = _cfgLinkedItems select _i;
				_westEquipment pushBackUnique (getText (_slot >> "item"));
			};
		};
		_muzzles = getArray (_cfgWeapons >> _x  >> "muzzles");
		if (count _muzzles > 1) then {
			{
				_westEquipment pushBackUnique _x;
			} forEach (getArray (_cfgWeapons >> _x >> (_muzzles select 1) >> "magazines"));
		}
	} forEach (getArray (_x >> "weapons"));
	{
		_westEquipment pushBackUnique _x;
	} forEach (getArray (_x >> "magazines"));
	{
		_westEquipment pushBackUnique _x;
	} forEach (getArray (_x >> "linkedItems"));
	{
		_westEquipment pushBackUnique _x;
	} forEach (getArray (_x >> "allowedHeadgear")); // headgearList
	_westEquipment pushBackUnique (getText (_x >> "backpack"));
	_westEquipment pushBackUnique (getText (_x >> "uniformClass"));
} forEach _westMenCfgArr;

_indyMenCfgArr = "configName _x isKindOf 'CAManBase' and {getNumber (_x >> 'scope') == 2} and {getNumber (_x >> 'side') == 2} and {getText (_x >> 'model') != ''}" configClasses (configFile >> "CfgVehicles");

_indyEquipment = [];
{
	{
		private _weap = _x call _fnc_getWeaponParent;
		_indyEquipment pushBackUnique _weap;
		{
			_indyEquipment pushBackUnique _x
		} forEach (getArray (_cfgWeapons >> _x >> "magazines"));
		_cfgLinkedItems = _cfgWeapons >> _x  >> "LinkedItems";
		if (count _cfgLinkedItems > 0) then {
			for "_i" from 0 to count _cfgLinkedItems - 1 do {
				_slot = _cfgLinkedItems select _i;
				_indyEquipment pushBackUnique (getText (_slot >> "item"));
			};
		};
		_muzzles = getArray (_cfgWeapons >> _x  >> "muzzles");
		if (count _muzzles > 1) then {
			{
				_indyEquipment pushBackUnique _x;
			} forEach (getArray (_cfgWeapons >> _x >> (_muzzles select 1) >> "magazines"));
		}
	} forEach (getArray (_x >> "weapons"));
	{
		_indyEquipment pushBackUnique _x;
	} forEach (getArray (_x >> "magazines"));
	{
		_indyEquipment pushBackUnique _x;
	} forEach (getArray (_x >> "linkedItems"));
	{
		_indyEquipment pushBackUnique _x;
	} forEach (getArray (_x >> "allowedHeadgear")); // headgearList
	_indyEquipment pushBackUnique (getText (_x >> "backpack"));
	_indyEquipment pushBackUnique (getText (_x >> "uniformClass"));
} forEach _indyMenCfgArr;

{
	_arr = _x;
	{
		_item = _x;
		if not (_item isEqualTo "autoAdd") then {
			/*diag_log format ["item: %1",_item];*/
			_cfgItem = _item call _fnc_getConfig;
			_allowedSides = [];
			_arrIndex = _forEachIndex;
			{
				_sideEquipment = _x;
				_side = _forEachIndex;
				call {
					if ({_item isKindOf [_x,_cfgWeapons]} count _sideEquipment > 0) exitWith {
						_allowedSides pushBack _side
					};
					/*if ({_item isKindOf [_x,_cfgMagazines] or {_x isKindOf [_item,_cfgMagazines]}} count _sideEquipment > 0) exitWith {
						_allowedSides pushBack _side
					};*/
					if ({_item isKindOf [_x,_cfgMagazines]} count _sideEquipment > 0) exitWith {
						_allowedSides pushBack _side
					};
					if ({_item isKindOf _x or {_x isKindOf _item}} count _sideEquipment > 0) exitWith {
						_allowedSides pushBack _side
					};
					/*if ({_item isKindOf _x} count _sideEquipment > 0) exitWith {
						_allowedSides pushBack _side
					};*/
					/*if ({_item isKindOf [_x,_cfgGlasses] or {_x isKindOf [_item,_cfgGlasses]}} count _sideEquipment > 0) exitWith {
						_allowedSides pushBack _side
					};*/
					if ({_item isKindOf [_x,_cfgGlasses]} count _sideEquipment > 0) exitWith {
						_allowedSides pushBack _side
					};
				};
			} forEach [_eastEquipment,_indyEquipment,_westEquipment]; // sides
			if not (_allowedSides isEqualTo []) then {
				_arr set [_arrIndex,[_item,_allowedSides]]
			} else {
				// if no-one uses this rifle, then check if another one of it's family are being used
				if (_item isKindOf ["RifleCore",_cfgWeapons]) then {
					_fnc_findBase = {
						private _base = "";
						while {!isNull _this} do {
							if (toLower configName _this find "base" > -1) exitWith {
								_base = configName _this
							};
							_this = inheritsFrom _this;
						};
						_base
					};
					_base = (_cfgWeapons >> _item) call _fnc_findBase;
					if (_base != "") then {
						scopeName "esc";
						{
							if (_x isEqualType []) then {
								_x params ["_item2","_allowedSides2"];
								_base2 = (_cfgWeapons >> _item2) call _fnc_findBase;
								if (_base == _base2) then {
									_arr set [_arrIndex,[_item,_allowedSides2]];
									diag_log "----------------";
									diag_log format ["found common base class: %1",_item];
									diag_log format ["base: %1",_base];
									diag_log format ["allowedSides2: %1",_allowedSides2];
									breakTo "esc"
								}
							} else {
								_arr set [_arrIndex,[_item,[3]]];
								breakTo "esc"
							}
						} forEach _arr;
					}
				} else {
					_arr set [_arrIndex,[_item,[3]]]
				};
			};
		};
	} forEach _arr;
	if (_arr select 0 isEqualTo "autoAdd") then {
		_arr deleteAt 0;
		{
			_arr select _forEachIndex params ["_item","_allowedSides"];
			if (_allowedSides isEqualTo [3]) then {
				_arr set [_forEachIndex,[_item,[4]]]
			};
		} forEach _arr;
	};
} forEach [
	_riflesTier0,
	_riflesTier1,
	_riflesTier2,
	_riflesTier3,
	_riflesTier4,
	_pistolsTier0,
	_pistolsTier1,
	_launchersTier0,
	_launchersTier1,
	_launchersTier2,
	_barrelAttach,
	_scopesTier0,
	_scopesTier1,
	_scopesTier2,
	_scopesTier3,
	_sideAttachTier0,
	_sideAttachTier1,
	_underAttach,
	_headOpticsTier0,
	_headOpticsTier1,
	_helmetsTier0,
	_helmetsTier1,
	_helmetsTier2,
	_helmetsTier3,
	_helmetsTier4,
	_helmetsTier5,
	_vestsTier0,
	_vestsTier1,
	_vestsTier2,
	_vestsTier3,
	_vestsTier4,
	_vestsTier5,
	_vestsTier6,
	_uniformsTier0,
	_uniformsTier1,
	_uniformsTier2,
	_uniformsTier3,
	_uniformsTier4,
	_binosTier0,
	_binosTier1,
	_binosTier2,
	_medicalTier0,
	_medicalTier1,
	_foodTier0,
	_foodTier1,
	_foodTier2,
	_drink,
	_rubbish,
	_toolsTier0,
	_toolsTier1,
	_toolsTier2,
	_tents,
	_fuel,
	_passesTier0,
	_passesTier1,
	_miscItems,
	_sticky,
	_rockets,
	_vehicleMagsTier0,
	_vehicleMagsTier1,
	_vehicleMagsTier2,
	_vehicleMagsTier3,
	_magsTier0,
	_magsTier1,
	_magsTier2,
	_magsTier3,
	_magsTier4,
	_grenades,
	_ugls,
	_smokes,
	_chemLights,
	_flares,
	_backpacksTier0,
	_backpacksTier1,
	_backpacksTier2,
	_backpacksTier3,
	_backpacksTier4,
	_vehiclePartsTier0,
	_vehiclePartsTier1,
	_vehiclePartsTier2,
	_vehiclePartsTier3,
	_aircraftPartsTier0,
	_aircraftPartsTier1,
	_aircraftPartsTier2,
	_aircraftPartsTier3,
	_weaponBags,
	_badGuyShades,
	_shades
];

diag(_riflesTier0);
diag(_riflesTier1);
diag(_riflesTier2);
diag(_riflesTier3);
diag(_riflesTier4);
diag(_pistolsTier0);
diag(_pistolsTier1);
diag(_launchersTier0);
diag(_launchersTier1);
diag(_launchersTier2);
diag(_barrelAttach);
diag(_scopesTier0);
diag(_scopesTier1);
diag(_scopesTier2);
diag(_scopesTier3);
diag(_sideAttachTier0);
diag(_sideAttachTier1);
diag(_underAttach);
diag(_headOpticsTier0);
diag(_headOpticsTier1);
diag(_helmetsTier0);
diag(_helmetsTier1);
diag(_helmetsTier2);
diag(_helmetsTier3);
diag(_helmetsTier4);
diag(_helmetsTier5);
diag(_vestsTier0);
diag(_vestsTier1);
diag(_vestsTier2);
diag(_vestsTier3);
diag(_vestsTier4);
diag(_vestsTier5);
diag(_vestsTier6);
diag(_uniformsTier0);
diag(_uniformsTier1);
diag(_uniformsTier2);
diag(_uniformsTier3);
diag(_uniformsTier4);
diag(_binosTier0);
diag(_binosTier1);
diag(_binosTier2);
diag(_medicalTier0);
diag(_medicalTier1);
diag(_foodTier0);
diag(_foodTier1);
diag(_foodTier2);
diag(_drink);
diag(_toolsTier0);
diag(_toolsTier1);
diag(_toolsTier2);
diag(_tents);
diag(_fuel);
diag(_passesTier0);
diag(_passesTier1);
diag(_miscItems);
diag(_sticky);
diag(_rockets);
diag(_vehicleMagsTier0);
diag(_vehicleMagsTier1);
diag(_vehicleMagsTier2);
diag(_vehicleMagsTier3);
diag(_magsTier0);
diag(_magsTier1);
diag(_magsTier2);
diag(_magsTier3);
diag(_magsTier4);
diag(_grenades);
diag(_ugls);
diag(_smokes);
diag(_chemLights);
diag(_flares);
diag(_backpacksTier0);
diag(_backpacksTier1);
diag(_backpacksTier2);
diag(_backpacksTier3);
diag(_backpacksTier4);
diag(_vehiclePartsTier0);
diag(_vehiclePartsTier1);
diag(_vehiclePartsTier2);
diag(_vehiclePartsTier3);
diag(_aircraftPartsTier0);
diag(_aircraftPartsTier1);
diag(_aircraftPartsTier2);
diag(_aircraftPartsTier3);
diag(_weaponBags);
diag(_badGuyShades);
diag(_shades);

uiNamespace setVariable ["ncb_uv_masterRiflesTier_0",_riflesTier0];
uiNamespace setVariable ["ncb_uv_masterRiflesTier_1",_riflesTier1];
uiNamespace setVariable ["ncb_uv_masterRiflesTier_2",_riflesTier2];
uiNamespace setVariable ["ncb_uv_masterRiflesTier_3",_riflesTier3];
uiNamespace setVariable ["ncb_uv_masterRiflesTier_4",_riflesTier4];
uiNamespace setVariable ["ncb_uv_masterPistolsTier_0",_pistolsTier0];
uiNamespace setVariable ["ncb_uv_masterPistolsTier_1",_pistolsTier1];
uiNamespace setVariable ["ncb_uv_masterLaunchersTier_0",_launchersTier0];
uiNamespace setVariable ["ncb_uv_masterLaunchersTier_1",_launchersTier1];
uiNamespace setVariable ["ncb_uv_masterLaunchersTier_2",_launchersTier2];
uiNamespace setVariable ["ncb_uv_masterBarrelAttachments",_barrelAttach];
uiNamespace setVariable ["ncb_uv_masterScopesTier_0",_scopesTier0];
uiNamespace setVariable ["ncb_uv_masterScopesTier_1",_scopesTier1];
uiNamespace setVariable ["ncb_uv_masterScopesTier_2",_scopesTier2];
uiNamespace setVariable ["ncb_uv_masterScopesTier_3",_scopesTier3];
uiNamespace setVariable ["ncb_uv_masterSideAttachmentsTier_0",_sideAttachTier0];
uiNamespace setVariable ["ncb_uv_masterSideAttachmentsTier_1",_sideAttachTier1];
uiNamespace setVariable ["ncb_uv_masterUnderBarrelAttachments",_underAttach];
uiNamespace setVariable ["ncb_uv_masterHeadOpticsTier_0",_headOpticsTier0];
uiNamespace setVariable ["ncb_uv_masterHeadOpticsTier_1",_headOpticsTier1];
uiNamespace setVariable ["ncb_uv_masterHelmetsTier_0",_helmetsTier0];
uiNamespace setVariable ["ncb_uv_masterHelmetsTier_1",_helmetsTier1];
uiNamespace setVariable ["ncb_uv_masterHelmetsTier_2",_helmetsTier2];
uiNamespace setVariable ["ncb_uv_masterHelmetsTier_3",_helmetsTier3];
uiNamespace setVariable ["ncb_uv_masterHelmetsTier_4",_helmetsTier4];
uiNamespace setVariable ["ncb_uv_masterHelmetsTier_5",_helmetsTier5];
uiNamespace setVariable ["ncb_uv_masterVestsTier_0",_vestsTier0];
uiNamespace setVariable ["ncb_uv_masterVestsTier_1",_vestsTier1];
uiNamespace setVariable ["ncb_uv_masterVestsTier_2",_vestsTier2];
uiNamespace setVariable ["ncb_uv_masterVestsTier_3",_vestsTier3];
uiNamespace setVariable ["ncb_uv_masterVestsTier_4",_vestsTier4];
uiNamespace setVariable ["ncb_uv_masterVestsTier_5",_vestsTier5];
uiNamespace setVariable ["ncb_uv_masterVestsTier_6",_vestsTier6];
uiNamespace setVariable ["ncb_uv_masterUniformsTier_0",_uniformsTier0];
uiNamespace setVariable ["ncb_uv_masterUniformsTier_1",_uniformsTier1];
uiNamespace setVariable ["ncb_uv_masterUniformsTier_2",_uniformsTier2];
uiNamespace setVariable ["ncb_uv_masterUniformsTier_3",_uniformsTier3];
uiNamespace setVariable ["ncb_uv_masterUniformsTier_4",_uniformsTier4];
uiNamespace setVariable ["ncb_uv_masterBinosTier_0",_binosTier0];
uiNamespace setVariable ["ncb_uv_masterBinosTier_1",_binosTier1];
uiNamespace setVariable ["ncb_uv_masterBinosTier_2",_binosTier2];
uiNamespace setVariable ["ncb_uv_masterMedicalItemsTier_0",_medicalTier0];
uiNamespace setVariable ["ncb_uv_masterMedicalItemsTier_1",_medicalTier1];
uiNamespace setVariable ["ncb_uv_masterFoodItemsTier_0",_foodTier0];
uiNamespace setVariable ["ncb_uv_masterFoodItemsTier_1",_foodTier1];
uiNamespace setVariable ["ncb_uv_masterFoodItemsTier_2",_foodTier2];
uiNamespace setVariable ["ncb_uv_masterDrinkItems",_drink];
uiNamespace setVariable ["ncb_uv_masterRubbishItems",_rubbish];
uiNamespace setVariable ["ncb_uv_masterToolItemsTier_0",_toolsTier0];
uiNamespace setVariable ["ncb_uv_masterToolItemsTier_1",_toolsTier1];
uiNamespace setVariable ["ncb_uv_masterToolItemsTier_2",_toolsTier2];
uiNamespace setVariable ["ncb_uv_masterTentItems",_tents];
uiNamespace setVariable ["ncb_uv_masterFuelItems",_fuel];
uiNamespace setVariable ["ncb_uv_masterPassesTier_0",_passesTier0];
uiNamespace setVariable ["ncb_uv_masterPassesTier_1",_passesTier1];
uiNamespace setVariable ["ncb_uv_masterMiscItems",_miscItems];
uiNamespace setVariable ["ncb_uv_masterStickyBombs",_sticky];
uiNamespace setVariable ["ncb_uv_masterRockets",_rockets];
uiNamespace setVariable ["ncb_uv_masterVehicleMagsTier_0",_vehicleMagsTier0];
uiNamespace setVariable ["ncb_uv_masterVehicleMagsTier_1",_vehicleMagsTier1];
uiNamespace setVariable ["ncb_uv_masterVehicleMagsTier_2",_vehicleMagsTier2];
uiNamespace setVariable ["ncb_uv_masterVehicleMagsTier_3",_vehicleMagsTier3];
uiNamespace setVariable ["ncb_uv_masterMagsTier_0",_magsTier0];
uiNamespace setVariable ["ncb_uv_masterMagsTier_1",_magsTier1];
uiNamespace setVariable ["ncb_uv_masterMagsTier_2",_magsTier2];
uiNamespace setVariable ["ncb_uv_masterMagsTier_3",_magsTier3];
uiNamespace setVariable ["ncb_uv_masterMagsTier_4",_magsTier4];
uiNamespace setVariable ["ncb_uv_masterGrenades",_grenades];
uiNamespace setVariable ["ncb_uv_masterUGLs",_ugls];
uiNamespace setVariable ["ncb_uv_masterSmokes",_smokes];
uiNamespace setVariable ["ncb_uv_masterChemLights",_chemlights];
uiNamespace setVariable ["ncb_uv_masterFlares",_flares];
uiNamespace setVariable ["ncb_uv_masterBackPacksTier_0",_backpacksTier0];
uiNamespace setVariable ["ncb_uv_masterBackPacksTier_1",_backpacksTier1];
uiNamespace setVariable ["ncb_uv_masterBackPacksTier_2",_backpacksTier2];
uiNamespace setVariable ["ncb_uv_masterBackPacksTier_3",_backpacksTier3];
uiNamespace setVariable ["ncb_uv_masterBackPacksTier_4",_backpacksTier4];
uiNamespace setVariable ["ncb_uv_masterVehiclePartsTier_0",_vehiclePartsTier0];
uiNamespace setVariable ["ncb_uv_masterVehiclePartsTier_1",_vehiclePartsTier1];
uiNamespace setVariable ["ncb_uv_masterVehiclePartsTier_2",_vehiclePartsTier2];
uiNamespace setVariable ["ncb_uv_masterVehiclePartsTier_3",_vehiclePartsTier3];
uiNamespace setVariable ["ncb_uv_masterAircraftPartsTier_0",_aircraftPartsTier0];
uiNamespace setVariable ["ncb_uv_masterAircraftPartsTier_1",_aircraftPartsTier1];
uiNamespace setVariable ["ncb_uv_masterAircraftPartsTier_2",_aircraftPartsTier2];
uiNamespace setVariable ["ncb_uv_masterAircraftPartsTier_3",_aircraftPartsTier3];
uiNamespace setVariable ["ncb_uv_masterAircraftParts",_aircraftParts];
uiNamespace setVariable ["ncb_uv_masterWeaponBags",_weaponBags];
uiNamespace setVariable ["ncb_uv_masterBadGuyShades",_badGuyShades];
uiNamespace setVariable ["ncb_uv_masterShades",_shades];

// makes lists of compatible magazines for each ammo class

diag_log "-----------------------------------------";
diag_log "-----------ammo compatibility------------";
diag_log "-----------------------------------------";

_cfgAmmo = configFile >> "CfgAmmo";
_cfgMags = configFile >> "CfgMagazines";
for "_i" from 0 to (count _cfgAmmo - 1) do {
	_cfgAmmoEntry = _cfgAmmo select _i;
	_ammoClass = configName _cfgAmmoEntry;
	if (isClass _cfgAmmoEntry) then {
		if ({if (_ammoClass isKindOf _x) exitWith {1}} count ["BulletBase","ShotgunBase","F_40mm_White","G_40mm_HE","G_40mm_Smoke"] > 0
			and {toLower _ammoClass find "base" == -1}
		) then {
			_arr = [];
			// iterate through cfgMags
			for "_j" from 0 to count _cfgMags - 1 do {
				_cfgMagEntry = _cfgMags select _j;
				_magClass = configName _cfgMagEntry;
				_isVehicleMag = _magClass isKindOf ["VehicleMagazine",_cfgMags];
				if (isClass _cfgMagEntry
					and {getNumber (_cfgMagEntry >> "scope") == 2}
					and {getText (_cfgMagEntry >> "model") != ""}
					and {getText (_cfgMagEntry >> "picture") != ""}
					and {getText (_cfgMagEntry >> "ammo") == _ammoClass}
					//and {
					//	getText (_cfgMagEntry >> "ammo") isKindOf _ammoClass
					//	or {
					//		_ammoClass isKindOf (getText (_cfgMagEntry >> "ammo"))
					//	}
					//}
					and {
						not _isVehicleMag
						or {_isVehicleMag and {getNumber (_cfgMagEntry >> "ncb_refill") == 1}}
					}
				) then {
					_arr pushBack _magClass;
				};
			};
			uiNamespace setVariable ["ncb_uv_ammoMags_" + _ammoClass,_arr];
			diag_log format ["AMMO: '%1' : MAGS: %2",_ammoClass,_arr];
		};
	};
};

diag_log "-----------------------------------------";
diag_log "-----------------------------------------";

true