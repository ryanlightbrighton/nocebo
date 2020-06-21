#include "\nocebo\defines\scriptDefines.hpp"


params ["_object","_needed"];

if not (isNull _object) then {
	if (local _object) then {
		_object addRating (_needed - (rating _object));
	} else {
		_this remoteExecCall [
		 	"horde_fnc_setUnitRatingGlobal",
			_object
		];
	};
};

true