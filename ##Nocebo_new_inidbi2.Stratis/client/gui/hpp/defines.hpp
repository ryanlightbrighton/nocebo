// https://forums.bistudio.com/forums/topic/187668-code-snippet-extracting-full-classes-from-config/

// Control types
#define CT_STATIC           0
#define CT_BUTTON           1
#define CT_EDIT             2
#define CT_SLIDER           3
#define CT_COMBO            4
#define CT_LISTBOX          5
#define CT_TOOLBOX          6
#define CT_CHECKBOXES       7
#define CT_PROGRESS         8
#define CT_HTML             9
#define CT_STATIC_SKEW      10
#define CT_ACTIVETEXT       11
#define CT_TREE             12
#define CT_STRUCTURED_TEXT  13
#define CT_CONTEXT_MENU     14
#define CT_CONTROLS_GROUP   15
#define CT_SHORTCUTBUTTON   16
#define CT_HITZONES         17
#define CT_XKEYDESC         40
#define CT_XBUTTON          41
#define CT_XLISTBOX         42
#define CT_XSLIDER          43
#define CT_XCOMBO           44
#define CT_ANIMATED_TEXTURE 45
#define CT_OBJECT           80
#define CT_OBJECT_ZOOM      81
#define CT_OBJECT_CONTAINER 82
#define CT_OBJECT_CONT_ANIM 83
#define CT_LINEBREAK        98
#define CT_USER             99
#define CT_MAP              100
#define CT_MAP_MAIN         101
#define CT_LISTNBOX         102
#define CT_ITEMSLOT         103
#define CT_CHECKBOX         77

// Static styles
#define ST_POS            0x0F
#define ST_HPOS           0x03
#define ST_VPOS           0x0C
#define ST_LEFT           0x00
#define ST_RIGHT          0x01
#define ST_CENTER         0x02
#define ST_DOWN           0x04
#define ST_UP             0x08
#define ST_VCENTER        0x0C
#define ST_TYPE           0xF0
#define ST_SINGLE         0x00
#define ST_MULTI          0x10
#define ST_TITLE_BAR      0x20
#define ST_PICTURE        0x30
#define ST_FRAME          0x40
#define ST_BACKGROUND     0x50
#define ST_GROUP_BOX      0x60
#define ST_GROUP_BOX2     0x70
#define ST_HUD_BACKGROUND 0x80
#define ST_TILE_PICTURE   0x90
#define ST_WITH_RECT      0xA0
#define ST_LINE           0xB0
#define ST_UPPERCASE      0xC0
#define ST_LOWERCASE      0xD0

#define ST_SHADOW         0x100
#define ST_NO_RECT        0x200
#define ST_KEEP_ASPECT_RATIO  0x800
#define ST_TITLE          ST_TITLE_BAR + ST_CENTER

// Slider styles
#define SL_DIR            0x400
#define SL_VERT           0
#define SL_HORZ           0x400

#define SL_TEXTURES       0x10

// progress bar
#define ST_VERTICAL       0x01
#define ST_HORIZONTAL     0

// Listbox styles
#define LB_TEXTURES       0x10
#define LB_MULTI          0x20

// Tree styles
#define TR_SHOWROOT       1
#define TR_AUTOCOLLAPSE   2

// MessageBox styles
#define MB_BUTTON_OK      1
#define MB_BUTTON_CANCEL  2
#define MB_BUTTON_USER    4
#define MB_ERROR_DIALOG   8

