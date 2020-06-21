class ncb_reloadMenuRscText {
    deletable = 0;
    fade = 0;
    access = 0;
    type = 0;
    idc = -1;
    colorBackground[] = {0, 0, 0, 0};
    colorText[] = {1, 1, 1, 1};
    text = "";
    fixedWidth = 0;
    x = 0;
    y = 0;
    h = 0.037;
    w = 0.3;
    style = 0; // 0;
    shadow = 1;
    colorShadow[] = {0, 0, 0, 0.5};
    font = "RobotoCondensed";
    SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
    linespacing = 1;
    tooltipColorText[] = {1, 1, 1, 1};
    tooltipColorBox[] = {1, 1, 1, 1};
    tooltipColorShade[] = {0, 0, 0, 0.65};
};
class ncb_reloadMenuRscTextCenter : ncb_reloadMenuRscText {
	colorBackground[] = {0, 0, 0, 0.7};
	style = ST_CENTER;
};
class ncb_reloadMenuScrollBar {
    color[] = {1, 1, 1, 0.6};
    colorActive[] = {1, 1, 1, 1};
    colorDisabled[] = {1, 1, 1, 0.3};
    thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
    arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
    arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
    border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
    shadow = 0;
    scrollSpeed = 0.06;
    width = 0;
    height = 0;
    autoScrollEnabled = 0;
    autoScrollSpeed = -1;
    autoScrollDelay = 5;
    autoScrollRewind = 0;
};
class ncb_reloadMenuRscListBox {
    deletable = 0;
    fade = 0;
    access = 0;
    type = 5;
    //rowHeight = 0.05 / (getResolution select 5); // <=== experiment with this default 0
    rowHeight = 0.07 / (getResolution select 5); // <=== experiment with this default 0
    colorText[] = {1, 1, 1, 1};
    colorDisabled[] = {1, 1, 1, 0.25};
    colorScrollbar[] = {1, 1, 1, 1};
    colorSelect[] = {1, 1, 1, 1};
    colorSelect2[] = {1, 1, 1, 1};
    colorSelectBackground[] = {0, 0, 0, 1};
    colorSelectBackground2[] = {0, 0, 0, 1};
    colorBackground[] = {0, 0, 0, 1};
    soundSelect[] = {"\A3\ui_f\data\sound\RscListbox\soundSelect", 0.09, 1};
    autoScrollSpeed = -1;
    autoScrollDelay = 5;
    autoScrollRewind = 0;
    arrowEmpty = "#(argb,8,8,3)color(1,1,1,1)";
    arrowFull = "#(argb,8,8,3)color(1,1,1,1)";
    colorPicture[] = {1, 1, 1, 1};
    colorPictureSelected[] = {1, 1, 1, 1};
    colorPictureDisabled[] = {1, 1, 1, 0.25};
    colorPictureRight[] = {1, 1, 1, 1};
    colorPictureRightSelected[] = {1, 1, 1, 1};
    colorPictureRightDisabled[] = {1, 1, 1, 0.25};
    colorTextRight[] = {1, 1, 1, 1};
    colorSelectRight[] = {0, 0, 0, 1};
    colorSelect2Right[] = {0, 0, 0, 1};
    tooltipColorText[] = {1, 1, 1, 1};
    tooltipColorBox[] = {1, 1, 1, 1};
    tooltipColorShade[] = {0, 0, 0, 0.65};
    class ListScrollBar : ncb_reloadMenuScrollBar {
        color[] = {1, 1, 1, 1};
        autoScrollEnabled = 1;
        height = 0;
        width = 0;
    };
    x = 0.1;
    y = 0.1;
    w = 0.3;
    h = 0.3;
    style = 16; // 0x10; //16;
    font = "RobotoCondensed";
    sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
    shadow = 0;
    colorShadow[] = {0, 0, 0, 0.5};
    period = 1.2;
    maxHistoryDelay = 1;
};
class ncb_reloadMenuRscVehicle : ncb_reloadMenuRscListBox {
	canDrag = 1;
	onLBDrag = "_this call horde_fnc_reloadMenuDragStarted";
	onLBDrop = "_this call horde_fnc_reloadMenuDragDropped";
	//drawSideArrows = 0;
	//idcLeft = -1;
	//idcRight = -1;
};
class reloadMenu {
	idd = 456785;
	movingEnable = false;
	onLoad = "\
		uiNamespace setVariable ['reloadMenu', (_this select 0)];\
		[(_this select 0)] call horde_fnc_reloadMenu;\
	";
	//onLoad = "\
	//	uiNamespace setVariable ['reloadMenu', (_this select 0)];\
	//	[(_this select 0)] call fnc_reloadMenu;\
	//";
	onUnload = "\
		uiNamespace setVariable ['reloadMenu', nil];\
	";
	class controlsBackground {
		class vehicleHeader: ncb_reloadMenuRscText
		{
			idc = 995;

