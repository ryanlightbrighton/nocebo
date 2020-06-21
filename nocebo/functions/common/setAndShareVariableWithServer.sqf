#include "\nocebo\defines\scriptDefines.hpp"

// NOTE - IF ISSERVER THEN SETS LOCALLY, ELSE SETS LOCALLY AND SENDS TO SERVER

// EX:  _ret = [OBJECT,"VARIABLE NAME",[ARRAY]] call horde_fnc_setAndShareVariableWithServer;

sel(_this,0) setVariable [sel(_this,1),sel(_this,2)];
if (not isServer) then {
	_this remoteExecCall [
		"horde_fnc_setAndShareVariableWithServer",
		2
	];
};

true
