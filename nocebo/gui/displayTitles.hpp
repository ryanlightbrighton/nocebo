class RscTitles {
	//titles[] = {};
	class FixVehProgressBar {
		onLoad = "uiNamespace setVariable ['ncb_ui_fixVehProgressBar',_this select 0]";
		onUnLoad = "uiNamespace setVariable ['ncb_ui_fixVehProgressBar',nil]";
		name = "FixVehProgressBar";
		duration = 99999999;
		fadeIn = 0;
		idd = 40568;
		movingEnable = false;
		controls[] = {
			"Background",
			"ProgressBar",
			"Text"
		};
		class Background: Horde_RscPicture {
			idc = 1;
			text = "#(argb,8,8,3)color(0,0,0,1)";
			x = 0.208333 * safezoneW + safezoneX;
			y = 0.15 * safezoneH + safezoneY;
			w = 0.583333 * safezoneW;
			h = 0.07 * safezoneH;
			colorText[] = {0,0,0,1};
			colorBackground[] = {0,0,0,1};
			colorActive[] = {0,0,0,1};
		};
		class ProgressBar: Horde_RscProgress {
			idc = 2;
			colorFrame[] = {0,0,0,0.4};
			colorBar[] = {1,0,0,1};
			x = 0.208333 * safezoneW + safezoneX;
			y = 0.164 * safezoneH + safezoneY;
			w = 0.583333 * safezoneW;
			h = 0.042 * safezoneH;
		};
		class Text: horde_RscText {
			idc = 3;
			text = "PROGRESS";
			x = 0.208333 * safezoneW + safezoneX;
			y = 0.052 * safezoneH + safezoneY;
			w = 0.583333 * safezoneW;
			h = 0.07 * safezoneH;
			sizeEx = 0.048 / (getResolution select 5);
		};
	};
	class playerMonitor {
		onLoad = "\
			uiNamespace setVariable ['ncb_ui_playerMonitor', (_this select 0)];\
			[\
			    ['playerMonitor'],\
			    horde_fnc_playerMonitor,\
			    0.1\
			] call horde_fnc_addEachFrame;\
			if (isNil 'ncb_gv_distanceData') then {\
				ncb_gv_distanceData = [false,0,getPosWorld player,false,0]\
			};\
			[\
			    ['playerSetNeeds'],\
			    horde_fnc_playerSetNeeds,\
			    2\
			] call horde_fnc_addEachFrame;\
		";
		onUnload = "uiNamespace setVariable ['ncb_ui_playerMonitor', nil]";
		name = "playerMonitor";
		duration = 99999999;
		fadeIn = 0;
		idd = 2502;
		movingEnable = false;
		class controlsBackground {
			class BackGround : Horde_BackGround {
				idc = 0;
				x = 0.842708 * safezoneW + safezoneX;
				y = 0.654 * safezoneH + safezoneY;
				w = 0.138542 * safezoneW;
				h = 0.294 * safezoneH;
			};
		};
		class Controls {
			class HealthText : horde_RscText {
				idc = 1;
				text = "Health"; // text = "Bleeding";
				x = 0.85 * safezoneW + safezoneX;
				y = 0.668 * safezoneH + safezoneY;
				w = 0.123958 * safezoneW;
				h = 0.028 * safezoneH;
			};
			class BleedingText : horde_RscText {
				idc = 2;
				text = "Bleeding"; // text = "Lodged Bullets";
				x = 0.85 * safezoneW + safezoneX;
				y = 0.738 * safezoneH + safezoneY;
				w = 0.123958 * safezoneW;
				h = 0.028 * safezoneH;
			};
			class FoodText : horde_RscText {
				idc = 3;
				text = "Food";
				x = 0.85 * safezoneW + safezoneX;
				y = 0.808 * safezoneH + safezoneY;
				w = 0.123958 * safezoneW;
				h = 0.028 * safezoneH;
			};
			class WaterText : horde_RscText {
				idc = 4;
				text = "Water";
				x = 0.85 * safezoneW + safezoneX;
				y = 0.878 * safezoneH + safezoneY;
				w = 0.123958 * safezoneW;
				h = 0.028 * safezoneH;
			};
			class HealthProgress : Horde_RscProgress {
				idc = 5;
				x = 0.85 * safezoneW + safezoneX;
				y = 0.696 * safezoneH + safezoneY;
				w = 0.123958 * safezoneW;
				h = 0.028 * safezoneH;
			};
			class BleedingProgress : Horde_RscProgress {
				idc = 6;
				x = 0.85 * safezoneW + safezoneX;
				y = 0.766 * safezoneH + safezoneY;
				w = 0.123958 * safezoneW;
				h = 0.028 * safezoneH;
				colorBar[] = {187/256,10/256,30/256,1};
			};
			class FoodProgress : Horde_RscProgress {
				idc = 7;
				x = 0.85 * safezoneW + safezoneX;
				y = 0.836 * safezoneH + safezoneY;
				w = 0.123958 * safezoneW;
				h = 0.028 * safezoneH;
			};
			class WaterProgress : Horde_RscProgress {
				idc = 8;
				x = 0.85 * safezoneW + safezoneX;
				y = 0.906 * safezoneH + safezoneY;
				w = 0.123958 * safezoneW;
				h = 0.028 * safezoneH;
			};
		};
	};
};
