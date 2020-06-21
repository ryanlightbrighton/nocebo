#include "\nocebo\defines\scriptDefines.hpp"

params ["_thing","_type"];
call {
	if (_type == "main") exitWith {
		uiNamespace setVariable ["ncb_dlg_fuseSetting",_thing];
		_fuse = str (missionNamespace getVariable ["ncb_gv_launcherFuseSetting",0]);
		if (_fuse == "0") then {
			_fuse = "CONTACT"
		} else {
			_fuse = _fuse + "m"
		};
		(_thing displayCtrl 1001) ctrlSetStructuredText parseText (format ["<t size='1.7'color='#000000' align='center'shadow='2'>CURRENT FUSE: %1</t>",_fuse]);
		ctrlSetFocus (_thing displayCtrl 1801);
		(_thing displayCtrl 1801) ctrlSetEventHandler [
			"KeyDown",
			"
				call {
					if ((_this select 1) in [28,156]) exitWith {
						_value = ctrlText ((uiNamespace getVariable 'ncb_dlg_fuseSetting') displayCtrl 1801);
						_value = parseNumber _value;
						if (_value > 0) then {
							if (_value < 40) then {
								_value = 40
							}
						};
						missionNamespace setVariable ['ncb_gv_launcherFuseSetting',_value];
						closeDialog 0;
						false
					};
					if ((_this select 1) in actionKeys 'nextWeapon') exitWith {
						closeDialog 0;
						false
					};
				}
			"
		];
	};
	if (_type == "object") exitWith {
		_ammo = getText (configFile >> "CfgMagazines" >> currentMagazine player >> "ammo");
		_ammo = getText (configFile >> "CfgAmmo" >> _ammo >> "model");
		if (_ammo select [0,1] == "\") then {
			_ammo = _ammo splitString "";
			_ammo deleteAt 0;
			_ammo = _ammo joinString "";
		};
		_thing ctrlSetModel _ammo;
		_thing ctrlSetModelScale 1;
		_thing ctrlSetModelDirAndUp [[0,0,-1],[0,1,0]];
		_thing ctrlSetPosition [0.5, 1.2, 0.5];
		_thing ctrlEnable false;
		/*[
			[_thing,[0.5, 1.2, 0.5]],{
				if (dialog) then {
					call horde_fnc_getEachFrameArgs params ["_ctrl","_pos"];

					_ctrl ctrlSetPosition _pos;
					// _ctrl ctrlSetModelDirAndUp [[0,0,-1],[linearConversion [0,1,time % 1,-1,1,true],1,0]];
				} else {
					call horde_fnc_removeEachFrame
				}
			},
			0
		] call horde_fnc_addEachFrame;*/
	};
	if (_type == "input") exitWith {
		_thing ctrlSetToolTip call compile "'Enter range (m)' + endl + '0 = impact detonation' + endl + 'Minimum dist = 40m'";
	};
};