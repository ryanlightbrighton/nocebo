class DefaultEventHandlers;
// class RCWSOptics;
class CfgVehicles {
	class All {
		horde_actionSound = ""; // used in actions/inventory
		horde_ambientEmitter = 0;
		horde_objectType = "NONE";
		horde_objectLootSpots = -1;
		horde_particles[] = {};
		horde_primWeapMinCalLevel = 1;  // (1) = any gun (2) = 7.62 belt + (3) = 127 x 108mm (4) = unobtainable
		horde_sound[] = {}; // used by emitters
	};

	class Building;
	class Church_F;
	class Church_Small_F;
	class House_F;
	class House_Small_F;
	class HeliH;
	class Thing : All {};
	class Furniture_base_F;
	class thingX;
	class Wreck_base;
	class Static;
	class Wall;
	class Strategic;
	class ReammoBox : Strategic {
		class InteractionInfo : InteractionInfo {
			class openInventory : openInventory {};
		};
	};
	class ReammoBox_F : thingX {
		class InteractionInfo : InteractionInfo {
			class openInventory : openInventory {};
		};
	};
	class Box_east_Ammo_F;
	class WeaponHolder;
	class Ruins;
	class Sound;

	// the order is specific (dependent on config declarations)

	#include "vehicles\logic.hpp"
	#include "vehicles\land.hpp"
	#include "vehicles\static.hpp"
	#include "vehicles\units.hpp"
	#include "vehicles\air.hpp"
	#include "vehicles\sea.hpp"
	#include "vehicles\houses.hpp"
	#include "vehicles\containers.hpp"
	#include "vehicles\animals.hpp"

	/*class Land_spp_Transformer_F : House_Small_F {
		sound = "Oil_pump"; // add sound by default to object - needs to be animated apparently
	};*/

	// FUEL SOURCES
	class Land_MetalBarrel_F : Items_base_F {
		class InteractionInfo : InteractionInfo {
			class fillJerryCan : fillJerryCan {};
		};
	};

	class Land_fs_feed_F : House_Small_F {
		transportFuel = 0;
		class InteractionInfo : InteractionInfo {
			class fillJerryCan : fillJerryCan {};
		};
	};

	class Land_FuelStation_Feed_F : House_Small_F {
		transportFuel = 0;
		class InteractionInfo : InteractionInfo {
			class fillJerryCan : fillJerryCan {};
		};
	};
	class Land_Tank_rust_F : House_Small_F {
		class InteractionInfo : InteractionInfo {
			class fillJerryCan : fillJerryCan {};
		};
	};

	// WATER SOURCES

	class Land_Water_source_F : NonStrategic {
		class InteractionInfo : InteractionInfo {
			class FillEmptyCanteens : FillEmptyCanteens {};
			class DrinkFromSource : DrinkFromSource {};
		};
	};
	class Stall_Base_F;
	class Land_StallWater_F : Stall_base_F {
		class InteractionInfo : InteractionInfo {
			class FillEmptyCanteens : FillEmptyCanteens {};
			class DrinkFromSource : DrinkFromSource {};
		};
	};
	class Land_BarrelWater_F : Items_base_F {
		class InteractionInfo : InteractionInfo {
			class FillEmptyCanteens : FillEmptyCanteens {};
			class DrinkFromSource : DrinkFromSource {};
		};
	};
	class Land_WaterBarrel_F : Items_base_F {
		class InteractionInfo : InteractionInfo {
			class FillEmptyCanteens : FillEmptyCanteens {};
			class DrinkFromSource : DrinkFromSource {};
		};
	};
	class Land_WaterTank_F : Items_base_F {
		class InteractionInfo : InteractionInfo {
			class FillEmptyCanteens : FillEmptyCanteens {};
			class DrinkFromSource : DrinkFromSource {};
		};
	};

	// WALLS

	class Wall_F;
	class Land_BarGate_F : Wall_F {
		class InteractionInfo : InteractionInfo {
			class openGate : openGate {};
			class closeGate : closeGate {};
		};
	};

	// CAMPING

	class Land_FirePlace_F : House_F {
		class Effects : SmallFire {
            class Light1 {
                simulation = "light";
                type = "ncb_fireLight";
            };
            class sound {
                simulation = "sound";
                type = "Fire_camp_small";
            };
            class Smoke1 {
                simulation = "particles";
                type = "SmallFireS";
            };
            class Fire1 : Smoke1 {
                simulation = "particles";
                type = "SmallFireFPlace";
            };
            class Refract1 {
                simulation = "particles";
                type = "SmallFireFRefract";
            };
        };
	};
	class ncb_obj_smallFireEmbers : Land_FirePlace_F {
		class EventHandlers {
			init = "if (isServer) then {\
				_fire = _this select 0;\
				_fire setVariable ['deadDeleteTime',round time + 1200];\
				ncb_gv_garbageContents pushBack _fire\
			}";
		};
		class InteractionInfo : InteractionInfo {
			class lightFire : lightFire {};
			class hideFire : hideFire {};
		};
	};

