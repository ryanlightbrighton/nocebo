#include "\nocebo\defines\scriptDefines.hpp"

params ["_class","_users"];

closeDialog 0;
player playActionNow "PutDown";
removeBackpack player;
private _spawnPos = player modelToWorld [0,2,2];
_spawnPos = AGLtoASL _spawnPos;
private _intersections = lineIntersectsSurfaces [
	_spawnPos,
	_spawnPos vectorAdd [0,0,-3],
	objNull,
	objNull,
	true,
	1,
	"FIRE",
	"NONE"
];
if not empty(_intersections) then {
	sel(_intersections,0) params ["_intersectPosASL","_surfaceNormal","_intersectObject","_parentObject"];
	private _beacon = createVehicle [
		"ncb_obj_para_beacon",
		ASLToAGL _intersectPosASL,
		[],
		0,
		"can_collide"
	];
	waitUntil {
		not isNull _beacon
	};
	_beacon setDir getDir player;
	_beacon setVectorUp _surfaceNormal;

	// animate

	_beacon animate ["Upload_1_cover_hide_1",3];
	_beacon animate ["Upload_2_cover_hide_1",3];
	_beacon animate ["Upload_3_cover_hide_1",3];

	_beacon animate ["Wifi_1_hide_1",3];
	_beacon animate ["Wifi_2_hide_1",3];
	_beacon animate ["Wifi_3_hide_1",3];
	_beacon animate ["Wifi_4_hide_1",3];
	_beacon animate ["Wifi_5_hide_1",3];

	_beacon animate ["Vent_1_rot_1",3];
	_beacon animate ["Vent_2_rot_1",3];
	_beacon animate ["Vent_3_rot_1",3];
	_beacon animate ["Vent_4_rot_1",3];

	_beacon animate ["Base_stripes_1_1_move_1",3];
	_beacon animate ["Base_stripes_2_1_move_1",3];
	_beacon animate ["Base_stripes_3_1_move_1",3];
	_beacon animate ["Base_stripes_4_1_move_1",3];
	_beacon animate ["Lid_stripes_1_1_move_1",3];
	_beacon animate ["Lid_stripes_2_1_move_1",3];
	_beacon animate ["Lid_stripes_3_1_move_1",3];
	_beacon animate ["Lid_stripes_4_1_move_1",3];

	_beacon animate ["Base_stripes_1_2_move_1",3];
	_beacon animate ["Base_stripes_2_2_move_1",3];
	_beacon animate ["Base_stripes_3_2_move_1",3];
	_beacon animate ["Base_stripes_4_2_move_1",3];
	_beacon animate ["Lid_stripes_1_2_move_1",3];
	_beacon animate ["Lid_stripes_2_2_move_1",3];
	_beacon animate ["Lid_stripes_3_2_move_1",3];
	_beacon animate ["Lid_stripes_4_2_move_1",3];

	_beacon animate ["Base_stripes_1_2_move_2",3];
	_beacon animate ["Base_stripes_2_2_move_2",3];
	_beacon animate ["Base_stripes_3_2_move_2",3];
	_beacon animate ["Base_stripes_4_2_move_2",3];
	_beacon animate ["Lid_stripes_1_2_move_2",3];
	_beacon animate ["Lid_stripes_2_2_move_2",3];
	_beacon animate ["Lid_stripes_3_2_move_2",3];
	_beacon animate ["Lid_stripes_4_2_move_2",3];

	_beacon animate ["Base_stripes_1_3_move_1",3];
	_beacon animate ["Base_stripes_2_3_move_1",3];
	_beacon animate ["Base_stripes_3_3_move_1",3];
	_beacon animate ["Base_stripes_4_3_move_1",3];
	_beacon animate ["Lid_stripes_1_3_move_1",3];
	_beacon animate ["Lid_stripes_2_3_move_1",3];
	_beacon animate ["Lid_stripes_3_3_move_1",3];
	_beacon animate ["Lid_stripes_4_3_move_1",3];

	_beacon animate ["Lock_1_rot_1",3];
	_beacon animate ["Lock_2_rot_1",3];
	_beacon animate ["Lid_rot_1",3];
	_beacon animate ["Lid_pistons_rot_1",3];
	_beacon animate ["Base_pistons_rot_1",3];

	_beacon animate ["Button_7_rot_1",3];
	_beacon animate ["Switch_2_rot_1",3];
	_beacon animate ["Switch_5_rot_1",3];
	_beacon animate ["Switch_6_rot_1",3];

	_beacon animate ["Dish_1_01_rot_1",3];
	_beacon animate ["Dish_1_02_rot_1",3];
	_beacon animate ["Dish_1_03_rot_1",3];
	_beacon animate ["Dish_1_04_rot_1",3];
	_beacon animate ["Dish_1_05_rot_1",3];
	_beacon animate ["Dish_1_06_rot_1",3];
	_beacon animate ["Dish_1_07_rot_1",3];
	_beacon animate ["Dish_1_08_rot_1",3];
	_beacon animate ["Dish_1_09_rot_1",3];
	_beacon animate ["Dish_1_10_rot_1",3];
	_beacon animate ["Dish_1_11_rot_1",3];
	_beacon animate ["Dish_1_12_rot_1",3];
	_beacon animate ["Dish_1_13_rot_1",3];
	_beacon animate ["Dish_1_14_rot_1",3];
	_beacon animate ["Dish_1_15_rot_1",3];
	_beacon animate ["Dish_1_16_rot_1",3];
	_beacon animate ["Dish_1_17_rot_1",3];
	_beacon animate ["Dish_1_18_rot_1",3];
	_beacon animate ["Dish_1_19_rot_1",3];
	_beacon animate ["Dish_1_20_rot_1",3];

	_beacon animate ["Antenna_piston_1_move_1",3];
	_beacon animate ["Antenna_piston_2_move_1",3];
	_beacon animate ["Antenna_piston_3_move_1",3];
	_beacon animate ["Antenna_base_rot_1",3];
	_beacon animate ["Antenna_center_rot_1",3];

	_beacon animate ["Dish_2_01_rot_1",3];
	_beacon animate ["Dish_2_02_rot_1",3];
	_beacon animate ["Dish_2_03_rot_1",3];
	_beacon animate ["Dish_2_04_rot_1",3];
	_beacon animate ["Dish_2_05_rot_1",3];
	_beacon animate ["Dish_2_06_rot_1",3];
	_beacon animate ["Dish_2_07_rot_1",3];
	_beacon animate ["Dish_2_08_rot_1",3];
	_beacon animate ["Dish_2_09_rot_1",3];
	_beacon animate ["Dish_2_10_rot_1",3];
	_beacon animate ["Dish_2_11_rot_1",3];
	_beacon animate ["Dish_2_12_rot_1",3];
	_beacon animate ["Dish_2_13_rot_1",3];
	_beacon animate ["Dish_2_14_rot_1",3];
	_beacon animate ["Dish_2_15_rot_1",3];
	_beacon animate ["Dish_2_16_rot_1",3];
	_beacon animate ["Dish_2_17_rot_1",3];
	_beacon animate ["Dish_2_18_rot_1",3];
	_beacon animate ["Dish_2_19_rot_1",3];
	_beacon animate ["Dish_2_20_rot_1",3];

	_beacon animate ["Screen_1_text_01_fakeunhide_1",3];

	_beacon animate ["Cpu_cover_fakehide_1",3];
	_beacon animate ["Ram_cover_fakehide_1",3];
	_beacon animate ["Cpu_1_rot_1",3];
	_beacon animate ["Cpu_2_rot_1",3];
	_beacon animate ["Ram_1_rot_1",3];
	_beacon animate ["Ram_2_rot_1",3];

	_beacon animate ["Screen_1_text_02_fakeunhide_1",3];
	_beacon animate ["Screen_1_text_03_fakeunhide_1",3];
	_beacon animate ["Screen_1_text_04_fakeunhide_1",3];
	_beacon animate ["Screen_1_text_05_fakeunhide_1",3];
	_beacon animate ["Screen_1_text_06_fakeunhide_1",3];
	_beacon animate ["Screen_1_text_07_fakeunhide_1",3];
	_beacon animate ["Screen_1_text_08_fakeunhide_1",3];

	_beacon animate ["Screen_1_text_09_fakeunhide_1",3];
	_beacon animate ["Screen_1_text_10_fakeunhide_1",3];
	_beacon animate ["Screen_1_text_11_fakeunhide_1",3];

	_beacon animate ["Screen_1_text_12_fakeunhide_1",3];
	_beacon animate ["Screen_1_text_13_fakeunhide_1",3];
	_beacon animate ["Screen_1_text_14_fakeunhide_1",3];
	_beacon animate ["Screen_1_text_15_fakeunhide_1",3];
	_beacon animate ["Screen_1_text_16_fakeunhide_1",3];
	_beacon animate ["Screen_1_text_17_fakeunhide_1",3];
	_beacon animate ["Screen_1_text_18_fakeunhide_1",3];
	_beacon animate ["Screen_1_text_19_fakeunhide_1",3];
	_beacon animate ["Screen_1_text_20_fakeunhide_1",3];
	_beacon animate ["Screen_1_text_21_fakeunhide_1",3];
	_beacon animate ["Screen_1_text_22_fakeunhide_1",3];
	_beacon animate ["Screen_1_text_23_fakeunhide_1",3];

	_beacon animate ["Screen_1_text_24_fakeunhide_1",3];
	_beacon animate ["Screen_1_text_25_fakeunhide_1",3];
	_beacon animate ["Screen_1_text_26_fakeunhide_1",3];
	_beacon animate ["Screen_1_text_27_fakeunhide_1",3];

	_beacon animate ["Screen_1_logo_fakeunhide_1",3];

	_beacon animate ["Screen_2_text_01_fakeunhide_1",3];
	_beacon animate ["Screen_2_text_02_fakeunhide_1",3];
	_beacon animate ["Screen_2_text_03_fakeunhide_1",3];
	_beacon animate ["Screen_2_text_04_fakeunhide_1",3];
	_beacon animate ["Screen_2_text_05_fakeunhide_1",3];
	_beacon animate ["Screen_2_text_06_fakeunhide_1",3];

	_beacon animate ["Screen_2_text_07_fakeunhide_1",3];
	_beacon animate ["Screen_2_text_08_fakeunhide_1",3];
	_beacon animate ["Screen_2_text_09_fakeunhide_1",3];

	_beacon animate ["Screen_2_text_10_fakeunhide_1",3];
	_beacon animate ["Screen_2_text_11_fakeunhide_1",3];
	_beacon animate ["Screen_2_text_12_fakeunhide_1",3];
	_beacon animate ["Screen_2_text_13_fakeunhide_1",3];
	_beacon animate ["Screen_2_text_14_fakeunhide_1",3];
	_beacon animate ["Screen_2_text_15_fakeunhide_1",3];

	_beacon animate ["Upload_fakeunhide_1",3];
	_beacon animate ["Wifi_cover_fakehide_1",3];

	// set colour of lights blue/green/white
	call {
		if (_users == "personal") exitWith {
			_texture = "#(argb,8,8,3)color(1,1,1,1)";
			_material = "\nocebo\rvmat\dataterminal_white.rvmat";
			_beacon setObjectTextureGlobal [2,_texture];
			_beacon setObjectTextureGlobal [3,_texture];
			_beacon setObjectTextureGlobal [4,_texture];
			_beacon setObjectMaterialGlobal [2,_material];
			_beacon setObjectMaterialGlobal [3,_material];
			_beacon setObjectMaterialGlobal [4,_material];
		};
		if (_users == "group") exitWith {
			_texture = "#(argb,8,8,3)color(0.25,0.75,0.25,1)";
			_material = "\nocebo\rvmat\dataterminal_green.rvmat";
			_beacon setObjectTextureGlobal [2,_texture];
			_beacon setObjectTextureGlobal [3,_texture];
			_beacon setObjectTextureGlobal [4,_texture];
			_beacon setObjectMaterialGlobal [2,_material];
			_beacon setObjectMaterialGlobal [3,_material];
			_beacon setObjectMaterialGlobal [4,_material];
		};
		if (_users == "side") exitWith {
			_texture = "#(argb,8,8,3)color(0,1,1,1)";
			_material = "\A3\Props_F_Exp_A\Military\Equipment\Data\DataTerminal_blue.rvmat";
			_beacon setObjectTextureGlobal [2,_texture];
			_beacon setObjectTextureGlobal [3,_texture];
			_beacon setObjectTextureGlobal [4,_texture];
			_beacon setObjectMaterialGlobal [2,_material];
			_beacon setObjectMaterialGlobal [3,_material];
			_beacon setObjectMaterialGlobal [4,_material];
		};
	};

	[player,_beacon,_users] remoteExecCall [
		"horde_fnc_serverSetTentOwner",
		2
	];
	private _text = format [
		"
			<t size='3.2'color='#FFFFFF'align='center'shadow='2'>
			%1 deployed.
			</t>
		",
		getText (configfile >> "cfgvehicles" >> _class >> "displayname")
	];
	_text call horde_fnc_displayActionConfMessage;
} else {
	private _text = "
		<t size='3.2'color='#FF0000'align='center'shadow='2'>
		You cannot place the beacon here.
		</t>
	";
	_text call horde_fnc_displayActionRejMessage;
};
true