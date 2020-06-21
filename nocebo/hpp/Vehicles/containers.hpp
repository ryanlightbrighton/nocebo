// AMMOBOXES & BACKPACKS

class Bag_Base : ReammoBox {
	horde_inventorySound = "horde_sound_linenInventory";
	class ItemActions {
		class Empty {
			text = "Empty contents (into vest & uniform)";
			script = "call horde_fnc_emptyBackpack";
		};
	};
};

// dummy test for ghilliesuit

// class ncb_obj_dummy_backpack : Bag_Base {
// 	author = "Das Attorney";
// 	displayName = "Ghille suit";
// 	mapSize = 0.01;
// 	model = "\A3\weapons_f\empty";
// 	maximumLoad = 0;
// 	mass = 0;
// 	transportMaxWeapons = 0;
// 	transportMaxMagazines = 0;
// };

// diver pack

class B_Assault_Diver;
class Diver_Pack : B_Assault_Diver {
	author = "Das Attorney";
	displayname = "NCB Diver Pack (Black)";
	mass = 15;
	maximumload = 60;
	transportmaxbackpacks = 0;
	transportmaxmagazines = 6;
	transportmaxweapons = 0;
	class TransportMagazines {};
	class TransportItems {};
};

class Weapon_Bag_Base : Bag_Base {
	class assembleInfo;
};
class PortableGenerator_backpack_F : Weapon_Bag_Base {
	author = "Das Attorney";
	displayname = "Portable Generator Bag";
	faction = "Default";
	hiddenselectionstextures[] = {"\A3\Drones_F\Weapons_F_Gamma\Ammoboxes\Bags\data\UAV_backpack_rgr_co.paa"};
	mapsize = 0.6;
	mass = 300;
	maximumload = 0;
	model = "\A3\Drones_F\Weapons_F_Gamma\Ammoboxes\Bags\UAV_backpack_F.p3d";
	picture = "\A3\Drones_F\Weapons_F_Gamma\ammoboxes\bags\data\ui\icon_B_C_UAV_rgr_ca";
	scope = 2;
	side = 3;
	class assembleInfo : assembleInfo {
		assembleto = "ncb_obj_portable_generator";
		base = "";
		displayname = "Portable Generator";
	};
	class ItemActions {
		class Assemble {
			text = "Unpack portable generator";
			script = "spawn horde_fnc_unpackPortableGenerator";
		};
	};
};
class ParaBeacon_backpack_F : Weapon_Bag_Base {
	author = "Das Attorney";
	displayname = "Para-Beacon Bag";
	faction = "Default";
	hiddenselectionstextures[] = {"\A3\Drones_F\Weapons_F_Gamma\Ammoboxes\Bags\data\UAV_backpack_rgr_co.paa"};
	mapsize = 0.6;
	mass = 300;
	maximumload = 0;
	model = "\A3\Drones_F\Weapons_F_Gamma\Ammoboxes\Bags\UAV_backpack_F.p3d";
	picture = "\A3\Drones_F\Weapons_F_Gamma\ammoboxes\bags\data\ui\icon_B_C_UAV_rgr_ca";
	scope = 2;
	side = 3;
	// class assembleInfo : assembleInfo {
	// 	assembleto = "ncb_obj_para_beacon";
	// 	base = "";
	// 	displayname = "Para-Beacon";
	// };
	class ItemActions {
		class AssemblePersonal {
			text = "Deploy para-beacon (personal)";
			script = "call {[_this,'personal'] spawn horde_fnc_unpackParaBeacon}";
		};
		class AssembleGroup {
			text = "Deploy para-beacon (group)";
			script = "call {[_this,'group'] spawn horde_fnc_unpackParaBeacon}";
		};
		class AssembleSide {
			text = "Deploy para-beacon (all)";
			script = "call {[_this,'side'] spawn horde_fnc_unpackParaBeacon}";
		};
	};
};
class Horde_VehiclePartsBag_Base : Bag_Base {
	author = "Das Attorney";
	faction = "Default";
	hiddenselectionstextures[] = {"\A3\Drones_F\Weapons_F_Gamma\Ammoboxes\Bags\data\UAV_backpack_rgr_co.paa"};
	horde_displayName = "";
	horde_health = 100;
	horde_magazineClass = "";
	horde_inventorySound = "horde_sound_magazineBeltInventory";
	mapsize = 0.6;
	mass = 400;
	maximumload = 0;
	model = "\A3\Drones_F\Weapons_F_Gamma\Ammoboxes\Bags\UAV_backpack_F.p3d";
	picture = "\A3\Drones_F\Weapons_F_Gamma\ammoboxes\bags\data\ui\icon_B_C_UAV_rgr_ca";
	side = 3;
	class ItemActions {};
};
class Horde_AircraftPartsBag_Base : Bag_Base {
	author = "Das Attorney";
	faction = "Default";
	hiddenselectionstextures[] = {"\A3\Drones_F\Weapons_F_Gamma\Ammoboxes\Bags\data\UAV_backpack_rgr_co.paa"};
	horde_displayName = "";
	horde_health = 100;
	horde_magazineClass = "";
	horde_inventorySound = "horde_sound_magazineBeltInventory";
	mapsize = 0.6;
	mass = 400;
	maximumload = 0;
	model = "\A3\Drones_F\Weapons_F_Gamma\Ammoboxes\Bags\UAV_backpack_F.p3d";
	picture = "\A3\Drones_F\Weapons_F_Gamma\ammoboxes\bags\data\ui\icon_B_C_UAV_rgr_ca";
	side = 3;
	class ItemActions {};
};
class ItemTyre_100 : Horde_VehiclePartsBag_Base {
	descriptionshort = "100% Health";
	displayname = "Tyre 100%";
	horde_classPrefix = "ItemTyre_";
	horde_displayName = "Tyre";
	horde_health = 100;
	horde_inventorySound = "horde_sound_linenInventory";
	mass = 100;
	// model = "\A3\Structures_F\Civ\Garbage\Tyre_F.p3d";
	picture = "nocebo\images\tyre.paa";
	scope = 2;
};
class ItemTyre_90 : ItemTyre_100 {
	displayname = "Tyre 90%";
	descriptionshort = "90% Health";
	horde_health = 90;
};
class ItemTyre_80 : ItemTyre_100 {
	displayname = "Tyre 80%";
	descriptionshort = "80% Health";
	horde_health = 80;
};
class ItemTyre_70 : ItemTyre_100 {
	displayname = "Tyre 70%";
	descriptionshort = "70% Health";
	horde_health = 70;
};
class ItemTyre_60 : ItemTyre_100 {
	displayname = "Tyre 60%";
	descriptionshort = "60% Health";
	horde_health = 60;
};
class ItemTyre_50 : ItemTyre_100 {
	displayname = "Tyre 50%";
	descriptionshort = "50% Health";
	horde_health = 50;
};
class ItemTyre_40 : ItemTyre_100 {
	displayname = "Tyre 40%";
	descriptionshort = "40% Health";
	horde_health = 40;
};
class ItemTyre_30 : ItemTyre_100 {
	displayname = "Tyre 30%";
	descriptionshort = "30% Health";
	horde_health = 30;
};
class ItemTyre_20 : ItemTyre_100 {
	displayname = "Tyre 20%";
	descriptionshort = "20% Health";
	horde_health = 20;
};
class ItemTyre_10 : ItemTyre_100 {
	displayname = "Tyre 10%";
	descriptionshort = "10% health";
	horde_health = 10;
};

