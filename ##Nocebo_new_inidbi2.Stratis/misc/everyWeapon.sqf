// ex 0 = [this,1,10,0,true] call horde_fnc_everyWeapon;

private ["_box","_countWeapons","_countMags","_countItems","_fill","_cfgMagazines","_cfgWeapons","_root","_weaponRoots","_cfgEntry","_isWeapon","_cfgParent","_magRoots","_isMag","_itemRoots","_isItem"];

if (isServer) then {
	_box = _this select 0;
	_countWeapons = _this select 1;
	_countMags = _this select 2;
	_countItems = _this select 3;
	_fill = _this select 4;

	if (not _fill) exitWith {};

	clearMagazineCargo _box;
	clearWeaponCargo _box;

	_cfgMagazines = configFile >> "CfgMagazines";
	_cfgWeapons = configFile >> "CfgWeapons";

	if (_countWeapons > 0) then {
		for "_i" from 0 to count _cfgWeapons - 1 do {
			_cfgEntry = _cfgWeapons select _i;
			_className = configName _cfgEntry;
			if (isClass _cfgEntry) then {
				if (_className isKindOf ["Rifle",_cfgWeapons]
					or {_className isKindOf ["Pistol",_cfgWeapons]}
					or {_className isKindOf ["Launcher",_cfgWeapons]}
				) then {
					// only add classes without attachments
					if (count (_cfgEntry >> "LinkedItems") < 1
						and {getNumber (_cfgEntry >> "scope") == 2}
						and {getText (_cfgEntry >> "picture") != ""}
					) then {
						_box addWeaponCargoGlobal [_className,_countWeapons];
					};
				};
			};
		};
	};

	if (_countMags > 0) then {
		for "_i" from 0 to (count _cfgMagazines - 1) do {
			_cfgEntry = _cfgMagazines select _i;
			_className = configName _cfgEntry;
			if (isClass _cfgEntry) then {
				if (_className isKindOf ["CA_Magazine",_cfgMagazines]) then {
					// only add classes without attachments
					if (getNumber (_cfgEntry >> "scope") == 2
						and {getText (_cfgEntry >> "picture") != ""}
					) then {
						_box addMagazineCargoGlobal [_className,_countMags];
					};
				};
			};
		};
	};

	if (_countItems > 0) then {
		for "_i" from 0 to (count _cfgWeapons - 1) do {
			_cfgEntry = _cfgWeapons select _i;
			_className = configName _cfgEntry;
			if (isClass _cfgEntry) then {
				if (_className isKindOf ["ItemCore",_cfgWeapons]) then {
					// only add classes without attachments
					if (getNumber (_cfgEntry >> "scope") == 2
						and {getText (_cfgEntry >> "picture") != ""}
					) then {
						_box addItemCargoGlobal [_className,_countItems];
					};
				};
			};
		};
	};
};



