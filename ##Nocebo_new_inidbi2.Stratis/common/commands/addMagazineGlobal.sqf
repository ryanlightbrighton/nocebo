#include "\nocebo\defines\scriptDefines.hpp"

params ["_unit","_mag"];

if not (isNull _unit) then {
	if (local _unit) then {
		_unit addMagazine _mag
	} else {
		_this remoteExecCall [
			"horde_fnc_addMagazineGlobal",
			_unit
		];
	};
};

true