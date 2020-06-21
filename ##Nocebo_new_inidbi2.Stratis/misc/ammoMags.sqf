// makes lists of compatible magazines for each ammo class

_cfgAmmo = configFile >> "CfgAmmo";
_cfgMagazines = configFile >> "CfgMagazines";

for "_i" from 0 to (count _cfgAmmo - 1) do {
	_cfgAmmoEntry = _cfgAmmo select _i;
	_ammoClassName = configName _cfgAmmoEntry;
	if (isClass _cfgAmmoEntry) then {
		if (_ammoClassName isKindOf "BulletBase"
			and {toLower _ammoClassName find "base" == -1}
		) then {
			_arr = [];
			// iterate through cfgMags
			for "_j" from 0 to count _cfgMagazines - 1 do {
				_cfgMagEntry = _cfgMagazines select _j;
				if (isClass _cfgMagEntry
					and {getNumber (_cfgMagEntry >> "scope") == 2}
					and {getText (_cfgMagEntry >> "model") != ""}
					and {getText (_cfgMagEntry >> "picture") != ""}
					and {getText (_cfgMagEntry >> "ammo") == _ammoClassName}
				) then {
					_arr pushBack configName _cfgMagEntry;
				};
			};
			missionNamespace setVariable ["ncb_gv_ammoMags_" + _ammoClassName,_arr];
			diag_log format ["'%1' - %2",_ammoClassName,_arr];
		};
	};
};



