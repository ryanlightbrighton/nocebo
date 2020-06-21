#include "\nocebo\defines\scriptDefines.hpp"

// server only

private _type = typeOf _this;
private _cfgInteraction = cfgVeh >> _type >> "VehicleInteractionInfo";

for "_i" from 0 to count _cfgInteraction - 1 do {
	private _action = sel(_cfgInteraction,_i);
	{
		if diff(_x,"AddWeapon") then {
			private _dmg = _this getHitPointDamage _x;
			private _anim = getArray (_action >> "anim");
			if (not empty(_anim)) then {
				if same(_x,"HitEngine") then {
					[_veh,_x] call horde_fnc_selectEngineSmoke;
				};
				_anim params ["_animType","_animPartsArr"];
				{
					_x params ["_part","_threshold"];
					if (_dmg >= _threshold) then {
						if same(_animType,"animate") then {
							if diff(_this animationPhase _part,1) then {
								_this animate [_part,1];
							};
						} else {
							if diff(_this doorPhase _part,1) then {
								_this animateDoor [_part,1,true];
							};
						};
					} else {
						if same(_animType,"animate") then {
							if diff(_this animationPhase _part,0) then {
								_this animate [_part,0];
							};
						} else {
							if diff(_this doorPhase _part,0) then {
								_this animateDoor [_part,0,true];
							};
						};
					};
					true
				} count _animPartsArr;
			};
		};
	} forEach getArray (_action >> "location");
};

true