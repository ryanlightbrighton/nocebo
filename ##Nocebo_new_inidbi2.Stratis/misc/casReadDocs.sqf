#include "\nocebo\defines\scriptDefines.hpp"

closeDialog 0;

params ["_item","_casType","_dlg"];

if (isNil {getVar(missionNamespace,"playerPerformingAction")}) then {
	call {
		if (_dlg == "ncb_dlg_casRemCtrlMenu") exitWith {
			uiNamespace setVariable ["ncb_uv_casData",[_item,_casType]];
			createDialog _dlg;
		};
		if (_dlg == "ncb_dlg_casMenu") exitWith {
			uiNamespace setVariable ["ncb_uv_casData",[_item,_casType]];
			createDialog _dlg;
		};
		if (_dlg == "ncb_dlg_artyMenu") exitWith {
			uiNamespace setVariable ["ncb_uv_casData",[_item,_casType]];
			createDialog _dlg;
		};
		if (_dlg == "uav") exitWith {
			if ("B_UavTerminal" in assignedItems player) then {
				[_casType,_item] call horde_fnc_casSpawnDrone
			} else {
				private _text = "
					<t size='3.2'color='#FF0000'align='center'shadow='2'>
					You need to have a UAV terminal assigned
					</t>
				";
				_text call horde_fnc_displayActionRejMessage;
			}
		};
	}
} else {
	private _text = "
		<t size='3.2'color='#FF0000'align='center'shadow='2'>
		You are already doing something.
		</t>
	";
	_text call horde_fnc_displayActionRejMessage;
};
true