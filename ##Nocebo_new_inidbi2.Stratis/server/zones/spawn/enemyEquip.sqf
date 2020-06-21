#include "\nocebo\defines\scriptDefines.hpp"

params [
	"_unit",							// the unit!
	"_uniforms",						// [thing1,thing2]
	"_vests",							// [thing1,thing2]
	"_backpackChance",					// 0 - 1
	"_backpacks",						// [thing1,thing2]
	"_hatChance",						// 0 - 1
	"_hats",							// [thing1,thing2]
	"_goggleChance",					// 0 - 1
	"_goggles",							// [thing1,thing2]
	"_nvgChance",						// 0 - 1
	"_nvGoggles",						// [thing1,thing2]
	"_primaryWeaponChance",				// 0 - 1
	"_primaryWeapons",					// [thing1,thing2]
	"_primaryWeaponMags",				// [lower numb of mags,higher numb of mags]
	"_primaryAttachmentBarrelChance",	// 0 - 1
	"_primaryAttachmentScopeChance",	// 0 - 1
	"_primaryAttachmentScopes",			// [thing1,thing2]
	"_primaryAttachmentPointerChance",	// 0 - 1
	"_primaryAttachmentPointers",		// [thing1,thing2]
	"_secondaryWeaponChance",			// 0 - 1
	"_secondaryWeapons",				// [thing1,thing2]
	"_secondaryWeaponMags",				// [lower numb of mags,higher numb of mags]
	"_handgunChance",					// 0 - 1
	"_handguns",						// [thing1,thing2]
	"_handgunMags",						// [lower numb of mags,higher numb of mags]
	"_handgunAttachmentBarrelChance",	// 0 - 1
	"_handgunAttachmentScopeChance",	// 0 - 1
	"_defaultItems",					// [thing1,thing2]
	"_randomItemData",					// [[[arrofitems1],%chance 0-1],[[arrofitems2],%chance 0-1]]
	"_skills"							// [general,aimingAccuracy,aimingShake,aimingSpeed,commanding,courage,endurance,reloadSpeed,spotDistance,spotTime]
];

// remove default gear (disabled for now as all nocebo units are deviod of gear - some other units from other mods will need this though)

/*removeAllContainers _unit;
removeAllWeapons _unit;
removeHeadgear _unit;
removeGoggles _unit;
{
	_unit unlinkItem _x;
} forEach assignedItems _unit;*/

// clothes

_unit forceAddUniform rand(_uniforms);
_unit addVest rand(_vests);
if (random 1 <= _backpackChance
	and {not empty(_backpacks)}
) then {
	_unit addBackpack rand(_backpacks);
};
if (random 1 <= _hatChance
	and {not empty(_hats)}
) then {
	_unit addHeadgear rand(_hats);
};
if (random 1 <= _goggleChance
	and {not empty(_goggles)}
) then {
	_unit addGoggles rand(_goggles);
};

// rifle

if (random 1 <= _primaryWeaponChance
	and {not empty(_primaryWeapons)}
) then {
	private _primaryWeapon = rand(_primaryWeapons);
	private _cfgPrimaryWeapon = cfgWeap >> _primaryWeapon;
	/*_realMags = getArray (_cfgPrimaryWeapon >> "magazines") select {getNumber (configFile >> "CfgMagazines" >> _x >> "scope") == 2};
	if not empty(_realMags) then {
		_unit addMagazines [
			selectRandom _realMags,
			randInteg(sel(_primaryWeaponMags,0),sel(_primaryWeaponMags,1))
		];
	};*/
	_unit addMagazines [
		selectRandom (getArray (_cfgPrimaryWeapon >> "magazines")),
		randInteg(sel(_primaryWeaponMags,0),sel(_primaryWeaponMags,1))
	];
	_unit addWeapon _primaryWeapon;

	if (random 1 <= _primaryAttachmentBarrelChance) then {
		private _arr = getArray(_cfgPrimaryWeapon >> "WeaponSlotsInfo" >> "MuzzleSlot" >> "compatibleItems");
		if not empty(_arr) then {
			_unit addPrimaryWeaponItem rand(_arr);
		};
	};
	if (random 1 <= _primaryAttachmentScopeChance) then {
		/*_arr = getArray(_cfgPrimaryWeapon >> "WeaponSlotsInfo" >> "CowsSlot" >> "compatibleItems");
		if not empty(_arr) then {*/
			_unit addPrimaryWeaponItem rand(_primaryAttachmentScopes);
		/*};*/
	};

	if (random 1 <= _primaryAttachmentPointerChance) then {
		private _arr = getArray(_cfgPrimaryWeapon >> "WeaponSlotsInfo" >> "PointerSlot" >> "compatibleItems");
		if not empty(_arr) then {
			_unit addPrimaryWeaponItem rand(_primaryAttachmentPointers);
		};
	};

	private _muzzleArr = getArray (_cfgPrimaryWeapon >> "muzzles");
	if (count _muzzleArr > 1) then {
		private _grenadeArr = getArray (_cfgPrimaryWeapon >> sel(_muzzleArr,1) >> "magazines");
		/*_grenadeArr = _grenadeArr select {getNumber (configFile >> "CfgMagazines" >> _x >> "scope") == 2};*/
		/*if not empty(_grenadeArr) then {*/
			_unit addMagazines [
				sel(_grenadeArr,0),
				randInteg(sel(_primaryWeaponMags,0),sel(_primaryWeaponMags,1))
			];
			// now add some flares
			{
				private _index = toLower _x find "flare";
				if (_index > -1) exitWith {
					_unit addMagazines [
						sel(_grenadeArr,_index),
						randInteg(1,4)
					];
				};
			} forEach _grenadeArr;
		/*};*/

		_unit selectWeapon sel(_muzzleArr,0);
	} else {
		_unit selectWeapon _primaryWeapon;
	};
};

