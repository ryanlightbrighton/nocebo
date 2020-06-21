#include "\nocebo\defines\scriptDefines.hpp"

private _object = sel(_this,0);
if not (isNull _object) then {
	if (local _object) then {
		_object lockCargo sel(_this,1);
	} else {
		_this remoteExecCall [
		 	"horde_fnc_lockCargoGlobal",
			_object
		];
	};
};

true