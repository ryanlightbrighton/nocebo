#include "\nocebo\defines\scriptDefines.hpp"

_this = missionNameSpace getVariable [_this,objNull];
if (alive _this and {simulationEnabled _this}) then {
	private _grp = group _this;
	if (_this isEqualTo leader _grp) then {
		// targets
		private _target = _this findNearestEnemy _this;
		if (not isNull _target) then {
			private _tgtInfo = (_this nearTargets ((_this distance _target) + 50)) select {(_x select 4) == _target};
			if not ([] isEqualTo _tgtInfo) then {
				_target = [_target,_tgtInfo select 0 select 5,_this knowsabout _target]
			};
		} else {
			_target = "NONE"
		};
		call compile format [
			"drawIcon3D ['a3\ui_f\data\gui\Rsc\RscDisplayArsenal\radio_ca.paa', [0,0,0,1], %1 modelToWorldVisual (%1 selectionPosition 'head'), 0, 0, 0, '%2 %3 WP: %4 TYP: %5 TGT: %6', 1, 0.04, 'RobotoCondensed']",
			_this,
			_grp,
			_grp getVariable ["groupData", ["N/A"]],
			currentWaypoint _grp,
			waypointType [_grp,currentWaypoint _grp],
			_target
		];
	};
} else {
	removeMissionEventHandler ["eachFrame",_thisEventHandler];
};