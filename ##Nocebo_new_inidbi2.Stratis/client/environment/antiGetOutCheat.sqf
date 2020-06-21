#include "\nocebo\defines\scriptDefines.hpp"

params ["_veh","_unit"];

[
	[_veh,_unit],{
		call horde_fnc_getEachFrameArgs params ["_veh","_unit"];
		if (_veh != _unit) then {
			private _eyePos = eyePos _unit;
			private _testPosASL = +_eyePos;
			_testPosASL set [2,(_eyePos select 2) + 10];
			private _obs = lineIntersectsWith [_eyePos,_testPosASL];
			if ({if (_x isKindOf "House") exitWith {1}} count _obs isEqualTo 1) then {
				private _dir = _veh getDir _unit;
				_dir = (_dir + 180) % 360;
				_dir = abs _dir;
				private _dist = _veh distance _unit;
				private _pos = _veh getRelPos [_dist,_dir];
				_unit setDir _dir;
				_unit setPosATL _pos;
			};
			call horde_fnc_removeEachFrame
		}
	},
	0
] call horde_fnc_addEachFrame;

true