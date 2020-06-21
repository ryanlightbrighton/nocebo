//Max range of fire and hit proba at the max
#define horde_sniperRifleMaxRange 1500
#define horde_sniperRifleMaxRangeChance 0.005

#define horde_DMRMaxRange 1000
#define horde_DMRMaxRangeChance 0.0015

#define horde_assaultRifleMaxRange 800
#define horde_assaultRifleMaxRangeChance 0.001

#define horde_carbineMaxRange 600
#define horde_carbineMaxRangeChance 0.0005

#define horde_LMGMaxRange 900
#define horde_LMGMaxRangeChance 0.001

#define horde_pitch 1.5
#define horde_vol 2.51189

class Mode_SemiAuto;

class CfgWeapons {
	class Default;
	class PistolCore;
	class Pistol : PistolCore {
		horde_inventorySound = "horde_sound_gunInventory";
		class ItemActions {
			class Holster {
				text = "Holster pistol";
				script = "spawn horde_fnc_weaponSlotSelected";
			};
		};
	};
	class hgun_P07_F;
	class hgun_P18_F : hgun_P07_F {
		changeFiremodeSound[] = {"A3\sounds_f\weapons\closure\firemode_changer_1",0.251189,1,5};
		descriptionshort = "Auto Handgun<br />Caliber: 9x21 mm";
		displayName = "P18-A 9 mm";
		modes[] = {"Single","Burst","FullAuto"};
		class Library {
		libtextdesc = "The P18-A is a select-fire pistol with an iron and reinforced polymer mix frame. Following the success of Glock, polymer based pistols became known as perfect handguns for both military use and self-defense and are available in various calibers. P18-A allows easy mounting of suppressors.";
		};
		class Single {
			artilleryCharge = 1;
			artilleryDispersion = 1;
			autoFire = 0;
			burst = 1;
			displayName = "Semi";
			multiplier = 1;
			showToPlayer = 1;
			soundBurst = 0;
			soundContinuous = 0;
			sounds[] = {"StandardSound", "SilencedSound"};
			textureType = "semi";
			useAction = 0;
			useActionTitle = "";
			class BaseSoundModeType {
				weaponSoundEffect = "DefaultRifle";
				closure1[] = {"A3\sounds_f\weapons\closure\closure_handgun_6", 0.223872, 1, 10};
				closure2[] = {"A3\sounds_f\weapons\closure\closure_handgun_6", 0.223872, 1.1, 10};
				soundClosure[] = {"closure1", 0.5, "closure2", 0.5};
			};
			class StandardSound : BaseSoundModeType {
				begin1[] = {"A3\sounds_f\weapons\pistols\pistol_st_1", 0.794328, 1, 1200};
				begin2[] = {"A3\sounds_f\weapons\pistols\pistol_st_2", 0.794328, 1, 1200};
				begin3[] = {"A3\sounds_f\weapons\pistols\pistol_st_3", 0.794328, 1, 1200};
				soundBegin[] = {"begin1", 0.33, "begin2", 0.33, "begin3", 0.34};
			};
			class SilencedSound : BaseSoundModeType {
				begin1[] = {"A3\Sounds_F\weapons\Pistols\silencer_pistol_st_1", 0.562341, 1, 400};
				begin2[] = {"A3\Sounds_F\weapons\Pistols\silencer_pistol_st_2", 0.562341, 1, 400};
				soundBegin[] = {"begin1", 0.5, "begin2", 0.5};
			};
			reloadTime = 0.05;
			dispersion = 0.003;
			recoil = "recoil_single_ktb";
			recoilProne = "recoil_single_prone_ktb";
			minRange = 2;
			minRangeProbab = 0.3;
			midRange = 100;
			midRangeProbab = 0.7;
			maxRange = 150;
			maxRangeProbab = 0.05;
			aiRateOfFire = 2;
			aiRateOfFireDistance = 300;
		};
		class Burst : Single {
			burst = 3;
			displayName = "Burst";
			textureType = "burst";
			soundBurst = 0;
			reloadTime = 0.05;
			dispersion = 0.01;
			recoil = "recoil_burst_smg_01";
			recoilProne = "recoil_burst_prone_smg_01";
			minRange = 2;
			minRangeProbab = 0.3;
			midRange = 50;
			midRangeProbab = 0.7;
			maxRange = 100;
			maxRangeProbab = 0.05;
			aiRateOfFire = 1;
			aiRateOfFireDistance = 250;
			class BaseSoundModeType {
				weaponSoundEffect = "DefaultRifle";
				closure1[] = {"A3\sounds_f\weapons\closure\closure_handgun_6", 0.223872, 1, 10};
				closure2[] = {"A3\sounds_f\weapons\closure\closure_handgun_6", 0.223872, 1.1, 10};
				soundClosure[] = {"closure1", 0.5, "closure2", 0.5};
			};
			class StandardSound : BaseSoundModeType {
				begin1[] = {"A3\sounds_f\weapons\pistols\pistol_st_1", 0.794328, 1, 1200};
				begin2[] = {"A3\sounds_f\weapons\pistols\pistol_st_2", 0.794328, 1, 1200};
				begin3[] = {"A3\sounds_f\weapons\pistols\pistol_st_3", 0.794328, 1, 1200};
				soundBegin[] = {"begin1", 0.33, "begin2", 0.33, "begin3", 0.34};
			};
			class SilencedSound : BaseSoundModeType {
				begin1[] = {"A3\Sounds_F\weapons\Pistols\silencer_pistol_st_1", 0.562341, 1, 400};
				begin2[] = {"A3\Sounds_F\weapons\Pistols\silencer_pistol_st_2", 0.562341, 1, 400};
				soundBegin[] = {"begin1", 0.5, "begin2", 0.5};
			};
		};
		class FullAuto : Single {
			autoFire = 1;
			displayName = "Full";
			reloadTime = 0.05;
			dispersion = 0.01;
			recoil = "recoil_auto_smg_01";
			recoilProne = "recoil_auto_prone_smg_01";
			minRange = 0;
			minRangeProbab = 0.9;
			midRange = 15;
			midRangeProbab = 0.7;
			maxRange = 30;
			maxRangeProbab = 0.1;
			aiRateOfFire = 1e-006;
			aiRateOfFireDistance = 50;
			textureType = "fullAuto";
			class BaseSoundModeType {
				weaponSoundEffect = "DefaultRifle";
				closure1[] = {"A3\sounds_f\weapons\closure\closure_handgun_6", 0.223872, 1, 10};
				closure2[] = {"A3\sounds_f\weapons\closure\closure_handgun_6", 0.223872, 1.1, 10};
				soundClosure[] = {"closure1", 0.5, "closure2", 0.5};
			};
			class StandardSound : BaseSoundModeType {
				begin1[] = {"A3\sounds_f\weapons\pistols\pistol_st_1", 0.794328, 1, 1200};
				begin2[] = {"A3\sounds_f\weapons\pistols\pistol_st_2", 0.794328, 1, 1200};
				begin3[] = {"A3\sounds_f\weapons\pistols\pistol_st_3", 0.794328, 1, 1200};
				soundBegin[] = {"begin1", 0.33, "begin2", 0.33, "begin3", 0.34};
			};
			class SilencedSound : BaseSoundModeType {
				begin1[] = {"A3\Sounds_F\weapons\Pistols\silencer_pistol_st_1", 0.562341, 1, 400};
				begin2[] = {"A3\Sounds_F\weapons\Pistols\silencer_pistol_st_2", 0.562341, 1, 400};
				soundBegin[] = {"begin1", 0.5, "begin2", 0.5};
			};
		};
	};
	class RifleCore;
	class Rifle : RifleCore {
		horde_inventorySound = "horde_sound_gunInventory";
		class ItemActions {
			class Holster {
				text = "Sling rifle";
				script = "spawn horde_fnc_weaponSlotSelected";
			};
		};
	};
	class Rifle_Base_F : Rifle {
		maxrange = horde_assaultRifleMaxRange;
		maxrangeprobab = horde_assaultRifleMaxRangeChance;
		class WeaponSlotsInfo;
	};

