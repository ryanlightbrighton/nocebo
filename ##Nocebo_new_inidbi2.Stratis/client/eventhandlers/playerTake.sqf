#include "\nocebo\defines\scriptDefines.hpp"

params ["_player","_container","_item"];

private _playerContainers = [
	backPackContainer _player,
	uniformContainer _player,
	vestContainer _player
];

if not (_container in _playerContainers) then {
	private _pos = ASLtoAGL getPosASL _player;
	private _sound = "";
	call {
		private _cfgItem = cfgMag >> _item;
		if (isClass _cfgItem) exitWith {
			_sound = getText (_cfgItem >> "horde_inventorySound");
		};
		_cfgItem = configFile >> "CfgGlasses" >> _item;
		if (isClass _cfgItem) exitWith {
			_sound = "horde_sound_linenInventory";
		};
		_cfgItem = cfgWeap >> _item;
		if (isClass _cfgItem) then {
			_sound = getText (_cfgItem >> "horde_inventorySound");
		} else {
			_cfgItem = cfgVeh >> _item;
			_sound = getText (_cfgItem >> "horde_inventorySound");
		};
	};

	private _nearPlayers = _pos nearEntities ["ncb_player_base",23];
	if not empty(_nearPlayers) then {
		[_pos,_sound,3] remoteExecCall [
			"horde_fnc_playSingleSound",
			_nearPlayers
		];
	};

	call {
		if not (simulationEnabled _container) then {
			diag("container not simulated");
			diag(_container);
			[_container, true] remoteExecCall [
				"enableSimulationGlobal",
				2
			];
		};
		if (_item isKindOf "Bag_Base") exitWith {
			if (_container isKindOf "Offroad_01_base_F") then {
				private _content = getBackpackCargo _container;
				if empty(sel(_content,0)) then {
					_container animate ["HideBackpacks", 1];
				};
			};
		};
		// new bit for defusing bombs
		if (_item == "DemoCharge_Remote_Mag") exitWith {
			player removeItem "DemoCharge_Remote_Mag";
			player addItem "StickyCharge_Remote_Mag"
		};
		if (_item == "B_UavTerminal") exitWith {
			{
				player disableUAVConnectability [_x,true];
			} forEach [
				ncb_obj_destroyer_hammer,
				ncb_obj_destroyer_vls,
				ncb_obj_destroyer_praetorian_fwd,
				ncb_obj_destroyer_praetorian_port,
				ncb_obj_destroyer_praetorian_starboard,
				ncb_obj_destroyer_centurion,
				ncb_obj_destroyer_spartan
			];
		}
	};
} else {
	// player sideChat format ["Reload complete: %1",_item];
	// more code for later (not working if pick up ammo off ground into weapon mag - obv)
	// also triggers when assigning items
};
true