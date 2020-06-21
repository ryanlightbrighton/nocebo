#define ST_LEFT				0x00
#define ST_RIGHT			0x01
#define ST_CENTER			0x02
#define ST_PICTURE			0x30
#define ST_ROUNDED1			128
#define ST_MULTI			0x10
#define CT_MAP_MAIN 		101
#define LARGE_HEADER		0.048
#define SMALL_HEADER		0.023
#define COLOUR_HEADER_TEXT	{1,1,1,0.8}
// ((_this select 0) displayCtrl 1800) ctrlMapAnimAdd [0,1,getArray(configfile >> 'CfgWorlds' >> worldName >> 'centerPosition')];\
class ncb_dlg_casRemCtrlMenu {
	idd = -1;
	movingEnable = false;
	onLoad = "\
		uiNamespace setVariable ['ncb_dlg_casRemCtrlMenu', (_this select 0)];\
		_display = (_this select 0);\
		((_this select 0) displayCtrl 1800) ctrlMapAnimAdd [0,1,[worldSize * 0.5,worldSize * 0.5]];\
		ctrlMapAnimCommit ((_this select 0) displayCtrl 1800);\
		((_this select 0) displayCtrl 1803) cbSetChecked false;\
	";
	onUnload = "\
		uiNamespace setVariable ['ncb_dlg_casRemCtrlMenu', nil];\
	";
	class controlsBackground {};
	class Objects {};
	class Controls {
		class map : rscMapControl {
			idc = 1800;
			x = 0.208333 * safezoneW + safezoneX;
			y = 0.15 * safezoneH + safezoneY;
			w = 0.452083 * safezoneW;
			h = 0.7 * safezoneH;
			onMouseButtonDblClick = "_this call horde_fnc_cas";
			tooltip = "Double LMB on area to order CAS.";
		};
		class setHeight : horde_RscEdit {
			idc = 1801;
			text = "400";
			x = 0.660417 * safezoneW + safezoneX;
			y = 0.22 * safezoneH + safezoneY;
			w = 0.13125 * safezoneW;
			h = 0.07 * safezoneH;
			tooltip = "Set height CAS cruises at.";
		};
		class setRadius : horde_RscEdit {
			idc = 1802;
			text = "800";
			x = 0.660417 * safezoneW + safezoneX;
			y = 0.36 * safezoneH + safezoneY;
			w = 0.13125 * safezoneW;
			h = 0.07 * safezoneH;
			tooltip = "Set radius CAS cruises at.";
		};
		class setFollowTerrain : horde_rscCheckBox {
			idc = 1803;
			text = "";
			x = 0.660417 * safezoneW + safezoneX;
			y = 0.5 * safezoneH + safezoneY;
			w = 0.13125 * safezoneW;
			h = 0.07 * safezoneH;
			colorBackground[] = {0,0,0,1};
		};
		class heightText : horde_RscText {
			idc = 1804;
			text = "Height";
			x = 0.660417 * safezoneW + safezoneX;
			y = 0.15 * safezoneH + safezoneY;
			w = 0.13125 * safezoneW;
			h = 0.07 * safezoneH;
		};
		class radiusText : horde_RscText {
			idc = 1805;
			text = "Radius";
			x = 0.660417 * safezoneW + safezoneX;
			y = 0.29 * safezoneH + safezoneY;
			w = 0.13125 * safezoneW;
			h = 0.07 * safezoneH;
		};
		class FollowTerrainText : horde_RscText {
			idc = 1806;
			text = "Follow terrain";
			x = 0.660417 * safezoneW + safezoneX;
			y = 0.43 * safezoneH + safezoneY;
			w = 0.13125 * safezoneW;
			h = 0.07 * safezoneH;
		};
	};
};