class ItemEngine_100 : Horde_VehiclePartsBag_Base {
	descriptionshort = "100% Health";
	displayname = "Engine Parts 100%";
	horde_classPrefix = "ItemEngine_";
	horde_displayName = "Engine Parts";
	horde_health = 100;
	horde_inventorySound = "horde_sound_linenInventory";
	mass = 250;
	// model = "\A3\Structures_F\Items\Luggage\Suitcase_F.p3d";
	picture = "nocebo\images\engine.paa";
	scope = 2;
};
class ItemEngine_90 : ItemEngine_100 {
	displayname = "Engine Parts 90%";
	descriptionshort = "90% Health";
	horde_health = 90;
};
class ItemEngine_80 : ItemEngine_100 {
	displayname = "Engine Parts 80%";
	descriptionshort = "80% Health";
	horde_health = 80;
};
class ItemEngine_70 : ItemEngine_100 {
	displayname = "Engine Parts 70%";
	descriptionshort = "70% Health";
	horde_health = 70;
};
class ItemEngine_60 : ItemEngine_100 {
	displayname = "Engine Parts 60%";
	descriptionshort = "60% Health";
	horde_health = 60;
};
class ItemEngine_50 : ItemEngine_100 {
	displayname = "Engine Parts 50%";
	descriptionshort = "50% Health";
	horde_health = 50;
};
class ItemEngine_40 : ItemEngine_100 {
	displayname = "Engine Parts 40%";
	descriptionshort = "40% Health";
	horde_health = 40;
};
class ItemEngine_30 : ItemEngine_100 {
	displayname = "Engine Parts 30%";
	descriptionshort = "30% Health";
	horde_health = 30;
};
class ItemEngine_20 : ItemEngine_100 {
	displayname = "Engine Parts 20%";
	descriptionshort = "20% Health";
	horde_health = 20;
};
class ItemEngine_10 : ItemEngine_100 {
	displayname = "Engine Parts 10%";
	descriptionshort = "10% health";
	horde_health = 10;
};

