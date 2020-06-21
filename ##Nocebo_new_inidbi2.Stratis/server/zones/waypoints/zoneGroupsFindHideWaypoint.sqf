#include "\nocebo\defines\scriptDefines.hpp"

params ["_validGroups","_zonePosATL","_coverPlaceDataArr","_hideCenter","_hideNear"];

{
	if not (isNull _x) then {
		private _grp = _x;
		if not (_grp call horde_fnc_isGroupAdvancing) then {
			private _leader = leader _grp;
			private _leaderPosATL = getPosATL _leader;
			getVar(_grp,"groupData") params ["_groupType","_groupVehicle","_scanDist","_threatIndex","_coverDist"];

			private _destPos = _leaderPosATL;
			private _boardVehicle = false;
			if (_coverDist > -1) then {
				if (_hideCenter) then {
					private _dir = _leaderPosATL getDir _zonePosATL;

					private _withdrawPos = _leader getRelPos [_coverDist,_dir];

					private _ret = [
						_withdrawPos,
						_coverDist,
						_coverPlaceDataArr
					] call horde_fnc_squadFindCover;

					if not empty(_ret) then {
						_destPos = sel(_ret,0);
					};
				};
				if (_hideNear and {same(_destPos,_leaderPosATL)}) then {
					if (not empty(_coverPlaceDataArr)) then {
						// NOTE: THERE IS COVER IN ZONE (CHECK NEAREST COVER THEN WITHIN 3 X COVERDIST)
						scopeName "indent_5";
						{
							private _ret = [
								_leaderPosATL,
								_x,
								_coverPlaceDataArr
							] call horde_fnc_squadFindCover;
							if not empty(_ret) then {
								_destPos = sel(_ret,0);
								if ((_grp call horde_fnc_currWpPos) distance _destPos > 30) exitWith {
									breakTo "indent_5";
								};
							};
							true
						} count [_coverDist,3*_coverDist];
					};
				};
				_destPos resize 2;
				[_grp,_destPos] call horde_fnc_setHoldWp;
			};
		};
	};
	true
} count _validGroups;

true