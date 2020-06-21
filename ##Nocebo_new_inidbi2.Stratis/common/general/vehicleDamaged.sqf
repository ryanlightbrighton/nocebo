#define diag(a,b) (diag_log format [prefix + "vehicleDamaged"" - " + a + ": %1",b])
#include "\nocebo\defines\scriptDefines.hpp"

/*params ["_veh","_part","_damage","_source","_proj"];
diag_log format ["in %1", _this];
diag_log format ["curr damage %1", _veh getHit _part];
if same(_part,"") then {
	_damage = 0
} else {
	if (not isNull driver _veh
		and {not isPlayer driver _veh}
	) then {
		if (not isPlayer _source
			and {same(_proj,"")}
		) then {
			_damage = 0
		};
	};
};
diag_log format ["out %1", _damage];
_damage*/

// _this select 0 seems now to be the driver of the vehicle if it is a collision

/*params ["_object","_part","_damage","_source","_proj"];
diag_log "	";
diag_log format ["in %1", _this];
diag_log format ["curr damage %1", _object getHit _part];
if (same(_part,"")
    or {not (_damage isEqualType 0)}
) then {
	_damage = 0
} else {
	_driver = driver _object;
	if (not isNull _driver
		and {not isPlayer _driver}
		and {not isPlayer _source}
		and {same(_proj,"")}
	) then {
		_damage = 0
	};
};
diag_log format ["out %1", _damage];
_damage*/

params ["_object","_part","_damage","_source","_proj"];
/*diag_log "	";
diag_log format ["in: %1", _this];
diag_log format ["curr damage: %1", _object getHit _part];*/
if (_part isEqualTo "") then {
	_damage = 0
} else {
	if (not isPlayer _object
		and {not isPlayer _source}
		and {_proj isEqualTo ""}
	) then {
		_damage = 0
	};
};
/*diag_log format ["out: %1", _damage];*/
_damage