class ItemFuelTank_100 : Horde_VehiclePartsBag_Base {
	descriptionshort = "100% Health";
	displayname = "Fuel Tank Parts 100%";
	horde_classPrefix = "ItemFuelTank_";
	horde_displayName = "Fuel tank parts";
	horde_health = 100;
	horde_inventorySound = "horde_sound_linenInventory";
	mass = 250;
	// model = "\A3\Structures_F\Items\Luggage\Suitcase_F.p3d";
	picture = "nocebo\images\fuel_tank.paa";
	scope = 2;
};
class ItemFuelTank_90 : ItemFuelTank_100 {
	displayname = "Fuel Tank Parts 90%";
	descriptionshort = "90% Health";
	horde_health = 90;
};
class ItemFuelTank_80 : ItemFuelTank_100 {
	displayname = "Fuel Tank Parts 80%";
	descriptionshort = "80% Health";
	horde_health = 80;
};
class ItemFuelTank_70 : ItemFuelTank_100 {
	displayname = "Fuel Tank Parts 70%";
	descriptionshort = "70% Health";
	horde_health = 70;
};
class ItemFuelTank_60 : ItemFuelTank_100 {
	displayname = "Fuel Tank Parts 60%";
	descriptionshort = "60% Health";
	horde_health = 60;
};
class ItemFuelTank_50 : ItemFuelTank_100 {
	displayname = "Fuel Tank Parts 50%";
	descriptionshort = "50% Health";
	horde_health = 50;
};
class ItemFuelTank_40 : ItemFuelTank_100 {
	displayname = "Fuel Tank Parts 40%";
	descriptionshort = "40% Health";
	horde_health = 40;
};
class ItemFuelTank_30 : ItemFuelTank_100 {
	displayname = "Fuel Tank Parts 30%";
	descriptionshort = "30% Health";
	horde_health = 30;
};
class ItemFuelTank_20 : ItemFuelTank_100 {
	displayname = "Fuel Tank Parts 20%";
	descriptionshort = "20% Health";
	horde_health = 20;
};
class ItemFuelTank_10 : ItemFuelTank_100 {
	displayname = "Fuel Tank Parts 10%";
	descriptionshort = "10% health";
	horde_health = 10;
};

class ItemChassis_100 : Horde_VehiclePartsBag_Base {
	descriptionshort = "100% Health";
	displayname = "Chassis Parts 100%";
	horde_classPrefix = "ItemChassis_";
	horde_displayName = "Chassis parts";
	horde_health = 100;
	horde_inventorySound = "horde_sound_linenInventory";
	mass = 250;
	// model = "\A3\Structures_F\Items\Luggage\Suitcase_F.p3d";
	picture = "nocebo\images\chassis.paa";
	scope = 2;
};
class ItemChassis_90 : ItemChassis_100 {
	descriptionshort = "90% Health";
	displayname = "Chassis Parts 90%";
	horde_health = 90;
};
class ItemChassis_80 : ItemChassis_100 {
	descriptionshort = "80% Health";
	displayname = "Chassis Parts 80%";
	horde_health = 80;
};
class ItemChassis_70 : ItemChassis_100 {
	descriptionshort = "70% Health";
	displayname = "Chassis Parts 70%";
	horde_health = 70;
};
class ItemChassis_60 : ItemChassis_100 {
	descriptionshort = "60% Health";
	displayname = "Chassis Parts 60%";
	horde_health = 60;
};
class ItemChassis_50 : ItemChassis_100 {
	descriptionshort = "50% Health";
	displayname = "Chassis Parts 50%";
	horde_health = 50;
};
class ItemChassis_40 : ItemChassis_100 {
	descriptionshort = "40% Health";
	displayname = "Chassis Parts 40%";
	horde_health = 40;
};
class ItemChassis_30 : ItemChassis_100 {
	descriptionshort = "30% Health";
	displayname = "Chassis Parts 30%";
	horde_health = 30;
};
class ItemChassis_20 : ItemChassis_100 {
	descriptionshort = "20% Health";
	displayname = "Chassis Parts 20%";
	horde_health = 20;
};
class ItemChassis_10 : ItemChassis_100 {
	descriptionshort = "10% health";
	displayname = "Chassis Parts 10%";
	horde_health = 10;
};

class ItemTracks_100 : Horde_VehiclePartsBag_Base {
	descriptionshort = "100% Health";
	displayname = "Track Parts 100%";
	horde_classPrefix = "ItemTracks_";
	horde_displayName = "Track parts";
	horde_health = 100;
	horde_inventorySound = "horde_sound_linenInventory";
	mass = 250;
	picture = "nocebo\images\tracks.paa";
	scope = 2;
};
class ItemTracks_90 : ItemTracks_100 {
	descriptionshort = "90% Health";
	displayname = "Track Parts 90%";
	horde_health = 90;
};
class ItemTracks_80 : ItemTracks_100 {
	descriptionshort = "80% Health";
	displayname = "Track Parts 80%";
	horde_health = 80;
};
class ItemTracks_70 : ItemTracks_100 {
	descriptionshort = "70% Health";
	displayname = "Track Parts 70%";
	horde_health = 70;
};
class ItemTracks_60 : ItemTracks_100 {
	descriptionshort = "60% Health";
	displayname = "Track Parts 60%";
	horde_health = 60;
};
class ItemTracks_50 : ItemTracks_100 {
	descriptionshort = "50% Health";
	displayname = "Track Parts 50%";
	horde_health = 50;
};
class ItemTracks_40 : ItemTracks_100 {
	descriptionshort = "40% Health";
	displayname = "Track Parts 40%";
	horde_health = 40;
};
class ItemTracks_30 : ItemTracks_100 {
	descriptionshort = "30% Health";
	displayname = "Track Parts 30%";
	horde_health = 30;
};
class ItemTracks_20 : ItemTracks_100 {
	descriptionshort = "20% Health";
	displayname = "Track Parts 20%";
	horde_health = 20;
};
class ItemTracks_10 : ItemTracks_100 {
	descriptionshort = "10% health";
	displayname = "Track Parts 10%";
	horde_health = 10;
};

