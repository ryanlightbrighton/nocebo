#include "\nocebo\defines\scriptDefines.hpp"

/*

	empty array means type is not considered

	else it will be [int,int,int,int] (lower & higher different types, lower & higher qty of each type)

	eg:

	_filled = [
		myCrate,
		[3,5,4,5],	// optics (between 3 and 5 different types, with 4-5 of each type)
		[3,5,4,5],	// vests
		[3,5,4,5],	// helmets
		[3,5,4,5],	// guns
		[3,5,4,5],	// backpacks
		[],			// no charges
		[1,2,1,2],	// medical
		[],			// no food
		[1,2,1,2],	// tools
		[1,2,1,2],	// tents
		[1,2,1,2],	// fuel
		[1,2,1,2],	// vehicle mags
		[1,2,1,2],	// launchers
		[1,2,1,2]	// vehicle parts
	] call horde_fnc_fillCrate;

	_filled = [
		myCrate,
		[],			// no optics
		[3,5,4,5],	// vests
		[3,5,4,5],	// helmets
		[],			// no guns
		[3,5,4,5],	// backpacks
		[1,2,1,2],	// charges
		[1,2,1,2],	// medical
		[1,2,1,2],	// food
		[1,2,1,2],	// tools
		[1,2,1,2],	// tents
		[],			// no fuel
		[]			// no vehicle mags
		[],			// no launchers
		[]			// no vehicle parts
	] call horde_fnc_fillCrate;

;*/
params ["_crate","_optics","_vests","_helmets","_guns","_backpacks","_charges","_medical","_food","_tools","_tents","_fuel","_vehicleMags","_launchers","_vehicleParts"];

private _cfgMagazines = configFile >> "CfgMagazines";

