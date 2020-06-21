#include "\nocebo\defines\scriptDefines.hpp"

if not (isServer) exitWith {};

if not (isNil "ncb_gv_ranPreInit") exitWith {
	diag_log "/**************************************/";
	diag("trying to read server pre-init twice");
	diag_log "/**************************************/";
};

if (isFilePatchingEnabled) exitWith {
	diag_log "/**************************************/";
	diag("file patching enabled - quitting");
	diag_log "/**************************************/";
	"filePatching" remoteExecCall [
		"endMission",
		0
	];
};

if not (isClass (configFile >> "CfgPatches" >> "inidbi2")) exitWith {
	diag_log "/**************************************/";
	diag("inidbi2 not loaded - quitting");
	diag_log "/**************************************/";
	"noIniDbi" remoteExecCall [
		"endMission",
		0
	];
};
//["Arma 3","Arma3",176,142872,"Stable",true,"Windows","x64"]
if (productVersion select 2 < 100 * getNumber (configFile >> "CfgPatches" >> "nocebo" >> "requiredVersion")) exitWith {
	diag_log "/**************************************/";
	diag("out of date Arma 3 - quitting");
	diag_log "/**************************************/";
	"badVersion" remoteExecCall [
		"endMission",
		0
	];
};

ncb_gv_ranPreInit = true;

/////////////////////////////////////////////
// new test - compressed functions

// https://forums.bistudio.com/forums/topic/176744-publicvariable-each-variable-on-the-server/?do=findComment&comment=2772678

/*_functionData = uiNamespace getVariable "ncb_uv_compressedFunctionsList";

{
	_x params ["_fnc","_public"];
	missionNamespace setVariable[_fnc,uiNamespace getVariable _fnc];
	if (_public) then {
		publicVariable format ["%1",_fnc]
	}
} forEach _functionData;

_functionData = nil;*/

// re-enable ^^^^^ - also remove the Z at the end of the compressedFunctions folder!

ncb_fnc_init = true;
publicVariable "ncb_fnc_init";

/////////////////////////////////////////////

call horde_fnc_commonInit;

// server only (local function)

_fnc_magsForVehiclesInit = {
	// gets a list of single mags for a vehicle
	// we can then add one of each of the output and use a reload EH to reload same type
	// run this here in preinit and spawn a vehicle of each type to test
	// then delete it and save the info to a var we can use in game
	_veh = _this createVehicle [0,0,1700];
	_arr = [];
	{
		_x params ["_mag","_path"];
		if ([] isEqualTo _arr) then {
			_arr = [[_path,[_mag]]]
		} else {
			_found = false;
			{
				_x params ["_path2","_mag2"];
				if (_path isEqualTo _path2) exitWith {
					_found = true;
					_mag2 pushBack _mag
				}
			} forEach _arr;
			if not (_found) then {
				_arr pushBack [_path,[_mag]]
			}
		}
	} forEach (magazinesAllTurrets _veh);


	{
		_x params ["_path","_mags"];
		_remove = [];
		{
			_mag = _x;
			if ({_mag isEqualTo _x} count _mags > 1) then {
				_remove pushBack _mag
			}
		} forEach _mags;
		{
			_mags = _mags - [_x]
		} forEach _remove;
		_arr set [_forEachIndex,[_path,_mags]]
	} forEach _arr;
	deleteVehicle _veh;
	missionNamespace setVariable [format ["ncb_gv_extraVehicleMagData_%1",_this],_arr];
};

ncb_pv_paramsArray = [];

_cfgParams = missionConfigFile >> "Params";
if (isNil "paramsArray") then {
	diag("error - paramsarray not initialised");
	if (isClass _cfgParams) then {
		for "_i" from 0 to count _cfgParams - 1 do {
			_cfgParam = _cfgParams select _i;
			_paramName = configName _cfgParam;
			if (_paramName find "ncb_param" > -1) then {
				_multiplier = getNumber (_cfgParam >> "paramMultiplier");
				_value = getNumber (_cfgParam >> "default") * _multiplier;
				missionNamespace setVariable [_paramName,_value];
				ncb_pv_paramsArray pushBack [_paramName,_value];
			};
		};
	};
} else {
	for "_i" from 0 to count paramsArray - 1 do {
		_cfgParam = _cfgParams select _i;
		_paramName = configName _cfgParam;
		if (_paramName find "ncb_param" > -1) then {
			_multiplier = getNumber (_cfgParam >> "paramMultiplier");
			_profileValue = paramsArray select _i;
			_missionValue = _profileValue * _multiplier;
			_replace = getText (_cfgParam >> "paramReplace");
			if (_replace != "") then {
				_missionValue = (call compile _replace) select _profileValue
			};
			if (_paramName == "ncb_param_loadZonesFromProfile") then {
				_profileValue = 1
			};
			missionNamespace setVariable [_paramName,_missionValue];
			profileNamespace setVariable [_paramName,_profileValue];
			ncb_pv_paramsArray pushBack [_paramName,_missionValue];
		};
	};
};

call horde_fnc_waypointFunctions;

/*{
	if (_x find "ncb_param" > -1) then {
		_value = missionNamespace getVariable [_x,-1];
	};
} forEach (allVariables missionNamespace);*/

_fnc_roundArray = {
	{
		_this set [_forEachIndex,round (_this select _forEachIndex)];
	} forEach _this;
	_this
};

_fnc_checkAboveASL = {
	private _open = true;
	for "_direction" from 0 to 270 step 90 do {
		private _testPosASL = [
			sel(_this,0) + 10 * sin _direction,
			sel(_this,1) + 10 * cos _direction,
			sel(_this,2) + 10 * tan 65
		];
		/*_handle = addMissionEventHandler ["Draw3D",compile format ["drawLine3D [%1,%2,[1,0,1,1]]",ASLtoATL _this,ASLtoATL _testPosASL]];*/
		if (lineIntersects [_this vectorAdd [0,0,0.2],_testPosASL]) exitWith {
			_open = false;
		};
	};
	_open
};

//  key: [class,modelpos,rel dir,fuel,damage,[pitch,bank],varname,init,simulation,asl,onFloor,align to surface,sound source]

ncb_gv_samSiteObjects = [
	["Land_Bunker_F",[0,0,0],0,1,0,[],"","",false,false,true,false,""],
	["ncb_static_spartan_system",[0,2.2,2.9],270,1,0,[],"","",true,false,false,false,""],
	["Land_dp_transformer_F",[0.06,6.18,-0.98],180,1,0,[],"","",false,false,true,false,""]
];

ncb_gv_artilleryObjects = [
	["Intel_File2_F",[9.0293,-4.88672,0.81],78.4791,1,0,[0.0203362,0.129691],"","",false,false,false,true,""],
	["Land_MobilePhone_old_F",[8.9375,-5.23828,0.815],260.483,1,0,[-0.015788,-0.130323],"","",false,false,false,true,""],
	["Land_Laptop_device_F",[9.11328,-5.91797,0.81],278.349,1,0,[0.0249542,-0.128882],"","",false,false,false,true,""],
	["Land_BagFence_Long_F",[11.1602,8.22656,2.8],270,1,0,[0.00597614,-0.131139],"","",false,false,false,true,""],
	["Land_BagFence_Long_F",[12.8379,6.91211,2.8],180,1,0,[-0.131139,-0.00597623],"","",false,false,false,true,""],
	["Land_BagFence_Long_F",[14.4824,8.16211,2.8],90,1,0,[-0.00597614,0.131139],"","",false,false,false,true,""],
	["Land_FloodLight_F",[11.0039,6.68555,3.1],117.882,1,0,[-0.0666091,20.3809],"","",false,false,false,false,""],

	["Land_GasTank_01_blue_F",[9.16992,-5.08008,0],118.087,1,0,[-0.0945703,0.112882],"","",false,false,true,true,""],
	["ncb_flag_antagonist",[3.35352,4.2168,0.00143194],0,1,0,[0.131139,0.00597617],"","",true,false,true,false,""],
	["Land_HBarrier_5_F",[-0.833984,-3.50391,0.00142908],90,1,0,[-0.00597614,0.131139],"","",false,false,true,true,""],
	["CamoNet_OPFOR_open_F",[5.12305,-4.28906,0.00143051],90,1,0,[-0.00597614,0.131139],"","",false,false,true,true,""],
	["Land_MetalBarrel_F",[7.42969,0.9375,0],98.9745,1,0,[-0.0263602,0.128602],"","",false,false,true,true,""],
	["Land_MetalBarrel_F",[7.98047,0.646484,0],99.0629,1,0,[-0.0265586,0.128561],"","",false,false,true,true,""],
	["Land_MetalBarrel_F",[7.89258,1.4082,0],81.1222,1,0,[0.0143338,0.130491],"","",false,false,true,true,""],
	["Land_WaterTank_F",[7.68945,3.2793,0],0,1,0,[0.131139,0.00597617],"","",false,false,true,true,""],
	["ncb_obj_ammobox_m",[8.86133,-2.5918,0.00143194],90,1,0,[-0.00597614,0.131139],"","",true,false,true,true,""],
	["WaterPump_01_forest_F",[7.10352,6.24805,0.000890732],355.002,1,0,[0.131161,-0.00547206],"","",true,false,true,true,"Sound_Generator"],
	["Land_HBarrier_5_F",[-10.1914,4.83594,0.00153327],90,1,0,[-0.00597614,0.131139],"","",false,false,true,true,""],
	["Land_CampingTable_F",[9.06445,-5.45117,0.00143337],92.9998,1,0,[-0.0128308,0.130647],"","",false,false,true,true,""],
	["Land_HBarrier_5_F",[-10.1914,-0.765625,0.00153232],90,1,0,[-0.00597614,0.131139],"","",false,false,true,true,""],
	["MapBoard_altis_F",[8.55469,-8.22656,-0.00215149],108.576,1,0,[-0.0474417,0.122403],"","",false,false,true,true,""],
	["Land_MetalCase_01_large_F",[6.48828,-9.95898,0.00143838],81.6513,1,0,[0.0131282,0.130617],"","",false,false,true,true,""],
	["Land_CncBarrier_F",[-5.64453,11.4473,0.00142193],0,1,0,[0.131139,0.00597617],"","",false,false,true,true,""],
	["Land_HBarrier_5_F",[-10.1914,10.4375,0.00153422],90,1,0,[-0.00597614,0.131139],"","",false,false,true,true,""],
	["Land_HBarrier_5_F",[-10.1914,-6.36719,0.0015316],90,1,0,[-0.00597614,0.131139],"","",false,false,true,true,""],
	["Land_HBarrier_5_F",[13.1543,4.79492,0.00143456],90,1,0,[-0.00597614,0.131139],"","",false,false,true,true,""],
	["Land_HBarrier_5_F",[13.1543,-0.806641,0.00143361],90,1,0,[-0.00597614,0.131139],"","",false,false,true,true,""],
	["Land_CncBarrier_F",[-8.23438,11.4473,0.00142193],0,1,0,[0.131139,0.00597617],"","",false,false,true,true,""],
	["Land_HBarrier_5_F",[4.92188,12.2441,0.00143313],0,1,0,[0.131139,0.00597617],"","",false,false,true,true,""],
	["Land_HBarrier_5_F",[-0.796875,-14.709,0.00142884],0,1,0,[0.131139,0.00597617],"","",false,false,true,true,""],
	["Land_HBarrier_5_F",[-6.39844,-14.709,0.00142312],0,1,0,[0.131139,0.00597617],"","",false,false,true,true,""],
	["Land_HBarrier_5_F",[-10.0098,-11.2773,0.00141931],44.9999,1,0,[0.088504,0.0969552],"","",false,false,true,true,""],
	["Land_HBarrier_5_F",[9.76367,-14.498,0.0014379],315,1,0,[0.0969553,-0.0885039],"","",false,false,true,true,""],
	["Land_HBarrier_5_F",[13.1543,-6.4082,0.00143266],90,1,0,[-0.00597614,0.131139],"","",false,false,true,true,""],
	["Land_BagBunker_Tower_F",[12.9043,9.87109,0.00143862],180,1,0,[-0.131139,-0.00597623],"","",false,false,true,true,""],
	["Land_HBarrier_5_F",[4.80469,-14.709,0.00143456],90,1,0,[0.131139,0.00597617],"","",false,false,true,true,""],

	["O_Soldier_F",[12.2461,8.69727,3],224.749,1,1,[-0.0889269,-0.0965675],"","",true,false,true,false,""],
	["O_Soldier_F",[13.0625,8.42188,0.00143313],109.535,1,1,[-0.0494838,0.121592],"","",true,false,true,false,""],
	["O_Soldier_F",[13.3398,8.10156,3],126.233,1,1,[-0.0823326,0.102248],"","",true,false,true,false,""],
	["O_Soldier_F",[13.0625,10.8125,0.0014348],0,1,1,[0.131139,0.00597617],"","",true,false,true,false,""],

	["ncb_veh_sochor",[-5.85547,-3.46094,-0.0706186],0,1,0,[0.131139,0.00597617],"","",true,false,true,true,""],
	["ncb_static_hmg_high",[13.0996,11.2988,2.5],0,1,0,[0.131139,0.00597617],"","",true,false,false,true,""]
];

ncb_gv_radioTransmitterObjects = [
	["MetalBarrel_burning_F",[5.96289,3.75781,0],325.84,1,0,[0,0],"","",false,false,true,true,""],
	["Land_Cargo_HQ_V2_F",[2.28906,-6.61328,0],325.84,1,0,[0,0],"","",false,false,true,false,""],
	["WaterPump_01_forest_F",[8.69727,0.476563,0.00087595],325.835,1,0,[0,0],"","",true,false,true,true,"Sound_Generator"],
	["Land_LampHalogen_F",[-0.265625,-19.2793,0],100.84,1,0,[0,-0],"","",true,false,true,false,""],
	["Land_Communication_F",[14.0957,13.6797,0],325.84,1,0,[0,0],"","",false,false,true,false,""],
	["Land_Cargo_Patrol_V2_F",[20.9355,1.94531,0],280.84,1,0,[0,0],"","",false,false,true,false,""],
	["Land_spp_Transformer_F",[17.9863,9.56055,0],325.84,1,0,[0,0],"","",false,false,true,true,"Sound_Hum"],
	["Land_Concrete_SmallWall_8m_F",[8.3418,16.1797,0],55.84,1,0,[0,0],"","",false,false,true,true,""],
	["Land_Concrete_SmallWall_8m_F",[13.5449,15.1328,0],325.84,1,0,[0,0],"","",false,false,true,true,""],
	["ncb_obj_ammobox_m",[11,-3.6,0],55,1,0,[0,0],"","",true,false,true,true,""],
	["Land_HBarrierBig_F",[8.78711,-16.4746,-1.3],325.84,1,0,[0,0],"","",false,false,true,true,""],
	["Land_HBarrierBig_F",[-8.85938,-12.1094,-1.3],55.84,1,0,[0,0],"","",false,false,false,true,""],
	["Land_HBarrierBig_F",[-16.0859,2.7832,-1.3],100.84,1,0,[0,0],"","",false,false,false,true,""],
	["Land_HBarrierBig_F",[-3.97656,-18.9512,-1.3],55.84,1,0,[0,0],"","",false,false,false,true,""],
	["Land_HBarrierBig_F",[15.6914,-11.7891,-1.3],325.84,1,0,[0,0],"","",false,false,false,true,""],
	["Land_HBarrierBig_F",[-10.4609,16.5059,-1.3],325.84,1,0,[0,0],"","",false,false,false,true,""],
	["Land_HBarrierBig_F",[1.83398,-21.1914,-1.3],325.84,1,0,[0,0],"","",false,false,false,true,""],
	["Land_HBarrierBig_F",[19.291,13.3496,-1.3],55.84,1,0,[0,0],"","",false,false,false,true,""],
	["Land_HBarrierBig_F",[22.6934,-7.03711,-1.3],325.84,1,0,[0,0],"","",false,false,false,true,""],
	["Land_HBarrierBig_F",[24.0996,6.26367,-1.3],55.84,1,0,[0,0],"","",false,false,false,true,""],
	["Land_HBarrierBig_F",[25.9648,-0.568359,-1.3],280.84,1,0,[0,0],"","",false,false,false,true,""]
];