// heli parts

class ItemAvionics_100 : Horde_AircraftPartsBag_Base {
	descriptionshort = "100% Health";
	displayname = "Avionics Parts 100%";
	horde_classPrefix = "ItemAvionics_";
	horde_displayName = "Avionics parts";
	horde_health = 100;
	horde_inventorySound = "horde_sound_linenInventory";
	mass = 250;
	// model = "\A3\Structures_F\Items\Luggage\Suitcase_F.p3d";
	picture = "nocebo\images\Avionics.paa";
	scope = 2;
};
class ItemAvionics_90 : ItemAvionics_100 {
	descriptionshort = "90% Health";
	displayname = "Avionics Parts 90%";
	horde_health = 90;
};
class ItemAvionics_80 : ItemAvionics_100 {
	descriptionshort = "80% Health";
	displayname = "Avionics Parts 80%";
	horde_health = 80;
};
class ItemAvionics_70 : ItemAvionics_100 {
	descriptionshort = "70% Health";
	displayname = "Avionics Parts 70%";
	horde_health = 70;
};
class ItemAvionics_60 : ItemAvionics_100 {
	descriptionshort = "60% Health";
	displayname = "Avionics Parts 60%";
	horde_health = 60;
};
class ItemAvionics_50 : ItemAvionics_100 {
	descriptionshort = "50% Health";
	displayname = "Avionics Parts 50%";
	horde_health = 50;
};
class ItemAvionics_40 : ItemAvionics_100 {
	descriptionshort = "40% Health";
	displayname = "Avionics Parts 40%";
	horde_health = 40;
};
class ItemAvionics_30 : ItemAvionics_100 {
	descriptionshort = "30% Health";
	displayname = "Avionics Parts 30%";
	horde_health = 30;
};
class ItemAvionics_20 : ItemAvionics_100 {
	descriptionshort = "20% Health";
	displayname = "Avionics Parts 20%";
	horde_health = 20;
};
class ItemAvionics_10 : ItemAvionics_100 {
	descriptionshort = "10% health";
	displayname = "Avionics Parts 10%";
	horde_health = 10;
};

class ItemMainRotor_100 : Horde_AircraftPartsBag_Base {
	descriptionshort = "100% Health";
	displayname = "Main Rotor Parts 100%";
	horde_classPrefix = "ItemMainRotor_";
	horde_displayName = "Main Rotor parts";
	horde_health = 100;
	horde_inventorySound = "horde_sound_linenInventory";
	mass = 250;
	// model = "\A3\Structures_F\Items\Luggage\Suitcase_F.p3d";
	picture = "nocebo\images\MainRotor.paa";
	scope = 2;
};
class ItemMainRotor_90 : ItemMainRotor_100 {
	descriptionshort = "90% Health";
	displayname = "Main Rotor Parts 90%";
	horde_health = 90;
};
class ItemMainRotor_80 : ItemMainRotor_100 {
	descriptionshort = "80% Health";
	displayname = "Main Rotor Parts 80%";
	horde_health = 80;
};
class ItemMainRotor_70 : ItemMainRotor_100 {
	descriptionshort = "70% Health";
	displayname = "Main Rotor Parts 70%";
	horde_health = 70;
};
class ItemMainRotor_60 : ItemMainRotor_100 {
	descriptionshort = "60% Health";
	displayname = "Main Rotor Parts 60%";
	horde_health = 60;
};
class ItemMainRotor_50 : ItemMainRotor_100 {
	descriptionshort = "50% Health";
	displayname = "Main Rotor Parts 50%";
	horde_health = 50;
};
class ItemMainRotor_40 : ItemMainRotor_100 {
	descriptionshort = "40% Health";
	displayname = "Main Rotor Parts 40%";
	horde_health = 40;
};
class ItemMainRotor_30 : ItemMainRotor_100 {
	descriptionshort = "30% Health";
	displayname = "Main Rotor Parts 30%";
	horde_health = 30;
};
class ItemMainRotor_20 : ItemMainRotor_100 {
	descriptionshort = "20% Health";
	displayname = "Main Rotor Parts 20%";
	horde_health = 20;
};
class ItemMainRotor_10 : ItemMainRotor_100 {
	descriptionshort = "10% health";
	displayname = "Main Rotor Parts 10%";
	horde_health = 10;
};

