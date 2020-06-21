#include "\nocebo\defines\scriptDefines.hpp"

private _grp = group _this;
if (time > 1 + (_grp getVariable ["timeCompleted",0])) then {
	_grp setVariable ["timeCompleted",time];
	if ([vehicle _this,1000] call horde_fnc_playerIsNear) then {
		private _target = _this findNearestEnemy _this;
		if (isNull _target) then {
			{
				/*if ((_x select 2) in [west,east]) then {*/
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
			// find current closest waypoint to target
			private _currentPos = getPos vehicle _this;
			for "_i" from 1 to 4 do {
				private _wPos = waypointPosition [_grp,_i];
				if (_wPos distance _target < _currentPos distance _target) then {
					_currentPos = _wPos
				};
			};
			[_grp,_currentPos,0,300] call horde_fnc_setRenegadeBoatWPs;
		} else {
			private _searchData = + (_grp getVariable "searchData");
			_searchData set [1,waypointPosition [_grp,4]];
			_searchData call horde_fnc_setRenegadeBoatWPs;
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