#include "\nocebo\defines\scriptDefines.hpp"

disableSerialization;
if (not isNull (findDisplay 46 displayCtrl 1929)) then {
	ctrlDelete (findDisplay 46 displayCtrl 1929)
};
private _ctrl = (findDisplay 46) ctrlCreate ["horde_RscStructuredText",1929];
_ctrl ctrlSetStructuredText (parseText _this);
_ctrl ctrlSetPosition [
	0.208333 * safezoneW + safezoneX,
	2 * safezoneH + safezoneY,
	0.583333 * safezoneW,
	0.22 * safezoneH // 0.112 * safezoneH
];
_ctrl ctrlCommit 0;
_ctrl ctrlSetPosition [
	0.208333 * safezoneW + safezoneX,
	0.738 * safezoneH + safezoneY,
	0.583333 * safezoneW,
	0.22 * safezoneH // 0.112 * safezoneH
],
_ctrl ctrlCommit 0.5;

[
	[_ctrl],{
        call horde_fnc_getEachFrameArgs params ["_ctrl"];
        disableSerialization;
        _ctrl ctrlSetPosition [
			0.208333 * safezoneW + safezoneX,
			2 * safezoneH + safezoneY,
			0.583333 * safezoneW,
			0.22 * safezoneH
		];
		_ctrl ctrlCommit 1;
		[
			[_ctrl],
			{
				call horde_fnc_getEachFrameArgs params ["_ctrl"];
				ctrlDelete _ctrl;
				call horde_fnc_removeEachFrame
			},
			1
		] call horde_fnc_updateEachFrame
    },
    3
] call horde_fnc_addEachFrame;

true