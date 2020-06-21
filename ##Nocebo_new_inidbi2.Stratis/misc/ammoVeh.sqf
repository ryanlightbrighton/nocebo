_vehicleTypes = [];
{
	_vehicleTypes pushBackUnique _x
} forEach (ncb_gv_enemyCivVehTypes + ncb_gv_enemyIndVehTypes + ncb_gv_enemyMilVehTypes + ncb_gv_enemyPatrolBoatTypes + ncb_gv_enemyInflatableTypes + ncb_gv_enemyCarTypes + ncb_gv_enemyTruckTypes + ncb_gv_enemyTechnicalTypes + ncb_gv_enemyAPCTypes + ncb_gv_enemyStaticMGLoTypes + ncb_gv_enemyStaticMGHiTypes + ncb_gv_enemyStaticAATypes + ncb_gv_enemyStaticATTypes + ncb_gv_enemyMortarTypes + ncb_gv_enemyAttackHeliTypes + ncb_gv_enemyTransportHeliTypes + ncb_gv_enemyDropPodHeliTypes + ncb_gv_enemyDropPodTypes);

diag_log _vehicleTypes;

_ammoTypes = [];
_cfgAmmo = configFile >> "CfgAmmo";

for "_i" from 0 to (count _cfgAmmo - 1) do {
	_cfgAmmoEntry = _cfgAmmo select _i;
	_ammoClassName = configName _cfgAmmoEntry;
	if (isClass _cfgAmmoEntry) then {
		/*if (_ammoClassName isKindOf "BulletBase"*/
		if ({if (_ammoClassName isKindOf _x) exitWith {1}} count ["BulletBase","ShotgunBase","G_40mm_HE"] > 0
			and {toLower _ammoClassName find "base" == -1}
		) then {
			_ammoTypes pushBack _ammoClassName
		};
	};
};

diag_log _ammoTypes;

_spawnPos = player modelToWorld [0,20,0];
{
	_veh = createVehicle [_x,_spawnPos,[],0,"can_collide"];
	/*waitUntil {not isNull _veh and {vectorMagnitude velocity _veh < 0.01};*/
	_veh addEventHandler ["handledamage",{_d = _this select 2; if (_d > 0.9) then {_d = 0.9};_d}];
	// shoot it
	{
		_t = time;
		_proj = createVehicle [_x,getPos _veh vectorAdd [0,0,30],[],0,"none"];
		_proj setVelocity [0,0,-900];
		waitUntil {
			uiSleep 0.01;
			isNull _proj or {time - _t > 2}
		};
		if not (isNull _proj) then {
			deleteVehicle _proj
		};
		// check damage

		_veh setDamage 0;
	} forEach _ammoTypes;
	deleteVehicle _veh;
} forEach _vehicleTypes;