class ItemTailRotor_100 : Horde_AircraftPartsBag_Base {
	descriptionshort = "100% Health";
	displayname = "Tail Rotor Parts 100%";
	horde_classPrefix = "ItemTailRotor_";
	horde_displayName = "Tail Rotor parts";
	horde_health = 100;
	horde_inventorySound = "horde_sound_linenInventory";
	mass = 250;
	// model = "\A3\Structures_F\Items\Luggage\Suitcase_F.p3d";
	picture = "nocebo\images\TailRotor.paa";
	scope = 2;
};
class ItemTailRotor_90 : ItemTailRotor_100 {
	descriptionshort = "90% Health";
	displayname = "Tail Rotor Parts 90%";
	horde_health = 90;
};
class ItemTailRotor_80 : ItemTailRotor_100 {
	descriptionshort = "80% Health";
	displayname = "Tail Rotor Parts 80%";
	horde_health = 80;
};
class ItemTailRotor_70 : ItemTailRotor_100 {
	descriptionshort = "70% Health";
	displayname = "Tail Rotor Parts 70%";
	horde_health = 70;
};
class ItemTailRotor_60 : ItemTailRotor_100 {
	descriptionshort = "60% Health";
	displayname = "Tail Rotor Parts 60%";
	horde_health = 60;
};
class ItemTailRotor_50 : ItemTailRotor_100 {
	descriptionshort = "50% Health";
	displayname = "Tail Rotor Parts 50%";
	horde_health = 50;
};
class ItemTailRotor_40 : ItemTailRotor_100 {
	descriptionshort = "40% Health";
	displayname = "Tail Rotor Parts 40%";
	horde_health = 40;
};
class ItemTailRotor_30 : ItemTailRotor_100 {
	descriptionshort = "30% Health";
	displayname = "Tail Rotor Parts 30%";
	horde_health = 30;
};
class ItemTailRotor_20 : ItemTailRotor_100 {
	descriptionshort = "20% Health";
	displayname = "Tail Rotor Parts 20%";
	horde_health = 20;
};
class ItemTailRotor_10 : ItemTailRotor_100 {
	descriptionshort = "10% health";
	displayname = "Tail Rotor Parts 10%";
	horde_health = 10;
};

class ItemWinch_100 : Horde_AircraftPartsBag_Base {
	descriptionshort = "100% Health";
	displayname = "Winch Parts 100%";
	horde_classPrefix = "ItemWinch_";
	horde_displayName = "Winch parts";
	horde_health = 100;
	horde_inventorySound = "horde_sound_linenInventory";
	mass = 250;
	// model = "\A3\Structures_F\Items\Luggage\Suitcase_F.p3d";
	picture = "nocebo\images\Winch.paa";
	scope = 2;
};
class ItemWinch_90 : ItemWinch_100 {
	descriptionshort = "90% Health";
	displayname = "Winch Parts 90%";
	horde_health = 90;
};
class ItemWinch_80 : ItemWinch_100 {
	descriptionshort = "80% Health";
	displayname = "Winch Parts 80%";
	horde_health = 80;
};
class ItemWinch_70 : ItemWinch_100 {
	descriptionshort = "70% Health";
	displayname = "Winch Parts 70%";
	horde_health = 70;
};
class ItemWinch_60 : ItemWinch_100 {
	descriptionshort = "60% Health";
	displayname = "Winch Parts 60%";
	horde_health = 60;
};
class ItemWinch_50 : ItemWinch_100 {
	descriptionshort = "50% Health";
	displayname = "Winch Parts 50%";
	horde_health = 50;
};
class ItemWinch_40 : ItemWinch_100 {
	descriptionshort = "40% Health";
	displayname = "Winch Parts 40%";
	horde_health = 40;
};
class ItemWinch_30 : ItemWinch_100 {
	descriptionshort = "30% Health";
	displayname = "Winch Parts 30%";
	horde_health = 30;
};
class ItemWinch_20 : ItemWinch_100 {
	descriptionshort = "20% Health";
	displayname = "Winch Parts 20%";
	horde_health = 20;
};
class ItemWinch_10 : ItemWinch_100 {
	descriptionshort = "10% health";
	displayname = "Winch Parts 10%";
	horde_health = 10;
};

// weapon bags

class ncb_weaponbag_base : Weapon_Bag_Base {
	author = "Das Attorney";
	faction = "ncb_antagonists";
	class assembleInfo : assembleInfo {};
	class ItemActions {};
};
class ncb_weaponbag_hmg_low : ncb_weaponbag_base {
	_generalMacro = "ncb_weaponbag_hmg_low";
	scope = 2;
	displayName = "Dismantled DShK";
	hiddenselectionstextures[] = {"\A3\Drones_F\Weapons_F_Gamma\Ammoboxes\Bags\data\UAV_backpack_rgr_co.paa"};
	model = "\A3\Drones_F\Weapons_F_Gamma\Ammoboxes\Bags\UAV_backpack_F.p3d";
	picture = "\A3\Drones_F\Weapons_F_Gamma\ammoboxes\bags\data\ui\icon_B_C_UAV_rgr_ca";
	mass = 320;
	class assembleInfo : assembleInfo {
		displayName = "DshK";
		assembleTo = "ncb_static_hmg_low";
		//base[] = {"ncb_weaponbag_tripod"};
		base = "";
		primary = 1;
	};
};

class ncb_weaponbag_hmg_high : ncb_weaponbag_hmg_low {
	_generalMacro = "ncb_weaponbag_hmg_high";
	displayName = "Dismantled DShK (high)";
	class assembleInfo : assembleInfo {
		displayName = "DshK (high)";
		assembleTo = "ncb_static_hmg_high";
		// base[] = {"ncb_weaponbag_tripod"};
		base = "";
		primary = 1;
	};
};

