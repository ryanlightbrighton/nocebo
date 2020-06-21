// BOATS

class Ship;
class Ship_F : Ship {
	// class InteractionInfo : InteractionInfo {
	// 	class pushObject : pushObject {
	// 		text = "Push boat";
	// 		tooltip	= "'Give boat a' + endl + 'shove to free it' + endl + 'from the ground'";
	// 	};
	// };
};
class Boat_F;
class SDV_01_base_F;
class O_SDV_01_F;
class Rubber_duck_base_F;
class Boat_Armed_01_base_F;
class Boat_Armed_01_minigun_base_F;

// PATROL BOATS

class I_Boat_Armed_01_minigun_F : Boat_Armed_01_minigun_base_F {
	class AnimationSources;
	class Turrets;
	class MainTurret;
	class FrontTurret;
	class RearTurret;
};
class ncb_boat_speedboat_minigun : I_Boat_Armed_01_minigun_F {
	author = "Das Attorney";
	crew = "Horde_diverUnit";
	faction = "ncb_antagonists";
	hiddenselectionstextures[] = {"\A3\boat_f\Boat_Armed_01\data\Boat_Armed_01_ext_opfor_co.paa","\A3\boat_f\Boat_Armed_01\data\Boat_Armed_01_int_opfor_co.paa","\A3\boat_f\Boat_Armed_01\data\Boat_Armed_01_crows_OPFOR_co.paa"};
	scope = 2;
	side = 0;
	typicalCargo[] = {"Horde_diverUnit"};
	class AnimationSources : AnimationSources {
        class muzzle2_source {
            source = "reload";
            weapon = "M134_minigun_land";
        };
        class muzzle2_source_rot {
            source = "ammorandom";
            weapon = "M134_minigun_land";
        };
        class ReloadAnim {
            source = "reload";
            weapon = "M134_minigun_land";
        };
        class ReloadMagazine {
            source = "reloadmagazine";
            weapon = "M134_minigun_land";
        };
        class Revolving {
            source = "revolving";
            weapon = "M134_minigun_land";
        };
    };
	class Turrets : Turrets {
		class FrontTurret : FrontTurret {};
		class RearTurret : RearTurret {
			weapons[] = {"M134_minigun_land"};
			magazines[] = {"ncb_mag_762x51_2000_g"};
		};
	};
	class VehicleInteractionInfo : VehicleInteractionInfo {
		class Chassis : Chassis {
			location[] = {"HitBody","HitTurret","HitGun"};
			modelposition[] = {0,6.375,-1.42};
		};
		class Engine : Engine {
			modelposition[] = {0,-5.143,-2.25};
		};
	};
	class TransportItems {};
	class TransportWeapons {};
	class TransportMagazines {};
	class TransportBackpacks {};
};
class O_Boat_Armed_01_hmg_F : Boat_Armed_01_base_F {
	class AnimationSources;
	class Turrets;
	class MainTurret;
	class FrontTurret;
	class RearTurret;
};
class ncb_boat_speedboat_hmg : O_Boat_Armed_01_hmg_F {
	author = "Das Attorney";
	crew = "Horde_diverUnit";
	faction = "ncb_antagonists";
	scope = 2;
	typicalCargo[] = {"Horde_diverUnit"};
	class AnimationSources : AnimationSources {
        class muzzle2_source {
            source = "reload";
            weapon = "ncb_weap_127x108_hmg_boat_200";
        };
        class muzzle2_source_rot {
            source = "ammorandom";
            weapon = "ncb_weap_127x108_hmg_boat_200";
        };
        class ReloadAnim {
            source = "reload";
            weapon = "ncb_weap_127x108_hmg_boat_200";
        };
        class ReloadMagazine {
            source = "reloadmagazine";
            weapon = "ncb_weap_127x108_hmg_boat_200";
        };
        class Revolving {
            source = "revolving";
            weapon = "ncb_weap_127x108_hmg_boat_200";
        };
    };
	class Turrets : Turrets {
		class FrontTurret : FrontTurret {};
		class RearTurret : RearTurret {
			magazines[] = {"ncb_mag_127x108_200","ncb_mag_127x108_200","ncb_mag_127x108_200"};
			weapons[] = {"ncb_weap_127x108_hmg_boat_200"};
		};
	};
	class VehicleInteractionInfo : VehicleInteractionInfo {
		class Chassis : Chassis {
			location[] = {"HitBody","HitTurret","HitGun"};
			modelposition[] = {0,6.375,-1.42};
		};
		class Engine : Engine {
			modelposition[] = {0,-5.143,-2.25};
		};
	};
	class TransportItems {};
	class TransportWeapons {};
	class TransportMagazines {};
	class TransportBackpacks {};
};

// INFLATABLE

class ncb_boat_inflatable : Rubber_duck_base_F {
	author = "Das Attorney";
	crew = "Horde_diverUnit";
	enginePower = 26;
	faction = "ncb_antagonists";
	insideSoundCoef = 1;
	rudderForceCoef = 0.25;
	scope = 2;
	side = 0;
	thrustDelay = 1.5;
	typicalcargo[] = {"Horde_diverUnit"};
	class VehicleInteractionInfo : VehicleInteractionInfo {
		class Chassis : Chassis {
			location[] = {"HitBody"};
			modelposition[] = {0,2.288,-0.559};
		};
		class Engine : Engine {
			modelposition[] = {0,-2.112,-0.559};
		};
	};
	class TransportItems {};
	class TransportWeapons {};
	class TransportMagazines {};
	class TransportBackpacks {};
};

