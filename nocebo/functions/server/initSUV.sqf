#define diag(a,b) (diag_log format [prefix + "initSUV"" - " + a + ": %1",b])
#include "\nocebo\defines\scriptDefines.hpp"

params ["_veh","_age","_texture"];


if (_age isEqualTo "new") then {
	_texture = rand(ncb_gv_suvTextures);
	_veh setObjectTextureGlobal [0, _texture];
	_veh setObjectTextureGlobal [1, _texture];
};

true
