// class cfgSoundSets {
// 	class TreeFalling {
// 		distanceFilter = "explosionDistanceFreqAttenuationFilter";
// 		doppler = 0;
// 		loop = 0;
// 		sound3DProcessingType = "ExplosionHeavy3DProcessingType";
// 		soundShaders[] = {
// 			"TreeFalling_closeExp_SoundShader"
// 		};
// 		spatial = 1;
// 		volumeCurve = "LinearCurve";
// 		volumeFactor = 2;
// 	};
// };

// class CfgSoundShaders {
// 	class TreeFalling_closeExp_SoundShader {
// 		range = 110;
// 		rangeCurve = "CannonCloseShotCurve";
// 		samples[] = {
// 			{"\nocebo\sounds\tree_falling",1},
// 			{"\nocebo\sounds\tree_falling",1},
// 			{"\nocebo\sounds\tree_falling",1},
// 			{"\nocebo\sounds\tree_falling",1}
// 		};
// 	};
// };


// EFFECT CONFIGS
class Horde_EngineSmokeBaseCfg {
	class Horde_EngineSmokeBaseCfg {
		intensity = 1;
		interval = 1;
		position[] = {0,0,0};
		simulation = "particles";
		type = "Horde_EngineSmokeCloudlet";   // SmokeShellWhite
	};
};

class Horde_EngineSmokeBaseCfg2 {
	class smokeFX {
		intensity = 1;
		interval = 1;
		position[] = {0,0,0};
		simulation = "particles";
		type = "Horde_EngineSmokeCloudlet2";
	};
};
class Horde_EngineSmokeBaseCfg3 {
	class smokeFX {
		intensity = 1;
		interval = 1;
		position[] = {0,0,0};
		simulation = "particles";
		type = "Horde_EngineSmokeCloudlet3";
	};
};
class Horde_WreckSmokeBaseCfg {
	class Smoke1 {
		intensity = 1;
		interval = 1; // 0.12
		position[] = {0,0,0};
		simulation = "particles";
		type = "ObjectDestructionSmokeSmallx";
	};
	class Smoke2 {
		intensity = 1;
		interval = 1; // 0.16
		position[] = {0,0,0};
		simulation = "particles";
		type = "ObjectDestructionSmoke1_2Smallx";
	};
};
class ImpactSuppressionObject {
	class ImpactSuppressionObject {
		intensity = 0;
		interval = 0;
		position[] = {0,0,0};
		simulation = ""; // particles";
		type = ""; // Refract"; or "Test_SuppressionFX";
	};
};

class Horde_BreachingChargeCfg {
	class LightExp {
		simulation = "light";
		type = "ExploLight";
		position[] = {0, 1.5, 0};
		intensity = 0.001;
		interval = 1;
		lifeTime = 0.25;
	};
	class Horde_AmmoEH {
		simulation = "particles";
		// type = "GrenadeExp";
		type = "Horde_AmmoEHCloudlet";
		position[] = {0,0,0};
		intensity = 1;
		interval = 1;
		lifeTime = 1;
	};
	class Explosion1 {
		simulation = "particles";
		type = "Horde_ImpactSparksSabot1";
		position[] = {0, 0, 0};
		intensity = 3;
		interval = 1;
		lifeTime = 0.25;
	};
	class SmallSmoke1 {
		simulation = "particles";
		type = "CloudSmallLight2";
		position[] = {0, 0, 0};
		intensity = 1;
		interval = 1;
		lifeTime = 1;
	};
	class FireSparksSmall1 {
		simulation = "particles";
		type = "FireSparksSmall2";
		position[] = {0, 0, 0};
		intensity = 1;
		interval = 1;
		lifeTime = 1;
	};
	class MissileCircleDust {
		simulation = "particles";
		type = "MineCircleDust1";
		position[] = {0, 0, 0};
		intensity = 1;
		interval = 1;
		lifeTime = 0.2;
	};
};

// END CONFIGS


class CfgAmmo {
	class Default;
	class FakeCore: Default {};
	class FlareBase;
	class F_40mm_White: FlareBase {
		brightness = 250;
		intensity = 15000;
		timetolive = 60;
	};
	class BulletCore;

	class BulletBase: BulletCore{
		access = 1;
	};

	// MX series different from Katiba (denoted by R)


	// Katiba


	// 7.62 & .408 caliber level

