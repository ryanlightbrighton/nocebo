#include "\nocebo\defines\scriptDefines.hpp"

if not (isNull sel(_this,0)) then {
	if (isServer) then {
		sel(_this,0) enableSimulationGlobal sel(_this,1);
	} else {
		_this remoteExecCall [
			"horde_fnc_enableSimulationGlobal",
			2
		];
	};
};
true