#include "\nocebo\defines\scriptDefines.hpp"

params ["_house","","","_doorA","_handleA","_doorB"];

_house animateSource [_doorA, 0];
_house animateSource [_handleA, 0];
_house animateSource [_doorB, 0];

true