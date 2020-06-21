#include "\nocebo\defines\scriptDefines.hpp"

params ["_bird","_ascendPos","_destinationPos","_roostPos","_flockDiameter"];

private _randDist = random _flockDiameter;
private _randDir = random 360;
private _wp = [
	sel(_ascendPos,0) + _randDist * sin _randDir,
	sel(_ascendPos,1) + _randDist * cos _randDir,
	sel(_ascendPos,2) - 7 + (random 14)
];

_bird camsetpos _wp;
_bird camcommit (_bird distance _wp);
_this set [0,""];

[
	[_bird,_this],{
		call horde_fnc_getEachFrameArgs params ["_bird","_arr"];
		/*execute after 1 sec*/
		if (speed _bird < 1) then {
			_arr params ["","","_destinationPos","_roostPos","_flockDiameter"];
			private _randDist = random _flockDiameter;
			private _randDir = random 360;
			private _wp = [
				sel(_destinationPos,0) + _randDist * sin _randDir,
				sel(_destinationPos,1) + _randDist * cos _randDir,
				sel(_destinationPos,2) - 4 + (random 8)
			];
			_bird camSetPos _wp;
			_bird camCommit (_bird distance _wp);

			[
				{
					call horde_fnc_getEachFrameArgs params ["_bird","_arr"];
					/*execute after 5 secs*/
					if (speed _bird < 1) then {
						_arr params ["","","","_roostPos",""];
						private _randDist = random 3;
						private _randDir = random 360;
						private _wp = [
							sel(_roostPos,0) + _randDist * sin _randDir,
							sel(_roostPos,1) + _randDist * cos _randDir,
							sel(_roostPos,2)
						];
						_bird camSetPos _wp;
						_bird camCommit (_bird distance _wp);
						[
							{
								call horde_fnc_getEachFrameArgs params ["_bird"];
								/*execute after 3 secs*/
								if (speed _bird < 0.5) then {
									deleteVehicle _bird;
									call horde_fnc_removeEachFrame
								}
							},
							3
						] call horde_fnc_updateEachFrameData
					}
				},
				5
			] call horde_fnc_updateEachFrameData
		}
	},
	1
] call horde_fnc_addEachFrame;

true




