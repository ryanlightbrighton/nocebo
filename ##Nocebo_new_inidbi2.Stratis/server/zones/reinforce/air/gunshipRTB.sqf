#include "\nocebo\defines\scriptDefines.hpp"

[
	[_this],{
		call horde_fnc_getEachFrameArgs params ["_grp"];
		if (not isNull _grp
			and {{if (alive _x) exitWith {1}} count units _grp > 0}
		) then {
			_grp setCurrentWaypoint [_grp,8]
		};
		call horde_fnc_removeEachFrame
	},
	ncb_param_gunshipPatrolTimerBase + random ncb_param_gunshipPatrolTimerVariance
] call horde_fnc_addEachFrame;

true
