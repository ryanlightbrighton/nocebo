#define ST_LEFT				0x00
#define ST_RIGHT			0x01
#define ST_CENTER			0x02
#define ST_PICTURE			0x30
#define ST_ROUNDED1			128
#define ST_MULTI			0x10
#define LARGE_HEADER		0.048
#define SMALL_HEADER		0.023
#define COLOUR_HEADER_TEXT	{1, 1, 1, 0.8}

class Horde_progressMenu {
	idd = -1;
	movingEnable = true;
	onLoad = "uiNamespace setVariable ['Horde_progressMenu',(_this select 0)]";
	onUnload = "uiNamespace setVariable ['Horde_progressMenu',nil]";
	// onUnload = ";\
	// uiNamespace setVariable ['Horde_progressMenu', nil];\
	// 	_var = player getVariable 'interact_vehicle_class';\
	// 	_var setVariable ['vehiclePlayerInteracting', nil, true]";
	class controlsBackground {};
	class Objects {};
	class Controls {
		// background

		class IGUIBack_2200: horde_RscPicture {
			idc = 2200;

			text = "#(argb,8,8,3)color(0.1,0,0,0.8)";
			x = 0.63125 * safezoneW + safezoneX;
			y = 0.164 * safezoneH + safezoneY;
			w = 0.153125 * safezoneW;
			h = 0.112 * safezoneH;
		};
		class RscText_1000: horde_RscText {
			idc = 1000;

			x = 0.645833 * safezoneW + safezoneX;
			y = 0.192 * safezoneH + safezoneY;
			w = 0.0875 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class closeMenu_picture: horde_RscPicture {
			idc = 1598;

			text = "client\gui\images\icon_close.paa";
			x = 0.733333 * safezoneW + safezoneX;
			y = 0.192 * safezoneH + safezoneY;
			w = 0.0364583 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class closeMenu_button: horde_RscButton {
			idc = 1599;
			action = "closeDialog 0";
			borderSize = 0;
			colorBackgroundActive[] = {0,0,0,0};
			colorBackgroundDisabled[] = {0,0,0,0};
			colorBorder[] = {0,0,0,0};
			colorDisabled[] = {0,0,0,0};
			colorFocused[] = {0,0,0,0};
			colorShadow[] = {0,0,0,0};
			offsetPressedX = 0;
			offsetPressedY = 0;
			offsetX = 0;
			offsetY = 0;
			period = 1.2;
			periodFocus = 1.2;
			periodOver = 1.2;
			x = 0.733333 * safezoneW + safezoneX;
			y = 0.192 * safezoneH + safezoneY;
			w = 0.0364583 * safezoneW;
			h = 0.056 * safezoneH;
			colorText[] = {0,0,0,0};
			colorBackground[] = {0,0,0,0};
		};
	};
};