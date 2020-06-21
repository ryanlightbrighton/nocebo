#include "\nocebo\defines\scriptDefines.hpp"

scriptName "dragStarted";
params ["_ctrl","_data"];
_data = _data select 0;
_data params ["","","_entry"];
_entry = call compile _entry;
_entry params ["_mag","_count"];

_display = uiNamespace getVariable "reloadMenu";

// log a variable to tell us where the item came from

_display setVariable ["ncb_itemFrom", [
	_ctrl getVariable ["ncb_object",objNull],
	ctrlIDC _ctrl
]];

// add EH to enable controls when mouse button is unclicked

_display displayAddEventHandler ["mouseButtonUp",{
	_display = uiNamespace getVariable "reloadMenu";
	{
		_ct = _display displayCtrl _x;
		if not (ctrlEnabled _ct) then {
			_ct ctrlEnable true
		}
	} forEach [1001,1002,1003];

	for "_i" from 1600 to 1700 do {
		_ct = _display displayCtrl _i;
		if (isNull _ct) exitWith {};
		if not (ctrlEnabled _ct) then {
			_ct ctrlEnable true
		}
	};
	_display displayRemoveAllEventHandlers "mouseButtonUp"
}];

// if this came from a vehicle, then change the class to refill class
if (ctrlIDC _ctrl >= 1600) then {
	_mag = (_ctrl getVariable ["ncb_linkClasses",["",""]]) select 1
};

// disable any containers that have no room
{
	_ct = _display displayCtrl _x;
	_canAdd = _ct getVariable ["ncb_object",objNull] canAdd _mag;
	if (isNil "_canAdd") then {
		_canAdd = false
	};
	if (not _canAdd
	    or {_ct isEqualTo _ctrl}
	    or {_count == 0}
	) then {
		_ct ctrlEnable false;
	}
} forEach [1001,1002,1003];

// disable any weapons that will not accept this mag.
// also, disable any weapons that have enough (or too many mags)

for "_i" from 1600 to 1700 do {
	_ct = _display displayCtrl _i;
	if (isNull _ct) exitWith {};
	call {
		if (ctrlIDC _ctrl >= 1600) exitWith {
			_ct ctrlEnable false;
		};
		if not (_ct getVariable ["ncb_canAdd",true]) exitWith {
			_ct ctrlEnable false;
		};
		_ct getVariable ["ncb_linkClasses",["",""]] params ["_defaultMag","_magToAdd"];
		if (_magToAdd != _mag) then {
			_ct ctrlEnable false;
		}
	}
}