// launcher

if (random 1 <= _secondaryWeaponChance
	and {not empty(_secondaryWeapons)}
) then {
	if same(backpack _unit,"") then {
		if empty(_backpacks) then {
			_unit addBackpack "B_AssaultPack_khk";
		} else {
			_unit addBackpack rand(_backpacks);
		};
	};
	private _secondaryWeapon = rand(_secondaryWeapons);
	private _cfgSecondaryWeapon = cfgWeap >> _secondaryWeapon;
	/*_realMags = getArray (_cfgSecondaryWeapon >> "magazines") select {getNumber (configFile >> "CfgMagazines" >> _x >> "scope") == 2};
	if not empty(_realMags) then {
		_unit addMagazines [
			selectRandom _realMags,
			randInteg(sel(_secondaryWeaponMags,0),sel(_secondaryWeaponMags,1))
		];
	};*/
	_unit addMagazines [
		selectRandom (getArray (_cfgSecondaryWeapon >> "magazines")),
		randInteg(sel(_secondaryWeaponMags,0),sel(_secondaryWeaponMags,1))
	];
	_unit addWeapon _secondaryWeapon;
};

// sidearm

if ((random 1 <= _handgunChance
	and {not empty(_handguns)})
	or {primaryWeapon _unit == ""}
) then {
	private _handgun = rand(_handguns);
	private _cfgHandgun = cfgWeap >> _handgun;
	/*_realMags = getArray (_cfgHandgun >> "magazines") select {getNumber (configFile >> "CfgMagazines" >> _x >> "scope") == 2};
	if not empty(_realMags) then {
		_unit addMagazines [
			selectRandom _realMags,
			randInteg(sel(_handgunMags,0),sel(_handgunMags,1))
		];
	};*/
	_unit addMagazines [
		selectRandom (getArray (_cfgHandgun >> "magazines")),
		randInteg(sel(_handgunMags,0),sel(_handgunMags,1))
	];
	_unit addWeapon _handgun;

	if (random 1 <= _handgunAttachmentBarrelChance) then {
		private _arr = getArray(_cfgHandgun >> "WeaponSlotsInfo" >> "MuzzleSlot" >> "compatibleItems");
		if not empty(_arr) then {
			_unit addHandgunItem rand(_arr);
		};
	};

	if (random 1 <= _handgunAttachmentScopeChance) then {
		private _arr = getArray(_cfgHandgun >> "WeaponSlotsInfo" >> "CowsSlot" >> "compatibleItems");
		if not empty(_arr) then {
			_unit addHandgunItem rand(_arr);
		};
	};
	if (primaryWeapon _unit == "") then {
		_unit selectWeapon _handgun;
	};
};

// default items

{
	_unit addItem _x
} count _defaultItems;

// nvg

if (random 1 <= _nvgChance
    and {not empty(_nvGoggles)}
) then {
	_unit linkItem selectRandom _nvGoggles
};

// _random items

{
	private _itemChance = sel(_x,1);
	{
		if (random 1 <= _itemChance) exitWith {
			_unit addItem _x
		};
	} count sel(_x,0)
} forEach _randomItemData;

// skills

_skills params ["_gen","_acc","_steady","_spd","_comm","_crge","_end","_reload","_sptDist","_spotTime"];
_unit setSkill _gen;
_unit setSkill ["aimingAccuracy",_acc];
_unit setSkill ["aimingShake",_steady];
_unit setSkill ["aimingSpeed",_spd];
_unit setSkill ["commanding",_comm];
_unit setSkill ["courage",_crge];
_unit setSkill ["endurance",_end];
_unit setSkill ["reloadSpeed",_reload];
_unit setSkill ["spotDistance",_sptDist];
_unit setSkill ["spotTime",_spotTime];

/*diag(_unit skillFinal "aimingAccuracy");
diag(_unit skillFinal "aimingShake");
diag(_unit skillFinal "aimingSpeed");
diag(_unit skillFinal "commanding");
diag(_unit skillFinal "courage");
diag(_unit skillFinal "endurance");
diag(_unit skillFinal "general");
diag(_unit skillFinal "reloadSpeed");
diag(_unit skillFinal "spotDistance");
diag(_unit skillFinal "spotTime");*/

// params

if (ncb_param_aiAimingError isEqualTo 0) then {
	_unit disableAI "aimingerror"
};
if (ncb_param_aiAutoCombat isEqualTo 0) then {
	_unit disableAI "autocombat"
};
if (ncb_param_aiCover isEqualTo 0) then {
	_unit disableAI "cover"
};
if (ncb_param_aiFSM isEqualTo 0) then {
	_unit disableAI "fsm"
};
if (ncb_param_aiStamina isEqualTo 0) then {
	_unit enableStamina false
};
if (ncb_param_aiSuppression isEqualTo 0) then {
	_unit disableAI "suppression"
};

//disable this as unit spawns in pool

_unit disableAI "checkvisible";

true
