#include "\nocebo\defines\scriptDefines.hpp"

params ["_args","_code","_repeat"];
{
    if (_x select 0 isEqualTo _thisEventHandler) exitWith {
        ncb_gv_eachFrameData set [_forEachIndex,[_thisEventHandler,_args,[_code,_repeat,diag_tickTime + _repeat]]]
    }
} forEach ncb_gv_eachFrameData;
true