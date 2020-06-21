#include "\nocebo\defines\scriptDefines.hpp"
// NOTE - IF ISSERVER THEN ADDS EH LOCALLY.  IF NOT, THEN SENDS TO SERVER

// EX:  _ret = [car1,"GetOut","horde_fnc_getOutVehicle"] call horde_fnc_addServerEventHandler;

if (isServer) then {
	 sel(_this,0) addEventHandler [sel(_this,1), "_this call " + sel(_this,2)];
} else {
	_this remoteExecCall [
		"horde_fnc_addServerEventHandler",
		2
	];
};

true