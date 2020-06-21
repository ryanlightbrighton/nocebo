#include "\nocebo\defines\scriptDefines.hpp"

// runs on player - maybe move to server

/*params ["_pos","_dir","_planeClass","_weaponTypesID"];*/

disableSerialization;

params ["_ctrl","_button","_xVal","_yVal"];

if diff(_button,0) exitWith {false};

private _display = uiNamespace getVariable "ncb_dlg_casMenu";

private _dir = ctrlText (_display displayCtrl 1801);
_dir = round (parseNumber _dir) % 360;
if (_dir < 0) then {
	_dir = _dir + 360
};

closeDialog 0;
private _pos = _ctrl ctrlMapScreenToWorld [_xVal,_yVal];
_pos set [2,0];
uiNamespace getVariable ["ncb_uv_casData",["wipeoutCASAccessCode",["B_Plane_CAS_01_dynamicLoadout_F",0]]] params ["_item","_casType"];
player removeItem _item;
_casType params [
	["_planeClass","B_Plane_CAS_01_dynamicLoadout_F"],
	["_weaponTypesID",0]
];

[_pos,_dir,_planeClass,_weaponTypesID] remoteExec [
	"horde_fnc_serverCasAttackRun",
	2
];