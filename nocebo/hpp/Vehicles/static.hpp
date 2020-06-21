// STATIC WEAPONS

class HMG_01_base_F;
class O_HMG_01_F : HMG_01_base_F {
	class AssembleInfo;
	class Turrets;
	class MainTurret;
	class AnimationSources;
};
class ncb_static_hmg_low : O_HMG_01_F {
	horde_actionSound = "horde_sound_vehicleAmmo";
	author = "Das Attorney";
	crew = "Horde_gunmanUnit";
	displayName = "DShK 12.7x108mm";
	faction = "ncb_antagonists";
	class AnimationSources : AnimationSources {
		class autonomous_unhide {
			animPeriod = 1e-006;
			initPhase = 0;
			source = "user";
		};
		class muzzle_source {
			source = "reload";
			weapon = "ncb_weap_127x108_hmg_static_100";
		};
		class muzzle_source_rot {
			source = "ammorandom";
			weapon = "ncb_weap_127x108_hmg_static_100";
		};
		class ReloadAnim {
			source = "reload";
			weapon = "ncb_weap_127x108_hmg_static_100";
		};
		class ReloadMagazine {
			source = "reloadmagazine";
			weapon = "ncb_weap_127x108_hmg_static_100";
		};
		class Revolving {
			source = "revolving";
			weapon = "ncb_weap_127x108_hmg_static_100";
		};
	};
	class AssembleInfo : AssembleInfo {
		dissasembleTo[] = {};
	};
	class InteractionInfo : InteractionInfo {
		class disassemble : disassemble {
			// output[] = {"ncb_weaponbag_hmg_low","ncb_weaponbag_tripod"};
			output[] = {"ncb_weaponbag_hmg_low"};
			text = "Disassemble weapon";
			tooltip	= "'Break weapon down' + endl + 'into backpack' + endl + 'and ammo'";
		};
		class dragObject : dragObject {
			text = "Drag HMG";
			tooltip	= "'Drag static weapon'";
		};
		class getInGunner : getInGunner {
			text = "Get in HMG";
			tooltip	= "'Get in' + endl + 'static weapon'";
		};
		class reloadMenu : reloadMenu {};
		class rotateL : rotateL {};
		class rotateR : rotateR {};
	};
	class Turrets : Turrets {
		class MainTurret : MainTurret {
			magazines[] = {"ncb_mag_127x108_100"};
			weapons[] = {"ncb_weap_127x108_hmg_static_100"};
		};
	};
};
class HMG_01_high_base_F;
class O_HMG_01_high_F : HMG_01_high_base_F {
	class Turrets;
	class MainTurret;
	class AnimationSources;
};
class ncb_static_hmg_high : O_HMG_01_high_F {
	horde_actionSound = "horde_sound_vehicleAmmo";
	author = "Das Attorney";
	crew = "Horde_gunmanUnit";
	displayName = "DShK 12.7x108mm (High)";
	faction = "ncb_antagonists";
	class AnimationSources : AnimationSources {
		class autonomous_unhide {
			animPeriod = 1e-006;
			initPhase = 0;
			source = "user";
		};
		class muzzle_source {
			source = "reload";
			weapon = "ncb_weap_127x108_hmg_static_100";
		};
		class muzzle_source_rot {
			source = "ammorandom";
			weapon = "ncb_weap_127x108_hmg_static_100";
		};
		class ReloadAnim {
			source = "reload";
			weapon = "ncb_weap_127x108_hmg_static_100";
		};
		class ReloadMagazine {
			source = "reloadmagazine";
			weapon = "ncb_weap_127x108_hmg_static_100";
		};
		class Revolving {
			source = "revolving";
			weapon = "ncb_weap_127x108_hmg_static_100";
		};
	};
	class AssembleInfo {
		assembleTo = "";
		base = "";
		displayName = "";
		dissasembleTo[] = {};
		primary = 0;
	};
	class InteractionInfo : InteractionInfo {
		class disassemble : disassemble {
			// output[] = {"ncb_weaponbag_hmg_high","ncb_weaponbag_tripod"};
			output[] = {"ncb_weaponbag_hmg_high"};
			text = "Disassemble weapon";
			tooltip	= "'Break weapon down' + endl + 'into backpack' + endl + 'and ammo'";
		};
		class dragObject : dragObject {
			text = "Drag HMG";
			tooltip	= "'Drag static weapon'";
		};
		class getInGunner : getInGunner {
			text = "Get in HMG";
			tooltip	= "'Get in' + endl + 'static weapon'";
		};
		class reloadMenu : reloadMenu {};
		class rotateL : rotateL {};
		class rotateR : rotateR {};
	};
	class Turrets : Turrets {
		class MainTurret : MainTurret {
			magazines[] = {"ncb_mag_127x108_100"};
			weapons[] = {"ncb_weap_127x108_hmg_static_100"};
		};
	};
};