	class FirePlace_burning_F;
	class ncb_obj_smallFire : FirePlace_burning_F {
		transportmaxbackpacks = 4;
		transportmaxmagazines = 64;
		transportmaxweapons = 12;
		class EventHandlers {
			init = "if (isServer) then {\
					_fire = _this select 0;\
					_fire setVariable ['deadDeleteTime',round time + 1200];\
					ncb_gv_garbageContents pushBack _fire;\
				};\
				(_this select 0) inflame true;\
			";
		};
		class InteractionInfo : InteractionInfo {
			class extinguishFire : extinguishFire {};
			class hideFire : hideFire {};
			class openInventory : openInventory {};
		};
	};

	class Land_Campfire_F : House_F {
		class Effects : SmallFire {
            class Light1 {
                simulation = "light";
                type = "ncb_fireLight";
            };
            class sound {
                simulation = "sound";
                type = "Fire_camp";
            };
            class Smoke1 {
                simulation = "particles";
                type = "SmallFireS";
            };
            class Fire1 : Smoke1 {
                simulation = "particles";
                type = "ncb_small_fire";
            };
            class Refract1 {
                simulation = "particles";
                type = "SmallFireFRefract";
            };
        };
	};
	class ncb_obj_campFireEmbers : Land_Campfire_F {
		class EventHandlers {
			init = "if (isServer) then {\
					_fire = _this select 0;\
					_fire setVariable ['deadDeleteTime',round time + 1200];\
					ncb_gv_garbageContents pushBack _fire\
				};\
			";
		};
		class InteractionInfo : InteractionInfo {
			class hideFire : hideFire {};
			class lightFire : lightFire {
				output[] = {"ncb_obj_campFire"};
			};
		};
	};
	class Campfire_burning_F;
	class ncb_obj_campFire : Campfire_burning_F {
		transportmaxbackpacks = 4;
		transportmaxmagazines = 64;
		transportmaxweapons = 12;
		class EventHandlers {
			init = "if (isServer) then {\
					_fire = _this select 0;\
					_fire allowDamage false;\
					_fire setVariable ['deadDeleteTime',round time + 1200];\
					ncb_gv_garbageContents pushBack _fire;\
				};\
				(_this select 0) inflame true;\
			";
		};
		class InteractionInfo : InteractionInfo {
			class extinguishFire : extinguishFire {
				output[] = {"ncb_obj_campFireEmbers"};
			};
			class hideFire : hideFire {};
			class openInventory : openInventory {};
		};
	};


	// WRECKS

	class Wreck_base_F;

