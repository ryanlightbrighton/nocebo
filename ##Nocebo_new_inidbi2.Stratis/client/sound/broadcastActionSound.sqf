#include "\nocebo\defines\scriptDefines.hpp"

params ["_unit","_cfgType","_item"];

private _soundClass = getText (configFile >> _cfgType >> _item >> "horde_actionSound");
private _soundArr = getArray (configFile >> "CfgSounds" >> _soundClass >> "sound");
private _nearPlayers = _unit nearEntities ["ncb_player_base",sel(_soundArr,3)];
if not empty(_nearPlayers) then {
	[_unit,_soundClass,7] remoteExecCall [
		"horde_fnc_playSingleSound",
		_nearPlayers
	];
};

true
