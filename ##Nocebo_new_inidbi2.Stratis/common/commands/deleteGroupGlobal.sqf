#include "\nocebo\defines\scriptDefines.hpp"

// _this = group;   local can be used for groups (since Arma 3 v1.31.127204)

if not (isNull _this) then {
	if (local _this) then {
		deleteGroup _this
	} else {
		if (isServer) then {
			_this remoteExecCall [
				"horde_fnc_deleteGroupGlobal",
				groupOwner _this
			];
		} else {
			_this remoteExecCall [
				"horde_fnc_deleteGroupGlobal",
				2
			]
		}
	}
};
true