ncb_gv_wreckTypes = [
	"ncb_obj_wreck_bmp",
	"ncb_obj_wreck_brdm",
	"ncb_obj_wreck_car",
	"ncb_obj_wreck_car2",
	"ncb_obj_wreck_car3",
	"ncb_obj_wreck_car_dismantled",
	"ncb_obj_wreck_hmmwv",
	"ncb_obj_wreck_hunter",
	"ncb_obj_wreck_offroad",
	"ncb_obj_wreck_offroad2",
	"ncb_obj_wreck_skodovka",
	"ncb_obj_wreck_slammer",
	"ncb_obj_wreck_slammer_hull",
	"ncb_obj_wreck_slammer_turret",
	"ncb_obj_wreck_t72_hull",
	"ncb_obj_wreck_t72_turret",
	"ncb_obj_wreck_truck_dropside",
	"ncb_obj_wreck_truck",
	"ncb_obj_wreck_uaz",
	"ncb_obj_wreck_ural",
	"ncb_obj_wreck_van"
];

ncb_gv_alarmBuildingBaseClasses = [
	"Cargo_Patrol_base_F",
	"Cargo_Tower_base_F",
	"Cargo_HQ_base_F",
	"Land_BagBunker_Tower_F",
	"Land_Airport_Tower_F",
	"Land_TTowerBig_1_F"
];

ncb_gv_spawnMinFps = 20;
if (isDedicated) then {
	ncb_gv_spawnMaxFps = 50;
} else {
	ncb_gv_spawnMaxFps = 60;
};
ncb_gv_spawnMinDelay = 0.0001;
ncb_gv_spawnMaxDelay = 0.05;
ncb_gv_zoneRadius = 1000;
ncb_gv_zoneTriggerRad = 1250; // was 1500;
ncb_gv_zoneBaseTriggerRad = 1500;
ncb_gv_zoneList = [];
ncb_gv_garbageContents = [];
ncb_gv_abandonedVehicles = [];
ncb_gv_connectedPlayerList = []; // list of all players who have connected to this session so far

// variables for troop probability and count on spawn

if (ncb_param_zoneSniperCountLower > ncb_param_zoneSniperCountUpper) then {
	ncb_param_zoneSniperCountUpper = ncb_param_zoneSniperCountLower;
	diag(ncb_param_zoneSniperCountLower);
};
if (ncb_param_zoneStaticCountLower > ncb_param_zoneStaticCountUpper) then {
	ncb_param_zoneStaticCountUpper = ncb_param_zoneStaticCountLower;
	diag(ncb_param_zoneStaticCountLower);
};

// UNIT TYPES

ncb_gv_enemyUnitTypes = [
	"Horde_gunmanUnit"
	/*"B_Soldier_F"*/
];
ncb_gv_enemyParaTypes = [
	"Horde_paraUnit"
];
ncb_gv_enemySniperTypes = [
	"Horde_sniperUnit"
];
ncb_gv_renegadeTypes = [
	"Horde_renegadeUnit"
];
ncb_gv_enemyDiverTypes = [
	"Horde_diverUnit"
];

//WEAPONS & EQUIP

_fnc_getEquipmentFromConfig = {
	params ["_classes","_factions","_equipCfgArr","_typesArr"];
	_equipCfgArr params ["_cfgProperty","_dataType"];
	// ex: ["B_Soldier_F",["OPF_F","IND_F"],["linkedItems",[]]] call _fnc_getEquipmentFromConfig (vests)
	// ex: ["B_Soldier_F",["OPF_F","IND_F"],["uniformClass",""]] call _fnc_getEquipmentFromConfig (vests)
	// if classes is empty array then factions are used
	// if factions is empty then only classes are used
	{
		private _config = _x;
		private _class = configName _x;
		{
			if (getText (_config >> "faction") == _x
				and {_class isKindOf "camanbase"}
				and {getNumber (_config >> "scope") == 2}
				/*and {toLower _class find "soldier" > -1}*/
				and {{toLower _class find _x > -1} count _typesArr > 0}
			) exitWith {
				_classes pushBack _class
			};
		} forEach _factions;
	} forEach ("true" configClasses (configFile >> "CfgVehicles"));

	private _equipClasses = [];
	{
		call {
			if ([] isEqualType _dataType) exitWith {
				{
					_equipClasses pushBackUnique _x
				} forEach (getArray (configFile >> "CfgVehicles" >> _x >> _cfgProperty))
			};
			if ("" isEqualType _dataType) exitWith {
				private _text = getText (configFile >> "CfgVehicles" >> _x >> _cfgProperty);
				if not (_text isEqualTo "") then {
					_equipClasses pushBackUnique _text
				}
			};
			if (0 isEqualType _dataType) exitWith {
				_equipClasses pushBackUnique (getNumber (configFile >> "CfgVehicles" >> _x >> _cfgProperty))
			};
		}
	} forEach _classes;

	_equipClasses
};

ncb_gv_backpackTypes = [
	"B_OutdoorPack_blk",
	"B_OutdoorPack_tan",
	"B_OutdoorPack_blu",
	"B_HuntingBackpack"
];
_fnc_getEmptyBackpackParent = {
	private _cfgParent = inheritsFrom (configFile >> "CfgVehicles" >> _this);
	if (getNumber (_cfgParent >> "scope") == 2) then {
		_this = configName _cfgParent;
		_this = _this call _fnc_getEmptyBackpackParent;
	};
	_this
};
// https://dev.withsix.com/projects/cup/wiki/CUP_Naming_Standards
if (isClass (configFile >> "CfgPatches" >> "CUP_BaseData")) then {
	ncb_gv_backpackTypes = ([[],["CUP_O_RU"],["backpack",""],["soldier"]] call _fnc_getEquipmentFromConfig) apply {_x call _fnc_getEmptyBackpackParent}
};
if (isClass (configFile >> "CfgPatches" >> "rhs_c_troops")) then {
	ncb_gv_backpackTypes = ([[],["rhs_faction_msv"],["backpack",""],["rifleman","machinegunner","grenadier"]] call _fnc_getEquipmentFromConfig) apply {_x call _fnc_getEmptyBackpackParent}
};

ncb_gv_hatTypes = [
	"H_MilCap_ocamo",
	"H_Beret_ocamo",
	"H_Watchcap_khk",
	"H_Watchcap_sgg",
	"H_Booniehat_khk",
	"H_Booniehat_mcamo",
	"H_Booniehat_grn",
	"H_Booniehat_tan",
	"H_Booniehat_dirty",
	"H_Booniehat_dgtl",
	"H_Shemag_khk",
	"H_Shemag_olive",
	"H_Shemag_tan",
	"H_ShemagOpen_khk",
	"H_ShemagOpen_tan",
	"H_Shemag_khk",
	"H_Shemag_olive",
	"H_Shemag_tan",
	"H_ShemagOpen_khk",
	"H_ShemagOpen_tan",
	"H_TurbanO_blk",
	"H_Bandanna_camo"
];
// https://dev.withsix.com/projects/cup/wiki/CUP_Naming_Standards
if (isClass (configFile >> "CfgPatches" >> "CUP_BaseData")) then {
	private _cfg = configFile >> "CfgWeapons";
	ncb_gv_hatTypes = (([[],["CUP_O_RU"],["linkedItems",[]],["soldier"]] call _fnc_getEquipmentFromConfig) select {getNumber (_cfg >> _x >> "ItemInfo" >> "type") == 605})
};
if (isClass (configFile >> "CfgPatches" >> "rhs_c_troops")) then {
	private _cfg = configFile >> "CfgWeapons";
	ncb_gv_hatTypes = (([[],["rhs_faction_msv"],["linkedItems",[]],["rifleman","machinegunner","grenadier"]] call _fnc_getEquipmentFromConfig) select {getNumber (_cfg >> _x >> "ItemInfo" >> "type") == 605})
};
ncb_gv_renegadeHatTypes = [
	"H_Shemag_khk",
	"H_Shemag_olive",
	"H_Shemag_olive_hs",
	"H_Shemag_tan",
	"H_ShemagOpen_khk",
	"H_ShemagOpen_tan"
];
ncb_gv_armourTypesGunman = [
	"V_HarnessO_brn",
	"V_HarnessOGL_brn",
	"V_HarnessO_gry",
	"V_HarnessOGL_gry"
];
// https://dev.withsix.com/projects/cup/wiki/CUP_Naming_Standards
if (isClass (configFile >> "CfgPatches" >> "CUP_BaseData")) then {
	private _cfg = configFile >> "CfgWeapons";
	ncb_gv_armourTypesGunman = ([[],["CUP_O_RU"],["linkedItems",[]],["soldier"]] call _fnc_getEquipmentFromConfig) select {getNumber (_cfg >> _x >> "ItemInfo" >> "type") == 701}
};
if (isClass (configFile >> "CfgPatches" >> "rhs_c_troops")) then {
	private _cfg = configFile >> "CfgWeapons";
	ncb_gv_armourTypesGunman = (([[],["rhs_faction_msv"],["linkedItems",[]],["rifleman","machinegunner","grenadier"]] call _fnc_getEquipmentFromConfig) select {getNumber (_cfg >> _x >> "ItemInfo" >> "type") == 701})
};
ncb_gv_armourTypesSniper = [
	"V_Chestrig_khk"
];
if (isClass (configFile >> "CfgPatches" >> "CUP_BaseData")) then {
	private _cfg = configFile >> "CfgWeapons";
	ncb_gv_armourTypesSniper = ([[],["CUP_O_RU"],["linkedItems",[]],["sniper","spotter"]] call _fnc_getEquipmentFromConfig) select {getNumber (_cfg >> _x >> "ItemInfo" >> "type") == 701}
};
if (isClass (configFile >> "CfgPatches" >> "rhs_c_troops")) then {
	private _cfg = configFile >> "CfgWeapons";
	ncb_gv_armourTypesSniper = (([[],["rhs_faction_msv"],["linkedItems",[]],["marksman"]] call _fnc_getEquipmentFromConfig) select {getNumber (_cfg >> _x >> "ItemInfo" >> "type") == 701})
};
ncb_gv_armourTypesPara = [
	"V_PlateCarrier1_blk"
];
if (isClass (configFile >> "CfgPatches" >> "CUP_BaseData")) then {
	private _cfg = configFile >> "CfgWeapons";
	ncb_gv_armourTypesPara = ([[],["CUP_O_RU"],["linkedItems",[]],["soldier"]] call _fnc_getEquipmentFromConfig) select {getNumber (_cfg >> _x >> "ItemInfo" >> "type") == 701}
};
if (isClass (configFile >> "CfgPatches" >> "rhs_c_troops")) then {
	private _cfg = configFile >> "CfgWeapons";
	ncb_gv_armourTypesPara = (([[],["rhs_faction_msv"],["linkedItems",[]],["rifleman","machinegunner","grenadier"]] call _fnc_getEquipmentFromConfig) select {getNumber (_cfg >> _x >> "ItemInfo" >> "type") == 701})
};
ncb_gv_uniformGunmanTypes = [
	"U_O_CombatUniform_ocamo",
	"U_O_CombatUniform_oucamo"
	/*"U_C_HunterBody_grn",
	"U_BG_Guerilla2_1",
	"U_BG_Guerilla2_2",
	"U_BG_Guerilla2_3",
	"U_BG_Guerilla3_1"*/
];
if (isClass (configFile >> "CfgPatches" >> "CUP_BaseData")) then {
	private _cfg = configFile >> "CfgWeapons";
	ncb_gv_uniformGunmanTypes = ([[],["CUP_O_RU"],["uniformClass",""],["soldier"]] call _fnc_getEquipmentFromConfig) select {getNumber (_cfg >> _x >> "ItemInfo" >> "type") == 801}
};
if (isClass (configFile >> "CfgPatches" >> "rhs_c_troops")) then {
	private _cfg = configFile >> "CfgWeapons";
	ncb_gv_uniformGunmanTypes = (([[],["rhs_faction_msv"],["uniformClass",""],["rifleman","machinegunner","grenadier"]] call _fnc_getEquipmentFromConfig) select {getNumber (_cfg >> _x >> "ItemInfo" >> "type") == 801})
};
ncb_gv_uniformParaTypes = [
	"U_O_SpecopsUniform_ocamo"
];
if (isClass (configFile >> "CfgPatches" >> "CUP_BaseData")) then {
	private _cfg = configFile >> "CfgWeapons";
	ncb_gv_uniformParaTypes = ([[],["CUP_O_RU"],["uniformClass",""],["soldier"]] call _fnc_getEquipmentFromConfig) select {getNumber (_cfg >> _x >> "ItemInfo" >> "type") == 801}
};
if (isClass (configFile >> "CfgPatches" >> "rhs_c_troops")) then {
	private _cfg = configFile >> "CfgWeapons";
	ncb_gv_uniformParaTypes = (([[],["rhs_faction_msv"],["uniformClass",""],["rifleman","machinegunner","grenadier"]] call _fnc_getEquipmentFromConfig) select {getNumber (_cfg >> _x >> "ItemInfo" >> "type") == 801})
};
ncb_gv_uniformSniperTypes = [
	"U_O_SpecopsUniform_ocamo",
	/*"U_O_FullGhillie_ard",
	"U_O_FullGhillie_lsh",
	"U_O_FullGhillie_sard",*/
	"U_O_GhillieSuit"
	/*"U_C_HunterBody_grn",
	"U_BG_Guerilla2_1",
	"U_BG_Guerilla2_2",
	"U_BG_Guerilla2_3",
	"U_BG_Guerilla3_1"*/
];
if (isClass (configFile >> "CfgPatches" >> "CUP_BaseData")) then {
	private _cfg = configFile >> "CfgWeapons";
	ncb_gv_uniformSniperTypes = ([[],["CUP_O_RU"],["uniformClass",""],["sniper","spotter"]] call _fnc_getEquipmentFromConfig) select {getNumber (_cfg >> _x >> "ItemInfo" >> "type") == 801}
};
if (isClass (configFile >> "CfgPatches" >> "rhs_c_troops")) then {
	private _cfg = configFile >> "CfgWeapons";
	ncb_gv_uniformSniperTypes = (([[],["rhs_faction_msv"],["uniformClass",""],["marksman"]] call _fnc_getEquipmentFromConfig) select {getNumber (_cfg >> _x >> "ItemInfo" >> "type") == 801})
};
ncb_gv_uniformRenegadeTypes = [
	"U_BG_Guerilla1_1",
	"U_BG_Guerrilla_6_1",
	"U_I_C_Soldier_Camo_F",
	"U_I_C_Soldier_Para_2_F",
	"U_I_C_Soldier_Para_3_F",
	"U_I_C_Soldier_Para_4_F",
	"U_I_C_Soldier_Para_1_F",
	"U_BG_leader",
	"U_C_HunterBody_grn",
	"U_BG_Guerilla2_1",
	"U_BG_Guerilla2_2",
	"U_BG_Guerilla2_3",
	"U_BG_Guerilla3_1"
];

ncb_gv_civilianTypes = "configName _x isKindOf 'CAManBase' and {getNumber (_x >> 'side') == 3} and {getNumber (_x >> 'scope') == 2}" configClasses (configFile >> "CfgVehicles") apply {configName _x};


_a3Addons = getArray (configFile >> "CfgAddons" >> "PreloadAddons" >> "A3" >> "list");
_apexAddons = getArray (configFile >> "CfgAddons" >> "PreloadAddons" >> "A3_Expansion" >> "list");
_heliAddons = getArray (configFile >> "CfgAddons" >> "PreloadAddons" >> "A3_Heli" >> "list");
_kartAddons = getArray (configFile >> "CfgAddons" >> "PreloadAddons" >> "A3_Kart" >> "list");
_markAddons = getArray (configFile >> "CfgAddons" >> "PreloadAddons" >> "A3_Mark" >> "list");
_jetsAddons = getArray (configFile >> "CfgAddons" >> "PreloadAddons" >> "A3_Jets" >> "list");
_lowAddons = getArray (configFile >> "CfgAddons" >> "PreloadAddons" >> "A3_Orange" >> "list");
_enochAddons = getArray (configFile >> "CfgAddons" >> "PreloadAddons" >> "A3_Enoch" >> "list");
_tankAddons = getArray (configFile >> "CfgAddons" >> "PreloadAddons" >> "A3_Tank" >> "list");

_fnc_isAllowedVanilla = {
	ncb_param_vanillaEquipmentAllowed == 1
	or {
		ncb_param_vanillaEquipmentAllowed == 0
		and {{_x in _a3Addons} count (configSourceAddonList _this) == 0}
	}
};

