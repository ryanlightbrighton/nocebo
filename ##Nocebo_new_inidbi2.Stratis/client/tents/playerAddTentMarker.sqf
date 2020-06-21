#include "\nocebo\defines\scriptDefines.hpp"

diag(_this);

params ["_tent","_markerName","_markerText","_color"];

private _mkr = createMarkerLocal [_markerName,position _tent];
_mkr setMarkerSizeLocal [1, 1];
_mkr setMarkerTypeLocal "respawn_inf";
_mkr setMarkerColorLocal _color;
_mkr setMarkerAlphaLocal 1;
_mkr setMarkerTextLocal _markerText;
_mkr setMarkerDirLocal 0;

true