class AA_01_base_F;
class O_static_AA_F : AA_01_base_F {
	class AnimationSources;
	class Turrets;
	class MainTurret;
};
class ncb_static_aa : O_static_AA_F {
	horde_actionSound = "horde_sound_vehicleAmmo";
	author = "Das Attorney";
	crew = "Horde_gunmanUnit";
	displayname = "Titan Launcher (AA)";
	faction = "ncb_antagonists";
	// class AnimationSources : AnimationSources {
	// 	class autonomous_unhide {
	// 		source = "user";
	// 		animPeriod = 1e-006;
	// 		initPhase = 0;
	// 	};
	// 	class muzzle_source {
	// 		source = "reload";
	// 		weapon = "horde_static_AA_launcher";
	// 	};
	// 	class muzzle_source_rot {
	// 		source = "ammorandom";
	// 		weapon = "horde_static_AA_launcher";
	// 	};
	// 	class ReloadAnim {
	// 		source = "reload";
	// 		weapon = "horde_static_AA_launcher";
	// 	};
	// 	class ReloadMagazine {
	// 		source = "reloadmagazine";
	// 		weapon = "horde_static_AA_launcher";
	// 	};
	// 	class Revolving {
	// 		source = "revolving";
	// 		weapon = "horde_static_AA_launcher";
	// 	};
	// };
	class AssembleInfo {
		assembleTo = "";
		base = "";
		displayName = "";
		dissasembleTo[] = {};
		primary = 0;
	};
	class InteractionInfo : InteractionInfo {
		class disassemble : disassemble {
			// output[] = {"ncb_weaponbag_aa","ncb_weaponbag_tripod"};
			output[] = {"ncb_weaponbag_aa"};
			text = "Disassemble weapon";
			tooltip	= "'Break weapon down' + endl + 'into backpack' + endl + 'and ammo'";
		};
		class dragObject : dragObject {
			text = "Drag launcher";
			tooltip	= "'Drag static weapon'";
		};
		class getInGunner : getInGunner {
			text = "Get in launcher";
			tooltip	= "'Get in' + endl + 'static weapon'";
		};
		class reloadMenu : reloadMenu {};
		class rotateL : rotateL {};
		class rotateR : rotateR {};
	};
	class Turrets : Turrets {
		class MainTurret : MainTurret {
			maxTurn = 360;
			// magazines[] = {"Titan_AA"};
			minTurn = -360;
			// weapons[] = {"horde_static_AA_launcher"};
			// class ViewOptics : ViewOptics {
			// 	visionmode[] = {"Normal","NVG"};
			// };
		};
	};
};

