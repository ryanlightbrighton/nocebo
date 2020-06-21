#include "\nocebo\defines\scriptDefines.hpp"

private _ob = sel(_this,0);

if not (isNull _ob) then {
	if (local _ob) then {
		_ob setHitPointDamage sel(_this,1);
	} else {
		_this remoteExecCall [
			"horde_fnc_setHitPointDamageGlobal",
			_ob
		];
	};
};
true