#define diag(a,b) (diag_log format [prefix + "initVan"" - " + a + ": %1",b])
#include "\nocebo\defines\scriptDefines.hpp"

params ["_veh","_age","_randomIndex","_texture0","_texture1"];

if (_age isEqualTo "new") then {
	_randomIndex = floor random count ncb_gv_vanTexturesA;
	_texture0 = sel(ncb_gv_vanTexturesA,_randomIndex);
	_texture1 = sel(ncb_gv_vanTexturesB,_randomIndex);
	_veh setObjectTextureGlobal [0, _texture0];
	_veh setObjectTextureGlobal [1, _texture1];
};

true