	class Land_Wreck_BMP2_F : Wreck_base_F {};
	class ncb_obj_wreck_bmp : Land_Wreck_BMP2_F {
		transportmaxbackpacks = 4;
		transportmaxmagazines = 64;
		transportmaxweapons = 12;
		class InteractionInfo : InteractionInfo {
			class openInventory : openInventory {};
			class Salvage : Salvage {
				output[] = {
					"ItemChassis_",
					"ItemEngine_",
					"ItemFuelTank_"
				};
				tools[] = {
					"ItemGrinder",
					"ItemWrench",
					"ItemHammer"
				};
			};
		};
	};
	class Land_Wreck_BRDM2_F : Wreck_base_F {};
	class ncb_obj_wreck_brdm : Land_Wreck_BRDM2_F {
		transportmaxbackpacks = 4;
		transportmaxmagazines = 64;
		transportmaxweapons = 12;
		class InteractionInfo : InteractionInfo {
			class openInventory : openInventory {};
			class Salvage : Salvage {
				output[] = {
					"ItemChassis_",
					"ItemEngine_",
					"ItemFuelTank_"
				};
				tools[] = {
					"ItemGrinder",
					"ItemWrench",
					"ItemHammer"
				};
			};
		};
	};
	class Land_Wreck_Car_F : Wreck_base_F {};
	class ncb_obj_wreck_car : Land_Wreck_Car_F {
		transportmaxbackpacks = 4;
		transportmaxmagazines = 64;
		transportmaxweapons = 12;
		class InteractionInfo : InteractionInfo {
			class openInventory : openInventory {};
			class Salvage : Salvage {
				output[] = {
					"ItemChassis_",
					"ItemEngine_",
					"ItemFuelTank_",
					"ItemTyre_"
				};
				tools[] = {
					"ItemGrinder",
					"ItemWrench",
					"ItemHammer"
				};
			};
		};
	};
	class Land_Wreck_Car2_F : Wreck_base_F {};
	class ncb_obj_wreck_car2 : Land_Wreck_Car2_F {
		transportmaxbackpacks = 4;
		transportmaxmagazines = 64;
		transportmaxweapons = 12;
		class InteractionInfo : InteractionInfo {
			class openInventory : openInventory {};
			class Salvage : Salvage {
				output[] = {
					"ItemChassis_",
					"ItemEngine_",
					"ItemFuelTank_",
					"ItemTyre_"
				};
				tools[] = {
					"ItemGrinder",
					"ItemWrench",
					"ItemHammer"
				};
			};
		};
	};
	class Land_Wreck_Car3_F : Wreck_base_F {};
	class ncb_obj_wreck_car3 : Land_Wreck_Car3_F {
		transportmaxbackpacks = 4;
		transportmaxmagazines = 64;
		transportmaxweapons = 12;
		class InteractionInfo : InteractionInfo {
			class openInventory : openInventory {};
			class Salvage : Salvage {
				output[] = {
					"ItemChassis_",
					"ItemEngine_",
					"ItemFuelTank_",
					"ItemTyre_"
				};
				tools[] = {
					"ItemGrinder",
					"ItemWrench",
					"ItemHammer"
				};
			};
		};
	};
	class Land_Wreck_CarDismantled_F : Wreck_base_F {};
	class ncb_obj_wreck_car_dismantled : Land_Wreck_CarDismantled_F {
		transportmaxbackpacks = 4;
		transportmaxmagazines = 64;
		transportmaxweapons = 12;
		class InteractionInfo : InteractionInfo {
			class openInventory : openInventory {};
			class Salvage : Salvage {
				output[] = {
					"ItemChassis_",
					"ItemEngine_",
					"ItemFuelTank_"
				};
				tools[] = {
					"ItemGrinder",
					"ItemWrench",
					"ItemHammer"
				};
			};
		};
	};
	class Land_Wreck_Heli_Attack_01_F : Wreck_base_F {};
	class ncb_obj_wreck_blackfoot : Land_Wreck_Heli_Attack_01_F {
		transportmaxbackpacks = 4;
		transportmaxmagazines = 64;
		transportmaxweapons = 12;
		class EventHandlers {}; // removed sparking from wreck (clogging up scheduler)
		class InteractionInfo : InteractionInfo {
			class openInventory : openInventory {};
			class Salvage : Salvage {
				output[] = {
					"ItemChassis_",
					"ItemEngine_",
					"ItemFuelTank_"
				};
				tools[] = {
					"ItemGrinder",
					"ItemWrench",
					"ItemHammer"
				};
			};
		};
	};
	class Land_Wreck_Heli_Attack_02_F : Wreck_base_F {};
	class ncb_obj_wreck_kajman : Land_Wreck_Heli_Attack_02_F {
		transportmaxbackpacks = 4;
		transportmaxmagazines = 64;
		transportmaxweapons = 12;
		class InteractionInfo : InteractionInfo {
			class openInventory : openInventory {};
			class Salvage : Salvage {
				output[] = {
					"ItemChassis_",
					"ItemEngine_",
					"ItemFuelTank_"
				};
				tools[] = {
					"ItemGrinder",
					"ItemWrench",
					"ItemHammer"
				};
			};
		};
	};
	class Land_Wreck_HMMWV_F : Wreck_base_F {};
	class ncb_obj_wreck_hmmwv : Land_Wreck_HMMWV_F {
		transportmaxbackpacks = 4;
		transportmaxmagazines = 64;
		transportmaxweapons = 12;
		class InteractionInfo : InteractionInfo {
			class openInventory : openInventory {};
			class Salvage : Salvage {
				output[] = {
					"ItemChassis_",
					"ItemEngine_",
					"ItemFuelTank_",
					"ItemTyre_",
					"ItemTyre_",
					"ItemTyre_"
				};
				tools[] = {
					"ItemGrinder",
					"ItemWrench",
					"ItemHammer"
				};
			};
		};
	};
	class Land_Wreck_Hunter_F : Wreck_base_F {};
	class ncb_obj_wreck_hunter : Land_Wreck_Hunter_F {
		transportmaxbackpacks = 4;
		transportmaxmagazines = 64;
		transportmaxweapons = 12;
		class InteractionInfo : InteractionInfo {
			class openInventory : openInventory {};
			class Salvage : Salvage {
				output[] = {
					"ItemChassis_",
					"ItemEngine_",
					"ItemFuelTank_",
					"ItemTyre_",
					"ItemTyre_",
					"ItemTyre_"
				};
				tools[] = {
					"ItemGrinder",
					"ItemWrench",
					"ItemHammer"
				};
			};
		};
	};
	class Land_Wreck_Offroad_F : Wreck_base_F {};
	class ncb_obj_wreck_offroad : Land_Wreck_Offroad_F {
		transportmaxbackpacks = 4;
		transportmaxmagazines = 64;
		transportmaxweapons = 12;
		class InteractionInfo : InteractionInfo {
			class openInventory : openInventory {};
			class Salvage : Salvage {
				output[] = {
					"ItemChassis_",
					"ItemEngine_",
					"ItemFuelTank_",
					"ItemTyre_",
					"ItemTyre_",
					"ItemTyre_"
				};
				tools[] = {
					"ItemGrinder",
					"ItemWrench",
					"ItemHammer"
				};
			};
		};
	};
	class Land_Wreck_Offroad2_F : Wreck_base_F {};
	class ncb_obj_wreck_offroad2 : Land_Wreck_Offroad2_F {
		transportmaxbackpacks = 4;
		transportmaxmagazines = 64;
		transportmaxweapons = 12;
		class InteractionInfo : InteractionInfo {
			class openInventory : openInventory {};
			class Salvage : Salvage {
				output[] = {
					"ItemChassis_",
					"ItemEngine_",
					"ItemFuelTank_",
					"ItemTyre_",
					"ItemTyre_",
					"ItemTyre_"
				};
				tools[] = {
					"ItemGrinder",
					"ItemWrench",
					"ItemPliers",
					"ItemDrill",
					"ItemScrewdriverPhillips",
					"ItemScrewdriverSlotted",
					"ItemHammer"
				};
			};
		};
	};
	class Land_Wreck_Plane_Transport_01_F : Wreck_base_F {};
	class ncb_obj_wreck_samson : Land_Wreck_Plane_Transport_01_F {
		transportmaxbackpacks = 4;
		transportmaxmagazines = 64;
		transportmaxweapons = 12;
		class InteractionInfo : InteractionInfo {
			class openInventory : openInventory {};
			class Salvage : Salvage {
				output[] = {
					"ItemChassis_",
					"ItemEngine_",
					"ItemEngine_",
					"ItemFuelTank_"
				};
				tools[] = {
					"ItemGrinder",
					"ItemWrench",
					"ItemPliers",
					"ItemDrill",
					"ItemScrewdriverPhillips",
					"ItemScrewdriverSlotted",
					"ItemHammer"
				};
			};
		};
	};
	class Land_Wreck_Skodovka_F : Wreck_base_F {};
	class ncb_obj_wreck_skodovka : Land_Wreck_Skodovka_F {
		transportmaxbackpacks = 4;
		transportmaxmagazines = 64;
		transportmaxweapons = 12;
		class InteractionInfo : InteractionInfo {
			class openInventory : openInventory {};
			class Salvage : Salvage {
				output[] = {
					"ItemChassis_",
					"ItemEngine_",
					"ItemFuelTank_",
					"ItemTyre_",
					"ItemTyre_"
				};
				tools[] = {
					"ItemGrinder",
					"ItemWrench",
					"ItemHammer"
				};
			};
		};
	};
	class Land_Wreck_Slammer_F : Wreck_base_F {};
	class ncb_obj_wreck_slammer : Land_Wreck_Slammer_F {
		transportmaxbackpacks = 4;
		transportmaxmagazines = 64;
		transportmaxweapons = 12;
		class InteractionInfo : InteractionInfo {
			class openInventory : openInventory {};
			class Salvage : Salvage {
				output[] = {
					"ItemChassis_",
					"ItemChassis_",
					"ItemEngine_",
					"ItemFuelTank_"
				};
				tools[] = {
					"ItemGrinder",
					"ItemWrench",
					"ItemHammer"
				};
			};
		};
	};
	class Land_Wreck_Slammer_hull_F : Wreck_base_F {};
	class ncb_obj_wreck_slammer_hull : Land_Wreck_Slammer_hull_F {
		transportmaxbackpacks = 4;
		transportmaxmagazines = 64;
		transportmaxweapons = 12;
		class InteractionInfo : InteractionInfo {
			class openInventory : openInventory {};
			class Salvage : Salvage {
				output[] = {
					"ItemChassis_",
					"ItemEngine_",
					"ItemFuelTank_"
				};
				tools[] = {
					"ItemGrinder",
					"ItemWrench",
					"ItemHammer"
				};
			};
		};
	};
	class Land_Wreck_Slammer_turret_F : Wreck_base_F {};
	class ncb_obj_wreck_slammer_turret : Land_Wreck_Slammer_turret_F {
		transportmaxbackpacks = 4;
		transportmaxmagazines = 64;
		transportmaxweapons = 12;
		class InteractionInfo : InteractionInfo {
			class openInventory : openInventory {};
			class Salvage : Salvage {
				output[] = {
					"ItemChassis_"
				};
				tools[] = {
					"ItemGrinder",
					"ItemWrench",
					"ItemHammer"
				};
			};
		};
	};
	class Land_Wreck_T72_hull_F : Wreck_base_F {};
	class ncb_obj_wreck_t72_hull : Land_Wreck_T72_hull_F {
		transportmaxbackpacks = 4;
		transportmaxmagazines = 64;
		transportmaxweapons = 12;
		class InteractionInfo : InteractionInfo {
			class openInventory : openInventory {};
			class Salvage : Salvage {
				output[] = {
					"ItemChassis_",
					"ItemChassis_",
					"ItemEngine_",
					"ItemFuelTank_"
				};
				tools[] = {
					"ItemGrinder",
					"ItemWrench",
					"ItemHammer"
				};
			};
		};
	};
	class Land_Wreck_T72_turret_F : Wreck_base_F {};
	class ncb_obj_wreck_t72_turret : Land_Wreck_T72_turret_F {
		transportmaxbackpacks = 4;
		transportmaxmagazines = 64;
		transportmaxweapons = 12;
		class InteractionInfo : InteractionInfo {
			class openInventory : openInventory {};
			class Salvage : Salvage {
				output[] = {
					"ItemChassis_"
				};
				tools[] = {
					"ItemGrinder",
					"ItemWrench",
					"ItemHammer"
				};
			};
		};
	};
	class Land_Wreck_Truck_dropside_F : Wreck_base_F {};
	class ncb_obj_wreck_truck_dropside : Land_Wreck_Truck_dropside_F {
		transportmaxbackpacks = 4;
		transportmaxmagazines = 64;
		transportmaxweapons = 12;
		class InteractionInfo : InteractionInfo {
			class openInventory : openInventory {};
			class Salvage : Salvage {
				output[] = {
					"ItemChassis_",
					"ItemEngine_",
					"ItemFuelTank_"
				};
				tools[] = {
					"ItemGrinder",
					"ItemWrench",
					"ItemHammer"
				};
			};
		};
	};
	class Land_Wreck_Truck_F : Wreck_base_F {};
	class ncb_obj_wreck_truck : Land_Wreck_Truck_F {
		transportmaxbackpacks = 4;
		transportmaxmagazines = 64;
		transportmaxweapons = 12;
		class InteractionInfo : InteractionInfo {
			class openInventory : openInventory {};
			class Salvage : Salvage {
				output[] = {
					"ItemChassis_",
					"ItemEngine_",
					"ItemFuelTank_"
				};
				tools[] = {
					"ItemGrinder",
					"ItemWrench",
					"ItemHammer"
				};
			};
		};
	};
	class Land_Wreck_UAZ_F : Wreck_base_F {};
	class ncb_obj_wreck_uaz : Land_Wreck_UAZ_F {
		transportmaxbackpacks = 4;
		transportmaxmagazines = 64;
		transportmaxweapons = 12;
		class InteractionInfo : InteractionInfo {
			class openInventory : openInventory {};
			class Salvage : Salvage {
				output[] = {
					"ItemChassis_",
					"ItemEngine_",
					"ItemFuelTank_"
				};
				tools[] = {
					"ItemGrinder",
					"ItemWrench",
					"ItemHammer"
				};
			};
		};
	};
	class Land_Wreck_Ural_F : Wreck_base_F {};
	class ncb_obj_wreck_ural : Land_Wreck_Ural_F {
		transportmaxbackpacks = 4;
		transportmaxmagazines = 64;
		transportmaxweapons = 12;
		class InteractionInfo : InteractionInfo {
			class openInventory : openInventory {};
			class Salvage : Salvage {
				output[] = {
					"ItemChassis_",
					"ItemEngine_",
					"ItemFuelTank_",
					"ItemTyre_",
					"ItemTyre_",
					"ItemTyre_",
					"ItemTyre_",
					"ItemTyre_"
				};
				tools[] = {
					"ItemGrinder",
					"ItemWrench",
					"ItemHammer"
				};
			};
		};
	};
	class Land_Wreck_Van_F : Wreck_base_F {};
	class ncb_obj_wreck_van : Land_Wreck_Van_F {
		transportmaxbackpacks = 4;
		transportmaxmagazines = 64;
		transportmaxweapons = 12;
		class InteractionInfo : InteractionInfo {
			class openInventory : openInventory {};
			class Salvage : Salvage {
				output[] = {
					"ItemChassis_",
					"ItemEngine_",
					"ItemFuelTank_",
					"ItemTyre_",
					"ItemTyre_"
				};
				tools[] = {
					"ItemGrinder",
					"ItemWrench",
					"ItemHammer"
				};
			};
		};
	};

