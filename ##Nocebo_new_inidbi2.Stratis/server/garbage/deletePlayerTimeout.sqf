#include "\nocebo\defines\scriptDefines.hpp"

params ["_body"];

_body setVariable ["deadDeleteTime",(round time) + ncb_param_removeDeadPlayerTimeout];
true