#include "\nocebo\defines\scriptDefines.hpp"

params ["_house","","","_door","_handle1"];

_house animateSource [_handle1, 0];
_house animateSource [_door, 0];
_house animateSource [format ["Door_%1_noSound_source", parseNumber (_door select [5,99])],0]; // new bodge for double doors


true