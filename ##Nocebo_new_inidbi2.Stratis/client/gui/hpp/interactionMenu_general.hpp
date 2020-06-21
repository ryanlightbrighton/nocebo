////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT START (by Horde, v1.063, #Jynevy)
////////////////////////////////////////////////////////

#define ST_LEFT					0x00
#define ST_RIGHT				0x01
#define ST_CENTER				0x02
#define ST_PICTURE				0x30
#define ST_ROUNDED1				128
#define ST_MULTI				0x10
#define LARGE_HEADER			0.048
#define SMALL_HEADER			0.023
#define COLOUR_HEADER_TEXT		{1, 1, 1, 0.8}

class Horde_interactionMenu_general {
	idd = 6666;
	movingEnable = true;
	onLoad = "'dynamicBlur' ppEffectEnable true;'dynamicBlur' ppEffectAdjust [3];'dynamicBlur' ppEffectCommit 0.25;\
		10000 cutText ['','PLAIN DOWN'];\
		uiNamespace setVariable ['Horde_InteractionMenu',(_this select 0)];\
		_ret = 0 call horde_fnc_setupGeneralMenuDlg;\
	";
	onUnload = "'dynamicBlur' ppEffectAdjust [0];'dynamicBlur' ppEffectCommit 0.25;";
	class ControlsBackground {};
	class Objects {};
	class Controls {
		// background
		class IGUIBack_2200: horde_RscPicture {
			idc = 2200;
			text = "";  //text = "#(argb,8,8,3)color(0,0,0,0)";
			x = 0.565625 * safezoneW + safezoneX;
			y = 0.15 * safezoneH + safezoneY;
			w = 0.226042 * safezoneW;
			h = 0.7 * safezoneH;
		};
		// button space
		class buttonTemplate: horde_RscText {
			idc = 1000;
			text = "";
			x = 0.572917 * safezoneW + safezoneX;
			y = 0.164 * safezoneH + safezoneY;
			w = 0.211458 * safezoneW;
			h = 0.672 * safezoneH;
		};
	};
};
