#include "\nocebo\defines\scriptDefines.hpp"

params ["_mortar","_objFired","_dist","_weap","_muzz","_mode","_ammo","_gunnerObjFired"];
private _gunner = gunner _mortar;
if (isNull _gunner or {isPlayer _gunner}) exitWith {};
if (side _objFired in [west,resistance]) then {
	if (_gunner knowsAbout _objFired > 1) then {
		[_gunner] allowGetIn false;
		_gunner action ["getOut",_mortar];

		[
			[_mortar,_gunner],{
				call horde_fnc_getEachFrameArgs params ["_mortar","_gunner"];
				private _enemy = _gunner findNearestEnemy _gunner;
				if (not alive _gunner
					or {not alive _mortar}
					or {isNull _enemy}
					or {_enemy distance _gunner > 69}
				) then {
					if (alive _gunner and {alive _mortar}) then {
						[_gunner] allowGetIn true;
						_gunner action ["getInGunner",_mortar];
					} else {
						_mortar removeAllEventHandlers "firedNear"
					};
					call horde_fnc_removeEachFrame
				}
			},
			10
		] call horde_fnc_addEachFrame;
	}
};