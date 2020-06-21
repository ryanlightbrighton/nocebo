#include "\nocebo\defines\scriptDefines.hpp"

params ["_object","_timeout"];

_object setVariable ["deadDeleteTime",(round time) + _timeout];
ncb_gv_garbageContents pushBack _object;
true