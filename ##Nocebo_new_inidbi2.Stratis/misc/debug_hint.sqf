#include "\nocebo\defines\scriptDefines.hpp"
#define diag(a,b) (diag_log format [prefix + "debugHint.sqf"" - " + a + ": %1",b])


waitUntil {
	sleep 1;
	time > 1;
};

waitUntil {
	if (isMultiplayer) then {
		call {
			if (hasinterface) exitWith {				// players
				_un = {local _x} count allUnits;
				_gp = {local _x} count allGroups;
				_vc = {local _x and {not (_x isKindOf "Man")}} count vehicles;
				_dd = {local _x} count allDead;
				_string = format ["Player: unit: %1 | grps: %2 | veh: %3 | dead: %4",_un,_gp,_vc,_dd];
				ssChat("",_string);
			};
			if (isServer) then {						// dedicated server
				_un = {local _x} count allUnits;
				_gp = {local _x} count allGroups;
				_vc = {local _x and {not (_x isKindOf "Man")}} count vehicles;
				_dd = {local _x} count allDead;
				_string = format ["Server: unit: %1 | grps: %2 | veh: %3 | dead: %4",_un,_gp,_vc,_dd];
				ssChat("",_string);
			} else {									// headless client
				_un = {local _x} count allUnits;
				_gp = {local _x} count allGroups;
				_vc = {local _x and {not (_x isKindOf "Man")}} count vehicles;
				_dd = {local _x} count allDead;
				_string = format ["Headless Client: unit: %1 | grps: %2 | veh: %3 | dead: %4",_un,_gp,_vc,_dd];
				ssChat("",_string);
			};
		};
	} else {
		// single player
		_units = {local _x} count allUnits;
		_un = {local _x} count allUnits;
		_gp = {local _x} count allGroups;
		_vc = {local _x and {not (_x isKindOf "Man")}} count vehicles;
		_dd = {local _x} count allDead;
		_string = format ["Single Player: unit: %1 | grps: %2 | veh: %3 | dead: %4",_un,_gp,_vc,_dd];
		ssChat("",_string);
	};
	sleep 5;
	false
};