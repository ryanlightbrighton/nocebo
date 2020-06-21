#include "\nocebo\defines\scriptDefines.hpp"

params ["_unit","_container","_item"];

if (_container isEqualTo (vestContainer _unit)
	or {_container isEqualTo (uniformContainer _unit)}
	or {_container isEqualTo (backPackContainer _unit)}
) then {
	private _cfgMags = configFile >> "CfgMagazines";
	private _cfgMag = _cfgMags >> _item;
	if (isClass _cfgMag) then {
		private _ok = true;
		if (_item isKindOf ["HandGrenade",_cfgMags]
			or {_item isKindOf ["1Rnd_HE_Grenade_shell",_cfgMags]}
			or {_item isKindOf ["CA_LauncherMagazine",_cfgMags]}
		) then {
			if (random 1 < 0.5) then {
				_ok = false
			};
		};
		if (_ok) then {
			_count = getNumber(_cfgMag >> "count");
			if (_count != 1) then {
				_unit addMagazine [_item,randInteg(1,_count)];
			} else {
				_unit addMagazines [_item,1];
			};
		}
	};
};
true