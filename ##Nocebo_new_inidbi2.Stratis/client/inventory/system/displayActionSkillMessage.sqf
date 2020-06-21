#include "\nocebo\defines\scriptDefines.hpp"

private _text = format ["
		<t size='3.5'color='#FFFF55'align='center'shadow='2'>
		%1 skill levelled up to level %2.
		</t>
	",
	sel(_this,0),
	sel(_this,1)
];

disableSerialization;
if (not isNull (findDisplay 46 displayCtrl 1931)) then {
	ctrlDelete (findDisplay 46 displayCtrl 1931)
};
private _ctrl = (findDisplay 46) ctrlCreate ["horde_RscStructuredText",1931];
_ctrl ctrlSetStructuredText (parseText _text);
_ctrl ctrlSetPosition [
	0.208333 * safezoneW + safezoneX,
	-1 * safezoneH + safezoneY,
	0.583333 * safezoneW,
	0.14 * safezoneH
];
_ctrl ctrlCommit 0;
_ctrl ctrlSetPosition [
	0.208333 * safezoneW + safezoneX,
	0.1 * safezoneH + safezoneY,
	0.583333 * safezoneW,
	0.14 * safezoneH
],
_ctrl ctrlCommit 0.5;

[
	[_ctrl],{
        call horde_fnc_getEachFrameArgs params ["_ctrl"];
        disableSerialization;
        _ctrl ctrlSetPosition [
			0.208333 * safezoneW + safezoneX,
			-1 * safezoneH + safezoneY,
			0.583333 * safezoneW,
			0.14 * safezoneH
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
    5
] call horde_fnc_addEachFrame;

true


