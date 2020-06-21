#include "\nocebo\defines\scriptDefines.hpp"

params ["_grp","_unit"];

if not (isNull _grp) then {
	if (local _grp) then {
		_grp selectLeader _unit
	} else {
		if (isServer) then {
			_this remoteExecCall ["selectLeader", groupOwner _grp];
		} else {
			_this remoteExecCall ["horde_fnc_selectLeaderGlobal",2];
		};
	};
};

true