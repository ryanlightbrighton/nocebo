#include "\nocebo\defines\scriptDefines.hpp"

params ["_unsorted","_pos","_closest","_sorted"];

// ex: [unsorted positions and/or objects,pos] call horde_fnc_sortByDistance

_sorted = [];
{
	if (_unsorted isEqualTo []) exitWith {};
	_closest = _unsorted select 0;
	{
		if (_x distance _pos < _closest distance _pos) then {
			_closest = _x;
		};
	} forEach _unsorted;
	_sorted pushBack _closest;
	_unsorted = _unsorted - [_closest];
} forEach _unsorted;

_sorted