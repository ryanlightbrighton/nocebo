#include "\nocebo\defines\scriptDefines.hpp"

params ["_player","_container","_item"];

private _playerContainers = [
	backPackContainer _player,
	uniformContainer _player,
	vestContainer _player
];

if not (_container in _playerContainers) then {
	private _pos = ASLtoATL getPosASL _player;
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
		if (not simulationEnabled _container) then {
			[_container, true] remoteExecCall [
				"enableSimulationGlobal",
				2
			];
		};
		if (_item isKindOf "Bag_Base") exitWith {
			if (_container isKindOf "Offroad_01_base_F") then {
				private _content = getBackpackCargo _container;
				if (count sel(_content,0) == 1) then {
					_container animate ["HideBackpacks", 0];
				};
			};
		};

		if ({typeOf _container isKindOf _x} count ["FirePlace_burning_F","Campfire_burning_F"] > 0) exitWith {
			[_item,_container] remoteExecCall [
				"horde_fnc_placeItemInFire",
				2
			]
		};
	};
};
true