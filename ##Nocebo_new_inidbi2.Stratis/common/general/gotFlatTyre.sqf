#include "\nocebo\defines\scriptDefines.hpp"

scopeName "0";
private _flat = false;
private _cfg = configFile >> "CfgVehicles" >> typeOf _this >> "Wheels";
private _countWheels = count _cfg;
if (_countWheels > 0) then {
	for "_i" from 0 to _countWheels - 1 do {
		private _center = getText(sel(_cfg,_i) >> "center");
		private _sel = (_center select [0,9]) + "_steering";
		private _dam = _this getHit _sel;
		if not(isNil "_dam") then {
			if (_dam == 1) then {
				_flat = true;
				breakTo "0"
			};
		};
	};
};
_flat