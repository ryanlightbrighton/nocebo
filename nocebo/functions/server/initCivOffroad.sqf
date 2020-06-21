#define diag(a,b) (diag_log format [prefix + "initCivOffroad"" - " + a + ": %1",b])
#include "\nocebo\defines\scriptDefines.hpp"

params ["_veh","_age","_texture"];

_veh animate ["HidePolice", 1];
_veh animate ["HideServices", 1];
// _veh animate ["HideConstruction", 0]; // roll bar
if (backpackCargo _veh isEqualTo []) then {
	_veh animate ["HideBackpacks", 1];
} else {
	_veh animate ["HideBackpacks", 0];
};
if (_age isEqualTo "new") then {
	_texture = rand(ncb_gv_civOffroadTextures);
	_veh setObjectTextureGlobal [0, _texture];
	_veh setObjectTextureGlobal [1, _texture];
};

true