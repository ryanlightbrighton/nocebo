
#define CT_STATIC 0
#define CT_BUTTON 1
#define CT_EDIT 2
#define CT_SLIDER 3
#define CT_COMBO 4
#define CT_LISTBOX 5
#define CT_TOOLBOX 6
#define CT_CHECKBOXES 7
#define CT_PROGRESS 8
#define CT_HTML 9
#define CT_STATIC_SKEW 10
#define CT_ACTIVETEXT 11
#define CT_TREE 12
#define CT_STRUCTURED_TEXT 13
#define CT_CONTEXT_MENU 14
#define CT_CONTROLS_GROUP 15
#define CT_SHORTCUTBUTTON 16
#define CT_XKEYDESC 40
#define CT_XBUTTON 41
#define CT_XLISTBOX 42
#define CT_XSLIDER 43
#define CT_XCOMBO 44
#define CT_ANIMATED_TEXTURE 45
#define CT_OBJECT 80
#define CT_OBJECT_ZOOM 81
#define CT_OBJECT_CONTAINER 82
#define CT_OBJECT_CONT_ANIM 83
#define CT_LINEBREAK 98
#define CT_USER 99
#define CT_MAP 100
#define CT_MAP_MAIN 101
#define CT_LISTNBOX 102

// Static styles
#define ST_POS 0x0F
#define ST_HPOS 0x03
#define ST_VPOS 0x0C
#define ST_LEFT 0x00
#define ST_RIGHT 0x01
#define ST_CENTER 0x02
#define ST_DOWN 0x04
#define ST_UP 0x08
#define ST_VCENTER 0x0C
#define ST_TYPE 0xF0
#define ST_SINGLE 0x00
#define ST_MULTI 0x10
#define ST_TITLE_BAR 0x20
#define ST_PICTURE 0x30
#define ST_FRAME 0x40
#define ST_BACKGROUND 0x50
#define ST_GROUP_BOX 0x60
#define ST_GROUP_BOX2 0x70
#define ST_HUD_BACKGROUND 0x80
#define ST_TILE_PICTURE 0x90
#define ST_WITH_RECT 0xA0
#define ST_LINE 0xB0
#define ST_SHADOW 0x100
#define ST_NO_RECT 0x200
#define ST_KEEP_ASPECT_RATIO 0x800
#define ST_TITLE ST_TITLE_BAR + ST_CENTER

// Slider styles
#define SL_DIR 0x400
#define SL_VERT 0
#define SL_HORZ 0x400
#define SL_TEXTURES 0x10

// progress bar
#define ST_VERTICAL 0x01
#define ST_HORIZONTAL 0

// Listbox styles
#define LB_TEXTURES 0x10
#define LB_MULTI 0x20

// Tree styles
#define TR_SHOWROOT 1
#define TR_AUTOCOLLAPSE 2

// MessageBox styles
#define MB_BUTTON_OK 1
#define MB_BUTTON_CANCEL 2
#define MB_BUTTON_USER 4

// text
#define LARGE_HEADER		0.048 / (getResolution select 5)
#define SMALL_HEADER		0.023 / (getResolution select 5)
#define COLOUR_HEADER_TEXT	{1,1,1,0.8}

// EX:  colorBackground[] = {"(profilenamespace getvariable ['IGUI_BCG_RGB_R',0])", "(profilenamespace getvariable ['IGUI_BCG_RGB_G',1])", "(profilenamespace getvariable ['IGUI_BCG_RGB_B',1])", "(profilenamespace getvariable ['IGUI_BCG_RGB_A',0.8])"};

////////////////
//Base Classes//
////////////////

class Horde_BackGround {
	idc = -1;
	autocomplete = false;
	type = CT_STATIC;
	style = 2;
	moving = false;
	x = 0.1;
	y = 0.1;
	w = 0.1;
	h = 0.1;
	font = "puristaMedium";
	sizeEx = LARGE_HEADER;
	action = "";
	text = "";
	default = false;
	colorText[] = {
		254/255,
		254/255,
		254/255,
		1
	};
	colorBackground[] = {
		0,
		0,
		0,
		0.5
	};
	colorSelection[] = {
		0,
		0,
		0,
		0.5
	};
	colorDisabled[] = {
		0,
		0,
		0,
		0.5
	};
};

class horde_RscPicture {
	type = CT_STATIC;
	style = ST_PICTURE;
	idc = -1;
	colorBackground[] = {0,0,0,0};
	colorText[] = {1,1,1,1};
	font = "puristaMedium";
	sizeEx = LARGE_HEADER;
	lineSpacing = 0;
	text = "";
	fixedWidth = 0;
	shadow = 0;
	x = 0.1;
	y = 0.1;
	w = 0.1;
	h = 0.1;
};

class horde_RscRender: horde_RscPicture {
	moving = 1;
	text = "#(argb,256,256,1)r2t(hordeRender1,1.0)";
	x = 0.5;
	y = 0.5;
	h = 0.25;
	w = 0.25 * 3 / 4;
};

class horde_RscRender2: horde_RscRender {
	text = "#(argb,256,256,1)r2t(rendertarget7,1.0)";
};

