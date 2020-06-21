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

class Horde_interactionMenu_vehicleParts {
	idd = 6666;
	movingEnable = true;
	onLoad = "'dynamicBlur' ppEffectEnable true;'dynamicBlur' ppEffectAdjust [3];'dynamicBlur' ppEffectCommit 0.25;\
				10000 cutText ['','PLAIN DOWN'];\
				uiNamespace setVariable ['Horde_InteractionMenu',(_this select 0)];\
				_ret = 0 call horde_fnc_setupVehicleMainMenuDlg;\
			";
	onUnload = "'dynamicBlur' ppEffectAdjust [0];'dynamicBlur' ppEffectCommit 0.25;";
	class controls {};
	class Objects {
		//|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
		class assignedItemModel: horde_ctrlObject {
			idc = 6666;
			model = "\A3\Weapons_f\empty";
			// model = "\A3\Drones_F\Weapons_F_Gamma\Ammoboxes\Bags\UAV_backpack_F.p3d";
			x = 0.32 * safezoneW + safezoneX;
			y = 0.4 * safezoneH + safezoneY;
			z = 0.168;
			// direction[] = {0,0,1};
			scale = 0.05;
			shadow = 1;
			// up[] = {0,1,0};
		};
		//|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
	};
	class ControlsBackground {
		// background
		class IGUIBack_2200: horde_RscPicture {
			idc = 2200;
			text = "#(argb,8,8,3)color(0.1,0,0,0.8)";
			x = 0.215625 * safezoneW + safezoneX;
			y = 0.164 * safezoneH + safezoneY;
			w = 0.56875 * safezoneW;
			h = 0.756 * safezoneH;
		};

		// text

		class RscText_1000: horde_RscText // VEHICLE DISPLAY NAME
		{
			idc = 1000;
			x = 0.230208 * safezoneW + safezoneX;
			y = 0.192 * safezoneH + safezoneY;
			w = 0.2625 * safezoneW;
			h = 0.056 * safezoneH;
			sizeEx = LARGE_HEADER * safezoneH;
		};
		class RscText_1001: horde_RscText // ACTIONS
		{
			idc = 1001;
			text = "Actions";
			x = 0.507292 * safezoneW + safezoneX;
			y = 0.192 * safezoneH + safezoneY;
			w = 0.2625 * safezoneW;
			h = 0.056 * safezoneH;
			sizeEx = LARGE_HEADER * safezoneH;
		};
		class RscText_1002: horde_RscText // PLAYER NAME
		{
			idc = 1002;
			x = 0.230208 * safezoneW + safezoneX;
			y = 0.57 * safezoneH + safezoneY;
			w = 0.2625 * safezoneW;
			h = 0.056 * safezoneH;
			sizeEx = LARGE_HEADER * safezoneH;
		};
		class RscText_1003: horde_RscText // VEHICLE LOCATION NAME
		{
			idc = 1003;
			x = 0.230208 * safezoneW + safezoneX;
			y = 0.262 * safezoneH + safezoneY;
			w = 0.2625 * safezoneW;
			h = 0.028 * safezoneH;
		};
		class RscText_1004: horde_RscText // HEADER TOP LEFT
		{
			idc = 1004;
			x = 0.230208 * safezoneW + safezoneX;
			y = 0.304 * safezoneH + safezoneY;
			w = 0.123958 * safezoneW;
			h = 0.028 * safezoneH;
		};
		class RscText_1005: horde_RscText // FOOTER TOP LEFT
		{
			idc = 1005;
			x = 0.230208 * safezoneW + safezoneX;
			y = 0.528 * safezoneH + safezoneY;
			w = 0.123958 * safezoneW;
			h = 0.028 * safezoneH;
		};
		class RscText_1006: horde_RscText // HEADER TOP RIGHT
		{
			idc = 1006;
			x = 0.36875 * safezoneW + safezoneX;
			y = 0.304 * safezoneH + safezoneY;
			w = 0.123958 * safezoneW;
			h = 0.028 * safezoneH;
		};
		class RscText_1007: horde_RscText // FOOTER TOP RIGHT
		{
			idc = 1007;
			x = 0.36875 * safezoneW + safezoneX;
			y = 0.528 * safezoneH + safezoneY;
			w = 0.123958 * safezoneW;
			h = 0.028 * safezoneH;
		};
		class RscText_1008: horde_RscText // HEADER BOTTOM LEFT
		{
			idc = 1008;
			x = 0.230208 * safezoneW + safezoneX;
			y = 0.64 * safezoneH + safezoneY;
			w = 0.123958 * safezoneW;
			h = 0.028 * safezoneH;
		};
		class RscText_1009: horde_RscText // FOOTER BOTTOM LEFT
		{
			idc = 1009;
			x = 0.230208 * safezoneW + safezoneX;
			y = 0.864 * safezoneH + safezoneY;
			w = 0.123958 * safezoneW;
			h = 0.028 * safezoneH;
		};
		class RscText_1010: horde_RscText // HEADER BOTTOM RIGHT
		{
			idc = 1010;
			text = "Assigned Item";
			x = 0.36875 * safezoneW + safezoneX;
			y = 0.64 * safezoneH + safezoneY;
			w = 0.123958 * safezoneW;
			h = 0.028 * safezoneH;
		};
		class RscText_1011: horde_RscText // FOOTER BOTTOM RIGHT
		{
			idc = 1011;
			x = 0.36875 * safezoneW + safezoneX;
			y = 0.864 * safezoneH + safezoneY;
			w = 0.123958 * safezoneW;
			h = 0.028 * safezoneH;
		};
		class RscText_1012: horde_RscText // ACTION BUTTON BACKGROUND
		{
			idc = 1012;
			x = 0.507292 * safezoneW + safezoneX;
			y = 0.276 * safezoneH + safezoneY;
			w = 0.2625 * safezoneW;
			h = 0.616 * safezoneH;
		};
		class FuelDisplay: horde_RscText // FUEL DISPLAY (TOP LEFT PANEL)
		{
			idc = 1013;
			colorBackground[] = {0, 0, 0, 0};
			x = 0.2375 * safezoneW + safezoneX;
			y = 0.346 * safezoneH + safezoneY;
			w = 0.109375 * safezoneW;
			h = 0.168 * safezoneH;
			sizeEx = LARGE_HEADER * safezoneH;
		};

