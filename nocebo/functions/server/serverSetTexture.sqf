#include "\nocebo\defines\scriptDefines.hpp"

params ["_veh","_textures"];

//NOTE: CALLED - SEEMS TO BE IDENTICAL TO SERVERSETTEXTURE BUT THAT IS SPAWNED
// RAN FROM CLIENT WHEN UPGRADING VEHICLE

if not (empty(_textures)) then {
	for "_i" from 0 to count _textures - 1 do {
		_veh setObjectTextureGlobal [_i,sel(_textures,_i)];
	};
};

true