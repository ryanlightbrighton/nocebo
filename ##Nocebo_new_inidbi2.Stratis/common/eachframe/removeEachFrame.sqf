#include "\nocebo\defines\scriptDefines.hpp"

removeMissionEventHandler ["EachFrame",_thisEventHandler];
{
    if (_x select 0 isEqualTo _thisEventHandler) exitWith {
        ncb_gv_eachFrameData deleteAt _forEachIndex;
    }
} forEach ncb_gv_eachFrameData;
true