class ncb_weaponbag_gmg_low : ncb_weaponbag_hmg_low {
	_generalMacro = "ncb_weaponbag_gmg_low";
	displayName = "Dismantled AGS-30";
	class assembleInfo : assembleInfo {
		displayName = "AGS-30";
		assembleTo = "ncb_static_gmg_low";
		// base[] = {"ncb_weaponbag_tripod"};
		base = "";
		primary = 1;
	};
};

class ncb_weaponbag_gmg_high : ncb_weaponbag_hmg_low {
	_generalMacro = "ncb_weaponbag_gmg_high";
	displayName = "Dismantled AGS-30 (high)";
	class assembleInfo : assembleInfo {
		displayName = "AGS-30 (high)";
		assembleTo = "ncb_static_gmg_high";
		// base[] = {"ncb_weaponbag_tripod"};
		base = "";
		primary = 1;
	};
};

class ncb_weaponbag_aa : ncb_weaponbag_hmg_low {
	_generalMacro = "ncb_weaponbag_aa";
	displayName = "Dismantled Titan (AA)";
	mass = 380;
	class assembleInfo : assembleInfo {
		displayName = "Titan AA";
		assembleTo = "ncb_static_aa";
		// base[] = {"ncb_weaponbag_tripod"};
		base = "";
		primary = 1;
	};
};

class ncb_weaponbag_at : ncb_weaponbag_hmg_low {
	_generalMacro = "ncb_weaponbag_at";
	displayName = "Dismantled Titan (AT)";
	mass = 380;
	class assembleInfo : assembleInfo {
		displayName = "Titan AT";
		assembleTo = "ncb_static_at";
		// base[] = {"ncb_weaponbag_tripod"};
		base = "";
		primary = 1;
	};
};

class ncb_weaponbag_mortar : ncb_weaponbag_hmg_low {
	_generalMacro = "ncb_weaponbag_mortar";
	displayName = "Dismantled 2B14 Podnos";
	mass = 380;
	class assembleInfo : assembleInfo {
		displayName = "2B14 Podnos";
		assembleTo = "ncb_static_mortar";
		// base[] = {"ncb_weaponbag_tripod"};
		// base[] = {};
		base = "";
		primary = 1;
	};
};

// tripod bag

class ncb_weaponbag_tripod : Bag_Base {
	author = "Das Attorney";
	_generalMacro = "ncb_weaponbag_tripod";
	scope = 2;
	hiddenSelectionsTextures[] = {"\A3\Weapons_F\Ammoboxes\Bags\Data\backpack_small_co.paa"};
	picture = "\A3\Weapons_F\Ammoboxes\Bags\data\UI\icon_B_C_Small_khk.paa";
	displayName = "Tripod Bag";
	model = "\A3\Weapons_F\Ammoboxes\Bags\Backpack_Small.p3d";
	maximumLoad = 0;
	mass = 180;
	faction = "ncb_antagonists";
	class assembleInfo {
		primary = 0;
		base = "";
		assembleTo = "";
		dissasembleTo[] = {};
		displayName = "";
	};
	class ItemActions {};
};

// portable generator

class Items_base_F;
class Land_PortableGenerator_01_F;
class ncb_obj_portable_generator : Land_PortableGenerator_01_F {
	class assembleInfo {
		assembleto = "";
		base = "";
		displayname = "";
		dissasembleto[] = {"PortableGenerator_backpack_F"};
		primary = 1;
	};
	class EventHandlers {
		init = "if (isServer) then {(_this select 0) setVariable ['generatorRunning',[false,0],true]}";
	};
	class InteractionInfo : InteractionInfo {
		class startGenerator : startGenerator {};
		class stopGenerator : stopGenerator {};
		class disassembleGenerator : disassembleGenerator {};
		// class dragObject : dragObject {
		// 	text = "Drag generator";
		// 	tooltip	= "'Drag' + endl + 'generator'";
		// };
	};
};

class Land_DataTerminal_01_F;
class ncb_obj_para_beacon : Land_DataTerminal_01_F {
	accuracy = 10;
	cost = 1e10;
	side = 1;
	threat[] = {1,1,1};
	class EventHandlers {
		killed = "\
			if (local (_this select 0)) then {\
				[_this select 0] remoteExecCall [\
					'horde_fnc_tentKilled',\
					2\
				]\
			};\
		";
	};
	class InteractionInfo : InteractionInfo {
		class DisassembleParaBeacon : DisassembleParaBeacon {};
	};
};


// fake classes for trees and bushes

class AllTrees : Items_base_F {
	class InteractionInfo : InteractionInfo {
		class chopFireWood : chopFireWood {};
	};
};
class AllBushes : Items_base_F {
	// class InteractionInfo : InteractionInfo {
	// 	class collectKindling : collectKindling {};
	// };
};

// oil slick

class Oil_Spill_F;
class ncb_obj_oil_spill : Oil_Spill_F {
	class EventHandlers {
		init = "if (isServer) then {\
			_holder = _this select 0;\
			_holder setVariable ['deadDeleteTime',(round time) + 60];\
			ncb_gv_garbageContents pushBack _holder\
		}";
	};
};

// Ammocrate in loot spots only (hidden for all but server and HC's)

