#include "\nocebo\defines\scriptDefines.hpp"

params ["_mkr","_pos","_sizeX","_sizeY","_posX","_posY","_mkrPosX","_angle","_u","_v","_distSqr","_inMarker"];

_sizeX = (markerSize _mkr) select 0;
_sizeY = (markerSize _mkr) select 1;
_posX = _pos select 0;
_posY = _pos select 1;
_mkrPosX = (markerPos _mkr) select 0;
_mkrPosY = (markerPos _mkr) select 1;
_angle = -1 * (markerDir _mkr);
_u = (cos _angle) * (_mkrPosX - _posX) + (sin _angle) * (_mkrPosY- _posY);
_v = -(sin _angle) * (_mkrPosX - _posX) + (cos _angle) * (_mkrPosY- _posY);
_distSqr = (_u/_sizeX) * (_u/_sizeX) + (_v/_sizeY) * (_v/_sizeY);
_inMarker = false;
if (_distSqr <= 1) then {
	_inMarker = true;
};

_inMarker