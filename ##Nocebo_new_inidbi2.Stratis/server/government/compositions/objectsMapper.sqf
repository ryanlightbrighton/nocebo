#define diag(a,b) (diag_log format [prefix + "objectsMapper"" - " + a + ": %1",b])
#include "\nocebo\defines\scriptDefines.hpp"

// _objects = [position player,getDir player,ncb_gv_artilleryObjects] call horde_fnc_ObjectsMapper;

params ["_pos","_azi","_objs","_random"];

if (count _this > 3) then {
	_random = _this select 3;
} else {
	_random = 0;
};

private _newObjs = [];
private _gunSpots = [];
private _unitSpots = [];
private _vehicleSpots = [];
_pos params ["_posX","_posY"];

{
	if (random 1 > _random) then {
		_x params ["_type","_relPos","_azimuth","_fuel","_damage","_orientation","_varName","_init","_simulation","_ASL","_onFloor","_align","_soundSource"];
		private _rotMatrix = [
			[cos _azi,sin _azi],
			[-(sin _azi),cos _azi]
		];
		private _newRelPos = [_rotMatrix, _relPos] call horde_fnc_multiplyMatrix;

		private _z = if (count _relPos > 2) then {
			_relPos select 2
		} else {
			0
		};

		private _newPos = [
			_posX + (_newRelPos select 0),
			_posY + (_newRelPos select 1),
			_z
		];
		private _newDir = _azi + _azimuth;

		call {
			if (_type isKindOf "CAManBase") exitWith {
				_unitSpots pushBack [_newPos,_newDir];
			};
			if (_type isKindOf "StaticWeapon") exitWith {
				_gunSpots pushBack [_type,_newPos,_newDir];
			};
			if (_type isKindOf "AllVehicles") then {
				_vehicleSpots pushBack [_type,_newPos,_newDir];
			} else {
				private _newObj = createVehicle [_type,_newPos,[],0,"can_collide"];
				_newObj setDir _newDir;
				if not (_ASL) then {
					_newObj setPos _newPos;
				} else {
					_newObj setPosASL _newPos;
				};
				_newObj setFuel _fuel;
				_newObj setDamage _damage;
				if (count _orientation > 0) then {
					([_newObj] + _orientation) call BIS_fnc_setPitchBank;
				};
				if (_varName != "") then {
					_newObj setVehicleVarName _varName;
					call compile (_varName + " = _newObj;");
				};
				if (_init != "") then {
					_newObj call compile ("this = _this; " + _init);
				};
				if (_onFloor) then {
					_newPos set [2,0];
					_newObj setPos _newPos;
				};
				if (_align) then {
					_newObj setVectorUp surfaceNormal _newPos;
				} else {
					_newObj setVectorUp [0,0,1]
				};
				if (_soundSource != "") then {
					private _sound = createSoundSource [_soundSource,_newPos,[],0];
					_sound attachTo [_newObj,[0,0,1]];
					_newObj addEventHandler ["killed", {
						{
							deleteVehicle _x
						} count attachedObjects (_this select 0);
					}];
				};
				// add some guns if cargo
				if (_type isEqualTo "ncb_obj_ammobox_m") then {
					[
						_newObj,
						[0,4,1,3],	// optics
						[0,5,1,2],	// vests
						[0,5,1,2],	// helmets
						[0,5,1,2],	// guns
						[0,4,1,3],	// backpacks
						[0,2,1,5],	// charges
						[0,2,1,2],	// medical
						[],			// food
						[],			// tools
						[],			// tents
						[0,2,1,2],	// fuel
						[0,2,1,2],	// vehicle ammo
						[0,2,1,2],	// launchers
						[]			// vehicle parts
					] call horde_fnc_fillCrate;
				};
				_newObj enableSimulation _simulation;
				_newObjs pushBack _newObj;
			};
		};
	};
} forEach _objs;

[_newObjs,_gunSpots,_unitSpots,_vehicleSpots]

