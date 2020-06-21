/*class RscControlsGroup;
// class RscActiveText;
class RscDisplayMainMap {
	access = 1;
	class controls {
		class TopRight: RscControlsGroup {
			class controls {
				class ButtonPlayer : RscActiveText {
					onbuttonclick = "((findDisplay 12) displayCtrl 1202) ctrlSetTooltip '..then you would know where you are.'";
					style = 48;
					color[] = {1, 1, 1, 0.7};
					idc = 1202;
					text = "\A3\ui_f\data\igui\cfg\islandmap\iconplayer_ca.paa";
					x = "13.5 * (((safezoneW / safezoneH) min 1.2) / 40)";
					y = "0.2 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "1.1 * (((safezoneW / safezoneH) min 1.2) / 40)";
					h = "1.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					colorText[] = {1, 1, 1, 0.7};
					colorActive[] = {1, 1, 1, 1};
					tooltip = "If only you could move map to player position...";
				};
			};
		};
	};
};*/
class RscControlsGroup;
class RscDisplayMainMap {
    access = 1;
    class controls {
        class TopRight : RscControlsGroup {
            class controls {
                delete ButtonPlayer;
            };
        };
    };
};

// WORKING

/*class RscControlsGroup;
class RscActiveText;
class RscDisplayMainMap {
	access = 1;
	class controls {
		class TopRight: RscControlsGroup {
			class controls {
				class ButtonPlayer : RscActiveText {
					onbuttonclick = "((findDisplay 12) displayCtrl 1202) ctrlSetTooltip '..then you would know where you are.'";
					style = 48;
					color[] = {1, 1, 1, 0.7};
					idc = 1202;
					text = "\A3\ui_f\data\igui\cfg\islandmap\iconplayer_ca.paa";
					x = "13.5 * (((safezoneW / safezoneH) min 1.2) / 40)";
					y = "0.2 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "1.1 * (((safezoneW / safezoneH) min 1.2) / 40)";
					h = "1.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					colorText[] = {1, 1, 1, 0.7};
					colorActive[] = {1, 1, 1, 1};
					tooltip = "If only you could move map to player position...";
				};
			};
		};
	};
};*/