	class Rifle_Long_Base_F : Rifle_Base_F {
		maxrange = horde_DMRMaxRange;
		maxrangeprobab = horde_DMRMaxRangeChance;
		class WeaponSlotsInfo : WeaponSlotsInfo {
			class MuzzleSlot;
			class PointerSlot;
		};
	};


	//EBR
	class EBR_base_F : Rifle_Long_Base_F {
		maxrange = horde_DMRMaxRange;
		maxrangeprobab = horde_DMRMaxRangeChance;
		class Single;
	};

	class srifle_EBR_F : EBR_base_F {
		maxrange = horde_DMRMaxRange;
		maxrangeprobab = horde_DMRMaxRangeChance;
		class Single : Single {
			maxrange = horde_DMRMaxRange;
			maxrangeprobab = horde_DMRMaxRangeChance;
		};
	};

	// RAHIM

	class DMR_01_base_F : Rifle_Long_Base_F {
		class Single;
	}
	class srifle_DMR_01_F : DMR_01_base_F {
		maxrange = horde_DMRMaxRange;
		maxrangeprobab = horde_DMRMaxRangeChance;
		class Single : Single {
			maxrange = horde_DMRMaxRange;
			maxrangeprobab = horde_DMRMaxRangeChance;
		};
	};

	//GM6
	class GM6_base_F : Rifle_Long_Base_F {
		maxrange = horde_sniperRifleMaxRange;
		maxrangeprobab = horde_sniperRifleMaxRangeChance;
		class Single;
	};
	class srifle_GM6_F : GM6_base_F {
		maxrange = horde_sniperRifleMaxRange;
		maxrangeprobab = horde_sniperRifleMaxRangeChance;
		class Single : Single {
			maxrange = horde_sniperRifleMaxRange;
			maxrangeprobab = horde_sniperRifleMaxRangeChance;
		};
	};

	//LRR
	class LRR_base_F : Rifle_Long_Base_F {
		maxrange = horde_sniperRifleMaxRange;
		maxrangeprobab = horde_sniperRifleMaxRangeChance;
		class Single;
	};
	class srifle_LRR_F : LRR_base_F {
		maxrange = horde_sniperRifleMaxRange;
		maxrangeprobab = horde_sniperRifleMaxRangeChance;
		class Single : Single {
			maxrange = horde_sniperRifleMaxRange;
			maxrangeprobab = horde_sniperRifleMaxRangeChance;
		};
	};

	//MK200
	class LMG_Mk200_F : Rifle_Long_Base_F {
		maxrange = horde_LMGMaxRange;
		maxrangeprobab = horde_LMGMaxRangeChance;
		class close;
		class manual;
		class medium: close {
			maxrange = horde_LMGMaxRange;
			maxrangeprobab = horde_LMGMaxRangeChance;
		};
		class WeaponSlotsInfo : WeaponSlotsInfo {
			class MuzzleSlot : MuzzleSlot {};
		};
	};

	//Zafir
	class LMG_Zafir_F : Rifle_Long_Base_F {
		maxrange = horde_LMGMaxRange;
		maxrangeprobab = horde_LMGMaxRangeChance;
		class close;
		class medium: close {
			maxrange = horde_LMGMaxRange;
			maxrangeprobab = horde_LMGMaxRangeChance;
		};
	};

	//KATIBA
	class arifle_Katiba_Base_F : Rifle_Base_F {
		// magazines[] = {
		// 	"30Rnd_65x39_caseless_green",
		// 	"ncb_katiba_group"
		// };
		maxrange = horde_assaultRifleMaxRange;
		maxrangeprobab = horde_assaultRifleMaxRangeChance;
		class Single;
	};
	class arifle_Katiba_F : arifle_Katiba_Base_F {
		maxrange = horde_assaultRifleMaxRange;
		maxrangeprobab = horde_assaultRifleMaxRangeChance;
		class Single : Single {
			maxrange = horde_assaultRifleMaxRange;
			maxrangeprobab = horde_assaultRifleMaxRangeChance;
		};
	};
	class arifle_Katiba_C_F : arifle_Katiba_Base_F {
		maxrange = horde_assaultRifleMaxRange;
		maxrangeprobab = horde_assaultRifleMaxRangeChance;
		class Single : Single {
			maxrange = horde_assaultRifleMaxRange;
			maxrangeprobab = horde_assaultRifleMaxRangeChance;
		};
	};
	class arifle_Katiba_GL_F : arifle_Katiba_Base_F {
		maxrange = horde_assaultRifleMaxRange;
		maxrangeprobab = horde_assaultRifleMaxRangeChance;
		class Single : Single {
			maxrange = horde_assaultRifleMaxRange;
			maxrangeprobab = horde_assaultRifleMaxRangeChance;
		};
	};

	//MX

	class arifle_MX_Base_F : Rifle_Base_F {
		maxrange = horde_assaultRifleMaxRange;
		maxrangeprobab = horde_assaultRifleMaxRangeChance;
		class single;
	};

	class arifle_MXC_F : arifle_MX_Base_F {
		maxrange = horde_assaultRifleMaxRange;
		maxrangeprobab = horde_assaultRifleMaxRangeChance;
		class Single : Single {
			maxrange = horde_assaultRifleMaxRange;
			maxrangeprobab = horde_assaultRifleMaxRangeChance;
		};
	};
	class arifle_MX_F : arifle_MX_Base_F {
		maxrange = horde_assaultRifleMaxRange;
		maxrangeprobab = horde_assaultRifleMaxRangeChance;
		class Single : Single {
			maxrange = horde_assaultRifleMaxRange;
			maxrangeprobab = horde_assaultRifleMaxRangeChance;
		};
	};
	class arifle_MX_GL_F : arifle_MX_Base_F {
		maxrange = horde_assaultRifleMaxRange;
		maxrangeprobab = horde_assaultRifleMaxRangeChance;
		class Single : Single {
			maxrange = horde_assaultRifleMaxRange;
			maxrangeprobab = horde_assaultRifleMaxRangeChance;
		};
	};

	class arifle_MX_SW_F : arifle_MX_Base_F {
		maxrange = horde_LMGMaxRange;
		maxrangeprobab = horde_LMGMaxRangeChance;
		// class single : single {
		class single : Mode_SemiAuto {
			maxrange = horde_LMGMaxRange;
			maxrangeprobab = horde_LMGMaxRangeChance;
		};
	};

	class arifle_MXM_F : arifle_MX_Base_F {
		// for some reason it redefines it's mags
		maxrange = horde_DMRMaxRange;
		maxrangeprobab = horde_DMRMaxRangeChance;
		// initspeed = 830;
		class Single : Single {
			maxrange = horde_DMRMaxRange;
			maxrangeprobab = horde_DMRMaxRangeChance;
		};
	};


	//SDAR
	class SDAR_base_F : Rifle_Base_F {
		maxrange = horde_carbineMaxRange;
		maxrangeprobab = horde_carbineMaxRangeChance;
		class Single;
	};
	class arifle_SDAR_F : SDAR_base_F {
		discretedistanceinitindex = 1;
		maxrange = horde_carbineMaxRange;
		maxrangeprobab = horde_carbineMaxRangeChance;
		class Single : Single {
			maxrange = horde_carbineMaxRange;
			maxrangeprobab = horde_carbineMaxRangeChance;
		};
	};

	//Tavor
	class Tavor_base_F : Rifle_Base_F {
		maxrange = horde_assaultRifleMaxRange;
		maxrangeprobab = horde_assaultRifleMaxRangeChance;
		class Single;
	};
	class arifle_TRG21_F : Tavor_base_F {
		maxrange = horde_assaultRifleMaxRange;
		maxrangeprobab = horde_assaultRifleMaxRangeChance;
		class Single : Single {
			maxrange = horde_assaultRifleMaxRange;
			maxrangeprobab = horde_assaultRifleMaxRangeChance;
		};
	};
	class arifle_TRG20_F : Tavor_base_F {
		maxrange = horde_assaultRifleMaxRange;
		maxrangeprobab = horde_assaultRifleMaxRangeChance;
		class Single : Single {
			maxrange = horde_assaultRifleMaxRange;
			maxrangeprobab = horde_assaultRifleMaxRangeChance;
		};
	};