class horde_RscText {
	x = 0.1;
	y = 0.1;
	h = 0.1;
	w = 0.1;
	colorBackground[] = {0,0,0,0};
	colorShadow[] = {0,0,0,0.5};
	colorText[] = COLOUR_HEADER_TEXT;
	deletable = 0;
	fade = 0;
	fixedWidth = 0;
	font = "puristaMedium";
	idc = -1;
	linespacing = 1;
	shadow = 1;
	sizeEx = SMALL_HEADER;
	style = ST_CENTER;
	text = "";
	type = CT_STATIC;
 };

 class horde_RscStructuredText {
	type = CT_STRUCTURED_TEXT;
	style = ST_CENTER;
	idc = -1;
	colorBackground[] = {0,0,0,0};
	colorText[] = COLOUR_HEADER_TEXT;
	x = 0.1;
	y = 0.1;
	h = 0.1;
	w = 0.1;
	text = "";
	size = 0.022;
	shadow = 2;
};

class horde_RscButton {
	type = CT_BUTTON;
	style = ST_CENTER;
	x = 0.1;
	y = 0.1;
	w = 0.1;
	h = 0.1;
	text = "";
	borderSize = 0;
	colorBackground[] = {0.1,0,0,0.8};
	colorBackgroundActive[] = {0.1,0,0,0.8}; // this is the colour when it's highlighted
	colorBackgroundDisabled[] = {0.6,0.6,0.6,1};
	colorBorder[] = {0,0,0,1};
	colorFocused[] = {0,0,0,1};
	colorDisabled[] = {0.3,0.3,0.3,1};
	colorShadow[] = {0,0,0,1};
	colorText[] = COLOUR_HEADER_TEXT;
	font = "puristaMedium";
	offsetX = 0;
	offsetY = 0;
	offsetPressedX = 0.002;
	offsetPressedY = 0.002;
	shadow = 0;
	sizeEx = 0.03 / (getResolution select 5);
	soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1};
    soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1};
    soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1};
    soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1};
	// soundEnter[] = {"",0.1,1};
	// soundPush[] = {"",0.1,1};
	// soundClick[] = {"",0.1,1};
	// soundEscape[] = {"",0.1,1};
};

class horde_RscInvisibleButton : horde_RscButton {
	colorBackground[] = {0,0,0,0.2};
	colorBackgroundActive[] = {0,0,0,0.2};
	colorBackgroundDisabled[] = {0,0,0,0.2};
	colorBorder[] = {0,0,0,0};
	colorFocused[] = {0,0,0,0};
	colorDisabled[] = {0,0,0,0};
	colorShadow[] = {0,0,0,0};
	offsetPressedX = 0;
	offsetPressedY = 0;
	/// action = "closeDialog 1664;closeDialog 0";
};

class RscListBox;
class horde_RscListBox: RscListBox {
	x = 0.1;
	y = 0.1;
	w = 0.1;
	h = 0.1;
};

class Horde_RscCombo {
	access = 1;
	type = 4;
	colorSelect[] = {
		0,
		0,
		0,
		1
	};
	colorText[] = {
		0.95,
		0.95,
		0.95,
		1
	};
	colorBackground[] = {
		0,
		0,
		0,
		1
	};
	colorScrollbar[] = {
		1,
		0,
		0,
		1
	};
	soundSelect[] = {
		"\A3\ui_f\data\sound\RscCombo\soundSelect",
		0.1,
		1
	};
	soundExpand[] = {
		"\A3\ui_f\data\sound\RscCombo\soundExpand",
		0.1,
		1
	};
	soundCollapse[] = {
		"\A3\ui_f\data\sound\RscCombo\soundCollapse",
		0.1,
		1
	};
	maxHistoryDelay = 1;
	class ComboScrollBar {
		color[] = {
			1,
			1,
			1,
			0.6
		};
		colorActive[] = {
			1,
			1,
			1,
			1
		};
		colorDisabled[] = {
			1,
			1,
			1,
			0.3
		};
		shadow = 0;
		thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
		arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
		arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
		border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
	};
	style = 16;
	x = 0.1;
	y = 0.1;
	w = 0.1;
	h = 0.1;
	shadow = 0;
	colorSelectBackground[] = {
		1,
		1,
		1,
		0.7
	};
	arrowEmpty = "\A3\ui_f\data\GUI\RscCommon\rsccombo\arrow_combo_ca.paa";
	arrowFull = "\A3\ui_f\data\GUI\RscCommon\rsccombo\arrow_combo_active_ca.paa";
	wholeHeight = 0.45;
	color[] = {
		1,
		1,
		1,
		1
	};
	colorActive[] = {
		1,
		0,
		0,
		1
	};
	colorDisabled[] = {
		1,
		1,
		1,
		0.25
	};
	font = "puristaMedium";
	sizeEx = SMALL_HEADER;
	// sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
};

class horde_ctrlObject {
	direction[] = {0,0,1};
	model = "\A3\Weapons_f\empty";
	scale = 1;
	shadow = 0;
	type = 82;
	up[] = {0,1,0};
	x = 0.5 * safezoneW + safezoneX;		// width
	z = 0.5;								// height
	y = 0.5 * safezoneH + safezoneY;		// depth
	xBack = 0;
	zBack = 0;
	yBack = 0;
	inBack = 0;
	enableZoom = 0;
	zoomDuration = 0;
};

class Horde_RscProgress {
	deletable = 0;
	fade = 0;
	access = 0;
	type = 8;
	style = 0;
	colorFrame[] = {0, 0, 0, 0};
	colorBar[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.8])"};
	x = 0;
	y = 0;
	w = 0;
	h = 0;
	shadow = 2;
	texture = "#(argb,8,8,3)color(1,1,1,1)";
};