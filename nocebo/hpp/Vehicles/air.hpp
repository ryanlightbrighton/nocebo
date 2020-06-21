// HELICOPTERS

class Air;
class Helicopter : Air {
	class EventHandlers : DefaultEventHandlers {
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
};
class Helicopter_Base_F : Helicopter {
	horde_primWeapMinCalLevel = 2;
};

class Heli_Light_02_base_F;
class O_Heli_Light_02_F : Heli_Light_02_base_F {
	class AnimationSources;
};

class ncb_heli_orca : O_Heli_Light_02_F {
	author = "Das Attorney";
	crew = "Horde_gunmanUnit";
	ejectDeadCargo = 0;
	faction = "ncb_antagonists";
	magazines[] = {"ncb_mag_762x51_1000_g_air","12Rnd_PG_missiles","168Rnd_CMFlare_Chaff_Magazine"};
	typicalCargo[] = {"Horde_gunmanUnit"};
	weapons[] = {"M134_minigun_air_L","missiles_DAGR","CMFlareLauncher"};
	class AnimationSources : AnimationSources {
		class Gatling {
			source = "revolving";
			weapon = "M134_minigun_air_L";
		};
		class Gatling_flash {
			source = "ammorandom";
			weapon = "M134_minigun_air_L";
		};
	};
	class VehicleInteractionInfo : VehicleInteractionInfo {
		class Avionics : Avionics {
			location[] = {"HitAvionics","HitPitotTube","HitStaticPort","HitLight"};
			modelposition[] = {-0.00720215,5.6333,-1.39157};
		};
		class Chassis : Chassis {
			location[] = {"HitHull","HitHydraulics","HitGear","HitTail","HitHStabilizerL1","HitHStabilizerR1","HitVStabilizer1","HitMissiles","HitTurret","HitGun"};
			modelposition[] = {0.959106,1.63525,-1.17957};
		};
		class Engine : Engine {
			location[] = {"HitEngine1","HitEngine2","HitEngine","HitEngine3","HitStarter1","HitStarter2","HitStarter3","HitTransmission"};
			modelposition[] = {0,-2.19971,0.325653};
		};
		class FuelTank: FuelTank {
			modelposition[] = {-0.959106,1.63525,-1.17957};
		};
		class MainRotor : MainRotor {
			modelposition[] = {0.738647,-1.46094,-0.815063};
		};
		class TailRotor : TailRotor {
			modelposition[] = {-0.344727,-6.62402,-0.264069};
		};
		class Winch : Winch {
			modelposition[] = {-0.69104,-1.45654,-0.815338};
		};
	};
	class TransportItems {};
	class TransportWeapons {};
	class TransportMagazines {};
	class TransportBackpacks {};
};
class Heli_Light_02_unarmed_base_F;
class O_Heli_Light_02_unarmed_F : Heli_Light_02_unarmed_base_F {};
class ncb_heli_orca_unarmed : O_Heli_Light_02_unarmed_F {
	author = "Das Attorney";
	crew = "Horde_gunmanUnit";
	ejectDeadCargo = 0;
	faction = "ncb_antagonists";
	typicalCargo[] = {"Horde_gunmanUnit"};
	class VehicleInteractionInfo : VehicleInteractionInfo {
		class Avionics : Avionics {
			location[] = {"HitAvionics","HitPitotTube","HitStaticPort","HitLight"};
			modelposition[] = {-0.00720215,5.6333,-1.39157};
		};
		class Chassis : Chassis {
			location[] = {"HitHull","HitHydraulics","HitGear","HitTail","HitHStabilizerL1","HitHStabilizerR1","HitVStabilizer1"};
			modelposition[] = {0.959106,1.63525,-1.17957};
		};
		class Engine : Engine {
			location[] = {"HitEngine1","HitEngine2","HitEngine","HitEngine3","HitStarter1","HitStarter2","HitStarter3","HitTransmission"};
			modelposition[] = {0,-2.19971,0.325653};
		};
		class FuelTank: FuelTank {
			modelposition[] = {-0.959106,1.63525,-1.17957};
		};
		class MainRotor : MainRotor {
			modelposition[] = {0.738647,-1.46094,-0.815063};
		};
		class TailRotor : TailRotor {
			modelposition[] = {-0.344727,-6.62402,-0.264069};
		};
		class Winch : Winch {
			modelposition[] = {-0.69104,-1.45654,-0.815338};
		};
	};
	class TransportItems {};
	class TransportWeapons {};
	class TransportMagazines {};
	class TransportBackpacks {};
};
class Heli_Attack_02_base_F;
class O_Heli_Attack_02_F : Heli_Attack_02_base_F {
	class Turrets;
	class MainTurret;
};

class ncb_heli_kajman : O_Heli_Attack_02_F {
	author = "Das Attorney";
	crew = "Horde_gunmanUnit";
	ejectDeadCargo = 0;
	faction = "ncb_antagonists";
	typicalCargo[] = {"Horde_gunmanUnit"};
	class VehicleInteractionInfo : VehicleInteractionInfo {
		class Avionics : Avionics {
			location[] = {"HitAvionics","HitPitotTube","HitStaticPort","HitLight"};
			modelposition[] = {0,5.93311,-1.2004};
		};
		class Chassis : Chassis {
			location[] = {"HitHull","HitHydraulics","HitGear","HitTail","HitHStabilizerL1","HitHStabilizerR1","HitVStabilizer1","HitMissiles","HitTurret","HitGun"};
			modelposition[] = {0.805786,3.22852,-1.37297};
		};
		class Engine : Engine {
			location[] = {"HitEngine1","HitEngine2","HitEngine","HitEngine3","HitStarter1","HitStarter2","HitStarter3","HitTransmission"};
			modelposition[] = {0,-2.44287,-0.393082};
		};
		class FuelTank: FuelTank {
			modelposition[] = {-0.823853,3.22852,-1.3715};
		};
		class MainRotor : MainRotor {
			modelposition[] = {0.88562,-1.47412,-1.62405};
		};
		class TailRotor : TailRotor {
			modelposition[] = {0,-7.61621,-1.65924};
		};
		class Winch : Winch {
			modelposition[] = {-0.883911,-1.47412,-1.62246};
		};
	};
	class TransportItems {};
	class TransportWeapons {};
	class TransportMagazines {};
	class TransportBackpacks {};
};
class O_Heli_Attack_02_black_F : Heli_Attack_02_base_F {
	class Turrets;
	class MainTurret;
};
class ncb_heli_kajman_black : O_Heli_Attack_02_black_F {
	author = "Das Attorney";
	crew = "Horde_gunmanUnit";
	ejectDeadCargo = 0;
	faction = "ncb_antagonists";
	radartype = 0;
	typicalCargo[] = {"Horde_gunmanUnit"};
	class VehicleInteractionInfo : VehicleInteractionInfo {
		class Avionics : Avionics {
			location[] = {"HitAvionics","HitPitotTube","HitStaticPort","HitLight"};
			modelposition[] = {0,5.93311,-1.2004};
		};
		class Chassis : Chassis {
			location[] = {"HitHull","HitHydraulics","HitGear","HitTail","HitHStabilizerL1","HitHStabilizerR1","HitVStabilizer1","HitMissiles","HitTurret","HitGun"};
			modelposition[] = {0.805786,3.22852,-1.37297};
		};
		class Engine : Engine {
			location[] = {"HitEngine1","HitEngine2","HitEngine","HitEngine3","HitStarter1","HitStarter2","HitStarter3","HitTransmission"};
			modelposition[] = {0,-2.44287,-0.393082};
		};
		class FuelTank: FuelTank {
			modelposition[] = {-0.823853,3.22852,-1.3715};
		};
		class MainRotor : MainRotor {
			modelposition[] = {0.88562,-1.47412,-1.62405};
		};
		class TailRotor : TailRotor {
			modelposition[] = {0,-7.61621,-1.65924};
		};
		class Winch : Winch {
			modelposition[] = {-0.883911,-1.47412,-1.62246};
		};
	};
	class TransportItems {};
	class TransportWeapons {};
	class TransportMagazines {};
	class TransportBackpacks {};
};
// uprated miniguns
class Heli_Transport_01_base_F;
class B_Heli_Transport_01_F : Heli_Transport_01_base_F {
	class AnimationSources;
	class Turrets;
	class CopilotTurret;
	class MainTurret;
	class RightDoorGun;
};
class ncb_heli_ghostHawk : B_Heli_Transport_01_F {
	author = "Das Attorney";
	faction = "ncb_players";
	class AnimationSources : AnimationSources {
		class Door_L {
			source = "door";
			animPeriod = 1.6;
			initPhase = 0;
		};
		class Door_R : Door_L {
		};
		class Holder {
			source = "user";
			animPeriod = 1e-006;
			initPhase = 1;
		};
		class Gun_HRot {
			source = "user";
			animPeriod = 1e-006;
			initPhase = 0;
		};
		class Gun_VRot {
			source = "user";
			animPeriod = 1e-006;
			initPhase = 0;
		};
		class Minigun {
			source = "revolving";
			weapon = "M134_minigun_air_L";
		};
		class Muzzle_flash {
			source = "ammorandom";
			weapon = "M134_minigun_air_L";
		};
		class Minigun2 {
			source = "revolving";
			weapon = "M134_minigun_air_R";
		};
		class Muzzle_flash2 {
			source = "ammorandom";
			weapon = "M134_minigun_air_R";
		};
	};
	class Turrets : Turrets {
		class CopilotTurret : CopilotTurret {};
		class MainTurret : MainTurret {
			weapons[] = {"M134_minigun_air_L"};
			magazines[] = {"ncb_mag_762x51_1000_w_air"};
		};
		class RightDoorGun : RightDoorGun {
			weapons[] = {"M134_minigun_air_R"};
			magazines[] = {"ncb_mag_762x51_1000_w_air"};
		};
	};
	class TransportItems {};
	class TransportWeapons {};
	class TransportMagazines {};
	class TransportBackpacks {};
};

// need to maybe change weapons
class B_Heli_Light_01_armed_F;
class ncb_heli_pawnee : B_Heli_Light_01_armed_F {
	author = "Das Attorney";
	crew = "Horde_renegadeUnit";
	ejectDeadCargo = 0;
	faction = "ncb_renegades";
	side = 2;
	typicalCargo[] = {"Horde_renegadeUnit"};
	class TransportItems {};
	class TransportWeapons {};
	class TransportMagazines {};
	class TransportBackpacks {};
};

// scrappy port-ins for now....
class Heli_light_03_base_F;
class I_Heli_light_03_F : Heli_light_03_base_F {
	class AnimationSources;
};
class ncb_heli_hellcat : I_Heli_light_03_F {
	author = "Das Attorney";
	crew = "Horde_gunmanUnit";
	ejectDeadCargo = 0;
	faction = "ncb_antagonists";
	typicalCargo[] = {"Horde_gunmanUnit"};
	weapons[] = {"M134_minigun_air_L","missiles_DAR","CMFlareLauncher"};
	magazines[] = {"ncb_mag_762x51_5000_y_air","24Rnd_missiles","168Rnd_CMFlare_Chaff_Magazine"};
	class AnimationSources : AnimationSources {
		class GunL_Revolving {
			source = "revolving";
			weapon = "M134_minigun_air_L";
		};
		class GunR_Revolving : GunL_Revolving {
		};
		class muzzle_hide {
			source = "reload";
			weapon = "M134_minigun_air_L";
		};
		class Muzzle_Flash {
			source = "ammorandom";
			weapon = "M134_minigun_air_L";
			animPeriod = 1e-006;
		};
	};
	class VehicleInteractionInfo : VehicleInteractionInfo {
		class Avionics : Avionics {
			location[] = {"HitAvionics","HitPitotTube","HitStaticPort","HitLight"};
			modelposition[] = {-0.0020752,5.72314,-0.352159};
		};
		class Chassis : Chassis {
			location[] = {"HitHull","HitHydraulics","HitGear","HitTail","HitHStabilizerL1","HitHStabilizerR1","HitVStabilizer1","HitMissiles","HitTurret","HitGun"};
			modelposition[] = {0.988037,1.32275,-0.382154};
		};
		class Engine : Engine {
			location[] = {"HitEngine1","HitEngine2","HitEngine","HitEngine3","HitStarter1","HitStarter2","HitStarter3","HitTransmission"};
			modelposition[] = {0,-0.877441,0.71785};
		};
		class FuelTank: FuelTank {
			modelposition[] = {-0.988037,1.32275,-0.382154};
		};
		class MainRotor : MainRotor {
			modelposition[] = {0.578247,-0.677246,-0.382151};
		};
		class TailRotor : TailRotor {
			modelposition[] = {-0.521484,-6.229,1.24786};
		};
		class Winch : Winch {
			modelposition[] = {-0.578247,-0.677246,-0.382151};
		};
	};
	class TransportItems {};
	class TransportWeapons {};
	class TransportMagazines {};
	class TransportBackpacks {};
};
class I_Heli_Transport_02_F;
class ncb_heli_mohawk : I_Heli_Transport_02_F {
	author = "Das Attorney";
	crew = "Horde_gunmanUnit";
	ejectDeadCargo = 0;
	faction = "ncb_antagonists";
	typicalCargo[] = {"Horde_gunmanUnit"};
	class TransportItems {};
	class TransportWeapons {};
	class TransportMagazines {};
	class TransportBackpacks {};
};
class O_Heli_Transport_04_F;
class ncb_heli_taru : O_Heli_Transport_04_F {
	author = "Das Attorney";
	crew = "Horde_gunmanUnit";
	ejectDeadCargo = 0;
	faction = "ncb_antagonists";
	typicalCargo[] = {"Horde_gunmanUnit"};
	class EventHandlers {
		init = "if (local (_this select 0)) then {[_this select 0,"",[],false] call bis_fnc_initVehicle}";
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
		class Avionics : Avionics {
			location[] = {"HitAvionics","HitPitotTube","HitStaticPort","HitLight"};
			modelposition[] = {0,5.682,-1.926};
		};
		class Chassis : Chassis {
			location[] = {"HitHull","HitHydraulics","HitGear","HitTail","HitHStabilizerL1","HitHStabilizerR1","HitVStabilizer1","HitMissiles","HitTurret","HitGun"};
			modelposition[] = {1.272,3.682,-1.426};
		};
		class Engine : Engine {
			location[] = {"HitEngine1","HitEngine2","HitEngine","HitEngine3","HitStarter1","HitStarter2","HitStarter3","HitTransmission"};
			modelposition[] = {0,-2.03,-0.296};
		};
		class FuelTank: FuelTank {
			modelposition[] = {-1.272,3.682,-1.426};
		};
		class MainRotor : MainRotor {
			modelposition[] = {0,0.37,-0.596};
		};
		class TailRotor : TailRotor {
			modelposition[] = {-0.012,-8.531,-0.296};
		};
		class Winch : Winch {
			modelposition[] = {0,2.77,-1.426};
		};
	};
	class TransportItems {};
	class TransportWeapons {};
	class TransportMagazines {};
	class TransportBackpacks {};
};
class ncb_heli_taru_black : ncb_heli_taru {
	hiddenSelectionsTextures[] = {"A3\Air_F_Heli\Heli_Transport_04\Data\heli_transport_04_base_01_Black_co.paa","A3\Air_F_Heli\Heli_Transport_04\Data\heli_transport_04_base_02_Black_co.paa"};
	textureList[] = {"Black",1};
};
class Land_Pod_Heli_Transport_04_covered_F;
class ncb_pod_taru_transport : Land_Pod_Heli_Transport_04_covered_F {
	author = "Das Attorney";
	crew = "Horde_gunmanUnit";
	ejectDeadCargo = 0;
	faction = "ncb_antagonists";
	typicalCargo[] = {"Horde_gunmanUnit"};
	class TransportItems {};
	class TransportWeapons {};
	class TransportMagazines {};
	class TransportBackpacks {};
};
class ncb_pod_transport_black : ncb_pod_taru_transport {
	hiddenSelectionsTextures[] = {"A3\Air_F_Heli\Heli_Transport_04\Data\Heli_Transport_04_Pod_Ext01_Black_CO.paa","A3\Air_F_Heli\Heli_Transport_04\Data\Heli_Transport_04_Pod_Ext02_Black_CO.paa"};
	textureList[] = {"Black",1};
};

class Plane;
class UAV : Plane {};

class O_UAV_01_F;
class ncb_uav_tayran : O_UAV_01_F {
	author = "Das Attorney";
	crew = "Horde_UAV_AI";
	displayName = "Spotter UAV";
	faction = "ncb_antagonists";
	fuelCapacity = 400;
	// fuelConsumptionRate = 1;
	initScript = "";
	isuav = 0;
	simulation = "HelicopterX";
	class EventHandlers {
		class Nocebo {
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
};
class O_UAV_02_F;
class ncb_uav_ababil_missile : O_UAV_02_F {
	author = "Das Attorney";
	crew = "Horde_UAV_AI";
	displayName = "K39 Ababil-2 (CAS)";
	faction = "ncb_antagonists";
	// fuelConsumptionRate = 1;
	initScript = "";
	isuav = 0;
	simulation = "AirplaneX";
	class EventHandlers {
		class Nocebo {
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
};
class O_UAV_02_CAS_F;
class ncb_uav_ababil_bomb : O_UAV_02_CAS_F {
	author = "Das Attorney";
	crew = "Horde_UAV_AI";
	displayName = "K39 Ababil-2 (CAS)";
	faction = "ncb_antagonists";
	// fuelConsumptionRate = 1;
	initScript = "";
	isuav = 0;
	simulation = "AirplaneX";
	class EventHandlers {
		class Nocebo {
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
};

class O_T_VTOL_02_infantry_hex_F;
class ncb_vtol_xian_infantry : O_T_VTOL_02_infantry_hex_F {
	author = "Das Attorney";
	crew = "Horde_gunmanUnit";
	ejectDeadCargo = 0;
	faction = "ncb_antagonists";
	typicalCargo[] = {"Horde_gunmanUnit"};
	class TransportItems {};
	class TransportWeapons {};
	class TransportMagazines {};
	class TransportBackpacks {};
};

class O_T_VTOL_02_vehicle_hex_F;
class ncb_vtol_xian_vehicle : O_T_VTOL_02_vehicle_hex_F {
	author = "Das Attorney";
	crew = "Horde_gunmanUnit";
	ejectDeadCargo = 0;
	faction = "ncb_antagonists";
	typicalCargo[] = {"Horde_gunmanUnit"};
	class TransportItems {};
	class TransportWeapons {};
	class TransportMagazines {};
	class TransportBackpacks {};
};

class VTOL_Base_F;
class VTOL_01_base_F : VTOL_Base_F {
	class Components : Components {
		class SensorsManagerComponent {
			class Components {
				class ManSensorComponent : SensorTemplateMan {
					class GroundTarget {
						minRange = 2000;
						maxRange = 3000;
						objectDistanceLimitCoef = -1;
						viewDistanceLimitCoef = -1;
					};
					typeRecognitionDistance = 3000;
					angleRangeHorizontal = 360;
					angleRangeVertical = 180;
					nightRangeCoef = 1;
					maxFogSeeThrough= -1;
					groundNoiseDistanceCoef = -1;
					maxGroundNoiseDistance = -1;
					minSpeedThreshold = 0;
					animDirection = "cannon_barrel";
				};
				class IRSensorComponent : SensorTemplateIR {
					class AirTarget {
						minRange = 500;
						maxRange = 3000;
						objectDistanceLimitCoef = 1;
						viewDistanceLimitCoef = 1;
					};
					class GroundTarget {
						minRange = 500;
						maxRange = 3000;
						objectDistanceLimitCoef = 1;
						viewDistanceLimitCoef = 1;
					};
					maxTrackableSpeed = 300;
					angleRangeHorizontal = 45;
					angleRangeVertical = 35;
					animDirection = "Copilot_flir_V_rot";
				};
				class VisualSensorComponent : SensorTemplateVisual {
					class AirTarget {
						minRange = 500;
						maxRange = 3000;
						objectDistanceLimitCoef = 1;
						viewDistanceLimitCoef = 1;
					};
					class GroundTarget {
						minRange = 500;
						maxRange = 3000;
						objectDistanceLimitCoef = 1;
						viewDistanceLimitCoef = 1;
					};
					maxTrackableSpeed = 300;
					angleRangeHorizontal = 45;
					angleRangeVertical = 36;
					aimDown = 1;
					animDirection = "Copilot_flir_V_rot";
				};
				class ActiveRadarSensorComponent : SensorTemplateActiveRadar {
					class AirTarget {
						minRange = 4000;
						maxRange = 4000;
						objectDistanceLimitCoef = -1;
						viewDistanceLimitCoef = -1;
					};
					class GroundTarget {
						minRange = 4000;
						maxRange = 4000;
						objectDistanceLimitCoef = -1;
						viewDistanceLimitCoef = -1;
					};
					angleRangeHorizontal = 240;
					angleRangeVertical = 110;
					groundNoiseDistanceCoef = -1;
					maxGroundNoiseDistance = -1;
					minSpeedThreshold = 0;
					maxSpeedThreshold = 0;
					aimDown = 35;
				};
				class PassiveRadarSensorComponent : SensorTemplatePassiveRadar {
				};
				class LaserSensorComponent : SensorTemplateLaser {
					angleRangeHorizontal = 360;
					angleRangeVertical = 120;
					aimDown = 30;
				};
				class NVSensorComponent : SensorTemplateNV {
					angleRangeHorizontal = 360;
					angleRangeVertical = 120;
					aimDown = 30;
				};
			};
		};
		class VehicleSystemsDisplayManagerComponentLeft : DefaultVehicleSystemsDisplayManagerLeft {
			class Components {
				class EmptyDisplay {
					componentType = "EmptyDisplayComponent";
				};
				class MinimapDisplay {
					componentType = "MinimapDisplayComponent";
					resource = "RscCustomInfoMiniMap";
				};
				class CrewDisplay {
					componentType = "CrewDisplayComponent";
					resource = "RscCustomInfoCrew";
				};
				class UAVDisplay {
					componentType = "UAVFeedDisplayComponent";
				};
				class VehiclePrimaryGunnerDisplay {
					componentType = "TransportFeedDisplayComponent";
					source = "PrimaryGunner";
				};
				class SensorDisplay {
					componentType = "SensorsDisplayComponent";
					range[] = {4000};
					resource = "RscCustomInfoSensors";
				};
			};
		};
		class VehicleSystemsDisplayManagerComponentRight : DefaultVehicleSystemsDisplayManagerRight {
			defaultDisplay = "SensorDisplay";
			class Components {
				class EmptyDisplay {
					componentType = "EmptyDisplayComponent";
				};
				class MinimapDisplay {
					componentType = "MinimapDisplayComponent";
					resource = "RscCustomInfoMiniMap";
				};
				class CrewDisplay {
					componentType = "CrewDisplayComponent";
					resource = "RscCustomInfoCrew";
				};
				class UAVDisplay {
					componentType = "UAVFeedDisplayComponent";
				};
				class VehiclePrimaryGunnerDisplay {
					componentType = "TransportFeedDisplayComponent";
					source = "PrimaryGunner";
				};
				class SensorDisplay {
					componentType = "SensorsDisplayComponent";
					range[] = {4000};
					resource = "RscCustomInfoSensors";
				};
			};
		};
	};
};

class B_T_VTOL_01_armed_F;
class ncb_vtol_blackfish_gunship : B_T_VTOL_01_armed_F {
	author = "Das Attorney";
	faction = "ncb_players";
	class TransportItems {};
	class TransportWeapons {};
	class TransportMagazines {};
	class TransportBackpacks {};
};