	//MK20
	class mk20_base_F : Rifle_Base_F {
		maxrange = horde_assaultRifleMaxRange;
		maxrangeprobab = horde_assaultRifleMaxRangeChance;
		class Single;
	};
	class arifle_Mk20_F : mk20_base_F {
		maxrange = horde_assaultRifleMaxRange;
		maxrangeprobab = horde_assaultRifleMaxRangeChance;
		class Single : Single {
			maxrange = horde_assaultRifleMaxRange;
			maxrangeprobab = horde_assaultRifleMaxRangeChance;
		};
	};
	class arifle_Mk20C_F : mk20_base_F {
		maxrange = horde_assaultRifleMaxRange;
		maxrangeprobab = horde_assaultRifleMaxRangeChance;
		class Single : Single {
			maxrange = horde_assaultRifleMaxRange;
			maxrangeprobab = horde_assaultRifleMaxRangeChance;
		};
	};
	class arifle_Mk20_GL_F : mk20_base_F {
		maxrange = horde_assaultRifleMaxRange;
		maxrangeprobab = horde_assaultRifleMaxRangeChance;
		class Single : Single {
			maxrange = horde_assaultRifleMaxRange;
			maxrangeprobab = horde_assaultRifleMaxRangeChance;
		};
	};

	class Rifle_Short_Base_F : Rifle_Base_F {
		maxrange = horde_carbineMaxRange;
		maxrangeprobab = horde_carbineMaxRangeChance;
		class Single;
	};

	//SMG1
	class SMG_01_Base : Rifle_Short_Base_F {
		maxrange = horde_carbineMaxRange;
		maxrangeprobab = horde_carbineMaxRangeChance;
		class Single;
	};
	class SMG_01_F : SMG_01_Base {
		maxrange = horde_carbineMaxRange;
		maxrangeprobab = horde_carbineMaxRangeChance;
		class Single : Single {
			maxrange = horde_carbineMaxRange;
			maxrangeprobab = horde_carbineMaxRangeChance;
		};
	};

	//SMG2
	class SMG_02_base_F : Rifle_Short_Base_F {
		maxrange = horde_carbineMaxRange;
		maxrangeprobab = horde_carbineMaxRangeChance;
		class Single;
	};
	class SMG_02_F : SMG_02_base_F {
		maxrange = horde_carbineMaxRange;
		maxrangeprobab = horde_carbineMaxRangeChance;
		class Single : Single {
			maxrange = horde_carbineMaxRange;
			maxrangeprobab = horde_carbineMaxRangeChance;
		};
	};

	//PDW2000
	class pdw2000_base_F : Rifle_Short_Base_F {
		maxrange = horde_carbineMaxRange;
		maxrangeprobab = horde_carbineMaxRangeChance;
		class Single;
	};
	class hgun_PDW2000_F : pdw2000_base_F {
		maxrange = horde_carbineMaxRange;
		maxrangeprobab = horde_carbineMaxRangeChance;
		class Single : Single {
			maxrange = horde_carbineMaxRange;
			maxrangeprobab = horde_carbineMaxRangeChance;
		};
	};
	class Launcher;
	class Launcher_Base_F : Launcher {
		horde_inventorySound = "horde_sound_gunInventory";
		class ItemActions {
			class Holster {
				text = "Sling launcher";
				script = "spawn horde_fnc_weaponSlotSelected";
			};
		};
	};
	class launch_NLAW_F : Launcher_Base_F {};
	class launch_RPG32_F : Launcher_Base_F {
		magazines[] = {"RPG32_F", "RPG32_HE_F","RPG32_F_topAttack"};
		class OpticsModes {
			class optic;
		};
		class EventHandlers {
			class nocebo {
				fired = "if (local (_this select 0)) then {_this call horde_fnc_launcherFired}";
			};
		};
	};
	class launch_RPG32_NoNVG : launch_RPG32_F {
		author = "Das Attorney";
		displayName = "RPG-42 Alamut (no NV)";
		class OpticsModes : OpticsModes {
			class optic : optic {
				visionmode[] = {"Normal"};
			};
		};
	};
	class launch_RPG7_F : Launcher_Base_F {
		magazines[] = {"RPG7_F","RPG7_F_topAttack"};
		class EventHandlers {
			class nocebo {
				fired = "if (local (_this select 0)) then {_this call horde_fnc_launcherFired}";
			};
		};
	};
	class launch_Titan_base : Launcher_Base_F {};

	// set display names

	// NOTE: AA

	class launch_B_Titan_F : launch_Titan_base {
		displayName = "Titan AA Launcher (TAN)";
	};
	class launch_I_Titan_F : launch_Titan_base {
		displayName = "Titan AA Launcher (GRN)";
	};
	class launch_O_Titan_F : launch_Titan_base {
		displayName = "Titan AA Launcher (BRN)";
	};
	class launch_Titan_F : launch_Titan_base {
		displayName = "Titan AA Launcher (???)";
	};

	// class launch_O_Titan_ghex_F : launch_O_Titan_F {
	// 	displayName = "Test name";
	// };

	// NOTE: AT

	class launch_Titan_short_base;
	class launch_B_Titan_short_F : launch_Titan_short_base {
		displayName = "Titan AT/AP Launcher (TAN)";
	};
	class launch_I_Titan_short_F : launch_Titan_short_base {
		displayName = "Titan AT/AP Launcher (GRN)";
	};
	class launch_O_Titan_short_F : launch_Titan_short_base {
		displayName = "Titan AT/AP Launcher (BRN)";
	};
	class launch_Titan_short_F : launch_Titan_short_base {
		displayName = "Titan AT/AP Launcher (???)";
	};

	// vehicle weapons

	class MGunCore;
	class M134_minigun : MGunCore {
		class HighROF;
		class LowROF;
	};
	class M134_minigun_air_L : M134_minigun {
		displayName = "M134 Minigun 7.62 mm";
		magazineReloadTime = 5;
		magazines[] = {
			"ncb_mag_762x51_200_w_air",
			"ncb_mag_762x51_200_g_air",
			"ncb_mag_762x51_200_r_air",
			"ncb_mag_762x51_200_y_air",
			"ncb_mag_762x51_1000_w_air",
			"ncb_mag_762x51_1000_g_air",
			"ncb_mag_762x51_1000_r_air",
			"ncb_mag_762x51_1000_y_air",
			"ncb_mag_762x51_2000_w_air",
			"ncb_mag_762x51_2000_g_air",
			"ncb_mag_762x51_2000_r_air",
			"ncb_mag_762x51_2000_y_air",
			"ncb_mag_762x51_5000_w_air",
			"ncb_mag_762x51_5000_g_air",
			"ncb_mag_762x51_5000_r_air",
			"ncb_mag_762x51_5000_y_air"
		};
		reloadAction = "ManActReloadMagazine";
		reloadMagazineSound[] = {"A3\Sounds_F\arsenal\weapons_static\Static_HMG\reload_static_HMG",10,1,20};
		class HighROF : HighROF {
			cartridgePos = "nabojnicestart";
			cartridgeVel = "nabojniceend";
			muzzlePos = "usti hlavne";
			muzzleEnd = "konec hlavne";
			selectionFireAnim = "zasleh";
		};
		class LowROF : LowROF {
			cartridgePos = "nabojnicestart";
			cartridgeVel = "nabojniceend";
			muzzlePos = "usti hlavne";
			muzzleEnd = "konec hlavne";
			selectionFireAnim = "zasleh";
		};
		class GunParticles {
			class effect1 {
				positionName = "machinegun_eject_pos";
				directionName = "machinegun_eject_dir";
				effectName = "MachineGunCartridgeShort1";
			};
			class effect2 {
				positionName = "machinegun_end";
				directionName = "machinegun_beg";
				effectName = "MachineGun1";
			};
		};
	};
	class M134_minigun_air_R : M134_minigun_air_L {
		class GunParticles {
			class effect1 {
				positionName = "machinegun2_eject_pos";
				directionName = "machinegun2_eject_dir";
				effectName = "MachineGunCartridgeShort1";
			};
			class effect2 {
				positionName = "machinegun2_end";
				directionName = "machinegun2_beg";
				effectName = "MachineGun1";
			};
		};
	};
	class M134_minigun_land : M134_minigun_air_L {
		magazines[] = {
			"ncb_mag_762x51_200_w",
			"ncb_mag_762x51_200_g",
			"ncb_mag_762x51_200_r",
			"ncb_mag_762x51_200_y",
			"ncb_mag_762x51_1000_w",
			"ncb_mag_762x51_1000_g",
			"ncb_mag_762x51_1000_r",
			"ncb_mag_762x51_1000_y",
			"ncb_mag_762x51_2000_w",
			"ncb_mag_762x51_2000_g",
			"ncb_mag_762x51_2000_r",
			"ncb_mag_762x51_2000_y",
			"ncb_mag_762x51_5000_w",
			"ncb_mag_762x51_5000_g",
			"ncb_mag_762x51_5000_r",
			"ncb_mag_762x51_5000_y"
		};
	};

