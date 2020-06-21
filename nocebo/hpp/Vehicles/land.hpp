// QUAD
class Land;
class Landvehicle;
class Car;
class Car_F;
class Quadbike_01_base_F;
class O_Quadbike_01_F;
class ncb_veh_quadbike : O_Quadbike_01_F {
	author = "Das Attorney";
	crew = "Horde_gunmanUnit";
	ejectDeadCargo = 0;
	ejectDeadDriver = 0;
	faction = "ncb_antagonists";
	initScript = "horde_fnc_initQuadbike";
	//secondaryexplosion = 0;
	typicalCargo[] = {"Horde_gunmanUnit"};
	class EventHandlers {
		class Nocebo {
			dammaged = "if (local (_this select 0)) then {_this call horde_fnc_vehicleDamageAnims}";
			killed = "\
				if (local (_this select 0)) then {\
					_this remoteExecCall [\
						'horde_fnc_vehicleKilled',\
						2\
					]\
				};\
			";
		};
	};
	class VehicleInteractionInfo : VehicleInteractionInfo {
		class Chassis : Chassis {
			modelposition[] = {-0.0302734,1.03369,-0.785585};
		};
		class Engine : Engine {
			modelposition[] = {0.20874,-0.104004,-0.942381};
		};
		class FuelTank: FuelTank {
			modelposition[] = {-0.229614,-0.121582,-0.895263};
		};
		class Wheel_L1 : Wheel_L1 {
			modelposition[] = {-0.58313,0.548828,-1.14309};
		};
		class Wheel_L2 : Wheel_L2 {
			modelposition[] = {-0.575195,-0.78125,-1.13067};
		};
		class Wheel_R1 : Wheel_R1 {
			modelposition[] = {0.561157,0.553711,-1.12963};
		};
		class Wheel_R2 : Wheel_R2 {
			modelposition[] = {0.55249,-0.777832,-1.12418};
		};
	};
	class TransportItems {};
	class TransportWeapons {};
	class TransportMagazines {};
	class TransportBackpacks {};
};

// BMW SUV
class SUV_01_base_F : Car_F {
	class SoundsExt;
};
class C_SUV_01_F : SUV_01_base_F {};
class ncb_veh_suv : C_SUV_01_F {
	author = "Das Attorney";
	ejectDeadCargo = 0;
	ejectDeadDriver = 0;
	initScript = "horde_fnc_initSUV";
	//secondaryexplosion = 0;
	class EventHandlers {
		killed = "_this call (uinamespace getvariable 'BIS_fnc_effectKilled')";
		class nocebo {
			dammaged = "if (local (_this select 0)) then {_this call horde_fnc_vehicleDamageAnims}";
			killed = "\
				if (local (_this select 0)) then {\
					_this remoteExecCall [\
						'horde_fnc_vehicleKilled',\
						2\
					]\
				};\
			";
		};
	};
	class VehicleInteractionInfo : VehicleInteractionInfo {
		class Chassis : Chassis {
			modelposition[] = {0.966675,-0.283691,-0.667637};
		};
		class Engine : Engine {
			modelposition[] = {-0.0163574,2.30811,-0.582161};
		};
		class FuelTank: FuelTank {
			modelposition[] = {-0.987915,-0.513184,-0.633656};
		};
		class Wheel_L1 : Wheel_L1 {
			modelposition[] = {-1.02795,1.36279,-1.01685};
		};
		class Wheel_L2 : Wheel_L2 {
			modelposition[] = {-1.02759,-1.87354,-1.01209};
		};
		class Wheel_R1 : Wheel_R1 {
			modelposition[] = {1.00256,1.35889,-1.03725};
		};
		class Wheel_R2 : Wheel_R2 {
			modelposition[] = {1.00452,-1.86426,-1.02308};
		};
	};
	class TransportItems {};
	class TransportWeapons {};
	class TransportMagazines {};
	class TransportBackpacks {};
};
// HATCHBACK

class C_Hatchback_01_F;
class ncb_veh_hatchback : C_Hatchback_01_F {
	author = "Das Attorney";
	ejectDeadCargo = 0;
	ejectDeadDriver = 0;
	initScript = "";
	//secondaryexplosion = 0;
	class EventHandlers {
		killed = "_this call (uinamespace getvariable 'BIS_fnc_effectKilled')";
		class nocebo {
			dammaged = "if (local (_this select 0)) then {_this call horde_fnc_vehicleDamageAnims}";
			killed = "\
				if (local (_this select 0)) then {\
					_this remoteExecCall [\
						'horde_fnc_vehicleKilled',\
						2\
					]\
				};\
			";
		};
	};
	class VehicleInteractionInfo : VehicleInteractionInfo {
		class Chassis : Chassis {
			modelposition[] = {0.831421,-0.257813,-0.53326};
		};
		class Engine : Engine {
			modelposition[] = {-0.0391846,2.21191,-0.6353};
		};
		class FuelTank: FuelTank {
			modelposition[] = {-0.866943,-0.281738,-0.49416};
		};
		class Wheel_L1 : Wheel_L1 {
			modelposition[] = {-0.895508,1.33203,-1.02143};
		};
		class Wheel_L2 : Wheel_L2 {
			modelposition[] = {-0.910645,-1.66992,-0.965706};
		};
		class Wheel_R1 : Wheel_R1 {
			modelposition[] = {0.826782,1.34424,-1.02683};
		};
		class Wheel_R2 : Wheel_R2 {
			modelposition[] = {0.842041,-1.6543,-0.97226};
		};
	};
	class TransportItems {};
	class TransportWeapons {};
	class TransportMagazines {};
	class TransportBackpacks {};
};

class C_Hatchback_01_sport_F;
class ncb_veh_hatchback_sport : C_Hatchback_01_sport_F {
	author = "Das Attorney";
	ejectDeadCargo = 0;
	ejectDeadDriver = 0;
	initScript = "";
	//secondaryexplosion = 0;
	class EventHandlers {
		killed = "_this call (uinamespace getvariable 'BIS_fnc_effectKilled')";
		class nocebo {
			dammaged = "if (local (_this select 0)) then {_this call horde_fnc_vehicleDamageAnims}";
			killed = "\
				if (local (_this select 0)) then {\
					_this remoteExecCall [\
						'horde_fnc_vehicleKilled',\
						2\
					]\
				};\
			";
		};
	};
	class VehicleInteractionInfo : VehicleInteractionInfo {
		class Chassis : Chassis {
			modelposition[] = {0.831421,-0.257813,-0.53326};
		};
		class Engine : Engine {
			modelposition[] = {-0.0391846,2.21191,-0.6353};
		};
		class FuelTank: FuelTank {
			modelposition[] = {-0.866943,-0.281738,-0.49416};
		};
		class Wheel_L1 : Wheel_L1 {
			modelposition[] = {-0.895508,1.33203,-1.02143};
		};
		class Wheel_L2 : Wheel_L2 {
			modelposition[] = {-0.910645,-1.66992,-0.965706};
		};
		class Wheel_R1 : Wheel_R1 {
			modelposition[] = {0.826782,1.34424,-1.02683};
		};
		class Wheel_R2 : Wheel_R2 {
			modelposition[] = {0.842041,-1.6543,-0.97226};
		};
	};
	class TransportItems {};
	class TransportWeapons {};
	class TransportMagazines {};
	class TransportBackpacks {};
};

// OFFROAD