// Xbox buttons
#define KEY_XINPUT                0x00050000
#define KEY_XBOX_A                KEY_XINPUT + 0
#define KEY_XBOX_B                KEY_XINPUT + 1
#define KEY_XBOX_X                KEY_XINPUT + 2
#define KEY_XBOX_Y                KEY_XINPUT + 3
#define KEY_XBOX_Up               KEY_XINPUT + 4
#define KEY_XBOX_Down             KEY_XINPUT + 5
#define KEY_XBOX_Left             KEY_XINPUT + 6
#define KEY_XBOX_Right            KEY_XINPUT + 7
#define KEY_XBOX_Start            KEY_XINPUT + 8
#define KEY_XBOX_Back             KEY_XINPUT + 9
#define KEY_XBOX_LeftBumper       KEY_XINPUT + 10
#define KEY_XBOX_RightBumper      KEY_XINPUT + 11
#define KEY_XBOX_LeftTrigger      KEY_XINPUT + 12
#define KEY_XBOX_RightTrigger     KEY_XINPUT + 13
#define KEY_XBOX_LeftThumb        KEY_XINPUT + 14
#define KEY_XBOX_RightThumb       KEY_XINPUT + 15
#define KEY_XBOX_LeftThumbXRight  KEY_XINPUT + 16
#define KEY_XBOX_LeftThumbYUp     KEY_XINPUT + 17
#define KEY_XBOX_RightThumbXRight KEY_XINPUT + 18
#define KEY_XBOX_RightThumbYUp    KEY_XINPUT + 19
#define KEY_XBOX_LeftThumbXLeft   KEY_XINPUT + 20
#define KEY_XBOX_LeftThumbYDown   KEY_XINPUT + 21
#define KEY_XBOX_RightThumbXLeft  KEY_XINPUT + 22
#define KEY_XBOX_RightThumbYDown  KEY_XINPUT + 23

// Fonts
#define GUI_FONT_NORMAL			PuristaMedium
#define GUI_FONT_BOLD			PuristaSemibold
#define GUI_FONT_THIN			PuristaLight
#define GUI_FONT_MONO			EtelkaMonospacePro
#define GUI_FONT_NARROW			EtelkaNarrowMediumPro
#define GUI_FONT_CODE			LucidaConsoleB
#define GUI_FONT_SYSTEM			TahomaB

// Grids
#define GUI_GRID_CENTER_WAbs		((safezoneW / safezoneH) min 1.2)
#define GUI_GRID_CENTER_HAbs		(GUI_GRID_CENTER_WAbs / 1.2)
#define GUI_GRID_CENTER_W		(GUI_GRID_CENTER_WAbs / 40)
#define GUI_GRID_CENTER_H		(GUI_GRID_CENTER_HAbs / 25)
#define GUI_GRID_CENTER_X		(safezoneX + (safezoneW - GUI_GRID_CENTER_WAbs)/2)
#define GUI_GRID_CENTER_Y		(safezoneY + (safezoneH - GUI_GRID_CENTER_HAbs)/2)

// my stuff

#define LARGE_HEADER		0.048
#define SMALL_HEADER		0.023
#define COLOUR_HEADER_TEXT	{1,1,1,0.8}

// EX:  colorBackground[] = {"(profilenamespace getvariable ['IGUI_BCG_RGB_R',0])", "(profilenamespace getvariable ['IGUI_BCG_RGB_G',1])", "(profilenamespace getvariable ['IGUI_BCG_RGB_B',1])", "(profilenamespace getvariable ['IGUI_BCG_RGB_A',0.8])"};

////////////////
//Base Classes//
////////////////

class horde_BackGround {
	idc = -1;
	autocomplete = false;
	type = 0;
	style = 2;
	moving = false;
	x = 0.1;
	y = 0.1;
	w = 0.1;
	h = 0.1;
	font = "puristaMedium";
	// sizeEx = LARGE_HEADER * safezoneH;
	sizeEx = LARGE_HEADER / (getResolution select 5);
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
class horde_rscCheckBox {
	access = 0; // Control access (0 - ReadAndWrite, 1 - ReadAndCreate, 2 - ReadOnly, 3 - ReadOnlyVerified)
	idc = CT_CHECKBOX; // Control identification (without it, the control won't be displayed)
	type = CT_CHECKBOX; // Type
	style = ST_LEFT + ST_MULTI; // Style
	default = 0; // Control selected by default (only one within a display can be used)
	blinkingPeriod = 0; // Time in which control will fade out and back in. Use 0 to disable the effect.

	x = 29 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X; // Horizontal coordinates
	y = 20 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y; // Vertical coordinates
	w = 1 * GUI_GRID_CENTER_W; // Width
	h = 1 * GUI_GRID_CENTER_H; // Height

