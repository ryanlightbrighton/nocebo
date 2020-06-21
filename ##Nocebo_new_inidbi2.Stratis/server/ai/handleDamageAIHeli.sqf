#include "\nocebo\defines\scriptDefines.hpp"

params ["_veh","_selName","_damage","_source","_projClass","_hitPartIndex"];
if (_hitPartIndex > -1) then {
	getAllHitPointsDamage _veh params ["_hpNames"];
	_hitPoint = _hpNames select _hitPartIndex;
	call {
		if (_hitPoint == "HitEngine") exitWith {
			if (_damage > 0.9) then {
				_veh setDamage 1;
				_veh removeAllEventHandlers "handleDamage"
			};
		};
		if (_hitPoint == "HitVRotor") exitWith {
			if (_damage > 0.6) then {
				_veh setDamage 1;
				_veh removeAllEventHandlers "handleDamage"
			};
		};
	};
};
_damage