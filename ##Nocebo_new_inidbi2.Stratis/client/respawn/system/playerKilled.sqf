#include "\nocebo\defines\scriptDefines.hpp"

params ["_body","_killer"];

// set the delete timeout on server

[_body] remoteExecCall ["horde_fnc_deletePlayerTimeout",2];

openMap [false,false];
closeDialog 0;
clearRadio;
enableRadio false;
"dynamicBlur" ppEffectEnable false;
if (same(group player,group _killer)
	and {diff(_body,_killer)}
) then {
	private _text = format [
		"
			<t size='3.2'color='#FF0000'align='center'shadow='2'>
			%1 was killed by group member: %2
			</t>
		",
		name player,
		name _killer
	];
	_text remoteExecCall [
		"horde_fnc_displayActionRejMessage",
		units group _killer
	];
};
private _blur = nil;
private _var = getVar(missionNamespace,"playerReviveNotAllowed");
if (isNil {_var}) then {
	ncb_layer_blackOutScreen cutText ["", "BLACK OUT",playerRespawnTime];
	_blur = ppEffectCreate ["dynamicBlur", 665];
	_blur ppEffectEnable true;
	_blur ppEffectAdjust [0];
	_blur ppEffectCommit 0;
	_blur ppEffectAdjust [3];
	_blur ppEffectCommit playerRespawnTime;
};

private _veh = vehicle _body;
private _pos = ASLtoAGL getPosASL _veh;
if (_body distance2D markerPos "respawn_west" > 100) then {
	if (surfaceIsWater getPosASL _body
	    or {not (isTouchingGround _veh) and {sel(_pos,2) > 2}}
	) then {
		setVar(missionNamespace,"playerRespawnType","NO_REVIVE")
	};
};
if (_veh != _body) then {
	_body setPosWorld getPosWorld _body
};

_body setBleedingRemaining 0;

sleep playerRespawnTime;

if (not isNil "_blur") then {
	ppEffectDestroy _blur;
};

{
	if (not isNull (findDisplay 46 displayCtrl _x)) then {
		ctrlDelete (findDisplay 46 displayCtrl _x)
	};
} forEach [1929,1930,1931];

ncb_gv_distanceData = nil; // reset in displayTitles.hpp