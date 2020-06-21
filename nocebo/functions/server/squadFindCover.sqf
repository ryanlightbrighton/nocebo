#include "\nocebo\defines\scriptDefines.hpp"

params ["_pos","_dist","_coverPlaceDataArr","_occupiedPositions","_coverPosArr"];

/*_occupiedPositions = _this select 2;*/ // <== PASSED HERE BUT NOT USED (YET)

_coverPosArr = [[0,0,0],0]; // will be in format [pos,cost]
{
	if (_pos distance sel(_x,0) < _dist) then {
		if (sel(_x,1) > sel(_coverPosArr,1)) then {
			_coverPosArr = _x;
		};
	};
	true
} count _coverPlaceDataArr;
if (_coverPosArr isEqualTo [[0,0,0],0]) then {
	_coverPosArr = [];
};

_coverPosArr