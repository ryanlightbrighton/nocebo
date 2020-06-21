// class SFX is for sound sources in CfgVehicles

class CfgSFX {
	class AlarmSfx;
	class horde_sound_transformer_hum : AlarmSfx {
		Hum_1[] = {"\nocebo\sounds\hum",1,1,50,1,0,0,0};
		//soundName[] = {path to sound file, DB value, pitch multiplier, probability of being played, minimum delay, average delay, maximum delay after the sound};
		empty[] = {"",0,0,0,0,0,0,0};
		name = "horde_sound_transformer_hum";
		sounds[] = {"Hum_1"};
	};
	class horde_sound_transformer_plant : AlarmSfx {
		Plant_1[] = {"\nocebo\sounds\plant",1.2,1,50,1,0,0,0};
		empty[] = {"",0,0,0,0,0,0,0};
		name = "horde_sound_transformer_plant";
		sounds[] = {"Plant_1"};
	};
	class horde_sound_fan : AlarmSfx {
		// Fan_1[] = {"\nocebo\sounds\plant",0.8,1.7,25,1,0,0,0};
		Fan_1[] = {"\nocebo\sounds\fan",1,1,25,1,0,0,0};
		empty[] = {"",0,0,0,0,0,0,0};
		name = "horde_sound_fan";
		sounds[] = {"Fan_1"};
	};
	class horde_sound_flies : AlarmSfx {
		Flies[] = {"\nocebo\sounds\flies",1,1,25,1,0,0,0};
		empty[] = {"",0,0,0,0,0,0,0};
		name = "horde_sound_flies";
		sounds[] = {"Flies"};
	};
	// bullshit experimental generator

	class horde_sound_generator : AlarmSfx {
		TwoStrokeEngine[] = {"\nocebo\sounds\generator",8,1,150,1,0,0,0};
		empty[] = {"",0,0,0,0,0,0,0};
		name = "horde_sound_generator";
		sounds[] = {"TwoStrokeEngine"};
	};
};

// class SFX is for sound sources called from script (eg say3D/playSoundSource3D)

// http://resources.bisimulations.com/wiki/CfgSFX_Config_Reference

class CfgSounds {
	class Alarm;
	class horde_sound_stop : Alarm {
		name = "close";
		sound[] = {"\nocebo\sounds\stop",1.12202,1,300,1,0,0,0};
		titles[] = {};
	};
	class horde_sound_start : Alarm {
		name = "open";
		sound[] = {"\nocebo\sounds\start",1.12202,1,300,1,0,0,0};
		titles[] = {};
	};
	class horde_sound_hum : Alarm {
		name = "hum";
		sound[] = {"\nocebo\sounds\hum",1.12202,1,300,1,0,0,0};
		titles[] = {};
	};
	class horde_sound_plant : Alarm {
		name = "plant";
		sound[] = {"\nocebo\sounds\plant",1.12202,1,300,1,0,0,0};
		titles[] = {};
	};
	class horde_sound_fan : Alarm {
		name = "fan";
		sound[] = {"\nocebo\sounds\fan",1.2,1,23,1,0,0,0};
		titles[] = {};
	};
	class horde_sound_flies : Alarm {
		name = "flies";
		sound[] = {"\nocebo\sounds\flies",1.12202,1,15,1,0,0,0};
		titles[] = {};
	};
	class horde_sound_openDoorMetal : Alarm {
		name = "openDoorMetal";
		sound[] = {"\nocebo\sounds\open_metal_door_1",1.7,1,50,1,0,0,0};
		titles[] = {};
	};
	class horde_sound_openDoorSlide : Alarm {
		name = "openDoorSlide";
		sound[] = {"\nocebo\sounds\open_metal_door_1",1.7,1,50,1,0,0,0};
		titles[] = {};
	};
	class horde_sound_openDoorWood : Alarm {
		name = "openDoorWood";
		sound[] = {"\nocebo\sounds\open_wood_door",1.6,1,50,1,0,0,0};
		titles[] = {};
	};
	class horde_sound_closeDoorMetal : Alarm {
		name = "closeDoorMetal";
		sound[] = {"\nocebo\sounds\open_metal_door_1",1.7,1,50,1,0,0,0};
		titles[] = {};
	};
	class horde_sound_closeDoorSlide : Alarm {
		name = "closeDoorSlide";
		sound[] = {"\nocebo\sounds\open_metal_door_1",1.7,1,50,1,0,0,0};
		titles[] = {};
	};
	class horde_sound_closeDoorWood : Alarm {
		name = "closeDoorWood";
		sound[] = {"\nocebo\sounds\open_wood_door",1.6,1,50,1,0,0,0};
		titles[] = {};
	};
	class horde_sound_accessDenied : Alarm {
		name = "accessDenied";
		sound[] = {"\nocebo\sounds\access_denied",1.7,1,50,1,0,0,0};
		titles[] = {};
	};
	class horde_sound_eatFood : Alarm {
		name = "Eat";
		sound[] = {"\nocebo\sounds\eat.ogg",2,1,23,1,0,0,0};
		titles[] = {};
	};
	class horde_sound_drinkBottle : Alarm {
		name = "Drink bottle";
		sound[] = {"\nocebo\sounds\drink_canteen.ogg",2,1,23,1,0,0,0};
		titles[] = {};
	};
	class horde_sound_drinkCan : Alarm {
		name = "Drink can";
		sound[] = {"\nocebo\sounds\drink_can.ogg",2,1,23,1,0,0,0};
		titles[] = {};
	};
	class horde_sound_pitchTent : Alarm {
		name = "Pitch tent";
		sound[] = {"\nocebo\sounds\tent_pitch.ogg",2,1,23,1,0,0,0};
		titles[] = {};
	};
	class horde_sound_packTent : Alarm {
		name = "Pack Tent";
		sound[] = {"\nocebo\sounds\tent_pack.ogg",2,1,23,1,0,0,0};
		titles[] = {};
	};
	class horde_sound_firstAid : Alarm {
		name = "First aid";
		sound[] = {"\nocebo\sounds\first_aid.ogg",2,1,23,1,0,0,0};
		titles[] = {};
	};
	class horde_sound_bandage : Alarm {
		name = "Bandage";
		sound[] = {"\nocebo\sounds\bandage.ogg",2,1,23,1,0,0,0};
		titles[] = {};
	};
	class horde_sound_pills : Alarm {
		name = "Pills";
		sound[] = {"\nocebo\sounds\painkillers.ogg",10,1,23,1,0,0,0};
		titles[] = {};
	};
	class horde_sound_radioPianoMusic : Alarm {
		name = "Radio piano music";
		sound[] = {"\nocebo\sounds\radio_music_piano_static.ogg",1.5,1,23,1,0,0,0};
		titles[] = {};
	};
	class horde_sound_radioTransmissionRussian : Alarm {
		name = "Radio transmission Russian";
		sound[] = {"\nocebo\sounds\radio_transmission_russian.ogg",1.5,1,23,1,0,0,0};
		titles[] = {};
	};
	class horde_sound_radioTransmissionWombat : Alarm {
		name = "Radio transmission Wombat";
		sound[] = {"\nocebo\sounds\radio_transmission_wombat.ogg",1.5,1,23,1,0,0,0};
		titles[] = {};
	};
	class horde_sound_geigerLevel_0 : Alarm {
		name = "Geiger level 0";
		sound[] = {"\nocebo\sounds\geiger_level_0.ogg",1.5,1,23,1,0,0,0};
		titles[] = {};
	};
	class horde_sound_geigerLevel_1 : Alarm {
		name = "Geiger level 1";
		sound[] = {"\nocebo\sounds\geiger_level_1.ogg",1.5,1,23,1,0,0,0};
		titles[] = {};
	};
	class horde_sound_geigerLevel_2 : Alarm {
		name = "Geiger level 2";
		sound[] = {"\nocebo\sounds\geiger_level_2.ogg",1.5,1,23,1,0,0,0};
		titles[] = {};
	};
	class horde_sound_geigerLevel_3 : Alarm {
		name = "Geiger level 3";
		sound[] = {"\nocebo\sounds\geiger_level_3.ogg",1.5,1,23,1,0,0,0};
		titles[] = {};
	};
	class horde_sound_laptopFan : Alarm {
		name = "Laptop fan";
		sound[] = {"\nocebo\sounds\fan",1.3,1.4,10,1,0,0,0};
		titles[] = {};
	};
	class horde_sound_phoneVibrate : Alarm {
		name = "Phone Vibrate";
		sound[] = {"\nocebo\sounds\cell_ring_1.ogg",5,1,10,1,0,0,0};
		titles[] = {};
	};