_fnc_isAllowedDlc = {
	private _addons = configSourceAddonList _this;
	true
	and {
		ncb_param_dlcEquipmentAllowedApex
		or {! ncb_param_dlcEquipmentAllowedApex and {{_x in _apexAddons} count _addons == 0}}
	}
	and {
		ncb_param_dlcEquipmentAllowedHeli
		or {! ncb_param_dlcEquipmentAllowedHeli and {{_x in _heliAddons} count _addons == 0}}
	}
	and {
		ncb_param_dlcEquipmentAllowedKart
		or {! ncb_param_dlcEquipmentAllowedKart and {{_x in _kartAddons} count _addons == 0}}
	}
	and {
		ncb_param_dlcEquipmentAllowedMark
		or {! ncb_param_dlcEquipmentAllowedMark and {{_x in _markAddons} count _addons == 0}}
	}
	and {
		ncb_param_dlcEquipmentAllowedJets
		or {! ncb_param_dlcEquipmentAllowedJets and {{_x in _jetsAddons} count _addons == 0}}
	}
	and {
		ncb_param_dlcEquipmentAllowedLOW
		or {! ncb_param_dlcEquipmentAllowedLOW and {{_x in _lowAddons} count _addons == 0}}
	}
	and {
		ncb_param_dlcEquipmentAllowedEnoch
		or {! ncb_param_dlcEquipmentAllowedEnoch and {{_x in _enochAddons} count _addons == 0}}
	}
	and {
		ncb_param_dlcEquipmentAllowedTank
		or {! ncb_param_dlcEquipmentAllowedTank and {{_x in _tankAddons} count _addons == 0}}
	}
};

_fnc_getConfig = {
	if (isClass (_cfgWeapons >> _this)) exitWith {
		_cfgWeapons >>  _this
	};
	if (isClass (_cfgMagazines >> _this)) exitWith {
		_cfgMagazines >> _this
	};
	if (isClass (_cfgVehicles >> _this)) exitWith {
		_cfgVehicles >> _this
	};
	if (isClass (_cfgGlasses >> _this)) exitWith {
		_cfgGlasses >> _this
	};
};

_fnc_defaultItems = {
	private _item = [];
	call {
		if (toLower _this find "scope" > -1) exitWith {
			_item = ["optic_Aco"];
		};
		if (toLower _this find "rifle" > -1) exitWith {
			_item = ["hgun_PDW2000_F"];
		};
		if (toLower _this find "pistol" > -1) exitWith {
			_item = ["hgun_P07_F"];
		};
		if (toLower _this find "launcher" > -1) exitWith {
			_item = ["launch_RPG7_F"];
		};
		if (toLower _this find "helmet" > -1) exitWith {
			_item = ["H_Booniehat_khk"];
		};
		if (toLower _this find "vest" > -1) exitWith {
			_item = ["V_Rangemaster_belt"];
		};
		if (toLower _this find "mags" > -1) exitWith {
			_item = ["30Rnd_9x21_Mag"];
		};
		if (toLower _this find "belt" > -1) exitWith {
			_item = ["200Rnd_556x45_stanag_box"];
		};
		if (toLower _this find "backpack" > -1) exitWith {
			_item = ["B_AssaultPack_khk"];
		};
	};
	_item
};

_fnc_scopeType = {
	private "_found";
	_found = false;
	_cfgOpticsModes = _cfgItem  >> "ItemInfo" >> "OpticsModes";
	for "_i" from 0 to count _cfgOpticsModes - 1 do {
		_cfgMode = _cfgOpticsModes select _i;
		_modes = getArray (_cfgMode >> 'visionMode');
		if ({if (_x == _this) exitWith {1}} count _modes > 0) exitWith {
			_found = true
		}
	};
	_found
};

_fnc_launcherOptics = {
	private "_found";
	_found = false;
	_cfgOpticsModes = _cfgItem >> "OpticsModes";
	for "_i" from 0 to count _cfgOpticsModes - 1 do {
		_cfgMode = _cfgOpticsModes select _i;
		_modes = getArray (_cfgMode >> 'visionMode');
		if ({if (_x == _this) exitWith {1}} count _modes > 0) exitWith {
			_found = true
		}
	};
	_found
};

// we have the master lists, so filter by params

_cfgVehicles = configFile >> "CfgVehicles";
_cfgWeapons = configFile >> "CfgWeapons";
_cfgMagazines = configFile >> "CfgMagazines";
_cfgGlasses = configFile >> "CfgGlasses";

{
	_uiVarName = _x;
	_uiList = uiNamespace getVariable [_uiVarName,[]];
	if not empty(_uiList) then {
		{

			// filter
			_type = _x;
			_items = [];
			_varName = "ncb_gv_" + _type + (_uiVarName select [13,99]);
			_nv = missionNamespace getVariable ("ncb_param_nvScopesAllowed" + _type);
			_ti = missionNamespace getVariable ("ncb_param_tiScopesAllowed" + _type);
			_nonSideOK = missionNamespace getVariable ("ncb_param_nonSideEquipmentAllowed" + _type);
			_filterSides = missionNamespace getVariable ("ncb_param_filterEquipmentSides" + _type);
			{
				_x params ["_item","_sides"];
				_cfgItem = _item call _fnc_getConfig;
				private _cond1 = _sides isEqualTo [4];
				private _cond2 = _nonSideOK and {_sides isEqualTo [3]};
				private _cond3 = {if (_filterSides find _x > -1) exitWith {1}} count _sides > 0;
				private _cond4 = _cfgItem call _fnc_isAllowedVanilla;
				private _cond5 = _cfgItem call _fnc_isAllowedDlc;
				if ((_cond1 or {_cond2} or {_cond3}) and {_cond4} and {_cond5}) then {
					if (toLower _varName find "scopes" > - 1) exitWith {
						// ti and ir check
						_ok = true;
						if (_nv == 0 and {"nvg" call _fnc_scopeType}) then {
							_ok = false
						};
						if (_ti == 0 and {"ti" call _fnc_scopeType}) then {
							_ok = false
						};
						if (_ok) then {
							_items pushBack _item
						};
					};
					if (toLower _varName find "binos" > - 1) exitWith {
						// ti and ir check
						_modes = getArray (_cfgItem >> 'visionMode');
						_ok = true;
						if (_nv == 0 and {{if (_x == "nvg") exitWith {1}} count _modes > 0}) then {
							_ok = false
						};
						if (_ti == 0 and {{if (_x == "ti") exitWith {1}} count _modes > 0}) then {
							_ok = false
						};
						if (_ok) then {
							_items pushBack _item
						};
					};
					if (toLower _varName find "headoptics" > - 1) exitWith {
						// ti and ir check
						_modes = getArray (_cfgItem >> 'visionMode');
						_ok = true;
						if (_nv == 0 and {{if (_x == "nvg") exitWith {1}} count _modes > 0}) then {
							_ok = false
						};
						if (_ti == 0 and {{if (_x == "ti") exitWith {1}} count _modes > 0}) then {
							_ok = false
						};
						if (_ok) then {
							_items pushBack _item
						};
					};
					if (toLower _varName find "launcher" > - 1) exitWith {
						// ti and ir check
						_modes = getArray (_cfgItem >> 'OpticsModes');
						_ok = true;
						if (_nv == 0 and {"nvg" call _fnc_launcherOptics}) then {
							_ok = false
						};
						if (_ti == 0 and {"ti" call _fnc_launcherOptics}) then {
							_ok = false
						};
						if (_ok) then {
							_items pushBack _item
						};
					};
					_items pushBack _item
				};
			} forEach _uiList;

			if empty(_items) then {
				_stringIndex = _varName find "Tier_";
				if (_stringIndex > -1) then {
					_tierNumb = parseNumber (_varName select [_stringIndex + 5,99]);
					if (_tierNumb isEqualTo 0) then {
						_item = _varName call _fnc_defaultItems;
						missionNamespace setVariable [_varName,_item];
					} else {
						missionNamespace setVariable [
							_varName,
							missionNamespace getVariable ((_varName select [0,_stringIndex + 5]) + str (_tierNumb - 1))
						]
					};
				} else {
					_list = _uiList apply {_x select 0};
					if (ncb_param_vanillaEquipmentAllowed == 0) then {
						_list2 = _list select {(_x call _fnc_getConfig) call _fnc_isAllowedVanilla};
						if not empty(_list2) then {
							_list = _list2
						};
					};
					diag("NO ENTRY - DEFAULTING");
					diag(_varName);
					diag(_list);
					missionNamespace setVariable [_varName,_list]
				}
			} else {
				missionNamespace setVariable [_varName,_items]
			};
		} forEach [
			"ai",
			"crate",
			"loot"
		];
	};
} forEach [
	"ncb_uv_masterRiflesTier_0",
	"ncb_uv_masterRiflesTier_1",
	"ncb_uv_masterRiflesTier_2",
	"ncb_uv_masterRiflesTier_3",
	"ncb_uv_masterRiflesTier_4",
	"ncb_uv_masterPistolsTier_0",
	"ncb_uv_masterPistolsTier_1",
	"ncb_uv_masterLaunchersTier_0",
	"ncb_uv_masterLaunchersTier_1",
	"ncb_uv_masterLaunchersTier_2",
	"ncb_uv_masterBarrelAttachments",
	"ncb_uv_masterScopesTier_0",
	"ncb_uv_masterScopesTier_1",
	"ncb_uv_masterScopesTier_2",
	"ncb_uv_masterScopesTier_3",
	"ncb_uv_masterSideAttachmentsTier_0",
	"ncb_uv_masterSideAttachmentsTier_1",
	"ncb_uv_masterUnderBarrelAttachments",
	"ncb_uv_masterHeadOpticsTier_0",
	"ncb_uv_masterHeadOpticsTier_1",
	"ncb_uv_masterHelmetsTier_0",
	"ncb_uv_masterHelmetsTier_1",
	"ncb_uv_masterHelmetsTier_2",
	"ncb_uv_masterHelmetsTier_3",
	"ncb_uv_masterHelmetsTier_4",
	"ncb_uv_masterHelmetsTier_5",
	"ncb_uv_masterVestsTier_0",
	"ncb_uv_masterVestsTier_1",
	"ncb_uv_masterVestsTier_2",
	"ncb_uv_masterVestsTier_3",
	"ncb_uv_masterVestsTier_4",
	"ncb_uv_masterVestsTier_5",
	"ncb_uv_masterVestsTier_6",
	"ncb_uv_masterUniformsTier_0",
	"ncb_uv_masterUniformsTier_1",
	"ncb_uv_masterUniformsTier_2",
	"ncb_uv_masterUniformsTier_3",
	"ncb_uv_masterUniformsTier_4",
	"ncb_uv_masterBinosTier_0",
	"ncb_uv_masterBinosTier_1",
	"ncb_uv_masterBinosTier_2",
	"ncb_uv_masterRockets",
	"ncb_uv_masterMagsTier_0",
	"ncb_uv_masterMagsTier_1",
	"ncb_uv_masterMagsTier_2",
	"ncb_uv_masterMagsTier_3",
	"ncb_uv_masterMagsTier_4",
	"ncb_uv_masterVehicleMagsTier_0",
	"ncb_uv_masterVehicleMagsTier_1",
	"ncb_uv_masterVehicleMagsTier_2",
	"ncb_uv_masterVehicleMagsTier_3",
	"ncb_uv_masterGrenades",
	"ncb_uv_masterUGLs",
	"ncb_uv_masterSmokes",
	"ncb_uv_masterChemLights",
	"ncb_uv_masterFlares",
	"ncb_uv_masterBackpacksTier_0",
	"ncb_uv_masterBackpacksTier_1",
	"ncb_uv_masterBackpacksTier_2",
	"ncb_uv_masterBackpacksTier_3",
	"ncb_uv_masterBackpacksTier_4",
	"ncb_uv_masterVehiclePartsTier_0",
	"ncb_uv_masterVehiclePartsTier_1",
	"ncb_uv_masterVehiclePartsTier_2",
	"ncb_uv_masterVehiclePartsTier_3",
	"ncb_uv_masterAircraftPartsTier_0",
	"ncb_uv_masterAircraftPartsTier_1",
	"ncb_uv_masterAircraftPartsTier_2",
	"ncb_uv_masterAircraftPartsTier_3",
	"ncb_uv_masterBadGuyShades",
	"ncb_uv_masterShades",
	"ncb_uv_masterMedicalItemsTier_0",
	"ncb_uv_masterMedicalItemsTier_1",
	"ncb_uv_masterFoodItemsTier_0",
	"ncb_uv_masterFoodItemsTier_1",
	"ncb_uv_masterFoodItemsTier_2",
	"ncb_uv_masterDrinkItems",
	"ncb_uv_masterRubbishItems",
	"ncb_uv_masterToolItemsTier_0",
	"ncb_uv_masterToolItemsTier_1",
	"ncb_uv_masterToolItemsTier_2",
	"ncb_uv_masterTentItems",
	"ncb_uv_masterFuelItems",
	"ncb_uv_masterPassesTier_0",
	"ncb_uv_masterPassesTier_1",
	"ncb_uv_masterMiscItems",
	"ncb_uv_masterStickyBombs",
	"ncb_uv_masterHeavyMags",
	"ncb_uv_masterWeaponBags"
];

ncb_gv_crateScopes = ncb_gv_crateScopesTier_0 + ncb_gv_crateScopesTier_1 + ncb_gv_crateScopesTier_2 + ncb_gv_crateScopesTier_3;
ncb_gv_crateRifles = ncb_gv_crateRiflesTier_0 + ncb_gv_crateRiflesTier_1 + ncb_gv_crateRiflesTier_2 + ncb_gv_crateRiflesTier_3 + ncb_gv_crateRiflesTier_4;
ncb_gv_crateBackpacks = ncb_gv_crateBackPacksTier_0 + ncb_gv_crateBackPacksTier_1 + ncb_gv_crateBackPacksTier_2 + ncb_gv_crateBackPacksTier_3 + ncb_gv_crateBackPacksTier_4;
ncb_gv_crateVests = ncb_gv_crateVestsTier_0 + ncb_gv_crateVestsTier_1 + ncb_gv_crateVestsTier_2 + ncb_gv_crateVestsTier_3 + ncb_gv_crateVestsTier_4 + ncb_gv_crateVestsTier_5 + ncb_gv_crateVestsTier_6;
ncb_gv_crateHelmets = ncb_gv_crateHelmetsTier_0 + ncb_gv_crateHelmetsTier_1 + ncb_gv_crateHelmetsTier_2 + ncb_gv_crateHelmetsTier_3 + ncb_gv_crateHelmetsTier_4 + ncb_gv_crateHelmetsTier_5;
ncb_gv_crateMedicalItems = ncb_gv_crateMedicalItemsTier_0 + ncb_gv_crateMedicalItemsTier_1;
ncb_gv_crateFoodItems = ncb_gv_crateFoodItemsTier_0 + ncb_gv_crateFoodItemsTier_1 + ncb_gv_crateFoodItemsTier_2;
ncb_gv_crateToolItems = ncb_gv_crateToolItemsTier_0 + ncb_gv_crateToolItemsTier_1 + ncb_gv_crateToolItemsTier_2;
ncb_gv_crateLaunchers = ncb_gv_crateLaunchersTier_0 + ncb_gv_crateLaunchersTier_1 + ncb_gv_crateLaunchersTier_2;
ncb_gv_crateVehicleParts = ncb_gv_crateVehiclePartsTier_0 + ncb_gv_crateVehiclePartsTier_1 + ncb_gv_crateVehiclePartsTier_2 + ncb_gv_crateVehiclePartsTier_3 + ncb_gv_crateAircraftPartsTier_0 + ncb_gv_crateAircraftPartsTier_1 + ncb_gv_crateAircraftPartsTier_2 + ncb_gv_crateAircraftPartsTier_3;
ncb_gv_crateVehicleMags = ncb_gv_crateVehicleMagsTier_0 + ncb_gv_crateVehicleMagsTier_1 + ncb_gv_crateVehicleMagsTier_2 + ncb_gv_crateVehicleMagsTier_3;


ncb_gv_renegadeRandomItemTypes = ncb_gv_aiGrenades + ncb_gv_aiFoodItemsTier_0 + ncb_gv_aiDrinkItems + ncb_gv_aiTentItems + ncb_gv_aiFuelItems + ncb_gv_aiMedicalItemsTier_0 + ncb_gv_aiToolItemsTier_0 + ncb_gv_aiPassesTier_0 + ncb_gv_aiStickyBombs + ncb_gv_aiMiscItems - ["PortableGenerator_backpack_F"];