			text = "Vehicle";
			x = 0.252083 * safezoneW + safezoneX;
			y = 0.122 * safezoneH + safezoneY;
			w = 0.0510417 * safezoneW;
			h = 0.028 * safezoneH;
			colorBackground[] = {0,0,0,1};
		};
		class playerHeader: ncb_reloadMenuRscText
		{
			idc = 996;

			text = "Player";
			x = 0.514583 * safezoneW + safezoneX;
			y = 0.374 * safezoneH + safezoneY;
			w = 0.0583333 * safezoneW;
			h = 0.028 * safezoneH;
			colorBackground[] = {0,0,0,1};
		};
		class groundHeader: ncb_reloadMenuRscText
		{
			idc = 997;

			text = "Ground";
			x = 0.514583 * safezoneW + safezoneX;
			y = 0.626 * safezoneH + safezoneY;
			w = 0.0510417 * safezoneW;
			h = 0.028 * safezoneH;
			colorBackground[] = {0,0,0,1};
		};
		class cargoHeader: ncb_reloadMenuRscText
		{
			idc = 998;

			text = "Cargo";
			x = 0.514583 * safezoneW + safezoneX;
			y = 0.122 * safezoneH + safezoneY;
			w = 0.0510417 * safezoneW;
			h = 0.028 * safezoneH;
			colorBackground[] = {0,0,0,1};
		};
	};
	class Objects {};
	// look up controlsGroup!!! - example: https://github.com/acemod/ACE3/blob/95aa9f604bf83d29ad51267cc1d62ded6eaf2f18/addons/spectator/UI/interface.hpp#L36
	class Controls {
		class Vehicle : ncb_reloadMenuRscText
		{
			idc = 1000;
			x = 0.252083 * safezoneW + safezoneX;
			y = 0.15 * safezoneH + safezoneY;
			w = 0.233333 * safezoneW;
			h = 0.728 * safezoneH;
			colorBackground[] = {0,0,0,0.8};
		};
		class player : ncb_reloadMenuRscListBox
		{
			idc = 1001;
			x = 0.514583 * safezoneW + safezoneX;
			y = 0.402 * safezoneH + safezoneY;
			w = 0.233333 * safezoneW;
			h = 0.224 * safezoneH;
			colorBackground[] = {0,0,0,0.8};
			canDrag = 1;
			onLBDrag = "_this call horde_fnc_reloadMenuDragStarted";
			onLBDrop = "_this call horde_fnc_reloadMenuDragDropped";
		};
		class cargo : ncb_reloadMenuRscListBox
		{
			idc = 1002;
			x = 0.514583 * safezoneW + safezoneX;
			y = 0.15 * safezoneH + safezoneY;
			w = 0.233333 * safezoneW;
			h = 0.224 * safezoneH;
			colorBackground[] = {0,0,0,0.8};
			canDrag = 1;
			onLBDrag = "_this call horde_fnc_reloadMenuDragStarted";
			onLBDrop = "_this call horde_fnc_reloadMenuDragDropped";
		};
		class ground : ncb_reloadMenuRscListBox
		{
			idc = 1003;
			x = 0.514583 * safezoneW + safezoneX;
			y = 0.654 * safezoneH + safezoneY;
			w = 0.233333 * safezoneW;
			h = 0.224 * safezoneH;
			colorBackground[] = {0,0,0,0.8};
			canDrag = 1;
			onLBDrag = "_this call horde_fnc_reloadMenuDragStarted";
			onLBDrop = "_this call horde_fnc_reloadMenuDragDropped";
		};
	};
};

