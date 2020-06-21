#include "\nocebo\defines\scriptDefines.hpp"

params ["_ctrl","_button","_xVal","_yVal"];

if diff(_button,0) exitWith {false};

private _display = uiNamespace getVariable "ncb_dlg_casRemCtrlMenu";

private _followTerrain = if (cbChecked (_display displayCtrl 1803)) then {true} else {false};
private _height = ctrlText (_display displayCtrl 1801);
_height = round (parseNumber _height max 100);
private _radius = ctrlText (_display displayCtrl 1802);
_radius = round (parseNumber _radius max 200);

closeDialog 0;
private _screenCoords = [_xVal,_yVal];
private _targetPos = _ctrl ctrlMapScreenToWorld _screenCoords;
_targetPos set [2,0];
uiNamespace getVariable ["ncb_uv_casData",["ghosthawkCASAccessCode","ghosthawk"]] params ["_item","_casType"];
player removeItem _item;
_targetPos params ["_xTarget","_yTarget"];
private _xSpnMin = 0;
private _xSpnMax = worldSize / 2;
private _ySpnMin = 0;
private _ySpnMax = worldSize / 2;
if (_xTarget > worldSize / 2) then {
	// start somewhere on the right
	_xSpnMin = worldSize / 2;
	_xSpnMax = worldSize;
};
if (_yTarget > worldSize / 2) then {
	// start somewhere on the top
	_ySpnMin = worldSize / 2;
	_ySpnMax = worldSize;
};
private _spawnPos = if (random 1 > 0.5) then {
	[if (_xTarget > worldSize / 2) then {worldSize} else {0},_ySpnMin + random (_ySpnMax - _ySpnMin),_height]
} else {
	[_xSpnMin + random (_xSpnMax - _xSpnMin),if (_yTarget > worldSize / 2) then {worldSize} else {0},_height]
};

call {
	if (_casType == "blackfish") exitWith {
		private _class = "ncb_vtol_blackfish_gunship";
		[_height,_radius,_followTerrain,_targetPos,_spawnPos,_class,player] remoteExecCall [
			"horde_fnc_casRemoteControlServer",
			2
		];
	};
	if (_casType == "ghosthawk") exitWith {
		private _class = "ncb_heli_ghostHawk";
		[_height,_radius,_followTerrain,_targetPos,_spawnPos,_class,player] remoteExecCall [
			"horde_fnc_casRemoteControlServer",
			2
		];
	};
};

true


