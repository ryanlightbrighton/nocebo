#include "\nocebo\defines\scriptDefines.hpp"

private _mission = floor random 7;
//private _mission = 6;
call {
	if (_mission == 0) exitWith {
		0 spawn horde_fnc_sideMissionDestroyAA;
	};
	if (_mission == 1) exitWith {
		0 spawn horde_fnc_sideMissionRescueHostages;
	};
	if (_mission == 2) exitWith {
		0 spawn horde_fnc_sideMissionDestroyConvoy;
	};
	if (_mission == 3) exitWith {
		0 spawn horde_fnc_sideMissionDestroyArmouredColumn;
	};
	if (_mission == 4) exitWith {
		0 spawn horde_fnc_sideMissionAssassination;
	};
	if (_mission == 5) exitWith {
		0 spawn horde_fnc_sideMissionHumanBomb;
	};
	if (_mission == 6) exitWith {
		0 spawn horde_fnc_sideMissionDestroyConvoyBoat;
	};
};