// RHIB

class I_C_Boat_Transport_02_F;
class ncb_boat_rhib : I_C_Boat_Transport_02_F {
	author = "Das Attorney";
	crew = "Horde_diverUnit";
	faction = "ncb_antagonists";
	hiddenSelectionsTextures[] = {
		"a3\boat_f_exp\boat_transport_02\data\boat_transport_02_exterior_co.paa",
    	"a3\boat_f_exp\boat_transport_02\data\boat_transport_02_interior_2_co.paa"
	};
	rudderForceCoef = 0.17;
	typicalcargo[] = {"Horde_diverUnit"};
	class VehicleInteractionInfo : VehicleInteractionInfo {
		class Chassis : Chassis {
			location[] = {"HitHull"};
			modelposition[] = {0,3.434,-0.133};
		};
		class Engine : Engine {
			modelposition[] = {0,-2.737,-0.433};
		};
	};
	class TransportItems {};
	class TransportWeapons {};
	class TransportMagazines {};
	class TransportBackpacks {};
};

// SDV

class ncb_boat_sdv : O_SDV_01_F {
	author = "Das Attorney";
	crew = "Horde_diverUnit";
	faction = "ncb_antagonists";
	scope = 2;
	typicalCargo[] = {"Horde_diverUnit"};
	// unloadincombat = 1;
	class VehicleInteractionInfo : VehicleInteractionInfo {
		class Chassis : Chassis {
			location[] = {"HitBody","HitTurret","HitGun"};
			modelposition[] = {0,1.788,-0.701};
		};
		class Engine : Engine {
			modelposition[] = {0,-3.413,-0.871};
		};
	};
	class TransportItems {};
	class TransportWeapons {};
	class TransportMagazines {};
	class TransportBackpacks {};
};

// civvie boats

class C_Boat_Civil_01_F;
class ncb_boat_motorboat : C_Boat_Civil_01_F {
	author = "Das Attorney";
	crew = "Horde_diverUnit";
	scope = 2;
	typicalCargo[] = {"Horde_diverUnit"};
	class VehicleInteractionInfo : VehicleInteractionInfo {
		class Chassis : Chassis {
			location[] = {"HitHull"};
			modelposition[] = {0,3.39,-0.113};
		};
		class Engine : Engine {
			location[] = {"HitEngine1","HitEngine2","HitEngine"};
			modelposition[] = {0,-2.737,-0.633};
		};
	};
	class TransportItems {};
	class TransportWeapons {};
	class TransportMagazines {};
	class TransportBackpacks {};
};
class C_Boat_Civil_01_rescue_F;
class ncb_boat_motorboat_rescue : C_Boat_Civil_01_rescue_F {
	author = "Das Attorney";
	crew = "Horde_diverUnit";
	scope = 2;
	typicalCargo[] = {"Horde_diverUnit"};
	class VehicleInteractionInfo : VehicleInteractionInfo {
		class Chassis : Chassis {
			location[] = {"HitHull"};
			modelposition[] = {0,3.39,-0.113};
		};
		class Engine : Engine {
			location[] = {"HitEngine1","HitEngine2","HitEngine"};
			modelposition[] = {0,-2.737,-0.633};
		};
	};
	class TransportItems {};
	class TransportWeapons {};
	class TransportMagazines {};
	class TransportBackpacks {};
};
class C_Boat_Civil_01_police_F;
class ncb_boat_motorboat_police : C_Boat_Civil_01_police_F {
	author = "Das Attorney";
	crew = "Horde_diverUnit";
	scope = 2;
	typicalCargo[] = {"Horde_diverUnit"};
	class VehicleInteractionInfo : VehicleInteractionInfo {
		class Chassis : Chassis {
			location[] = {"HitHull"};
			modelposition[] = {0,3.39,-0.113};
		};
		class Engine : Engine {
			location[] = {"HitEngine1","HitEngine2","HitEngine"};
			modelposition[] = {0,-2.737,-0.633};
		};
	};
	class TransportItems {};
	class TransportWeapons {};
	class TransportMagazines {};
	class TransportBackpacks {};
};
class C_Scooter_Transport_01_F;
class ncb_boat_jetski : C_Scooter_Transport_01_F {
	author = "Das Attorney";
	crew = "Horde_diverUnit";
	scope = 2;
	typicalCargo[] = {"Horde_diverUnit"};
	class VehicleInteractionInfo : VehicleInteractionInfo {
		class Chassis : Chassis {
			location[] = {"HitBody"};
			modelposition[] = {0,1.59,-0.804};
		};
		class Engine : Engine {
			modelposition[] = {0,-1.273,-1.014};
		};
	};
	class TransportItems {};
	class TransportWeapons {};
	class TransportMagazines {};
	class TransportBackpacks {};
};