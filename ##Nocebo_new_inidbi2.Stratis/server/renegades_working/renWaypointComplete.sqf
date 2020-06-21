#include "\nocebo\defines\scriptDefines.hpp"

private _grp = group _this;
if (time > 1 + (_grp getVariable ["timeCompleted",0])) then {
	_grp setVariable ["timeCompleted",time];
	if playerIsNear(_this,1000) then {
		private _target = _this findNearestEnemy _this;
		if (isNull _target
			or {_target isKindOf "air"}
		) then {
			_target = objNull;
			{
				if ((_x select 2) in [east,west]
					and {_this knowsAbout (_x select 4) >= 1}
				) then {
					if (_this distance (_x select 0) < _this distance _target) then {
						if not ((_x select 4) isKindOf "air") then {
							_target = _x select 4;
						};
					};
				};
			} count (_this nearTargets 700);
		};
		if not (isNull _target) then {
			private _pos = getPosATL _target;
			private _building = (ATLtoASL _pos) call horde_fnc_isPosInEnterableBuilding;
			if not (isNull _building) then {
				private _buildingPositions = _building buildingPos -1;
				if not empty(_buildingPositions) then {
					for "_i" from 1 to 5 do {
						[_grp,_i] setWaypointPosition [selectRandom _buildingPositions,0];
						[_grp,_i] setWaypointCompletionRadius 2;
					};

				} else {
					private _waypointPositions = [_pos,150] call horde_fnc_findRenWaypoints;
					if ([] isEqualTo _waypointPositions) then {
						for "_i" from 1 to 5 do {
							_wp = [_grp,_i];
							_wp setWaypointPosition [_pos,0];
							_wp setWaypointCompletionRadius 50;
						};
					} else {
						for "_i" from 1 to 5 do {
							_wp = [_grp,_i];
							_wp setWaypointPosition [_waypointPositions select (_i - 1) % (count _waypointPositions),0];
							_wp setWaypointCompletionRadius 50;
						};
					};
				};
			} else {
				private _waypointPositions = [_pos,150] call horde_fnc_findRenWaypoints;
				for "_i" from 1 to 5 do {
					_wp = [_grp,_i];
					_wp setWaypointPosition [_waypointPositions select (_i - 1) % (count _waypointPositions),0];
					_wp setWaypointCompletionRadius 50;
				};
			};
		} else {
			private _waypointPositions = [_this,700] call horde_fnc_findRenWaypoints;
			for "_i" from 1 to 5 do {
				_wp = [_grp,_i];
				_wp setWaypointPosition [_waypointPositions select (_i - 1) % (count _waypointPositions),0];
				_wp setWaypointCompletionRadius 100;
			};
		};
		_grp setCurrentWaypoint [_grp,1];
	} else {
		_grp call horde_fnc_cacheGroup
	};
};

true
