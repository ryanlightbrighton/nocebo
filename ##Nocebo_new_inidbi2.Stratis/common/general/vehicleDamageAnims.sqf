#define diag(a,b) (diag_log format [prefix + "vehicleDamageAnims"" - " + a + ": %1",b])
#include "\nocebo\defines\scriptDefines.hpp"

// old version

params ["_veh","_selectionName","_damage","_hitPartIndex","_hitpoint"];

if (_hitpoint == "" or {damage _veh >= 1}) exitWith {false};

private _cfgInteraction = cfgVeh >> typeOf _veh >> "VehicleInteractionInfo";

// check if anims have been changed
// if threshold is high enough, and they are not triggered, then animate and spawn some particle fx

for "_i" from 0 to count _cfgInteraction - 1 do {
	private _action = sel(_cfgInteraction,_i);
	private _location  = getArray (_action >> "location");
	if (_hitpoint in _location) exitWith {
		private _dmg = _veh getHitPointDamage _hitpoint;
		private _anim = getArray (_action >> "anim");
		if not empty(_anim) then {
			if same(_hitpoint,"HitEngine") then {
				private _ret = [_veh,_hitpoint] call horde_fnc_selectEngineSmoke;
				if sel(_ret,0) then {
					for "_i" from 1 to 3 do {
						private _slickPos = _veh modelToWorld sel(_ret,1);
						private _vel = (vectorNormalized velocity _veh) vectorMultiply ((speed _veh) * 0.25);
						_slickPos = _slickPos vectorAdd [
							((random 4) - 2) + sel(_vel,0),
							((random 4) - 2) + sel(_vel,1),
							0
						];
						_slickPos set [2,0];
						private _slick = createVehicle ["ncb_obj_oil_spill",_slickPos,[],0,"can_collide"];
						_slick setDir random 360;
						_slick setVectorUp surfaceNormal _slickPos;
					};
				};
			};
			_anim params ["_animType","_animPartsArr"];
			{
				_x params ["_part","_threshold"];
				private _phase = if (_animType == "animate") then {
					_veh animationPhase _part
				} else {
					_veh doorPhase _part
				};
				if (same(_phase,0) and {_dmg >= _threshold}) then {
					private _nearPlayers = [_veh,400] call horde_fnc_allPlayersInRange;
					if not empty(_nearPlayers) then {
						(_veh modelToWorldVisual (getArray (_action >> "modelposition"))) remoteExecCall [
							"horde_fnc_vehDamageParticleEffects",
							_nearPlayers
						];
					};
					if (_animType == "animate") then {
						_veh animate [_part,1];
					} else {
						_veh animateDoor [_part,1,false];
					};
				};
				nil
			} count _animPartsArr;
		};
	};
};

true