	// 7.62x54 LMG

	class LMG_coax;
	class ncb_weap_762x54_lmg_coax_1000 : LMG_coax {
		author = "Das Attorney";
		displayName = "PKM 7.62x54mm";
		magazines[] = {
			"ncb_mag_762x54_1000_w",
			"ncb_mag_762x54_1000_g",
			"ncb_mag_762x54_1000_r",
			"ncb_mag_762x54_1000_y"
		};
	};
	class ncb_weap_762x54_lmg_coax_2000 : ncb_weap_762x54_lmg_coax_1000 {
		author = "Das Attorney";
		displayName = "PKM 7.62x54mm";
		magazines[] = {
			"ncb_mag_762x54_2000_w",
			"ncb_mag_762x54_2000_g",
			"ncb_mag_762x54_2000_r",
			"ncb_mag_762x54_2000_y"
		};
	};

	class LMG_M200;
	class ncb_weap_762x54_lmg_1000 : LMG_M200 {
		author = "Das Attorney";
		displayName = "PKM 7.62x54mm";
		magazines[] = {
			"ncb_mag_762x54_1000_w",
			"ncb_mag_762x54_1000_g",
			"ncb_mag_762x54_1000_r",
			"ncb_mag_762x54_1000_y"
		};
	};
	class ncb_weap_762x54_lmg_2000 : ncb_weap_762x54_lmg_1000 {
		author = "Das Attorney";
		displayName = "PKM 7.62x54mm";
		magazines[] = {
			"ncb_mag_762x54_2000_w",
			"ncb_mag_762x54_2000_g",
			"ncb_mag_762x54_2000_r",
			"ncb_mag_762x54_2000_y"
		};
	};

	// 12.7x99


	class HMG_127;
	class ncb_weap_127x108_hmg_100 : HMG_127 {
		author = "Das Attorney";
		displayName = "DShK 12.7x108mm";
		magazines[] = {
			"ncb_mag_127x108_100",
			"ncb_mag_127x108_100_r",
			"ncb_mag_127x108_100_g",
			"ncb_mag_127x108_100_y"
		};
	};
	class ncb_weap_127x108_hmg_200 : ncb_weap_127x108_hmg_100 {
		magazines[] = {
			"ncb_mag_127x108_200",
			"ncb_mag_127x108_200_r",
			"ncb_mag_127x108_200_g",
			"ncb_mag_127x108_200_y"
		};
	};
	class ncb_weap_127x108_hmg_500 : ncb_weap_127x108_hmg_100 {
		magazines[] = {
			"ncb_mag_127x108_500",
			"ncb_mag_127x108_500_r",
			"ncb_mag_127x108_500_g",
			"ncb_mag_127x108_500_y"
		};
	};
	class HMG_127_APC;
	class ncb_weap_127x108_hmg_apc_100 : HMG_127_APC {
		author = "Das Attorney";
		displayName = "DShK 12.7x108mm";
		magazines[] = {
			"ncb_mag_127x108_100",
			"ncb_mag_127x108_100_r",
			"ncb_mag_127x108_100_g",
			"ncb_mag_127x108_100_y"
		};
	};
	class ncb_weap_127x108_hmg_apc_200 : ncb_weap_127x108_hmg_apc_100 {
		magazines[] = {
			"ncb_mag_127x108_200",
			"ncb_mag_127x108_200_r",
			"ncb_mag_127x108_200_g",
			"ncb_mag_127x108_200_y"
		};
	};
	class ncb_weap_127x108_hmg_apc_500 : ncb_weap_127x108_hmg_apc_100 {
		magazines[] = {
			"ncb_mag_127x108_500",
			"ncb_mag_127x108_500_r",
			"ncb_mag_127x108_500_g",
			"ncb_mag_127x108_500_y"
		};
	};
	class HMG_01;
	class ncb_weap_127x108_hmg_boat_200 : HMG_01 {
		author = "Das Attorney";
		displayName = "DShK 12.7x108mm";
		magazines[] = {
			"ncb_mag_127x108_200",
			"ncb_mag_127x108_200_r",
			"ncb_mag_127x108_200_g",
			"ncb_mag_127x108_200_y"
		};
	};
	class HMG_static;
	class ncb_weap_127x108_hmg_static_100 : HMG_static {
		author = "Das Attorney";
		displayName = "DShK 12.7x108mm";
		magazines[] = {
			"ncb_mag_127x108_100",
			"ncb_mag_127x108_100_r",
			"ncb_mag_127x108_100_g",
			"ncb_mag_127x108_100_y"
		};
	};

	class GMG_F;
	class GMG_20mm : GMG_F {
		displayName = "AGS-30 20 mm";
	};

	// VTOL weapons

	class autocannon_Base_F;
	class autocannon_40mm_CTWS : autocannon_Base_F {
		class HE;
		class AP;
	};
	class autocannon_40mm_VTOL_01 : autocannon_40mm_CTWS {
		class HE : HE {
			ballisticsComputer = "1 + 8";
		};
		class AP : AP {
			ballisticsComputer = "1 + 8";
		};
	};
	class CannonCore;
	class cannon_105mm : CannonCore {};
	class cannon_105mm_VTOL_01 : cannon_105mm {
		ballisticsComputer = "1 + 8";
	};
	class gatling_20mm : CannonCore {
	};
	class gatling_20mm_VTOL_01 : gatling_20mm {
		ballisticsComputer = "1 + 8";
	};
	// items

	class ItemCore : Default {
		horde_inventorySound = "horde_sound_magazineInventory";
	};
	class Uniform_Base : ItemCore {
		horde_inventorySound = "horde_sound_linenInventory";
		class ItemActions {
			class DropAttachedAmmo {
				text = "Drop attached light/smoke";
				script = "spawn horde_fnc_dropAttachedAmmo";
			};
			class MakeBandages {
				text = "Rip up into bandages";
				script = "spawn horde_fnc_makeBandages";
			};
			class Empty {
				text = "Empty contents (into BP & vest)";
				script = "call horde_fnc_emptyUniform";
			};
		};
	};
	class Vest_Camo_Base : ItemCore {
		horde_inventorySound = "horde_sound_magazineInventory";
		class ItemActions {
			class Empty {
				text = "Empty contents (into BP & uniform)";
				script = "call horde_fnc_emptyVest";
			};
		};
	};
	// test to see if we can block off backpack slot
	// class U_B_GhillieSuit : Uniform_Base {
 //        //subItems[] = {"ncb_obj_dummy_backpack"};
 //        subItems[] = {"B_AssaultPack_khk"};
 //    };
	class Vest_NoCamo_Base : ItemCore {
		horde_inventorySound = "horde_sound_magazineInventory";
		class ItemActions {
			class Empty {
				text = "Empty contents (into BP & uniform)";
				script = "call horde_fnc_emptyVest";
			};
		};
	};
	class HelmetBase : ItemCore {
		horde_inventorySound = "horde_sound_magazineInventory";
	};
	class H_Cap_red : HelmetBase {
		horde_inventorySound = "horde_sound_linenInventory";
	};
	class H_Cap_headphones : HelmetBase {
		horde_inventorySound = "horde_sound_linenInventory";
	};
	class H_MilCap_ocamo : HelmetBase {
		horde_inventorySound = "horde_sound_linenInventory";
	};
	class H_Bandanna_surfer : HelmetBase {
		horde_inventorySound = "horde_sound_linenInventory";
	};
	class H_Shemag_khk : HelmetBase {
		horde_inventorySound = "horde_sound_linenInventory";
	};
	class H_ShemagOpen_khk : HelmetBase {
		horde_inventorySound = "horde_sound_linenInventory";
	};
	class H_Watchcap_blk : HelmetBase {
		horde_inventorySound = "horde_sound_linenInventory";
	};
	class H_TurbanO_blk : HelmetBase {
		horde_inventorySound = "horde_sound_linenInventory";
	};
	class H_StrawHat : HelmetBase {
		horde_inventorySound = "horde_sound_linenInventory";
	};
	class H_Hat_blue : HelmetBase {
		horde_inventorySound = "horde_sound_linenInventory";
	};
	class Binocular : Default {
		horde_inventorySound = "horde_sound_magazineInventory";
	};

