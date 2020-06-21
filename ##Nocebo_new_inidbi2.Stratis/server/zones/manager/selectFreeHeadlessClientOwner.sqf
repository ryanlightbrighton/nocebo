#include "\nocebo\defines\scriptDefines.hpp"

private _drones = entities "HeadlessClient_F" select {_x getVariable ["droneLoaded",true]};
if not (_drones isEqualTo []) then {
	private _owner = owner (selectRandom _drones);
	{
		if ((_x getVariable "groupData") select 0 != "static") then {
			private _result = _x setGroupOwner _owner;
			diag_log format ["group locality changed: %1 %2",_x, _result];
			sleep 3;
		};
	} forEach _this;
};