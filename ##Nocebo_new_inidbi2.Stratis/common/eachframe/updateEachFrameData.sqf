#include "\nocebo\defines\scriptDefines.hpp"

_this pushBack (diag_tickTime + (_this select 1));
{
    if (_x select 0 isEqualTo _thisEventHandler) exitWith {
        ncb_gv_eachFrameData set [_forEachIndex,[_thisEventHandler,_x select 1,_this]]
    }
} forEach ncb_gv_eachFrameData;
true