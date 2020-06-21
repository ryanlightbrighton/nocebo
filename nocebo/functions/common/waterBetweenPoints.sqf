#include "\nocebo\defines\scriptDefines.hpp"

// EX:  [pos1,pos2,50] call horde_fnc_waterBetweenPoints;  returns t/f (checks every 50m in this example)

params ["_pos1","_pos2","_step"];
private _isWater = false;
for "_dist" from 0 to (round (_pos1 distance2D _pos2)) step _step do {
    if (surfaceIsWater (_pos1 getPos [_dist,_pos1 getDir _pos2])) exitWith {
        _isWater = true
    };
};
_isWater