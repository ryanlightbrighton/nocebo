#include "\nocebo\defines\scriptDefines.hpp"

params ["_item","_container"];

if (_item == "ItemMeatRaw") exitWith {
	[
		[_item,_container],{
			call horde_fnc_getEachFrameArgs params ["_item","_container"];
			private _cargo = itemCargo _container;
			private _index = _cargo find _item;
			if (_index > -1) then {
				_cargo deleteAt _index;
				_cargo pushBack "ItemMeatCookedLean";
				clearItemCargoGlobal _container;
				{
					_container addItemCargoGlobal [_x,1]
				} count _cargo;
			};
			call horde_fnc_removeEachFrame
		},
		2 + (random 5)
	] call horde_fnc_addEachFrame;
};
if (_item isKindOf ["CA_Magazine",configFile >> "CfgMagazines"]) exitWith {
	[
		[_item,_container],{
			call horde_fnc_getEachFrameArgs params ["_item","_container"];
			private _cargo = magazinesAmmoCargo _container;
			{
				_x params ["_mag","_ammoCount"];
				if (_item == _mag) exitWith {
					_cargo deleteAt _forEachIndex;
					clearMagazineCargoGlobal _container;
					{
						_x params ["_mag2","_ammoCount2"];
						_container addMagazineAmmoCargo [_mag2,1,_ammoCount2]
					} forEach _cargo;
					// explode!
					[_container,_item,_ammoCount] spawn {
						scriptName "playerPut";
						params ["_container","_item","_ammoCount"];
						private _pos = getPosATL _container vectorAdd [0,0,4];
						private _cfgItem = configFile >> "CfgMagazines" >> _item;
						private _ammo = getText (_cfgItem >> "ammo");
						private _shootsOff = {if (_ammo isKindOf _x) exitWith {1}} count ["BulletBase","F_40mm_White","G_40mm_HE","G_40mm_Smoke","RocketBase","MissileBase","ShellBase"] > 0;
						private _players = [_container,200] call horde_fnc_allPlayersInRange;
						for "_times" from 1 to _ammoCount do {
							if (isNull _container) exitWith {};
							playSound3D [
								format ["A3\Sounds_F\arsenal\weapons\Pistols\Acpc2\acpc2_short_0%1.wss",selectRandom [1,2,3]],
								_container,
								false,
								getPosASL _container,
								1,
								1,
								200
							];

							[getPosATL _container,"Horde_ImpactSparksSabot1Small",0.2] remoteExecCall [
								"horde_fnc_timedParticleEffect",
								_players
							];

							private _stray = createVehicle [_ammo,_pos,[],0,"can_collide"];
							if (_shootsOff) then {
								private _velocity = [
									(random 5) - 2.5,
									(random 5) - 2.5,
									(random 2) - 1
								] vectorMultiply (random (getNumber (_cfgItem >> "initSpeed")));
								_stray setVelocity _velocity;
							} else {
								_stray setVelocity [0,0,-1]
							};
							uiSleep (random [0.01,0.2,3]);
						}
					}
				}
			} forEach _cargo;
			call horde_fnc_removeEachFrame
		},
		2 + (random 5)
	] call horde_fnc_addEachFrame;
};