	// NOTE :  DEFINE ITEMS HERE

	class ItemBase : ItemCore {
		ncb_objectClass = "";
		class ItemInfo {
			mass = 2;
			scope = 0;
			type = 620;
		};
	};
	class ItemBaseVehicle : ItemBase {
		class ItemInfo : ItemInfo {
			mass = 150;
		};
	};
	class ItemBaseAmmo : ItemBase {
		class ItemInfo : ItemInfo {
			mass = 150;
		};
	};

	// DOCUMENTS

	class ItemBaseFiles : ItemBase {
		author = "Das Attorney";
		displayname = "Document";
		model = "\A3\Structures_F\Items\Documents\File1_F.p3d";
		picture = "\nocebo\images\document.paa";
		class ItemInfo : ItemInfo {
			mass = 0.01;
		};
	};
	class blackfishCASAccessCode : ItemBaseFiles {
		descriptionshort = "An access code allowing one use of a Blackfish<br />When used, you can invite a group member via the group menu";
		displayname = "Blackfish code";
		scope = 2;
		class ItemActions {
			class Use {
				text = "Request CAS";
				script = "call {[_this,'blackfish','ncb_dlg_casRemCtrlMenu'] spawn horde_fnc_casReadDocs}";
			};
		};
	};
	class ghosthawkCASAccessCode : ItemBaseFiles {
		descriptionshort = "An access code allowing one use of a Ghost Hawk<br />When used, you can invite a group member via the group menu";
		displayname = "Ghost Hawk code";
		scope = 2;
		class ItemActions {
			class Use {
				text = "Request CAS";
				script = "call {[_this,'ghosthawk','ncb_dlg_casRemCtrlMenu'] spawn horde_fnc_casReadDocs}";
			};
		};
	};
	class greyhawkCASAccessCode : ItemBaseFiles {
		descriptionshort = "An access code allowing one use of a Grey Hawk<br />You must have a UAV terminal equipped to use this";
		displayname = "Grey Hawk code";
		scope = 2;
		class ItemActions {
			class Use {
				text = "Request UAV";
				script = "call {[_this,'greyhawk','uav'] spawn horde_fnc_casReadDocs}";
			};
		};
	};
	class hammerStrikeAccessCode : ItemBaseFiles {
		descriptionshort = "An access code allowing one Mk45 Hammer salvo";
		displayname = "MK45 code";
		scope = 2;
		class ItemActions {
			class Use {
				text = "Request MK45";
				script = "call {[_this,'mk45','ncb_dlg_artyMenu'] spawn horde_fnc_casReadDocs}";
			};
		};
	};
	class mlrsStrikeAccessCode : ItemBaseFiles {
		descriptionshort = "An access code allowing one MLRS strike";
		displayname = "MLRS code";
		scope = 2;
		class ItemActions {
			class Use {
				text = "Request MLRS";
				script = "call {[_this,'mlrs','ncb_dlg_artyMenu'] spawn horde_fnc_casReadDocs}";
			};
		};
	};
	class wipeoutCASAccessCode : ItemBaseFiles {
		descriptionshort = "An access code allowing one use of an A-164 Wipeout";
		displayname = "Wipeout code";
		scope = 2;
		class ItemActions {
			class gun {
				text = "Request gun strike";
				script = "call {[_this,['B_Plane_CAS_01_dynamicLoadout_F',0],'ncb_dlg_casMenu'] spawn horde_fnc_casReadDocs}";
			};
			class missile {
				text = "Request missile strike";
				script = "call {[_this,['B_Plane_CAS_01_dynamicLoadout_F',1],'ncb_dlg_casMenu'] spawn horde_fnc_casReadDocs}";
			};
			class gunMissile {
				text = "Request gun and missile strike";
				script = "call {[_this,['B_Plane_CAS_01_dynamicLoadout_F',2],'ncb_dlg_casMenu'] spawn horde_fnc_casReadDocs}";
			};
			class bomb {
				text = "Request bomb";
				script = "call {[_this,['B_Plane_CAS_01_dynamicLoadout_F',3],'ncb_dlg_casMenu'] spawn horde_fnc_casReadDocs}";
			};
			class cluster {
				text = "Request cluster bomb";
				script = "call {[_this,['B_Plane_CAS_01_Cluster_F',3],'ncb_dlg_casMenu'] spawn horde_fnc_casReadDocs}";
			};
		};
	};

	// TENT

	class ItemBaseTent : ItemBase {
		author = "Das Attorney";
		horde_actionSound = "horde_sound_pitchTent";
		horde_inventorySound = "horde_sound_linenInventory";
		class ItemInfo : ItemInfo {
			mass = 30;
		};
	};
	class ItemTent : ItemBaseTent {
		descriptionshort = "A rolled up tent.";
		displayname = "Tent";
		model = "\A3\Structures_F\Civ\Camping\Sleeping_bag_folded_F.p3d";
		ncb_objectClass = "Land_Sleeping_bag_folded_F";
		picture = "\nocebo\images\tent.paa";
		scope = 2;
		class ItemActions {
			class PersonalTent {
				text = "Pitch Tent (personal)";
				script = "call {[_this,'personal'] spawn horde_fnc_pitchTent}";
			};
			class GroupTent {
				text = "Pitch Tent (group)";
				script = "call {[_this,'group'] spawn horde_fnc_pitchTent}";
			};
			class SideTent {
				text = "Pitch Tent (all players)";
				script = "call {[_this,'side'] spawn horde_fnc_pitchTent}";
			};
		};
	};
	class ItemCamoNet : ItemBaseTent {
		descriptionshort = "A packed down Camo Net.";
		displayname = "Camo Net";
		model = "\A3\Structures_F\Civ\Camping\Sleeping_bag_brown_folded_F.p3d";
		ncb_objectClass = "Land_Sleeping_bag_brown_folded_F";
		picture = "\nocebo\images\camo_net.paa";
		scope = 2;
		class ItemActions {
			class Use {
				text = "Pitch Camo Net";
				script = "spawn horde_fnc_pitchCamoNet";
			};
		};
	};
	class ItemCamoNetOpen : ItemCamoNet {
		descriptionshort = "A packed down Camo Net (open).";
		displayname = "Camo Net (open)";
		class ItemActions {
			class Use {
				text = "Pitch Camo Net (open)";
				script = "spawn horde_fnc_pitchCamoNet";
			};
		};
	};
	class ItemVehicleCamoNet : ItemCamoNet {
		descriptionshort = "A packed down Vehicle Camo Net.";
		displayname = "Vehicle Camo Net";
		class ItemActions {
			class Use {
				text = "Pitch Vehicle Camo Net";
				script = "spawn horde_fnc_pitchCamoNet";
			};
		};
	};

	// MEDICAL

