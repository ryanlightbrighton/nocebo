#include "\nocebo\defines\scriptDefines.hpp"

setVar(missionNamespace,"ncb_gv_playerBleedingRate",0);
player setDamage 0.5 max (ncb_gv_playerLodgedBullets * 0.07);

player setUnconscious false;

private _string = "%1 revived you.";
call {
	if (ncb_gv_playerLodgedBullets == 1) exitWith {
		_string = "%1 revived you, but you have a lodged bullet that needs to be removed."
	};
	if (ncb_gv_playerLodgedBullets > 1) exitWith {
		_string = "%1 revived you, but you have %2 lodged bullets that need to be removed."
	};
};
private _text = format [
	"
		<t size='3.2'color='#FFFFFF'align='center'shadow='2'>
		%1
		</t>
	",
	format [_string,name _this,ncb_gv_playerLodgedBullets]
];
_text call horde_fnc_displayActionConfMessage;


