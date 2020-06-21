#include "\nocebo\defines\scriptDefines.hpp"

// only spawns locally now (less hassle on network and if player discos before clearing the objects up, then objects aren't stranded in the game world - poss fix is to update the disconnect missionEventHandler to search for these items)

// https://forums.bistudio.com/topic/187670-new-command-createobject-for-decorative-objects/?p=2982372

private _fnc_getModelPath = {
	private _var = getText (configfile >> "CfgVehicles" >> _this >> "model");
	if (_var find ".p3d" == -1) then {
		_var = _var + ".p3d"
	};
	_var
};

private _thingsArr = [];
params ["_category","_item"];
private _handVehClass = getText (configfile >> "CfgWeapons" >> _item >> "ncb_objectClass");

// exception for defib (don't want players waving it about)

if (_item == "ItemDefibrillator") then {
	_handVehClass = "Land_Bandage_F"
};

private _hand = "RightHand";
if (_category == "medical") then {
	_hand = "LeftHand";
};
if diff(_handVehClass,"") then {
	private _thing = _handVehClass createVehicleLocal [200,200,200];
	_thing attachTo [player,[0,0,0],_hand];
	_thingsArr pushBack _thing;
	call {
		if (_item == "ItemHammer") exitWith {
			_thing attachTo [player,[0,0,0.1],_hand];
			_thing setVectorDirAndUp [[0,1,1],[0,0,1]];
		};
		if (_item == "ItemGrinder") exitWith {
			_thing attachTo [player,[-0.1,0.1,0],_hand];
			_thing setVectorDirAndUp [[0,-1,0],[0,0,1]];
		};
		if (_item == "ItemDrill") exitWith {
			_thing attachTo [player,[0,-0.05,-0.15],_hand];
		};
		if (_item == "ItemMedPack") exitWith {
			_thing attachTo [player,[0,-0.05,0.6],_hand];
		};
		if (_item == "ItemCanBacon") exitWith {
			_thing attachTo [player,[0,0,-0.07],_hand];
		};
		if (_item == "ItemRice") exitWith {
			_thing attachTo [player,[0,0,-0.07],_hand];
		};
		if (_item == "ItemCereal") exitWith {
			_thing attachTo [player,[0,0,-0.07],_hand];
			_thing setVectorDirAndUp  [[2.2,1,0],[0,0,1]];
		};
		if (_item == "ItemCanteen") exitWith {
			_thing attachTo [player,[-0.03,0,-0.07],_hand];
		};
		if (_item == "ItemBottleDrink") exitWith {
			_thing attachTo [player,[-0.03,0,-0.07],_hand];
		};
		if (_item == "ItemCanDrink") exitWith {
			_thing attachTo [player,[-0.03,0,-0.07],_hand];
		};
		if (_item == "ItemCanDrink2") exitWith {
			_thing attachTo [player,[-0.03,0,-0.07],_hand];
		};
		if (_item == "ItemCanDrink3") exitWith {
			_thing attachTo [player,[-0.03,0,-0.07],_hand];
		};
		if (_item == "ItemPliers"
			and {_category == "medical"}
		) exitWith {
			_thing setVectorDirAndUp [[0,-1,0],[0,0,1]];
		};
	};
};

private _things = [];

