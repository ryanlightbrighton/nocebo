#include "\nocebo\defines\scriptDefines.hpp"

with uiNamespace do {
	private _display = getVar(uiNamespace,"Horde_respawnMenu");
	private _map = _display displayCtrl 1800;
	private _button = _display displayCtrl 1602;
	if (ctrlShown _map) then {
		_map ctrlSetPosition [
			0.784375 * safezoneW + safezoneX,
			0.136 * safezoneH + safezoneY,
			0,
			0.728 * safezoneH
		];
		_map ctrlCommit 0.15;
		_map ctrlShow false;
		/*ctrlSetText [1602,"Open map"];*/
		ctrlSetText [1602,"nocebo\images\respawnTent2.paa"];
	} else {
		/*x = 0.784375 * safezoneW + safezoneX;
		y = 0.136 * safezoneH + safezoneY;
		w = 0.561458 * safezoneW;
		h = 0.728 * safezoneH;*/
		_map ctrlSetPosition [
			0.784375 * safezoneW + safezoneX,
			0.136 * safezoneH + safezoneY,
			0,
			0.728 * safezoneH
		];
		_map ctrlCommit 0;
		// NOTE:  NEW CODE HERE TO ZOOM IN
		_map ctrlMapAnimAdd [0,1,[worldSize * 0.5,worldSize * 0.5]];
		// _map ctrlMapAnimAdd [0,1,getArray(configfile >> "CfgWorlds" >> worldName >> "centerPosition")];
		ctrlMapAnimCommit _map;
		//NOTE: END NEW CODE
		_map ctrlSetPosition [
			0.219644 * safezoneW + safezoneX,
			0.13381 * safezoneH + safezoneY,
			0.561458 * safezoneW,
			0.728 * safezoneH
		];
		_map ctrlCommit 0.15;
		_map ctrlShow true;
		/*ctrlSetText [1602,"Close map"];*/
		ctrlSetText [1602,"nocebo\images\closeMap.paa"];
	};
};
true