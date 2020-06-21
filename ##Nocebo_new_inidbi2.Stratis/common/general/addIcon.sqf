#include "\nocebo\defines\scriptDefines.hpp"

_this = _this call BIS_fnc_objectVar;
addMissionEventHandler ["EachFrame",{
	_this call horde_fnc_drawIcon
}];