class AT_01_base_F;
class O_static_AT_F : AT_01_base_F {
	class AnimationSources;
	class Turrets;
	class MainTurret;
};
class ncb_static_at : O_static_AT_F {
	horde_actionSound = "horde_sound_vehicleAmmo";
	author = "Das Attorney";
	crew = "Horde_gunmanUnit";
	displayname = "Titan Launcher (AT)";
	faction = "ncb_antagonists";
	// class AnimationSources : AnimationSources {
	// 	class autonomous_unhide {
	// 		source = "user";
	// 		animPeriod = 1e-006;
	// 		initPhase = 0;
	// 	};
	// 	class muzzle_source {
	// 		source = "reload";
	// 		weapon = "horde_static_AT_launcher";
	// 	};
	// 	class muzzle_source_rot {
	// 		source = "ammorandom";
	// 		weapon = "horde_static_AT_launcher";
	// 	};
	// 	class ReloadAnim {
	// 		source = "reload";
	// 		weapon = "horde_static_AT_launcher";
	// 	};
	// 	class ReloadMagazine {
	// 		source = "reloadmagazine";
	// 		weapon = "horde_static_AT_launcher";
	// 	};
	// 	class Revolving {
	// 		source = "revolving";
	// 		weapon = "horde_static_AT_launcher";
	// 	};
	// };
	class AssembleInfo {
		assembleTo = "";
		base = "";
		displayName = "";
		dissasembleTo[] = {};
		primary = 0;
	};
	class InteractionInfo : InteractionInfo {
		class disassemble : disassemble {
			// output[] = {"ncb_weaponbag_at","ncb_weaponbag_tripod"};
			output[] = {"ncb_weaponbag_at"};
			text = "Disassemble weapon";
			tooltip	= "'Break weapon down' + endl + 'into backpack' + endl + 'and ammo'";
		};
		class dragObject : dragObject {
			text = "Drag weapon";
			tooltip	= "'Drag static weapon'";
		};
		class getInGunner : getInGunner {
			text = "Get in launcher";
			tooltip	= "'Get in' + endl + 'static weapon'";
		};
		class reloadMenu : reloadMenu {};
		class rotateL : rotateL {};
		class rotateR : rotateR {};
	};
	class Turrets : Turrets {
		class MainTurret : MainTurret {
			// magazines[] = {"Titan_AT"};
			// weapons[] = {"horde_static_AT_launcher"};
		};
	};
};

class GMG_01_base_F;
class O_GMG_01_F : GMG_01_base_F {
	class Turrets;
	class MainTurret;
};
class ncb_static_gmg_low : O_GMG_01_F {
	horde_actionSound = "horde_sound_vehicleAmmo";
	author = "Das Attorney";
	crew = "Horde_gunmanUnit";
	displayName = "AGS-30 20mm";
	faction = "ncb_antagonists";
	class AssembleInfo {
		assembleTo = "";
		base = "";
		displayName = "";
		dissasembleTo[] = {};
		primary = 0;
	};
	class InteractionInfo : InteractionInfo {
		class disassemble : disassemble {
			// output[] = {"ncb_weaponbag_gmg_low","ncb_weaponbag_tripod"};
			output[] = {"ncb_weaponbag_gmg_low"};
			text = "Disassemble weapon";
			tooltip	= "'Break weapon down' + endl + 'into backpack' + endl + 'and ammo'";
		};
		class dragObject : dragObject {
			text = "Drag GMG";
			tooltip	= "'Drag static weapon'";
		};
		class getInGunner : getInGunner {
			text = "Get in GMG";
			tooltip	= "'Get in' + endl + 'static weapon'";
		};
		class reloadMenu : reloadMenu {};
		class rotateL : rotateL {};
		class rotateR : rotateR {};
	};
	class Turrets : Turrets {
		class MainTurret : MainTurret {
			magazines[] = {"40Rnd_20mm_g_belt"};
		};
	};
};