		// PICTURES

		class RscPicture_1200: horde_RscPicture // TOP LEFT
		{
			idc = 1200;
			x = 0.2375 * safezoneW + safezoneX;
			y = 0.346 * safezoneH + safezoneY;
			w = 0.109375 * safezoneW;
			h = 0.168 * safezoneH;
		};
		class RscPicture_1201: horde_RscPicture // TOP RIGHT
		{
			idc = 1201;
			x = 0.376042 * safezoneW + safezoneX;
			y = 0.346 * safezoneH + safezoneY;
			w = 0.109375 * safezoneW;
			h = 0.168 * safezoneH;
		};
		class RscPicture_1202: horde_RscPicture // BOTTOM LEFT
		{
			idc = 1202;
			x = 0.2375 * safezoneW + safezoneX;
			y = 0.682 * safezoneH + safezoneY;
			w = 0.109375 * safezoneW;
			h = 0.168 * safezoneH;
		};
		class RscPicture_1203: horde_RscPicture // BOTTOM RIGHT
		{
			idc = 1203;
			x = 0.376042 * safezoneW + safezoneX;
			y = 0.682 * safezoneH + safezoneY;
			w = 0.109375 * safezoneW;
			h = 0.168 * safezoneH;
		};
		class RscPicture_1204: horde_RscPicture // DESTROYED IMAGE (BOTTOM LEFT)
		{
			idc = 1204;
			text = "#(argb,8,8,3)color(0,0,0,0)";
			x = 0.2375 * safezoneW + safezoneX;
			y = 0.346 * safezoneH + safezoneY;
			w = 0.109375 * safezoneW;
			h = 0.168 * safezoneH;
		};

		// invisible reset panels

