#include "\nocebo\defines\scriptDefines.hpp"


private _ammo = getText(configFile >> "CfgMagazines" >> _this >> "ammo");
private _name = getText(configFile >> "CfgMagazines" >> _this >> "displayname");

call {
	if (_this == "StickyCharge_Remote_Mag") exitWith {
		horde_gvar_currentChargeType = ["StickyCharge_Remote_Mag","DemoCharge_Remote_Ammo_Scripted"];
	};
	if (_this == "BreachingCharge_Remote_Mag") exitWith {
		horde_gvar_currentChargeType = ["BreachingCharge_Remote_Mag","BreachingCharge_Remote_Ammo_Scripted"];
	};
	// new
	if (_this find "Chemlight" > -1) exitWith {
		horde_gvar_currentChargeType = [_this,_this]; // ammo name is mag name!
	};
	if (_this find "SmokeShell" > -1) exitWith {
		horde_gvar_currentChargeType = [_this,_this]; // ammo name is mag name!
	};
};

private _text = format ["
		<t size='3.2'color='#FFFFFF'align='center'shadow='2'>
		%1 selected
		</t>
	",
	_name
];
_text call horde_fnc_displayActionConfMessage;
true