	// FENCES

	class Land_Mil_WiredFence_F : Wall_F {
		class InteractionInfo : InteractionInfo {
			class cutFence : cutFence {};
		};
	};
	class Land_Mil_WiredFence_Gate_F : Wall_F {
		class InteractionInfo : InteractionInfo {
			class cutFence : cutFence {};
		};
	};
	class Land_Mil_WiredFenceD_F : Wall_F {
		class InteractionInfo : InteractionInfo {
			class cutFence : cutFence {};
		};
	};
	class Land_Net_Fence_4m_F : Wall_F {
		class InteractionInfo : InteractionInfo {
			class cutFence : cutFence {};
		};
	};
	class Land_Net_Fence_8m_F : Wall_F {
		class InteractionInfo : InteractionInfo {
			class cutFence : cutFence {};
		};
	};
	class Land_Net_Fence_Gate_F : Wall_F {
		class InteractionInfo : InteractionInfo {
			class cutFence : cutFence {};
		};
	};
	class Land_Net_Fence_pole_F : Wall_F {
		class InteractionInfo : InteractionInfo {
			class cutFence : cutFence {};
		};
	};
	class Land_Net_FenceD_8m_F : Wall_F {
		class InteractionInfo : InteractionInfo {
			class cutFence : cutFence {};
		};
	};
	class Land_New_WiredFence_5m_F : Wall_F {
		class InteractionInfo : InteractionInfo {
			class cutFence : cutFence {};
		};
	};
	class Land_New_WiredFence_10m_Dam_F : Wall_F {
		class InteractionInfo : InteractionInfo {
			class cutFence : cutFence {};
		};
	};
	class Land_New_WiredFence_10m_F : Wall_F {
		class InteractionInfo : InteractionInfo {
			class cutFence : cutFence {};
		};
	};
	class Land_New_WiredFence_pole_F : Wall_F {
		class InteractionInfo : InteractionInfo {
			class cutFence : cutFence {};
		};
	};
	class Land_Pipe_fence_4m_F : Wall_F {
		class InteractionInfo : InteractionInfo {
			class cutFence : cutFence {};
		};
	};
	class Land_Pipe_fence_4mNoLC_F : Wall_F {
		class InteractionInfo : InteractionInfo {
			class cutFence : cutFence {};
		};
	};
	class Land_SportGround_fence_F : Wall_F {
		class InteractionInfo : InteractionInfo {
			class cutFence : cutFence {};
		};
	};
	class Land_Wired_Fence_4m_F : Wall_F {
		class InteractionInfo : InteractionInfo {
			class cutFence : cutFence {};
		};
	};
	class Land_Wired_Fence_4mD_F : Wall_F {
		class InteractionInfo : InteractionInfo {
			class cutFence : cutFence {};
		};
	};
	class Land_Wired_Fence_8m_F : Wall_F {
		class InteractionInfo : InteractionInfo {
			class cutFence : cutFence {};
		};
	};
	class Land_Wired_Fence_8mD_F : Wall_F {
		class InteractionInfo : InteractionInfo {
			class cutFence : cutFence {};
		};
	};