class Offroad_01_civil_base_F;
class C_Offroad_01_F : Offroad_01_civil_base_F {
	class Turrets;
	class CargoTurret_01;
	class CargoTurret_02;
	class CargoTurret_03;
	class CargoTurret_04;
};
class ncb_veh_offroad : C_Offroad_01_F {
	ejectDeadCargo = 0;
	ejectDeadDriver = 0;
	initScript = "horde_fnc_initCivOffroad";
	//secondaryexplosion = 0;
	class EventHandlers {
		killed = "_this call (uinamespace getvariable 'BIS_fnc_effectKilled')";
		class nocebo {
			handledamage = "if (local (_this select 0)) then {_this call horde_fnc_vehicleDamaged}";
			dammaged = "if (local (_this select 0)) then {_this call horde_fnc_vehicleDamageAnims}";
			killed = "\
				if (local (_this select 0)) then {\
					_this remoteExecCall [\
						'horde_fnc_vehicleKilled',\
						2\
					]\
				};\
			";
		};
	};
	class VehicleInteractionInfo : VehicleInteractionInfo {
		class Chassis : Chassis {
			anim[] = {"animate",{{"HideGlass2",0.2},{"HideDoor2",0.5},{"HideConstruction",0.8}}};
			modelposition[] = {0.984985,-0.344727,-0.57067};
			class actions : actions {
				class addParts : addParts {};
				class swapParts : swapParts {};
				class takeParts : takeParts {};
				class loadVehicle {
					baseTime = 0;
					failTextLocStatus = "You cannot load any more cargo into this vehicle";
					failTextHasPart = "";
					script = "spawn horde_fnc_loadVehicleCargo";
					text = "Load cargo";
					type = "call horde_fnc_setVehicleCargoDlg";
				};
				class unloadVehicle : loadVehicle {
					failTextLocStatus = "There is no cargo in this vehicle";
					script = "spawn horde_fnc_unloadVehicleCargo";
					text = "Unload cargo";
				};
			};
		};
		class Engine : Engine {
			anim[] = {"animate",{{"HideBumper1",0.6},{"HideBumper2",0.3}}};
			modelposition[] = {0,2.67969,-0.451313};
		};
		class FuelTank: FuelTank {
			anim[] = {"animate",{{"HideDoor1",0.35},{"HideDoor3",0.75}}};
			modelposition[] = {-1.01501,-0.344727,-0.56741};
		};
		class Wheel_L1 : Wheel_L1 {
			modelposition[] = {-1.08655,1.68457,-1.11766};
		};
		class Wheel_L2 : Wheel_L2 {
			modelposition[] = {-1.08643,-1.86426,-1.14976};
		};
		class Wheel_R1 : Wheel_R1 {
			modelposition[] = {1.01343,1.68457,-1.119};
		};
		class Wheel_R2 : Wheel_R2 {
			modelposition[] = {1.01355,-1.83643,-1.15085};
		};
		class AddWeapon : AddWeapon {};
	};
	class Logistics {
		class Config_1 {
			class slot_1 {
				cargoLockIndices[] = {1,2,3,4};
				choices[] = {
					{"ncb_obj_ammobox_m",{-0.0625,-1.73438,0.3479},{{1,0,0},{0,0,1}}},
					{"ncb_obj_ammobox_l",{-0.0625,-1.73438,0.3479},{{1,0,0},{0,0,1}}},
					{"ncb_obj_fuel_supply_m",{-0.0234375,-1.73242,0.217911},{{1,0,0},{0,0,1}}},
					{"ncb_obj_repair_parts_box_m",{-0.0625,-1.73438,0.3479},{{1,0,0},{0,0,1}}}
				};
			};
		};
		class Config_2 {
			class slot_1 {
				cargoLockIndices[] = {1,2,3,4};
				choices[] = {
					{"ncb_veh_quadbike",{[0.02,-1.6,0.7},{{1,0,0},{0,0,1}}}
				};
			};
		};
	};
	class TransportItems {};
	class TransportWeapons {};
	class TransportMagazines {};
	class TransportBackpacks {};
	class Turrets : Turrets {
		class CargoTurret_01 : CargoTurret_01 {
			ejectDeadGunner = 0;
		};
		class CargoTurret_02 : CargoTurret_02 {
			ejectDeadGunner = 0;
		};
		class CargoTurret_03 : CargoTurret_03 {
			ejectDeadGunner = 0;
		};
		class CargoTurret_04 : CargoTurret_04 {
			ejectDeadGunner = 0;
		};
	};
};
class ncb_veh_offroad_turbo : ncb_veh_offroad {
	enginePower = 180;
	unloadInCombat = 0;
};
class I_G_Offroad_01_F;
class O_G_Offroad_01_F : I_G_Offroad_01_F {
	class EventHandlers;
	class Turrets;
	class CargoTurret_01;
	class CargoTurret_02;
	class CargoTurret_03;
	class CargoTurret_04;
};
class ncb_veh_offroad_unarmed : O_G_Offroad_01_F {
	author = "Das Attorney";
	crew = "Horde_gunmanUnit";
	ejectDeadCargo = 0;
	ejectDeadDriver = 0;
	faction = "ncb_antagonists";
	initScript = "horde_fnc_initOffroad";
	scope = 2;
	//secondaryexplosion = 0;
	typicalCargo[] = {"Horde_gunmanUnit"};
	class EventHandlers {
		class nocebo {
			handledamage = "if (local (_this select 0)) then {_this call horde_fnc_vehicleDamaged}";
			dammaged = "if (local (_this select 0)) then {_this call horde_fnc_vehicleDamageAnims}";
			killed = "\
				if (local (_this select 0)) then {\
					_this remoteExecCall [\
						'horde_fnc_vehicleKilled',\
						2\
					]\
				};\
			";
		};
	};
	class Logistics {
		class Config_1 {
			class slot_1 {
				cargoLockIndices[] = {1,2,3,4};
				choices[] = {
					{"ncb_obj_ammobox_m",{-0.0625,-1.73438,0.3479},{{1,0,0},{0,0,1}}},
					{"ncb_obj_ammobox_l",{-0.0625,-1.73438,0.3479},{{1,0,0},{0,0,1}}},
					{"ncb_obj_fuel_supply_m",{-0.0234375,-1.73242,0.217911},{{1,0,0},{0,0,1}}},
					{"ncb_obj_repair_parts_box_m",{-0.0625,-1.73438,0.3479},{{1,0,0},{0,0,1}}}
				};
			};
		};
		class Config_2 {
			class slot_1 {
				cargoLockIndices[] = {1,2,3,4};
				choices[] = {
					{"ncb_veh_quadbike",{[0.02,-1.6,0.7},{{1,0,0},{0,0,1}}}
				};
			};
		};
	};
	class VehicleInteractionInfo : VehicleInteractionInfo {
		class Chassis : Chassis {
			anim[] = {"animate",{{"HideGlass2",0.2},{"HideDoor2",0.5},{"HideConstruction",0.8}}};
			modelposition[] = {0.984985,-0.344727,-0.57067};
			class actions : actions {
				class addParts : addParts {};
				class swapParts : swapParts {};
				class takeParts : takeParts {};
				class loadVehicle {
					baseTime = 0;
					failTextLocStatus = "You cannot load any more cargo into this vehicle";
					failTextHasPart = "";
					script = "spawn horde_fnc_loadVehicleCargo";
					text = "Load cargo";
					type = "call horde_fnc_setVehicleCargoDlg";
				};
				class unloadVehicle : loadVehicle {
					failTextLocStatus = "There is no cargo in this vehicle";
					script = "spawn horde_fnc_unloadVehicleCargo";
					text = "Unload cargo";
				};
			};
		};
		class Engine : Engine {
			anim[] = {"animate",{{"HideBumper1",0.6},{"HideBumper2",0.3}}};
			modelposition[] = {0,2.67969,-0.451313};
		};
		class FuelTank: FuelTank {
			anim[] = {"animate",{{"HideDoor1",0.35},{"HideDoor3",0.75}}};
			modelposition[] = {-1.01501,-0.344727,-0.56741};
		};
		class Wheel_L1 : Wheel_L1 {
			modelposition[] = {-1.08655,1.68457,-1.11766};
		};
		class Wheel_L2 : Wheel_L2 {
			modelposition[] = {-1.08643,-1.86426,-1.14976};
		};
		class Wheel_R1 : Wheel_R1 {
			modelposition[] = {1.01343,1.68457,-1.119};
		};
		class Wheel_R2 : Wheel_R2 {
			modelposition[] = {1.01355,-1.83643,-1.15085};
		};
		class AddWeapon : AddWeapon {};
	};
	class TransportItems {};
	class TransportWeapons {};
	class TransportMagazines {};
	class TransportBackpacks {};
	class Turrets : Turrets {
		class CargoTurret_01 : CargoTurret_01 {
			ejectDeadGunner = 0;
		};
		class CargoTurret_02 : CargoTurret_02 {
			ejectDeadGunner = 0;
		};
		class CargoTurret_03 : CargoTurret_03 {
			ejectDeadGunner = 0;
		};
		class CargoTurret_04 : CargoTurret_04 {
			ejectDeadGunner = 0;
		};
	};
};
class I_G_Offroad_01_armed_F;
class O_G_Offroad_01_armed_F : I_G_Offroad_01_armed_F {
	class AnimationSources;
	class EventHandlers;
	class Turrets;
	class M2_Turret;
};
class ncb_veh_offroad_hmg : O_G_Offroad_01_armed_F {
	author = "Das Attorney";
	crew = "Horde_gunmanUnit";
	ejectDeadCargo = 0;
	ejectDeadDriver = 0;
	faction = "ncb_antagonists";
	initScript = "horde_fnc_initOffroad";
	scope = 2;
	//secondaryexplosion = 0;
	side = 0;
	typicalCargo[] = {"Horde_gunmanUnit"};
	class EventHandlers {
		fired = "_this call (uinamespace getvariable 'BIS_fnc_effectFired')";
		killed = "_this call (uinamespace getvariable 'BIS_fnc_effectKilled')";
		class nocebo {
			handledamage = "if (local (_this select 0)) then {_this call horde_fnc_vehicleDamaged}";
			dammaged = "if (local (_this select 0)) then {_this call horde_fnc_vehicleDamageAnims}";
			killed = "\
				if (local (_this select 0)) then {\
					_this remoteExecCall [\
						'horde_fnc_vehicleKilled',\
						2\
					]\
				};\
			";
		};
	};
	class VehicleInteractionInfo : VehicleInteractionInfo {
		class Chassis : Chassis {
			anim[] = {"animate",{{"HideGlass2",0.2},{"HideDoor2",0.5}}};
			location[] = {"HitBody","HitHull","HitTurret","HitGun"};
			modelposition[] = {0.984985,-0.344727,-1.07067};
		};
		class Engine : Engine {
			anim[] = {"animate",{{"HideBumper1",0.6},{"HideBumper2",0.3}}};
			modelposition[] = {0,2.67969,-0.951313};
		};
		class FuelTank: FuelTank {
			anim[] = {"animate",{{"HideDoor1",0.35},{"HideDoor3",0.75}}};
			modelposition[] = {-1.01501,-0.344727,-1.06741};
		};
		class Wheel_L1 : Wheel_L1 {
			modelposition[] = {-1.08655,1.68457,-1.51766};
		};
		class Wheel_L2 : Wheel_L2 {
			modelposition[] = {-1.08643,-1.86426,-1.64976};
		};
		class Wheel_R1 : Wheel_R1 {
			modelposition[] = {1.01343,1.68457,-1.619};
		};
		class Wheel_R2 : Wheel_R2 {
			modelposition[] = {1.01355,-1.83643,-1.65085};
		};
	};
	class TransportItems {};
	class TransportWeapons {};
	class TransportMagazines {};
	class TransportBackpacks {};
};

// magazines[] = {"12rnd_SPG9_HEAT","8rnd_SPG9_HE"}; // BASE = "SPG9_HEAT" / "SPG9_HE"
// weapons[] = {"launcher_SPG9"};
// magazines[] = {"SPG9_HEAT","SPG9_HE","12rnd_SPG9_HEAT","8rnd_SPG9_HE"};

// [["Laserbatteries","Laserbeam"],["Titan_AA","M_Titan_AA"],["Titan_AP","M_Titan_AP"],["Titan_AT","M_Titan_AT"],["130Rnd_338_Mag","B_338_NM_Ball"],["ncb_mag_flare_60_refill","CMflareAmmo"],["ncb_mag_chaff_60_refill","CMflare_Chaff_Ammo"],["ncb_mag_smoke_2_refill","SmokeLauncherAmmo"],["ncb_mag_65x39_100_refill","B_65x39_Caseless"],["ncb_mag_762x51_100_refill","B_762x51_Ball"],["ncb_mag_762x54_100_refill","B_762x54_Ball"],["ncb_mag_127x99_100_refill","B_127x99_Ball"],["ncb_mag_127x108_100_refill","B_127x108_Ball"],["ncb_mag_grenade_40mm_he_32_refill","G_40mm_HEDP"],["ncb_magv_grenade_20mm_he_40_refill","G_20mm_HE"],["ncb_mag_missile_dagr_1_refill","M_PG_AT"],["ncb_mag_missile_dar_1_refill","M_AT"],["ncb_mag_missile_scalpel_1_refill","M_Scalpel_AT"],["ncb_mag_missile_skyfire_1_refill","R_80mm_HE"],["ncb_mag_missile_sahr_1_refill","Missile_AA_03_F"],["ncb_mag_missile_sharur_1_refill","Missile_AGM_01_F"],["ncb_mag_rocket_tratnyr_he_1_refill","Rocket_03_HE_F"],["ncb_mag_rocket_tratnyr_ap_1_refill","Rocket_03_AP_F"],["ncb_mag_cannon_20mm_he_100_refill","B_20mm"],["ncb_mag_cannon_25mm_he_100_refill","B_25mm"],["ncb_mag_cannon_30mm_he_50_refill","B_30mm_HE"],["ncb_mag_cannon_30mm_apds_50_refill","B_30mm_AP"],["ncb_mag_cannon_30mm_gau8_50_refill","Gatling_30mm_HE_Plane_CAS_01_F"],["ncb_mag_cannon_35mm_aa_40_refill","B_35mm_AA"],["ncb_mag_cannon_40mm_gpr_30_refill","B_40mm_GPR"],["ncb_mag_cannon_120mm_he_1_refill","Sh_120mm_HE"],["ncb_mag_cannon_120mm_apfsds_1_refill","Sh_120mm_APFSDS"],["ncb_mag_cannon_155mm_he_1_refill","Sh_155mm_AMOS"],["ncb_mag_cannon_155mm_smoke_1_refill","Smoke_120mm_AMOS_White"],["ncb_mag_cannon_155mm_guided_1_refill","Sh_155mm_AMOS_guided"],["ncb_mag_cannon_155mm_lg_1_refill","Sh_155mm_AMOS_LG"],["ncb_mag_cannon_155mm_mine_1_refill","Mine_155mm_AMOS_range"],["ncb_mag_cannon_155mm_atmine_1_refill","AT_Mine_155mm_AMOS_range"],["ncb_mag_cannon_155mm_cluster_1_refill","Cluster_155mm_AMOS"],["ncb_mag_mortar_82mm_he_1_refill","Sh_82mm_AMOS"],["ncb_mag_mortar_82mm_flare_white_1_refill","Flare_82mm_AMOS_White"],["ncb_mag_mortar_82mm_smoke_white_1_refill","Smoke_82mm_AMOS_White"],["ncb_mag_bomb_gbu12_1_refill","Bo_GBU12_LGB"],["ncb_mag_bomb_lom_250g_1_refill","Bomb_03_F"],["200Rnd_338_Mag","B_338_NM_Ball"]]

class I_G_Offroad_01_AT_F;
class ncb_veh_offroad_at : I_G_Offroad_01_AT_F {
	author = "Das Attorney";
	crew = "Horde_gunmanUnit";
	ejectDeadCargo = 0;
	ejectDeadDriver = 0;
	faction = "ncb_antagonists";
	initScript = "horde_fnc_initOffroad";
	scope = 2;
	//secondaryexplosion = 0;
	side = 0;
	typicalCargo[] = {"Horde_gunmanUnit"};
	class EventHandlers {
		fired = "_this call (uinamespace getvariable 'BIS_fnc_effectFired')";
		killed = "_this call (uinamespace getvariable 'BIS_fnc_effectKilled'); _this select 0 animate [""DamageUnHideConstruction"",0]";
		class nocebo {
			handledamage = "if (local (_this select 0)) then {_this call horde_fnc_vehicleDamaged}";
			dammaged = "if (local (_this select 0)) then {_this call horde_fnc_vehicleDamageAnims}";
			killed = "\
				if (local (_this select 0)) then {\
					_this remoteExecCall [\
						'horde_fnc_vehicleKilled',\
						2\
					]\
				};\
			";
		};
	};
	class VehicleInteractionInfo : VehicleInteractionInfo {
		class Chassis : Chassis {
			anim[] = {"animate",{{"HideGlass2",0.2},{"HideDoor2",0.5}}};
			location[] = {"HitBody","HitHull","HitTurret","HitGun"};
			modelposition[] = {0.984985,-0.344727,-0.57067};
		};
		class Engine : Engine {
			anim[] = {"animate",{{"HideBumper1",0.6},{"HideBumper2",0.3}}};
			modelposition[] = {0,2.67969,-0.451313};
		};
		class FuelTank: FuelTank {
			anim[] = {"animate",{{"HideDoor1",0.35},{"HideDoor3",0.75}}};
			modelposition[] = {-1.01501,-0.344727,-1.06741};
		};
		class Wheel_L1 : Wheel_L1 {
			modelposition[] = {-1.08655,1.68457,-1.11766};
		};
		class Wheel_L2 : Wheel_L2 {
			modelposition[] = {-1.08643,-1.86426,-1.14976};
		};
		class Wheel_R1 : Wheel_R1 {
			modelposition[] = {1.01343,1.68457,-1.119};
		};
		class Wheel_R2 : Wheel_R2 {
			modelposition[] = {1.01355,-1.83643,-1.15085};
		};
	};
	class TransportItems {};
	class TransportWeapons {};
	class TransportMagazines {};
	class TransportBackpacks {};
};


// 4WD Tanoa offroad

class Offroad_02_base_F;
class Offroad_02_unarmed_base_F : Offroad_02_base_F {};
class I_C_Offroad_02_unarmed_F : Offroad_02_unarmed_base_F {};
class ncb_veh_4wd_unarmed : I_C_Offroad_02_unarmed_F {
	author = "Das Attorney";
	crew = "Horde_gunmanUnit";
	ejectDeadCargo = 0;
	ejectDeadDriver = 0;
	faction = "ncb_antagonists";
	initScript = "";
	scope = 2;
	//secondaryexplosion = 0;
	side = 0;
	typicalCargo[] = {"Horde_gunmanUnit"};
	class EventHandlers {
		killed = "_this call (uinamespace getvariable 'BIS_fnc_effectKilled')";
		class nocebo {
			handledamage = "if (local (_this select 0)) then {_this call horde_fnc_vehicleDamaged}";
			dammaged = "if (local (_this select 0)) then {_this call horde_fnc_vehicleDamageAnims}";
			killed = "\
				if (local (_this select 0)) then {\
					_this remoteExecCall [\
						'horde_fnc_vehicleKilled',\
						2\
					]\
				};\
			";
			init = " \
				if (isServer) then { \
					_veh = _this select 0; \
					_veh animate ['hideLeftDoor',0]; \
					_veh animate ['hideRightDoor',0]; \
					_veh animate ['hideRearDoor',0]; \
					_veh animate ['hideBullbar',0]; \
					_veh animate ['hideFenders',0]; \
					_veh animate ['hideHeadSupportRear',0]; \
					_veh animate ['hideHeadSupportFront',0]; \
					_veh animate ['hideRollcage',0]; \
				}; \
			";
		};
	};
	class VehicleInteractionInfo : VehicleInteractionInfo {
		class Chassis : Chassis {
			anim[] = {"animate",{{"hideHeadSupportFront",0.2},{"hideRollcage",0.5},{"hideRightDoor",0.75}}};
			modelposition[] = {0.86,0.28,-1.00};
			class actions : actions {
				class addParts : addParts {};
				class swapParts : swapParts {};
				class takeParts : takeParts {};
			};
		};
		class Engine : Engine {
			anim[] = {"animate",{{"hideBullbar",0.3},{"hideFenders",0.7}}};
			modelposition[] = {0,2.07,-0.37};
		};
		class FuelTank: FuelTank {
			anim[] = {"animate",{{"hideHeadSupportRear",0.2},{"hideLeftDoor",0.35},{"hideRearDoor",0.67}}};
			modelposition[] = {-0.90,-1.45,-0.29};
		};
		class Wheel_L1 : Wheel_L1 {
			modelposition[] = {-0.96,1.6,-1.14};
		};
		class Wheel_L2 : Wheel_L2 {
			modelposition[] = {-0.96,-0.93,-1.14};
		};
		class Wheel_R1 : Wheel_R1 {
			modelposition[] = {0.96,1.6,-1.14};
		};
		class Wheel_R2 : Wheel_R2 {
			modelposition[] = {0.96,-0.93,-1.14};
		};
	};
	class TransportItems {};
	class TransportWeapons {};
	class TransportMagazines {};
	class TransportBackpacks {};
};
class I_C_Offroad_02_AT_F;
class ncb_veh_4wd_at : I_C_Offroad_02_AT_F {
	author = "Das Attorney";
	crew = "Horde_gunmanUnit";
	ejectDeadCargo = 0;
	ejectDeadDriver = 0;
	faction = "ncb_antagonists";
	initScript = "";
	scope = 2;
	side = 0;
	typicalCargo[] = {"Horde_gunmanUnit"};
	class EventHandlers {
		fired = "_this call (uinamespace getvariable 'BIS_fnc_effectFired')";
		killed = "_this call (uinamespace getvariable 'BIS_fnc_effectKilled');";
		class nocebo {
			handledamage = "if (local (_this select 0)) then {_this call horde_fnc_vehicleDamaged}";
			dammaged = "if (local (_this select 0)) then {_this call horde_fnc_vehicleDamageAnims}";
			killed = "\
				if (local (_this select 0)) then {\
					_this remoteExecCall [\
						'horde_fnc_vehicleKilled',\
						2\
					]\
				};\
			";
		};
	};
	class VehicleInteractionInfo : VehicleInteractionInfo {
		class Chassis : Chassis {
			anim[] = {"animate",{{"hideHeadSupportFront",0.2},{"hideRollcage",0.5},{"hideRightDoor",0.75}}};
			modelposition[] = {0.86,0.28,-1.00};
			// class actions : actions {
			// 	class addParts : addParts {};
			// 	class swapParts : swapParts {};
			// 	class takeParts : takeParts {};
			// 	class reload : reload {};
			// };
		};
		class Engine : Engine {
			anim[] = {"animate",{{"hideBullbar",0.3},{"hideFenders",0.7}}};
			modelposition[] = {0,2.07,-0.37};
		};
		class FuelTank: FuelTank {
			anim[] = {"animate",{{"hideHeadSupportRear",0.2},{"hideLeftDoor",0.35},{"hideRearDoor",0.67}}};
			modelposition[] = {-0.90,-1.45,-0.29};
		};
		class Wheel_L1 : Wheel_L1 {
			modelposition[] = {-0.96,1.6,-1.14};
		};
		class Wheel_L2 : Wheel_L2 {
			modelposition[] = {-0.96,-0.93,-1.14};
		};
		class Wheel_R1 : Wheel_R1 {
			modelposition[] = {0.96,1.6,-1.14};
		};
		class Wheel_R2 : Wheel_R2 {
			modelposition[] = {0.96,-0.93,-1.14};
		};
	};
	class TransportItems {};
	class TransportWeapons {};
	class TransportMagazines {};
	class TransportBackpacks {};
};
class I_C_Offroad_02_LMG_F;
class ncb_veh_4wd_lmg : I_C_Offroad_02_LMG_F {
	author = "Das Attorney";
	crew = "Horde_gunmanUnit";
	ejectDeadCargo = 0;
	ejectDeadDriver = 0;
	faction = "ncb_antagonists";
	initScript = "";
	scope = 2;
	side = 0;
	typicalCargo[] = {"Horde_gunmanUnit"};
	class EventHandlers {
		fired = "_this call (uinamespace getvariable 'BIS_fnc_effectFired')";
		killed = "_this call (uinamespace getvariable 'BIS_fnc_effectKilled');";
		class nocebo {
			handledamage = "if (local (_this select 0)) then {_this call horde_fnc_vehicleDamaged}";
			dammaged = "if (local (_this select 0)) then {_this call horde_fnc_vehicleDamageAnims}";
			killed = "\
				if (local (_this select 0)) then {\
					_this remoteExecCall [\
						'horde_fnc_vehicleKilled',\
						2\
					]\
				};\
			";
		};
	};
	class VehicleInteractionInfo : VehicleInteractionInfo {
		class Chassis : Chassis {
			anim[] = {"animate",{{"hideHeadSupportFront",0.2},{"hideRollcage",0.5},{"hideRightDoor",0.75}}};
			modelposition[] = {0.86,0.28,-1.55};
			// class actions : actions {
			// 	class addParts : addParts {};
			// 	class swapParts : swapParts {};
			// 	class takeParts : takeParts {};
			// 	class reload : reload {};
			// };
		};
		class Engine : Engine {
			anim[] = {"animate",{{"hideBullbar",0.3},{"hideFenders",0.7}}};
			modelposition[] = {0,2.07,-0.9};
		};
		class FuelTank: FuelTank {
			anim[] = {"animate",{{"hideHeadSupportRear",0.2},{"hideLeftDoor",0.35},{"hideRearDoor",0.67}}};
			modelposition[] = {-0.90,-1.45,-0.85};
		};
		class Wheel_L1 : Wheel_L1 {
			modelposition[] = {-0.96,1.6,-1.70};
		};
		class Wheel_L2 : Wheel_L2 {
			modelposition[] = {-0.96,-0.93,-1.70};
		};
		class Wheel_R1 : Wheel_R1 {
			modelposition[] = {0.96,1.6,-1.70};
		};
		class Wheel_R2 : Wheel_R2 {
			modelposition[] = {0.96,-0.93,-1.70};
		};
	};
	class TransportItems {};
	class TransportWeapons {};
	class TransportMagazines {};
	class TransportBackpacks {};
};


// HUNTER

class MRAP_01_base_F;
class MRAP_01_gmg_base_F : MRAP_01_base_F {};
class ncb_veh_hunter_gmg : MRAP_01_gmg_base_F {
	author = "Das Attorney";
	mapSize = 6.71;
	class SimpleObject {
		eden = 1;
		animate[] = {{"damagehide", 0}, {"damagehidevez", 0}, {"damagehidehlaven", 0}, {"wheel_1_1_destruct", 0}, {"wheel_1_2_destruct", 0}, {"wheel_1_3_destruct", 0}, {"wheel_1_4_destruct", 0}, {"wheel_2_1_destruct", 0}, {"wheel_2_2_destruct", 0}, {"wheel_2_3_destruct", 0}, {"wheel_2_4_destruct", 0}, {"wheel_1_1_destruct_unhide", 0}, {"wheel_1_2_destruct_unhide", 0}, {"wheel_1_3_destruct_unhide", 0}, {"wheel_1_4_destruct_unhide", 0}, {"wheel_2_1_destruct_unhide", 0}, {"wheel_2_2_destruct_unhide", 0}, {"wheel_2_3_destruct_unhide", 0}, {"wheel_2_4_destruct_unhide", 0}, {"wheel_1_3_damage", 0}, {"wheel_1_4_damage", 0}, {"wheel_2_3_damage", 0}, {"wheel_2_4_damage", 0}, {"wheel_1_3_damper_damage_backanim", 0}, {"wheel_1_4_damper_damage_backanim", 0}, {"wheel_2_3_damper_damage_backanim", 0}, {"wheel_2_4_damper_damage_backanim", 0}, {"glass1_destruct", 0}, {"glass2_destruct", 0}, {"glass3_destruct", 0}, {"glass4_destruct", 0}, {"glass5_destruct", 0}, {"glass6_destruct", 0}, {"fuel", 1}, {"wheel_1_1", 1}, {"wheel_2_1", 1}, {"wheel_1_2", 1}, {"wheel_2_2", 1}, {"wheel_1_1_damper", 0.48}, {"wheel_2_1_damper", 0.53}, {"wheel_1_2_damper", 0.48}, {"wheel_2_2_damper", 0.61}, {"daylights", 0}, {"pedal_thrust", 0}, {"pedal_brake", 1}, {"wheel_1_1_damage", 0}, {"wheel_1_2_damage", 0}, {"wheel_2_1_damage", 0}, {"wheel_2_2_damage", 0}, {"wheel_1_1_damper_damage_backanim", 0}, {"wheel_1_2_damper_damage_backanim", 0}, {"wheel_2_1_damper_damage_backanim", 0}, {"wheel_2_2_damper_damage_backanim", 0}, {"vehicletransported_antenna_hide", 0}, {"drivingwheel", 0}, {"steering_1_1", 0}, {"steering_2_1", 0}, {"indicatorspeed", 0}, {"indicatorfuel", 1}, {"indicatorrpm", 0}, {"indicatortemp", 0}, {"indicatortemp_move", 0}, {"indicatortemp2", 0}, {"indicatortemp2_move", 0}, {"reverse_light", 0}, {"door_lf", 0}, {"door_rf", 0}, {"door_lb", 0}, {"door_rb", 0}, {"mainturret", 0}, {"maingun", 0}, {"damagehlaven", 0}, {"gmg_muzzle", 0}, {"zaslehrot", 0}};
		hide[] = {"clan", "zasleh", "light_l", "light_r", "light_r2", "light_l2", "zadni svetlo", "brzdove svetlo", "podsvit pristroju", "poskozeni"};
		verticalOffset = 2.582;
		verticalOffsetWorld = -0.176;
		init = "''";
	};
	editorPreview = "\A3\EditorPreviews_F\Data\CfgVehicles\B_MRAP_01_gmg_F.jpg";
	scope = 2;
	faction = "ncb_renegades";
	crew = "Horde_renegadeUnit";
	typicalCargo[] = {"Horde_renegadeUnit"};
	side = 2;
	hiddenSelectionsTextures[] = {"\A3\soft_F\MRAP_01\data\MRAP_01_base_CO.paa", "\A3\soft_F\MRAP_01\data\MRAP_01_adds_CO.paa", "\A3\Data_F\Vehicles\Turret_CO.paa"};
	class EventHandlers {
		//init = "if (local (_this select 0)) then {(_this select 0) animate ['Unarmed_Main_Turret_hide',1]}";
		fired = "_this call (uinamespace getvariable 'BIS_fnc_effectFired')";
		killed = "_this call (uinamespace getvariable 'BIS_fnc_effectKilled')";
		class nocebo {
			handledamage = "if (local (_this select 0)) then {_this call horde_fnc_vehicleDamaged}";
			dammaged = "if (local (_this select 0)) then {_this call horde_fnc_vehicleDamageAnims}";
			killed = "\
				if (local (_this select 0)) then {\
					_this remoteExecCall [\
						'horde_fnc_vehicleKilled',\
						2\
					]\
				};\
			";
		};
	};
	class VehicleInteractionInfo : VehicleInteractionInfo {
		class Chassis : Chassis {
			anim[] = {};
			location[] = {"HitBody","HitHull","HitTurret","HitGun"};
			modelposition[] = {0.983887,-1.59766,-1.54883};
		};
		class Engine : Engine {
			modelposition[] = {0,1.58105,-1.25628};
		};
		class FuelTank: FuelTank {
			anim[] = {};
			modelposition[] = {-0.913086,-1.59766,-1.54883};
		};
		class Wheel_L1 : Wheel_L1 {
			modelposition[] = {-1.36963,0.539063,-2};
		};
		class Wheel_L2 : Wheel_L2 {
			modelposition[] = {-1.36963,-3.41211,-2};
		};
		class Wheel_R1 : Wheel_R1 {
			modelposition[] = {1.34912,0.539063,-2};
		};
		class Wheel_R2 : Wheel_R2 {
			modelposition[] = {1.34912,-3.41211,-2};
		};
	};
	class TransportItems {};
	class TransportWeapons {};
	class TransportMagazines {};
	class TransportBackpacks {};
};
class MRAP_01_hmg_base_F : MRAP_01_gmg_base_F {};
class ncb_veh_hunter_hmg : MRAP_01_hmg_base_F {
	author = "Bohemia Interactive";
	mapSize = 6.71;
	class SimpleObject {
		eden = 1;
		animate[] = {{"damagehide", 0}, {"damagehidevez", 0}, {"damagehidehlaven", 0}, {"wheel_1_1_destruct", 0}, {"wheel_1_2_destruct", 0}, {"wheel_1_3_destruct", 0}, {"wheel_1_4_destruct", 0}, {"wheel_2_1_destruct", 0}, {"wheel_2_2_destruct", 0}, {"wheel_2_3_destruct", 0}, {"wheel_2_4_destruct", 0}, {"wheel_1_1_destruct_unhide", 0}, {"wheel_1_2_destruct_unhide", 0}, {"wheel_1_3_destruct_unhide", 0}, {"wheel_1_4_destruct_unhide", 0}, {"wheel_2_1_destruct_unhide", 0}, {"wheel_2_2_destruct_unhide", 0}, {"wheel_2_3_destruct_unhide", 0}, {"wheel_2_4_destruct_unhide", 0}, {"wheel_1_3_damage", 0}, {"wheel_1_4_damage", 0}, {"wheel_2_3_damage", 0}, {"wheel_2_4_damage", 0}, {"wheel_1_3_damper_damage_backanim", 0}, {"wheel_1_4_damper_damage_backanim", 0}, {"wheel_2_3_damper_damage_backanim", 0}, {"wheel_2_4_damper_damage_backanim", 0}, {"glass1_destruct", 0}, {"glass2_destruct", 0}, {"glass3_destruct", 0}, {"glass4_destruct", 0}, {"glass5_destruct", 0}, {"glass6_destruct", 0}, {"fuel", 1}, {"wheel_1_1", 1}, {"wheel_2_1", 1}, {"wheel_1_2", 1}, {"wheel_2_2", 1}, {"wheel_1_1_damper", 0.48}, {"wheel_2_1_damper", 0.53}, {"wheel_1_2_damper", 0.48}, {"wheel_2_2_damper", 0.61}, {"daylights", 0}, {"pedal_thrust", 0}, {"pedal_brake", 1}, {"wheel_1_1_damage", 0}, {"wheel_1_2_damage", 0}, {"wheel_2_1_damage", 0}, {"wheel_2_2_damage", 0}, {"wheel_1_1_damper_damage_backanim", 0}, {"wheel_1_2_damper_damage_backanim", 0}, {"wheel_2_1_damper_damage_backanim", 0}, {"wheel_2_2_damper_damage_backanim", 0}, {"vehicletransported_antenna_hide", 0}, {"drivingwheel", 0}, {"steering_1_1", 0}, {"steering_2_1", 0}, {"indicatorspeed", 0}, {"indicatorfuel", 1}, {"indicatorrpm", 0}, {"indicatortemp", 0}, {"indicatortemp_move", 0}, {"indicatortemp2", 0}, {"indicatortemp2_move", 0}, {"reverse_light", 0}, {"door_lf", 0}, {"door_rf", 0}, {"door_lb", 0}, {"door_rb", 0}, {"mainturret", 0}, {"maingun", 0}, {"damagehlaven", 0}, {"mg_muzzle", 0}, {"zaslehrot", 0}};
		hide[] = {"clan", "zasleh", "light_l", "light_r", "light_r2", "light_l2", "zadni svetlo", "brzdove svetlo", "podsvit pristroju", "poskozeni"};
		verticalOffset = 2.582;
		verticalOffsetWorld = -0.176;
		init = "''";
	};
	editorPreview = "\A3\EditorPreviews_F\Data\CfgVehicles\B_MRAP_01_hmg_F.jpg";
	_generalMacro = "B_MRAP_01_hmg_F";
	scope = 2;
	faction = "ncb_renegades";
	crew = "Horde_renegadeUnit";
	typicalCargo[] = {"Horde_renegadeUnit"};
	side = 2;
	hiddenSelectionsTextures[] = {"\A3\soft_F\MRAP_01\data\MRAP_01_base_CO.paa", "\A3\soft_F\MRAP_01\data\MRAP_01_adds_CO.paa", "\A3\Data_F\Vehicles\Turret_CO.paa"};
	class EventHandlers {
		//init = "if (local (_this select 0)) then {(_this select 0) animate ['Unarmed_Main_Turret_hide',1]}";
		fired = "_this call (uinamespace getvariable 'BIS_fnc_effectFired')";
		killed = "_this call (uinamespace getvariable 'BIS_fnc_effectKilled')";
		class nocebo {
			handledamage = "if (local (_this select 0)) then {_this call horde_fnc_vehicleDamaged}";
			dammaged = "if (local (_this select 0)) then {_this call horde_fnc_vehicleDamageAnims}";
			killed = "\
				if (local (_this select 0)) then {\
					_this remoteExecCall [\
						'horde_fnc_vehicleKilled',\
						2\
					]\
				};\
			";
		};
	};
	class VehicleInteractionInfo : VehicleInteractionInfo {
		class Chassis : Chassis {
			anim[] = {};
			location[] = {"HitBody","HitHull","HitTurret","HitGun"};
			modelposition[] = {0.983887,-1.59766,-1.54883};
		};
		class Engine : Engine {
			modelposition[] = {0,1.58105,-1.25628};
		};
		class FuelTank: FuelTank {
			anim[] = {};
			modelposition[] = {-0.913086,-1.59766,-1.54883};
		};
		class Wheel_L1 : Wheel_L1 {
			modelposition[] = {-1.36963,0.539063,-2};
		};
		class Wheel_L2 : Wheel_L2 {
			modelposition[] = {-1.36963,-3.41211,-2};
		};
		class Wheel_R1 : Wheel_R1 {
			modelposition[] = {1.34912,0.539063,-2};
		};
		class Wheel_R2 : Wheel_R2 {
			modelposition[] = {1.34912,-3.41211,-2};
		};
	};
	class TransportItems {};
	class TransportWeapons {};
	class TransportMagazines {};
	class TransportBackpacks {};
};

// IFRIT

class MRAP_02_base_F : Car_F {
	horde_primWeapMinCalLevel = 2;
};
class O_MRAP_02_F : MRAP_02_base_F {
	class EventHandlers;
};
class ncb_veh_ifrit : O_MRAP_02_F {
	author = "Das Attorney";
	crew = "Horde_gunmanUnit";
	ejectDeadCargo = 0;
	ejectDeadDriver = 0;
	faction = "ncb_antagonists";
	initScript = "";
	//secondaryexplosion = 0;
	typicalCargo[] = {"Horde_gunmanUnit"};

