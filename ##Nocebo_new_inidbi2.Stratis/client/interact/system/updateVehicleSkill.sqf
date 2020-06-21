#include "\nocebo\defines\scriptDefines.hpp"

params ["_cfgEntry","_skillName","_failText","_repairText"];

(player getVariable [_skillName,[0,0]]) params ["_skillLevel","_repairTotal"];

_repairTotal = _repairTotal + 1;

if (_repairTotal >= _skillLevel ^ 2) then {
	_skillLevel = _skillLevel + 1;
	[_skillName,_skillLevel] call horde_fnc_displayActionSkillMessage;
};

player setVariable [_skillName,[_skillLevel,_repairTotal]];

private _item = sel(getVar(uiNamespace,"ncb_uv_playerAssignedItemInfo"),0);
private _text = getText (_cfgEntry >> "text");
/*if (random 100 + _skillLevel < 14) then {*/
if (false) then {
	player unlinkItem _item;
	private _msg = format ["
			<t size='3.2'color='#FFFFFF'align='center'shadow='2'>
			%1
			</t>
		",
		format [_failText,_text,_item]
	];
	_msg call horde_fnc_displayActionConfMessage;
} else {
	private _msg = format ["
			<t size='3.2'color='#FFFFFF'align='center'shadow='2'>
			%1
			</t>
		",
		format [_repairText,_text]
	];
	_msg call horde_fnc_displayActionConfMessage;
};

true