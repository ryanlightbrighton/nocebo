#include "\nocebo\defines\scriptDefines.hpp"

private _attAmmo = player getVariable ["playerHasAttachedAmmoObject",objNull];

if (isNull _attAmmo) then {
	private _text = "
		<t size='3.2'color='#FF0000'align='center'shadow='2'>
		You do not have anything attached to your uniform.
		</t>
	";
	_text call horde_fnc_displayActionRejMessage;
	false
} else {
	closeDialog 0;
	player playActionNow "PutDown";
	detach _attAmmo;
	player setVariable ["playerHasAttachedAmmoObject",objNull];
	private _text = format [
		"
			<t size='3.2'color='#FFFFFF'align='center'shadow='2'>
			%1 dropped on floor.
			</t>
		",
		getText (configfile >> "cfgammo" >> typeOf _attAmmo >> "displayname")
	];
	_text call horde_fnc_displayActionConfMessage;
};
true