	//Colors
	color[] = {1,1,1,0.7}; // Texture color
	colorFocused[] = {1,1,1,1}; // Focused texture color
	colorHover[] = {1,1,1,1}; // Mouse over texture color
	colorPressed[] = {1,1,1,1}; // Mouse pressed texture color
	colorDisabled[] = {1,1,1,0.2}; // Disabled texture color

	//Background colors
	colorBackground[] = {0,0,0,0}; // Fill color
	colorBackgroundFocused[] = {0,0,0,0}; // Focused fill color
	colorBackgroundHover[] = {0,0,0,0}; // Mouse hover fill color
	colorBackgroundPressed[] = {0,0,0,0}; // Mouse pressed fill color
	colorBackgroundDisabled[] = {0,0,0,0}; // Disabled fill color

	//Textures
	textureChecked = "\A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_checked_ca.paa";		//Texture of checked CheckBox.
	textureUnchecked = "\A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_unchecked_ca.paa";		//Texture of unchecked CheckBox.
	textureFocusedChecked = "\A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_checked_ca.paa";	//Texture of checked focused CheckBox (Could be used for showing different texture when focused).
	textureFocusedUnchecked = "\A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_unchecked_ca.paa";	//Texture of unchecked focused CheckBox.
	textureHoverChecked = "\A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_checked_ca.paa";
	textureHoverUnchecked = "\A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_unchecked_ca.paa";
	texturePressedChecked = "\A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_checked_ca.paa";
	texturePressedUnchecked = "\A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_unchecked_ca.paa";
	textureDisabledChecked = "\A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_checked_ca.paa";
	textureDisabledUnchecked = "\A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_unchecked_ca.paa";

	tooltip = "CT_CHECKBOX"; // Tooltip text
	tooltipColorShade[] = {0,0,0,1}; // Tooltip background color
	tooltipColorText[] = {1,1,1,1}; // Tooltip text color
	tooltipColorBox[] = {1,1,1,1}; // Tooltip frame color

