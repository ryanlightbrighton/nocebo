#include "\nocebo\defines\scriptDefines.hpp"

params ["_unit","_selName","_damage","_source","_projClass"];

if (ncb_param_invincible == 1
    or {not alive _unit}
    or {lifeState _unit == "INCAPACITATED"}
) exitWith {0};

if same(_selName,"") then {
	private _checkBleed = false;
	if (_projClass isKindOf "BulletCore") then {
		_checkBleed = true;
		{
			if (_x isKindOf _projClass
				and {random 1 > 0.9}
				and {diff(ncb_gv_playerLastBullet,_x)}
				and {vectorMagnitude velocity _x <= 0.01}
			) exitWith {
				ncb_gv_playerLodgedBullets = ncb_gv_playerLodgedBullets + 1;
				ncb_gv_playerLastBullet = _x
			};
		} count (nearestObjects [ASLtoAGL getPosWorld _unit,[],1.5]);
	};
	if (_checkBleed
		or {not isNull objectParent player}
		or {_projClass isKindOf "Default"}
	) then {
		if (_damage > 0.1
			and {random 1 > 0.5}
		) then {
			if same(ncb_gv_playerBleedingRate,0) then {
				ncb_gv_playerBleedingRate = _damage / 120;
				player setBleedingRemaining 99999;
				[
					[],
					horde_fnc_playerSetBleeding,
					2.5
				] call horde_fnc_addEachFrame;
			} else {
				ncb_gv_playerBleedingRate = ncb_gv_playerBleedingRate + (_damage / 120);
			};
		};
	};
};

if (isPlayer _source) then {
	// player caused damage
	if (_selName != "") then {
		private _oldDamage = _unit getHit _selName;
		if (_oldDamage isEqualType 0) then {
			_damage = _oldDamage + ((_damage - _oldDamage) * ncb_param_playerDamageCoefSourcePlayer);
		};
	} else {
		private _oldDamage = damage player;
		_damage = _oldDamage + ((_damage - _oldDamage) * ncb_param_playerDamageCoefSourcePlayer);
	};
} else {
	// sort AI damage from things like falling etc
	if (_projClass isKindOf "Default") then {
		if (_selName != "") then {
			private _oldDamage = _unit getHit _selName;
			if (_oldDamage isEqualType 0) then {
				_damage = _oldDamage + ((_damage - _oldDamage) * ncb_param_playerDamageCoefSourceAI);
			};
		} else {
			private _oldDamage = damage player;
			_damage = _oldDamage + ((_damage - _oldDamage) * ncb_param_playerDamageCoefSourceAI);
		};
	};
};

_damage = _damage max ncb_gv_playerLodgedBullets * 0.07;

if (toLower _selName in ["","head","face_hub","neck","spine1","spine2","spine3","pelvis","body","?"]) then {
	// trigger revive if applicable
	if (_damage > 0.99) then {
		_damage = 0.95;
		_selName = "forced_death";
		private _veh = vehicle _unit;
		private _pos = getPosATL _veh;

		diag("tripped revive code");
		diag(_this);
		diag(time);

		ncb_gv_playerBleedingRate = 0;
		if (surfaceIsWater getPosASL _unit
		    or {not (isTouchingGround _veh) and {sel(_pos,2) > 2}}
		) exitWith {
			diag("tripped no revive death");
			diag(_this);
			diag("time",time);
			setVar(missionNamespace,"playerRespawnType","NO_REVIVE");
			_damage = 1;
		};
		if (_veh != _unit) then {
			_unit setPosWorld getPosWorld _unit;
		};
		_unit switchMove "";
		_unit setUnconscious true;
		openMap [false,false];
		closeDialog 0;
		clearRadio;
		enableRadio false;
		"dynamicBlur" ppEffectEnable false;
		_unit allowDamage false;
		_unit setCaptive true;
		if (same(group _unit,group _source)
			and {diff(_unit,_source)}
		) then {
			private _text = format [
				"
					<t size='3.2'color='#FF0000'align='center'shadow='2'>
					%1 was killed by group member: %2
					</t>
				",
				name _unit,
				name _source
			];
			_text remoteExecCall [
				"horde_fnc_displayActionRejMessage",
				units group _source
			];
		};
		[_unit,_unit] call  horde_fnc_handleRespawn;
	};
};

if (toLower _selName in ["legs"]) then {
	if (_damage > 0.49) then {
		_damage = 0.49
	};
};

_damage