/*
	Author: Karel Moricky
	Enhanced by Robalo

	Description:
	Return all compatible weapon attachments

	Parameter(s):
		0: STRING - weapon class
		1: STRING - optional, accessory type: number (101 - muzzle, 201 - optic, 301 - pointer, 302 - bipod)

	Returns:
		ARRAY of STRINGs

	Examples:
		_acclist = ["LMG_Mk200_F"] call CBA_fnc_compatibleItems;
		_muzzleacclist = ["LMG_Mk200_F", 101] call CBA_fnc_compatibleItems;

		0.478909 ms
*/

params [["_weapon", "", [""]], ["_typefilter", 0]];

_weapon = "arifle_Katiba_F";
_typeFilter = 201;

if (_weapon isEqualTo "") exitWith {[]};
_cfgWeapon = configfile >> "cfgweapons" >> _weapon;

if (isClass _cfgWeapon) then {
	_compatibleItems = [];
	{
		_cfgCompatibleItems = _x >> "compatibleItems";
		if (isarray _cfgCompatibleItems) then {
			{
				_compatibleItems pushBackUnique _x
			} forEach getArray _cfgCompatibleItems;
		} else {
			if (isclass _cfgCompatibleItems) then {
				{
					if (getnumber _x > 0) then {
						_compatibleItems pushBackUnique configname _x
					};
				} foreach configproperties [_cfgCompatibleItems, "isNumber _x"];
			};
		};
	} foreach configproperties [_cfgWeapon >> "WeaponSlotsInfo","isclass _x"];
	if (_typefilter isEqualTo 0) then {
		_compatibleItems
	} else {
		[_compatibleItems, {_typefilter == getnumber (configfile >> "cfgweapons" >> _x >> "itemInfo" >> "type")}] call BIS_fnc_conditionalSelect
	};
} else {
	["'%1' not found in CfgWeapons",_weapon] call bis_fnc_error;
	[]
};
