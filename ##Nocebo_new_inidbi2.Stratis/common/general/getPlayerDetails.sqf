#include "\nocebo\defines\scriptDefines.hpp"

if not (isNull sel(_this,0)) then {
	if (isServer) then {
		diag("unit");
		diag(sel(_this,0));
		diag("profile name");
		diag(sel(_this,1));
		diag("profile name steam");
		diag(sel(_this,2));
	} else {
		[player,profileName,profileNameSteam] remoteExecCall [
			"horde_fnc_getPlayerDetails",
			2
		];
	};
};
true