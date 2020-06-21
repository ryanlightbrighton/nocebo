#include "\nocebo\defines\scriptDefines.hpp"

/*
	Author: BIS

	Description:
	Earthquake simulation - camera shake and sound

	Usage:
	[selectRandom [1,2,3,4],duration] call horde_fnc_earthquake

	Returns:
	earthquake duration

*/

params ["_magnitude","_duration"];

private _power = 0.3;
private _frequency = 100;
private _offset = 1;
private _eqsound = "Earthquake_01";
private _compensation = 0;
private _fatigue = 0.2;

private _fatigueDefault = getFatigue player;

call {
	if (_magnitude == 1) exitWith {
		_power = 0.5;
		_compensation = 4;
		_frequency = 200;
		_eqsound = "Earthquake_01";
		_fatigue = 0.4;
	};
	if (_magnitude == 2) exitWith {
		_power = 0.8;
		_compensation = 8.5;
		_frequency = 50;
		_eqsound = "Earthquake_02";
		_fatigue = 0.6;
	};
	if (_magnitude == 3) exitWith {
		_power = 1.5;
		_compensation = 7;
		_frequency = 40;
		_eqsound = "Earthquake_03";
		_fatigue = 0.8;
	};
	if (_magnitude == 4) exitWith {
		_power = 2.1;
		_compensation = 6;
		_frequency = 30;
		_eqsound = "Earthquake_04";
		_fatigue = 1;
	};
	[ "EarthQuake: number not defined, using default shake" ] call BIS_fnc_Log;
};
enableCamShake true;
playsound _eqsound;
"DynamicBlur" ppEffectEnable true;
"DynamicBlur" ppEffectAdjust [_power/2];
"DynamicBlur" ppEffectCommit _offset;

[
	[_duration,_compensation,_fatigue,_power,_frequency,_fatigueDefault],{
		call horde_fnc_getEachFrameArgs params ["_duration","_compensation","_fatigue","_power","_frequency","_fatigueDefault"];
		"DynamicBlur" ppEffectAdjust [0];
		"DynamicBlur" ppEffectCommit (_duration - _compensation);
		player setFatigue _fatigue;
		addCamShake [_power, _duration, _frequency];
		[
			[_fatigueDefault],{
				call horde_fnc_getEachFrameArgs params ["_fatigueDefault"];
				player setFatigue _fatigueDefault;
				call horde_fnc_removeEachFrame
			},
			_duration - _compensation
		] call horde_fnc_updateEachFrame;
	},
	_offset
] call horde_fnc_addEachFrame;

_duration




