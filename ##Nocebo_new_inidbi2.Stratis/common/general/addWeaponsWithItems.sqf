#include "\nocebo\defines\scriptDefines.hpp"

params ["_container","_array","_element"];

{
	for "_i" from 1 to count _x - 1 do {
		_element = sel(_x,_i);
		call {
			if (_element isEqualType "") exitWith {
				if (_element != "") then {
					_container addItemCargoGlobal [_element,1];
				};
			};
			if (_element isEqualType []) exitWith {
				if (count _element == 2) then {
					_container addMagazineAmmoCargo [sel(_element,0),1,sel(_element,1)];
				};
			};
		};
	};
	_container addWeaponCargoGlobal[
		sel(_x,0) call horde_fnc_findBareWeaponClass,
		1
	];
} count _array;

true