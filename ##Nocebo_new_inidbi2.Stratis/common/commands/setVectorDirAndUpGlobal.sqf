#include "\nocebo\defines\scriptDefines.hpp"

params ["_unit","_vector"];

if not (isNull _unit) then {
	if (local _unit) then {
		_unit setVectorDirAndUp _vector
	} else {
		_this remoteExecCall [
			"horde_fnc_setVectorDirAndUpGlobal",
			_unit
		];
	};
};

true