ncb_gv_enemyRandomItemTypes = ncb_gv_aiFoodItemsTier_0 + ncb_gv_aiDrinkItems + ncb_gv_aiMedicalItemsTier_0 + ["BreachingCharge_Remote_Mag"];

// check rifles
diag_log "/-----------------------------------/";
diag(ncb_gv_aiRiflesTier_0);
diag(ncb_gv_aiRiflesTier_1);
diag(ncb_gv_aiRiflesTier_2);
diag(ncb_gv_aiRiflesTier_3);
diag_log "/-----------------------------------/";

// code to call for enemy generation

ncb_gv_aiSkills = [
	ncb_param_aiSkillGeneral / 100,
	ncb_param_aiSkillAimingAccuracy / 100,
	ncb_param_aiSkillAimingSteadiness / 100,
	ncb_param_aiSkillAimingSpeed / 100,
	ncb_param_aiSkillCommanding / 100,
	ncb_param_aiSkillCourage / 100,
	ncb_param_aiSkillEndurance / 100,
	ncb_param_aiSkillReloadSpeed / 100,
	ncb_param_aiSkillSpotDistance / 100,
	ncb_param_aiSkillSpotTime / 100
];

ncb_gv_enemyUnitVariables = {
	[
		["ncb_gv_enemyUnitPool",ncb_gv_enemyUnitPoolPos,ncb_gv_enemyUnitTypes],
		ncb_gv_uniformGunmanTypes,
		ncb_gv_armourTypesGunman,
		0.25,
		ncb_gv_backpackTypes,
		0.75,
		ncb_gv_hatTypes,
		0.75,
		ncb_gv_aiShades,
		0,
		ncb_gv_aiHeadOpticsTier_0,
		ncb_param_aiPrimaryWeaponChance,
		missionNamespace getVariable ("ncb_gv_aiRiflesTier_" + str round random [
			ncb_param_enemyUnitMinWeaponTier,
			ncb_param_enemyUnitMidWeaponTier,
			ncb_param_enemyUnitMaxWeaponTier
		]),
		[3,6],
		0.3,
		0.75,
		missionNamespace getVariable ("ncb_gv_aiScopesTier_" + str (randInteg(0,1))),
		1 - sunOrMoon,
		["acc_flashlight"],
		ncb_param_aiSecondaryWeaponChance,
		missionNamespace getVariable ("ncb_gv_aiLaunchersTier_" + str round random [
			ncb_param_enemyUnitMinLauncherTier,
			ncb_param_enemyUnitMidLauncherTier,
			ncb_param_enemyUnitMaxLauncherTier
		]),
		[1,2],
		ncb_param_aiHandgunWeaponChance,
		ncb_gv_aiPistolsTier_0,
		[2,3],
		0.2,
		0.2,
		[qty_2("SmokeShell"),qty_2("Chemlight_blue"),"HandGrenade"],
		[
			[["Binocular","ItemCompass","ItemMap"],0.3],
			[["ItemBandage","ItemBandage","ItemBandage","ItemBandage","ItemMedigel","ItemBloodBag","ItemBloodBag","ItemMedPack"],0.5],
			[ncb_gv_aiPassesTier_0,0.1],
			[ncb_gv_enemyRandomItemTypes,0.1]
		],
		ncb_gv_aiSkills
	]
};
ncb_gv_enemyParaVariables = {
	[
		["ncb_gv_enemyParaPool",ncb_gv_enemyParaPoolPos,ncb_gv_enemyParaTypes],
		ncb_gv_uniformParaTypes,
		ncb_gv_armourTypesPara,
		0.25,
		ncb_gv_backpackTypes,
		1,
		["H_HelmetSpecB_blk"],
		0.75,
		ncb_gv_aiBadGuyShades,
		1 - sunOrMoon, // nvg chance
		ncb_gv_aiHeadOpticsTier_0,
		ncb_param_aiPrimaryWeaponChance,
		missionNamespace getVariable ("ncb_gv_aiRiflesTier_" + str round random [
			ncb_param_enemyParaMinWeaponTier,
			ncb_param_enemyParaMidWeaponTier,
			ncb_param_enemyParaMaxWeaponTier
		]),
		[3,6],
		0.3,
		0.75,
		ncb_gv_aiScopesTier_1,
		1 - sunOrMoon,
		["acc_pointer_IR"],
		ncb_param_aiSecondaryWeaponChance,
		missionNamespace getVariable ("ncb_gv_aiLaunchersTier_" + str round random [
			ncb_param_enemyParaMinLauncherTier,
			ncb_param_enemyParaMidLauncherTier,
			ncb_param_enemyParaMaxLauncherTier
		]),
		[1,2],
		ncb_param_aiHandgunWeaponChance,
		missionNamespace getVariable ("ncb_gv_aiPistolsTier_" + str (randInteg(0,1))),
		[2,3],
		0.2,
		0.2,
		[qty_2("SmokeShell"),qty_2("Chemlight_blue"),"HandGrenade"],
		[
			[["Binocular","ItemCompass","ItemMap"],0.3],
			[["ItemBandage","ItemBandage","ItemBandage","ItemBandage","ItemMedigel","ItemBloodBag","ItemBloodBag","ItemMedPack"],0.5],
			[ncb_gv_aiPassesTier_0,0.1],
			[ncb_gv_enemyRandomItemTypes,0.15]
		],
		ncb_gv_aiSkills
	]
};
ncb_gv_enemySniperVariables = {
	[
		["ncb_gv_enemySniperPool",ncb_gv_enemySniperPoolPos,ncb_gv_enemySniperTypes],
		ncb_gv_uniformSniperTypes,
		ncb_gv_armourTypesSniper,
		0.25,
		ncb_gv_backpackTypes,
		0.75,
		[],
		0.75,
		[],
		0,
		ncb_gv_aiHeadOpticsTier_0,
		ncb_param_aiPrimaryWeaponChance,
		missionNamespace getVariable ("ncb_gv_aiRiflesTier_" + str round random [
			ncb_param_enemySniperMinWeaponTier,
			ncb_param_enemySniperMidWeaponTier,
			ncb_param_enemySniperMaxWeaponTier
		]),
		[3,6],
		0.3,
		0.75,
		missionNamespace getVariable ("ncb_gv_aiScopesTier_" + str (randInteg(1,2))),
		1 - sunOrMoon,
		["acc_flashlight"],
		0,
		[],
		[1,2],
		ncb_param_aiHandgunWeaponChance,
		missionNamespace getVariable ("ncb_gv_aiPistolsTier_" + str (randInteg(0,1))),
		[2,3],
		0.2,
		0.2,
		[qty_2("SmokeShell"),qty_2("Chemlight_blue"),"HandGrenade"],
		[
			[["Binocular","ItemCompass","ItemMap"],0.3],
			[["ItemBandage","ItemBandage","ItemBandage","ItemBandage","ItemMedigel","ItemBloodBag","ItemBloodBag","ItemMedPack"],0.5],
			[ncb_gv_aiPassesTier_0,0.1],
			[ncb_gv_enemyRandomItemTypes,0.15]
		],
		ncb_gv_aiSkills
	]
};
ncb_gv_enemyDiverVariables = {
	[
		["ncb_gv_enemyDiverPool",ncb_gv_enemyDiverPoolPos,ncb_gv_enemyDiverTypes],
		["U_O_Wetsuit"],
		["V_RebreatherIR"],
		0.25,
		["B_FieldPack_blk"],
		0,
		[],
		1,
		["G_O_Diving"],
		0,
		ncb_gv_aiHeadOpticsTier_0,
		1,
		["arifle_SDAR_F"],
		[3,6],
		0,
		0,
		[],
		0,
		[],
		ncb_param_aiSecondaryWeaponChance,
		missionNamespace getVariable ("ncb_gv_aiLaunchersTier_" + str round random [
			ncb_param_enemyUnitMinLauncherTier,
			ncb_param_enemyUnitMidLauncherTier,
			ncb_param_enemyUnitMaxLauncherTier
		]),
		[1,2],
		ncb_param_aiHandgunWeaponChance,
		missionNamespace getVariable ("ncb_gv_aiPistolsTier_" + str (randInteg(0,1))),
		[2,3],
		0.2,
		0.2,
		[qty_2("SmokeShell"),qty_2("Chemlight_blue"),"HandGrenade"],
		[
			[["Binocular","ItemCompass","ItemMap"],0.3],
			[["ItemBandage","ItemBandage","ItemBandage","ItemBandage","ItemMedigel","ItemBloodBag","ItemBloodBag","ItemMedPack"],0.5],
			[ncb_gv_aiPassesTier_0,0.1],
			[ncb_gv_enemyRandomItemTypes,0.15]
		],
		ncb_gv_aiSkills
	]
};
ncb_gv_renegadeVariables = {
	[
		["ncb_gv_renegadePool",ncb_gv_renegadePoolPos,ncb_gv_renegadeTypes],
		ncb_gv_uniformRenegadeTypes,
		[],
		0.25,
		["B_OutdoorPack_blu"],
		0.75,
		ncb_gv_renegadeHatTypes,
		0.75,
		ncb_gv_aiBadGuyShades,
		0,
		ncb_gv_aiHeadOpticsTier_0,
		ncb_param_renPrimaryWeaponChance,
		missionNamespace getVariable ("ncb_gv_aiRiflesTier_" + str round random [
			ncb_param_renMinWeaponTier,
			ncb_param_renMidWeaponTier,
			ncb_param_renMaxWeaponTier
		]),
		[3,6],
		0.3,
		0.75,
		missionNamespace getVariable ("ncb_gv_aiScopesTier_" + str (randInteg(0,1))),
		1 - sunOrMoon,
		["acc_flashlight"],
		ncb_param_renSecondaryWeaponChance,
		missionNamespace getVariable ("ncb_gv_aiLaunchersTier_" + str round random [
			ncb_param_renMinLauncherTier,
			ncb_param_renMidLauncherTier,
			ncb_param_renMaxLauncherTier
		]),
		[1,2],
		ncb_param_renHandgunWeaponChance,
		missionNamespace getVariable ("ncb_gv_aiPistolsTier_" + str (randInteg(0,1))),
		[2,3],
		0.2,
		0.2,
		[qty_2("SmokeShell"),qty_2("Chemlight_blue"),"HandGrenade"],
		[
			[["ItemBandage","ItemBandage","ItemBandage","ItemBandage","ItemMedigel","ItemBloodBag","ItemBloodBag","ItemMedPack"],0.5],
			[ncb_gv_renegadeRandomItemTypes,0.1],
			[ncb_gv_renegadeRandomItemTypes,0.1],
			[ncb_gv_renegadeRandomItemTypes,0.1]
		],
		ncb_gv_aiSkills
	];
};
// ENEMY VEHICLES

_fnc_getVehicleClasses = {
	params ["_classes","_factions","_baseClasses"];
	{
		private _config = _x;
		private _class = configName _x;
		{
			if (getText (_config >> "faction") == _x
				and {{_class isKindOf _x} count _baseClasses > 0}
				and {getNumber (_config >> "scope") == 2}
			) then {
				_classes pushBack _class
			};
		} forEach _factions;
	} forEach ("true" configClasses (configFile >> "CfgVehicles"));
	_classes
};
_classes = [

];
ncb_gv_renegadeCarTypes =  [
	"ncb_veh_offroad_turbo",
	"ncb_veh_offroad_hmg",
	"ncb_veh_prowler_black",
	"ncb_veh_prowler_olive",
	"ncb_veh_van_transport",
	"ncb_veh_hunter_gmg",
	"ncb_veh_hunter_hmg"
];
ncb_gv_enemyPatrolBoatTypes = [
	"ncb_boat_speedboat_hmg",
	"ncb_boat_speedboat_minigun"
];
ncb_gv_enemyInflatableTypes = [
	/*"ncb_boat_inflatable",
	"ncb_boat_inflatable",*/
	"ncb_boat_rhib"
];
ncb_gv_enemyCarTypes =  [
	"ncb_veh_offroad_unarmed",
	"ncb_veh_offroad_unarmed",
	"ncb_veh_offroad_unarmed",
	"ncb_veh_4wd_unarmed",
	"ncb_veh_4wd_unarmed",
	"ncb_veh_ifrit"
];
ncb_gv_enemyTruckTypes = [
	"ncb_veh_van_transport",
	"ncb_veh_van_transport",
	"ncb_veh_van_transport",
	"ncb_veh_van_transport",
	"ncb_veh_zamak_covered",
	"ncb_veh_zamak_open",
	"ncb_veh_tempest_covered",
	"ncb_veh_tempest_open"
];
ncb_gv_enemyTechnicalTypes = [
	"ncb_veh_offroad_hmg",
	"ncb_veh_offroad_hmg",
	"ncb_veh_offroad_at",
	"ncb_veh_offroad_at",
	"ncb_veh_4wd_at",
	"ncb_veh_4wd_at",
	"ncb_veh_4wd_lmg",
	"ncb_veh_4wd_lmg",
	"ncb_veh_qilin_minigun",
	"ncb_veh_qilin_minigun",
	"ncb_veh_ifrit_gmg",
	"ncb_veh_ifrit_hmg"
];
ncb_gv_enemyAPCTypes = [
	/*"ncb_veh_kamysh",*/
	"ncb_veh_marid_v2",
	"ncb_veh_marid"
];
ncb_gv_enemyStaticMGLoTypes = [
	"ncb_static_hmg_low"
];
ncb_gv_enemyStaticMGHiTypes = [
	"ncb_static_hmg_high"
];
ncb_gv_enemyStaticAATypes = [
	"ncb_static_aa"
];
ncb_gv_enemyStaticATTypes = [
	"ncb_static_at"
];
ncb_gv_enemyMortarTypes = [
	"ncb_static_mortar"
];
ncb_gv_enemyAttackHeliTypes = [
	"ncb_vtol_xian_infantry",
	"ncb_heli_kajman",
	"ncb_heli_kajman_black",
	"ncb_heli_hellcat",
	"ncb_heli_hellcat",
	"ncb_heli_orca",
	"ncb_heli_orca"
];
if (isClass (configFile >> "CfgPatches" >> "rhs_c_troops")) then {
	ncb_gv_enemyAttackHeliTypes = [[],["rhs_faction_vvs","rhs_faction_vvs_c"],["Heli_Attack_02_base_F"]] call _fnc_getVehicleClasses
};

ncb_gv_enemyTransportHeliTypes = [
	"ncb_heli_mohawk"
];
if (isClass (configFile >> "CfgPatches" >> "rhs_c_troops")) then {
	ncb_gv_enemyTransportHeliTypes = [[],["rhs_faction_vvs","rhs_faction_vvs_c"],["RHS_Mi8_base"]] call _fnc_getVehicleClasses
};


ncb_gv_enemyDropPodHeliTypes = [
	"ncb_heli_taru"
];

ncb_gv_enemyDropPodTypes = [
	"ncb_pod_taru_transport"
];

// now work out what mags they all need

_list = "configName _x find 'ncb_' > -1 and {not (configName _x isKindOf 'Man')} and {configName _x isKindOf 'AllVehicles'} and {getNumber (_x >> 'scope') == 2} and {getText (_x >> 'model') != ''}" configClasses (configFile >> "CfgVehicles");
_list = _list apply {configName _x};
{
	_x call _fnc_magsForVehiclesInit
} forEach _list;
_list = nil;

// EMPTIES