call {
	if (_category == "medical") exitWith {
		_things = [
			["Land_DisinfectantSpray_F" call _fnc_getModelPath,1,false],
			["Horde_Item_Medkit" call _fnc_getModelPath,1,true]
		];
		{
			if (_x isKindOf ["ItemBaseMedical",configFile >> "CfgWeapons"]) then {
				_things pushBack [(getText (configFile >> "CfgWeapons" >> _x >> "ncb_objectClass")) call _fnc_getModelPath,1,true]
			};
		} forEach ((assignedItems player) + (items player));
	};
	if (_category == "repair") exitWith {
		_things = [
			["Item_Toolkit" call _fnc_getModelPath,1,true],
			["Land_DuctTape_F" call _fnc_getModelPath,3,false],
			["Land_DustMask_F" call _fnc_getModelPath,1,false],
			["Land_ExtensionCord_F" call _fnc_getModelPath,1,true],
			["Land_CanisterOil_F" call _fnc_getModelPath,1,true],
			["Land_CarBattery_02_F" call _fnc_getModelPath,1,false],
			["Land_CarBattery_01_F" call _fnc_getModelPath,1,false],
			["Land_Gloves_F" call _fnc_getModelPath,1,false],
			["Land_ButaneTorch_F" call _fnc_getModelPath,1,true]
		];
		{
			if diff(_item,_x) then {
				if (_x isKindOf ["ItemBaseTool",configFile >> "CfgWeapons"]) then {
					_things pushBack [(getText (configFile >> "CfgWeapons" >> _x >> "ncb_objectClass")) call _fnc_getModelPath,1,true]
				};
			};
		} forEach ((assignedItems player) + (items player));
	};
	if (_category == "tyre") exitWith {
		_things = [
			["Land_Tyre_F" call _fnc_getModelPath,1,true]
		];
		{
			if diff(_item,_x) then {
				if (_x isKindOf ["ItemBaseTool",configFile >> "CfgWeapons"]) then {
					_things pushBack [(getText (configFile >> "CfgWeapons" >> _x >> "ncb_objectClass")) call _fnc_getModelPath,1,true]
				};
			};
		} forEach ((assignedItems player) + (items player));
	};
	if (_category == "eat") exitWith {
		_things = [
			["Land_CanOpener_F" call _fnc_getModelPath,1,false],
			["Land_GasCooker_F" call _fnc_getModelPath,1,false],
			["Land_Ketchup_01_F" call _fnc_getModelPath,1,false],
			["Land_Matches_F" call _fnc_getModelPath,1,false],
			["Land_Mustard_01_F" call _fnc_getModelPath,1,false],
			["Land_Tableware_01_cup_F" call _fnc_getModelPath,1,false],
			["Land_Tableware_01_fork_F" call _fnc_getModelPath,1,false],
			["Land_Tableware_01_knife_F" call _fnc_getModelPath,1,false],
			["Land_Tableware_01_napkin_F" call _fnc_getModelPath,1,false],
			["Land_Tableware_01_spoon_F" call _fnc_getModelPath,1,false],
			["Land_Tableware_01_stackOfNapkins_F" call _fnc_getModelPath,1,false],
			["Land_Tableware_01_tray_F" call _fnc_getModelPath,1,false]
		];
		{
			if (_x isKindOf ["ItemBaseFood",configFile >> "CfgWeapons"]) then {
				_things pushBack [(getText (configFile >> "CfgWeapons" >> _x >> "ncb_objectClass")) call _fnc_getModelPath,1,true]
			};
		} forEach ((assignedItems player) + (items player));
	};
	if (_category == "fuel") exitWith {
		_things = [
			/*["Land_CanisterFuel_F",1,true]*/
		];
	};
	if (_category == "ammo") exitWith {
		_things = [
			["Land_Magazine_rifle_F" call _fnc_getModelPath,5,false],
			// ["Land_Box_AmmoOld_F" call _fnc_getModelPath,1,false],
			["Land_Ammobox_rounds_F" call _fnc_getModelPath,1,false]
		];
	};
	if (_category == "chopwood") exitWith {
		_things = [
			// ["Land_WoodPile_F" call _fnc_getModelPath,1,false],
			["Land_WoodenLog_F" call _fnc_getModelPath,4,false]
		];
		{
			if diff(_item,_x) then {
				if (_x isKindOf ["ItemBaseTool",configFile >> "CfgWeapons"]) then {
					_things pushBack [(getText (configFile >> "CfgWeapons" >> _x >> "ncb_objectClass")) call _fnc_getModelPath,1,true]
				};
			};
		} forEach ((assignedItems player) + (items player));
	};
	// do some for vehicles and other interactions
};

// new bit to add light source
/*if (sunOrMoon < 1) then {
	_things pushBack ["Land_Camping_Light_F" call _fnc_getModelPath,1,true]
};*/

/*diag("things",_things);*/

