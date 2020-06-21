#include "\nocebo\defines\scriptDefines.hpp"

disableSerialization;

private _display = getVar(uiNamespace,"Horde_InteractionMenu");

waitUntil {
	for "_i" from 0 to 359 do {
		if (isNull _display) exitWith {};
		private _vectorDir = [
			1 * sin _i,
			1 * cos _i,
			0
		];
		private _vectorUp = [
			0,
			0.5,
			0.5
		];
		{
			private _ctrl = _display displayCtrl sel(_x,0);
			if sel(_x,1) then {
				private _arr = +_vectorDir;
				_arr set[2,0.7];
				/*_ctrl ctrlSetModelDirAndUp [_arr,_vectorUp];*/
				_ctrl ctrlSetModelDirAndUp [_arr,[0,0,1]];
			} else{
				_ctrl ctrlSetModelDirAndUp [_vectorDir,[0,0,1]];
			};
			true
		} count _this;
		private _var = 0.5;
		if (_i < 180) then {
			_var = linearconversion [0,180,_i,0.01,0.24,true];
		} else {
			_var = linearconversion [180,360,_i,0.24,0.01,true];
		};
		{
			ctrlSetText [_x,"#(rgb,8,8,3)color(" + format["%1,%2,%3,%4",0,0,0,_var] +")"];
		} count [1200,1201,1202,1203,1204,1205];
		sleep 0.001;
	};
	not dialog
};
true