ncb_gv_enemyCivVehTypes = [
	"ncb_veh_hatchback",
	"ncb_veh_hatchback_sport",
	"ncb_veh_offroad",
	"ncb_veh_quadbike",
	"ncb_veh_suv",
	"ncb_veh_van_box",
	"ncb_veh_van_transport",
	"ncb_veh_4wd_unarmed"
];
ncb_gv_enemyIndVehTypes = [
	"ncb_veh_offroad",
	"ncb_veh_quadbike",
	"ncb_veh_suv",
	"ncb_veh_van_box",
	"ncb_veh_van_transport",
	"ncb_veh_zamak_covered_industrial",
	"ncb_veh_zamak_open_industrial",
	"ncb_veh_4wd_unarmed"
];
ncb_gv_enemyMilVehTypes = [
	"ncb_veh_quadbike",
	"ncb_veh_quadbike",
	"ncb_veh_quadbike",
	"ncb_veh_quadbike",
	"ncb_veh_offroad_unarmed",
	"ncb_veh_offroad_unarmed",
	"ncb_veh_offroad_unarmed",
	"ncb_veh_offroad_unarmed",
	"ncb_veh_4wd_unarmed",
	"ncb_veh_4wd_unarmed",
	"ncb_veh_4wd_unarmed",
	"ncb_veh_4wd_unarmed",
	"ncb_veh_zamak_covered",
	"ncb_veh_zamak_covered",
	"ncb_veh_zamak_open",
	"ncb_veh_zamak_open",
	"ncb_veh_tempest_covered",
	"ncb_veh_tempest_covered",
	"ncb_veh_tempest_open",
	"ncb_veh_tempest_open",
	"ncb_veh_ifrit",
	"ncb_veh_ifrit",
	"ncb_veh_ifrit",
	"ncb_veh_ifrit",
	"ncb_veh_ifrit_gmg",
	"ncb_veh_ifrit_gmg",
	"ncb_veh_ifrit_gmg",
	"ncb_veh_ifrit_gmg",
	"ncb_veh_ifrit_hmg",
	"ncb_veh_ifrit_hmg",
	"ncb_veh_ifrit_hmg",
	"ncb_veh_ifrit_hmg",
	"ncb_veh_offroad_hmg",
	"ncb_veh_offroad_hmg",
	"ncb_veh_offroad_hmg",
	"ncb_veh_offroad_hmg",
	"ncb_veh_offroad_at",
	"ncb_veh_offroad_at",
	"ncb_veh_4wd_at",
	"ncb_veh_4wd_at",
	"ncb_veh_4wd_lmg",
	"ncb_veh_4wd_lmg",
	"ncb_veh_qilin_minigun",
	"ncb_veh_qilin_minigun",
	"ncb_veh_qilin_minigun",
	"ncb_veh_qilin_minigun",
	"ncb_veh_marid",
	"ncb_veh_marid_v2",
	"ncb_heli_orca_unarmed",
	"ncb_heli_orca",
	"I_Heli_Transport_02_F"
];

// VEHICLE TEXTURES

ncb_gv_civOffroadTextures = [
	"\A3\soft_F\Offroad_01\Data\Offroad_01_ext_co.paa",
	"\A3\soft_F\Offroad_01\Data\Offroad_01_ext_BASE01_CO.paa",
	"\A3\soft_F\Offroad_01\Data\Offroad_01_ext_BASE02_CO.paa",
	"\A3\soft_F\Offroad_01\Data\Offroad_01_ext_BASE03_CO.paa",
	"\A3\soft_F\Offroad_01\Data\Offroad_01_ext_BASE04_CO.paa",
	"\A3\soft_F\Offroad_01\Data\Offroad_01_ext_BASE05_CO.paa"
];
ncb_gv_milOffroadTextures = [
	"\A3\Soft_F_Bootcamp\Offroad_01\Data\offroad_01_ext_IG_01_CO.paa",
	"\A3\Soft_F_Bootcamp\Offroad_01\Data\offroad_01_ext_IG_02_CO.paa",
	"\A3\Soft_F_Bootcamp\Offroad_01\Data\offroad_01_ext_IG_03_CO.paa",
	"\A3\Soft_F_Bootcamp\Offroad_01\Data\offroad_01_ext_IG_04_CO.paa",
	"\A3\Soft_F_Bootcamp\Offroad_01\Data\offroad_01_ext_IG_05_CO.paa",
	"\A3\Soft_F_Bootcamp\Offroad_01\Data\offroad_01_ext_IG_06_CO.paa",
	"\A3\Soft_F_Bootcamp\Offroad_01\Data\offroad_01_ext_IG_07_CO.paa",
	"\A3\Soft_F_Bootcamp\Offroad_01\Data\offroad_01_ext_IG_08_CO.paa",
	"\A3\Soft_F_Bootcamp\Offroad_01\Data\offroad_01_ext_IG_09_CO.paa",
	"\A3\Soft_F_Bootcamp\Offroad_01\Data\offroad_01_ext_IG_10_CO.paa",
	"\A3\Soft_F_Bootcamp\Offroad_01\Data\offroad_01_ext_IG_11_CO.paa",
	"\A3\Soft_F_Bootcamp\Offroad_01\Data\offroad_01_ext_IG_12_CO.paa"
];
ncb_gv_quadTexturesA = [
	"\A3\Soft_F_Bootcamp\Quadbike_01\Data\Quadbike_01_INDP_Hunter_CO.paa",
	"\A3\Soft_F_Bootcamp\Quadbike_01\Data\Quadbike_01_IG_CO.paa"
];
ncb_gv_quadTexturesB = [
	"\A3\Soft_F_Beta\Quadbike_01\Data\Quadbike_01_wheel_CIVBLACK_CO.paa",
	"\A3\Soft_F_Beta\Quadbike_01\Data\Quadbike_01_wheel_CIVBLACK_CO.paa"
];
ncb_gv_suvTextures = [
	"\A3\Soft_F_Gamma\SUV_01\Data\SUV_01_ext_CO.paa",
	"\A3\Soft_F_Gamma\SUV_01\Data\SUV_01_ext_02_CO.paa",
	"\A3\Soft_F_Gamma\SUV_01\Data\SUV_01_ext_03_CO.paa",
	"\A3\Soft_F_Gamma\SUV_01\Data\SUV_01_ext_04_CO.paa"
];
ncb_gv_vanTexturesA = [
	"\A3\Soft_F_Bootcamp\Van_01\Data\Van_01_ext_IG_01_CO.paa",
	"\A3\Soft_F_Bootcamp\Van_01\Data\Van_01_ext_IG_03_CO.paa",
	"\A3\Soft_F_Bootcamp\Van_01\Data\Van_01_ext_IG_03_CO.paa",
	"\A3\Soft_F_Bootcamp\Van_01\Data\Van_01_ext_IG_04_CO.paa",
	"\A3\Soft_F_Bootcamp\Van_01\Data\Van_01_ext_IG_05_CO.paa",
	"\A3\Soft_F_Bootcamp\Van_01\Data\Van_01_ext_IG_06_CO.paa",
	"\A3\Soft_F_Bootcamp\Van_01\Data\Van_01_ext_IG_07_CO.paa",
	"\A3\Soft_F_Bootcamp\Van_01\Data\Van_01_ext_IG_08_CO.paa",
	"\A3\Soft_F_Exp\Van_01\Data\Van_01_ext_oli_co.paa",
	"\A3\Soft_F_Exp\Van_01\Data\Van_01_ext_brn_co.paa"
];
ncb_gv_vanTexturesB = [
	"\A3\Soft_F_Bootcamp\Van_01\Data\Van_01_adds_IG_01_CO.paa",
	"\A3\Soft_F_Bootcamp\Van_01\Data\Van_01_adds_IG_03_CO.paa",
	"\A3\Soft_F_Bootcamp\Van_01\Data\Van_01_adds_IG_03_CO.paa",
	"\A3\Soft_F_Bootcamp\Van_01\Data\Van_01_adds_IG_04_CO.paa",
	"\A3\Soft_F_Bootcamp\Van_01\Data\Van_01_adds_IG_05_CO.paa",
	"\A3\Soft_F_Bootcamp\Van_01\Data\Van_01_adds_IG_06_CO.paa",
	"\A3\Soft_F_Bootcamp\Van_01\Data\Van_01_adds_IG_07_CO.paa",
	"\A3\Soft_F_Bootcamp\Van_01\Data\Van_01_adds_IG_08_CO.paa",
	"\A3\soft_f_gamma\van_01\Data\van_01_adds_CO.paa",
	"\A3\soft_f_gamma\van_01\Data\van_01_adds_CO.paa"
];

ncb_gv_alphabet = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"];

if (ncb_param_civilianEnable) then {
	/*#include ((parsingNamespace getVariable "NOCEBO_MISSION_ROOT") + "server\zones\manager\civilianVariables.sqf")*/
	call horde_fnc_civilianVariables
};

// add custom locations
ncb_pv_customLocations = {
	if (worldName == "tanoa") exitWith {
		// zone 11
		_location = createLocation [ "NameVillage" ,[4329.84,2999.53,0],50,50];
		_location setText "Wilderness";
	};
	if (worldName == "malden") exitWith {
		// zone 2
		_location = createLocation [ "NameLocal" ,[1338,1850,0],50,50];
		_location setText "Cabot Cove";
		// zone 42
		_location = createLocation [ "NameVillage" ,[5900,10800,0],50,50];
		_location setText "Abandoned Military Base - West";
		// zone 43
		_location = createLocation [ "NameVillage" ,[6220,10730,0],50,50];
		_location setText "Abandoned Military Base - East";
	};
};
call ncb_pv_customLocations;
publicVariable "ncb_pv_customLocations";

_cfgZones = configfile >> "CfgZones" >> worldName;
ncb_gv_mapRoadDeadEnds = [];
ncb_gv_mapRoadJunctions = [];
ncb_gv_mapRoadSegments = [];
ncb_gv_zoneMapHelipads = [];
ncb_gv_zonesWithEmptySpace = [];
ncb_pv_playerSpawnPlaces = [];

