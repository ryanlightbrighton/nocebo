#include "\nocebo\defines\scriptDefines.hpp"

setVar(_this,"buildingExcludeFromFurnitureManager",true);
private _housePosASL = getPosASL _this;

private _physxFurniture = [];
{
	private _furniture = getVar(_this,_x);
	if (not isNil "_furniture") then {
		{
			if (_x isKindOf "thingX") then {
				_physxFurniture pushBack _x;
				detach _x;
				_x disableCollisionWith _this;
				private _vect = _housePosASL vectorFromTo getPosASL _x;
				_vect = _vect vectorMultiply ((random 10) + 7);
				_x setVelocity _vect;
			} else {
				deleteVehicle _x;
			};
		} count _furniture;
	};
	setVar(_this,_x,nil);
	true
} count ["buildingFurniture25m","buildingFurniture50m"];

[
    [_physxFurniture],{
        call horde_fnc_getEachFrameArgs params ["_furn"];
        {
			deleteVehicle _x
		} count _furn;
        call horde_fnc_removeEachFrame
    },
    10
] call horde_fnc_addEachFrame;

private _attachLogic = _this getVariable "buildingFurnitureLogic25m";
if not (isNil "_attachLogic") then {
	deleteVehicle _attachLogic;
	_this setVariable ["buildingFurnitureLogic25m",nil];
};
_attachLogic = _this getVariable "buildingFurnitureLogic50m";
if not (isNil "_attachLogic") then {
	deleteVehicle _attachLogic;
	_this setVariable ["buildingFurnitureLogic50m",nil];
};

true