if not empty(_optics) then {
	_optics params ["_typesLower","_typesHigh","_qtyLow","_qtyHigh"];
	private _max = randInteg(_typesLower,_typesHigh);
	if (_max == 0) exitWith {};
	for "_i" from 1 to _max do {
		private _item = selectRandom ncb_gv_crateScopes;
		private _count = randInteg(_qtyLow,_qtyHigh);
		if (_count > 0) then {
			if (_crate canAdd [_item,_count]) then {
				_crate addItemCargoGlobal [
					_item,
					_count
				];
			};
		};
	};
};
if not empty(_vests) then {
	_vests params ["_typesLower","_typesHigh","_qtyLow","_qtyHigh"];
	private _max = randInteg(_typesLower,_typesHigh);
	if (_max == 0) exitWith {};
	for "_i" from 1 to _max do {
		private _item = selectRandom ncb_gv_crateVests;
		private _count = randInteg(_qtyLow,_qtyHigh);
		if (_count > 0) then {
			if (_crate canAdd [_item,_count]) then {
				_crate addItemCargoGlobal [
					_item,
					_count
				];
			};
		};
	};
};
if not empty(_helmets) then {
	_helmets params ["_typesLower","_typesHigh","_qtyLow","_qtyHigh"];
	private _max = randInteg(_typesLower,_typesHigh);
	if (_max == 0) exitWith {};
	for "_i" from 1 to _max do {
		private _item = selectRandom ncb_gv_crateHelmets;
		private _count = randInteg(_qtyLow,_qtyHigh);
		if (_count > 0) then {
			if (_crate canAdd [_item,_count]) then {
				_crate addItemCargoGlobal [
					_item,
					_count
				];
			};
		};
	};
};
if not empty(_guns) then {
	_guns params ["_typesLower","_typesHigh","_qtyLow","_qtyHigh"];
	private _magTypesLower = 1;
	private _magTypesHigh = 5;
	private _magQtyLow = 1;
	private _magQtyHigh = 3;
	private _max = randInteg(_typesLower,_typesHigh);
	if (_max == 0) exitWith {};
	for "_i" from 1 to _max do {
		private _item = selectRandom ncb_gv_crateRifles;
		private _count = randInteg(_qtyLow,_qtyHigh);
		if (_count > 0) then {
			if (_crate canAdd [_item,_count]) then {
				_crate addItemCargoGlobal [
					_item,
					_count
				];
				private _cfgWeapon = configFile >> "CfgWeapons" >> _item;
				private _mags = getArray (_cfgWeapon >> "magazines") select {getNumber (_cfgMagazines >> _x >> "scope") == 2};
				for "_i" from 1 to randInteg(_magTypesLower,_magTypesHigh) do {
					private _item = selectRandom _mags;
					_count = randInteg(_magQtyLow,_magQtyHigh);
					if (_count > 0) then {
						if (_crate canAdd [_item,_count]) then {
							for "_j" from 1 to _count do {
								_crate addMagazineAmmoCargo [
									_item,
									1,
									(floor random (getNumber (_cfgMagazines >> _item >> "count"))) + 1
								];
							};
						};
					};
				};
				private _muzzleArr = getArray (_cfgWeapon >> "muzzles");
				if (count _muzzleArr > 1) then {
					private _grenadeArr = getArray (_cfgWeapon >> sel(_muzzleArr,1) >> "magazines");
					_grenadeArr = _grenadeArr select {getNumber (_cfgMagazines >> _x >> "scope") == 2};
					if not empty(_grenadeArr) then {
						private _grenade = sel(_grenadeArr,0);
						_count = randInteg(2,5);
						if (_crate canAdd [_grenade,_count]) then {
							_crate addMagazineCargoGlobal [
								_grenade,
								_count
							];
						};
					};
				};
			};
		};
	};
};
if not empty(_backpacks) then {
	_backpacks params ["_typesLower","_typesHigh","_qtyLow","_qtyHigh"];
	private _max = randInteg(_typesLower,_typesHigh);
	if (_max == 0) exitWith {};
	for "_i" from 1 to _max do {
		private _item = selectRandom ncb_gv_crateBackpacks;
		private _count = randInteg(_qtyLow,_qtyHigh);
		if (_count > 0) then {
			if (_crate canAdd [_item,_count]) then {
				_crate addBackpackCargoGlobal [
					_item,
					_count
				];
			};
		};
	};
};
if not empty(_charges) then {
	_charges params ["_typesLower","_typesHigh","_qtyLow","_qtyHigh"];
	private _max = randInteg(_typesLower,_typesHigh);
	if (_max == 0) exitWith {};
	for "_i" from 1 to _max do {
		private _item = selectRandom ncb_gv_crateStickyBombs;
		private _count = randInteg(_qtyLow,_qtyHigh);
		if (_count > 0) then {
			if (_crate canAdd [_item,_count]) then {
				_crate addMagazineCargoGlobal [
					_item,
					_count
				];
			};
		};
	};
};

if not empty(_medical) then {
	_medical params ["_typesLower","_typesHigh","_qtyLow","_qtyHigh"];
	private _max = randInteg(_typesLower,_typesHigh);
	if (_max == 0) exitWith {};
	for "_i" from 1 to _max do {
		private _item = selectRandom ncb_gv_crateMedicalItems;
		private _count = randInteg(_qtyLow,_qtyHigh);
		if (_count > 0) then {
			if (_crate canAdd [_item,_count]) then {
				_crate addItemCargoGlobal [
					_item,
					_count
				];
			};
		};
	};
};

if not empty(_food) then {
	_food params ["_typesLower","_typesHigh","_qtyLow","_qtyHigh"];
	private _max = randInteg(_typesLower,_typesHigh);
	if (_max == 0) exitWith {};
	for "_i" from 1 to _max do {
		private _item = selectRandom ncb_gv_crateFoodItems;
		private _count = randInteg(_qtyLow,_qtyHigh);
		if (_count > 0) then {
			if (_crate canAdd [_item,_count]) then {
				_crate addItemCargoGlobal [
					_item,
					_count
				];
			};
		};
	};
};

if not empty(_tools) then {
	_tools params ["_typesLower","_typesHigh","_qtyLow","_qtyHigh"];
	private _max = randInteg(_typesLower,_typesHigh);
	if (_max == 0) exitWith {};
	for "_i" from 1 to _max do {
		private _item = selectRandom ncb_gv_crateToolItems;
		private _count = randInteg(_qtyLow,_qtyHigh);
		if (_count > 0) then {
			if (_crate canAdd [_item,_count]) then {
				_crate addItemCargoGlobal [
					_item,
					_count
				];
			};
		};
	};
};

