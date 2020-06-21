#define ST_LEFT				0x00
#define ST_RIGHT			0x01
#define ST_CENTER			0x02
#define ST_PICTURE			0x30
#define ST_ROUNDED1			128
#define ST_MULTI			0x10
#define CT_MAP_MAIN 		101
#define LARGE_HEADER		0.048
#define SMALL_HEADER		0.023
#define COLOUR_HEADER_TEXT	{1, 1, 1, 0.8}

// 		_this call horde_fnc_setupRespawnDialog;\

class Horde_respawnMenu {
	idd = -1;
	movingEnable = false;
	onLoad = "\
		uiNamespace setVariable ['Horde_respawnMenu', (_this select 0)];\
		_display = (_this select 0);\
		_button = _display displayCtrl 1800;\
		_button ctrlShow false;\
		missionNameSpace setVariable ['playerOkToCloseRespawnMenu',false];\
		0 call horde_fnc_respawnMenuMapMarkerManager;\
		['Horde_respawnMenu',1600,0.8,0] call horde_fnc_ctrlSetScale;\
		['Horde_respawnMenu',1601,0.8,0] call horde_fnc_ctrlSetScale;\
		['Horde_respawnMenu',1602,0.8,0] call horde_fnc_ctrlSetScale;\
		if not (isNil 'playerRespawnType') then {\
			_bar = _display displayCtrl 1603;\
			_bar ctrlShow false;\
		};\
		(_display displayCtrl 1600) ctrlSetTooltip ('Diver respawn' + endl + 'Skills reset');\
		(_display displayCtrl 1601) ctrlSetTooltip ('Paradrop respawn' + endl + 'Skills reset');\
		(_display displayCtrl 1602) ctrlSetTooltip ('Respawn at any' + endl + 'owned tent, group member,' + endl + 'or beacon' + endl + 'Skills retained');\
		(_display displayCtrl 1800) ctrlSetTooltip ('Double LMB on' + endl + 'tent or beacon' + endl + 'to select it');\
	";
	onUnload = ";\
		uiNamespace setVariable ['Horde_respawnMenu', nil];\
		if (not (missionNameSpace getVariable 'playerOkToCloseRespawnMenu')) then {\
			0 call horde_fnc_openRespawnMenu;\
		};\
	";
	class controlsBackground {};
	class Objects {};
	class Controls {
		class menuBackground : horde_RscPicture {
			idc = 2200;
			text = "#(argb,8,8,3)color(0.1,0,0,0.8)";
			x = 0.784375 * safezoneW + safezoneX;
			y = 0.136 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.728 * safezoneH;
		};
		class map : rscMapControl {
			idc = 1800;
			x = 0.219644 * safezoneW + safezoneX;
			y = 0.13381 * safezoneH + safezoneY;
			w = 0.561458 * safezoneW;
			h = 0.728 * safezoneH;
			onMouseButtonDblClick = "_this call horde_fnc_respawnMapClicked";
			//tooltip = "Double LMB on tent to select it.";
			// x = 0.784375 * safezoneW + safezoneX;
			// y = 0.136 * safezoneH + safezoneY;
			// w = 0;
			// h = 0.728 * safezoneH;
		};
		// class RscButton_1600: horde_RscButton {
		class RespawnDiver : horde_RscActiveText {
			idc = 1600;
			style = 0x30;
			color[] = {1,1,1,0.8};
			colorActive[] = {1,1,1,1};
			colorDisabled[] = {1,1,1,1};
			// text = "Respawn at coast";
			text = "nocebo\images\respawnDiver.paa";
			x = 0.791667 * safezoneW + safezoneX;
			y = 0.15 * safezoneH + safezoneY;
			w = 0.160417 * safezoneW;
			h = 0.238 * safezoneH;
			action = "\
				missionNamespace setVariable ['playerRespawnType','COAST'];\
				missionNameSpace setVariable ['playerOkToCloseRespawnMenu',true];\
				forceRespawn player;\
			";
			onMouseEnter = "['Horde_respawnMenu',1600,1,0.05] call horde_fnc_ctrlSetScale";
			onMouseExit = "['Horde_respawnMenu',1600,0.8,0.05] call horde_fnc_ctrlSetScale";
		};
		class RespawnPara : horde_RscActiveText {
			idc = 1601;
			style = 0x30;
			color[] = {1,1,1,0.8};
			colorActive[] = {1,1,1,1};
			colorDisabled[] = {1,1,1,1};
			// text = "Paradrop";
			text = "nocebo\images\respawnPara.paa";
			x = 0.791667 * safezoneW + safezoneX;
			y = 0.388 * safezoneH + safezoneY;
			w = 0.160417 * safezoneW;
			h = 0.238 * safezoneH;
			action = "\
				missionNamespace setVariable ['playerRespawnType','PARADROP'];\
				missionNameSpace setVariable ['playerOkToCloseRespawnMenu',true];\
				forceRespawn player;\
			";
			onMouseEnter = "['Horde_respawnMenu',1601,1,0.05] call horde_fnc_ctrlSetScale";
			onMouseExit = "['Horde_respawnMenu',1601,0.8,0.05] call horde_fnc_ctrlSetScale";
		};
		class RespawnTent : horde_RscActiveText {
			idc = 1602;
			style = 0x30;
			color[] = {1,1,1,0.8};
			colorActive[] = {1,1,1,1};
			colorDisabled[] = {1,1,1,1};
			// text = "Open map";
			text = "nocebo\images\respawnTent2.paa";
			x = 0.791667 * safezoneW + safezoneX;
			y = 0.626 * safezoneH + safezoneY;
			w = 0.160417 * safezoneW;
			h = 0.224 * safezoneH;
			action = "_ret = 0 call horde_fnc_respawnMenuMapControl";
			onMouseEnter = "['Horde_respawnMenu',1602,1,0.05] call horde_fnc_ctrlSetScale";
			onMouseExit = "['Horde_respawnMenu',1602,0.8,0.05] call horde_fnc_ctrlSetScale";
		};
		class BleedingBackground: menuBackground {
			idc = 1605;
			text = "#(argb,8,8,3)color(0,0,0,1)";
			x = 0.0479167 * safezoneW + safezoneX;
			y = 0.15 * safezoneH + safezoneY;
			w = 0.0583333 * safezoneW;
			h = 0.602 * safezoneH;
		};
		class Bleeding : Horde_RscProgress {
			idc = 1603;
			colorFrame[] = {1,1,1,0.4};
			colorBar[] = {0.8,0,0,1};
			x = 0.0625 * safezoneW + safezoneX;
			y = 0.15 * safezoneH + safezoneY;
			w = 0.0291667 * safezoneW;
			h = 0.602 * safezoneH;
			style = 0x01;
		};
		class SkullBackground: menuBackground {
			idc = 1604;
			text = "#(argb,8,8,3)color(0,0,0,1)";
			x = 0.0479167 * safezoneW + safezoneX;
			y = 0.752 * safezoneH + safezoneY;
			w = 0.0583333 * safezoneW;
			h = 0.098 * safezoneH;
		};
		class Skull : horde_RscPicture {
			idc = 1606;
			text = "nocebo\images\skull.paa";
			x = 0.0479167 * safezoneW + safezoneX;
			y = 0.752 * safezoneH + safezoneY;
			w = 0.0583333 * safezoneW;
			h = 0.098 * safezoneH;
		};
	};
};


