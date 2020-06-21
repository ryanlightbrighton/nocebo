#include "\nocebo\defines\scriptDefines.hpp"
scopeName "0";

params [
	"_pos",						// pos!
	"_minDist",					// min dist to search
	"_maxDist",					// furthest dist to search
	"_objDist",					// min dist to another obj
	"_water",					// 0=noWater 1=either 2=inWater
	"_gradient",	 			// average altitude difference in meters
	"_shore"					// 0=canBeAtShore 1=mustBeAtShore
];

if same(_shore,0) then {
	_shore = false;
} else {
	_shore = true;
};
private _newPos = [];
_pos resize 2;
for "_i" from 1 to 1000 do {
	private _testPos = [
		sel(_pos,0) + (_maxDist - (random (_maxDist * 2))),
		sel(_pos,1) + (_maxDist - (random (_maxDist * 2)))
	];
	if ((_pos distance _testPos) >= _minDist) then {
		if not ([] isEqualTo (_testPos isFlatEmpty [_objDist,0,_gradient,_objDist max 5,_water,_shore,objNull])) then {
			_newPos = _testPos;
			breakTo "0"
		};
	};
};
if not empty(_newPos) then {
	if (surfaceIsWater _newPos) then {
		_newPos set[2,0];
	} else {
		_newPos set[2,getTerrainHeightASL _newPos];
	};

};

_newPos

/*
	[getPos player,0,30,5,0,1,0] call bis_fnc_findSafePos

	4.79403 ms

	[getPos player,0,30,5,0,1,0] call horde_fnc_findSafePosASL

	1.94557 ms
*/