	//Sounds
	soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1}; // Sound played after control is activated in format {file, volume, pitch}
	soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1}; // Sound played when mouse cursor enters the control
	soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1}; // Sound played when the control is pushed down
	soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1}; // Sound played when the control is released after pushing down
};
class horde_RscEdit {
    deletable = 0;
    fade = 0;
    access = 0;
    type = 2;
    default = 0;
    x = 0;
    y = 0;
    h = 0.04;
    w = 0.2;
    colorBackground[] = {0};
    colorText[] = {0.95};
    colorDisabled[] = {1};
    colorSelection[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.13])"};
    autocomplete = "";
    text = "";
    size = 0.2;
    style = "0x00 + 0x40";
    font = "RobotoCondensed";
    shadow = 2;
    sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
    canModify = 1;
    tooltipColorText[] = {1};
    tooltipColorBox[] = {1};
    tooltipColorShade[] = {0};
};
class horde_RscPicture {
	type = CT_STATIC;
	style = ST_PICTURE;
	default = 0;
	idc = -1;
	colorBackground[] = {0,0,0,0};
	colorText[] = {1,1,1,1};
	font = "puristaMedium";
	sizeEx = LARGE_HEADER / (getResolution select 5);
	lineSpacing = 0;
	text = "";
	fixedWidth = 0;
	shadow = 0;
	x = 0;
	y = 0;
	w = 0;
	h = 0;
};
class horde_RscText {
	type = CT_STATIC;
	text = "";
	default = 0;
	idc = -1;
	style = ST_CENTER;
	colorBackground[] = {0, 0, 0, 0.3};
	colorText[] = COLOUR_HEADER_TEXT;
	x = 1;
	y = 1;
	h = 1;
	w = 1;
	font = "puristaMedium";
	sizeEx = SMALL_HEADER / (getResolution select 5);
};
class horde_RscStructuredText {
	type = CT_STRUCTURED_TEXT;
	style = ST_CENTER;
	idc = -1;
	colorBackground[] = {0,0,0,0};
	colorText[] = COLOUR_HEADER_TEXT;
	x = 1;
	y = 1;
	h = 1;
	w = 1;
	text = "";
	size = 0.022;
	shadow = 2;
};
class horde_RscActiveText {
	deletable = 0;
	fade = 0;
	access = 0;
	type = 11;
	style = 48;
	color[] = {0.1,0,0,0.8};
	colorActive[] = {0.3, 0.4, 0, 1};
	soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1};
	soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1};
	soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1};
	soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1};
	text = "";
	default = 0;
	idc = -1;
	x = 0.1;
	y = 0.1;
	h = 0.1;
	w = 0.1;
	font = "PuristaMedium";
	shadow = 0;
	sizeEx = "0.03 / (getResolution select 5)";
	colorText[] = COLOUR_HEADER_TEXT;
	tooltipColorText[] = {1, 1, 1, 1};
	tooltipColorBox[] = {1, 1, 1, 1};
	tooltipColorShade[] = {0, 0, 0, 0.65};
};
class horde_RscButton {
	type = CT_BUTTON;
	style = ST_CENTER;
	x = 10;  // make sure off the screen
	y = 10;  // make sure off the screen
	w = 1;
	h = 1;
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
	default = 0;
	font = "puristaMedium";
	offsetX = 0;
	offsetY = 0;
	offsetPressedX = 0.002;
	offsetPressedY = 0.002;
	shadow = 0;
	sizeEx = "0.03 / (getResolution select 5)";
	soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1};
    soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1};
    soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1};
    soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1};
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
};
class horde_RscShortcutButton {
	type = 16;
	x = 0.1;
	y = 0.1;
	class HitZone {
		left = 0.004;
		top = 0.029;
		right = 0.004;
		bottom = 0.029;
	};
	class ShortcutPos {
		left = 0.0145;
		top = 0.026;
		w = 0.0392157;
		h = 0.0522876;
	};
	class TextPos {
		left = 0.05;
		top = 0.034;
		right = 0.005;
		bottom = 0.005;
	};
	shortcuts[] = {};
	textureNoShortcut = "#(argb,8,8,3)color(0,0,0,0)";
	color[] = {0.8784,0.8471,0.651,1};
	color2[] = {0.95,0.95,0.95,1};
	colorDisabled[] = {1,1,1,0.25};
	colorBackground[] = {1,1,1,1};
	colorBackground2[] = {1,1,1,0.4};
	class Attributes {
		font = "puristaMedium";
		color = "#E5E5E5";
		align = "left";
		shadow = "true";
	};
	idc = -1;
	style = 0;
	default = 0;
	shadow = 2;
	w = 0.183825;
	h = 0.104575;
	periodFocus = 1.2;
	periodOver = 0.8;
	animTextureNormal = "\ca\ui\data\ui_button_normal_ca.paa";
	animTextureDisabled = "\ca\ui\data\ui_button_disabled_ca.paa";
	animTextureOver = "\ca\ui\data\ui_button_over_ca.paa";
	animTextureFocused = "\ca\ui\data\ui_button_focus_ca.paa";
	animTexturePressed = "\ca\ui\data\ui_button_down_ca.paa";
	animTextureDefault = "\ca\ui\data\ui_button_default_ca.paa";
	period = 0.4;
	font = "puristaMedium";
	size = 0.03921;
	// sizeEx = 0.04 * safezoneH;
	sizeEx = "0.04 / (getResolution select 5)";
	text = "";
	soundEnter[] = {"\ca\ui\data\sound\onover",0.09,1};
	soundPush[] = {"\ca\ui\data\sound\new1",0,0};
	soundClick[] = {"\ca\ui\data\sound\onclick",0.07,1};
	soundEscape[] = {"\ca\ui\data\sound\onescape",0.09,1};
	action = "";
	class AttributesImage {
		font = "puristaMedium";
		color = "#E5E5E5";
		align = "left";
	};
};
class horde_ctrlObject {
	direction[] = {0,0,1};
	model = "\A3\Weapons_f\empty";
	scale = 1 / (getResolution select 5);
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
class horde_RscProgress {
	deletable = 0;
	fade = 0;
	access = 0;
	type = 8;
	style = 0;
	colorFrame[] = {0, 0, 0, 0};
	colorBar[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.8])"};
	x = 1;
	y = 1;
	w = 1;
	h = 1;
	shadow = 2;
	texture = "#(argb,8,8,3)color(1,1,1,1)";
};
class horde_rscListBox {
	access = 0; // Control access (0 - ReadAndWrite, 1 - ReadAndCreate, 2 - ReadOnly, 3 - ReadOnlyVerified)
	idc = CT_LISTBOX; // Control identification (without it, the control won't be displayed)
	type = CT_LISTBOX; // Type
	style = ST_LEFT + LB_TEXTURES; // Style
	default = 0; // Control selected by default (only one within a display can be used)
	blinkingPeriod = 0; // Time in which control will fade out and back in. Use 0 to disable the effect.