	class B_762x51_Ball : BulletBase {};
	class ncb_762x51_air : B_762x51_Ball {
		hit = 12;
        indirectHit = 1.2;
        indirectHitRange = 2;
        model = "\A3\Weapons_f\Data\bullettracer\tracer_white";
        caliber = 3.6;
        deflecting = 30;
        fuseDistance = 0;
        soundSetSonicCrack[] = {"BulletSonicCrack_Gatling_SoundSet"};
	};
	class ncb_762x51_air_tg : ncb_762x51_air {
		model = "\A3\Weapons_f\Data\bullettracer\tracer_green";
	};
	class ncb_762x51_air_tr : ncb_762x51_air {
		model = "\A3\Weapons_f\Data\bullettracer\tracer_red";
	};
	class ncb_762x51_air_ty : ncb_762x51_air {
		model = "\A3\Weapons_f\Data\bullettracer\tracer_yellow";
	};


	class B_408_Ball : BulletBase {};

	// 127x99 & 127x108 caliber level

	class B_127x99_Ball : BulletBase {
	};

	class B_127x108_Ball : BulletBase {
	};

	class B_127x108_Ball_TG : B_127x108_Ball {
		model = "\A3\Weapons_f\Data\bullettracer\tracer_green";
	};

	class B_127x108_Ball_TR : B_127x108_Ball {
		model = "\A3\Weapons_f\Data\bullettracer\tracer_red";
	};

	class B_127x108_Ball_TY : B_127x108_Ball {
		model = "\A3\Weapons_f\Data\bullettracer\tracer_yellow";
	};

	class B_127x108_APDS;

	class B_127x108_APDS_TG : B_127x108_APDS {
		model = "\A3\Weapons_f\Data\bullettracer\tracer_green";
	};

	class B_127x108_APDS_TR: B_127x108_APDS {
		model = "\A3\Weapons_f\Data\bullettracer\tracer_red";
	};

	class B_127x108_APDS_TY: B_127x108_APDS {
		model = "\A3\Weapons_f\Data\bullettracer\tracer_yellow";
	};


	// breaching charge

	class DemoCharge_Remote_Ammo_Scripted;
	class BreachingCharge_Remote_Ammo_Scripted : DemoCharge_Remote_Ammo_Scripted {
		cratereffects = "";
		cratershape = "\A3\weapons_f\empty.p3d";
		defaultmagazine = "BreachingCharge_Remote_Mag";
		// explosioneffects = "DirectionalMineExplosion";
		directionalExplosion = 1;
		explosionangle = 60;
		explosioneffects = "Horde_BreachingChargeCfg";
		hit = 7;
		indirecthit = 3;
		indirecthitrange = 4;
		minemodeldisabled = "\A3\Weapons_F\explosives\mine_AP_bouncing_d";
		minetrigger = "RemoteTrigger";
		model = "\A3\Weapons_F\explosives\mine_AP_bouncing";
		soundhit[] = {"A3\Sounds_F\weapons\mines\mine_5", 3.16228, 1, 800};
		triggerWhenDestroyed = 1;
		whistledist = 24;
	};

