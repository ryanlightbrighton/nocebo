#include "\nocebo\defines\scriptDefines.hpp"

params ["_object","_texture"];

if not (isNull _object) then {
	if (local _object) then {
		_object setFlagTexture _texture;
	} else {
		_this remoteExecCall [
		 	"horde_fnc_setFlagTextureGlobal",
			_object
		];
	};
};

true