class GMG_01_high_base_F;
class O_GMG_01_high_F : GMG_01_high_base_F {
	class Turrets;
	class MainTurret;
};
class ncb_static_gmg_high : O_GMG_01_high_F {
	horde_actionSound = "horde_sound_vehicleAmmo";
	author = "Das Attorney";
	crew = "Horde_gunmanUnit";
	displayName = "AGS-30 20mm (high)";
	faction = "ncb_antagonists";
	class AssembleInfo {
		assembleTo = "";
		base = "";
		displayName = "";
		dissasembleTo[] = {};
		primary = 0;
	};
	class InteractionInfo : InteractionInfo {
		class disassemble : disassemble {
			// output[] = {"ncb_weaponbag_gmg_high","ncb_weaponbag_tripod"};
			output[] = {"ncb_weaponbag_gmg_high"};
			text = "Disassemble weapon";
			tooltip	= "'Break weapon down' + endl + 'into backpack' + endl + 'and ammo'";
		};
		class dragObject : dragObject {
			text = "Drag GMG";
			tooltip	= "'Drag static weapon'";
		};
		class getInGunner : getInGunner {
			text = "Get in GMG";
			tooltip	= "'Get in' + endl + 'static weapon'";
		};
		class reloadMenu : reloadMenu {};
		class rotateL : rotateL {};
		class rotateR : rotateR {};
	};
	class Turrets : Turrets {
		class MainTurret : MainTurret {
			magazines[] = {"40Rnd_20mm_g_belt"};
		};
	};
};

class O_GMG_01_A_F;
class ncb_static_gmg_drone : O_GMG_01_A_F {
	horde_actionSound = "horde_sound_vehicleAmmo";
	author = "Das Attorney";
	displayName = "AGS-30 20mm (sentry)";
	faction = "ncb_antagonists";
};

class Mortar_01_base_F;
class O_Mortar_01_F : Mortar_01_base_F {
	class Turrets;
	class MainTurret;
};

class ncb_static_mortar : O_Mortar_01_F {
	horde_actionSound = "horde_sound_vehicleAmmo";
	author = "Das Attorney";
	cost = 149000;
	crew = "Horde_gunmanUnit";
	displayname = "2B14 Podnos";
	faction = "ncb_antagonists";
	class AssembleInfo {
		assembleTo = "";
		base = "";
		displayName = "";
		dissasembleTo[] = {};
		primary = 0;
	};
	class InteractionInfo : InteractionInfo {
		class disassemble : disassemble {
			output[] = {"ncb_weaponbag_mortar"};
			text = "Disassemble mortar";
			tooltip	= "'Break weapon down' + endl + 'into backpack' + endl + 'and shells'";
		};
		class dragObject : dragObject {
			text = "Drag mortar";
			tooltip	= "'Drag static weapon'";
		};
		class getInGunner : getInGunner {
			text = "Get in mortar";
			tooltip	= "'Get in' + endl + 'static weapon'";
		};
		class reloadMenu : reloadMenu {};
		class rotateL : rotateL {};
		class rotateR : rotateR {};
	};
	class Turrets : Turrets {
		class MainTurret : MainTurret {
			magazines[] = {
				"8Rnd_82mm_Mo_shells",
				"8Rnd_82mm_Mo_Flare_white",
				"8Rnd_82mm_Mo_Smoke_white"
			};
		};
	};
};

// AA turrets

class B_AAA_System_01_F;
class ncb_static_goalkeeper_system : B_AAA_System_01_F {
	author = "Das Attorney";
	crew = "Horde_UAV_AI";
	faction = "ncb_antagonists";
	side = 0;
	typicalCargo[] = {"Horde_UAV_AI"};
};

class B_SAM_System_01_F;
class ncb_static_spartan_system : B_SAM_System_01_F {
	author = "Das Attorney";
	crew = "Horde_UAV_AI";
	faction = "ncb_antagonists";
	side = 0;
	typicalCargo[] = {"Horde_UAV_AI"};
};

// THIS ONE IS SHIT AND WILL NOT FIRE FOR SOME REASON

// class B_SAM_System_02_F;
// class ncb_static_centurion_system : B_SAM_System_02_F {
// 	author = "Das Attorney";
// 	crew = "Horde_UAV_AI";
// 	faction = "ncb_antagonists";
// 	side = 0;
// 	typicalCargo[] = {"Horde_UAV_AI"};
// };