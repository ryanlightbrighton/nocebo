#include "\nocebo\defines\scriptDefines.hpp"

params ["_object","_cargoData","_contentsOfContents"];

// INPUT FORMAT IS [CONTAINERS,ITEMS,WEAPONS,MAGAZINES]
_cargoData params [
	["_backpacks",[],[]],
	["_items",[],[]],
	["_weapons",[],[]],
	["_magazines",[],[]]
];

// ADD CONTAINERS AND THEIR CONTENTS

{
	_x params ["_class","_contents"];
	if(_class isKindOf "Bag_Base") then {
		_object addBackPackCargoGlobal [_class,1];
	} else {
		_object addItemCargoGlobal [_class,1];
	};
	if (_contentsOfContents) then {
		private _containerID = (everyContainer _object select (count everyContainer _object - 1)) select 1;
		[_containerID,_contents,false] call horde_fnc_fillCargo;
	};
	true
} count _backpacks;

// ADD ITEMS

{
	_object addItemCargoGlobal [_x,1];
} count _items;

// ADD WEAPONS - ISSUE: CRAPPY WORKAROUND UNTIL PROPER COMMAND

// WEAPONS ARRAY FORMAT: [["arifle_MX_GL_F","muzzle_snds_H","acc_flashlight","optic_Arco",["30Rnd_65x39_caseless_mag",25],["1Rnd_HE_Grenade_shell",1],""]]
{
	private _countArr = count _x;
	// muzz, side, optic
	for "_i" from 1 to 3 do {
		if diff(sel(_x,_i),"") then {
			_object addItemCargoGlobal [sel(_x,_i),1];
		};
	};
	//
	for "_i" from 4 to _countArr - 2 do {
		private _arr = sel(_x,_i);
		if not empty(_arr) then {
			_object addMagazineAmmoCargo [sel(_arr,0),1,sel(_arr,1)];
		};
	};
	if diff(sel(_x,_countArr - 1),"") then {
		_object addItemCargoGlobal [sel(_x,_countArr - 1),1];
	};
	_object addWeaponCargoGlobal [sel(_x,0),1]
} count _weapons;

// ADD MAGAZINES

{
	_object addMagazineAmmoCargo [sel(_x,0),1,sel(_x,1)]
} count _magazines;

true

// EX: _ret = [car1,CARGO_DATA,true] call horde_fnc_fillCargo;

/*VAR1 = [car1,true] call horde_fnc_totalContents;
_ret = [car2,VAR1,true] call horde_fnc_fillCargo;*/