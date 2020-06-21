#include "\nocebo\defines\scriptDefines.hpp"

params ["_veh","_selName","_damage","_source","_projClass","_hitPartIndex"];
_ejectCheck = false;
if (_hitPartIndex > -1) then {
	getAllHitPointsDamage _veh params ["_hpNames"];
	if (toLower (_hpNames select _hitPartIndex) in ["hitengine","hitbody"]) exitWith {
		_ejectCheck = true;
	};
} else {
	_ejectCheck = true;
};
if (_ejectCheck) then {
	if (damage _veh == 1) exitWith {
		_damage
	};
	if (_damage > 0.99) then {
		{
			_x action ["eject", _veh]
		} count crew _veh;
		_veh removeAllEventHandlers "handleDamage";
		_veh allowDamage false;
		_veh spawn {
			scriptName "horde_fnc_handleDamageAIBoat";
			waitUntil {
				crew _this isEqualTo []
			};
			_this setDamage 1;
		};
	};
};
_damage