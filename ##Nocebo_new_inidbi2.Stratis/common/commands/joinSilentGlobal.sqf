#include "\nocebo\defines\scriptDefines.hpp"

params ["_units","_grp"];

if not (isNull _grp) then {
	if (local _grp) then {
		_units joinSilent _grp
	} else {
		if (isServer) then {
			_this remoteExecCall ["horde_fnc_joinSilentGlobal",groupOwner _grp];
		} else {
			_this remoteExecCall ["horde_fnc_joinSilentGlobal",2];
		};
	};
};

true