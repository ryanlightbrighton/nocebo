#include "\nocebo\defines\scriptDefines.hpp"

private _holderArr = [];
{
	_x params ["_type","_holderPos","_contents"];
	if not empty(_contents) then {
		private _holder = spawnVeh(_type,_holderPos);
		_holder setPosATL _holderPos;
		/*_holder setvectorUp [0,0,1];*/
		_holder allowDamage false;
		_holderArr pushBack _holder;
		/*test_Logic action ["Gear", _holder];*/
		[_holder,_contents,true] call horde_fnc_fillCargo
	};
} count sel(getVar(_this,"HOUSE_LOOT_DATA"),1);

_holderArr

