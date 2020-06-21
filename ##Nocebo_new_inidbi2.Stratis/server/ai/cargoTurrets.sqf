#include "\nocebo\defines\scriptDefines.hpp"

params ["_grp","_allowCargoGunners"];
{
	if (vehicle _x != _x) then {
		private _roleArr = assignedVehicleRole _x;
		if (count _roleArr > 1) then {
			if (_roleArr select 0 == "cargo") then {
				(vehicle _x) enablePersonTurret [_roleArr select 1,_allowCargoGunners];
			};
		};
	};
} forEach units _grp;

true