	class Land_NetFence_01_m_4m_F : Wall_F {
		class InteractionInfo : InteractionInfo {
			class cutFence : cutFence {};
		};
    };
    class Land_NetFence_01_m_4m_noLC_F : Wall_F {
		class InteractionInfo : InteractionInfo {
			class cutFence : cutFence {};
		};
    };
    class Land_NetFence_01_m_8m_F : Wall_F {
		class InteractionInfo : InteractionInfo {
			class cutFence : cutFence {};
		};
    };
    class Land_NetFence_01_m_8m_noLC_F : Wall_F {
		class InteractionInfo : InteractionInfo {
			class cutFence : cutFence {};
		};
    };
    class Land_NetFence_01_m_d_F : Wall_F {
		class InteractionInfo : InteractionInfo {
			class cutFence : cutFence {};
		};
    };
    class Land_NetFence_01_m_d_noLC_F : Wall_F {
		class InteractionInfo : InteractionInfo {
			class cutFence : cutFence {};
		};
    };
    class Land_NetFence_01_m_gate_F : Wall_F {
		class InteractionInfo : InteractionInfo {
			class cutFence : cutFence {};
		};
    };
    class Land_NetFence_01_m_pole_F : Wall_F {
		class InteractionInfo : InteractionInfo {
			class cutFence : cutFence {};
		};
    };
    class Land_NetFence_02_m_2m_F : Wall_F {
		class InteractionInfo : InteractionInfo {
			class cutFence : cutFence {};
		};
    };
    class Land_NetFence_02_m_4m_F : Wall_F {
		class InteractionInfo : InteractionInfo {
			class cutFence : cutFence {};
		};
    };
    class Land_NetFence_02_m_8m_F : Wall_F {
		class InteractionInfo : InteractionInfo {
			class cutFence : cutFence {};
		};
    };
    class Land_NetFence_02_m_d_F : Wall_F {
		class InteractionInfo : InteractionInfo {
			class cutFence : cutFence {};
		};
    };
    class Land_NetFence_02_m_gate_v1_F : Wall_F {
		class InteractionInfo : InteractionInfo {
			class cutFence : cutFence {};
		};
    };
    class Land_NetFence_02_m_gate_v2_F : Wall_F {
		class InteractionInfo : InteractionInfo {
			class cutFence : cutFence {};
		};
    };
    class Land_NetFence_02_m_pole_F : Wall_F {
		class InteractionInfo : InteractionInfo {
			class cutFence : cutFence {};
		};
    };

