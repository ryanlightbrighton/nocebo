#include "\nocebo\defines\scriptDefines.hpp"

params ["_object","_contentsOfContents"];

private _everyContainer = everyContainer _object;
private _containerDataArr = [];
{
	if (_contentsOfContents) then {
		private _ret = [sel(_x,1),false] call horde_fnc_totalContents;
		_containerDataArr pushBack [sel(_x,0),_ret];
	} else {
		_containerDataArr pushBack [sel(_x,0),[]];
	};
	true
} count _everyContainer;

private _itemArr = [];
{
	if (not (getArray (configFile >> "CfgWeapons" >> _x >> "allowedslots") isEqualTo [901])) then {
		_itemArr pushBack _x;
	};
	true
} count itemCargo _object;
// static weaps and some cargo return nil
private _weaps = weaponsItemsCargo _object;
private _mags = magazinesAmmoCargo _object;
private _totalCargo = [
	_containerDataArr,
	_itemArr,
	if (isNil "_weaps") then {[]} else {_weaps},
	if (isNil "_mags") then {[]} else {_mags}
];
_totalCargo

// EX: _ret = [car1,true] call horde_fnc_totalContents;

// NOTE: RETURN IS IN THIS FORMAT:

/*[CONTAINERS,ITEMS,WEAPONS,MAGAZINES]

EACH CONTAINER ELEMENT IS [CLASS,CONTENTS(containers,items,weapons,magazines)]

[
	// containers and their contents (in the same format)
	[
		[
			"V_Rangemaster_belt",
			[
				[],
				[],
				[],
				[
					["HandGrenade",1],
					["ItemBandage",30],
					["ItemBandage",30],
					["ItemCanDrink",30],
					["HandGrenade",1]
				]
			]
		],


		[
			"B_Carryall_oli",
			[
				[
					["U_I_CombatUniform",[]]
				],
				[
					"G_Aviator",
					"ItemCompass"
				],
				[
					["hgun_ACPC2_F","","","",["9Rnd_45ACP_Mag",9]]
				],
				[
					["ItemTent",30],
					["9Rnd_45ACP_Mag",9],
					["16Rnd_9x21_Mag",16],
					["16Rnd_9x21_Mag",16],
					["16Rnd_9x21_Mag",16]
				];
			];
		];
	];

	// returned items
	[
		"I_UavTerminal",
		"ItemPass_MasterAll",
		"G_Balaclava_blk"
	],

	// weapons
	[
		["hgun_P07_F","muzzle_snds_L","","",["16Rnd_9x21_Mag",16]]
	],

	// magazines
	[
		["ItemMedPack",30],
		["30Rnd_556x45_Stanag_Tracer_Yellow",30],
		["30Rnd_556x45_Stanag_Tracer_Yellow",30]
	],
];*/