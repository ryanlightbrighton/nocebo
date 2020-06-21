#include "\nocebo\defines\scriptDefines.hpp"

params ["_house","","","_doorA","_handleA","_doorB","_handleB"];

_house animateSource [_doorA, 0];
_house animateSource [_handleA, 0];
_house animateSource [_doorB, 0];
_house animateSource [_handleB, 0];

true