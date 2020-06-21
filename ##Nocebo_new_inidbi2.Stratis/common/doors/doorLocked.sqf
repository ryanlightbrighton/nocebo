#include "\nocebo\defines\scriptDefines.hpp"

params ["_houseKeyName","_doorType","_worldPos"];

private _text = format [
	"
		<t size='3.2'color='#FF0000'align='center'shadow='2'>
		%1 %2 key required.
		</t>
	",
	_houseKeyName,
	_doorType
];
_text call horde_fnc_displayActionRejMessage;
private _nearPlayers = _worldPos nearEntities ["ncb_player_base", 15];
if not empty(_nearPlayers) then {
	[_worldPos,"horde_sound_accessDenied",3] remoteExecCall [
		"horde_fnc_playSingleSound",
		_nearPlayers
	];
};

true