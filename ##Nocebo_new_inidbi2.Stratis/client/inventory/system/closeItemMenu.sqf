#include "\nocebo\defines\scriptDefines.hpp"

private _clear = false;

for "_i" from 1600 to 1619 do {
	private _menu = (findDisplay 602) displayCtrl _i;
	_menu ctrlShow false;
};

for "_i" from 1620 to 1650 do {
	private _ctrl = (findDisplay 602) displayCtrl _i;
	if (not isNil "_ctrl" and {not isNull _ctrl}) then {
		if not (_this isEqualTo "") then {
			if (_ctrl getVariable [_this,false]) then {
				_clear = true
			};
		};
		ctrlDelete _ctrl
	}
};

_clear


/*private ["_display","_numActions","_menu"];

_display = getVar(uiNamespace,"Horde_GearDialogReference");
for "_i" from 1600 to 1619 do {
	_menu = _display displayCtrl _i;
	_menu ctrlShow false;
	_menu ctrlCommit 0;
};

for "_i" from 1620 to 1650 do {
	_ctrl = (findDisplay 602) displayCtrl _i;
	if not (isNull _ctrl) then {
		ctrlDelete _ctrl
	};
};
true*/