for "_i" from 0 to count _cfgZones - 1 do {
	_cfgZone = sel(_cfgZones,_i);
	_zoneName = configName _cfgZone;
	if (true) then {
	// FIND NEW DEBUG ISLAND
	/*_number = parseNumber (_zoneName select [10,99]);
	if (_number == 39) then {*/
		_zonePosASL = getArray (_cfgZone >> "zonePositionASL");
		_cfgRoadData = _cfgZone >> "Roads";
		{
			ncb_gv_mapRoadDeadEnds pushBack _x;
			true
		} count (getArray (_cfgRoadData >> "deadEnds"));
		{
			ncb_gv_mapRoadJunctions pushBack _x;
			true
		} count (getArray (_cfgRoadData >> "junctions"));
		{
			ncb_gv_mapRoadSegments pushBack _x;
			true
		} count (getArray (_cfgRoadData >> "roads"));
		// add zones beach spawns to global array
		{
			_x params ["_beachPosASL","_ingressPosASL"];
			if ({(_x select 0) distance2D _beachPosASL < 100} count ncb_pv_playerSpawnPlaces isEqualTo 0
			    and {not (nearestLocations [ASLtoAGL _beachPosASL, ["NameCity","NameCityCapital","NameVillage","NameLocal","Airport"],500] isEqualTo [])}
			) then {
				ncb_pv_playerSpawnPlaces pushBack [
					_beachPosASL,
					round (_ingressPosASL getDir _beachPosASL)
				];
				/*_mkr = createMarker [_zoneName + "INIT" + str _beachPosASL,_beachPosASL];
				_mkr setMarkerSize [20, 20];
				_mkr setMarkerShape "Ellipse";
				_mkr setMarkerBrush "SolidBorder";
				_mkr setMarkerColor "ColorGreen";
				_mkr setMarkerAlpha 1;*/
			};
		} forEach (getArray (_cfgZone >> "BeachHead" >> "ingressDataASL"));

		// ADD MANUALLY PLACED LOCATIONS

		_locations = getArray (_cfgZone >> "ClosestLocations" >> "locations");
		{
			_type = _x;
			{
					private _loc = _x;
					private _add = true;
					{
						if (locationPosition _loc distance2D (_x select 2) < 5) exitWith {
							_add = false;
						}
					} count _locations;
					if (_add) then {
						_locations pushBack [_type,text _loc,locationPosition _loc]
					}
			} forEach (nearestLocations [ASLtoAGL _zonePosASL,[_type],ncb_gv_zoneRadius])
		} forEach [
			"NameCityCapital",
			"CityCenter",
			"NameCity",
			"NameVillage",
			"NameLocal",
			"NameMarine"
		];

		// WORK OUT ZONE VALUE
		_zoneValue = 0;
		{
			_locType = sel(_x,0);
			call {
				if same(_locType,"NameCityCapital") exitWith {
					if (_zoneValue < ncb_param_zoneLocationValueNameCityCapital) then {
						_zoneValue = ncb_param_zoneLocationValueNameCityCapital;
					};
				};
				if same(_locType,"CityCenter") exitWith {
					if (_zoneValue < ncb_param_zoneLocationValueCityCenter) then {
						_zoneValue = ncb_param_zoneLocationValueCityCenter;
					};
				};
				if same(_locType,"NameCity") exitWith {
					if (_zoneValue < ncb_param_zoneLocationValueNameCity) then {
						_zoneValue = ncb_param_zoneLocationValueNameCity;
					};
				};
				if same(_locType,"NameVillage") exitWith {
					if (_zoneValue < ncb_param_zoneLocationValueNameVillage) then {
						_zoneValue = ncb_param_zoneLocationValueNameVillage;
					};
				};
				if same(_locType,"NameLocal") exitWith {
					if (_zoneValue < ncb_param_zoneLocationValueNameLocal) then {
						_zoneValue = ncb_param_zoneLocationValueNameLocal;
					};
				};
				if same(_locType,"NameMarine") exitWith {
					if (_zoneValue < ncb_param_zoneLocationValueNameMarine) then {
						_zoneValue = ncb_param_zoneLocationValueNameMarine;
					};
				};
			};
			true
		} count _locations;
		_patrolLandASLData = getArray(_cfgZone >> "PatrolData" >> "patrolLandASL");

		if (_zoneValue > 0 and {not empty(_patrolLandASLData)}) then {
			_zone = "Zone_Logic" createVehicleLocal ASLtoATL _zonePosASL;
			_zone setPosASL _zonePosASL;
			_zone setVectorDirAndUp [[0,1,0],[0,0,1]];
			ncb_gv_zoneList pushBack _zone;
			_zone setVehicleVarName _zoneName;
			missionNamespace setVariable [_zoneName,_zone];

			// make sure the zone value isn't higher than amount of available patrol routes

			if (_zoneValue > count _patrolLandASLData) then {
				_zoneValue = count _patrolLandASLData
			};

			// does zone have airbase (helipad)
			_helipadArr = ASLtoAGL _zonePosASL nearObjects ["HeliH",ncb_gv_zoneRadius];
			if (_helipadArr isEqualTo []) then {
				_helipadPositionsASL = getArray(_cfgZone >> "AirBaseData" >> "heliPadPositionsASL");
				if not (_helipadPositionsASL isEqualTo []) then {
					_pad = createVehicle [selectRandom ["Land_HelipadCircle_F","Land_HelipadSquare_F"],ASLtoAGL selectRandom _helipadPositionsASL,[],0,"can_collide"];
					_helipadArr = [_pad]
				};
			};
			if not (_helipadArr isEqualTo []) then {
				ncb_gv_zoneMapHelipads pushBack _zone
			};

			// does zone have any spaces for radio station / artillery
			_emptyPlacesASL = getArray (_cfgZone >> "EmptyPlaces" >> "EmptyPlacesASL_20");
			if not empty(_emptyPlacesASL) then {
				// minimum amount of patrol data needed to allow being a secondary task zone!
				if (count _patrolLandASLData > 4) then {
					ncb_gv_zonesWithEmptySpace pushBack _zone;
				};
			};

			if (ncb_param_debugMode == 1) then {
				_mkr = createMarker [_zoneName + "INIT",_zonePosASL];
				_mkr setMarkerSize [1000, 1000];
				_mkr setMarkerShape "Ellipse";
				_mkr setMarkerBrush "SolidBorder";
				_mkr setMarkerColor "ColorGreen";
				_mkr setMarkerAlpha 0.3;

				_mssg = format ["%1 value is: %2 - patrols: %3",_zoneName,_zoneValue,count _patrolLandASLData];
				_mkrName = _zoneName + "INFO";
				testMarker(_mkrName,_zonePosASL,_mssg);
			};

			// naval mine positions (max 500 at the moment)
			if (ncb_param_navalMines > 0) then {
				_minePositions = [];
				{
					_x params ["_pos"];
					if (getTerrainHeightASL _pos > -30
						and {getTerrainHeightASL _pos < -6}
						and {surfaceIsWater _pos}
						and {{_pos distance2D _x < 100} count _minePositions == 0}
					) then {
						_minePositions pushBack _pos
					};
				} forEach selectBestPlaces [
					_zonePosASL,
					ncb_gv_zoneRadius,
					"sea",
					5,
					500
				];
				_minePositions2 = [];
				for "_i" from 1 to count _minePositions -1 do {
					if ([] isEqualTo _minePositions) exitWith {};
					if (random 1 < ncb_param_navalMines) then {
						_minePositions2 pushBack (_minePositions deleteAt floor random count _minePositions)
					}
				};
				setVar(_zone,"zoneNavalMinePositions",_minePositions2);
			};

			_buildingArr = [];
			_vantagePointsLow = [];
			_vantagePointsHigh = [];
			_vantagePointsAirBaseLow = [];
			_vantagePointsAirBaseHigh = [];
			_staticPoints = [];
			_staticPointsAirBase = [];

			// test (used for secondary missions)
			_militaryBuildings = [];

			// try generating on the fly... (compare speed to pulling info from config)

			// test saving to profileNamespace

			_buildingArr = ASLtoAGL _zonePosASL nearObjects ["building",ncb_gv_zoneRadius];

			{
				_building = _x;
				if (isNil {_building getVariable "objectAssignedToZone"}) then {
				/*if (true) then {*/
					setVar(_building,"objectAssignedToZone",_zone);
					_buildingClass = typeOf _building;
					_buildingDir = getDir _building;
					_cfgBuilding = cfgVeh >> _buildingClass;
					_staticWeaponData = getArray (_cfgBuilding >> "staticWeaponData");
					_unitData = getArray (_cfgBuilding >> "unitData");
					_lootData = getArray (_cfgBuilding >> "lootData");
					_buildingType = getText (_cfgBuilding >> "horde_objectType");
					_alarmBuilding = if ({_buildingClass isKindOf _x} count ncb_gv_alarmBuildingBaseClasses > 0) then {true} else {false};

					// save to/load from profile
					if (ncb_param_loadZonesFromProfile == createZoneConfig) then {
						if not empty(_unitData) then {
							{
								_x params ["_modelPos","_relDir","_posArr"];
								_worldPos = _building modelToWorld _modelPos;
								_worldDir = (_relDir + _buildingDir) call horde_fnc_normalDir;
								_targetPositions = [];
								{
									_x params ["_text","_relAngles"];
									{
										_targetPos = _worldPos getPos [100,(_x + _buildingDir) call horde_fnc_normalDir];
										if (sel(AGLtoASL _targetPos,2) < sel(AGLtoASL _worldPos,2)) then {
											_targetPos = _targetPos vectorAdd [0,0,sel(AGLtoASL _worldPos,2) - sel(AGLtoASL _targetPos,2)];
										} else {
											_targetPos = _targetPos vectorAdd [0,0,10];
										};
										if (not lineIntersects [AGLtoASL _worldPos,AGLtoASL _targetPos,_building]
											and {not terrainIntersect [_worldPos,_targetPos]}
										) then {
											_targetPositions pushBack [_targetPos call _fnc_roundArray,_text];
										};
										true
									} count _relAngles;
									true
								} count _posArr;
								/*if not empty(_targetPositions) then {*/
								if (count _targetPositions > 1) then {
									if (not empty(_helipadArr)
										and {_worldPos distance2D sel(_helipadArr,0) < 500}
									) then {
										call {
											if (sel(_worldPos,2) > 15 or {_alarmBuilding and {sel(_worldPos,2) > 3}}) exitWith {
												_vantagePointsAirBaseHigh pushBack [_worldPos,_worldDir,_targetPositions,_alarmBuilding,surfaceIsWater _worldPos];
											};
											if (sel(_worldPos,2) > 3) exitWith {
												_vantagePointsAirBaseLow pushBack [_worldPos,_worldDir,_targetPositions,_alarmBuilding,surfaceIsWater _worldPos];
											};
										};
									};
									call {
										if (sel(_worldPos,2) > 15 or {_alarmBuilding and {sel(_worldPos,2) > 3}}) exitWith {
											_vantagePointsHigh pushBack [_worldPos, _worldDir, _targetPositions,_alarmBuilding,surfaceIsWater _worldPos];
										};
										if (sel(_worldPos,2) > 3) exitWith {
											_vantagePointsLow pushBack [_worldPos, _worldDir, _targetPositions,_alarmBuilding,surfaceIsWater _worldPos];
										};
									};
								};
								true
							} count _unitData;
						};

						if not empty(_staticWeaponData) then {
							{
								_x params ["_modelPos","_relDir","_gunTypes","_relAngles","_vectorDirAndUp","_isATPosition"];
								_vectorDirAndUp params ["_vectorDir","_vectorUp"];
								_worldPos = _building modelToWorld _modelPos;
								if (sel(_worldPos,2) > 3) then {
									_attachPos = _zone worldToModel _worldPos;
									_worldDir = (_relDir + _buildingDir) call horde_fnc_normalDir;
									_targetPositions = [];
									{
										_targetPos = _worldPos getPos [250,(_x + _buildingDir) call horde_fnc_normalDir];
										/*_targetPos = _targetPos vectorAdd [0,0,sel(_worldPos,2)];*/
										if (sel(AGLtoASL _targetPos,2) < sel(AGLtoASL _worldPos,2)) then {
											_targetPos = _targetPos vectorAdd [0,0,sel(AGLtoASL _worldPos,2) - sel(AGLtoASL _targetPos,2)];
										} else {
											_targetPos = _targetPos vectorAdd [0,0,10];
										};
										if (not lineIntersects [AGLtoASL _worldPos,AGLtoASL _targetPos,_building]
											and {not terrainIntersect [_worldPos,_targetPos]}
										) then {
											_targetPositions pushBack (_targetPos call _fnc_roundArray);
										};
										true
									} count _relAngles;

									/*if not empty(_targetPositions) then {*/
									if (count _targetPositions > 1) then {
										/*_vectorDirAndUp = [vectorDir _zone vectorDiff (_vectorDir vectorDiff (vectorDir _building)),_vectorUp];*/
										_vectorDirAndUp = [[sin _worldDir,cos _worldDir,0],_vectorUp];
										if (not empty(_helipadArr)
											and {_worldPos distance2D sel(_helipadArr,0) < 500}
										) then {
											_staticPointsAirBase pushBack [_gunTypes,_attachPos,_vectorDirAndUp,_worldDir,_targetPositions,_alarmBuilding,ATLtoASL _worldPos call _fnc_checkAboveASL];
										};
										_staticPoints pushBack [_gunTypes,_attachPos,_vectorDirAndUp,_worldDir,_targetPositions,_alarmBuilding,ATLtoASL _worldPos call _fnc_checkAboveASL];
									};
								};
								true
							} count _staticWeaponData;
						};
					};

					if not empty(_lootData) then {
						setVar(_building,"objectAssignedToZone",_zone);
					};

					// NOTE: THIS IS ONLY RUN IF SERVER
					if (isServer) then {
						// remove wh and static guns if building destroyed

						if (isClass (_cfgBuilding >> "DestructionEffects" >> "Ruin1")) then {
							if (getText(_cfgBuilding >> "replacedamaged") == "") then {
								_building addEventHandler ["Killed", {
									_rad = sizeOf typeOf sel(_this,0);
									if (ncb_param_localFurniture == 1) then {
										sel(_this,0) remoteExecCall [
											"horde_fnc_blowUpFurniture",
											[sel(_this,0),50] call horde_fnc_allPlayersInRange
										];
									};
									{
										detach _x
									} count (sel(_this,0) nearEntities [
										"StaticWeapon",
										_rad
									]);

									{
										deleteVehicle _x
									} count (nearestObjects [
										sel(_this,0),
										["ReammoBox"],
										_rad
									]);
								}];
							} else {
								_building call horde_fnc_addBuildingDamageHandler;
							};
						};

						// check for windows (was used with invisible targets code in zonemanager.fsm)

						/*_targetPositions = [];
						_cfgHitPoints = (cfgVeh >> (typeOf _building) >> "HitPoints");
						if not (empty(_cfgHitPoints)) then {
							for "_i" from 0 to count _cfgHitPoints - 1 do {
								_cfgEntry = sel(_cfgHitPoints,_i);
								_name = configName _cfgEntry;
								if (_name select [0,5] == "Glass") then {
									_cfgDestEff = (_cfgEntry >> "DestructionEffects");
									_brokenGlass = sel(_cfgDestEff,0);
									_selName = getText (_brokenGlass >> "position");
									_modelPos = _building selectionPosition _selName;
									_worldPos = _building modelToWorld _modelPos;
									_targetPositions pushBack _worldPos;
								};
							};
						};
						_cfgUserActions = (cfgVeh >> (typeOf _building) >> "UserActions");
						if (not empty(_cfgUserActions)) then {
							for "_i" from 0 to count _cfgUserActions - 1 do {
								_cfgEntry = sel(_cfgUserActions,_i);
								_displayName = toLower getText (_cfgEntry >> "displayname");
								_string = _displayName select [0,5];
								if same(_string,"open ") then {
									_selName = getText (_cfgEntry >> "position");
									_modelPos = _building selectionPosition _selName;
									_worldPos = _building modelToWorld _modelPos;
									_targetPositions pushBack _worldPos;
								};
							};
						};

						if (not empty(_targetPositions)) then {
							setVar(_building,"structureTargetPositions",_targetPositions);
						};*/
						// setup passes

						if (not empty(_unitData) or {not empty(_lootData)}) then {
							if (_buildingType in ["B_MILITARY"]) then {
								_passes = selectRandom ncb_gv_buildingPassTypes;
								setVarPlc(
									_building,
									"objectAcceptedAccessPasses",
									_passes
								);
								_militaryBuildings pushBack _building
							};
						};
					};

					// civilian stuff (if enabled)
					if (ncb_param_civilianEnable) then {
						// setup house types
						/*call {
							if (true) exitWith {

							};
						};*/
					};
				};
				true
			} count _buildingArr;
			_prefix = "nocebo_" + worldName + "_" + _zoneName;
			_dataBaseZone = ["new",_prefix] call OO_INIDBI;
			if (ncb_param_loadZonesFromProfile == startNewGame) then {
				_maxIndex = ["read",[_prefix,"vantagePointsAirBaseHighMaxIndex",-1]] call _dataBaseZone;
				if (_maxIndex > -1) then {
					for "_i" from 0 to _maxIndex step 1 do {
						_vantagePointsAirBaseHigh = _vantagePointsAirBaseHigh + (["read",[_prefix,"vantagePointsAirBaseHigh_" + str _i,[]]] call _dataBaseZone);
					};
				};
				_maxIndex = ["read",[_prefix,"vantagePointsAirBaseLowMaxIndex",-1]] call _dataBaseZone;
				if (_maxIndex > -1) then {
					for "_i" from 0 to _maxIndex step 1 do {
						_vantagePointsAirBaseLow = _vantagePointsAirBaseLow + (["read",[_prefix,"vantagePointsAirBaseLow_" + str _i,[]]] call _dataBaseZone);
					};
				};
				_maxIndex = ["read",[_prefix,"vantagePointsHighMaxIndex",-1]] call _dataBaseZone;
				if (_maxIndex > -1) then {
					for "_i" from 0 to _maxIndex step 1 do {
						_vantagePointsHigh = _vantagePointsHigh + (["read",[_prefix,"vantagePointsHigh_" + str _i,[]]] call _dataBaseZone);
					};
				};
				_maxIndex = ["read",[_prefix,"vantagePointsLowMaxIndex",-1]] call _dataBaseZone;
				if (_maxIndex > -1) then {
					for "_i" from 0 to _maxIndex step 1 do {
						_vantagePointsLow = _vantagePointsLow + (["read",[_prefix,"vantagePointsLow_" + str _i,[]]] call _dataBaseZone);
					};
				};
				_maxIndex = ["read",[_prefix,"staticPointsAirBaseMaxIndex",-1]] call _dataBaseZone;
				if (_maxIndex > -1) then {
					for "_i" from 0 to _maxIndex step 1 do {
						_staticPointsAirBase = _staticPointsAirBase + (["read",[_prefix,"staticPointsAirBase_" + str _i,[]]] call _dataBaseZone);
					};
				};
				_maxIndex = ["read",[_prefix,"staticPointsMaxIndex",-1]] call _dataBaseZone;
				if (_maxIndex > -1) then {
					for "_i" from 0 to _maxIndex step 1 do {
						_staticPoints = _staticPoints + (["read",[_prefix,"staticPoints_" + str _i,[]]] call _dataBaseZone);
					};
				};
			} else {
				{
					_x params ["_zoneInfo","_category","_var"];
					if not empty(_var) then {
						_globalCount = 0;
						_countSubArrays = str _var;
						_countSubArrays = count (toArray _countSubArrays);
						_countSubArrays = ceil (_countSubArrays / 2000);
						_countElements = (count _var) / _countSubArrays;
						_bool = ["write",[_zoneInfo,_category + "MaxIndex",_countSubArrays - 1]] call _dataBaseZone;
						for "_i" from 1 to _countSubArrays step 1 do {
							_subArray = [];
							for "_j" from 1 to _countElements step 1 do {
								_subArray pushBack (_var select _globalCount);
								_globalCount = _globalCount + 1;
							};
							_bool = ["write",[_zoneInfo,_category + "_" + str (_i - 1),_subArray]] call _dataBaseZone;
						};
					} else {
						_bool = ["write",[_zoneInfo,_category + "MaxIndex",-1]] call _dataBaseZone;
						_bool = ["write",[_zoneInfo,_category,_var]] call _dataBaseZone;
					};
				} count [
					[_prefix,"vantagePointsAirBaseHigh",_vantagePointsAirBaseHigh],
					[_prefix,"vantagePointsAirBaseLow",_vantagePointsAirBaseLow],
					[_prefix,"vantagePointsHigh",_vantagePointsHigh],
					[_prefix,"vantagePointsLow",_vantagePointsLow],
					[_prefix,"staticPointsAirBase",_staticPointsAirBase],
					[_prefix,"staticPoints",_staticPoints]
				];
			};

			// new bit (sets up waypoints for patrol vehicles - they get the spawn point from the "patrolLandASL" config entry but have custom waypoints defined below)

			_positions = [];

			{
				{
					_val = (_x select 1);
					_condition = true;
					if (worldName == "tanoa") then {
						_condition = isOnRoad ASLtoAGL _val
					};
					if (_condition) then {
						_val resize 2;
						_val = _val apply {round _x};
						_positions pushBack _val
					};
				} forEach (getArray (_cfgZone >> "Roads" >> _x));
			} forEach [
				"deadEnds",
				"junctions",
				"roads"
			];
			_positions = _positions call horde_fnc_arrayShuffle;


			// new new bit!  (pick only connected roads and select the biggest array)

			/*

				f_positions = _positions;

				if (_zoneName == "Hordezone_9") then {
				fnc_searchRoads = {
					{
						private ["_testRoad"];
						_testRoad = (_x nearRoads 1) select 0;
						if (_testRoad in ((_this nearRoads 35) - [_this])
							//and {not (_testRoad in f_checked)}
						) then {
							if (f_checked pushBackUnique _x > -1) then {
								if (f_array pushBackUnique _x > -1) then {
									_testRoad call fnc_searchRoads;
								};
							};
						};
					} forEach f_positions;
				};
				f_masterArray = [];
				f_checked = [];
				{
					f_array = [];
					_road = (_x nearRoads 1) select 0;
					_road call fnc_searchRoads;
					diag_log format ["COMPARING - f_array %1",f_array];
					diag_log format ["COMPARING - f_masterArray %1",f_masterArray];
					if (count f_array > count f_masterArray) then {
						f_masterArray = +f_array;
						diag_log format ["f_masterArray %1",f_masterArray];
					};
					f_checked pushBackUnique _road;
				} forEach f_positions;

				_positions = f_masterArray; // call horde_fnc_arrayShuffle;

				diag_log format ["f_positions %1",count f_positions];
				diag_log format ["f_masterArray %1",count f_masterArray];
				diag_log format ["f_positions %1",f_positions];
				diag_log format ["f_masterArray %1",f_masterArray];

				{
					_mkr = createMarker ["master" + str _x,_x];
					_mkr setMarkerSize [10, 10];
					_mkr setMarkerShape "Ellipse";
					_mkr setMarkerBrush "SolidBorder";
					_mkr setMarkerColor "ColorBlack";
					_mkr setMarkerAlpha 1;
				} forEach f_masterArray;

				{
					_mkr = createMarker ["position" + str _x,_x];
					_mkr setMarkerSize [15, 15];
					_mkr setMarkerShape "Ellipse";
					_mkr setMarkerBrush "SolidBorder";
					_mkr setMarkerColor "ColorYellow";
					_mkr setMarkerAlpha 0.5;
				} forEach f_positions;
			};*/

			_waypointGroups = [];
			for "_i" from 1 to 10000 do {
				if (_positions isEqualTo []) exitWith {};
				_entry = [];
				for "_j" from 0 to count _positions - 1 do {
					if (_positions - [objNull] isEqualTo []) exitWith {};
					if (count _entry == 6 or {count _entry > 2 and {random 1 > 0.75}}) exitWith {
						_waypointGroups pushBack _entry
					};
					_pos = _positions select _j;
					if ({if (_x distance2D _pos < 150) exitWith {1}} count _entry isEqualTo 0) then {
						if (count _entry isEqualTo 0
							or {not ([_entry select count _entry - 1,_pos,10] call horde_fnc_waterBetweenPoints)}
						) then {
							_entry pushBack _pos;
							_positions set [_j,objNull];
						};
					};
				};
				_positions = _positions - [objNull]
			};

			setVar(_zone,"zoneVehicleWaypointGroups",_waypointGroups);


			// ANOTHER NEW BIT (FIND LAND MASSES)

			/*horde_fnc_scanCircleUniformly = {
				params ["_pos","_radius","_limit","_step","_gridValsLand","_gridValsWater","_testPos"];

				_pos params ["_xPos","_yPos"];
				// generate grid
				_gridValsLand = [];
				_gridValsWater = [];
				// diag_log format ["- %1",round (_xPos - _radius)];
				// diag_log format ["+ %1",round (_xPos + _radius)];
				for "_xValue" from (round (_xPos - _radius)) to (round (_xPos + _radius)) step _step do {
					for "_yValue" from (round (_yPos - _radius)) to (round (_yPos + _radius)) step _step do {
						_testPos = [_xValue,_yValue];
						// diag_log format ["testPos %1",_testPos];
						if (_testPos distance2D _pos < _limit) then {
							if (surfaceIsWater _testPos) then {
								_gridValsWater pushBack _testPos;
							} else {
								_gridValsLand pushBack _testPos;
							};
						};
					};
				};
				[_gridValsLand,_gridValsWater]
			};

			if (_zoneName == "Hordezone_15") then {

				fnc_waterBetweenPoints = {
					params ["_pos1","_pos2","_step","_isWater","_dir"];
					_isWater = false;
					_dir = _pos1 getDir _pos2;
					for "_dist" from 0 to round (_pos1 distance2D _pos2) step _step do {
						_testPos = _pos1 getPos [_dist,_dir];
						if (surfaceIsWater _testPos) exitWith {
							_isWater = true;
						};
					};
					_isWater
				};


				f_coords = [_zonePosASL,1000,1000,50] call horde_fnc_scanCircleUniformly;
				f_coords = f_coords select 0;
				// {diag_log _x} forEach f_coords;
				f_index = 0;
				fnc_searchLandMasses = {
					{
						if (_x distance _this < 150
							and {not (_x isEqualTo _this)}
							and {not (_x in f_checked)}
							and {not ([_x,_this,20] call fnc_waterBetweenPoints)}
						) then {
							if (f_array pushBackUnique _x > -1) then {
								if (f_checked pushBackUnique _x > -1) then {
									0 = _x call fnc_searchLandMasses;
								};
							};
						};
					} forEach f_coords;
					true
				};
				f_checked = [];
				{
					f_array = [];
					// if not (_x in (missionNameSpace getVariable ["f_landMassArray" + str f_index,[]])) then {
					if (f_checked pushBackUnique _x > -1) then {
						0 = _x call fnc_searchLandMasses;
						if not (f_array isEqualTo []) then {
							missionNameSpace setVariable ["f_landMassArray" + str f_index,f_array];
							f_index = f_index + 1;
						};
					};
				} forEach f_coords;

				for "_i" from 0 to 10 do {
					_arr = missionNameSpace getVariable ["f_landMassArray" + str _i,[]];
					if (_arr isEqualTo []) exitWith {
						diag_log format ["no array %1",_i];
					};
					diag_log format ["var f_landMassArray%1",_i];
					diag_log format ["arr %1",_arr];
					{
						_mkr = createMarker ["masterland" + str _x,_x];
						_mkr setMarkerSize [10, 10];
						_mkr setMarkerShape "Ellipse";
						_mkr setMarkerBrush "SolidBorder";
						call {
							if (_i == 0) exitWith {
								_mkr setMarkerColor "ColorBlack";
							};
							if (_i == 1) exitWith {
								_mkr setMarkerColor "ColorBlue";
							};
							if (_i == 2) exitWith {
								_mkr setMarkerColor "ColorGreen";
							};
							if (_i == 3) exitWith {
								_mkr setMarkerColor "ColorBrown";
							};
							if (_i == 4) exitWith {
								_mkr setMarkerColor "ColorPink";
							};
						};
						_mkr setMarkerAlpha 1;
					} forEach _arr;
				};
			};*/

			// END FIND LAND MASSES

			// test mooring positions

			/*{
				{
					_mkr = createMarker ["lpos" + str _x,_x];
					_mkr setMarkerSize [10,10];
					_mkr setMarkerShape "Ellipse";
					_mkr setMarkerBrush "SolidBorder";
					_mkr setMarkerColor "ColorBlack";
					_mkr setMarkerAlpha 1;
					private _mkr = createMarker ["lpostext" + str _x,_x];
					_mkr setMarkerSize [1,1];
					_mkr setMarkerType "o_motor_inf";
					_mkr setMarkerAlpha 1;
					_mkr setMarkerColor "ColorRed";
					_mkr setMarkerText "mooring position";
				} forEach (_x select 3)
			} forEach (getArray (_cfgZone >> "VehicleSpawnData" >> "mooringDataASL"));*/

			// SET ZONE SPAWN ATTRIBUTES
			setVar(_zone,"zoneIsActive",false);
			setVar(_zone,"zoneHasAirBase",false);
			setVar(_zone,"zoneHasRadioInstallation",false);
			setVar(_zone,"zoneHasArtilleryEmplacement",false);
			if (ncb_param_zoneReinforcementTickets == -1) then {
				setVar(_zone,"zoneReinforceTickets",_zoneValue)
			} else {
				setVar(_zone,"zoneReinforceTickets",ncb_param_zoneReinforcementTickets)
			};
			setVar(_zone,"zoneCurrentGroups",[]); // always update
			setVar(_zone,"zoneTimeLastSpawned",nil);
			setVar(_zone,"zoneCurrentEmptyVehicles",[]);
			setVar(_zone,"zoneSavedEmptyVehicleData",[]);

			// SET ZONE ATTRIBUTES
			setVar(_zone,"zoneMapHelipads",_helipadArr);
			setVar(_zone,"zoneVantagePointsLow",_vantagePointslow);
			setVar(_zone,"zoneVantagePointsHigh",_vantagePointsHigh);
			setVar(_zone,"zoneVantagePointsAirBaseLow",_vantagePointsAirBaseLow);
			setVar(_zone,"zoneVantagePointsAirBaseHigh",_vantagePointsAirBaseHigh);
			setVar(_zone,"zoneStaticPoints",_staticPoints);
			setVar(_zone,"zoneStaticPointsAirBase",_staticPointsAirBase);
			setVar(_zone,"zoneAirBaseResources",[]);
			setVar(_zone,"zoneVantagePointsRadioTransmitterLow",[]);
			setVar(_zone,"zoneVantagePointsRadioTransmitterHigh",[]);
			setVar(_zone,"zoneStaticBuildingsRadioTransmitter",[]);
			setVar(_zone,"zoneMaxSquadCount",_zoneValue);
			setVar(_zone,"zoneOrigSquadCount",_zoneValue);
			setVar(_zone,"zoneTriggerRadius",ncb_gv_zoneTriggerRad);
			setVar(_zone,"zoneMilBuildings",_militaryBuildings);

			// ASSIGN SOME VALUES
			if (not empty(_vantagePointsHigh) or {not empty(_vantagePointsLow)}) then {
				setVar(_zone,"zoneHasSniperPositions",true);
			} else {
				setVar(_zone,"zoneHasSniperPositions",false);
			};
			if not empty(_staticPoints) then {
				setVar(_zone,"zoneHasStaticPositions",true);
			} else {
				setVar(_zone,"zoneHasStaticPositions",false);
			};
		};
	};
};

