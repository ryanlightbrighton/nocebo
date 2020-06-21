#define diag(a,b) (diag_log format [prefix + "initPlayerLocal.sqf"" - " + a + ": %1",b])
#include "\nocebo\defines\scriptDefines.hpp"

/*
	Executed locally when player/HC joins mission (includes both mission start and JIP).

	scheduled (before PostInit)

	https://community.bistudio.com/wiki/Initialization_Order
*/



// do HC setup here

if (not hasInterface and {not isServer}) then {
	disableRemoteSensors true;
	waitUntil {
		uiSleep 0.1;
		not isNil "ncb_pv_paramsArray" and {ncb_pv_paramsArray isEqualType []}
	};
	diag("params check (HC)",true);
	for "_i" from 0 to count ncb_pv_paramsArray - 1 do {
		_args = ncb_pv_paramsArray select _i;
		missionNamespace setVariable _args;
		diag_log format ["'%1': %2",_args select 0,_args select 1];
	};
	diag_log "---------";
	call horde_fnc_commonInit;
	horde_fnc_handleRespawn = {};
	_this remoteExec ["horde_fnc_initPlayerOnServer",2];
} else {
	_this remoteExec ["horde_fnc_initPlayerOnServer",2];
};

