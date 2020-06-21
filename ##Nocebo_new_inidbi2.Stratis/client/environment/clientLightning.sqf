#include "\nocebo\defines\scriptDefines.hpp"

params ["_pos"];

private _light = "#lightpoint" createVehicleLocal _pos;
_light setposATL [
	sel(_pos,0),
	sel(_pos,1),
	sel(_pos,2) + 10
];
_light setLightDayLight true;
_light setLightBrightness 300;
_light setLightAmbient [0.05,0.05,0.1];
_light setLightColor [1,1,2];

[
	[_light,_this],{
		call horde_fnc_getEachFrameArgs params ["_light","_args"];
		_light setLightBrightness 0;
		[
			{
				call horde_fnc_getEachFrameArgs params ["_light","_args"];
				_args params ["_pos","_delay","_brightness","_dir","_class","_repeats"];
				_lightning = _class createVehicleLocal [100,100,100];
				_lightning setDir _dir;
				_lightning setPos _pos;
				[
					[_repeats,_light,_brightness,_lightning],
					{
						call horde_fnc_getEachFrameArgs params ["_repeats","_light","_brightness","_lightning"];
						_repeats = _repeats - 1;
						if (_repeats > 0) then {
							[_repeats,_light,_brightness,_lightning] call horde_fnc_updateEachFrameArgs;
							_light setLightBrightness (100 + _brightness);
						} else {
							deletevehicle _lightning;
							deletevehicle _light;
							call horde_fnc_removeEachFrame
						}
					},
					0.1
				] call horde_fnc_updateEachFrame;
			},
			_args select 1
		] call horde_fnc_updateEachFrameData;
	},
	0.1
] call horde_fnc_addEachFrame;

true