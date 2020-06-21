#include "\nocebo\defines\scriptDefines.hpp"

diag_log "--------------------------------------------------------";
diag("started");
diag(_this);
diag_log "--------------------------------------------------------";

params ["_serverFunction","_text","_serverShutDown"];

[
	_serverShutDown,
	player,
	ncb_gv_playerFood,
	ncb_gv_playerWater,
	ncb_gv_playerBleedingRate,
	ncb_gv_playerLodgedBullets,
	player getVariable ["skillCook",[0,0]],
	player getVariable ["skillEngineer",[0,0]],
	player getVariable ["skillFuelling",[0,0]],
	player getVariable ["skillLogistics",[0,0]],
	player getVariable ["skillSurgeon",[0,0]],
	player getVariable ["skillTyreFitter",[0,0]],
	player getVariable ["skillMagazineFitter",[0,0]],
	player getVariable ["skillWeaponFitter",[0,0]],
	ncb_gv_distanceData
] remoteExecCall [
	_serverFunction,
	2
];
if (_text != "") then {
	_text = format ["
		<t size='3.2'color='#FFFFFF'align='center'shadow='2'>
		%1
		</t>
	",_text];
	_text call horde_fnc_displayActionConfMessage;
};
true