	x = 1 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X; // Horizontal coordinates
	y = 11 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y; // Vertical coordinates
	w = 10 * GUI_GRID_CENTER_W; // Width
	h = 3 * GUI_GRID_CENTER_H; // Height

	colorBackground[] = {0.2,0.2,0.2,1}; // Fill color
	colorSelectBackground[] = {1,0.5,0,1}; // Selected item fill color
	colorSelectBackground2[] = {0,0,0,1}; // Selected item fill color (oscillates between this and colorSelectBackground)

	sizeEx = GUI_GRID_CENTER_H; // Text size
	font = GUI_FONT_NORMAL; // Font from CfgFontFamilies
	shadow = 0; // Shadow (0 - none, 1 - directional, color affected by colorShadow, 2 - black outline)
	colorText[] = {1,1,1,1}; // Text and frame color
	colorDisabled[] = {1,1,1,0.5}; // Disabled text color
	colorSelect[] = {1,1,1,1}; // Text selection color
	colorSelect2[] = {1,1,1,1}; // Text selection color (oscillates between this and colorSelect)
	colorShadow[] = {0,0,0,0.5}; // Text shadow color (used only when shadow is 1)

	// pictureColor[] = {1,0.5,0,1}; // Picture color
	// pictureColorSelect[] = {1,1,1,1}; // Selected picture color
	// pictureColorDisabled[] = {1,1,1,0.5}; // Disabled picture color

	colorPicture[] = {1,1,1,1};
	colorPictureSelected[] = {1,1,1,1};
	colorPictureDisabled[] = {1,1,1,1};

	tooltip = "CT_LISTBOX"; // Tooltip text
	tooltipColorShade[] = {0,0,0,1}; // Tooltip background color
	tooltipColorText[] = {1,1,1,1}; // Tooltip text color
	tooltipColorBox[] = {1,1,1,1}; // Tooltip frame color

	period = 1; // Oscillation time between colorSelect/colorSelectBackground2 and colorSelect2/colorSelectBackground when selected

	rowHeight = 1.5 * GUI_GRID_CENTER_H; // Row height
	itemSpacing = 0; // Height of empty space between items
	maxHistoryDelay = 1; // Time since last keyboard type search to reset it
	canDrag = 1; // 1 (true) to allow item dragging

	soundSelect[] = {"\A3\ui_f\data\sound\RscListbox\soundSelect",0.09,1}; // Sound played when an item is selected

	// Scrollbar configuration (applied only when LB_TEXTURES style is used)
	class ListScrollBar {
		width = 0; // Unknown?
		height = 0; // Unknown?
		scrollSpeed = 0.01; // Unknown?

		arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa"; // Arrow
		arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa"; // Arrow when clicked on
		border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa"; // Slider background (stretched vertically)
		thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa"; // Dragging element (stretched vertically)