     class Land_WiredFence_01_4m_F : Wall_F {
        class InteractionInfo : InteractionInfo {
			class cutFence : cutFence {};
		};
    };
    class Land_WiredFence_01_8m_d_F : Wall_F {
        class InteractionInfo : InteractionInfo {
			class cutFence : cutFence {};
		};
    };
    class Land_WiredFence_01_8m_F : Wall_F {
        class InteractionInfo : InteractionInfo {
			class cutFence : cutFence {};
		};
    };
    class Land_WiredFence_01_16m_F : Wall_F {
        class InteractionInfo : InteractionInfo {
			class cutFence : cutFence {};
		};
    };
    class Land_WiredFence_01_gate_F : Wall_F {
        class InteractionInfo : InteractionInfo {
			class cutFence : cutFence {};
		};
    };
    class Land_WiredFence_01_pole_45_F : Wall_F {
        class InteractionInfo : InteractionInfo {
			class cutFence : cutFence {};
		};
    };
    class Land_WiredFence_01_pole_F : Wall_F {
        class InteractionInfo : InteractionInfo {
			class cutFence : cutFence {};
		};
    };

	// POSTER

	class Poster_base_F;
	class Land_Poster_04_F : Poster_base_F {
		// class EventHandlers {
		// 	init = "";
		// };
		delete EventHandlers;
	};

