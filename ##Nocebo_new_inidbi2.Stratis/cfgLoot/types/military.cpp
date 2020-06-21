class B_MILITARY {
	class Ammo {
		probability = 0.15;
		class Magazines : NCB_loot_Magazines {
			threshold = 0.5;
		};
		class Grenades : NCB_loot_Grenades {
			threshold = 0.7;
		};
		class SmokeGrenades : NCB_loot_SmokeGrenades {
			threshold = 0.8;
		};
		class Flares : NCB_loot_Flares {
			threshold = 0.9;
		};
		class Chemlights : NCB_loot_Chemlights {
			threshold = 1;
		};
	};
	class Backpacks {
		probability = 0.23;
		class TacBackpacks : NCB_loot_TacticalBackpacks {
			threshold = 0.2;
		};
		class LoadBackpacks : NCB_loot_LoadBackpacks {
			threshold = 1;
		};
	};
	class Clothing {
		probability = 0.3;
		class Helmets : NCB_loot_Helmets {
			threshold = 0.2;
		};
		class Vests : NCB_loot_Vests {
			threshold = 0.7;
		};
		class Uniforms : NCB_loot_Uniforms {
			threshold = 1;
		};
	};
	class Items {
		probability = 0.4;
		class Items : NCB_loot_Items {
			threshold = 1;
			loot[] = {
				"ncb_gv_lootMiscItems",
				"ncb_gv_lootTentItems",
				"ncb_gv_lootFuelItems",
				{"ItemTent"},
				{"ItemTent"},
				"ncb_gv_lootHeadOpticsTier_0",
				"ncb_gv_lootHeadOpticsTier_1",
				"ncb_gv_lootBinosTier_0",
				"ncb_gv_lootBinosTier_1",
				"ncb_gv_lootBinosTier_2"
			};
		};
	};
	class Medical {
		probability = 0.5;
		class Items : NCB_loot_Medical {
			threshold = 1;
			loot[] = {
				"ncb_gv_lootMedicalItemsTier_0"
			};
		};
	};
	class VehicleAmmunition {
		probability = 0.63;
		class VehicleAmmunition : NCB_loot_VehicleAmmo {
			threshold = 1;
		};
	};
	class Weapons {
		probability = 0.85;
		class Launchers : NCB_loot_Launchers {
			threshold = 0.3;
		};
		class Rifles : NCB_loot_Rifles {
			threshold = 0.95;
		};
		class Pistols : NCB_loot_Pistols {
			threshold = 1;
		};
	};
	class WeaponAttachments {
		probability = 1;
		class Optics : NCB_loot_Optics {
			threshold = 0.35;
		};
		class Barrels : NCB_loot_Barrels {
			threshold = 0.5;
		};
		class Bipods : NCB_loot_Bipods {
			threshold = 0.75;
		};
		class Side : NCB_loot_PNQ {
			threshold = 1;
		};
	};
};