#include "\nocebo\defines\scriptDefines.hpp"

private _args = [];
{
    if (_x select 0 isEqualTo _thisEventHandler) exitWith {
        _args = _x select 1
    }
} forEach ncb_gv_eachFrameData;
_args