class ncb_obj_ammobox_s : Box_east_Ammo_F {
	author = "Das Attorney";
	displayname = "Small Arms Crate (S)";
	class TransportBackpacks {};
	class TransportItems {};
	class TransportMagazines {};
	class TransportWeapons {};
	class EventHandlers {
		init = "if (not isServer or {not local (_this select 0)}) then {(_this select 0) enableSimulation false;(_this select 0) hideObject true}";
		// init = "(_this select 0) enableSimulation false;(_this select 0) hideObject true;";
	};
};

// slingloadable crates

// 1 - ammo & weaps

class B_supplyCrate_F;
class ncb_obj_ammobox_m : B_supplyCrate_F {
	author = "Das Attorney";
	cost = 100000;
	displayname = "Small Arms Crate (M)";
	horde_actionSound = "horde_sound_xxxxx";
	// side = 1;
	threat[] = {1,1,1};
	class InteractionInfo : InteractionInfo {
		class openInventory : openInventory {};
		class dragObject : dragObject {
			text = "Drag cargo";
			tooltip	= "'Drag cargo' + endl + 'container'";
		};
	};
	class TransportBackpacks {};
	class TransportItems {};
	class TransportMagazines {};
	class TransportWeapons {};
	// class EventHandlers {
	// 	// AI on dedicated servers will not target this crate until unhidden
	// 	init = "if (not hasInterface) then {(_this select 0) hideObject true}";
	// };
};

class B_CargoNet_01_ammo_F;
class ncb_obj_ammobox_l : B_CargoNet_01_ammo_F {
	author = "Das Attorney";
	cost = 100000;
	displayname = "Small arms crate (L)";
	horde_actionSound = "horde_sound_xxxxx";
	// side = 1;
	threat[] = {1,1,1};
	class InteractionInfo : InteractionInfo {
		class openInventory : openInventory {};
		class dragObject : dragObject {
			text = "Drag cargo";
			tooltip	= "'Drag cargo' + endl + 'container'";
		};
	};
	class TransportBackpacks {};
	class TransportItems {};
	class TransportMagazines {};
	class TransportWeapons {};
	// class EventHandlers {
	// 	init = "if (not hasInterface) then {(_this select 0) hideObject true}";
	// };
};

// 2 - fuel

class CargoNet_01_barrels_F;
class ncb_obj_fuel_supply_m : CargoNet_01_barrels_F {
	author = "Das Attorney";
	cost = 100000;
	displayname = "Fuel barrels (M)";
	explosionEffect = "FuelExplosion";
	fuelCapacity = 202;
	fuelExplosionPower = 5;
	horde_actionSound = "horde_sound_xxxxx";
	// side = 1;
	threat[] = {1,1,1};
	class InteractionInfo : InteractionInfo {
		// class openInventory : openInventory {};
		class dragObject : dragObject {
			text = "Drag cargo";
			tooltip	= "'Drag cargo' + endl + 'container'";
		};
		class fillJerryCan : fillJerryCan {};
	};
	class TransportBackpacks {};
	class TransportItems {};
	class TransportMagazines {};
	class TransportWeapons {};
	// class EventHandlers {
	// 	init = "if (not hasInterface) then {(_this select 0) hideObject true}";
	// };
};

class B_Slingload_01_Fuel_F;
class ncb_obj_fuel_supply_l : B_Slingload_01_Fuel_F {
	author = "Das Attorney";
	cost = 100000;
	displayname = "Fuel container (L)";
	explosionEffect = "FuelExplosion";
	fuelCapacity = 404;
	fuelExplosionPower = 7;
	horde_actionSound = "horde_sound_xxxxx";
	// side = 1;
	threat[] = {1,1,1};
	class InteractionInfo : InteractionInfo {
		// class openInventory : openInventory {};
		class dragObject : dragObject {
			text = "Drag cargo";
			tooltip	= "'Drag cargo' + endl + 'container'";
		};
		class fillJerryCan : fillJerryCan {};
	};
	class TransportBackpacks {};
	class TransportItems {};
	class TransportMagazines {};
	class TransportWeapons {};
	// class EventHandlers {
	// 	init = "if (not hasInterface) then {(_this select 0) hideObject true}";
	// };
};

// 3 - repair parts

class CargoNet_01_box_F;
class ncb_obj_repair_parts_box_m : CargoNet_01_box_F {
	author = "Das Attorney";
	cost = 100000;
	displayname = "Repair box (M)";
	horde_actionSound = "horde_sound_xxxxx";
	// side = 1;
	threat[] = {1,1,1};
	class InteractionInfo : InteractionInfo {
		class openInventory : openInventory {};
		class dragObject : dragObject {
			text = "Drag cargo";
			tooltip	= "'Drag cargo' + endl + 'container'";
		};
	};
	class TransportBackpacks {};
	class TransportItems {};
	class TransportMagazines {};
	class TransportWeapons {};
	// class EventHandlers {
	// 	init = "if (not hasInterface) then {(_this select 0) hideObject true}";
	// };
};