	class ItemBaseMedical : ItemBase {
		author = "Das Attorney";
		horde_actionSound = "horde_sound_pills";
		horde_inventorySound = "horde_sound_linenInventory";
		class ItemInfo : ItemInfo {
			mass = 3;
		};
	};
	class ItemBandage : ItemBaseMedical {
		descriptionshort = "Used to wrap wounds.";
		displayname = "Bandage";
		horde_actionSound = "horde_sound_bandage";
		model = "\A3\Structures_F_EPA\Items\Medical\Bandage_F.p3d";
		ncb_objectClass = "Land_Bandage_F";
		picture = "\nocebo\images\bandage.paa";
		scope = 2;
		class ItemActions {
			class Use {
				text = "Bandage wounds";
				script = "spawn horde_fnc_useBandage";
			};
		};
		class ItemInfo : ItemInfo {
			mass = 5;
		};
	};
	class ItemMedigel : ItemBaseMedical {
		descriptionshort = "Used to kill clot wounds quickly.";
		displayname = "Medigel";
		horde_actionSound = "horde_sound_bandage";
		model = "\A3\Structures_F_EPA\Items\Medical\PainKillers_F.p3d";
		ncb_objectClass = "Land_PainKillers_F";
		picture = "\nocebo\images\painkillers.paa";
		scope = 2;
		class ItemActions {
			class Use {
				text = "Apply Medigel";
				script = "call horde_fnc_useMedigel";
			};
		};
		class ItemInfo : ItemInfo {
			mass = 5;
		};
	};
	class ItemBloodBag : ItemBaseMedical {
		descriptionshort = "Used on self replenishes some health.<br />For best effects, use on another player.";
		displayname = "Blood Bag";
		horde_actionSound = "horde_sound_firstAid";
		model = "\A3\Structures_F_EPA\Items\Medical\BloodBag_F.p3d";
		ncb_objectClass = "Land_BloodBag_F";
		picture = "\nocebo\images\blood_bag.paa";
		scope = 2;
		class ItemActions {
			class Use {
				text = "Use Blood Bag";
				script = "spawn horde_fnc_selfBloodBag";
			};
		};
	};
	class ItemMedPack : ItemBaseMedical {
		descriptionshort = "Replenishes some health<br />and stops bleeding.<br />For best effects, use on another player.";
		displayname = "Med Pack";
		horde_actionSound = "horde_sound_firstAid";
		model = "\A3\Weapons_F\Items\FirstAidkit";
		ncb_objectClass = "Item_FirstAidKit";
		picture = "\A3\Weapons_F\Items\data\UI\gear_FirstAidKit_CA.paa";
		scope = 2;
		class ItemActions {
			class Use {
				text = "Use Med Pack";
				script = "spawn horde_fnc_useMedPack";
			};
		};
		class ItemInfo : ItemInfo {
			mass = 15;
		};
	};
	class ItemTruckerPills : ItemBaseMedical {
		descriptionshort = "Used to avoid fatigue. Do not OD on these!";
		displayname = "Trucker Pills";
		model = "\A3\Structures_F_EPA\Items\Medical\VitaminBottle_F.p3d";
		ncb_objectClass = "Land_VitaminBottle_F";
		picture = "\nocebo\images\vitamins.paa";
		scope = 2;
		class ItemActions {
			class Use {
				text = "Take Trucker Pills";
				script = "spawn horde_fnc_useTruckerPills";
			};
		};
	};
	class ItemDefibrillator : ItemBaseMedical {
		descriptionshort = "Used to restart hearts.";
		displayname = "Defibrillator";
		horde_actionSound = "";
		model = "\A3\Structures_F_EPA\Items\Medical\Defibrillator_F.p3d";
		ncb_objectClass = "Land_Defibrillator_F";
		picture = "\nocebo\images\defibrillator.paa";
		scope = 2;
		class ItemInfo : ItemInfo {
			mass = 30;
		};
	};

	// CONSUMABLES (rubbish, food, drink)

	class ItemBaseConsumables : ItemBase {
		author = "Das Attorney";
		horde_actionSound = "horde_sound_drinkCan";
		horde_inventorySound = "horde_sound_linenInventory";
		class ItemInfo : ItemInfo {
			mass = 6;
		};
	};

	// RUBBISH

	class ItemBaseRubbish : ItemBaseConsumables {
	};
	class ItemCanDented : ItemBaseRubbish {
		descriptionshort = "Empty can.";
		displayname = "Empty Can";
		model = "\A3\Structures_F\Items\Food\Can_Dented_F.p3d";
		ncb_objectClass = "Land_Can_Dented_F";
		picture = "\nocebo\images\lemonade_fizzy_pop.paa";
		scope = 2;
	};
	class ItemCanRusty : ItemCanDented {
		model = "\A3\Structures_F\Items\Food\Can_Rusty_F.p3d";
		ncb_objectClass = "Land_Can_Rusty_F";
		picture = "\nocebo\images\lemonade_fizzy_pop.paa";
	};
	class ItemCartridgeCase9x21 : ItemBaseRubbish {
		descriptionshort = "Spent Cartridge 9x21mm.";
		displayname = "Spent Cartridge 9x21mm.";
		model = "\A3\Weapons_f\ammo\cartridge_small";
		ncb_objectClass = "";
		picture = "\nocebo\images\spent_cartridge.paa";
		scope = 2;
	};
	class ItemCartridgeCase556x45 : ItemCartridgeCase9x21 {
		descriptionshort = "Spent Cartridge 5.56x45mm.";
		displayname = "Spent Cartridge 5.56x45mm.";
		model = "\A3\Weapons_f\ammo\cartridge";
		picture = "\nocebo\images\spent_cartridge.paa";
	};
	class ItemCartridgeCase65x39 : ItemCartridgeCase9x21 {
		descriptionshort = "Spent Cartridge 6.5x39mm.";
		displayname = "Spent Cartridge 6.5x39mm.";
		model = "\A3\weapons_f\ammo\cartridge_65";
		picture = "\nocebo\images\spent_cartridge.paa";
	};
	class ItemCartridgeCase762x51 : ItemCartridgeCase9x21 {
		descriptionshort = "Spent Cartridge 7.62x51mm.";
		displayname = "Spent Cartridge 7.62x51mm.";
		model = "\A3\weapons_f\ammo\cartridge_762";
		picture = "\nocebo\images\spent_cartridge.paa";
	};
	class ItemCartridgeCase127x99 : ItemCartridgeCase9x21 {
		descriptionshort = "Spent Cartridge 12.7x99mm.";
		displayname = "Spent Cartridge 12.7x99mm.";
		model = "\A3\weapons_f\ammo\cartridge_127";
		picture = "\nocebo\images\spent_cartridge.paa";
	};

	// DRINK

	class ItemBaseDrink : ItemBaseConsumables {
	};
	class ItemCanDrink : ItemBaseDrink {
		descriptionshort = "Refreshing fizzy pop.";
		displayname = "Fizzy lemon pop";
		horde_actionSound = "horde_sound_drinkBottle";
		model = "\A3\Structures_F\Items\Food\Can_V1_F.p3d";
		ncb_objectClass = "Land_Can_V1_F";
		picture = "\nocebo\images\lemonade_fizzy_pop.paa";
		scope = 2;
		class ItemActions {
			class Refill {
				text = "Fill empty canteen";
				script = "spawn horde_fnc_fillCanteen";
			};
			class Use {
				text = "Drink fizzy pop";
				script = "spawn horde_fnc_drinkCan";
			};
		};
	};
	class ItemCanDrink2 : ItemCanDrink {
		displayname = "Fizzy orange pop";
		model = "\A3\Structures_F\Items\Food\Can_V2_F.p3d";
		ncb_objectClass = "Land_Can_V2_F";
		picture = "\nocebo\images\orange_fizzy_pop.paa";
	};
	class ItemCanDrink3 : ItemCanDrink {
		displayname = "Fizzy energy drink";
		model = "\A3\Structures_F\Items\Food\Can_V3_F.p3d";
		ncb_objectClass = "Land_Can_V3_F";
		picture = "\nocebo\images\red_gull.paa";
	};
	class ItemBottleDrink : ItemCanDrink {
		descriptionshort = "From the Alps.";
		displayname = "Bottled Water";
		horde_actionSound = "horde_sound_drinkBottle";
		model = "\A3\Structures_F_EPA\Items\Food\BottlePlastic_V2_F.p3d";
		ncb_objectClass = "Land_BottlePlastic_V2_F";
		picture = "\nocebo\images\water_bottle_1.paa";
		class ItemActions {
			class Refill {
				text = "Fill empty canteen";
				script = "spawn horde_fnc_fillCanteen";
			};
			class Use {
				text = "Drink water";
				script = "spawn horde_fnc_drinkCan";
			};
		};
	};
	class ItemCanteen : ItemBaseDrink {
		descriptionshort = "Canteen full of fluid.";
		displayname = "Canteen (full)";
		horde_actionSound = "horde_sound_drinkBottle";
		model = "\A3\Structures_F_EPA\Items\Food\Canteen_F.p3d";
		ncb_objectClass = "Land_Canteen_F";
		picture = "\nocebo\images\canteen.paa";
		scope = 2;
		class ItemActions {
			class Use {
				text = "Drink fluid";
				script = "spawn horde_fnc_drinkCanteen";
			};
		};
		class ItemInfo : ItemInfo {
			mass = 8;
		};
	};
	class ItemCanteenEmpty : ItemBaseDrink {
		descriptionshort = "Empty canteen.";
		displayname = "Canteen (empty)";
		horde_actionSound = "horde_sound_fillCanteen";
		model = "\A3\Structures_F_EPA\Items\Food\Canteen_F.p3d";
		ncb_objectClass = "Land_Canteen_F";
		picture = "\nocebo\images\canteen.paa";
		scope = 2;
		class ItemInfo : ItemInfo {
			mass = 3;
		};
	};

