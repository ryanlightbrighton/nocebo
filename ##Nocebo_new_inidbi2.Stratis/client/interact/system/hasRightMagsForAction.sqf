#include "\nocebo\defines\scriptDefines.hpp"

private _mags = magazines player;
private _count = count _mags;
{
	private _element = _mags find _x;
	if (_element > -1) then {
		_mags deleteAt _element;
	};
	true
} count _this;
private _hasRightMags = false;
if (_count - count _this == count _mags) then {
	_hasRightMags = true;
};
_hasRightMags