if not empty(_tents) then {
	_tents params ["_typesLower","_typesHigh","_qtyLow","_qtyHigh"];
	private _max = randInteg(_typesLower,_typesHigh);
	if (_max == 0) exitWith {};
	for "_i" from 1 to _max do {
		private _item = selectRandom ncb_gv_crateTentItems;
		private _count = randInteg(_qtyLow,_qtyHigh);
		if (_count > 0) then {
			if (_crate canAdd [_item,_count]) then {
				_crate addItemCargoGlobal [
					_item,
					_count
				];
			};
		};
	};
};

if not empty(_fuel) then {
	_fuel params ["_typesLower","_typesHigh","_qtyLow","_qtyHigh"];
	private _max = randInteg(_typesLower,_typesHigh);
	if (_max == 0) exitWith {};
	for "_i" from 1 to _max do {
		private _item = selectRandom ncb_gv_crateFuelItems;
		private _count = randInteg(_qtyLow,_qtyHigh);
		if (_count > 0) then {
			if (_crate canAdd [_item,_count]) then {
				_crate addItemCargoGlobal [
					_item,
					_count
				];
			};
		};
	};
};
if not empty(_vehicleMags) then {
	_vehicleMags params ["_typesLower","_typesHigh","_qtyLow","_qtyHigh"];
	private _max = randInteg(_typesLower,_typesHigh);
	if (_max == 0) exitWith {};
	for "_i" from 1 to _max do {
		private _item = selectRandom ncb_gv_crateVehicleMags;
		private _count = randInteg(_qtyLow,_qtyHigh);
		if (_count > 0) then {
			if (_crate canAdd [_item,_count]) then {
				for "_j" from 1 to _count do {
					_crate addMagazineAmmoCargo [
						_item,
						1,
						(floor random (getNumber (_cfgMagazines >> _item >> "count"))) + 1
					];
				};
			};
		};
	};
};
if not empty(_launchers) then {
	_launchers params ["_typesLower","_typesHigh","_qtyLow","_qtyHigh"];
	private _magTypesLower = 1;
	private _magTypesHigh = 5;
	private _magQtyLow = 1;
	private _magQtyHigh = 3;
	private _max = randInteg(_typesLower,_typesHigh);
	if (_max == 0) exitWith {};
	for "_i" from 1 to _max do {
		private _item = selectRandom ncb_gv_crateLaunchers;
		private _count = randInteg(_qtyLow,_qtyHigh);
		if (_count > 0) then {
			if (_crate canAdd [_item,_count]) then {
				_crate addItemCargoGlobal [
					_item,
					_count
				];
				private _cfgWeapon = configFile >> "CfgWeapons" >> _item;
				private _mags = getArray (_cfgWeapon >> "magazines") select {getNumber (_cfgMagazines >> _x >> "scope") == 2};
				for "_i" from 1 to randInteg(_magTypesLower,_magTypesHigh) do {
					private _item = selectRandom _mags;
					_count = randInteg(_magQtyLow,_magQtyHigh);
					if (_count > 0) then {
						if (_crate canAdd [_item,_count]) then {
							for "_j" from 1 to _count do {
								_crate addMagazineAmmoCargo [
									_item,
									1,
									1
								];
							};
						};
					};
				};
			};
		};
	};
};
if not empty(_vehicleParts) then {
	_vehicleParts params ["_typesLower","_typesHigh","_qtyLow","_qtyHigh"];
	private _max = randInteg(_typesLower,_typesHigh);
	if (_max == 0) exitWith {};
	for "_i" from 1 to _max do {
		private _item = selectRandom ncb_gv_crateVehicleParts;
		private _count = randInteg(_qtyLow,_qtyHigh);
		if (_count > 0) then {
			if (_crate canAdd [_item,_count]) then {
				_crate addBackpackCargoGlobal [
					_item,
					_count
				];
			};
		};
	};
};

true