	// FOOD

	class ItemBaseFood : ItemBaseConsumables {
	};
	class ItemBakedBeans : ItemBaseFood {
		descriptionshort = "Baked beans.";
		displayname = "Baked Beans";
		horde_actionSound = "horde_sound_eatFood";
		model = "\A3\Structures_F_EPA\Items\Food\BakedBeans_F.p3d";
		ncb_objectClass = "Land_BakedBeans_F";
		picture = "\nocebo\images\baked_beans.paa";
		scope = 2;

		horde_increase_food = 30;
		horde_restore_health = 0.1;

		class ItemActions {
			class Use {
				text = "Eat Baked beans";
				script = "spawn horde_fnc_eatFood";
			};
		};
		class ItemInfo: ItemInfo {
			mass = 7;
		};
	};
	class ItemCereal : ItemBaseFood {
		descriptionshort = "Cereal.";
		displayname = "Box of cereal";
		horde_actionSound = "horde_sound_eatFood";
		model = "\A3\Structures_F_EPA\Items\Food\CerealsBox_F.p3d";
		ncb_objectClass = "Land_CerealsBox_F";
		picture = "\nocebo\images\cereal.paa";
		scope = 2;

		horde_increase_food = 35;
		horde_restore_health = 0.15;

		class ItemActions {
			class Use {
				text = "Eat Cereal";
				script = "spawn horde_fnc_eatFood";
			};
		};
		class ItemInfo: ItemInfo {
			mass = 7;
		};
	};
	class ItemRice : ItemBaseFood {
		descriptionshort = "Rice.";
		displayname = "Box of rice";
		horde_actionSound = "horde_sound_eatFood";
		model = "\A3\Structures_F_EPA\Items\Food\RiceBox_F.p3d";
		ncb_objectClass = "Land_RiceBox_F";
		picture = "\nocebo\images\rice.paa";
		scope = 2;

		horde_increase_food = 40;
		horde_restore_health = 0.2;

		class ItemActions {
			class Use {
				text = "Eat Rice";
				script = "spawn horde_fnc_eatFood";
			};
		};
		class ItemInfo: ItemInfo {
			mass = 7;
		};
	};
	class ItemCanBacon : ItemBaseFood {
		descriptionshort = "MR Bacon";
		displayname = "Mechanically Recovered Bacon";
		horde_actionSound = "horde_sound_eatFood";
		model = "\A3\Structures_F\Items\Food\TacticalBacon_F.p3d";
		ncb_objectClass = "Land_TacticalBacon_F";
		picture = "\nocebo\images\tactical_bacon.paa";
		scope = 2;

		horde_increase_food = 25;
		horde_restore_health = 0.01;

		class ItemActions {
			class Use {
				text = "Eat MR Bacon";
				script = "spawn horde_fnc_eatFood";
			};
		};
		class ItemInfo: ItemInfo {
			mass = 7;
		};
	};
	class ItemMeatRaw: ItemBaseFood {
		descriptionshort = "Put in fire container to cook";
		displayname = "Raw Meat";
		horde_actionSound = "horde_sound_eatFood";
		model = "\A3\Structures_F\Items\Food\TacticalBacon_F.p3d";
		ncb_objectClass = "Land_TacticalBacon_F";
		picture = "\nocebo\images\tactical_bacon.paa";
		scope = 2;
		horde_increase_food = -10;
		horde_restore_health = -0.1;
		class ItemActions {
			class Use {
				text = "Eat Raw Meat";
				script = "spawn horde_fnc_eatFood";
			};
		};
		class ItemInfo: ItemInfo {
			mass = 1;
		};
	};
	class ItemMeatCookedBurnt : ItemMeatRaw {
		descriptionshort = "Burnt Steak";
		displayname = "Overcooked steak";
		model = "\A3\Structures_F\Items\Food\TacticalBacon_F.p3d";
		ncb_objectClass = "Land_TacticalBacon_F";
		picture = "\nocebo\images\tactical_bacon.paa";
		horde_increase_food = 5;
		horde_restore_health = 0.15;
		class ItemActions {
			class Use {
				text = "Eat Burnt Steak (burger)";
				script = "spawn horde_fnc_eatFood";
			};
		};
	};
	class ItemMeatCookedMedium : ItemMeatRaw {
		descriptionshort = "Cooked Steak";
		displayname = "Medium grilled steak";
		model = "\A3\Structures_F\Items\Food\TacticalBacon_F.p3d";
		ncb_objectClass = "Land_TacticalBacon_F";
		picture = "\nocebo\images\tactical_bacon.paa";
		horde_increase_food = 30;
		horde_restore_health = 0.25;
		class ItemActions {
			class Use {
				text = "Eat Medium Steak";
				script = "spawn horde_fnc_eatFood";
			};
		};
	};
	class ItemMeatCookedLean : ItemMeatRaw {
		descriptionshort = "Lean Steak";
		displayname = "Lean grilled steak, heated to perfection";
		model = "\A3\Structures_F\Items\Food\TacticalBacon_F.p3d";
		ncb_objectClass = "Land_TacticalBacon_F";
		picture = "\nocebo\images\tactical_bacon.paa";
		horde_increase_food = 60;
		horde_restore_health = 0.4;
		class ItemActions {
			class Use {
				text = "Eat Delicious Lean Steak";
				script = "spawn horde_fnc_eatFood";
			};
		};
	};

	// WOOD

	class ItemBaseWood : ItemBase {
		author = "Das Attorney";
		horde_actionSound = "horde_sound_drinkCan";
		horde_inventorySound = "horde_sound_linenInventory";
		class ItemInfo : ItemInfo {
			mass = 6;
		};
	};
	class ItemFireWood : ItemBaseWood {
		descriptionshort = "Firewood.";
		displayname = "Firewood";
		horde_actionSound = "horde_sound_drinkBottle";
		model = "\A3\Structures_F\Civ\Accessories\WoodPile_F.p3d";
		ncb_objectClass = "Land_WoodPile_F";
		picture = "\nocebo\images\woodpile.paa";
		scope = 2;
		class ItemActions {
			class MakeFire {
				text = "Build fire";
				script = "spawn horde_fnc_buildFire";
			};
		};
	};
	class ItemFireWoodLog : ItemFireWood {
		descriptionshort = "Log of firewood.";
		displayname = "Firewood (log)";
		model = "\A3\Structures_F_EPA\Civ\Camping\WoodenLog_F.p3d";
		ncb_objectClass = "Land_WoodenLog_F";
		picture = "\nocebo\images\woodenLog.paa";
		scope = 2;
		class ItemActions {
			class MakeFire {
				text = "Build fire";
				script = "spawn horde_fnc_buildFire";
			};
		};
	};

	// PASSES

