////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT START (by Horde, v1.063, #Jynevy)
////////////////////////////////////////////////////////

#define ST_LEFT				0x00
#define ST_RIGHT			0x01
#define ST_CENTER			0x02
#define ST_PICTURE			0x30
#define ST_ROUNDED1			128
#define ST_MULTI			0x10
#define LARGE_HEADER		0.048
#define SMALL_HEADER		0.023
#define COLOUR_HEADER_TEXT	{1, 1, 1, 0.8}

class Horde_interactionMenu_refit {
	idd = 6666;
	movingEnable = false;
	onLoad = "'dynamicBlur' ppEffectEnable true;'dynamicBlur' ppEffectAdjust [3];'dynamicBlur' ppEffectCommit 0.25;\
				10000 cutText ['','PLAIN DOWN'];\
				uiNamespace setVariable ['Horde_InteractionMenu', (_this select 0)];\
				_ret = 0 call horde_fnc_setupVehicleAddWeaponMainMenuDlg;\
				0 = [[6666,false],[6667,false],[6668,true],[6669,false],[6670,false],[6671,true]] spawn horde_fnc_rotDlgObject;\
				for '_i' from 6666 to 6671 step 1 do {_this select 0 displayCtrl _i ctrlEnable false};\
			";
	onUnload = "'dynamicBlur' ppEffectAdjust [0];'dynamicBlur' ppEffectCommit 0.25;";

	class controls {};

	class Objects {
		class weaponBagModel: horde_ctrlObject {
			idc = 6666;
			model = "a3\drones_f\weapons_f_gamma\ammoboxes\bags\uav_backpack_f.p3d";
			x = 0.290675 * safezoneW + safezoneX;
			z = 0.695662;
			y = 0.481971 * safezoneH + safezoneY;
			scale = 0.096491 / (getResolution select 5);
		};
		class tripodBagModel: horde_ctrlObject {
			idc = 6667;
			model = "a3\drones_f\weapons_f_gamma\ammoboxes\bags\uav_backpack_f.p3d";
			x = 0.430674 * safezoneW + safezoneX;
			z = 0.695662;
			y = 0.481971 * safezoneH + safezoneY;
			scale = 0.096491 / (getResolution select 5);

		};
		class requiredItemModel: horde_ctrlObject {
			idc = 6668;
			model = "a3\structures_f\items\tools\grinder_f.p3d";
			x = 0.567758 * safezoneW + safezoneX;
			z = 0.695662;
			y = 0.426671 * safezoneH + safezoneY;
			scale = 0.134991 / (getResolution select 5);
		};
		class availableWeaponBagModel: horde_ctrlObject {
			idc = 6669;
			model = "\A3\Drones_F\Weapons_F_Gamma\Ammoboxes\Bags\UAV_backpack_F.p3d";
			x = 0.290675 * safezoneW + safezoneX;
			z = 0.695662;
			y = 0.824971 * safezoneH + safezoneY;
			scale = 0.096491 / (getResolution select 5);
		};
		class availableTripodBagModel: horde_ctrlObject {
			idc = 6670;
			model = "\A3\Drones_F\Weapons_F_Gamma\Ammoboxes\Bags\UAV_backpack_F.p3d";
			x = 0.430674 * safezoneW + safezoneX;
			z = 0.695662;
			y = 0.824971 * safezoneH + safezoneY;
			scale = 0.096491 / (getResolution select 5);
		};
		class availableItemModel: horde_ctrlObject {
			idc = 6671;
			model = "a3\structures_f\items\tools\grinder_f.p3d";
			x = 0.567758 * safezoneW + safezoneX;
			z = 0.695662;
			y = 0.768971 * safezoneH + safezoneY;
			scale = 0.134991 / (getResolution select 5);
		};
	};

	class ControlsBackground {
		// background

		class backGround: horde_RscPicture {
			idc = 2200;

			text = "#(argb,8,8,3)color(0.1,0,0,0.8)";
			x = 0.215625 * safezoneW + safezoneX;
			y = 0.164 * safezoneH + safezoneY;
			w = 0.56875 * safezoneW;
			h = 0.756 * safezoneH;
		};

		// text

		class RscText_1000: horde_RscText {
			idc = 1000;

