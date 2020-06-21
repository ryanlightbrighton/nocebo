class B_INDUSTRIAL {
	class Ammo {
		probability = 0.05;
		class Magazines : NCB_loot_Magazines {
			threshold = 0.35;
			loot[] = {
				"ncb_gv_lootMagsTier_0",
				"ncb_gv_lootMagsTier_1",
				"ncb_gv_lootMagsTier_2"
			};
		};
		class Grenades : NCB_loot_Grenades {
			threshold = 0.45;
		};
		class SmokeGrenades : NCB_loot_SmokeGrenades {
			threshold = 0.6;
		};
		class Flares : NCB_loot_Flares {
			threshold = 0.85;
		};
		class Chemlights : NCB_loot_Chemlights {
			threshold = 1;
		};
	};
	class Backpacks {
		probability = 0.1;
		class LoadBackpacks : NCB_loot_LoadBackpacks {
			threshold = 1;
			loot[] = {
				"ncb_gv_lootBackPacksTier_0",
				"ncb_gv_lootBackPacksTier_1"
			};
		};
	};
	class Consumables {
		probability = 0.15;
		class Food : NCB_loot_Food {
			threshold = 0.33;
		};
		class Drink: NCB_loot_Drink {
			threshold = 1;
		};
	};
	class Items {
		probability = 0.20;
		class Items : NCB_loot_Items {
			threshold = 1;
			loot[] = {
				"ncb_gv_lootBinosTier_0",
				"ncb_gv_lootMiscItems",
				"ncb_gv_lootTentItems",
				"ncb_gv_lootFuelItems"
			};
		};
	};
	class Medical {
		probability = 0.25;
		class Items : NCB_loot_Medical {
			threshold = 1;
		};
	};
	class Passes {
		probability = 0.30;
		class Items : NCB_loot_Passes {
			threshold = 1;
		};
	};
	class Tools {
		probability = 0.65;
		class Tools : NCB_loot_Tools {
			threshold = 1;
		};
	};
	class VehicleParts {
		probability = 0.9;
		class Parts : NCB_loot_PartsCar {
			threshold = 0.8;
		};
		class PartsAir : NCB_loot_PartsHelicopter {
			threshold = 1;
		};
	};
	class Weapons {
		probability = 0.95;
		class Launchers : NCB_loot_Launchers {
			threshold = 0.05;
			loot[] = {
				"ncb_gv_lootLaunchersTier_0"
			};
		};
		class Rifles : NCB_loot_Rifles {
			threshold = 0.4;
			loot[] = {
				"ncb_gv_lootRiflesTier_0",
				"ncb_gv_lootRiflesTier_1"
			};
		};
		class Pistols : NCB_loot_Pistols {
			threshold = 1;
			loot[] = {
				"ncb_gv_lootPistolsTier_0",
				"ncb_gv_lootPistolsTier_1"
			};
		};
	};
	class WeaponAttachments {
		probability = 1;
		class NCB_loot_Optics {
			threshold = 0.35;
			loot[] = {
				"ncb_gv_lootScopesTier_0",
				"ncb_gv_lootScopesTier_1"
			};
		};
		class NCB_loot_Barrels {
			threshold = 0.5;
			loot[] = {
				"ncb_gv_lootBarrelAttachments"
			};
		};
		class NCB_loot_Bipods {
			threshold = 0.75;
			loot[] = {
				"ncb_gv_lootUnderBarrelAttachments"
			};
		};
		class NCB_loot_PNQ {
			threshold = 1;
			loot[] = {
				"ncb_gv_lootSideAttachmentsTier_0"
			};
		};
	};
};