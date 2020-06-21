#include "\nocebo\defines\scriptDefines.hpp"

if not (hasInterface) exitWith {};

if not (isNil "ncb_gv_ranClientPreInit") exitWith {
	diag_log "/**************************************/";
	diag("trying to read client pre-init twice");
	diag_log "/**************************************/";
};

ncb_gv_ranClientPreInit = true;

//["Arma 3","Arma3",176,142872,"Stable",true,"Windows","x64"]
if (productVersion select 2 < 100 * getNumber (configFile >> "CfgPatches" >> "nocebo" >> "requiredVersion")) exitWith {
	diag("out of date Arma 3 - quitting");
	endMission "badVersion"
};

call horde_fnc_commonInit;

ncb_layer_fixVehProgBar = 16600;
ncb_layer_playerMonitor = 16700;
ncb_layer_staticScreen = 20000;
ncb_layer_blackOutScreen = 50000;

horde_fnc_handleRespawn = compileFinal "_this execFSM 'client\respawn\system\respawn.fsm'";

diag_log "/**************************************/";
diag("client pre-init done");
diag_log "/**************************************/";