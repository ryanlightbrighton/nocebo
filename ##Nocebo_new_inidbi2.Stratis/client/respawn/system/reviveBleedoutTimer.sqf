#include "\nocebo\defines\scriptDefines.hpp"

// the menu might be closed by player with <esc>.  This is ok as it will reopen if no selection is made, but this timer will need to be independent of the menu (ie called from the respawn fsm).  So, it's launched only from the respawn menu and the bleedout timer is hid by default (as this menu is also used in case of "no revive")

// refresh timer

ncb_gv_bleedoutTimer = ncb_param_bleedoutTimer;

[
	[],{
		if not (missionNameSpace getVariable ["playerOkToCloseRespawnMenu",false]) then {
			private _display = uiNamespace getVariable ['Horde_respawnMenu',displayNull];
			if not (isNull _display) then {
				// exit if bleedout
				if (ncb_gv_bleedoutTimer < 1) exitWith {
					missionNamespace setVariable ['playerRespawnType','COAST'];
					missionNameSpace setVariable ['playerOkToCloseRespawnMenu',true];
					forceRespawn player;
					call horde_fnc_removeEachFrame
				};
				(_display displayCtrl 1603) progressSetPosition (ncb_gv_bleedoutTimer / ncb_param_bleedoutTimer);
				ncb_gv_bleedoutTimer = ncb_gv_bleedoutTimer - 0.1;
			}
		} else {
			call horde_fnc_removeEachFrame
		}
	},
	0.1
] call horde_fnc_addEachFrame;