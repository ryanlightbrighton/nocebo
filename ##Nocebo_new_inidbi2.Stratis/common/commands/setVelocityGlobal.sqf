#include "\nocebo\defines\scriptDefines.hpp"

params ["_object","_velocity"];

if not (isNull _object) then {
	if (local _object) then {
		_object setVelocity _velocity;
	} else {
		_this remoteExecCall [
		 	"horde_fnc_setVelocityGlobal",
			_object
		];
	};
};

true