// setup databases

ncb_gv_iniDbiSaveGame = ["new","nocebo_" + worldName + "_saveStatus"] call OO_INIDBI;
ncb_gv_iniDbiPlayer = ["new","nocebo_" + worldName + "_players"] call OO_INIDBI;
ncb_gv_iniDbiAmmoBoxes = ["new","nocebo_" + worldName + "_ammoBoxes"] call OO_INIDBI;
ncb_gv_iniDbiCamoNets = ["new","nocebo_" + worldName + "_camoNets"] call OO_INIDBI;
ncb_gv_iniDbiTents = ["new","nocebo_" + worldName + "_tents"] call OO_INIDBI;
ncb_gv_iniDbiVehicles = ["new","nocebo_" + worldName + "_vehicles"] call OO_INIDBI;
ncb_gv_iniDbiAirWrecks = ["new","nocebo_" + worldName + "_airWrecks"] call OO_INIDBI;
ncb_gv_iniDbiAbandonedBases = ["new","nocebo_" + worldName + "_abandonedBases"] call OO_INIDBI;
ncb_gv_iniDbiArtillery = ["new","nocebo_" + worldName + "_artillery"] call OO_INIDBI;
ncb_gv_iniDbiAirBases = ["new","nocebo_" + worldName + "_airbases"] call OO_INIDBI;
ncb_gv_iniDbiRadioTransmitters = ["new","nocebo_" + worldName + "_radiotranmitters"] call OO_INIDBI;

// persistent vehicles / camo nets / tents etc

ncb_gv_AirWrecks = [];

ncb_gv_savedGame = ["read",["saveGame","saved",false]] call ncb_gv_iniDbiSaveGame;
"delete" call ncb_gv_iniDbiSaveGame;

