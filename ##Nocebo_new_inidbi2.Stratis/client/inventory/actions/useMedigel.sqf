#include "\nocebo\defines\scriptDefines.hpp"

closeDialog 0;
if (isNil {getVar(missionNamespace,"playerPerformingAction")}) then {
	player removeItem _this;
	if diff(vehicle player,player) exitWith {
		setVar(missionNamespace,"ncb_gv_playerBleedingRate",0);
		private _text = "
			<t size='3.2'color='#FFFFFF'align='center'shadow='2'>
			You applied some Medigel.
			</t>
		";
		_text call horde_fnc_displayActionConfMessage;
	};
	closeDialog 0;
	player playActionNow "PutDown"; // check what happens if lying down
	setVar(missionNamespace,"ncb_gv_playerBleedingRate",0);
	private _text = "
		<t size='3.2'color='#FFFFFF'align='center'shadow='2'>
		You applied some Medigel.
		</t>
	";
	_text call horde_fnc_displayActionConfMessage;
} else {
	closeDialog 0;
	private _text = "
		<t size='3.2'color='#FF0000'align='center'shadow='2'>
		You are already doing something.
		</t>
	";
	_text call horde_fnc_displayActionRejMessage;
};
true