#include "\nocebo\defines\scriptDefines.hpp"

// note: accepts ASL only

private _holder = objNull;

private _holders = nearestObjects [
	ASLtoAGL _this,
	[
		"WeaponHolder",
		"WeaponHolderSimulated"
	],
	1
];

if not empty(_holders) then {
	_holder = sel(_holders,0)
};

_holder