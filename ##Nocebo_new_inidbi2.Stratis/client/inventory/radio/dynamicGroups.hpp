// https://forums.bistudio.com/forums/topic/207554-unable-to-add-event-handlers-to-rscpicture/?do=findComment&comment=3214514

// rscactivetext has action button and you can set pictures to it!

class ncb_dlg_dynamicGroups {
	idd = 76573;
	movingEnable = false;
	onLoad = "'dynamicBlur' ppEffectEnable true;'dynamicBlur' ppEffectAdjust [3];'dynamicBlur' ppEffectCommit 0.25;\
		10000 cutText ['','PLAIN DOWN'];\
		uiNamespace setVariable ['ncb_dynamicGroupsMenu',(_this select 0)];\
		_ret = 0 call horde_fnc_setupDynamicGroupsMenu;\
	";
	onUnload = "'dynamicBlur' ppEffectAdjust [0];'dynamicBlur' ppEffectCommit 0.25;";
	class ControlsBackground {};
	class Objects {};
	class Controls {
		class background : horde_BackGround {
			idc = 1;
			x = 0.171875 * safezoneW + safezoneX;
			y = 0.178 * safezoneH + safezoneY;
			w = 0.663542 * safezoneW;
			h = 0.658 * safezoneH;
		};
		class toggleExtOptionsButton : horde_RscButton {
			idc = 2000;
			text = "Toggle Groups,Players and Invites";
			x = 0.186458 * safezoneW + safezoneX;
			y = 0.192 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
			colorBackground[] = {0,0,0,1};
		};
		class extListBox : horde_RscListBox {
			idc = 3;
			text = "Group/player/invite list";
			x = 0.186458 * safezoneW + safezoneX;
			y = 0.262 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.406 * safezoneH;
		};
		class actionsText_1 : horde_RscText {
			idc = 4;
			text = "Actions";
			x = 0.186458 * safezoneW + safezoneX;
			y = 0.682 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
			colorBackground[] = {0,0,0,1};
		};
		class extActionButton : horde_RscButton {
			idc = 5;
			text = "<group/player action>";
			x = 0.186458 * safezoneW + safezoneX;
			y = 0.752 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
			colorBackground[] = {0,0,0,1};
		};
		class groupNameInput : horde_RscEdit {
			idc = 7;
			text = "";
			x = 0.390625 * safezoneW + safezoneX;
			y = 0.192 * safezoneH + safezoneY;
			w = 0.430208 * safezoneW;
			h = 0.056 * safezoneH;
			colorBackground[] = {0,0,0,1};
		};
		//-------------------------------------------------------------------
		class squadListBox : horde_RscListBox {
			idc = 8;
			text = "squad list";
			x = 0.609375 * safezoneW + safezoneX;
			y = 0.332 * safezoneH + safezoneY;
			w = 0.211458 * safezoneW;
			h = 0.266 * safezoneH;
		};
		class actionsText_2 : horde_RscText {
			idc = 9;
			text = "Squad Actions";
			x = 0.609375 * safezoneW + safezoneX;
			y = 0.612 * safezoneH + safezoneY;
			w = 0.211458 * safezoneW;
			h = 0.056 * safezoneH;
			colorBackground[] = {0,0,0,1};
		};
		class squadActionListBox : horde_RscListBox {
			idc = 10;
			text = "squad actions list";
			x = 0.609375 * safezoneW + safezoneX;
			y = 0.682 * safezoneH + safezoneY;
			w = 0.211458 * safezoneW;
			h = 0.126 * safezoneH;
		};
		class actionsText_3 : horde_RscText {
			idc = 11;
			text = "Squad Icon";
			x = 0.390625 * safezoneW + safezoneX;
			y = 0.262 * safezoneH + safezoneY;
			w = 0.211458 * safezoneW;
			h = 0.056 * safezoneH;
			colorBackground[] = {0,0,0,1};
		};
		// for these 2, leader gets the listbox - everone else the picture
		class squadIconsPicture : horde_RscPicture {
			idc = 12;
			// text = "squad icon picture (if squad member)";
			text = "";
			x = 0.390625 * safezoneW + safezoneX;
			y = 0.332 * safezoneH + safezoneY;
			w = 0.211458 * safezoneW;
			h = 0.336 * safezoneH;
		};
		class squadIconsListBox : horde_RscListBox {
			idc = 13;
			text = "squad icons list (if leader)";
			x = 0.390625 * safezoneW + safezoneX;
			y = 0.332 * safezoneH + safezoneY;
			w = 0.211458 * safezoneW;
			h = 0.336 * safezoneH;
		};
		// -------------------------------------------------------------------
		class groupMembersText : horde_RscText {
			idc = 14;
			text = "Group members";
			x = 0.609375 * safezoneW + safezoneX;
			y = 0.262 * safezoneH + safezoneY;
			w = 0.211458 * safezoneW;
			h = 0.056 * safezoneH;
			colorBackground[] = {0,0,0,1};
		};
		class privateStatusText : horde_RscText {
			idc = 15;
			text = "Private";
			x = 0.390625 * safezoneW + safezoneX;
			y = 0.682 * safezoneH + safezoneY;
			w = 0.123958 * safezoneW;
			h = 0.126 * safezoneH;
			colorBackground[] = {0,0,0,1};
		};
		class privateStatusCheckBox : horde_rscCheckBox {
			idc = 16;
			text = "";
			x = 0.521875 * safezoneW + safezoneX;
			y = 0.682 * safezoneH + safezoneY;
			w = 0.0802083 * safezoneW;
			h = 0.126 * safezoneH;
			tooltip = "Enable to make group private";
		};
	};
};