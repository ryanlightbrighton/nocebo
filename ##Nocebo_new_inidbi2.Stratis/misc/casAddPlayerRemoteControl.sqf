#include "\nocebo\defines\scriptDefines.hpp"

params ["_veh","_grp"];

ncb_layer_staticScreen cutRsc ["RscNoise","black"];
sleep 0.25;
inGameUISetEventHandler ["Action","
	call {
		if (_this select 3 == 'MoveToPilot') exitWith {
			['DenyEject',['You are not allowed to switch seats']] call bis_fnc_showNotification;
			true
		};
		if (_this select 3 == 'Eject') exitWith {
			['DenyEject',['You are not allowed to eject']] call bis_fnc_showNotification;
			true
		};
		if (_this select 3 == 'MoveToTurret') exitWith {
			['DenyEject',['You are not allowed to switch seats']] call bis_fnc_showNotification;
			true
		};
		if (_this select 3 == 'SwitchToUAVDriver') exitWith {
			['DenyEject',['You are not allowed to take UAV controls']] call bis_fnc_showNotification;
			true
		};
		if (_this select 3 == 'BackFromUAV') exitWith {
			ncb_gv_exitRemoteControl = true;
			true
		};
	}
"];
(_veh turretUnit [2]) addAction ["View Dist: 1500m", "setViewDistance 1500;setObjectViewDistance [1500,ncb_param_shadowRenderDistance]"];
(_veh turretUnit [2]) addAction ["View Dist: 2000m", "setViewDistance 2000;setObjectViewDistance [2000,ncb_param_shadowRenderDistance]"];
(_veh turretUnit [2]) addAction ["View Dist: 3000m", "setViewDistance 3000;setObjectViewDistance [3000,ncb_param_shadowRenderDistance]"];
(_veh turretUnit [2]) addAction ["View Dist: 4000m", "setViewDistance 4000;setObjectViewDistance [4000,ncb_param_shadowRenderDistance]"];
player remoteControl (_veh turretUnit [2]);
_veh switchCamera "gunner";
sleep 0.75;
ncb_layer_staticScreen cutText ["","PLAIN DOWN"];
waitUntil {
	!(alive _veh)
	or {isTouchingGround _veh}
	or {not canMove _veh}
	or {not (toLower lifeState player in ["healthy","injured"])}
	or {currentWaypoint _grp > 2}
	or {not isNil "ncb_gv_exitRemoteControl"}
	or {not alive (_veh turretUnit [2])}
};
if (currentWaypoint _grp > 2) then {
	private _text = "
		<t size='3.2'color='#FFFFFF'align='center'shadow='2'>
		CAS RTB
		</t>
	";
	_text call horde_fnc_displayActionConfMessage;
	sleep 3;
};
closeDialog 0;
ncb_layer_staticScreen cutRsc ["RscNoise","black"];
setViewDistance 1500;
setObjectViewDistance [1500,ncb_param_shadowRenderDistance];
ncb_gv_exitRemoteControl = nil;
objNull remoteControl (_veh turretUnit [2]);
player switchCamera "internal";
sleep 0.5;
ncb_layer_staticScreen cutText ["","PLAIN DOWN"];
inGameUISetEventHandler ["Action",""];