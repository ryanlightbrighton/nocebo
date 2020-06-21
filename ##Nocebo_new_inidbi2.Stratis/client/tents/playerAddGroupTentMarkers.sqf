#include "\nocebo\defines\scriptDefines.hpp"

{

	_x params ["_tent","_markerName"];
	if (({if (_markerName == _x) exitWith {1}} count allMapMarkers) isEqualTo 0) then {
		private _markerText = "Group respawn tent";
		if (_tent isKindOf "ncb_obj_para_beacon") then {
			_markerText = "Group para respawn beacon";
		};
		[_tent,_markerName,_markerText,"colorGreen"] call horde_fnc_playerAddTentMarker
	};
} forEach _this;

true