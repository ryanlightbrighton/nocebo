#include "\nocebo\defines\scriptDefines.hpp"

private _dam = damage player;
private _minHealth = ncb_gv_playerLodgedBullets * 0.07;
_dam = (_dam - 0.85) max _minHealth;
player setDamage _dam;

private _string = "%1 gave you a blood bag.";
call {
	if (ncb_gv_playerLodgedBullets == 1) exitWith {
		_string = "%1 gave you a blood bag, but you have a lodged bullet that needs to be removed."
	};
	if (ncb_gv_playerLodgedBullets > 1) exitWith {
		_string = "%1 gave you a blood bag, but you have %2 lodged bullets that need to be removed."
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


