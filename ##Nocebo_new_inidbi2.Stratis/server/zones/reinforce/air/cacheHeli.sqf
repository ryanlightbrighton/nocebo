#include "\nocebo\defines\scriptDefines.hpp"

private _veh = vehicle _this;
private _grp = group _this;

_grp call horde_fnc_cacheGroup;

{
	detach _x;
	deleteVehicle _x;
} count attachedObjects _veh;
deleteVehicle _veh;

true