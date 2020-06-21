#include "\nocebo\defines\scriptDefines.hpp"

private _grp = group _this;

if (time > 1 + (_grp getVariable ["timeCompleted",0])) then {
	_grp setVariable ["timeCompleted",time];
	if ([vehicle _this,1000] call horde_fnc_playerIsNear) then {
		private _target = _this findNearestEnemy _this;
		if (isNull _target) then {
			{
				if ((_x select 2) in [east,west]
					and {_this knowsAbout (_x select 4) >= 1}
				) then {
					if (isNull _target) then {
						_target = _x select 4
					} else {
						if (_this distance (_x select 0) < _this distance _target) then {
							_target = _x select 4;
						};
					};
				};
			} count (_this nearTargets 1000);
		};
		if not (isNull _target) then {
			[_grp,getPosATL _target,0,0] call horde_fnc_setRenegadeCarWPs;
		} else {
			private _searchPos = [];
			scopeName "1";
			{
				if (_x select 1 != 0) then {
					if not (surfaceIsWater (_x select 0)) then {
						_searchPos = _x select 0;
						_searchPos set [2,0];
						breakTo "1"
					};
				};
				true
			} count (selectBestPlaces [
				(getPosWorld vehicle _this) getPos [500,random 359],
				200,
				"meadow + houses - sea - forest",
				100,
				5
			]);
			if (_searchPos isEqualTo []) then {
				(_grp getVariable "searchData") call horde_fnc_setRenegadeCarWPs
			} else {
				[_grp,_searchPos,0,0] call horde_fnc_setRenegadeCarWPs;
			};
		};
	} else {
		private _veh = vehicle _this;
		if (not isNull _veh) then {
			deleteVehicle _veh
		};
		_grp call horde_fnc_cacheGroup
	};
};

true