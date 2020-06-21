#include "\nocebo\defines\scriptDefines.hpp"

params ["_player"];

private _text = format [
	"
		<t size='3.2'color='#FFFFFF'align='center'shadow='2'>
		%1 players killed.<br />
		%2 AI killed.
		</t>
	",
	_player getVariable ["playerKills",0],
	_player getVariable ["aiKills",0]
];

_text remoteExecCall [
	"horde_fnc_displayActionConfMessage",
	_player
];

true