	class horde_sound_startledBirds : Alarm {
		name = "Startled birds";
		sound[] = {"\nocebo\sounds\startledBirds",35,1,200,1,0,0,0};
		titles[] = {};
	};

	// inventory

	class horde_sound_grenadeInventory : Alarm {
		name = "Magazine Inventory";
		sound[] = {"\nocebo\sounds\inv_grenade",9,1,23,1,0,0,0};
		titles[] = {};
	};
	class horde_sound_gunInventory : Alarm {
		name = "Magazine Inventory";
		sound[] = {"\nocebo\sounds\inv_gun",3,1,23,1,0,0,0};
		titles[] = {};
	};
	class horde_sound_jerryCanInventory : Alarm {
		name = "Magazine Inventory";
		sound[] = {"\nocebo\sounds\inv_jerry_can",15,1,23,1,0,0,0};
		titles[] = {};
	};
	class horde_sound_linenInventory : Alarm {
		name = "Open Inventory";
		sound[] = {"\nocebo\sounds\inv_linen.ogg",15,1,23,1,0,0,0};
		titles[] = {};
	};
	class horde_sound_magazineBeltInventory : Alarm {
		name = "Magazine Inventory";
		sound[] = {"\nocebo\sounds\inv_belt",3,1,23,1,0,0,0};
		titles[] = {};
	};
	class horde_sound_magazineInventory : Alarm {
		name = "Magazine Inventory";
		sound[] = {"\nocebo\sounds\inv_mag1",3,1,23,1,0,0,0};
		titles[] = {};
	};
	class horde_sound_openInventory : Alarm {
		name = "Open Inventory";
		sound[] = {"\nocebo\sounds\inv_linen.ogg",15,1,23,1,0,0,0};
		titles[] = {};
	};

	// vehicle reload

	class horde_sound_vehicleAmmo : Alarm {
		name = "Ammo Interaction";
		sound[] = {"\nocebo\sounds\vehicleAmmo",3,1,23,1,0,0,0};
		titles[] = {};
	};

	// generator start and stop

	class horde_sound_generatorStart : Alarm {
		name = "Generator Start";
		sound[] = {"\nocebo\sounds\generator_start",8,1,150,1,0,0,0};
		titles[] = {};
	};
	class horde_sound_generatorStop : Alarm {
		name = "Generator Stop";
		sound[] = {"\nocebo\sounds\generator_stop",8,1,150,1,0,0,0};
		titles[] = {};
	};

	// wind turbines

	class horde_sound_windTurbine : Alarm {
		name = "Generator Stop";
		sound[] = {"\nocebo\sounds\wind_turbine",10,1,300,1,0,0,0};
		titles[] = {};
	};
};