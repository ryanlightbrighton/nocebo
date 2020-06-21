#include "\nocebo\defines\scriptDefines.hpp"

{
    if (_x select 0 isEqualTo _thisEventHandler) exitWith {
        _x select 2 params ["_code","_interval","_timeout"];
        if (diag_tickTime > _timeout) then {
            ncb_gv_eachFrameData set [_forEachIndex,[_thisEventHandler,_x select 1,[_code,_interval,diag_tickTime + _interval]]];
            (_x select 1) call _code;
        };
    }
} forEach ncb_gv_eachFrameData;
true