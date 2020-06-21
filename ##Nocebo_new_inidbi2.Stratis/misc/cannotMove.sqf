#include "\nocebo\defines\scriptDefines.hpp"

// vehicle must have VehicleInteractionInfo !

private _cannotMove = false;
private _hitpoints = _this getVariable ["ncb_hitpoints",[]];
if ([] isEqualTo _hitpoints) then {
	{
		private _hitpoint = toLower getText (_x >> "location");
		if (_hitpoint find "wheel" > -1) then {
			_hitpoints pushBack _hitpoint;
		    if (_this getHitPointDamage _hitpoint == 1) then {
				_cannotMove = true
			}
		};
		if (_hitpoint == "hitengine") then {
			_hitpoints pushBack _hitpoint;
		    if (_this getHitPointDamage _hitpoint >= 0.9) then {
				_cannotMove = true
			}
		}
	} count ("toLower configName _x find 'wheel' > -1 or {toLower configName _x find 'engine' > -1}" configClasses (configFile >> "CfgVehicles" >> typeOf _this >> "VehicleInteractionInfo"));
	_this setVariable ["ncb_hitpoints",_hitpoints];
} else {
	{
		if (_x find "wheel" > -1
		    and {_this getHitPointDamage _x == 1}
		) exitWith {
			_cannotMove = true
		};
		if (_x == "hitengine"
		    and {_this getHitPointDamage _x >= 0.9}
		) exitWith {
			_cannotMove = true
		}
	} count _hitpoints;
};
_cannotMove

/*private _cannotMove = false;
{
	private _hitpoint = getText (_x >> "location");
	if (toLower _hitpoint find "wheel" > -1
	    and {_this getHitPointDamage _hitpoint == 1}
	) exitWith {
		_cannotMove = true
	};
	if (_hitpoint == "hitengine"
	    and {_this getHitPointDamage _hitpoint >= 0.9}
	) exitWith {
		_cannotMove = true
	}
} count ("toLower configName _x find 'wheel' > -1 or {toLower configName _x find 'engine' > -1}" configClasses (configFile >> "CfgVehicles" >> typeOf _this >> "VehicleInteractionInfo"));
_cannotMove*/

/*private _cannotMove = false;
{
	if (toLower configName _x find "wheel" > -1
		and {_this getHitPointDamage getText(_x >> "location") == 1}
	) exitWith {
		_cannotMove = true
	};
	if (toLower configName _x find "engine" > -1
		and {_this getHitPointDamage getText(_x >> "location") >= 0.9}
	) exitWith {
		_cannotMove = true
	}
} count ("true" configClasses (configFile >> "CfgVehicles" >> typeOf _this >> "VehicleInteractionInfo"));
_cannotMove*/