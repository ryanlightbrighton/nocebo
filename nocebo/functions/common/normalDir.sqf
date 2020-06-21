#include "\nocebo\defines\scriptDefines.hpp"

if (_this < 0 ) then {
	_this = _this + 720
};
_this = _this % 360;
abs _this