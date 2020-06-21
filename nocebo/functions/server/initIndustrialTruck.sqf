#define diag(a,b) (diag_log format [prefix + "initIndustrialTruck"" - " + a + ": %1",b])
#include "\nocebo\defines\scriptDefines.hpp"

params ["_veh","_age","_var","_skin1","_skin2"];

if (_age isEqualTo "new") then {
	_var = str random 1 + "," + str random 1 + "," + str random 1 + "," + str random 1;
	_skin1 = "#(argb,8,8,3)color(" + _var + ")";
	_var = str random 1 + "," + str random 1 + "," + str random 1 + "," + str random 1;
	_skin2 = "#(argb,8,8,3)color(" + _var + ")";
	_veh setObjectTextureGlobal [0,format ["%1",_skin1]];
	_veh setObjectTextureGlobal [1,format ["%1",_skin2]];
};

true