	// GARBAGE

	class Garbage_base_F : House_Small_F {
		horde_ambientEmitter = 1;
		horde_particles[] = {"Horde_Flies"};
		horde_sound[] = {{"horde_sound_flies",13}};
	};
	class Land_GarbageContainer_closed_F : thingX {
		horde_ambientEmitter = 1;
		horde_particles[] = {"Horde_Flies"};
		horde_sound[] = {{"horde_sound_flies",13}};
	};
	class Land_GarbageContainer_open_F : thingX {
		horde_ambientEmitter = 1;
		horde_particles[] = {"Horde_Flies"};
		horde_sound[] = {{"horde_sound_flies",13}};
	};

	// FURNITURE

	class Land_FMradio_F : Items_base_F {
		horde_ambientEmitter = 1;
		horde_sound[] = {{"horde_sound_radioPianoMusic",23}};
	};
	class Land_PortableLongRangeRadio_F : Items_base_F {
		horde_ambientEmitter = 1;
		horde_sound[] = {{"horde_sound_radioPianoMusic",23}};
	};
	class Land_SurvivalRadio_F : Items_base_F {
		horde_ambientEmitter = 1;
		horde_sound[] = {{"horde_sound_radioPianoMusic",23}};
	};
	/*class Land_MobilePhone_smart_F : Items_base_F {
		horde_ambientEmitter = 1;
		horde_sound[] = {{"horde_sound_phoneVibrate",2}};
	};
	class Land_MobilePhone_old_F : Items_base_F {
		horde_ambientEmitter = 1;
		horde_sound[] = {{"horde_sound_phoneVibrate",2}};
	};
	class Land_Laptop_unfolded_F : Items_base_F {
		horde_ambientEmitter = 1;
		horde_sound[] = {{"horde_sound_laptopFan",22}};
	};*/

	// MEDKIT (DUMMY ITEM TO BE SPAWNED WHEN HEALING)

	class Horde_Item_Medkit : Items_base_F {
		displayname = "Medikit";
		model = "\A3\Weapons_F\Items\Medikit";
		scope = 2;
	};

	// invisible item (attach static weaps to this)

	/*class Horde_Invisible_Item : Items_base_F {
		displayname = "Static invisible item";
		model = "\A3\Weapons_f\empty";
		scope = 2;
		vehicleclass = "Horde Objects";
	};*/


	// INVISIBLE TARGET

	// try and inherit helper class and make it west

