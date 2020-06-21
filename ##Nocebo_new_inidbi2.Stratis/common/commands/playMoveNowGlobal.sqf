#include "\nocebo\defines\scriptDefines.hpp"

params ["_unit","_anim"];

if not (isNull _unit) then {
	if (local _unit) then {
		_unit playMoveNow _anim
	} else {
		_this remoteExecCall [
			"horde_fnc_playMoveNowGlobal",
			_unit
		];
	};
};
true