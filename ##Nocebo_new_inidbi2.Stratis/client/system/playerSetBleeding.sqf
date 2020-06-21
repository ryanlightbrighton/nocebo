#include "\nocebo\defines\scriptDefines.hpp"

// small chance of self healing
if (random 0.02 > random 1) then {
	ncb_gv_playerBleedingRate = 0;
};
if (ncb_gv_playerBleedingRate != 0
	and {alive player}
) then {
	private _damage = damage player;
	_damage = _damage + ncb_gv_playerBleedingRate;
	if (_damage < 0.99) then {
		player setDamage _damage;
		if (player getHitPointDamage "HitLegs" > 0.49) then {
			player setHitPointDamage ["HitLegs",0.49]
		};
	} else {
		// trigger revive if applicable
		player setDamage 0.95;
		private _veh = vehicle player;
		private _pos = getPosATL _veh;

		ncb_gv_playerBleedingRate = 0;
		if (surfaceIsWater getPosASL player
			or {not (isTouchingGround _veh) and {sel(_pos,2) > 2}}
		) exitWith {
			setVar(missionNamespace,"playerRespawnType","NO_REVIVE");
			player setDamage 1;
		};
		if (not isNull objectParent player) then {
			player setPosWorld getPosWorld player;
		};
		player switchMove "";
		player setUnconscious true;
		openMap [false,false];
		closeDialog 0;
		clearRadio;
		enableRadio false;
		"dynamicBlur" ppEffectEnable false;
		player allowDamage false;
		player setCaptive true;
		[player,player] call horde_fnc_handleRespawn;
		call horde_fnc_removeEachFrame
	};
} else {
	call horde_fnc_removeEachFrame;
	player setBleedingRemaining 0
};

true