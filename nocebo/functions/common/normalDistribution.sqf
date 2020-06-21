#include "\nocebo\defines\scriptDefines.hpp"

params ["_lower","_upper","_checks","_diff","_ret"];
_diff = _upper - _lower;
_ret = 0;
for "_i" from 1 to _checks do {
	_ret = _ret + (random _diff);
};
if diff(_ret,0) then {
	_ret = _ret / _checks;
};
_ret + _lower