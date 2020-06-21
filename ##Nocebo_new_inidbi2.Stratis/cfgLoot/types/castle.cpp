class B_CASTLE {
	class Ammo {
		probability = 0.15;
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
		probability = 0.2;
		class LoadBackpacks : NCB_loot_LoadBackpacks {
			threshold = 1;
			loot[] = {
				"ncb_gv_lootBackPacksTier_0",
				"ncb_gv_lootBackPacksTier_1"
			};
		};
	};
	class Clothing {
		probability = 0.23;
		class Helmets : NCB_loot_Helmets {
			threshold = 0.2;
			loot[] = {
				"ncb_gv_lootHelmetsTier_0",
				"ncb_gv_lootHelmetsTier_1",
				"ncb_gv_lootHelmetsTier_2"
			};
		};
		class Vests : NCB_loot_Vests {
			threshold = 0.7;
			loot[] = {
				"ncb_gv_lootVestsTier_0",
				"ncb_gv_lootVestsTier_1",
				"ncb_gv_lootVestsTier_2"
			};
		};
		class Uniforms : NCB_loot_Uniforms {
			threshold = 1;
			loot[] = {
				"ncb_gv_lootUniformsTier_0"
			};
		};
	};
	class Consumables {
		probability = 0.45;
		class Food : NCB_loot_Food {
			threshold = 0.33;
		};
		class Drink: NCB_loot_Drink {
			threshold = 1;
		};
	};
	class Facewear {
		probability = 0.5;
		class Glasses : NCB_loot_Glasses {
			threshold = 1;
		};
	};
	class Items {
		probability = 0.55;
		class Items : NCB_loot_Items {
			threshold = 1;
			loot[] = {
				"ncb_gv_lootHeadOpticsTier_0",
				"ncb_gv_lootBinosTier_0",
				"ncb_gv_lootBinosTier_1",
				"ncb_gv_lootMiscItems",
				"ncb_gv_lootTentItems",
				"ncb_gv_lootFuelItems"
			};
		};
	};
	class Medical {
		probability = 0.65;
		class Items : NCB_loot_Medical {
			threshold = 1;
		};
	};
	class Passes {
		probability = 0.68;
		class Items : NCB_loot_Passes {
			threshold = 1;
		};
	};
	class Tools {
		probability = 0.75;
		class Tools : NCB_loot_Tools {
			threshold = 1;
		};
	};
	class VehicleAmmunition {
		probability = 0.78;
		class VehicleAmmunition : NCB_loot_VehicleAmmo {
			threshold = 1;
		};
	};
	class VehicleParts {
		probability = 0.85;
		class Tools : NCB_loot_Tools {
			threshold = 1;
		};
	};
	class Weapons {
		probability = 0.95;
		class Launchers : NCB_loot_Launchers {
			threshold = 0.2;
			loot[] = {
				"ncb_gv_lootLaunchersTier_0"
			};
		};
		class Rifles : NCB_loot_Rifles {
			threshold = 0.8;
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