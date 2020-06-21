#include "\nocebo\defines\scriptDefines.hpp"

params ["_veh","_textures"];

for "_i" from 0 to count _textures - 1 do {
	_veh setObjectTextureGlobal [_i,sel(_textures,_i)];
};

true