		color[] = {1,1,1,1}; // Scrollbar color
	};
};
class rscMapControl {
	access = 0;
	alphaFadeEndScale = 1;
	alphaFadeStartScale = 0;
	colorBackground[] = {0.969,0.957,0.949,1};
	colorCountlines[] = {0.572,0.354,0.188,0.25};
	colorCountlinesWater[] = {0.491,0.577,0.702,0.3};
	colorForest[] = {0.624,0.78,0.388,0.5};
	colorForestBorder[] = {0,0,0,0};
	colorGrid[] = {0.1,0.1,0.1,0.6};
	colorGridMap[] = {0.1,0.1,0.1,0.6};
	colorInactive[] = {1,1,1,0.5};
	colorLevels[] = {0.286,0.177,0.094,0.5};
	colorMainCountlines[] = {0.572,0.354,0.188,0.5};
	colorMainCountlinesWater[] = {0.491,0.577,0.702,0.6};
	colorMainRoads[] = {0.9,0.5,0.3,1};
	colorMainRoadsFill[] = {1,0.6,0.4,1};
	colorNames[] = {0.1,0.1,0.1,0.9};
	colorOutside[] = {0,0,0,1};
	colorPowerLines[] = {0.1,0.1,0.1,1};
	colorRailWay[] = {0.8,0.2,0,1};
	colorRoads[] = {0.7,0.7,0.7,1};
	colorRoadsFill[] = {1,1,1,1};
	colorRocks[] = {0,0,0,0.3};
	colorRocksBorder[] = {0,0,0,0};
	colorSea[] = {0.467,0.631,0.851,0.5};
	colorText[] = {0,0,0,1};
	colorTracks[] = {0.84,0.76,0.65,0.15};
	colorTracksFill[] = {0.84,0.76,0.65,1};
	font = "TahomaB";
	fontGrid = "TahomaB";
	fontInfo = "PuristaMedium";
	fontLabel = "PuristaMedium";
	fontLevel = "TahomaB";
	fontNames = "PuristaMedium";
	fontUnits = "TahomaB";
	h = "SafeZoneH - 1.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	maxSatelliteAlpha = 0.85;
	moveOnEdges = 0;
	ptsPerSquareCLn = 10;
	ptsPerSquareCost = 10;
	ptsPerSquareExp = 10;
	ptsPerSquareFor = 9;
	ptsPerSquareForEdge = 9;
	ptsPerSquareObj = 9;
	ptsPerSquareRoad = 6;
	ptsPerSquareSea = 5;
	ptsPerSquareTxt = 3;
	scaleDefault = 0.16;
	scaleMax = 1;
	scaleMin = 0.001;
	shadow = 0;
	showCountourInterval = 0;
	sizeEx = 0.04;
	sizeExGrid = 0.02;
	sizeExInfo = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	sizeExLabel = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	sizeExLevel = 0.02;
	sizeExNames = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8) * 2";
	sizeExUnits = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	stickX[] = {0.2,["Gamma",1,1.5]};
	stickY[] = {0.2,["Gamma",1,1.5]};
	style = 48;
	text = "#(argb,8,8,3)color(1,1,1,1)";
	type = 101;
	w = "SafeZoneWAbs";
	x = "SafeZoneXAbs";
	y = "SafeZoneY + 1.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	class ActiveMarker {
		color[] = {0.3,0.1,0.9,1};
		size = 50;
	};
	class Bunker {
		coefMax = 4;
		coefMin = 0.25;
		color[] = {0,0,0,1};
		icon = "\A3\ui_f\data\map\mapcontrol\bunker_ca.paa";
		importance = "1.5 * 14 * 0.05";
		size = 14;
	};
	class Bush {
		coefMax = 4;
		coefMin = 0.25;
		color[] = {0.45,0.64,0.33,0.4};
		icon = "\A3\ui_f\data\map\mapcontrol\bush_ca.paa";
		importance = "0.2 * 14 * 0.05 * 0.05";
		size = "14/2";
	};
	class BusStop {
		coefMax = 1;
		coefMin = 0.85;
		color[] = {1,1,1,1};
		icon = "\A3\ui_f\data\map\mapcontrol\busstop_CA.paa";
		importance = 1;
		size = 24;
	};
	class Chapel {
		coefMax = 4;
		coefMin = 0.85;
		color[] = {0,0,0,1};
		icon = "\A3\ui_f\data\map\mapcontrol\Chapel_CA.paa";
		importance = 1;
		size = 24;
	};
	class Church {
		coefMax = 1;
		coefMin = 0.85;
		color[] = {1,1,1,1};
		icon = "\A3\ui_f\data\map\mapcontrol\church_CA.paa";
		importance = 1;
		size = 24;
	};
	class Command {
		coefMax = 1;
		coefMin = 1;
		color[] = {1,1,1,1};
		icon = "\A3\ui_f\data\map\mapcontrol\waypoint_ca.paa";
		importance =1;
		size = 18;
	};
	class Cross {
		coefMax = 1;
		coefMin = 0.85;
		color[] = {0,0,0,1};
		icon = "\A3\ui_f\data\map\mapcontrol\Cross_CA.paa";
		importance = 1;
		size = 24;
	};
	class CustomMark {
		coefMax = 1;
		coefMin = 1;
		color[] = {0,0,0,1};
		icon = "\A3\ui_f\data\map\mapcontrol\custommark_ca.paa";
		importance = 1;
		size = 24;
	};
	class Fortress {
		coefMax = 4;
		coefMin = 0.25;
		color[] = {0,0,0,1};
		icon = "\A3\ui_f\data\map\mapcontrol\bunker_ca.paa";
		importance = "2 * 16 * 0.05";
		size = 16;
	};
	class Fountain {
		coefMax = 4;
		coefMin = 0.25;
		color[] = {0,0,0,1};
		icon = "\A3\ui_f\data\map\mapcontrol\fountain_ca.paa";
		importance = "1 * 12 * 0.05";
		size = 11;
	};
	class Fuelstation {
		coefMax = 1;
		coefMin = 0.85;
		color[] = {1,1,1,1};
		icon = "\A3\ui_f\data\map\mapcontrol\fuelstation_CA.paa";
		importance = 1;
		size = 24;
	};
	class Hospital {
		coefMax = 1;
		coefMin = 0.85;
		color[] = {1,1,1,1};
		icon = "\A3\ui_f\data\map\mapcontrol\hospital_CA.paa";
		importance = 1;
		size = 24;
	};
	class Legend {
		color[] = {0,0,0,1};
		colorBackground[] = {1,1,1,0.5};
		font = "PuristaMedium";
		h = "3.5 * 	((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		w = "10 * (((safezoneW / safezoneH) min 1.2) / 40)";
		x = "SafeZoneX + (((safezoneW / safezoneH) min 1.2) / 40)";
		y = "SafeZoneY + safezoneH - 4.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	};
	class Lighthouse {
		coefMax = 1;
		coefMin = 0.85;
		color[] = {1,1,1,1};
		icon = "\A3\ui_f\data\map\mapcontrol\lighthouse_CA.paa";
		importance = 1;
		size = 24;
	};
	class LineMarker {
		lineDistanceMin = 3e-005;
		lineLengthMin = 5;
		lineWidthThick = 0.014;
		lineWidthThin = 0.008;
		textureComboBoxColor = "#(argb,8,8,3)color(1,1,1,1)";
	};
	class power {
		coefMax = 1;
		coefMin = 0.85;
		color[] = {1,1,1,1};
		icon = "\A3\ui_f\data\map\mapcontrol\power_CA.paa";
		importance = 1;
		size = 24;
	};
	class powersolar {
		coefMax = 1;
		coefMin = 0.85;
		color[] = {1,1,1,1};
		icon = "\A3\ui_f\data\map\mapcontrol\powersolar_CA.paa";
		importance = 1;
		size = 24;
	};
	class powerwind {
		coefMax = 1;
		coefMin = 0.85;
		color[] = {1,1,1,1};
		icon = "\A3\ui_f\data\map\mapcontrol\powerwind_CA.paa";
		importance = 1;
		size = 24;
	};
	class powerwave {
		coefMax = 1;
		coefMin = 0.85;
		color[] = {1,1,1,1};
		icon = "\A3\ui_f\data\map\mapcontrol\powerwave_CA.paa";
		importance = 1;
		size = 24;
	};
	class Quay {
		coefMax = 1;
		coefMin = 0.85;
		color[] = {1,1,1,1};
		icon = "\A3\ui_f\data\map\mapcontrol\quay_CA.paa";
		importance = 1;
		size = 24;
	};
	class Rock {
		coefMax = 4;
		coefMin = 0.25;
		color[] = {0.1,0.1,0.1,0.8};
		icon = "\A3\ui_f\data\map\mapcontrol\rock_ca.paa";
		importance = "0.5 * 12 * 0.05";
		size = 12;
	};
	class Ruin {
		coefMax = 4;
		coefMin = 1;
		color[] = {0,0,0,1};
		icon = "\A3\ui_f\data\map\mapcontrol\ruin_ca.paa";
		importance = "1.2 * 16 * 0.05";
		size = 16;
	};
	class shipwreck {
		coefMax = 1;
		coefMin = 0.85;
		color[] = {1,1,1,1};
		icon = "\A3\ui_f\data\map\mapcontrol\shipwreck_CA.paa";
		importance = 1;
		size = 24;
	};
	class SmallTree {
		coefMax = 4;
		coefMin = 0.25;
		color[] = {0.45,0.64,0.33,0.4};
		icon = "\A3\ui_f\data\map\mapcontrol\bush_ca.paa";
		importance = "0.6 * 12 * 0.05";
		size = 12;
	};
	class Stack {
		coefMax = 4;
		coefMin = 0.9;
		color[] = {0,0,0,1};
		icon = "\A3\ui_f\data\map\mapcontrol\stack_ca.paa";
		importance = "2 * 16 * 0.05";
		size = 20;
	};
	class Task {
		coefMax = 1;
		coefMin = 1;
		color[] = {"(profilenamespace getvariable ['IGUI_TEXT_RGB_R',0])","(profilenamespace getvariable ['IGUI_TEXT_RGB_G',1])","(profilenamespace getvariable ['IGUI_TEXT_RGB_B',1])","(profilenamespace getvariable ['IGUI_TEXT_RGB_A',0.8])"};
		colorCanceled[] = {0.7,0.7,0.7,1};
		colorCreated[] = {1,1,1,1};
		colorDone[] = {0.7,1,0.3,1};
		colorFailed[] = {1,0.3,0.2,1};
		icon = "\A3\ui_f\data\map\mapcontrol\taskIcon_CA.paa";
		iconCanceled = "\A3\ui_f\data\map\mapcontrol\taskIconCanceled_CA.paa";
		iconCreated = "\A3\ui_f\data\map\mapcontrol\taskIconCreated_CA.paa";
		iconDone = "\A3\ui_f\data\map\mapcontrol\taskIconDone_CA.paa";
		iconFailed = "\A3\ui_f\data\map\mapcontrol\taskIconFailed_CA.paa";
		importance = 1;
		size = 27;
	};
	class Tourism {
		coefMax = 4;
		coefMin = 0.7;
		color[] = {0,0,0,1};
		icon = "\A3\ui_f\data\map\mapcontrol\tourism_ca.paa";
		importance = "1 * 16 * 0.05";
		size = 16;
	};
	class Transmitter {
		coefMax = 1;
		coefMin = 0.85;
		color[] = {1,1,1,1};
		icon = "\A3\ui_f\data\map\mapcontrol\transmitter_CA.paa";
		importance = 1;
		size = 24;
	};
	class Tree {
		coefMax = 4;
		coefMin = 0.25;
		color[] = {0.45,0.64,0.33,0.4};
		icon = "\A3\ui_f\data\map\mapcontrol\bush_ca.paa";
		importance = "0.9 * 16 * 0.05";
		size = 12;
	};
	class ViewTower {
		coefMax = 4;
		coefMin = 0.5;
		color[] = {0,0,0,1};
		icon = "\A3\ui_f\data\map\mapcontrol\viewtower_ca.paa";
		importance = "2.5 * 16 * 0.05";
		size = 16;
	};
	class Watertower {
		coefMax = 1;
		coefMin = 0.85;
		color[] = {1,1,1,1};
		icon = "\A3\ui_f\data\map\mapcontrol\watertower_CA.paa";
		importance = 1;
		size = 24;
	};
	class Waypoint {
		coefMax = 1;
		coefMin = 1;
		color[] = {0,0,0,1};
		icon = "\A3\ui_f\data\map\mapcontrol\waypoint_ca.paa";
		importance = 1;
		size = 24;
	};
	class WaypointCompleted {
		coefMax = 1;
		coefMin = 1;
		color[] = {0,0,0,1};
		icon = "\A3\ui_f\data\map\mapcontrol\waypointCompleted_ca.paa";
		importance = 1;
		size = 24;
	};
};