	class ItemBasePass : ItemBase {
		author = "Das Attorney";
		horde_actionSound = "";
		horde_inventorySound = "horde_sound_linenInventory";
		class ItemInfo : ItemInfo {
			mass = 1;
		};
	};
	class ItemPass_MasterAll : ItemBasePass {
		descriptionshort = "Master level clearance for all doors.";
		displayname = "Master Pass - All Doors";
		horde_pass_color = "master";
		horde_pass_type = "all";
		model = "\itempass\model\ItemPassBlack.p3d";
		picture = "\nocebo\images\pass_white.paa";
		scope = 2;
	};
	class ItemPass_Alpha : ItemBasePass {
		descriptionshort = "Alpha level door clearance.";
		displayname = "Alpha Pass";
		horde_pass_color = "alpha";
		horde_pass_type = "all";
		model = "\itempass\model\ItemPassRed.p3d";
		picture = "\nocebo\images\pass_red.paa";
		scope = 2;
	};
	class ItemPass_Beta : ItemBasePass {
		descriptionshort = "Beta level door clearance.";
		displayname = "Beta Pass";
		horde_pass_color = "beta";
		horde_pass_type = "all";
		model = "\itempass\model\ItemPassBlue.p3d";
		picture = "\nocebo\images\pass_blue.paa";
		scope = 2;
	};
	class ItemPass_Gamma : ItemBasePass {
		descriptionshort = "Gamma level door clearance.";
		displayname = "Gamma Pass";
		horde_pass_color = "gamma";
		horde_pass_type = "all";
		model = "\itempass\model\ItemPassGreen.p3d";
		picture = "\nocebo\images\pass_green.paa";
		scope = 2;
	};
	class ItemPass_Omega : ItemBasePass {
		descriptionshort = "Omega level door clearance.";
		displayname = "Omega Pass";
		horde_pass_color = "omega";
		horde_pass_type = "all";
		model = "\itempass\model\ItemPassYellow.p3d";
		picture = "\nocebo\images\pass_yellow.paa";
		scope = 2;
	};

	// TOOLS

	class ItemBaseTool : ItemBase {
		author = "Das Attorney";
		horde_actionSound = "";
		horde_inventorySound = "horde_sound_linenInventory";
		class ItemInfo : ItemInfo {
			mass = 3;
		};
	};
	class ItemDrill : ItemBaseTool {
		descriptionshort = "Used for repair.";
		displayname = "Electric Drill";
		model = "\A3\Structures_F\Items\Tools\DrillAku_F.p3d";
		ncb_objectClass = "Land_DrillAku_F";
		picture = "\nocebo\images\drill.paa";
		scope = 2;
		class ItemInfo : ItemInfo {
			mass = 35;
		};
	};
	class ItemGrinder : ItemBaseTool {
		descriptionshort = "Used for repair.";
		displayname = "Grinder";
		model = "\A3\Structures_F\Items\Tools\Grinder_F.p3d";
		ncb_objectClass = "Land_Grinder_F";
		picture = "\nocebo\images\grinder.paa";
		scope = 2;
		class ItemInfo : ItemInfo {
			mass = 45;
		};
	};
	class ItemHammer : ItemBaseTool {
		descriptionshort = "Used for repair.";
		displayname = "Hammer";
		model = "\A3\Structures_F\Items\Tools\Hammer_F.p3d";
		ncb_objectClass = "Land_Hammer_F";
		picture = "\nocebo\images\hammer.paa";
		scope = 2;
		class ItemInfo : ItemInfo {
			mass = 15;
		};
	};
	class ItemMultiMeter : ItemBaseTool {
		descriptionshort = "Used for repair.";
		displayname = "Multi-meter";
		model = "\A3\Structures_F\Items\Tools\MultiMeter_F.p3d";
		ncb_objectClass = "Land_MultiMeter_F";
		picture = "\nocebo\images\multimeter.paa";
		scope = 2;
		class ItemInfo : ItemInfo {
			mass = 7;
		};
	};
	class ItemPliers : ItemBaseTool {
		descriptionshort = "Used for repair,<br />cutting fences,<br />interrogation<br />and removing bullets.";
		displayname = "Pliers";
		model = "\A3\Structures_F\Items\Tools\Pliers_F.p3d";
		ncb_objectClass = "Land_Pliers_F";
		picture = "\nocebo\images\pliers.paa";
		scope = 2;
		class ItemActions {
			class SelfRemoveBullet {
				text = "Remove bullet (self)";
				script = "spawn horde_fnc_selfRemoveBullet";
			};
		};
		class ItemInfo : ItemInfo {
			mass = 5;
		};
	};
	class ItemScrewdriverPhillips : ItemBaseTool {
		descriptionshort = "Used for repair.";
		displayname = "Phillips Screwdriver";
		model = "\A3\Structures_F\Items\Tools\Screwdriver_V1_F.p3d";
		ncb_objectClass = "Land_Screwdriver_V1_F";
		picture = "\nocebo\images\screwdriver_phillips.paa";
		scope = 2;
		class ItemInfo : ItemInfo {
			mass = 5;
		};
	};
	class ItemScrewdriverSlotted : ItemBaseTool {
		descriptionshort = "Used for repair.";
		displayname = "Slot Screwdriver";
		model = "\A3\Structures_F\Items\Tools\Screwdriver_V2_F.p3d";
		ncb_objectClass = "Land_Screwdriver_V2_F";
		picture = "\nocebo\images\screwdriver_slot.paa";
		scope = 2;
		class ItemInfo : ItemInfo {
			mass = 5;
		};
	};
	class ItemWrench : ItemBaseTool {
		descriptionshort = "Useful for repair.";
		descriptionuse = "<t color='#9cf953'>Use : </t>Tooltip";
		displayname = "Wrench";
		model = "\A3\Structures_F\Items\Tools\Wrench_F.p3d";
		ncb_objectClass = "Land_Wrench_F";
		picture = "\nocebo\images\wrench.paa";
		scope = 2;
		class ItemInfo : ItemInfo {
			mass = 5;
		};
	};
	class ItemMatchBox : ItemBaseTool {
		descriptionshort = "Used for lighting fires.";
		displayname = "Matches";
		model = "\A3\Structures_F_EPA\Items\Tools\Matches_F.p3d";
		ncb_objectClass = "Land_Matches_F";
		picture = "\nocebo\images\matchBox.paa";
		scope = 2;
		class ItemInfo : ItemInfo {
			mass = 0.5;
		};
	};

	// NOTE:  DEFINE ASSIGNABLE ITEMS HERE

	class ItemWatch;

	class AssignedItemBase : ItemWatch {
		author = "Das Attorney";
		descriptionuse = "";
		mass = 1;
		model = "";
		ncb_objectClass = "";
		picture = "";
		scope = 1;
		class ItemInfo {
			mass = 1;
		};
	};

	// SUPPLIES

	class ItemSupply_Base : AssignedItemBase {
		author = "Das Attorney";
		descriptionuse = "<t color='#9cf953'>Use : </t>Use supply";
		mass = 1;
		model = "";
		picture = "\A3\Weapons_F\Data\UI\gear_item_watch_ca.paa";
		scope = 1;
		class ItemInfo {
			mass = 3;
		};
	};
	class ItemJerryCan : ItemSupply_Base {
		descriptionshort = "Used to refuel vehicles.";
		displayname = "Jerry Can (full)";
		horde_actionSound = "";
		horde_inventorySound = "horde_sound_jerryCanInventory";
		model = "\A3\Structures_F\Items\Vessels\CanisterFuel_F.p3d";
		ncb_objectClass = "Land_CanisterFuel_F";
		picture = "\nocebo\images\jerry_can.paa";
		scope = 2;
		class ItemInfo {
			mass = 200;
		};
	};
	class ItemJerryCanEmpty : ItemSupply_Base {
		descriptionshort = "Empty Jerry Can.";
		displayname = "Jerry Can (empty)";
		horde_actionSound = "";
		horde_inventorySound = "horde_sound_jerryCanInventory";
		model = "\A3\Structures_F\Items\Vessels\CanisterFuel_F.p3d";
		ncb_objectClass = "Land_CanisterFuel_F";
		picture = "\nocebo\images\jerry_can.paa";
		scope = 2;
		class ItemInfo {
			mass = 20;
		};
	};
};