	class TargetBase;
	class Horde_InvisibleTargetBase : TargetBase {
		accuracy = 0.01;
		armor = 10000;
		audible = 10;
		camouflage = 10;
		cost = "1e+006"; // "1e+008";
		//damageResistance = 0.001;
		destrtype = 0;
		icon = "\A3\Misc_F\Helpers\data\ui\icons\Sign_Sphere25cm_F";
		mapsize = 0.2;
		model = "\FLAY\FLAY_FireGeom\horde_invisible_target.p3d";
		nameSound = "veh_infantry_s";
		threat[] = {1,1,1};
		type = 0; // 0=soft 1=veh 2=air
		vehicleclass = "Training";
		// artillerytarget = 1;
		// irtarget = 1;
		// lasertarget = 1;
		// magazines[] = {"FakeWeapon"};
		// weapons[] = {"FakeWeapon"};
		class EventHandlers {};
	};
	class Horde_InvisibleTargetHeavyVehicle : Horde_InvisibleTargetBase {
		// armor = 900;
		displayname = "Heavy Vehicles target this";
		scope = 2;
		side = 1;
		type = 2;
		// threat[] = {0,0,0}; // {1,1,1};
	};
	class Horde_InvisibleTargetVehicle : Horde_InvisibleTargetBase {
		// armor = 100;
		displayname = "Vehicles target this";
		scope = 2;
		side = 1;
		type = 1;
		// threat[] = {0,0,0}; // {1,1,1};
	};
	class Horde_InvisibleTargetMan : Horde_InvisibleTargetBase {
		// armor = 2;
		// cost = 8;
		displayname = "Men target this";
		scope = 2;
		side = 1;
		type = 0;
		// threat[] = {0,0,0}; // {1,1,1};
	};
	class TargetSoldierBase;
	class Horde_InvisibleTargetMan2 : TargetSoldierBase {
        class SimpleObject {
            animate[] = {};
            hide[] = {"zasleh"};
            verticalOffset = 0;
        };
        accuracy = 0.01;
		armor = 10000;
		audible = 10;
		camouflage = 10;
		cost = "1e+006"; // "1e+008";
		type = 0;
        scope = 1;
        scopeCurator = 0;
        crew = "B_UAV_AI";
        typicalCargo[] = {"B_UAV_AI"};
        side = 5;
        faction = "BLU_F";
    };

	// rope

	// class Rope : All {
	// 	class InteractionInfo : InteractionInfo {
	// 		class ropePickUp : ropePickUp {};
	// 	};
	// };

	// SOUNDS (USES CLASS SFX FOR THE SOUNDS)

	class Sound_Hum : Sound {
		displayname = "Hum";
		scope = 2;
		sound = "horde_sound_transformer_hum";
	};
	class Sound_Plant : Sound {
		displayname = "Plant";
		scope = 2;
		sound = "horde_sound_transformer_plant";
	};
	class Sound_Fan : Sound {
		displayname = "Fan";
		scope = 2;
		sound = "horde_sound_fan";
	};
	class Sound_Flies : Sound {
		displayname = "Flies";
		scope = 2;
		sound = "horde_sound_flies";
	};
	class Sound_Generator : Sound {
		displayname = "Portable Generator";
		scope = 2;
		sound = "horde_sound_generator";
	};

	class FlagCarrier;
	class ncb_flag_antagonist : FlagCarrier {
        author = "Das Attorney";
        class SimpleObject {
            eden = 0;
            animate[] = {{"flag"}};
            hide[] = {};
            verticalOffset = 3.975;
            verticalOffsetWorld = 0;
        };
        editorPreview = "\A3\EditorPreviews_F\Data\CfgVehicles\Flag_CSAT_F.jpg";
        scope = 2;
        scopeCurator = 2;
        displayName = "Flag (CSAT)";
        hiddenSelectionsTextures[] = {"\A3\Structures_F\Mil\Flags\Data\Mast_mil_CO.paa"};
        hiddenSelectionsMaterials[] = {"\A3\Structures_F\Mil\Flags\Data\Mast_mil.rvmat"};
        class InteractionInfo : InteractionInfo {
			class raiseJollyRoger : raiseJollyRoger {};
		};
        class EventHandlers {
            init = "if (local (_this select 0)) then {(_this select 0) setFlagTexture '\A3\Data_F\Flags\Flag_CSAT_CO.paa'}";
        };
    };

	// ARMA 2 IMPORTS

	// class Horde_A2Import_Fridge_F : Furniture_base_F {
	// 	_generalmacro = "Horde_A2Import_Fridge_F";
	// 	author = "Das Attorney";
	// 	displayname = "Fridge";
	// 	icon = "iconObject_1x4";
	// 	mapsize = 2.05;
	// 	model = "\Fridge\fridge.p3d";
	// 	scope = 2;
	// };
	// class Horde_A2Import_VendingMachine_F : Furniture_base_F {
	// 	_generalmacro = "Horde_A2Import_VendingMachine_F";
	// 	author = "Das Attorney";
	// 	displayname = "Vending Machine";
	// 	icon = "iconObject_1x4";
	// 	mapsize = 2.05;
	// 	model = "\vending_machine\vending_machine.p3d";
	// 	scope = 2;
	// };
	// class Horde_A2Import_KitchenLight_F : Furniture_base_F {
	// 	_generalmacro = "Horde_A2Import_KitchenLight_F";
	// 	author = "Das Attorney";
	// 	displayname = "Kitchen Light";
	// 	icon = "iconObject_1x4";
	// 	mapsize = 2.05;
	// 	model = "\light_kitchen_03\light_kitchen_03.p3d";
	// 	scope = 2;
	// };
};