	class EventHandlers {
		fired = "_this call (uinamespace getvariable 'BIS_fnc_effectFired')";
		killed = "_this call (uinamespace getvariable 'BIS_fnc_effectKilled')";
		class nocebo {
			handledamage = "if (local (_this select 0)) then {_this call horde_fnc_vehicleDamaged}";
			dammaged = "if (local (_this select 0)) then {_this call horde_fnc_vehicleDamageAnims}";
			killed = "\
				if (local (_this select 0)) then {\
					_this remoteExecCall [\
						'horde_fnc_vehicleKilled',\
						2\
					]\
				};\
			";
		};
	};
	class VehicleInteractionInfo : VehicleInteractionInfo {
		class Chassis : Chassis {
			anim[] = {"animateDoor",{{"Door_RF",0.4},{"Door_RM",0.6}}};
			modelposition[] = {0.909546,-1.49902,-0.887887};
		};
		class Engine : Engine {
			modelposition[] = {0,1.61914,-1.05848};
		};
		class FuelTank: FuelTank {
			anim[] = {"animateDoor",{{"Door_LF",0.4},{"Door_LM",0.6}}};
			modelposition[] = {-0.90979,-1.50439,-0.939486};
		};
		class Wheel_L1 : Wheel_L1 {
			modelposition[] = {-1.35278,0.465332,-1.71245};
		};
		class Wheel_L2 : Wheel_L2 {
			modelposition[] = {-1.35266,-3.4668,-1.69902};
		};
		class Wheel_R1 : Wheel_R1 {
			modelposition[] = {1.39575,0.466309,-1.68968};
		};
		class Wheel_R2 : Wheel_R2 {
			modelposition[] = {1.39587,-3.46191,-1.66764};
		};
		class AddWeapon : AddWeapon {
			anim[] = {"animateDoor",{{"Door_rear",0.8}}};
			modelposition[] = {0,-4.90234,-0.486256};
			weaponconfig[] = {
				{
					{"ncb_weaponbag_hmg_low","ncb_weaponbag_hmg_high"},
					"Add HMG",
					"ncb_veh_ifrit_hmg",
					"spawn horde_fnc_addWeaponToVehicle",
					15
				};
				{
					{"ncb_weaponbag_gmg_low","ncb_weaponbag_gmg_high"},
					"Add GMG",
					"ncb_veh_ifrit_gmg",
					"spawn horde_fnc_addWeaponToVehicle",
					15
				};
			};
		};
	};
	class TransportItems {};
	class TransportWeapons {};
	class TransportMagazines {};
	class TransportBackpacks {};
};
class MRAP_02_hmg_base_F;
class MRAP_02_gmg_base_F;
class O_MRAP_02_gmg_F : MRAP_02_gmg_base_F {
	class AnimationSources;
	class Turrets;
	class MainTurret;
};
class ncb_veh_ifrit_gmg : O_MRAP_02_gmg_F {
	author = "Das Attorney";
	crew = "Horde_gunmanUnit";
	ejectDeadCargo = 0;
	faction = "ncb_antagonists";
	initScript = "";
	//secondaryexplosion = 0;
	typicalCargo[] = {"Horde_gunmanUnit"};
	class EventHandlers {
		fired = "_this call (uinamespace getvariable 'BIS_fnc_effectFired')";
		killed = "_this call (uinamespace getvariable 'BIS_fnc_effectKilled')";
		class nocebo {
			handledamage = "if (local (_this select 0)) then {_this call horde_fnc_vehicleDamaged}";
			dammaged = "if (local (_this select 0)) then {_this call horde_fnc_vehicleDamageAnims}";
			killed = "\
				if (local (_this select 0)) then {\
					_this remoteExecCall [\
						'horde_fnc_vehicleKilled',\
						2\
					]\
				};\
			";
		};
	};
	class VehicleInteractionInfo : VehicleInteractionInfo {
		class Chassis : Chassis {
			anim[] = {"animateDoor",{{"Door_RF",0.4},{"Door_RM",0.6}}};
			location[] = {"HitBody","HitHull","HitTurret","HitGun"};
			modelposition[] = {0.910522,-1.52783,-1.26243};
		};
		class Engine : Engine {
			modelposition[] = {0,1.62061,-1.67361};
		};
		class FuelTank: FuelTank {
			anim[] = {"animateDoor",{{"Door_LF",0.4},{"Door_LM",0.6}}};
			modelposition[] = {-0.9104,-1.52539,-1.2751};
		};
		class Wheel_L1 : Wheel_L1 {
			modelposition[] = {-1.35291,0.461426,-2.04067};
		};
		class Wheel_L2 : Wheel_L2 {
			modelposition[] = {-1.35291,-3.4668,-2.02346};
		};
		class Wheel_R1 : Wheel_R1 {
			modelposition[] = {1.39575,0.463867,-2.05254};
		};
		class Wheel_R2 : Wheel_R2 {
			modelposition[] = {1.39587,-3.46289,-2.04485};
		};
	};
	class TransportItems {};
	class TransportWeapons {};
	class TransportMagazines {};
	class TransportBackpacks {};
};
class O_MRAP_02_hmg_F : MRAP_02_hmg_base_F {
	class AnimationSources;
	class Turrets;
	class MainTurret;
	class ViewOptics;
};
class ncb_veh_ifrit_hmg : O_MRAP_02_hmg_F {
	author = "Das Attorney";
	crew = "Horde_gunmanUnit";
	ejectDeadCargo = 0;
	faction = "ncb_antagonists";
	initScript = "";
	//secondaryexplosion = 0;
	typicalCargo[] = {"Horde_gunmanUnit"};
	class AnimationSources: AnimationSources {
		class muzzle_rot {
			source = "ammorandom";
			weapon = "ncb_weap_127x108_hmg_100";
		};
		class muzzle_hide {
			source = "reload";
			weapon = "ncb_weap_127x108_hmg_100";
		};
	};
	class EventHandlers {
		fired = "_this call (uinamespace getvariable 'BIS_fnc_effectFired')";
		killed = "_this call (uinamespace getvariable 'BIS_fnc_effectKilled')";
		class nocebo {
			handledamage = "if (local (_this select 0)) then {_this call horde_fnc_vehicleDamaged}";
			dammaged = "if (local (_this select 0)) then {_this call horde_fnc_vehicleDamageAnims}";
			killed = "\
				if (local (_this select 0)) then {\
					_this remoteExecCall [\
						'horde_fnc_vehicleKilled',\
						2\
					]\
				};\
			";
		};
	};
	class Turrets: Turrets {
		class MainTurret: MainTurret {
			magazines[] = {"ncb_mag_127x108_100","ncb_mag_127x108_100","ncb_mag_127x108_100","ncb_mag_127x108_100"};
			weapons[] = {"ncb_weap_127x108_hmg_100"};
		};
	};
	class VehicleInteractionInfo : VehicleInteractionInfo {
		class Chassis : Chassis {
			anim[] = {"animateDoor",{{"Door_RF",0.4},{"Door_RM",0.6}}};
			location[] = {"HitBody","HitHull","HitTurret","HitGun"};
			modelposition[] = {0.910522,-1.52783,-1.26243};
		};
		class Engine : Engine {
			modelposition[] = {0,1.62061,-1.67361};
		};
		class FuelTank: FuelTank {
			anim[] = {"animateDoor",{{"Door_LF",0.4},{"Door_LM",0.6}}};
			modelposition[] = {-0.9104,-1.52539,-1.2751};
		};
		class Wheel_L1 : Wheel_L1 {
			modelposition[] = {-1.35291,0.461426,-2.04067};
		};
		class Wheel_L2 : Wheel_L2 {
			modelposition[] = {-1.35291,-3.4668,-2.02346};
		};
		class Wheel_R1 : Wheel_R1 {
			modelposition[] = {1.39575,0.463867,-2.05254};
		};
		class Wheel_R2 : Wheel_R2 {
			modelposition[] = {1.39587,-3.46289,-2.04485};
		};
	};
	class TransportItems {};
	class TransportWeapons {};
	class TransportMagazines {};
	class TransportBackpacks {};
};

// PROWLER

// class LSV_01_armed_base_F : LSV_01_base_F {
class LSV_01_armed_base_F;
class ncb_veh_prowler_sand : LSV_01_armed_base_F {
	author = "Das Attorney";
	class SimpleObject {
		eden = 1;
		animate[] = {{"damagehide", 0}, {"damagehidevez", 0}, {"damagehidehlaven", 0}, {"wheel_1_1_destruct", 0}, {"wheel_1_2_destruct", 0}, {"wheel_1_3_destruct", 0}, {"wheel_1_4_destruct", 0}, {"wheel_2_1_destruct", 0}, {"wheel_2_2_destruct", 0}, {"wheel_2_3_destruct", 0}, {"wheel_2_4_destruct", 0}, {"wheel_1_1_destruct_unhide", 0}, {"wheel_1_2_destruct_unhide", 0}, {"wheel_1_3_destruct_unhide", 0}, {"wheel_1_4_destruct_unhide", 0}, {"wheel_2_1_destruct_unhide", 0}, {"wheel_2_2_destruct_unhide", 0}, {"wheel_2_3_destruct_unhide", 0}, {"wheel_2_4_destruct_unhide", 0}, {"wheel_1_3_damage", 0}, {"wheel_1_4_damage", 0}, {"wheel_2_3_damage", 0}, {"wheel_2_4_damage", 0}, {"wheel_1_3_damper_damage_backanim", 0}, {"wheel_1_4_damper_damage_backanim", 0}, {"wheel_2_3_damper_damage_backanim", 0}, {"wheel_2_4_damper_damage_backanim", 0}, {"wheel_1_1", 0}, {"wheel_2_1", 0}, {"wheel_1_2", 0}, {"wheel_2_2", 0}, {"daylights", 0}, {"reverse_light", 0}, {"wheel_1_1_damage", 0}, {"wheel_1_2_damage", 0}, {"wheel_2_1_damage", 0}, {"wheel_2_2_damage", 0}, {"wheel_1_1_damper_damage_backanim", 0}, {"wheel_1_2_damper_damage_backanim", 0}, {"wheel_2_1_damper_damage_backanim", 0}, {"wheel_2_2_damper_damage_backanim", 0}, {"wheel_1_1_damper", 0.41}, {"wheel_2_1_damper", 0.4}, {"wheel_1_2_damper", 0.27}, {"wheel_2_2_damper", 0.26}, {"steeringwheel", 0}, {"steering_1_1", 0}, {"steering_2_1", 0}, {"unarmed_codriver_turret_damage_hide", 0}, {"hidedoor1", 0}, {"hidedoor2", 0}, {"hidedoor3", 0}, {"hidedoor4", 0}, {"hidegunner", 0}, {"displayunhide", 0}, {"rpmunhide", 0}, {"mphunhide", 0}, {"indicatorspeed", 0}, {"indicatorrpm", 0}, {"indicatorrpm_part2", 0}, {"indicatorrpm2", 0}, {"indicatorrpm2_part2", 0}, {"fuel", 1}, {"indicatortemp", 0}, {"indicatortemp_move", 0}, {"mainturret", 0}, {"maingun", 0}, {"mainmuzzleflashrotation", 0}, {"mainmuzzleflashhide", 0}, {"maingunshake", 0}, {"maingunshake_back", 0}, {"codriverturret", 0}, {"codrivergun", 0}, {"codrivermuzzleflashrotation", 0}, {"codrivermuzzleflashhide", 0}, {"codrivergunshake", 0}, {"codrivergunshake_eye", 0}, {"codrivergunshake_back", 0}, {"codrivergunshake_eye_back", 0}, {"codriverfeedtray_cover_up", 0}, {"codrivermagazine_hide", 0}, {"codriverammobelt_hide", 0}, {"codriverfeedtray_cover_down", 0}, {"codriverbullet001", 1}, {"codriverbullet002", 1}, {"codriverbullet003", 1}, {"codriverbullet004", 1}, {"codriverbullet005", 1}, {"codriverammo_belt_rotation_prep", 0}, {"codriverammo_belt_rotation_main", 0}, {"maingunmagazine_hide", 0}, {"maingunammobelt_hide", 0}, {"topgunnerbullet01", 1}, {"topgunnerbullet02", 1}, {"topgunnerbullet03", 1}, {"topgunnerbullet04", 1}, {"topgunnerbullet05", 1}, {"topgunnerbullet06", 1}, {"topgunnerbullet07", 1}, {"topgunnerbullet08", 1}, {"maingunammo_belt_prep", 0}, {"maingunammo_belt_main", 0}, {"wheel_1_1_damper_land_hack", 0}, {"wheel_1_2_damper_land_hack", 0}, {"wheel_2_1_damper_land_hack", 0}, {"wheel_2_2_damper_land_hack", 0}};
		hide[] = {"clan", "zasleh", "light_1_hide", "light_2_hide", "zadni svetlo", "brzdove svetlo", "podsvit pristroju", "poskozeni"};
		verticalOffset = 2.054;
		verticalOffsetWorld = -0.122;
		init = "[this, '', []] call bis_fnc_initVehicle";
	};
	editorPreview = "\A3\EditorPreviews_F_Exp\Data\CfgVehicles\B_LSV_01_armed_F.jpg";
	scope = 2;
	scopeCurator = 2;
	DLC = "Expansion";
	side = 2;
	faction = "ncb_renegades";
	crew = "Horde_renegadeUnit";
	typicalCargo[] = {"Horde_renegadeUnit"};
	textureList[] = {"Sand", 1};
	hiddenSelectionsTextures[] = {"\A3\Soft_F_Exp\LSV_01\Data\NATO_LSV_01_sand_CO.paa", "\A3\Soft_F_Exp\LSV_01\Data\NATO_LSV_02_sand_CO.paa", "\A3\Soft_F_Exp\LSV_01\Data\NATO_LSV_03_sand_CO.paa", "\A3\Soft_F_Exp\LSV_01\Data\NATO_LSV_Adds_sand_CO.paa"};
	class EventHandlers {
		//init = "if (local (_this select 0)) then {(_this select 0) animate ['Unarmed_Main_Turret_hide',1]}";
		fired = "_this call (uinamespace getvariable 'BIS_fnc_effectFired')";
		killed = "_this call (uinamespace getvariable 'BIS_fnc_effectKilled')";
		class nocebo {
			handledamage = "if (local (_this select 0)) then {_this call horde_fnc_vehicleDamaged}";
			dammaged = "if (local (_this select 0)) then {_this call horde_fnc_vehicleDamageAnims}";
			killed = "\
				if (local (_this select 0)) then {\
					_this remoteExecCall [\
						'horde_fnc_vehicleKilled',\
						2\
					]\
				};\
			";
		};
	};
	class VehicleInteractionInfo : VehicleInteractionInfo {
		class Chassis : Chassis {
			anim[] = {"animate",{{"hidedoor3",0.4},{"hidedoor4",0.7}}};
			location[] = {"HitBody","HitHull","HitTurret","HitGun"};
			modelposition[] = {1.03223,0.0371094,-1.29074};
		};
		class Engine : Engine {
			modelposition[] = {0,2.21582,-0.999554};
		};
		class FuelTank: FuelTank {
			anim[] = {"animate",{{"hidedoor1",0.4},{"hidedoor2",0.7}}};
			modelposition[] = {-0.989258,0.0371094,-1.29074};
		};
		class Wheel_L1 : Wheel_L1 {
			modelposition[] = {-0.932617,1.62793,-1.72436};
		};
		class Wheel_L2 : Wheel_L2 {
			modelposition[] = {-0.932617,-1.50684,-1.72436};
		};
		class Wheel_R1 : Wheel_R1 {
			modelposition[] = {1.01611,1.62793,-1.72436};
		};
		class Wheel_R2 : Wheel_R2 {
			modelposition[] = {1.01611,-1.50684,-1.72436};
		};
	};
	class TransportItems {};
	class TransportWeapons {};
	class TransportMagazines {};
	class TransportBackpacks {};
};
class ncb_veh_prowler_black : ncb_veh_prowler_sand {
	textureList[] = {"Black", 1};
	hiddenSelectionsTextures[] = {"\A3\Soft_F_Exp\LSV_01\Data\NATO_LSV_01_black_CO.paa", "\A3\Soft_F_Exp\LSV_01\Data\NATO_LSV_02_black_CO.paa", "\A3\Soft_F_Exp\LSV_01\Data\NATO_LSV_03_black_CO.paa", "\A3\Soft_F_Exp\LSV_01\Data\NATO_LSV_Adds_black_CO.paa"};
};
class ncb_veh_prowler_olive : ncb_veh_prowler_black {
	textureList[] = {"Olive", 1};
	hiddenSelectionsTextures[] = {"\A3\Soft_F_Exp\LSV_01\Data\NATO_LSV_01_olive_CO.paa", "\A3\Soft_F_Exp\LSV_01\Data\NATO_LSV_02_olive_CO.paa", "\A3\Soft_F_Exp\LSV_01\Data\NATO_LSV_03_olive_CO.paa", "\A3\Soft_F_Exp\LSV_01\Data\NATO_LSV_Adds_olive_CO.paa"};
};

// QILIN
class LSV_02_base_F : Car_F {
	class AnimationSources;
	class Turrets;
	class cargoturret_01;
	class cargoturret_02;
	class cargoturret_03;
	class cargoturret_04;
	class cargoturret_05;
	class MainTurret;
};
// class LSV_02_base_F : Car_F {
// 	horde_primWeapMinCalLevel = 2;
// };
class LSV_02_unarmed_base_F;
class O_LSV_02_unarmed_F: LSV_02_unarmed_base_F {};
class ncb_veh_qilin : O_LSV_02_unarmed_F {
	author = "Das Attorney";
	crew = "Horde_gunmanUnit";
	ejectDeadCargo = 0;
	ejectDeadDriver = 0;
	faction = "ncb_antagonists";
	initScript = "";
	//secondaryexplosion = 0;
	typicalCargo[] = {"Horde_gunmanUnit"};
	class EventHandlers {
		killed = "_this call (uinamespace getvariable 'BIS_fnc_effectKilled')";
		class nocebo {
			init = "if (local (_this select 0)) then {(_this select 0) animate ['Unarmed_Main_Turret_hide',1]}";
			handledamage = "if (local (_this select 0)) then {_this call horde_fnc_vehicleDamaged}";
			dammaged = "if (local (_this select 0)) then {_this call horde_fnc_vehicleDamageAnims}";
			killed = "\
				if (local (_this select 0)) then {\
					_this remoteExecCall [\
						'horde_fnc_vehicleKilled',\
						2\
					]\
				};\
			";
		};
	};
	class VehicleInteractionInfo : VehicleInteractionInfo {
		class Chassis : Chassis {
			anim[] = {"animate",{{"Unarmed_Doors_Hide",0.6}}};
			modelposition[] = {0.9,0,-1};
		};
		class Engine : Engine {
			modelposition[] = {-0.18,2.2,-0.5};
		};
		class FuelTank: FuelTank {
			anim[] = {};
			modelposition[] = {-1.2,0,-1};
		};
		class Wheel_L1 : Wheel_L1 {
			modelposition[] = {-1.2,1.65,-1.2};
		};
		class Wheel_L2 : Wheel_L2 {
			modelposition[] = {-1.2,-1.75,-1.2};
		};
		class Wheel_R1 : Wheel_R1 {
			modelposition[] = {0.9,1.65,-1.2};
		};
		class Wheel_R2 : Wheel_R2 {
			modelposition[] = {0.9,-1.75,-1.2};
		};

	};
	class TransportItems {};
	class TransportWeapons {};
	class TransportMagazines {};
	class TransportBackpacks {};
};

class LSV_02_armed_base_F : LSV_02_base_F {
	class AnimationSources : AnimationSources {};
	class Turrets : Turrets {
		class cargoturret_01 : cargoturret_01 {};
		class cargoturret_02 : cargoturret_02 {};
		class cargoturret_03 : cargoturret_03 {};
		class cargoturret_04 : cargoturret_04 {};
		class cargoturret_05 : cargoturret_05 {};
		class MainTurret : MainTurret {};
	};
};
class O_LSV_02_armed_F : LSV_02_armed_base_F {
	class AnimationSources : AnimationSources {};
	class Turrets : Turrets {
		class cargoturret_01 : cargoturret_01 {};
		class cargoturret_02 : cargoturret_02 {};
		class cargoturret_03 : cargoturret_03 {};
		class cargoturret_04 : cargoturret_04 {};
		class cargoturret_05 : cargoturret_05 {};
		class MainTurret : MainTurret {};
	};
};
class ncb_veh_qilin_minigun : O_LSV_02_armed_F {
	author = "Das Attorney";
	crew = "Horde_gunmanUnit";
	ejectDeadCargo = 0;
	ejectDeadDriver = 0;
	faction = "ncb_antagonists";
	initScript = "";
	//secondaryexplosion = 0;
	typicalCargo[] = {"Horde_gunmanUnit"};
	class AnimationSources : AnimationSources {
		class muzzle_rot {
			source = "ammorandom";
			weapon = "M134_minigun_land";
		};
		class Minigun {
			source = "revolving";
			weapon = "M134_minigun_land";
		};
	};
	class EventHandlers {
		fired = "_this call (uinamespace getvariable 'BIS_fnc_effectFired')";
		killed = "_this call (uinamespace getvariable 'BIS_fnc_effectKilled')";
		class nocebo {
			handledamage = "if (local (_this select 0)) then {_this call horde_fnc_vehicleDamaged}";
			dammaged = "if (local (_this select 0)) then {_this call horde_fnc_vehicleDamageAnims}";
			killed = "\
				if (local (_this select 0)) then {\
					_this remoteExecCall [\
						'horde_fnc_vehicleKilled',\
						2\
					]\
				};\
			";
		};
	};
	class VehicleInteractionInfo : VehicleInteractionInfo {
		class Chassis : Chassis {
			anim[] = {"animate",{{"Unarmed_Doors_Hide",0.6}}};
			location[] = {"HitBody","HitHull","HitTurret","HitGun"};
			modelposition[] = {0.9,0,-1};
		};
		class Engine : Engine {
			modelposition[] = {-0.18,2.2,-0.5};
		};
		class FuelTank: FuelTank {
			anim[] = {};
			modelposition[] = {-1.2,0,-1};
		};
		class Wheel_L1 : Wheel_L1 {
			modelposition[] = {-1.2,1.65,-1.2};
		};
		class Wheel_L2 : Wheel_L2 {
			modelposition[] = {-1.2,-1.75,-1.2};
		};
		class Wheel_R1 : Wheel_R1 {
			modelposition[] = {0.9,1.65,-1.2};
		};
		class Wheel_R2 : Wheel_R2 {
			modelposition[] = {0.9,-1.75,-1.2};
		};
	};
	class Turrets : Turrets {
		class MainTurret: MainTurret {
			ejectDeadGunner = 0;
			magazines[] = {"ncb_mag_762x51_1000_g"};
			weapons[] = {"M134_minigun_land"};
		};
		class CargoTurret_01 : CargoTurret_01 {};
		class CargoTurret_02 : CargoTurret_02 {};
		class CargoTurret_03 : CargoTurret_03 {};
		class CargoTurret_04 : CargoTurret_04 {};
		class CargoTurret_05 : CargoTurret_05 {};
	};
	class TransportItems {};
	class TransportWeapons {};
	class TransportMagazines {};
	class TransportBackpacks {};
};

//  STRIDER

class MRAP_03_base_F : Car_F {
	class TransportItems {};
	class TransportWeapons {};
	class TransportMagazines {};
	class TransportBackpacks {};
};
class MRAP_03_hmg_base_F : MRAP_03_base_F {
	class Turrets;
	class MainTurret;
	class ViewOptics;
};
class MRAP_03_gmg_base_F : MRAP_03_hmg_base_F {};
class I_MRAP_03_F : MRAP_03_base_F {};
class ncb_veh_strider : I_MRAP_03_F {
	author = "Das Attorney";
	crew = "Horde_gunmanUnit";
	ejectDeadCargo = 0;
	ejectDeadDriver = 0;
	faction = "ncb_antagonists";
	hiddenSelectionsTextures[] = {"\nocebo\images\strider_hex_co.paa"};
	initScript = "";
	//secondaryexplosion = 0;
	typicalCargo[] = {"Horde_gunmanUnit"};

