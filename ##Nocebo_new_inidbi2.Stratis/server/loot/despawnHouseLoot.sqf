#include "\nocebo\defines\scriptDefines.hpp"


private _time = sel(getVar(_this,"HOUSE_LOOT_DATA"),0);
private _holderArr = [];
{
	if (not isNull _x) then {
		private _contents = [_x,true] call horde_fnc_totalContents;
		_holderArr pushBack [typeOf _x, ASLtoAGL getPosASL _x,_contents];
		deleteVehicle _x;
	};
	true
} count getVar(_this,"LOOT_HOLDER_OBJECTS");

[_time,_holderArr]
