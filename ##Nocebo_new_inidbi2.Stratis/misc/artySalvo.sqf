#include "\nocebo\defines\scriptDefines.hpp"

// runs on player - maybe move to server

/*params ["_pos","_dir","_planeClass","_weaponTypesID"];*/

disableSerialization;

params ["_ctrl","_button","_xVal","_yVal"];

if diff(_button,0) exitWith {false};

private _display = uiNamespace getVariable "ncb_dlg_artyMenu";

closeDialog 0;
private _pos = _ctrl ctrlMapScreenToWorld [_xVal,_yVal];
_pos set [2,0];
uiNamespace getVariable ["ncb_uv_casData",["hammerStrikeAccessCode","mk45"]] params ["_item","_casType"];
player removeItem _item;


call {
	if (_casType == "mk45") exitWith {
		ncb_obj_destroyer_hammer doArtilleryFire [_pos, "magazine_ShipCannon_120mm_HE_shells_x32", 8];
	};
	// "R_230mm_Cluster" or "R_230mm_HE";
	if (_casType == "mlrs") exitWith {
		_pos spawn {
			sleep 45;
			// Selecting the final position where the AI should fire
			for "_i" from 1 to 8 do {
				sleep 1;
				_finalPos = _this5e5 getPos [random 60, random 360];
				_shell = "R_230mm_Cluster" createVehicle [_finalPos select 0, _finalPos select 1, 3000];
				_shell setVectorUp [0,0,-1];
				_shell setVelocity [0,0,-150];
			};
		};
	};
};