	class EventHandlers {
		fired = "_this call (uinamespace getvariable 'BIS_fnc_effectFired')";
		killed = "_this call (uinamespace getvariable 'BIS_fnc_effectKilled')";
		class nocebo {
			handledamage = "if (local (_this select 0)) then {_this call horde_fnc_vehicleDamaged}";
			dammaged = "if (local (_this select 0)) then {_this call horde_fnc_vehicleDamageAnims}";
			killed = "\
				if (local (_this select 0)) then {\
					_this remoteExecCall [\
						'horde_fnc_vehicleKilled',\
						2\
					]\
				};\
			";
		};
	};
	class VehicleInteractionInfo : VehicleInteractionInfo {
		class Chassis : Chassis {
			location[] = {"HitBody","HitHull","HitTurret","HitGun"};
			modelposition[] = {1.29,-0.51,-0.37};
		};
		class Engine : Engine {
			modelposition[] = {0,2.5,-0.44};
		};
		class FuelTank: FuelTank {
			modelposition[] = {-1.29,-0.51,-0.37};
		};
		class Wheel_L1 : Wheel_L1 {
			modelposition[] = {-1.39,1.36,-1.12};
		};
		class Wheel_L2 : Wheel_L2 {
			modelposition[] = {-1.39,-1.82,-1.12};
		};
		class Wheel_R1 : Wheel_R1 {
			modelposition[] = {1.39,1.36,-1.12};
		};
		class Wheel_R2 : Wheel_R2 {
			modelposition[] = {1.39,-1.82,-0.87};
		};
		class AddWeapon {
			anim[] = {};
			modelposition[] = {0,-2.91,-1.17};
			text = "Add weapon";
			textparts = "weapon parts";
			tools[] = {"ItemGrinder","ItemDrill","ItemHammer"};
			weaponconfig[] = {
				{
					{"ncb_weaponbag_hmg_low","ncb_weaponbag_hmg_high"},
					"Add HMG",
					"ncb_veh_strider_hmg",
					"spawn horde_fnc_addWeaponToVehicle",
					15
				};
				{
					{"ncb_weaponbag_gmg_low","ncb_weaponbag_gmg_high"},
					"Add GMG",
					"ncb_veh_strider_gmg",
					"spawn horde_fnc_addWeaponToVehicle",
					15
				};
			};
		};
	};
	class TransportItems {};
	class TransportWeapons {};
	class TransportMagazines {};
	class TransportBackpacks {};
};
class I_MRAP_03_hmg_F : MRAP_03_hmg_base_F {
	class AnimationSources;
	class Turrets;
	class MainTurret;
	class CommanderTurret;
};
class ncb_veh_strider_hmg : I_MRAP_03_hmg_F {
	author = "Das Attorney";
	crew = "Horde_gunmanUnit";
	ejectDeadCargo = 0;
	ejectDeadDriver = 0;
	faction = "ncb_antagonists";
	hiddenSelectionsTextures[] = {"\nocebo\images\strider_hex_co.paa","\nocebo\images\strider_hex_turret_co.paa"};
	initScript = "";
	//secondaryexplosion = 0;
	typicalCargo[] = {"Horde_gunmanUnit"};
	class AnimationSources : AnimationSources {
		class muzzle_rot {
			source = "ammorandom";
			weapon = "ncb_weap_127x108_hmg_200";
		};
		class muzzle_hide {
			source = "reload";
			weapon = "ncb_weap_127x108_hmg_200";
		};
	};
	class EventHandlers {
		fired = "_this call (uinamespace getvariable 'BIS_fnc_effectFired')";
		killed = "_this call (uinamespace getvariable 'BIS_fnc_effectKilled')";
		class nocebo {
			handledamage = "if (local (_this select 0)) then {_this call horde_fnc_vehicleDamaged}";
			dammaged = "if (local (_this select 0)) then {_this call horde_fnc_vehicleDamageAnims}";
			killed = "\
				if (local (_this select 0)) then {\
					_this remoteExecCall [\
						'horde_fnc_vehicleKilled',\
						2\
					]\
				};\
			";
		};
	};
	class Turrets : Turrets {
		class MainTurret : MainTurret {
			weapons[] = {"ncb_weap_127x108_hmg_200"};
			magazines[] = {"ncb_mag_127x108_200","ncb_mag_127x108_200"};
		};
		class CommanderTurret : CommanderTurret {};
	};
	class VehicleInteractionInfo : VehicleInteractionInfo {
		class Chassis : Chassis {
			location[] = {"HitBody","HitHull","HitTurret","HitGun"};
			modelposition[] = {1.29,-0.51,-1.1};
		};
		class Engine : Engine {
			modelposition[] = {0,2.5,-1.17};
		};
		class FuelTank: FuelTank {
			modelposition[] = {-1.29,-0.51,-1.1};
		};
		class Wheel_L1 : Wheel_L1 {
			modelposition[] = {-1.39,1.36,-1.85};
		};
		class Wheel_L2 : Wheel_L2 {
			modelposition[] = {-1.39,-1.82,-1.85};
		};
		class Wheel_R1 : Wheel_R1 {
			modelposition[] = {1.39,1.36,-1.85};
		};
		class Wheel_R2 : Wheel_R2 {
			modelposition[] = {1.39,-1.82,-1.85};
		};
	};
	class TransportItems {};
	class TransportWeapons {};
	class TransportMagazines {};
	class TransportBackpacks {};
};
class I_MRAP_03_gmg_F : MRAP_03_gmg_base_F {
	class AnimationSources;
	class Turrets;
	class MainTurret;
	class CommanderTurret;
};
class ncb_veh_strider_gmg : I_MRAP_03_gmg_F {
	author = "Das Attorney";
	crew = "Horde_gunmanUnit";
	ejectDeadCargo = 0;
	ejectDeadDriver = 0;
	faction = "ncb_antagonists";
	// hiddenSelectionsTextures[] = {"\nocebo\images\strider_hex_co.paa"};
	hiddenSelectionsTextures[] = {"\nocebo\images\strider_hex_co.paa","\nocebo\images\strider_hex_turret_co.paa"};
	initScript = "";
	//secondaryexplosion = 0;
	typicalCargo[] = {"Horde_gunmanUnit"};
	class EventHandlers {
		fired = "_this call (uinamespace getvariable 'BIS_fnc_effectFired')";
		killed = "_this call (uinamespace getvariable 'BIS_fnc_effectKilled')";
		class nocebo {
			handledamage = "if (local (_this select 0)) then {_this call horde_fnc_vehicleDamaged}";
			dammaged = "if (local (_this select 0)) then {_this call horde_fnc_vehicleDamageAnims}";
			killed = "\
				if (local (_this select 0)) then {\
					_this remoteExecCall [\
						'horde_fnc_vehicleKilled',\
						2\
					]\
				};\
			";
		};
	};
	class VehicleInteractionInfo : VehicleInteractionInfo {
		class Chassis : Chassis {
			location[] = {"HitBody","HitHull","HitTurret","HitGun"};
			modelposition[] = {1.29,-0.51,-1.1};
		};
		class Engine : Engine {
			modelposition[] = {0,2.5,-1.17};
		};
		class FuelTank: FuelTank {
			modelposition[] = {-1.29,-0.51,-1.1};
		};
		class Wheel_L1 : Wheel_L1 {
			modelposition[] = {-1.39,1.36,-1.85};
		};
		class Wheel_L2 : Wheel_L2 {
			modelposition[] = {-1.39,-1.82,-1.85};
		};
		class Wheel_R1 : Wheel_R1 {
			modelposition[] = {1.39,1.36,-1.85};
		};
		class Wheel_R2 : Wheel_R2 {
			modelposition[] = {1.39,-1.82,-1.85};
		};
	};
	class TransportItems {};
	class TransportWeapons {};
	class TransportMagazines {};
	class TransportBackpacks {};
};

// CIV VAN

class Truck_F;
class Van_01_base_F : Truck_F {
	class Logistics {
		class Config_1 {
			class slot_1 {
				cargoLockIndices[] = {2,3,4,5,6,7,8,9,10,11};
				choices[] = {
					{"ncb_obj_ammobox_m",{0.02,-1,0.3},{{1,0,0},{0,0,1}}},
					{"ncb_obj_ammobox_l",{0.02,-1,0.3},{{0,1,0},{0,0,1}}},
					{"ncb_obj_fuel_supply_m",{0.02,-1,0.3},{{0,0,0},{0,0,1}}},
					{"ncb_obj_repair_parts_box_m",{0.02,-1,0.3},{{0,1,0},{0,0,1}}}
				};
			};
			class slot_2 {
				cargoLockIndices[] = {2,3,4,5,6,7,8,9,10,11};
				choices[] = {
					{"ncb_obj_ammobox_m",{0.02,-2.6,0.3},{{1,0,0},{0,0,1}}},
					{"ncb_obj_ammobox_l",{0.02,-2.6,0.3},{{0,1,0},{0,0,1}}},
					{"ncb_obj_fuel_supply_m",{0.02,-2.6,0.3},{{0,0,0},{0,0,1}}},
					{"ncb_obj_repair_parts_box_m",{0.02,-2.6,0.3},{{0,1,0},{0,0,1}}}
				};
			};
		};
		class Config_2 {
			class slot_1 {
				cargoLockIndices[] = {2,3,4,5,6,7,8,9,10,11};
				choices[] = {
					{"ncb_veh_quadbike",{0,-1.8,0.82},{{0,1,0},{0,0,1}}}
				};
			};
		};
	};
};

class C_Van_01_transport_F;
class ncb_veh_van_transport : C_Van_01_transport_F {
	author = "Das Attorney";
	ejectDeadCargo = 0;
	ejectDeadDriver = 0;
	initScript = "horde_fnc_initVan";
	//secondaryexplosion = 0;
	class EventHandlers {
		killed = "_this call (uinamespace getvariable 'BIS_fnc_effectKilled')";
		class nocebo {
			dammaged = "if (local (_this select 0)) then {_this call horde_fnc_vehicleDamageAnims}";
			handledamage = "if (local (_this select 0)) then {_this call horde_fnc_vehicleDamaged}";
			killed = "\
				if (local (_this select 0)) then {\
					_this remoteExecCall [\
						'horde_fnc_vehicleKilled',\
						2\
					]\
				};\
			";
		};
	};
	class VehicleInteractionInfo : VehicleInteractionInfo {
		class Chassis : Chassis {
			anim[] = {"animate",{{"HideGlass1", 0.2},{"HideDoor1", 0.5}}};
			modelposition[] = {-0.967896,-0.857422,-0.874435};
			class actions : actions {
				class addParts : addParts {};
				class swapParts : swapParts {};
				class takeParts : takeParts {};
				class loadVehicle {
					baseTime = 0;
					failTextLocStatus = "You cannot load any more cargo into this vehicle";
					failTextHasPart = "";
					script = "spawn horde_fnc_loadVehicleCargo";
					text = "Load cargo";
					type = "call horde_fnc_setVehicleCargoDlg";
				};
				class unloadVehicle : loadVehicle {
					failTextLocStatus = "There is no cargo in this vehicle";
					script = "spawn horde_fnc_unloadVehicleCargo";
					text = "Unload cargo";
				};
			};
		};
		class Engine : Engine {
			anim[] = {"animate",{{"HideGlass3",0.3},{"dummy",0.6}}};
			modelposition[] = {-0.0157471,2.02002,-0.492599};
		};
		class FuelTank: FuelTank {
			anim[] = {"animate",{{"HideGlass2", 0.2},{"HideDoor2", 0.5}}};
			modelposition[] = {0.909668,-0.844238,-0.882004};
		};
		class Wheel_L1 : Wheel_L1 {
			modelposition[] = {-0.97168,1.26953,-1.2446};
		};
		class Wheel_L2 : Wheel_L2 {
			modelposition[] = {-0.970947,-2.00537,-1.34784};
		};
		class Wheel_R1 : Wheel_R1 {
			modelposition[] = {0.932129,1.27783,-1.23753};
		};
		class Wheel_R2 : Wheel_R2 {
			modelposition[] = {0.932617,-2.00195,-1.3495};
		};
	};
	class TransportItems {};
	class TransportWeapons {};
	class TransportMagazines {};
	class TransportBackpacks {};
};
class Van_01_box_base_F : Van_01_base_F {
	class Logistics : Logistics {
		class Config_1 : Config_1 {
			class slot_1 : slot_1 {
				cargoLockIndices[] = {};
			};
			class slot_2 : slot_2 {
				cargoLockIndices[] = {};
			};
		};
		class Config_2 : Config_2 {
			class slot_1 : slot_1 {
				cargoLockIndices[] = {};
			};
		};
	};
};
class C_Van_01_box_F;
class ncb_veh_van_box : C_Van_01_box_F {
	author = "Das Attorney";
	ejectDeadCargo = 0;
	ejectDeadDriver = 0;
	initScript = "horde_fnc_initVan";
	//secondaryexplosion = 0;
	class EventHandlers {
		killed = "_this call (uinamespace getvariable 'BIS_fnc_effectKilled')";
		class nocebo {
			dammaged = "if (local (_this select 0)) then {_this call horde_fnc_vehicleDamageAnims}";
			killed = "\
				if (local (_this select 0)) then {\
					_this remoteExecCall [\
						'horde_fnc_vehicleKilled',\
						2\
					]\
				};\
			";
		};
	};
	class VehicleInteractionInfo : VehicleInteractionInfo {
		class Chassis : Chassis {
			anim[] = {"animate",{{"HideGlass1", 0.2},{"HideDoor1", 0.5}}};
			modelposition[] = {-0.967896,-0.857422,-0.874435};
			class actions : actions {
				class addParts : addParts {};
				class swapParts : swapParts {};
				class takeParts : takeParts {};
				class loadVehicle {
					baseTime = 0;
					failTextLocStatus = "You cannot load any more cargo into this vehicle";
					failTextHasPart = "";
					script = "spawn horde_fnc_loadVehicleCargo";
					text = "Load cargo";
					type = "call horde_fnc_setVehicleCargoDlg";
				};
				class unloadVehicle : loadVehicle {
					failTextLocStatus = "There is no cargo in this vehicle";
					script = "spawn horde_fnc_unloadVehicleCargo";
					text = "Unload cargo";
				};
			};
		};
		class Engine : Engine {
			anim[] = {"animate",{{"HideGlass3",0.3},{"dummy",0.6}}};
			modelposition[] = {-0.0157471,2.02002,-0.492599};
		};
		class FuelTank: FuelTank {
			anim[] = {"animate",{{"HideGlass2", 0.2},{"HideDoor2", 0.5}}};
			modelposition[] = {0.909668,-0.844238,-0.882004};
		};
		class Wheel_L1 : Wheel_L1 {
			modelposition[] = {-0.97168,1.26953,-1.2446};
		};
		class Wheel_L2 : Wheel_L2 {
			modelposition[] = {-0.970947,-2.00537,-1.34784};
		};
		class Wheel_R1 : Wheel_R1 {
			modelposition[] = {0.932129,1.27783,-1.23753};
		};
		class Wheel_R2 : Wheel_R2 {
			modelposition[] = {0.932617,-2.00195,-1.3495};
		};
	};
	class TransportItems {};
	class TransportWeapons {};
	class TransportMagazines {};
	class TransportBackpacks {};
};

// ZAMAK

class Truck_02_base_F : Truck_F {
	class Logistics {
		class Config_1 {
			class slot_1 {
				// cargoLockIndices[] = {2,3,4,5,6,7,8,9,10,11,12,13,14,15};
				cargoLockIndices[] = {2,3,4,5};
				choices[] = {
					{"ncb_obj_ammobox_m",{0.02,0.4,0},{{1,0,0},{0,0,1}}},
					{"ncb_obj_ammobox_l",{0.02,0.4,0},{{0,1,0},{0,0,1}}},
					{"ncb_obj_fuel_supply_m",{0.02,0.4,0},{{0,0,0},{0,0,1}}},
					{"ncb_obj_repair_parts_box_m",{0.02,0.4,0},{{0,1,0},{0,0,1}}}
				};
			};
			class slot_2 {
				// cargoLockIndices[] = {2,3,4,5,6,7,8,9,10,11,12,13,14,15};
				cargoLockIndices[] = {6,7,8,9,10,11};
				choices[] = {
					{"ncb_obj_ammobox_m",{0.02,-1.3,0},{{1,0,0},{0,0,1}}},
					{"ncb_obj_ammobox_l",{0.02,-1.3,0},{{0,1,0},{0,0,1}}},
					{"ncb_obj_fuel_supply_m",{0.02,-1.3,0},{{0,0,0},{0,0,1}}},
					{"ncb_obj_repair_parts_box_m",{0.02,-1.3,0},{{0,1,0},{0,0,1}}}
				};
			};
			class slot_3 {
				// cargoLockIndices[] = {2,3,4,5,6,7,8,9,10,11,12,13,14,15};
				cargoLockIndices[] = {12,13,14,15};
				choices[] = {
					{"ncb_obj_ammobox_m",{0.02,-2.9,0},{{1,0,0},{0,0,1}}},
					{"ncb_obj_ammobox_l",{0.02,-2.9,0},{{0,1,0},{0,0,1}}},
					{"ncb_obj_fuel_supply_m",{0.02,-2.9,0},{{0,0,0},{0,0,1}}},
					{"ncb_obj_repair_parts_box_m",{0.02,-2.9,0},{{0,1,0},{0,0,1}}}
				};
			};
		};
		class Config_2 {
			class slot_1 {
				// cargoLockIndices[] = {2,3,4,5,6,7,8,9,10,11,12,13,14,15};
				cargoLockIndices[] = {2,3,4,5,6,7,8,9};
				choices[] = {
					{"ncb_veh_quadbike",{0.02,0.1,0.61},{{0,1,0},{0,0,1}}}
				};
			};
			class slot_2 {
				// cargoLockIndices[] = {2,3,4,5,6,7,8,9,10,11,12,13,14,15};
				cargoLockIndices[] = {10,11,12,13,14,15};
				choices[] = {
					{"ncb_veh_quadbike",{0.02,-2.3,0.61},{{0,1,0},{0,0,1}}},
					{"ncb_obj_ammobox_m",{0.02,-2.3,0.1},{{1,0,0},{0,0,1}}},
					{"ncb_obj_ammobox_l",{0.02,-2.3,0.1},{{0,1,0},{0,0,1}}},
					{"ncb_obj_fuel_supply_m",{0.02,-2.3,-0.3},{{0,0,0},{0,0,1}}},
					{"ncb_obj_repair_parts_box_m",{0.02,-2.3,-0.2},{{0,1,0},{0,0,1}}}
				};
			};
		};
		class Config_3 {
			class slot_1 {
				cargoLockIndices[] = {2,3,4,5,6,7,8,9,10,11,12,13,14,15};
				choices[] = {
					{"ncb_boat_inflatable",{0.02,-1.25,0.74},{{0,1,0},{0,0,1}}}
				};
			};
		};
	};
};
class O_Truck_02_covered_F : Truck_02_base_F {
	class Turrets;
	class CargoTurret_01;
	class CargoTurret_02;
};
class ncb_veh_zamak_covered : O_Truck_02_covered_F {
	author = "Das Attorney";
	crew = "Horde_gunmanUnit";
	displayName = "Zamak";
	ejectDeadCargo = 0;
	ejectDeadDriver = 0;
	initScript = "";
	faction = "ncb_antagonists";
	//secondaryexplosion = 0;
	typicalCargo[] = {"Horde_gunmanUnit"};
	class EventHandlers {
		killed = "_this call (uinamespace getvariable 'BIS_fnc_effectKilled')";
		class nocebo {
			handledamage = "if (local (_this select 0)) then {_this call horde_fnc_vehicleDamaged}";
			dammaged = "if (local (_this select 0)) then {_this call horde_fnc_vehicleDamageAnims}";
			killed = "\
				if (local (_this select 0)) then {\
					_this remoteExecCall [\
						'horde_fnc_vehicleKilled',\
						2\
					]\
				};\
			";
		};
	};
	class VehicleInteractionInfo : VehicleInteractionInfo {
		class Chassis : Chassis {
			anim[] = {};
			modelposition[] = {1.00806,1.03516,-1.22286};
			class actions : actions {
				class addParts : addParts {};
				class swapParts : swapParts {};
				class takeParts : takeParts {};
				class loadVehicle {
					baseTime = 0;
					failTextLocStatus = "You cannot load any more cargo into this vehicle";
					failTextHasPart = "";
					script = "spawn horde_fnc_loadVehicleCargo";
					text = "Load cargo";
					type = "call horde_fnc_setVehicleCargoDlg";
				};
				class unloadVehicle : loadVehicle {
					failTextLocStatus = "There is no cargo in this vehicle";
					script = "spawn horde_fnc_unloadVehicleCargo";
					text = "Unload cargo";
				};
			};
		};
		class Engine : Engine {
			modelposition[] = {0.0407715,3.8125,-0.874527};
		};
		class FuelTank: FuelTank {
			anim[] = {};
			modelposition[] = {-0.867676,0.864258,-1.2836};
		};
		class Wheel_L1 : Wheel_L1 {
			modelposition[] = {-1.08704,2.58594,-1.58017};
		};
		class Wheel_L2 : Wheel_L2 {
			modelposition[] = {-1.08557,-0.647949,-1.6865};
			text = "Left middle wheel";
		};
		class Wheel_L3 : Wheel_L3 {
			modelposition[] = {-1.08789,-1.9707,-1.7298};
		};
		class Wheel_R1 : Wheel_R1 {
			modelposition[] = {1.22986,2.59082,-1.60993};
		};
		class Wheel_R2 : Wheel_R2 {
			modelposition[] = {1.22852,-0.642578,-1.67944};
			text = "Right middle wheel";
		};
		class Wheel_R3 : Wheel_R3 {
			modelposition[] = {1.2301,-1.96484,-1.73439};
		};
	};
	class TransportItems {};
	class TransportWeapons {};
	class TransportMagazines {};
	class TransportBackpacks {};
	class Turrets : Turrets {
		class CargoTurret_01 : CargoTurret_01 {
			ejectDeadGunner = 0;
		};
		class CargoTurret_02 : CargoTurret_02 {
			ejectDeadGunner = 0;
		};
	};
};
// class O_Truck_02_transport_F : Truck_02_base_F {
class Truck_02_transport_base_F;
class O_Truck_02_transport_F : Truck_02_transport_base_F {
	class Turrets;
	class CargoTurret_01;
	class CargoTurret_02;
};
class ncb_veh_zamak_open : O_Truck_02_transport_F {
	author = "Das Attorney";
	crew = "Horde_gunmanUnit";
	displayName = "Zamak";
	ejectDeadCargo = 0;
	ejectDeadDriver = 0;
	faction = "ncb_antagonists";
	initScript = "";
	secondaryexplosion = 0;
	typicalCargo[] = {"Horde_gunmanUnit"};
	class EventHandlers {
		killed = "_this call (uinamespace getvariable 'BIS_fnc_effectKilled')";
		class nocebo {
			handledamage = "if (local (_this select 0)) then {_this call horde_fnc_vehicleDamaged}";
			dammaged = "if (local (_this select 0)) then {_this call horde_fnc_vehicleDamageAnims}";
			killed = "\
				if (local (_this select 0)) then {\
					_this remoteExecCall [\
						'horde_fnc_vehicleKilled',\
						2\
					]\
				};\
			";
		};
	};
	class VehicleInteractionInfo : VehicleInteractionInfo {
		class Chassis : Chassis {
			anim[] = {};
			modelposition[] = {1.00806,1.03516,-1.22286};
			class actions : actions {
				class addParts : addParts {};
				class swapParts : swapParts {};
				class takeParts : takeParts {};
				class loadVehicle {
					baseTime = 0;
					failTextLocStatus = "You cannot load any more cargo into this vehicle";
					failTextHasPart = "";
					script = "spawn horde_fnc_loadVehicleCargo";
					text = "Load cargo";
					type = "call horde_fnc_setVehicleCargoDlg";
				};
				class unloadVehicle : loadVehicle {
					failTextLocStatus = "There is no cargo in this vehicle";
					script = "spawn horde_fnc_unloadVehicleCargo";
					text = "Unload cargo";
				};
			};
		};
		class Engine : Engine {
			modelposition[] = {0.0407715,3.8125,-0.874527};
		};
		class FuelTank: FuelTank {
			anim[] = {};
			modelposition[] = {-0.867676,0.864258,-1.2836};
		};
		class Wheel_L1 : Wheel_L1 {
			modelposition[] = {-1.08704,2.58594,-1.58017};
		};
		class Wheel_L2 : Wheel_L2 {
			modelposition[] = {-1.08557,-0.647949,-1.6865};
			text = "Left middle wheel";
		};
		class Wheel_L3 : Wheel_L3 {
			modelposition[] = {-1.08789,-1.9707,-1.7298};
		};
		class Wheel_R1 : Wheel_R1 {
			modelposition[] = {1.22986,2.59082,-1.60993};
		};
		class Wheel_R2 : Wheel_R2 {
			modelposition[] = {1.22852,-0.642578,-1.67944};
			text = "Right middle wheel";
		};
		class Wheel_R3 : Wheel_R3 {
			modelposition[] = {1.2301,-1.96484,-1.73439};
		};
	};
	class TransportItems {};
	class TransportWeapons {};
	class TransportMagazines {};
	class TransportBackpacks {};
	class Turrets : Turrets {
		class CargoTurret_01 : CargoTurret_01 {
			ejectDeadGunner = 0;
		};
		class CargoTurret_02 : CargoTurret_02 {
			ejectDeadGunner = 0;
		};
	};
};
//industrial
class ncb_veh_zamak_covered_industrial : ncb_veh_zamak_covered {
	faction = "CIV_F";
	initScript = "horde_fnc_initIndustrialTruck";
	side = 3;
};
class ncb_veh_zamak_open_industrial : ncb_veh_zamak_open {
	faction = "CIV_F";
	initScript = "horde_fnc_initIndustrialTruck";
	side = 3;
};

// TEMPEST

class Truck_03_base_F : Truck_F {
	class Logistics {
		class Config_1 {
			class slot_1 {
				cargoLockIndices[] = {1,2,3,4,5,6,7,8,9,10,11,12};
				choices[] = {
					{"ncb_obj_ammobox_m",{0.02,-0.8,0.3},{{1,0,0},{0,0,1}}},
					{"ncb_obj_ammobox_l",{0.02,-0.8,0.3},{{0,1,0},{0,0,1}}},
					{"ncb_obj_fuel_supply_m",{0.02,-0.8,0.3},{{0,0,0},{0,0,1}}},
					{"ncb_obj_repair_parts_box_m",{0.02,-0.8,0.3},{{0,1,0},{0,0,1}}}
				};
			};
			class slot_2 {
				cargoLockIndices[] = {1,2,3,4,5,6,7,8,9,10,11,12};
				choices[] = {
					{"ncb_obj_ammobox_m",{0.02,-2.4,0.3},{{1,0,0},{0,0,1}}},
					{"ncb_obj_ammobox_l",{0.02,-2.4,0.3},{{0,1,0},{0,0,1}}},
					{"ncb_obj_fuel_supply_m",{0.02,-2.4,0.3},{{0,0,0},{0,0,1}}},
					{"ncb_obj_repair_parts_box_m",{0.02,-2.4,0.3},{{0,1,0},{0,0,1}}}
				};
			};
			class slot_3 {
				cargoLockIndices[] = {1,2,3,4,5,6,7,8,9,10,11,12};
				choices[] = {
					{"ncb_obj_ammobox_m",{0.02,-4,0.3},{{1,0,0},{0,0,1}}},
					{"ncb_obj_ammobox_l",{0.02,-4,0.3},{{0,1,0},{0,0,1}}},
					{"ncb_obj_fuel_supply_m",{0.02,-4,0.3},{{0,0,0},{0,0,1}}},
					{"ncb_obj_repair_parts_box_m",{0.02,-4,0.3},{{0,1,0},{0,0,1}}}
				};
			};
		};
		class Config_2 {
			class slot_1 {
				cargoLockIndices[] = {1,2,3,4,5,6,7,8,9,10,11,12};
				choices[] = {
					{"ncb_veh_quadbike",{0.07,-0.95,0.9},{{0,1,0},{0,0,1}}}
				};
			};
			class slot_2 {
				cargoLockIndices[] = {1,2,3,4,5,6,7,8,9,10,11,12};
				choices[] = {
					{"ncb_veh_quadbike",{0.07,-3.4,0.9},{{0,1,0},{0,0,1}}},
					{"ncb_obj_ammobox_m",{0.07,-3.4,0.9},{{1,0,0},{0,0,1}}},
					{"ncb_obj_ammobox_l",{0.07,-3.4,0.9},{{0,1,0},{0,0,1}}},
					{"ncb_obj_fuel_supply_m",{0.07,-3.4,0.9},{{0,0,0},{0,0,1}}},
					{"ncb_obj_repair_parts_box_m",{0.07,-3.4,0.9},{{0,1,0},{0,0,1}}}
				};
			};
		};
		class Config_3 {
			class slot_1 {
				cargoLockIndices[] = {1,2,3,4,5,6,7,8,9,10,11,12};
				choices[] = {
					{"ncb_boat_inflatable",{0.07,-2.54,1.09},{{0,1,0},{0,0,1}}}
				};
			};
		};
	};
};
class O_Truck_03_covered_F : Truck_03_base_F {
	class Turrets;
	class CargoTurret_01;
	class CargoTurret_02;
};
class ncb_veh_tempest_covered : O_Truck_03_covered_F {
	author = "Das Attorney";
	crew = "Horde_gunmanUnit";
	displayName = "Tempest";
	ejectDeadCargo = 0;
	ejectDeadDriver = 0;
	faction = "ncb_antagonists";
	initScript = "";
	//secondaryexplosion = 0;
	typicalCargo[] = {"Horde_gunmanUnit"};
	class EventHandlers {
		killed = "_this call (uinamespace getvariable 'BIS_fnc_effectKilled')";
		class nocebo {
			handledamage = "if (local (_this select 0)) then {_this call horde_fnc_vehicleDamaged}";
			dammaged = "if (local (_this select 0)) then {_this call horde_fnc_vehicleDamageAnims}";
			killed = "\
				if (local (_this select 0)) then {\
					_this remoteExecCall [\
						'horde_fnc_vehicleKilled',\
						2\
					]\
				};\
			";
		};
	};
	class VehicleInteractionInfo : VehicleInteractionInfo {
		class Chassis : Chassis {
			anim[] = {};
			modelposition[] = {1.32373,-1.82275,-0.989994};
			class actions : actions {
				class addParts : addParts {};
				class swapParts : swapParts {};
				class takeParts : takeParts {};
				class loadVehicle {
					baseTime = 0;
					failTextLocStatus = "You cannot load any more cargo into this vehicle";
					failTextHasPart = "";
					script = "spawn horde_fnc_loadVehicleCargo";
					text = "Load cargo";
					type = "call horde_fnc_setVehicleCargoDlg";
				};
				class unloadVehicle : loadVehicle {
					failTextLocStatus = "There is no cargo in this vehicle";
					script = "spawn horde_fnc_unloadVehicleCargo";
					text = "Unload cargo";
				};
			};
		};
		class Engine : Engine {
			modelposition[] = {0,3.57031,-0.610294};
		};
		class FuelTank: FuelTank {
			anim[] = {};
			modelposition[] = {-1.19604,-1.82813,-0.970676};
		};
		class Wheel_L1 : Wheel_L1 {
			modelposition[] = {-1.19128,1.86963,-1.63515};
		};
		class Wheel_L2 : Wheel_L2 {
			modelposition[] = {-1.19189,-0.164551,-1.64138};
			text = "Left middle wheel";
		};
		class Wheel_L3 : Wheel_L3 {
			modelposition[] = {-1.18933,-3.44238,-1.65887};
		};
		class Wheel_R1 : Wheel_R1 {
			modelposition[] = {1.32825,1.8833,-1.59393};
		};
		class Wheel_R2 : Wheel_R2 {
			modelposition[] = {1.32825,-0.164551,-1.63407};
			text = "Right middle wheel";
		};
		class Wheel_R3 : Wheel_R3 {
			modelposition[] = {1.32837,-3.42188,-1.64473};
		};
	};
	class TransportItems {};
	class TransportWeapons {};
	class TransportMagazines {};
	class TransportBackpacks {};
	class Turrets : Turrets {
		class CargoTurret_01 : CargoTurret_01 {
			ejectDeadGunner = 0;
		};
		class CargoTurret_02 : CargoTurret_02 {
			ejectDeadGunner = 0;
		};
	};
};
class O_Truck_03_transport_F : Truck_03_base_F {
	class Turrets;
	class CargoTurret_01;
	class CargoTurret_02;
};
class ncb_veh_tempest_open : O_Truck_03_transport_F {
	author = "Das Attorney";
	crew = "Horde_gunmanUnit";
	displayName = "Tempest";
	ejectDeadCargo = 0;
	ejectDeadDriver = 0;
	faction = "ncb_antagonists";
	initScript = "";
	//secondaryexplosion = 0;
	typicalCargo[] = {"Horde_gunmanUnit"};
	class EventHandlers {
		killed = "_this call (uinamespace getvariable 'BIS_fnc_effectKilled')";
		class nocebo {
			handledamage = "if (local (_this select 0)) then {_this call horde_fnc_vehicleDamaged}";
			dammaged = "if (local (_this select 0)) then {_this call horde_fnc_vehicleDamageAnims}";
			killed = "\
				if (local (_this select 0)) then {\
					_this remoteExecCall [\
						'horde_fnc_vehicleKilled',\
						2\
					]\
				};\
			";
		};
	};
	class VehicleInteractionInfo : VehicleInteractionInfo {
		class Chassis : Chassis {
			anim[] = {};
			modelposition[] = {1.32373,-1.82275,-0.989994};
			class actions : actions {
				class addParts : addParts {};
				class swapParts : swapParts {};
				class takeParts : takeParts {};
				class loadVehicle {
					baseTime = 0;
					failTextLocStatus = "You cannot load any more cargo into this vehicle";
					failTextHasPart = "";
					script = "spawn horde_fnc_loadVehicleCargo";
					text = "Load cargo";
					type = "call horde_fnc_setVehicleCargoDlg";
				};
				class unloadVehicle : loadVehicle {
					failTextLocStatus = "There is no cargo in this vehicle";
					script = "spawn horde_fnc_unloadVehicleCargo";
					text = "Unload cargo";
				};
			};
		};
		class Engine : Engine {
			modelposition[] = {0,3.57031,-0.610294};
		};
		class FuelTank: FuelTank {
			anim[] = {};
			modelposition[] = {-1.19604,-1.82813,-0.970676};
		};
		class Wheel_L1 : Wheel_L1 {
			modelposition[] = {-1.19128,1.86963,-1.63515};
		};
		class Wheel_L2 : Wheel_L2 {
			modelposition[] = {-1.19189,-0.164551,-1.64138};
			text = "Left middle wheel";
		};
		class Wheel_L3 : Wheel_L3 {
			modelposition[] = {-1.18933,-3.44238,-1.65887};
		};
		class Wheel_R1 : Wheel_R1 {
			modelposition[] = {1.32825,1.8833,-1.59393};
		};
		class Wheel_R2 : Wheel_R2 {
			modelposition[] = {1.32825,-0.164551,-1.63407};
			text = "Right middle wheel";
		};
		class Wheel_R3 : Wheel_R3 {
			modelposition[] = {1.32837,-3.42188,-1.64473};
		};
	};
	class TransportItems {};
	class TransportWeapons {};
	class TransportMagazines {};
	class TransportBackpacks {};
	class Turrets : Turrets {
		class CargoTurret_01 : CargoTurret_01 {
			ejectDeadGunner = 0;
		};
		class CargoTurret_02 : CargoTurret_02 {
			ejectDeadGunner = 0;
		};
	};
};
class O_Truck_03_device_F;
class ncb_veh_tempest_device : O_Truck_03_device_F {
	author = "Das Attorney";
	crew = "Horde_gunmanUnit";
	ejectDeadCargo = 0;
	faction = "ncb_antagonists";
	initScript = "";
	// secondaryexplosion = 0;
	typicalCargo[] = {"Horde_gunmanUnit"};
	class EventHandlers {
		killed = "_this call (uinamespace getvariable 'BIS_fnc_effectKilled')";
		class nocebo {
			handledamage = "if (local (_this select 0)) then {_this call horde_fnc_vehicleDamaged}";
			dammaged = "if (local (_this select 0)) then {_this call horde_fnc_vehicleDamageAnims}";
			killed = "\
				if (local (_this select 0)) then {\
					_this remoteExecCall [\
						'horde_fnc_vehicleKilled',\
						2\
					]\
				};\
			";
		};
	};
	class TransportItems {};
	class TransportWeapons {};
	class TransportMagazines {};
	class TransportBackpacks {};
};

// MARID

class Wheeled_APC_F : Car_F {
	horde_primWeapMinCalLevel = 4;
};
class APC_Wheeled_02_base_F;
class O_APC_Wheeled_02_base_F;
class O_APC_Wheeled_02_rcws_F : O_APC_Wheeled_02_base_F {
	class AnimationSources;
	class DestructionEffects;
	class Turrets;
	class MainTurret;
	class ViewOptics;
	class CommanderOptics;
};
class ncb_veh_marid : O_APC_Wheeled_02_rcws_F {
	author = "Das Attorney";
	ejectDeadCargo = 0;
	ejectDeadDriver = 0;
	crew = "Horde_gunmanUnit";
	faction = "ncb_antagonists";
	initScript = "";
	//secondaryexplosion = 0;
	typicalCargo[] = {"Horde_gunmanUnit"};
	class EventHandlers {
		fired = "_this call (uinamespace getvariable 'BIS_fnc_effectFired')";
		killed = "_this call (uinamespace getvariable 'BIS_fnc_effectKilled')";
		class nocebo {
			handledamage = "if (local (_this select 0)) then {_this call horde_fnc_vehicleDamaged}";
			dammaged = "if (local (_this select 0)) then {_this call horde_fnc_vehicleDamageAnims}";
			killed = "\
				if (local (_this select 0)) then {\
					_this remoteExecCall [\
						'horde_fnc_vehicleKilled',\
						2\
					]\
				};\
			";
		};
	};
	class Turrets : Turrets {
		class CommanderOptics : CommanderOptics {
			gunnerOpticsModel = "\A3\Weapons_F_Beta\Reticle\Optics_Commander_01_F.p3d";
			Laser = 1;
			turretInfoType = "RscOptics_Strider_commander";
			magazines[] = {"SmokeLauncherMag","Laserbatteries"};
			weapons[] = {"SmokeLauncher","Laserdesignator_mounted"};
		};
		class MainTurret : MainTurret {
			ejectDeadGunner = 0;
			magazines[] = {"ncb_mag_127x108_500","96Rnd_40mm_G_belt"};
			weapons[] = {"ncb_weap_127x108_hmg_apc_500","GMG_40mm"};
		};
	};
	class VehicleInteractionInfo : VehicleInteractionInfo {
		class Chassis : Chassis {
			location[] = {"HitBody","HitHull","HitTurret","HitGun"};
			modelposition[] = {1.7478,-4.06445,-0.707073};
		};
		class Engine : Engine {
			modelposition[] = {0,1.79688,-1.02967};
		};
		class FuelTank: FuelTank {
			modelposition[] = {-1.07593,-4.08398,-0.706953};
		};
		class Wheel_L1 : Wheel_L1 {
			modelposition[] = {-1.00708,0.184082,-1.84752};
		};
		class Wheel_L2 : Wheel_L2 {
			modelposition[] = {-1.00708,-1.37598,-1.86142};
			text = "Left middle wheel";
		};
		class Wheel_L3 : Wheel_L3 {
			modelposition[] = {-1.0072,-2.90576,-1.83812};
		};
		class Wheel_R1 : Wheel_R1 {
			modelposition[] = {1.71655,0.186523,-1.85166};
		};
		class Wheel_R2 : Wheel_R2 {
			modelposition[] = {1.71655,-1.37207,-1.85229};
			text = "Right middle wheel";
		};
		class Wheel_R3 : Wheel_R3 {
			modelposition[] = {1.71643,-2.89893,-1.8504};
		};
	};
	class TransportItems {};
	class TransportWeapons {};
	class TransportMagazines {};
	class TransportBackpacks {};
};
class ncb_veh_marid_unarmed : ncb_veh_marid {
	displayName = "Marid (Unarmed)";
	class EventHandlers {
		fired = "_this call (uinamespace getvariable 'BIS_fnc_effectFired')";
		killed = "_this call (uinamespace getvariable 'BIS_fnc_effectKilled')";
		class nocebo {
			init = "if (isServer) then {\
				(_this select 0) animate ['hideturret',1];\
			};";
			handledamage = "if (local (_this select 0)) then {_this call horde_fnc_vehicleDamaged}";
			dammaged = "if (local (_this select 0)) then {_this call horde_fnc_vehicleDamageAnims}";
			killed = "\
				if (local (_this select 0)) then {\
					_this remoteExecCall [\
						'horde_fnc_vehicleKilled',\
						2\
					]\
				};\
			";
		};
	};
	class Turrets: Turrets {
		class CommanderOptics : CommanderOptics {
			magazines[] = {"SmokeLauncherMag","Laserbatteries"};
			weapons[] = {"SmokeLauncher","Laserdesignator_mounted"};
		};
		delete MainTurret;
	};
	// class Turrets : Turrets {
	// 	class MainTurret: MainTurret {
	// 		magazines[] = {};
	// 		weapons[] = {};
	// 	};
	// };
};
class APC_Wheeled_02_base_v2_F;
class O_APC_Wheeled_02_rcws_v2_F : APC_Wheeled_02_base_v2_F {
	class Turrets;
	class CommanderOptics;
	class MainTurret;
};
class ncb_veh_marid_v2 : O_APC_Wheeled_02_rcws_v2_F {
	author = "Das Attorney";
	ejectDeadCargo = 0;
	ejectDeadDriver = 0;
	crew = "Horde_gunmanUnit";
	faction = "ncb_antagonists";
	initScript = "";
	typicalCargo[] = {"Horde_gunmanUnit"};
	class EventHandlers {
		fired = "_this call (uinamespace getvariable 'BIS_fnc_effectFired')";
		killed = "_this call (uinamespace getvariable 'BIS_fnc_effectKilled')";
		class nocebo {
			init = "if (local (_this#0)) then {\
				{\
					if (random 1 > 0.5) then {\
						_this#0 animate [_x,1]\
					}\
				} count [\
					'showBags',\
					'showCanisters',\
					'showTools',\
					'showCamonetHull',\
					'showSLATHull'\
				]\
			}";
			handledamage = "if (local (_this select 0)) then {_this call horde_fnc_vehicleDamaged}";
			dammaged = "if (local (_this select 0)) then {_this call horde_fnc_vehicleDamageAnims}";
			killed = "\
				if (local (_this select 0)) then {\
					_this remoteExecCall [\
						'horde_fnc_vehicleKilled',\
						2\
					]\
				};\
			";
		};
	};
	class Turrets : Turrets {
		class CommanderOptics : CommanderOptics {
			gunnerOpticsModel = "\A3\Weapons_F_Beta\Reticle\Optics_Commander_01_F.p3d";
			Laser = 1;
			turretInfoType = "RscOptics_Strider_commander";
			magazines[] = {"SmokeLauncherMag","Laserbatteries"};
			weapons[] = {"SmokeLauncher","Laserdesignator_mounted"};
		};
		class MainTurret : MainTurret {
			ejectDeadGunner = 0;
			magazines[] = {"ncb_mag_127x108_500","96Rnd_40mm_G_belt"};
			weapons[] = {"ncb_weap_127x108_hmg_apc_500","GMG_40mm"};
		};
	};
	class VehicleInteractionInfo : VehicleInteractionInfo {
		class Chassis : Chassis {
			location[] = {"HitBody","HitHull","HitTurret","HitGun"};
			modelposition[] = {1.7478,-4.06445,-0.707073};
		};
		class Engine : Engine {
			modelposition[] = {0,1.79688,-1.02967};
		};
		class FuelTank: FuelTank {
			modelposition[] = {-1.07593,-4.08398,-0.706953};
		};
		class Wheel_L1 : Wheel_L1 {
			modelposition[] = {-1.00708,0.184082,-1.84752};
		};
		class Wheel_L2 : Wheel_L2 {
			modelposition[] = {-1.00708,-1.37598,-1.86142};
			text = "Left middle wheel";
		};
		class Wheel_L3 : Wheel_L3 {
			modelposition[] = {-1.0072,-2.90576,-1.83812};
		};
		class Wheel_R1 : Wheel_R1 {
			modelposition[] = {1.71655,0.186523,-1.85166};
		};
		class Wheel_R2 : Wheel_R2 {
			modelposition[] = {1.71655,-1.37207,-1.85229};
			text = "Right middle wheel";
		};
		class Wheel_R3 : Wheel_R3 {
			modelposition[] = {1.71643,-2.89893,-1.8504};
		};
	};
	class TransportItems {};
	class TransportWeapons {};
	class TransportMagazines {};
	class TransportBackpacks {};
};
// GORGON

class I_APC_Wheeled_03_base_F;
class I_APC_Wheeled_03_cannon_F : I_APC_Wheeled_03_base_F {
	class Turrets;
	class MainTurret;
	class ViewOptics;
	class CommanderOptics;
};
class ncb_veh_gorgon : I_APC_Wheeled_03_cannon_F {
	author = "Das Attorney";
	crew = "Horde_gunmanUnit";
	ejectDeadCargo = 0;
	ejectDeadDriver = 0;
	faction = "ncb_antagonists";
	initScript = "";
	side = 0;
	//secondaryexplosion = 0;
	typicalCargo[] = {"Horde_gunmanUnit"};
	class EventHandlers {
		fired = "_this call (uinamespace getvariable 'BIS_fnc_effectFired')";
		killed = "_this call (uinamespace getvariable 'BIS_fnc_effectKilled')";
		class nocebo {
			handledamage = "if (local (_this select 0)) then {_this call horde_fnc_vehicleDamaged}";
			dammaged = "if (local (_this select 0)) then {_this call horde_fnc_vehicleDamageAnims}";
			killed = "\
				if (local (_this select 0)) then {\
					_this remoteExecCall [\
						'horde_fnc_vehicleKilled',\
						2\
					]\
				};\
			";
		};
	};
	class Turrets : Turrets {
		class MainTurret : MainTurret {
			magazines[] = {"140Rnd_30mm_MP_shells_Tracer_Yellow","60Rnd_30mm_APFSDS_shells_Tracer_Yellow","ncb_mag_762x54_1000_w","2Rnd_GAT_missiles"};
			weapons[] = {"autocannon_30mm_CTWS","ncb_weap_762x54_lmg_1000","missiles_titan"};
		};
	};
	class TransportItems {};
	class TransportWeapons {};
	class TransportMagazines {};
	class TransportBackpacks {};
};

// TRACKED APCs

class Tank;
class Tank_F : Tank {
	horde_primWeapMinCalLevel = 4;
};
class APC_Tracked_02_base_F;
class O_APC_Tracked_02_base_F;
class O_APC_Tracked_02_cannon_F : O_APC_Tracked_02_base_F {
	class Turrets;
	class MainTurret;
	class ViewOptics;
	class CommanderOptics;
	class OpticsIn;
	class Narrow;
	class Wide;
};
class ncb_veh_kamysh : O_APC_Tracked_02_cannon_F {
	author = "Das Attorney";
	crew = "Horde_gunmanUnit";
	ejectDeadCargo = 0;
	faction = "ncb_antagonists";
	//secondaryexplosion = 0;
	typicalCargo[] = {"Horde_gunmanUnit"};
	class EventHandlers {
		fired = "_this call (uinamespace getvariable 'BIS_fnc_effectFired')";
		killed = "_this call (uinamespace getvariable 'BIS_fnc_effectKilled')";
		class nocebo {
			handledamage = "if (local (_this select 0)) then {_this call horde_fnc_vehicleDamaged}";
			dammaged = "if (local (_this select 0)) then {_this call horde_fnc_vehicleDamageAnims}";
			killed = "\
				if (local (_this select 0)) then {\
					_this remoteExecCall [\
						'horde_fnc_vehicleKilled',\
						2\
					]\
				};\
			";
		};
	};
	class VehicleInteractionInfo : VehicleInteractionInfo {
		class Chassis : Chassis {
			location[] = {"HitBody","HitHull","HitTurret","HitGun"};
			modelposition[] = {0,2.37695,-1.26422};
			class actions : actions {
				class addParts : addParts {
					baseTime = 120;
				};
				class swapParts : swapParts {
					baseTime = 230;
				};
				class takeParts : takeParts {
					baseTime = 120;
				};
				class reload : reload {};
			};
		};
		class Engine : Engine {
			modelposition[] = {-1.75952,-4.21533,-0.669113};
		};
		class FuelTank: FuelTank {
			modelposition[] = {1.7406,-4.21533,-0.671776};
		};
		class Track_L : Track_L {
			modelposition[] = {-1.86963,-1.62549,-1.40592};
		};
		class Track_R : Track_R {
			modelposition[] = {1.91016,-1.62549,-1.4088};
		};
	};
	class Turrets : Turrets {
		class MainTurret : MainTurret {
			magazines[] = {"140Rnd_30mm_MP_shells_Tracer_Green","60Rnd_30mm_APFSDS_shells_Tracer_Green","ncb_mag_762x54_1000_w","2Rnd_GAT_missiles"};
			weapons[] = {"autocannon_30mm_CTWS","ncb_weap_762x54_lmg_1000","missiles_titan"};
			class Turrets : Turrets {
				class CommanderOptics : CommanderOptics {};
			};
		};
	};
	class TransportItems {};
	class TransportWeapons {};
	class TransportMagazines {};
	class TransportBackpacks {};
};
class O_APC_Tracked_02_AA_F : O_APC_Tracked_02_base_F {
	class Turrets;
	class MainTurret;
	class ViewOptics;
	class CommanderOptics;
	class OpticsIn;
	class Narrow;
	class Wide;
};
class ncb_veh_tigris : O_APC_Tracked_02_AA_F {
	author = "Das Attorney";
	crew = "Horde_gunmanUnit";
	ejectDeadCargo = 0;
	faction = "ncb_antagonists";
	//secondaryexplosion = 0;
	class EventHandlers {
		fired = "_this call (uinamespace getvariable 'BIS_fnc_effectFired')";
		killed = "_this call (uinamespace getvariable 'BIS_fnc_effectKilled')";
		class nocebo {
			handledamage = "if (local (_this select 0)) then {_this call horde_fnc_vehicleDamaged}";
			dammaged = "if (local (_this select 0)) then {_this call horde_fnc_vehicleDamageAnims}";
			killed = "\
				if (local (_this select 0)) then {\
					_this remoteExecCall [\
						'horde_fnc_vehicleKilled',\
						2\
					]\
				};\
			";
		};
	};
	class VehicleInteractionInfo : VehicleInteractionInfo {
		class Chassis : Chassis {
			location[] = {"HitBody","HitHull","HitTurret","HitGun"};
			modelposition[] = {0,2.37695,-1.26422};
			class actions : actions {
				class addParts : addParts {
					baseTime = 120;
				};
				class swapParts : swapParts {
					baseTime = 230;
				};
				class takeParts : takeParts {
					baseTime = 120;
				};
				class reload : reload {};
			};
		};
		class Engine : Engine {
			modelposition[] = {-1.75952,-4.21533,-0.669113};
		};
		class FuelTank: FuelTank {
			modelposition[] = {1.7406,-4.21533,-0.671776};
		};
		class Track_L : Track_L {
			modelposition[] = {-1.86963,-1.62549,-1.40592};
		};
		class Track_R : Track_R {
			modelposition[] = {1.91016,-1.62549,-1.4088};
		};
	};
	class TransportItems {};
	class TransportWeapons {};
	class TransportMagazines {};
	class TransportBackpacks {};
};

// MBTs

class MBT_02_base_F;
class MBT_02_arty_base_F;
class O_MBT_02_arty_base_F;
class O_MBT_02_arty_F : O_MBT_02_arty_base_F {
	class AnimationSources;
	class Turrets;
	class MainTurret;
	class OpticsIn;
	class Medium;
	class Narrow;
	class Wide;
	class CommanderOptics;
	class ViewOptics;
};
class ncb_veh_sochor : O_MBT_02_arty_F {
	author = "Das Attorney";
	crew = "Horde_gunmanUnit";
	ejectDeadCargo = 0;
	faction = "ncb_antagonists";
	class EventHandlers {
		fired = "_this call (uinamespace getvariable 'BIS_fnc_effectFired')";
		killed = "_this call (uinamespace getvariable 'BIS_fnc_effectKilled')";
		class nocebo {
			handledamage = "if (local (_this select 0)) then {_this call horde_fnc_vehicleDamaged}";
			dammaged = "if (local (_this select 0)) then {_this call horde_fnc_vehicleDamageAnims}";
			killed = "\
				if (local (_this select 0)) then {\
					_this remoteExecCall [\
						'horde_fnc_vehicleKilled',\
						2\
					]\
				};\
			";
		};
	};
	class AnimationSources : AnimationSources {
		class muzzle_rot_HMG {
            source = "ammorandom";
            weapon = "ncb_weap_127x108_hmg_apc_500";
        };
        class muzzle_hide_HMG {
            source = "reload";
            weapon = "ncb_weap_127x108_hmg_apc_500";
        };
	};
	class Turrets : Turrets {
		class MainTurret : MainTurret {
			magazines[] = {"32Rnd_155mm_Mo_shells","32Rnd_155mm_Mo_shells"};
			class Turrets : Turrets {
				class CommanderOptics : CommanderOptics {
					magazines[] = {"ncb_mag_127x108_500","96Rnd_40mm_G_belt","SmokeLauncherMag"};
					weapons[] = {"ncb_weap_127x108_hmg_apc_500","GMG_40mm","SmokeLauncher"};
				};
			};
		};
	};
	class TransportItems {};
	class TransportWeapons {};
	class TransportMagazines {};
	class TransportBackpacks {};
};

class O_MBT_02_base_F;
class O_MBT_02_cannon_F : O_MBT_02_base_F {
	class Turrets;
	class MainTurret;
	class OpticsIn;
	class Medium;
	class Narrow;
	class Wide;
	class CommanderOptics;
	class ViewOptics;
};
class ncb_veh_varsuk : O_MBT_02_cannon_F {
	author = "Das Attorney";
	crew = "Horde_gunmanUnit";
	ejectDeadCargo = 0;
	faction = "ncb_antagonists";
	class EventHandlers {
		fired = "_this call (uinamespace getvariable 'BIS_fnc_effectFired')";
		killed = "_this call (uinamespace getvariable 'BIS_fnc_effectKilled')";
		class nocebo {
			handledamage = "if (local (_this select 0)) then {_this call horde_fnc_vehicleDamaged}";
			dammaged = "if (local (_this select 0)) then {_this call horde_fnc_vehicleDamageAnims}";
			killed = "\
				if (local (_this select 0)) then {\
					_this remoteExecCall [\
						'horde_fnc_vehicleKilled',\
						2\
					]\
				};\
			";
		};
	};
	class VehicleInteractionInfo : VehicleInteractionInfo {
		class Chassis : Chassis {
			location[] = {"HitBody","HitHull","HitTurret","HitGun","HitComTurret","HitComGun"};
			modelposition[] = {0,1.87,-1.22};
			class actions : actions {
				class addParts : addParts {
					baseTime = 120;
				};
				class swapParts : swapParts {
					baseTime = 230;
				};
				class takeParts : takeParts {
					baseTime = 120;
				};
				class reload : reload {};
			};
		};
		class Engine : Engine {
			modelposition[] = {0,-4.9,-0.95};
		};
		class FuelTank: FuelTank {
			modelposition[] = {0.79,-4.73,-0.91};
		};
		class Track_L : Track_L {
			modelposition[] = {-1.72,-1.12,-1.21};
		};
		class Track_R : Track_R {
			modelposition[] = {1.76,-1.2,-1.21};
		};
	};
	class Turrets : Turrets {
		class MainTurret : MainTurret {
			magazines[] = {"24Rnd_125mm_APFSDS_T_Green","12Rnd_125mm_HE_T_Green","12Rnd_125mm_HEAT_T_Green","ncb_mag_762x54_2000_w","ncb_mag_762x54_2000_w"};
			weapons[] = {"cannon_125mm","ncb_weap_762x54_lmg_coax_2000"};
			class Turrets : Turrets {
				class CommanderOptics : CommanderOptics {};
			};
		};
	};
	class TransportItems {};
	class TransportWeapons {};
	class TransportMagazines {};
	class TransportBackpacks {};
};
