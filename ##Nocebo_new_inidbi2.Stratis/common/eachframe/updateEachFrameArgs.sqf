#include "\nocebo\defines\scriptDefines.hpp"

{
    if (_x select 0 isEqualTo _thisEventHandler) exitWith {
        ncb_gv_eachFrameData set [_forEachIndex,[_thisEventHandler,_this,_x select 2]]
    }
} forEach ncb_gv_eachFrameData;
true