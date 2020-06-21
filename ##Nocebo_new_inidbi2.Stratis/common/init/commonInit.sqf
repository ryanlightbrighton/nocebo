#define diag(a,b) (diag_log format [prefix + "commonInit"" - " + a + ": %1",b])
#include "\nocebo\defines\scriptDefines.hpp"

if (not isNil "ncb_gv_commonInitRan") exitWith {};

ncb_gv_commonInitRan = true;

enableSaving [false,false];

[true,[true,true,true,false],[0,true,false],[]] execVM "vip_lit\vip_lit_init.sqf";

ncb_gv_eachFrameData = [];

// call compile preprocessFileLineNumbers "Engima\Civilians\Init.sqf";

// do these here as everyone needs access to modified values.
/*ncb_param_playerDamageCoefSourceAI = ncb_param_playerDamageCoefSourceAI * 0.1;
ncb_param_playerDamageCoefSourcePlayer = ncb_param_playerDamageCoefSourcePlayer * 0.1;*/
BIS_fnc_feedback_allowPP = false;

ncb_gv_ghillieSuits = "
	(toLower getText (_x >> 'displayName') find 'ghillie' > -1
	or {toLower configName _x find 'ghillie' > -1})
	and {getArray (_x >> 'allowedSlots') isEqualTo [901]}
" configClasses (configFile >> "CfgWeapons");
ncb_gv_ghillieSuits = ncb_gv_ghillieSuits apply {configName _x};

_classes = "getNumber(_x >> 'ncb_refill') == 1" configClasses (configFile >> "CfgMagazines");
_classes = _classes select {getNumber (_x >> "ncb_refill") == 1};
ncb_gv_refillMagTypes = _classes apply {[configName _x,getText (_x >> "ammo")]};

ncb_gv_buildingPassTypes = [
	["Alpha",[
		"ItemPass_Alpha",
		"ItemPass_MasterAll"
	]],
	["Beta",[
		"ItemPass_Beta",
		"ItemPass_MasterAll"
	]],
	["Gamma",[
		"ItemPass_Gamma",
		"ItemPass_MasterAll"
	]],
	["Omega",[
		"ItemPass_Omega",
		"ItemPass_MasterAll"
	]]
];

// start loading screen fsm if not dedi/hc

if (hasInterface) then {
	0 execFSM "common\init\loading.fsm";
};

[
	["commonInit"],{
		if (not isNil "ncb_param_loadedParams") then {
			setTerrainGrid (50 / ncb_param_grassRenderDistance);
			setViewDistance 1500;
			setObjectViewDistance [1500,ncb_param_shadowRenderDistance];
			enableEngineArtillery ncb_param_enableEngineArtillery;
			0 enableChannel [ncb_param_enableChannelGlobalChat,ncb_param_enableChannelGlobalRadio];
			1 enableChannel [ncb_param_enableChannelSideChat,ncb_param_enableChannelSideRadio];
			2 enableChannel [ncb_param_enableChannelCommandChat,ncb_param_enableChannelCommandRadio];
			3 enableChannel [ncb_param_enableChannelGroupChat,ncb_param_enableChannelGroupRadio];
			4 enableChannel [ncb_param_enableChannelVehicleChat,ncb_param_enableChannelVehicleRadio];
			5 enableChannel [ncb_param_enableChannelDirectChat,ncb_param_enableChannelDirectRadio];
			call horde_fnc_removeEachFrame
		};

	},
	0
] call horde_fnc_addEachFrame;


0 spawn {
	scriptName "commonInitEnableEnvronment";
	waitUntil {time > 0 and {not isNil "ncb_param_loadedParams"}};
	enableEnvironment [ncb_param_ambientLife,ncb_param_ambientSounds];
	waitUntil {time > 10};
	CUP_stopLampCheck = true; // stops cup light scripts
};

// get list of unit insignia (for group menu stuff)
ncb_gv_unitInsigniaCfgs = [];
"ncb_gv_unitInsigniaCfgs pushBack _x;true" configClasses (configFile >> "CfgUnitInsignia");
"ncb_gv_unitInsigniaCfgs pushBack _x;true" configClasses (missionConfigFile >> "CfgUnitInsignia");

diag_log "/**************************************/";
diag("common init done");
diag_log "/**************************************/";

true