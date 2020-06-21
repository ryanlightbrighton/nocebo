#include "\nocebo\defines\scriptDefines.hpp"

params ["_cam","_tent"];

private _dist = 8;
private _tentPos = getPosATL _tent;
waitUntil {
	for "_i" from 10 to 360 step 10 do {
		if (isNull (findDisplay 12 displayCtrl 59502)) exitWith {};
		private _worldPos = [
			sel(_tentPos,0) + _dist * sin _i,
			sel(_tentPos,1) + _dist * cos _i,
			sel(_tentPos,2) + 2.5
		];
		_cam camSetPos _worldPos;
		_cam camSetTarget _tentPos;
		if (sunOrMoon < 0.15) then {
			camUseNVG true;
		} else {
			camUseNVG false;
		};
		private _wait = 0.5;
		_cam camCommit _wait;
		sleep _wait;
	};
	isNull (findDisplay 12 displayCtrl 59502)
};