#include "\nocebo\defines\scriptDefines.hpp"

if (not isPlayer (_this select 0)) exitWith {};
_type = getNumber (configFile >> "CfgMagazines" >> (_this select 5) >> "ncb_attackType");
call {
	if (_type < 1) exitWith {
		_fuse = missionNamespace getVariable ["ncb_gv_launcherFuseSetting",0];
		if (_fuse == 0) exitWith {};
		[
			[ASLtoAGL getPosASL (_this select 0),_this select 6,_fuse],{
				call horde_fnc_getEachFrameArgs params ["_start","_proj","_fuse"];
				if (isNull _proj) exitWith {
					call horde_fnc_removeEachFrame
				};
				_pos = ASLtoAGL getPosASL _proj;
				if (_start distance _pos >= _fuse) then {
					_exploder = createVehicle ["Land_BakedBeans_F",ASLtoAGL getPosASL _proj,[],0,"can_collide"];
					_exploder setPosASL getPosASL _proj;
					[
						[_exploder],
						{
							call horde_fnc_getEachFrameArgs params ["_exploder"];
							deleteVehicle _exploder;
							call horde_fnc_removeEachFrame
						},
						0.1
					] call horde_fnc_updateEachFrame
				}
			},
			0.0001
		] call horde_fnc_addEachFrame
	};
	if (_type == 1) exitWith {
		[
			[_this select 6],{
				call horde_fnc_getEachFrameArgs params ["_proj"];
				if (isNull _proj) exitWith {
					call horde_fnc_removeEachFrame
				};
				_ins = lineIntersectsSurfaces [
					getPosASL _proj,
					getPosASL _proj vectorAdd [0,0,-30],
					_proj,
					objNull,
					true,
					1,
					"FIRE",
					"NONE"
				];
				if not ([] isEqualTo _ins) then {
					_obj = _ins select 0 select 3;
					if ({_obj isKindOf _x} count ["LandVehicle","Air","Ship_F"] > 0) then {
						_pos1 = ASLtoAGL getPosASL _proj;
						_pos2 = ASLtoAGL getPosASL _obj;
						_vec = (_pos1 vectorFromTo _pos2) vectorMultiply (vectorMagnitude velocity _proj);
						[
							_pos1,
							["ncb_grenadeExp","ncb_grenadeSmoke1"],
							[[[0,0,0],10,[1,0.6,0.4],10000,[true,1,800],[0,0,0,2.2,500,1000],true]],
							0.1
						] call horde_fnc_timedParticleEffects;
						call horde_fnc_removeEachFrame;
						[
							[_proj,_vec],
							{
								call horde_fnc_getEachFrameArgs params ["_proj","_vec"];
								if (isNull _proj) then {
									call horde_fnc_removeEachFrame
								} else {
									_proj setVelocity _vec
								}
							},
							0
						] call horde_fnc_addEachFrame
					}
				}
			},
			0
		] call horde_fnc_addEachFrame
	}
}