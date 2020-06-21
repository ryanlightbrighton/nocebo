// https://forums.bistudio.com/forums/topic/167884-dialog-controls-on-3d-object-surface/

class ncb_dlg_fuseSetting {
    idd = 10846;
    movingenable = false;
	onLoad = "\
		[_this select 0,'main'] call horde_fnc_fuseSetting;\
	";
	onUnload = "\
		uiNamespace setVariable ['ncb_dlg_fuseSetting',nil];\
	";
	class controlsBackground {};
	class Objects {
		class ammoModel: horde_ctrlObject {
			idc = 66;
			model = "A3\Weapons_F_Exp\Launchers\RPG7\rocket_rpg7.p3d";
			x = 0.290675 * safezoneW + safezoneX;
			z = 0.695662;
			y = 0.481971 * safezoneH + safezoneY;
			scale = 0.096491 / (getResolution select 5);
			// _item.p3d
			onload = "\
				[_this select 0,'object'] call horde_fnc_fuseSetting;\
			";
			canDrag = 0;
		};
	};
    class Controls {
		class currentFuse : horde_RscStructuredText {
			idc = 1001;
			text = "";
			x = 0.448958 * safezoneW + safezoneX;
			y = 0.15 * safezoneH + safezoneY;
			w = 0.102083 * safezoneW;
			h = 0.06 * safezoneH;
			colorBackground[] = {1,1,1,0.1};
			colorActive[] = {-1,-1,-1,0};
			colorText[] = {0,0,0,1};
		};
		class newFuse : horde_RscStructuredText {
			idc = 1002;
			text = "<t size='1.7' color='#000000' align='center' shadow='2'>RANGE (m):</t>";
			x = 0.448958 * safezoneW + safezoneX;
			y = 0.23 * safezoneH + safezoneY;
			w = 0.102083 * safezoneW;
			h = 0.033 * safezoneH;
			colorBackground[] = {1,1,1,0.1};
			colorActive[] = {-1,-1,-1,0};
			colorText[] = {0,0,0,1};
		};
		class inputFuse : horde_RscEdit {
			idc = 1801;
			text = "";
			x = 0.478125 * safezoneW + safezoneX;
			y = 0.276 * safezoneH + safezoneY;
			w = 0.04375 * safezoneW;
			h = 0.028 * safezoneH;
			colorText[] = {0,0,0,1};
			onLoad = "\
				[_this select 0,'input'] call horde_fnc_fuseSetting;\
			";
		};
	};
};