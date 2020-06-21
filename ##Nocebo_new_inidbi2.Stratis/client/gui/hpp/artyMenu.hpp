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

class ncb_dlg_artyMenu {
	idd = -1;
	movingEnable = false;
	onLoad = "\
		uiNamespace setVariable ['ncb_dlg_artyMenu', (_this select 0)];\
		_display = (_this select 0);\
		((_this select 0) displayCtrl 1800) ctrlMapAnimAdd [0,1,[worldSize * 0.5,worldSize * 0.5]];\
		ctrlMapAnimCommit ((_this select 0) displayCtrl 1800);\
	";
	onUnload = "\
		uiNamespace setVariable ['ncb_dlg_artyMenu', nil];\
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
			onMouseButtonDblClick = "_this call horde_fnc_artySalvo";
			tooltip = "Double LMB on area to order Artillery Strike.";
		};
	};
};