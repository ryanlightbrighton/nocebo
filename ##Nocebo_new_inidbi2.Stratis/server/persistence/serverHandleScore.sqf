#include "\nocebo\defines\scriptDefines.hpp"

params ["_player","_object"];

if (_object isKindOf "CAManBase") then {
	if (isPlayer _object) then {
		private _kills = _player getVariable ["playerKills",0];
		_kills = _kills + 1;
		_player setVariable ["playerKills",_kills]
	} else {
		private _kills = _player getVariable ["aiKills",0];
		_kills = _kills + 1;
		_player setVariable ["aiKills",_kills]
	};
};

true