private _playPos = getPosATL player;
private _playDir = getDir player;
{
	_x params ["_modelPath","_qty","_true"];
	for "_i" from 1 to _qty do {
		if (_true
			or {random 1 > 0.5}
		) then {
			private _dist = random 1.7 max 1;
			private _deg = (random 90) + 45;

			if (random 1 > 0.5) then {
				_deg = 225 + random 90; // 225 - 315
			};
			_deg = _deg + _playDir;
			_deg = _deg call horde_fnc_normalDir;
			private _worldPos = [
				sel(_playPos,0) + _dist * sin _deg,
				sel(_playPos,1) + _dist * cos _deg,
				sel(_playPos,2)
			];
			// try new decorative objects to make them global
			_thing = createSimpleObject [
				_modelPath select [1,1000],
				_worldPos
			];
			_thing setPosATL _worldPos;
			_thing setDir random 360;
			_thingsArr pushBack _thing;
		};
	};
} forEach _things;

_thingsArr

/*

private ["_things","_thingsArr","_playPos","_dist","_deg","_worldPos","_thing"];

_thingsArr = [];

_category = sel(_this,0);
_item = sel(_this,1);
_handVehClass = getText (configfile >> "CfgWeapons" >> _item >> "ncb_objectClass");

// exception for defib (don't want players waving it about)

if (_item == "ItemDefibrillator") then {
	_handVehClass = "Land_Bandage_F"
};

_hand = "RightHand";
if (_category == "medical") then {
	_hand = "LeftHand";
};
if diff(_handVehClass,"") then {
	_thing = _handVehClass createVehicleLocal [200,200,200];
	_thing attachTo [player,[0,0,0],_hand];
	_thingsArr pushBack _thing
	call {
		if (_item == "ItemHammer") exitWith {
			_thing attachTo [player,[0,0,0.1],_hand];
			_thing setVectorDirAndUp [[0,1,1],[0,0,1]];
		};
		if (_item == "ItemGrinder") exitWith {
			_thing attachTo [player,[-0.1,0.1,0],_hand];
			_thing setVectorDirAndUp [[0,-1,0],[0,0,1]];
		};
		if (_item == "ItemDrill") exitWith {
			_thing attachTo [player,[0,-0.05,-0.15],_hand];
		};
		if (_item == "ItemMedPack") exitWith {
			_thing attachTo [player,[0,-0.05,0.6],_hand];
		};
		if (_item == "ItemCanBacon") exitWith {
			_thing attachTo [player,[0,0,-0.07],_hand];
		};
		if (_item == "ItemRice") exitWith {
			_thing attachTo [player,[0,0,-0.07],_hand];
		};
		if (_item == "ItemCereal") exitWith {
			_thing attachTo [player,[0,0,-0.07],_hand];
			_thing setVectorDirAndUp  [[2.2,1,0],[0,0,1]];
		};
		if (_item == "ItemCanteen") exitWith {
			_thing attachTo [player,[-0.03,0,-0.07],_hand];
		};
		if (_item == "ItemBottleDrink") exitWith {
			_thing attachTo [player,[-0.03,0,-0.07],_hand];
		};
		if (_item == "ItemCanDrink") exitWith {
			_thing attachTo [player,[-0.03,0,-0.07],_hand];
		};
		if (_item == "ItemCanDrink2") exitWith {
			_thing attachTo [player,[-0.03,0,-0.07],_hand];
		};
		if (_item == "ItemCanDrink3") exitWith {
			_thing attachTo [player,[-0.03,0,-0.07],_hand];
		};
		if (_item == "ItemPliers"
			and {_category == "medical"}
		) exitWith {
			_thing setVectorDirAndUp [[0,-1,0],[0,0,1]];
		};
	};
};

_things = [];

call {
	if (_category == "medical") exitWith {
		_things = [
			["Land_DisinfectantSpray_F",1,false],
			["Horde_Item_Medkit",1,true]
		];
		{
			if (_x isKindOf ["ItemBaseMedical",configFile >> "CfgWeapons"]) then {
				_things pushBack [getText (configFile >> "CfgWeapons" >> _x >> "ncb_objectClass"),1,true]
			};
		} forEach ((assignedItems player) + (items player));
	};
	if (_category == "repair") exitWith {
		_things = [
			["Item_Toolkit",1,true],
			["Land_DuctTape_F",3,false],
			["Land_DustMask_F",1,false],
			["Land_ExtensionCord_F",1,true],
			["Land_CanisterOil_F",1,true],
			["Land_CarBattery_02_F",1,false],
			["Land_CarBattery_01_F",1,false],
			["Land_Gloves_F",1,false],
			["Land_ButaneTorch_F",1,true]
		];
		{
			if diff(_item,_x) then {
				if (_x isKindOf ["ItemBaseTool",configFile >> "CfgWeapons"]) then {
					_things pushBack [getText (configFile >> "CfgWeapons" >> _x >> "ncb_objectClass"),1,true]
				};
			};
		} forEach ((assignedItems player) + (items player));
	};
	if (_category == "tyre") exitWith {
		_things = [
			["Land_Tyre_F",1,true]
		];
		{
			if diff(_item,_x) then {
				if (_x isKindOf ["ItemBaseTool",configFile >> "CfgWeapons"]) then {
					_things pushBack [getText (configFile >> "CfgWeapons" >> _x >> "ncb_objectClass"),1,true]
				};
			};
		} forEach ((assignedItems player) + (items player));
	};
	if (_category == "eat") exitWith {
		_things = [
			["Land_CanOpener_F",1,false],
			["Land_GasCooker_F",1,false],
			["Land_Ketchup_01_F",1,false],
			["Land_Matches_F",1,false],
			["Land_Mustard_01_F",1,false],
			["Land_Tableware_01_cup_F",1,false],
			["Land_Tableware_01_fork_F",1,false],
			["Land_Tableware_01_knife_F",1,false],
			["Land_Tableware_01_napkin_F",1,false],
			["Land_Tableware_01_spoon_F",1,false],
			["Land_Tableware_01_stackOfNapkins_F",1,false],
			["Land_Tableware_01_tray_F",1,false]
		];
		{
			if (_x isKindOf ["ItemBaseFood",configFile >> "CfgWeapons"]) then {
				_things pushBack [getText (configFile >> "CfgWeapons" >> _x >> "ncb_objectClass"),1,true]
			};
		} forEach ((assignedItems player) + (items player));
	};
	if (sel(_this,0) == "fuel") exitWith {
		_things = [
			// ["Land_CanisterFuel_F",1,true]
		];
	};
	if (sel(_this,0) == "ammo") exitWith {
		_things = [
			["Land_Magazine_rifle_F",5,false],
			// ["Land_Box_AmmoOld_F",1,false],
			["Land_Ammobox_rounds_F",1,false]
		];
	};
	// do some for vehicles and other interactions
};

// new bit to add light source
if (sunOrMoon < 1) then {
	_things pushBack ["Land_Camping_Light_F",1,true]
};

_playPos = getPosATL player;
_playDir = getDir player;
{
	_class = sel(_x,0);
	_qty = sel(_x,1);
	_true = sel(_x,2);
	for "_i" from 1 to _qty do {
		if (_true
			or {random 1 > 0.5}
		) then {
			_dist = random 1.7 max 1;
			_deg = (random 90) + 45;

			if (random 1 > 0.5) then {
				_deg = 225 + random 90; // 225 - 315
			};
			_deg = _deg + _playDir;
			_deg = _deg call horde_fnc_normalDir;
			_worldPos = [
				sel(_playPos,0) + _dist * sin _deg,
				sel(_playPos,1) + _dist * cos _deg,
				sel(_playPos,2)
			];
			_thing = _class createVehicleLocal _worldPos;
			// try new decorative objects to make them global
			// setup array (do this better later)
			// _thing = createSimpleObject [
			// 	getModelInfo _class,
			// 	_worldPos
			// ];
			_thing setPosATL _worldPos;
			_thing setDir random 360;
			_thingsArr pushBack _thing;
		};
	};
} forEach _things;

_thingsArr*/