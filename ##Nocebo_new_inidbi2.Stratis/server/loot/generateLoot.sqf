#include "\nocebo\defines\scriptDefines.hpp"

private _cfgHouse = cfgVeh >> typeOf _this;
private _buildingType = getText (_cfgHouse >> "horde_objectType"); // string like "B_MEDICAL"
/*_houseValue = getNumber (_cfgHouse >> "horde_lootPriority"); // 0 - 4*/
private _houseValue = getNumber (_cfgHouse >> "horde_objectLootSpots"); // 0 - 4 (-1 if no loot)
if (({typeOf _this isKindOf _x} count ncb_gv_alarmBuildingBaseClasses > 0)) then {
	_houseValue = 99;
};
if (_houseValue == -1) exitWith {false};
call {
    if (_houseValue < 5) exitWith {
        _houseValue = 0
    };
    if (_houseValue < 11) exitWith {
        _houseValue = 1
    };
    if (_houseValue < 31) exitWith {
        _houseValue = 2
    };
    if (_houseValue < 51) exitWith {
        _houseValue = 3
    };
    _houseValue = 4
};

private _itemsCount = round random ncb_param_baseNumbItemsLootPerPile;
private _assignedToZone = true;
if (isNil {getVar(_this,"objectAssignedToZone")}) then {
	_assignedToZone = false;
	_itemsCount = round random (ncb_param_baseNumbItemsLootPerPile * 0.5);
};
if (_houseValue > 0) then {
	_itemsCount = _itemsCount + _houseValue;
};
private _spawnAmmoBoxes = false;
if (_buildingType in ["B_MILITARY","B_MEDICAL"]) then {
	_itemsCount = _itemsCount + 2;
	if (_houseValue > 0) then {
		_houseValue = _houseValue + 1;
		_spawnAmmoBoxes = true;
	};
};
private _lootHousePositions = getArray (_cfgHouse >> "lootData");
private _thisData = [];
if (not empty(_lootHousePositions)
	and {_itemsCount > 0}
) then {
	/*diag_log format ["_lootHousePositions %1",_lootHousePositions];*/
	private _cfgBuildingType = missionConfigFile >> "CfgLoot" >> _buildingType; // ex: "B_CHURCH"
	for "_i" from 0 to count _lootHousePositions - 1 do {
		/*diag_log format ["checking loot (loot index) %1",_i];*/
		if (random 1 <= ncb_param_lootHolderDensity) then {
			private _holderClass = "ncb_obj_ground_weapon_holder";
			private _countItemsHolder = (round random _itemsCount) max 1;
			/*diag_log format ["_countItemsHolder %1",_countItemsHolder];*/
			if (_spawnAmmoBoxes and {random 1 > 0.8}) then {
				_holderClass = "ncb_obj_ammobox_s";
				_countItemsHolder = _itemsCount + (round random _itemsCount);
			};
			private _containers = [];
			private _items = [];
			private _weapons = [];
			private _magazines = [];
			for "_i" from 1 to _countItemsHolder do {
				private _random1 = random 1;
				for "_j" from 0 to count _cfgBuildingType - 1 do { // "Ammo" >> "Backpacks" >> "Clothing" >> "Consumables" etc
					private _cfgLootCategory = sel(_cfgBuildingType,_j);
					if (isClass _cfgLootCategory
						and {_random1 <= getNumber (_cfgLootCategory >> "probability")}
					) exitWith {
						private _random2 = random 1;
						if (not _assignedToZone) then {
							_random2 = _random2 max 0.5;
						};
						for "_k" from 0 to count _cfgLootCategory - 1 do { // "A_food" >> "B_Drink" etc
							private _cfgLootSubCategory = sel(_cfgLootCategory,_k);
							if (isClass _cfgLootSubCategory
								and {_random2 <= getNumber (_cfgLootSubCategory >> "threshold")}
							) exitWith {
								private _lootArrays = getArray (_cfgLootSubCategory >> "loot");
								private _numb = floor random [
									0,
									linearConversion [0,4,random _houseValue,0,count _lootArrays,true],
									count _lootArrays - 1
								];
								private _lootArr = _lootArrays select _numb;
								if (_lootArr isEqualType "") then {
									_lootArr = missionNamespace getVariable [_lootArr,[]];
								};
								if not (_lootArr isEqualTo []) then {
									private _cand = selectRandom _lootArr;
									// now we put the class in the right place [CONTAINERS,ITEMS,WEAPONS,MAGAZINES]
									call {
										if (_cand isKindOf "Bag_Base") exitWith {
											// container
											_containers pushBack [_cand,[[],[],[],[]]];
										};
										private _cfgItem = configFile >> "CfgMagazines" >> _cand;
										if (isClass _cfgItem) exitWith {
											// magazine
											private _maxCount = getNumber (_cfgItem >> "count");
											_magazines pushBack [
												_cand,
												randInteg(1,_maxCount)
											];
										};
										if (_cand isKindOf ["Rifle",cfgWeap]
											or {_cand isKindOf ["Pistol",cfgWeap]}
											or {_cand isKindOf ["Launcher",cfgWeap]}
										) then {
											// weapon
											private _cfgRifle = cfgWeap >> _cand;
											private _magArr = getArray (_cfgRifle >> "magazines");
											private _muzzleArr = getArray (_cfgRifle >> "muzzles");
											private _mag = selectRandom _magArr;
											private _maxCount = getNumber (cfgMag >> _mag >> "count");
											if (count _muzzleArr > 1) then {
												private _uglArr = getArray (_cfgRifle >> sel(_muzzleArr,1) >> "magazines");
												_weapons pushBack [_cand,"","","",[_mag,randInteg(1,_maxCount)],[rand(_uglArr),1],""];
											} else {
												_weapons pushBack [_cand,"","","",[_mag,randInteg(1,_maxCount)],""];
											};
											// up to 2 extra random mags
											if (random 1 > 0.33) then {
												for "_l" from 1 to randInteg(1,2) do {
													private _mag = selectRandom _magArr;
													private _maxCount = getNumber (cfgMag >> _mag >> "count");
													_magazines pushBack [_mag,randInteg(1,_maxCount)];
												};
											};
										} else {
											// item
											_items pushBack _cand;
										};
									};
								} else {
									private _type = typeOf _this;
									diag("-----------");
									diag(,_type);
									diag(_lootArrays);
									diag(_numb);
									diag("-----------");
								};
							};
						};
					};
				};
			};
			private _somePos = _this modelToWorld sel(_lootHousePositions,_i);
			if (surfaceIsWater _somePos) then {
				_somePos = _somePos vectorAdd [0,0,-1 *(getTerrainHeightASL _somePos)];
			};
			_thisData pushBack [
				_holderClass,
				/*_this modelToWorld sel(_lootHousePositions,_i),*/
				_somePos,
				[_containers,_items,_weapons,_magazines]
			];
		};
	};
};

_this setVariable ["HOUSE_LOOT_DATA",[time,_thisData]];

true