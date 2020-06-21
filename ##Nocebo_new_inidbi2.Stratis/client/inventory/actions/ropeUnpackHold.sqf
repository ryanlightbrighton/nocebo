#include "\nocebo\defines\scriptDefines.hpp"

// majorly unfinished

if false then {
	private _text = "
		<t size='3.2'color='#FF0000'align='center'shadow='2'>
		You cannot hold more than one rope.
		</t>
	";
	_text call horde_fnc_displayActionRejMessage;
	false
} else {
	closeDialog 0;
	player playActionNow "PutDown";
	player removeItem _this;
	/*_rope = ropeCreate [player,"righthand",objNull,[0,0,0],10];*/
	h_rope = ropeCreate [heli1,[0,0,0],10];
	heli1 ropeDetach h_rope;
	[player,[0,0,0],[0,1,0]] ropeAttachTo h_rope;
	ropeUnwind [h_rope,3,20];
	/*_text = format [
		"
			<t size='3.2'color='#FFFFFF'align='center'shadow='2'>
			%1 dropped on floor.
			</t>
		",
		getText (configfile >> "cfgammo" >> typeOf _attAmmo >> "displayname")
	];
	_text call horde_fnc_displayActionConfMessage;*/
};
true