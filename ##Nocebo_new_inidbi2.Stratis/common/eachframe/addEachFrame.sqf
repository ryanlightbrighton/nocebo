#include "\nocebo\defines\scriptDefines.hpp"

params ["_args","_code","_interval","_thisEventHandler"];
if (0 isEqualTo _interval) then {
    _thisEventHandler = addMissionEventHandler [
        "EachFrame",
        _code
    ];
} else {
    _thisEventHandler = addMissionEventHandler [
        "EachFrame",
        horde_fnc_eachFrameRepeat
    ]
};
ncb_gv_eachFrameData pushBack [
    _thisEventHandler,
    _args,
    [_code,_interval,diag_tickTime + _interval]
];
_thisEventHandler