			text = ""; // Vehicle display name
			x = 0.230208 * safezoneW + safezoneX;
			y = 0.192 * safezoneH + safezoneY;
			w = 0.401042 * safezoneW;
			h = 0.056 * safezoneH;
			sizeEx = LARGE_HEADER * safezoneH;
		};
		class RscText_1001: horde_RscText {
			idc = 1001;

			text = "Actions";
			x = 0.645833 * safezoneW + safezoneX;
			y = 0.192 * safezoneH + safezoneY;
			w = 0.123958 * safezoneW;
			h = 0.056 * safezoneH;
			sizeEx = LARGE_HEADER * safezoneH;
		};
		class RscText_1002: horde_RscText {
			idc = 1002;

			text = ""; // Player display name
			x = 0.230208 * safezoneW + safezoneX;
			y = 0.57 * safezoneH + safezoneY;
			w = 0.401042 * safezoneW;
			h = 0.056 * safezoneH;
			sizeEx = LARGE_HEADER * safezoneH;
		};
		class RscText_1003: horde_RscText {
			idc = 1003;

			text = "Required Items";
			x = 0.230208 * safezoneW + safezoneX;
			y = 0.262 * safezoneH + safezoneY;
			w = 0.401042 * safezoneW;
			h = 0.028 * safezoneH;
		};
		class RscText_1004: horde_RscText {
			idc = 1004;

			text = "Weapon Bag";
			x = 0.230208 * safezoneW + safezoneX;
			y = 0.304 * safezoneH + safezoneY;
			w = 0.123958 * safezoneW;
			h = 0.028 * safezoneH;
		};
		class RscText_1005: horde_RscText {
			idc = 1005;

			text = "Tripod Bag";
			x = 0.36875 * safezoneW + safezoneX;
			y = 0.304 * safezoneH + safezoneY;
			w = 0.123958 * safezoneW;
			h = 0.028 * safezoneH;
		};
		class RscText_1006: horde_RscText {
			idc = 1006;

			text = ""; // Required Weapon Bag Display Name
			x = 0.230208 * safezoneW + safezoneX;
			y = 0.528 * safezoneH + safezoneY;
			w = 0.123958 * safezoneW;
			h = 0.028 * safezoneH;
		};
		class RscText_1007: horde_RscText {
			idc = 1007;

			text = ""; // Required Stand Bag Display Name
			x = 0.36875 * safezoneW + safezoneX;
			y = 0.528 * safezoneH + safezoneY;
			w = 0.123958 * safezoneW;
			h = 0.028 * safezoneH;
		};
		class RscText_1008: horde_RscText {
			idc = 1008;

			text = ""; // Available weapon bag name
			x = 0.230208 * safezoneW + safezoneX;
			y = 0.64 * safezoneH + safezoneY;
			w = 0.123958 * safezoneW;
			h = 0.028 * safezoneH;
		};
		class RscText_1009: horde_RscText {
			idc = 1009;

			text = ""; // Available weaponbag location (in boot or on players back)
			x = 0.230208 * safezoneW + safezoneX;
			y = 0.864 * safezoneH + safezoneY;
			w = 0.123958 * safezoneW;
			h = 0.028 * safezoneH;
		};
		class RscText_1010: horde_RscText {
			idc = 1010;

			text = ""; // Assigned Stand Bag Name
			x = 0.36875 * safezoneW + safezoneX;
			y = 0.64 * safezoneH + safezoneY;
			w = 0.123958 * safezoneW;
			h = 0.028 * safezoneH;
		};
		class RscText_1011: horde_RscText {
			idc = 1011;

			text = ""; // Available standbag location (in boot or on players back)
			x = 0.36875 * safezoneW + safezoneX;
			y = 0.864 * safezoneH + safezoneY;
			w = 0.123958 * safezoneW;
			h = 0.028 * safezoneH;
		};
		class RscText_1012: horde_RscText {
			idc = 1012;

			text = "Tool";
			x = 0.507292 * safezoneW + safezoneX;
			y = 0.304 * safezoneH + safezoneY;
			w = 0.123958 * safezoneW;
			h = 0.028 * safezoneH;
		};
		class RscText_1013: horde_RscText {
			idc = 1013;