if (ncb_param_loadSavedGame == 1) then {


	// load ammoboxes

	for "_i" from 0 to 999999 step 1 do {
		_entry = "ammoBoxes_" + str _i;
		_class = ["read",[_entry,"class",""]] call ncb_gv_iniDbiAmmoBoxes;
		if (_class == "") exitWith {};
		_posWorld = ["read",[_entry,"position",[0,0,0]]] call ncb_gv_iniDbiAmmoBoxes;
		_direction = ["read",[_entry,"direction",0]] call ncb_gv_iniDbiAmmoBoxes;
		_vectorUp = ["read",[_entry,"vectorUp",[0,0,1]]] call ncb_gv_iniDbiAmmoBoxes;
		_damage = ["read",[_entry,"damage",0]] call ncb_gv_iniDbiAmmoBoxes;
		_cargo = ["read",[_entry,"cargo",[[],[],[],[]]]] call ncb_gv_iniDbiAmmoBoxes;

		_object = createVehicle [_class,[100,100,100],[],0,"can_collide"];
		_object setDir _direction;
		_object setPosWorld _posWorld;
		_object setVectorUp _vectorUp;
		_object setDamage _damage;
		[_object,_cargo,true] call horde_fnc_fillCargo;
		_object enableDynamicSimulation true;

		// delete section
		["deleteSection",_entry] call ncb_gv_iniDbiAmmoBoxes;
	};

	// load camonets

	for "_i" from 0 to 999999 step 1 do {
		_entry = "camoNet_" + str _i;
		_class = ["read",[_entry,"class",""]] call ncb_gv_iniDbiCamoNets;
		/*if (isNil "_class") exitWith {};*/
		if (_class == "") exitWith {};
		_posWorld = ["read",[_entry,"position",[0,0,0]]] call ncb_gv_iniDbiCamoNets;
		_direction = ["read",[_entry,"direction",0]] call ncb_gv_iniDbiCamoNets;
		_vectorUp = ["read",[_entry,"vectorUp",[0,0,1]]] call ncb_gv_iniDbiCamoNets;
		_damage = ["read",[_entry,"damage",0]] call ncb_gv_iniDbiCamoNets;

		_object = createVehicle [_class,[100,100,100],[],0,"can_collide"];
		_object setDir _direction;
		_object setPosWorld _posWorld;
		_object setVectorUp _vectorUp;
		_object setDamage _damage;
		_object enableDynamicSimulation true;

		// delete section
		["deleteSection",_entry] call ncb_gv_iniDbiCamoNets;
	};

	// load tents

	for "_i" from 0 to 999999 step 1 do {
		_entry = "tent_" + str _i;
		_class = ["read",[_entry,"class",""]] call ncb_gv_iniDbiTents;
		/*if (isNil "_class") exitWith {};*/
		if (_class == "") exitWith {};
		_users = ["read",[_entry,"users","side"]] call ncb_gv_iniDbiTents;
		_owner = ["read",[_entry,"owner","server"]] call ncb_gv_iniDbiTents;
		_posWorld = ["read",[_entry,"position",[0,0,0]]] call ncb_gv_iniDbiTents;
		_direction = ["read",[_entry,"direction",0]] call ncb_gv_iniDbiTents;
		_vectorUp = ["read",[_entry,"vectorUp",[0,0,1]]] call ncb_gv_iniDbiTents;
		_damage = ["read",[_entry,"damage",0]] call ncb_gv_iniDbiTents;
		_cargo = ["read",[_entry,"cargo",[[],[],[],[]]]] call ncb_gv_iniDbiTents;

		_object = createVehicle [_class,[100,100,100],[],0,"can_collide"];
		_object setDir _direction;
		_object setPosWorld _posWorld;
		_object setVectorUp _vectorUp;
		_object setDamage _damage;
		[_object,_cargo,true] call horde_fnc_fillCargo;
		_object setVariable ["tentOwnerDetails",[_owner,"markerName",_users],true];
		// initPlayerOnServer will run through all tents with players UID and mark up the ones he owns - (group and personal)
		if (_users == "side") then {
			[objNull,_object,"side"] call horde_fnc_serverSetTentOwner
		};
		if (_class == "ncb_obj_para_beacon") then {
			// animate it opening!
			_object animate ["Upload_1_cover_hide_1",3];
			_object animate ["Upload_2_cover_hide_1",3];
			_object animate ["Upload_3_cover_hide_1",3];

			_object animate ["Wifi_1_hide_1",3];
			_object animate ["Wifi_2_hide_1",3];
			_object animate ["Wifi_3_hide_1",3];
			_object animate ["Wifi_4_hide_1",3];
			_object animate ["Wifi_5_hide_1",3];

			_object animate ["Vent_1_rot_1",3];
			_object animate ["Vent_2_rot_1",3];
			_object animate ["Vent_3_rot_1",3];
			_object animate ["Vent_4_rot_1",3];

			_object animate ["Base_stripes_1_1_move_1",3];
			_object animate ["Base_stripes_2_1_move_1",3];
			_object animate ["Base_stripes_3_1_move_1",3];
			_object animate ["Base_stripes_4_1_move_1",3];
			_object animate ["Lid_stripes_1_1_move_1",3];
			_object animate ["Lid_stripes_2_1_move_1",3];
			_object animate ["Lid_stripes_3_1_move_1",3];
			_object animate ["Lid_stripes_4_1_move_1",3];

			_object animate ["Base_stripes_1_2_move_1",3];
			_object animate ["Base_stripes_2_2_move_1",3];
			_object animate ["Base_stripes_3_2_move_1",3];
			_object animate ["Base_stripes_4_2_move_1",3];
			_object animate ["Lid_stripes_1_2_move_1",3];
			_object animate ["Lid_stripes_2_2_move_1",3];
			_object animate ["Lid_stripes_3_2_move_1",3];
			_object animate ["Lid_stripes_4_2_move_1",3];

			_object animate ["Base_stripes_1_2_move_2",3];
			_object animate ["Base_stripes_2_2_move_2",3];
			_object animate ["Base_stripes_3_2_move_2",3];
			_object animate ["Base_stripes_4_2_move_2",3];
			_object animate ["Lid_stripes_1_2_move_2",3];
			_object animate ["Lid_stripes_2_2_move_2",3];
			_object animate ["Lid_stripes_3_2_move_2",3];
			_object animate ["Lid_stripes_4_2_move_2",3];

			_object animate ["Base_stripes_1_3_move_1",3];
			_object animate ["Base_stripes_2_3_move_1",3];
			_object animate ["Base_stripes_3_3_move_1",3];
			_object animate ["Base_stripes_4_3_move_1",3];
			_object animate ["Lid_stripes_1_3_move_1",3];
			_object animate ["Lid_stripes_2_3_move_1",3];
			_object animate ["Lid_stripes_3_3_move_1",3];
			_object animate ["Lid_stripes_4_3_move_1",3];

			_object animate ["Lock_1_rot_1",3];
			_object animate ["Lock_2_rot_1",3];
			_object animate ["Lid_rot_1",3];
			_object animate ["Lid_pistons_rot_1",3];
			_object animate ["Base_pistons_rot_1",3];

			_object animate ["Button_7_rot_1",3];
			_object animate ["Switch_2_rot_1",3];
			_object animate ["Switch_5_rot_1",3];
			_object animate ["Switch_6_rot_1",3];

			_object animate ["Dish_1_01_rot_1",3];
			_object animate ["Dish_1_02_rot_1",3];
			_object animate ["Dish_1_03_rot_1",3];
			_object animate ["Dish_1_04_rot_1",3];
			_object animate ["Dish_1_05_rot_1",3];
			_object animate ["Dish_1_06_rot_1",3];
			_object animate ["Dish_1_07_rot_1",3];
			_object animate ["Dish_1_08_rot_1",3];
			_object animate ["Dish_1_09_rot_1",3];
			_object animate ["Dish_1_10_rot_1",3];
			_object animate ["Dish_1_11_rot_1",3];
			_object animate ["Dish_1_12_rot_1",3];
			_object animate ["Dish_1_13_rot_1",3];
			_object animate ["Dish_1_14_rot_1",3];
			_object animate ["Dish_1_15_rot_1",3];
			_object animate ["Dish_1_16_rot_1",3];
			_object animate ["Dish_1_17_rot_1",3];
			_object animate ["Dish_1_18_rot_1",3];
			_object animate ["Dish_1_19_rot_1",3];
			_object animate ["Dish_1_20_rot_1",3];

			_object animate ["Antenna_piston_1_move_1",3];
			_object animate ["Antenna_piston_2_move_1",3];
			_object animate ["Antenna_piston_3_move_1",3];
			_object animate ["Antenna_base_rot_1",3];
			_object animate ["Antenna_center_rot_1",3];

			_object animate ["Dish_2_01_rot_1",3];
			_object animate ["Dish_2_02_rot_1",3];
			_object animate ["Dish_2_03_rot_1",3];
			_object animate ["Dish_2_04_rot_1",3];
			_object animate ["Dish_2_05_rot_1",3];
			_object animate ["Dish_2_06_rot_1",3];
			_object animate ["Dish_2_07_rot_1",3];
			_object animate ["Dish_2_08_rot_1",3];
			_object animate ["Dish_2_09_rot_1",3];
			_object animate ["Dish_2_10_rot_1",3];
			_object animate ["Dish_2_11_rot_1",3];
			_object animate ["Dish_2_12_rot_1",3];
			_object animate ["Dish_2_13_rot_1",3];
			_object animate ["Dish_2_14_rot_1",3];
			_object animate ["Dish_2_15_rot_1",3];
			_object animate ["Dish_2_16_rot_1",3];
			_object animate ["Dish_2_17_rot_1",3];
			_object animate ["Dish_2_18_rot_1",3];
			_object animate ["Dish_2_19_rot_1",3];
			_object animate ["Dish_2_20_rot_1",3];

			_object animate ["Screen_1_text_01_fakeunhide_1",3];

			_object animate ["Cpu_cover_fakehide_1",3];
			_object animate ["Ram_cover_fakehide_1",3];
			_object animate ["Cpu_1_rot_1",3];
			_object animate ["Cpu_2_rot_1",3];
			_object animate ["Ram_1_rot_1",3];
			_object animate ["Ram_2_rot_1",3];

			_object animate ["Screen_1_text_02_fakeunhide_1",3];
			_object animate ["Screen_1_text_03_fakeunhide_1",3];
			_object animate ["Screen_1_text_04_fakeunhide_1",3];
			_object animate ["Screen_1_text_05_fakeunhide_1",3];
			_object animate ["Screen_1_text_06_fakeunhide_1",3];
			_object animate ["Screen_1_text_07_fakeunhide_1",3];
			_object animate ["Screen_1_text_08_fakeunhide_1",3];

			_object animate ["Screen_1_text_09_fakeunhide_1",3];
			_object animate ["Screen_1_text_10_fakeunhide_1",3];
			_object animate ["Screen_1_text_11_fakeunhide_1",3];

			_object animate ["Screen_1_text_12_fakeunhide_1",3];
			_object animate ["Screen_1_text_13_fakeunhide_1",3];
			_object animate ["Screen_1_text_14_fakeunhide_1",3];
			_object animate ["Screen_1_text_15_fakeunhide_1",3];
			_object animate ["Screen_1_text_16_fakeunhide_1",3];
			_object animate ["Screen_1_text_17_fakeunhide_1",3];
			_object animate ["Screen_1_text_18_fakeunhide_1",3];
			_object animate ["Screen_1_text_19_fakeunhide_1",3];
			_object animate ["Screen_1_text_20_fakeunhide_1",3];
			_object animate ["Screen_1_text_21_fakeunhide_1",3];
			_object animate ["Screen_1_text_22_fakeunhide_1",3];
			_object animate ["Screen_1_text_23_fakeunhide_1",3];

			_object animate ["Screen_1_text_24_fakeunhide_1",3];
			_object animate ["Screen_1_text_25_fakeunhide_1",3];
			_object animate ["Screen_1_text_26_fakeunhide_1",3];
			_object animate ["Screen_1_text_27_fakeunhide_1",3];

			_object animate ["Screen_1_logo_fakeunhide_1",3];

			_object animate ["Screen_2_text_01_fakeunhide_1",3];
			_object animate ["Screen_2_text_02_fakeunhide_1",3];
			_object animate ["Screen_2_text_03_fakeunhide_1",3];
			_object animate ["Screen_2_text_04_fakeunhide_1",3];
			_object animate ["Screen_2_text_05_fakeunhide_1",3];
			_object animate ["Screen_2_text_06_fakeunhide_1",3];

			_object animate ["Screen_2_text_07_fakeunhide_1",3];
			_object animate ["Screen_2_text_08_fakeunhide_1",3];
			_object animate ["Screen_2_text_09_fakeunhide_1",3];

			_object animate ["Screen_2_text_10_fakeunhide_1",3];
			_object animate ["Screen_2_text_11_fakeunhide_1",3];
			_object animate ["Screen_2_text_12_fakeunhide_1",3];
			_object animate ["Screen_2_text_13_fakeunhide_1",3];
			_object animate ["Screen_2_text_14_fakeunhide_1",3];
			_object animate ["Screen_2_text_15_fakeunhide_1",3];

			_object animate ["Upload_fakeunhide_1",3];
			_object animate ["Wifi_cover_fakehide_1",3];

			// set colour of lights blue/green/white
			call {
				if (_users == "personal") exitWith {
					_texture = "#(argb,8,8,3)color(1,1,1,1)";
					_material = "\nocebo\rvmat\dataterminal_white.rvmat";
					_object setObjectTextureGlobal [2,_texture];
					_object setObjectTextureGlobal [3,_texture];
					_object setObjectTextureGlobal [4,_texture];
					_object setObjectMaterialGlobal [2,_material];
					_object setObjectMaterialGlobal [3,_material];
					_object setObjectMaterialGlobal [4,_material];
				};
				if (_users == "group") exitWith {
					_texture = "#(argb,8,8,3)color(0.25,0.75,0.25,1)";
					_material = "\nocebo\rvmat\dataterminal_green.rvmat";
					_object setObjectTextureGlobal [2,_texture];
					_object setObjectTextureGlobal [3,_texture];
					_object setObjectTextureGlobal [4,_texture];
					_object setObjectMaterialGlobal [2,_material];
					_object setObjectMaterialGlobal [3,_material];
					_object setObjectMaterialGlobal [4,_material];
				};
				if (_users == "side") exitWith {
					_texture = "#(argb,8,8,3)color(0,1,1,1)";
					_material = "\A3\Props_F_Exp_A\Military\Equipment\Data\DataTerminal_blue.rvmat";
					_object setObjectTextureGlobal [2,_texture];
					_object setObjectTextureGlobal [3,_texture];
					_object setObjectTextureGlobal [4,_texture];
					_object setObjectMaterialGlobal [2,_material];
					_object setObjectMaterialGlobal [3,_material];
					_object setObjectMaterialGlobal [4,_material];
				};
			};
		};
		_object enableDynamicSimulation true;
		// delete section
		["deleteSection",_entry] call ncb_gv_iniDbiTents;
	};

	// load vehicles

	for "_i" from 0 to 999999 step 1 do {
		_entry = "vehicle_" + str _i;
		_class = ["read",[_entry,"class",""]] call ncb_gv_iniDbiVehicles;
		if (_class == "") exitWith {};
		_posWorld = ["read",[_entry,"position",[0,0,0]]] call ncb_gv_iniDbiVehicles;
		_direction = ["read",[_entry,"direction",0]] call ncb_gv_iniDbiVehicles;
		_vectorUp = ["read",[_entry,"vectorUp",[0,0,1]]] call ncb_gv_iniDbiVehicles;
		_fuel = ["read",[_entry,"fuel",0]] call ncb_gv_iniDbiVehicles;
		_damage = ["read",[_entry,"damage",0]] call ncb_gv_iniDbiVehicles;
		_hitPoints = ["read",[_entry,"hitPoints",[]]] call ncb_gv_iniDbiVehicles;
		_cargo = ["read",[_entry,"cargo",[[],[],[],[]]]] call ncb_gv_iniDbiVehicles;
		_mags = ["read",[_entry,"magazines",[]]] call ncb_gv_iniDbiVehicles;
		_repairInfo = ["read",[_entry,"tools",[]]] call ncb_gv_iniDbiVehicles;
		_textures = ["read",[_entry,"textures",[]]] call ncb_gv_iniDbiVehicles;
		_locked = ["read",[_entry,"locked",[]]] call ncb_gv_iniDbiVehicles;

		_object = createVehicle [_class,[100,100,100],[],0,"can_collide"];
		_object setDir _direction;
		_object setPosWorld _posWorld;
		_object setVectorUp _vectorUp;
		_object setFuel _fuel;
		_object setDamage _damage;
		_object setVehicleAmmo 0;
		{
			_object setHitPointDamage _x;
		} count _hitPoints;
		[_object,_cargo,true] call horde_fnc_fillCargo;
		_magTypes = [];
		{
			if (_magTypes pushBackUnique (_x select 0) > -1) then {
				_object setMagazineTurretAmmo [_x select 0,_x select 2,_x select 1]
			} else {
				_object addMagazineTurret _x
			};
			nil
		} count _mags;
		{
			_x params ["_location","_part","_tool"];
			_object setVariable [_location,[_part,_tool],true];
		} count _repairInfo;

		_object call horde_fnc_vehicleDamageAnimSetup;
		_initScript = getText (_cfgVehicles >> (typeOf _object) >> "initScript");
		if not (_initScript isEqualTo "") then {
			[_object,"old"] call (missionNamespace getVariable _initScript);
		};

		if not ((_textures isEqualTo [])) then {
			[_object,_textures] call horde_fnc_setOldVehicleTexture;
		};

		if (_locked > 1) then {
			_object setVehicleLock "LOCKED"
		};

		_object addEventHandler ["GetIn", {
			_this call horde_fnc_getInVehicle
		}];
		_object addEventHandler ["GetOut", {
			_this call horde_fnc_getOutVehicle
		}];

		_object enableDynamicSimulation true;

		// delete section
		["deleteSection",_entry] call ncb_gv_iniDbiVehicles;
	};

	// load abandoned bases

	for "_i" from 0 to 999999 step 1 do {
		_entry = "abandonedBases_" + str _i;
		_class = ["read",[_entry,"class",""]] call ncb_gv_iniDbiAbandonedBases;
		if (_class == "") exitWith {};
		_posWorld = ["read",[_entry,"position",[0,0,0]]] call ncb_gv_iniDbiAbandonedBases;
		_direction = ["read",[_entry,"direction",0]] call ncb_gv_iniDbiAbandonedBases;
		_vectorUp = ["read",[_entry,"vectorUp",[0,0,1]]] call ncb_gv_iniDbiAbandonedBases;
		_damage = ["read",[_entry,"damage",0]] call ncb_gv_iniDbiAbandonedBases;

		_object = createVehicle [_class,[100,100,100],[],0,"can_collide"];
		_object setDir _direction;
		_object setPosWorld _posWorld;
		_object setVectorUp _vectorUp;
		_object setDamage _damage;
		_object enableDynamicSimulation true;

		// delete section
		["deleteSection",_entry] call ncb_gv_iniDbiAbandonedBases;
	};

	// load air wrecks ncb_param_airWrecks

	for "_i" from 0 to 999999 step 1 do {
		_entry = "airWreck_" + str _i;
		_class = ["read",[_entry,"class",""]] call ncb_gv_iniDbiAirWrecks;
		if (_class == "") exitWith {};
		_posWorld = ["read",[_entry,"position",[0,0,0]]] call ncb_gv_iniDbiAirWrecks;
		_direction = ["read",[_entry,"direction",0]] call ncb_gv_iniDbiAirWrecks;
		_vectorUp = ["read",[_entry,"vectorUp",[0,0,1]]] call ncb_gv_iniDbiAirWrecks;
		_wreckSalvageItem = ["read",[_entry,"wreckSalvageItem","ItemWrench"]] call ncb_gv_iniDbiAirWrecks;

		_object = createVehicle [_class,[100,100,100],[],0,"can_collide"];
		_object setDir _direction;
		_object setPosWorld _posWorld;
		_object setVectorUp _vectorUp;
		_object enableSimulationGlobal false;
		_object allowDamage false;
		_smokePos = [0,0,0];
		call {
			if (_class == "ncb_obj_wreck_blackfoot") exitWith {
				_smokePos = _object modelToWorld [0.38,-2.50,0.16]
			};
			if (_class == "ncb_obj_wreck_kajman") exitWith {
				_smokePos = _object modelToWorld [0.65,-0.33,-0.68]
			};
			if (_class == "ncb_obj_wreck_samson") exitWith {
				_smokePos = _object modelToWorld (selectRandom [[-4.86,-4,2.65],[4.39,-4.62,1.75]])
			};
		};
		_smoke = "test_EmptyObjectForSmoke" createVehicle _smokePos;
		_smoke setPos _smokePos;
		ncb_gv_AirWrecks pushBack _object;
		_object setVariable ["wreckSalvageItem",_wreckSalvageItem,true];
		_posWorld set [2,0];
		_object enableDynamicSimulation true;
		_smoke enableDynamicSimulation true;
		// furrows
		_startPos = _posWorld;
		_addFurrows = (floor random 4) + 3;
		for "_i" from 1 to _addFurrows + floor random _addFurrows do {
			_randDist = 2.7 + random 3;
			_furrowPos = [
				(_startPos select 0) + _randDist * sin _direction,
				(_startPos select 1) + _randDist * cos _direction,
				-0.65
			];
			_furrow = createVehicle ["CraterLong",_furrowPos,[],0,"can_collide"];
			_furrow setVectorDirAndUp [
				vectorDir _object,
				surfaceNormal _furrowPos
			];
			_furrow enableDynamicSimulation true;
			_startPos = _furrowPos;
		};

		// delete section
		["deleteSection",_entry] call ncb_gv_iniDbiAirWrecks;
	};
} else {
	"delete" call ncb_gv_iniDbiPlayer;
	"delete" call ncb_gv_iniDbiAmmoBoxes;
	"delete" call ncb_gv_iniDbiCamoNets;
	"delete" call ncb_gv_iniDbiAbandonedBases;
	"delete" call ncb_gv_iniDbiTents;
	"delete" call ncb_gv_iniDbiVehicles;
	"delete" call ncb_gv_iniDbiAirWrecks;
	"delete" call ncb_gv_iniDbiArtillery;
	"delete" call ncb_gv_iniDbiAirBases;
	"delete" call ncb_gv_iniDbiRadioTransmitters;
	setVar(profileNamespace,"ncb_param_loadSavedGame",1)
};

//////////////////////////////////////////////

/*if (ncb_param_loadZonesFromProfile == 0) then {
	setVar(profileNamespace,"ncb_param_loadZonesFromProfile",1)
};*/

publicVariable "ncb_gv_crateRiflesTier_0";
publicVariable "ncb_gv_crateRiflesTier_1";
publicVariable "ncb_gv_cratePistolsTier_0";
diag_log "/**************************************/";
diag("server pre-init done");
diag_log "/**************************************/";

true