class B_Slingload_01_Repair_F;
class ncb_obj_repair_parts_box_l : B_Slingload_01_Repair_F {
	author = "Das Attorney";
	cost = 100000;
	displayname = "Repair shop (L)";
	horde_actionSound = "horde_sound_xxxxx";
	// side = 1;
	threat[] = {1,1,1};
	class InteractionInfo : InteractionInfo {
		class openInventory : openInventory {};
		class dragObject : dragObject {
			text = "Drag cargo";
			tooltip	= "'Drag cargo' + endl + 'container'";
		};
	};
	class TransportBackpacks {};
	class TransportItems {};
	class TransportMagazines {};
	class TransportWeapons {};
	// class EventHandlers {
	// 	init = "if (not hasInterface) then {(_this select 0) hideObject true}";
	// };
};

// tent

class Land_TentDome_F;
class ncb_obj_tent_dome : Land_TentDome_F {
	armor = 80;
	author = "Das Attorney";
	cost = 100000;
	displayname = "Tent";
	horde_actionSound = "horde_sound_packTent";
	//side = 1;
	//scope = 2;
	threat[] = {1,1,1};
	transportmaxbackpacks = 4;
	transportmaxmagazines = 64;
	transportmaxweapons = 12;

	class EventHandlers {
		killed = "\
			if (local (_this select 0)) then {\
				[_this select 0] remoteExecCall [\
					'horde_fnc_tentKilled',\
					2\
				]\
			};\
		";
	};
	class InteractionInfo : InteractionInfo {
		class openInventory : openInventory {};
		class confirmKills : confirmKills {};
		class packTent : packTent {};
		class logOut : logOut {};
		class shutDownServer : shutDownServer {};
	};
	class TransportMagazines {};
};

class Land_TentA_F;
class ncb_obj_tent_aFrame : Land_TentA_F {
	transportmaxbackpacks = 4;
	transportmaxmagazines = 64;
	transportmaxweapons = 12;
	class InteractionInfo : InteractionInfo {
		class openInventory : openInventory {};
		class confirmKills : confirmKills {};
	};
};

class CamoNet_OPFOR_F;
class ncb_obj_camonet : CamoNet_OPFOR_F {
	author = "Das Attorney";
	cost = 100000;
	displayname = "Camo Net";
	horde_actionSound = "horde_sound_packTent";
	// side = 1;
	threat[] = {1,1,1};
	class InteractionInfo : InteractionInfo {
		class PackCamoNet : PackCamoNet {
			output[] = {"ItemCamoNet"};
		};
	};
};

class CamoNet_OPFOR_open_F;
class ncb_obj_camonet_open : CamoNet_OPFOR_open_F {
	author = "Das Attorney";
	cost = 100000;
	displayname = "Camo Net (open)";
	horde_actionSound = "horde_sound_packTent";
	// side = 1;
	threat[] = {1,1,1};
	class InteractionInfo : InteractionInfo {
		class PackCamoNet : PackCamoNet {
			output[] = {"ItemCamoNetOpen"};
		};
	};
};

class CamoNet_OPFOR_big_F;
class ncb_obj_camonet_large : CamoNet_OPFOR_big_F {
	author = "Das Attorney";
	cost = 100000;
	displayname = "Vehicle Camo Net";
	horde_actionSound = "horde_sound_packTent";
	// side = 1;
	threat[] = {1,1,1};
	class InteractionInfo : InteractionInfo {
		class PackCamoNet : PackCamoNet {
			output[] = {"ItemVehicleCamoNet"};
		};
	};
};

/*class HordeTestTent : ncb_obj_ammobox_s {
	armor = 80;
	author = "Das Attorney";
	destrType = "DestructTent";
	cost = 100000;
	displayname = "Tent";
	horde_actionSound = "horde_sound_packTent";
	model = "tents\model\tentSmall.p3d";
	side = 1;
	//scope = 2;
	threat[] = {1,1,1};
	transportmaxbackpacks = 4;
	transportmaxmagazines = 64;
	transportmaxweapons = 12;
	vehicleClass = "xxxxxx";
	class EventHandlers {};
	class InteractionInfo : InteractionInfo {
		class openInventory : openInventory {};
		class packTent : packTent {};
	};
	class TransportMagazines {};
};*/

class GroundWeaponHolder : WeaponHolder {
	// forceSupply = 0;
	class EventHandlers {
		init = "if (isServer) then {\
			_holder = _this select 0;\
			_holder setVariable ['deadDeleteTime',(round time) + 600];\
			ncb_gv_garbageContents pushBack _holder\
		}";
	};
};
class ncb_obj_ground_weapon_holder : GroundWeaponHolder {
	author = "Das Attorney";
	// forceSupply = 0;
	class EventHandlers {
		init = "if (hasInterface) then {(_this select 0) enableSimulation false;(_this select 0) hideObject true}";
	};
};
class WeaponHolderSimulated : thingX {
	// supplyradius = 1.4;
	// forceSupply = 0;
	class EventHandlers {
		init = "if (isServer) then {\
			_holder = _this select 0;\
			_holder setVariable ['deadDeleteTime',(round time) + 600];\
			ncb_gv_garbageContents pushBack _holder\
		}";
	};
	class InteractionInfo : InteractionInfo {
		class openInventory : openInventory {};
	};
};