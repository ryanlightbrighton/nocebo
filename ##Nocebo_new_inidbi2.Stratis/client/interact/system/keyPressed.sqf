#include "\nocebo\defines\scriptDefines.hpp"

params ["_ctrl","_keyCode","_shiftKey","_ctrlKey","_altKey"];

private _time = missionNamespace getVariable ["playerAntiButtonSpam",0];
private _override = false;
if (time > _time
	and {not dialog}
) then {
	call {
		if (_keyCode in (actionKeys "User13")) exitWith {
			0 call horde_fnc_selectInteractionMenu;
			setVar(missionNamespace,"playerAntiButtonSpam",time + 0.5);
			_override = true;
		};
		if (_keyCode in (actionKeys "User14")) exitWith {
			0 spawn horde_fnc_placeCharge;
			setVar(missionNamespace,"playerAntiButtonSpam",time + 1.5);
			_override = true;
		};
		if (_keyCode in (actionKeys "nextWeapon")) exitWith {
			if (currentWeapon player == secondaryWeapon player) then {
				if (currentMagazine player != "") then {
					if (getNumber (configFile >> "CfgMagazines" >> currentMagazine player >> "ncb_attackType") < 1
					    and {getNumber (configFile >> "CfgWeapons" >> currentWeapon player >> "weaponLockSystem") == 0}
					) then {
						createDialog "ncb_dlg_fuseSetting";
						_override = true;
					};
				};
			};
		};
	};
};
_override