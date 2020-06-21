#include "\nocebo\defines\scriptDefines.hpp"

getVar(missionNamespace,"playerResetAnim") params ["_anim1","_anim2"];
detach player;
player switchMove ("AmovP" + _anim1 + "MstpSrasW" + _anim2 + "Dnon");

true