	// engine smoke
	class GrenadeHand;
	class SmokeShell : GrenadeHand {
		displayName = "smoke grenade";
		class InteractionInfo : InteractionInfo {
			class attachAmmo : attachAmmo {
				text = "Pick up smoke grenade";
				tooltip	= "'Attach a smoke' + endl + 'grenade to' + endl + 'your clothing'";
			};
			class dropAmmo : dropAmmo {
				text = "Drop smoke grenade";
				tooltip	= "'Remove smoke grenade' + endl + 'from your clothing'";
			};
			class swapAmmo : swapAmmo {
				text = "Swap smoke grenades";
				tooltip	= "'Attach a different' + endl + 'smoke grenade to' + endl + 'your clothing'";
			};
		};
	};
	class Horde_EngineSmokeAmmo1: SmokeShell {
		access = 1;
		cost = 100;
		deflecting = 0;
		effectssmoke = "Horde_EngineSmokeBaseCfg"; // this is the base cfg effect (see top of file) that then checks for the class in cfgCloudlets
		explosiontime = 0.1;
		explosive = 0;
		fusedistance = 0;
		grenadeburningsound[] = {"SmokeShellSoundLoop1", 0.5, "SmokeShellSoundLoop2", 0.5};
		grenadefiresound[] = {"SmokeShellSoundHit1", 0.25, "SmokeShellSoundHit2", 0.25, "SmokeShellSoundHit3", 0.5};
		hit = 0;
		indirecthit = 0;
		indirecthitrange = 0.2;
		// model = "\A3\Weapons_f\empty"; // "\A3\Weapons_f\ammo\smokegrenade_white";
		simulation = "shotSmokeX";
		smokecolor[] = {1, 1, 1, 1};
		smokeshellsoundhit1[] = {"A3\Sounds_F\arsenal\sfx\bullet_hits\metal_plate_01", 1.25893, 1, 100};
		smokeshellsoundhit2[] = {"A3\Sounds_F\arsenal\sfx\bullet_hits\metal_plate_02", 1.25893, 1, 100};
		smokeshellsoundhit3[] = {"A3\Sounds_F\arsenal\sfx\bullet_hits\metal_plate_03", 1.25893, 1, 100};
		smokeshellsoundloop1[] = {"A3\Sounds_F\weapons\smokeshell\smoke_loop1", 0.1, 1, 70};
		smokeshellsoundloop2[] = {"A3\Sounds_F\weapons\smokeshell\smoke_loop2", 0.1, 1, 70};
		soundhit[] = {"", 0, 1};
		timetolive = 999999;
		whistledist = 0;
		class InteractionInfo {};
	};
	class Horde_EngineSmokeAmmo2: Horde_EngineSmokeAmmo1 {
		effectssmoke = "Horde_EngineSmokeBaseCfg2";
	};
	class Horde_EngineSmokeAmmo3: Horde_EngineSmokeAmmo1 {
		effectssmoke = "Horde_EngineSmokeBaseCfg3";
	};
	// class ShotDeployBase;
	// class Smoke_82mm_AMOS_White : ShotDeployBase {
	// 	grenadeBurningSound[] = {"SmokeShellSoundLoop1",0.5,"SmokeShellSoundLoop2",0.5};
	// 	multiSoundHit[] = {"soundHit1",0.33,"soundHit2",0.33,"soundHit3",0.34};
	// 	soundHit1[] = {"A3\Sounds_F\weapons\smokeshell\smoke_1",2.52,1,100};
	// 	soundHit2[] = {"A3\Sounds_F\weapons\smokeshell\smoke_2",2.52,1,100};
	// 	soundHit3[] = {"A3\Sounds_F\weapons\smokeshell\smoke_3",2.52,1,100};
	// 	smokeshellsoundloop1[] = {"A3\Sounds_F\weapons\smokeshell\smoke_loop1",0.13,1,70};
	// 	smokeshellsoundloop2[] = {"A3\Sounds_F\weapons\smokeshell\smoke_loop2",0.13,1,70};
	// };

	class Chemlight_base : SmokeShell {
		class InteractionInfo : InteractionInfo {
			class attachAmmo : attachAmmo {
				text = "Pick up chemlight";
				tooltip	= "'Attach a chemlight' + endl + 'to your clothing'";
			};
			class dropAmmo : dropAmmo {
				text = "Drop chemlight";
				tooltip	= "'Remove chemlight' + endl + 'from your clothing'";
			};
			class swapAmmo : swapAmmo {
				text = "Swap chemlights";
				tooltip	= "'Swap your attached' + endl + 'object with this one'";
			};
			class extinguishAmmo : extinguishAmmo {
				text = "Extinguish light";
				tooltip	= "'Extinguish' + endl + 'chemlight'";
			};
		};
	};
	class Chemlight_blue: Chemlight_base {
		displayName = "blue chemlight";
	};

	class Chemlight_green: Chemlight_base {
		displayName = "green chemlight";
	};

	class Chemlight_red: Chemlight_base {
		displayName = "red chemlight";
	};

	class Chemlight_yellow: Chemlight_base {
		displayName = "yellow chemlight";
	};

	// wreck smoke

	class Horde_WreckSmokeAmmo: Horde_EngineSmokeAmmo1 {
		effectssmoke = "Horde_WreckSmokeBaseCfg";
	};

	class GrenadeCore;
	class FlareCore;
	class Flare_82mm_AMOS_White : FlareCore {
		brightness = 999999;
		intensity = 999999;
		lightColor[] = {0.95,0.95,1,0.5};
		smokeColor[] = {1,1,1,0.5};
		timeToLive = 70;
	};
};