		class RscButton_1500: horde_RscButton {
			idc = 1500;
			action = "ctrlSetFocus ((uiNamespace getVariable 'Horde_InteractionMenu') displayCtrl 1599)";
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
			x = 0.507292 * safezoneW + safezoneX;
			y = 0.024 * safezoneH + safezoneY;
			w = 0.48125 * safezoneW;
			h = 0.252 * safezoneH;
			colorText[] = {0,0,0,0};
			colorBackground[] = {0,0,0,0};
		};
		class RscButton_1501: RscButton_1500 {
			idc = 1501;
			x = 0.769792 * safezoneW + safezoneX;
			y = 0.276 * safezoneH + safezoneY;
			w = 0.21875 * safezoneW;
			h = 0.7 * safezoneH;
		};
		class RscButton_1502: RscButton_1500 {
			idc = 1502;
			x = 0.0187503 * safezoneW + safezoneX;
			y = 0.892 * safezoneH + safezoneY;
			w = 0.751042 * safezoneW;
			h = 0.084 * safezoneH;
		};
		class RscButton_1503: RscButton_1500 {
			idc = 1503;
			x = 0.0187499 * safezoneW + safezoneX;
			y = 0.024 * safezoneH + safezoneY;
			w = 0.488542 * safezoneW;
			h = 0.868 * safezoneH;
		};

		// close button

		class closeMenu_picture: horde_RscPicture {
			idc = 1598;

			text = "client\gui\images\icon_close.paa";
			x = 0.733333 * safezoneW + safezoneX;
			y = 0.192 * safezoneH + safezoneY;
			w = 0.0364583 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class closeMenu_button: RscButton_1500 {
			idc = 1599;
			action = "closeDialog 0";
			x = 0.733333 * safezoneW + safezoneX;
			y = 0.192 * safezoneH + safezoneY;
			w = 0.0364583 * safezoneW;
			h = 0.056 * safezoneH;
		};

		// open inventory button

		class openInventory_button: RscButton_1500 {
			idc = 1598;
			action = "player action ['Gear', cursorTarget];";
			text = "INV"; //--- ToDo: Localize;
			x = 0.507292 * safezoneW + safezoneX;
			y = 0.192 * safezoneH + safezoneY;
			w = 0.0364583 * safezoneW;
			h = 0.056 * safezoneH;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0};
		};

		// buttons

		class RscButton_1600: horde_RscButton {
			idc = 1600;
		};
		class RscButton_1601: horde_RscButton {
			idc = 1601;
		};
		class RscButton_1602: horde_RscButton {
			idc = 1602;
		};
		class RscButton_1603: horde_RscButton {
			idc = 1603;
		};
		class RscButton_1604: horde_RscButton {
			idc = 1604;
		};
		class RscButton_1605: horde_RscButton {
			idc = 1605;
		};
		class RscButton_1606: horde_RscButton {
			idc = 1606;
		};
		class RscButton_1607: horde_RscButton {
			idc = 1607;
		};
		class RscButton_1608: horde_RscButton {
			idc = 1606;
		};
		class RscButton_1609: horde_RscButton {
			idc = 1607;
		};

		// buttons for pop-up weapon repair/reammo actions

		class RscButton_1700: horde_RscButton {
			idc = 1700;
		};
		class RscButton_1701: horde_RscButton {
			idc = 1701;
		};
		class RscButton_1702: horde_RscButton {
			idc = 1702;
		};
		class RscButton_1703: horde_RscButton {
			idc = 1703;
		};
		class RscButton_1704: horde_RscButton {
			idc = 1704;
		};
	};
};

////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT START (by Horde, v1.063, #Cohovy)
////////////////////////////////////////////////////////
/*
class Action_title: RscText
{
	idc = 1001;

	text = "Actions"; //--- ToDo: Localize;
	x = 0.507292 * safezoneW + safezoneX;
	y = 0.192 * safezoneH + safezoneY;
	w = 0.226042 * safezoneW;
	h = 0.056 * safezoneH;
};
class close_icon: RscText
{
	idc = 1201;

	x = 0.733333 * safezoneW + safezoneX;
	y = 0.192 * safezoneH + safezoneY;
	w = 0.0364583 * safezoneW;
	h = 0.056 * safezoneH;
};
*/
////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT END
////////////////////////////////////////////////////////