			text = ""; // Required Tool Display Name
			x = 0.507292 * safezoneW + safezoneX;
			y = 0.528 * safezoneH + safezoneY;
			w = 0.123958 * safezoneW;
			h = 0.028 * safezoneH;
		};
		class RscText_1014: horde_RscText {
			idc = 1014;

			text = "Assigned Item";
			x = 0.507292 * safezoneW + safezoneX;
			y = 0.64 * safezoneH + safezoneY;
			w = 0.123958 * safezoneW;
			h = 0.028 * safezoneH;
		};
		class RscText_1015: horde_RscText {
			idc = 1015;

			text = ""; // Assigned Item Name
			x = 0.507292 * safezoneW + safezoneX;
			y = 0.864 * safezoneH + safezoneY;
			w = 0.123958 * safezoneW;
			h = 0.028 * safezoneH;
		};
		class RscText_1016: horde_RscText {
			idc = 1016;

			text = ""; // Action_button_background (NO ACTIONS AVAILABLE)
			x = 0.645833 * safezoneW + safezoneX;
			y = 0.262 * safezoneH + safezoneY;
			w = 0.123958 * safezoneW;
			h = 0.63 * safezoneH;
		};

		// pictures

		class reqWeapBagPicture: horde_RscPicture {
			idc = 1200;

			text = "";
			x = 0.230208 * safezoneW + safezoneX;
			y = 0.332 * safezoneH + safezoneY;
			w = 0.123958 * safezoneW;
			h = 0.196 * safezoneH;
		};
		class reqStandBagPicture: horde_RscPicture {
			idc = 1201;

			text = "";
			x = 0.36875 * safezoneW + safezoneX;
			y = 0.332 * safezoneH + safezoneY;
			w = 0.123958 * safezoneW;
			h = 0.196 * safezoneH;
		};
		class availableWeapBagPicture: horde_RscPicture {
			idc = 1202;

			text = "";
			x = 0.230208 * safezoneW + safezoneX;
			y = 0.668 * safezoneH + safezoneY;
			w = 0.123958 * safezoneW;
			h = 0.196 * safezoneH;
		};
		class availableStandBagPicture: horde_RscPicture {
			idc = 1203;

			text = "";
			x = 0.36875 * safezoneW + safezoneX;
			y = 0.668 * safezoneH + safezoneY;
			w = 0.123958 * safezoneW;
			h = 0.196 * safezoneH;
		};
		class reqToolPicture: horde_RscPicture {
			idc = 1204;

			text = "";
			x = 0.507292 * safezoneW + safezoneX;
			y = 0.332 * safezoneH + safezoneY;
			w = 0.123958 * safezoneW;
			h = 0.196 * safezoneH;
		};
		class assignedItemPicture: horde_RscPicture {
			idc = 1205;

			text = "";
			x = 0.507292 * safezoneW + safezoneX;
			y = 0.668 * safezoneH + safezoneY;
			w = 0.123958 * safezoneW;
			h = 0.196 * safezoneH;
		};

		// buttons

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
			x = 0.645833 * safezoneW + safezoneX;
			y = 0.024 * safezoneH + safezoneY;
			w = 0.335417 * safezoneW;
			h = 0.238 * safezoneH;
			colorText[] = {0,0,0,0};
			colorBackground[] = {0,0,0,0};
		};
		class RscButton_1501: RscButton_1500 {
			idc = 1501;

			x = 0.769792 * safezoneW + safezoneX;
			y = 0.262 * safezoneH + safezoneY;
			w = 0.21875 * safezoneW;
			h = 0.714 * safezoneH;
		};
		class RscButton_1502: RscButton_1500 {
			idc = 1502;

			x = 0.00416666 * safezoneW + safezoneX;
			y = 0.024 * safezoneH + safezoneY;
			w = 0.641667 * safezoneW;
			h = 0.868 * safezoneH;
		};
		class RscButton_1503: RscButton_1500 {
			idc = 1503;

			x = 0.01875 * safezoneW + safezoneX;
			y = 0.892 * safezoneH + safezoneY;
			w = 0.751042 * safezoneW;
			h = 0.098 * safezoneH;
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
	};
};
