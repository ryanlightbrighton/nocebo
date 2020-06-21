#include "\nocebo\defines\scriptDefines.hpp"

// used with (ncb_param_weatherSystemSelect == 1)

_fncWind = {
	private _maxWind = 20; // 10 m/s
	// random chance of strong winds
	_rand = random 1;
	call {
		if (_rand < 0.5) exitWith {
			_maxWind = 6; // 3 m/s
		};
		if (_rand < 0.75) exitWith {
			_maxWind = 14; // 7 m/s
		};
	};
	_maxWind
};

call {
	if (_this isEqualTo 0) exitWith {
		// "Clear"
		private _maxWind = 666 call _fncWind;
		private _windX = (random _maxWind) - (0.5 * _maxWind);
		private _windY = (random _maxWind) - (0.5 * _maxWind);
		ncb_gv_intendedWeather = [
			0, // fog
			random 0.3, // overcast
			0, // rain
			[_windX,_windY,true], // wind
			(abs (_windX * _windY)) * 0.01, // waves
			date
		];
	};
	if (_this isEqualTo 1) exitWith {
		// "Cloudy"
		private _maxWind = 666 call _fncWind;
		private _windX = (random _maxWind) - (0.5 * _maxWind);
		private _windY = (random _maxWind) - (0.5 * _maxWind);
		ncb_gv_intendedWeather = [
			0, // fog
			0.6 + (random 0.4), // overcast
			0, // rain
			[_windX,_windY,true], // wind
			(abs (_windX * _windY)) * 0.01, // waves
			date
		];
	};
	if (_this isEqualTo 2) exitWith {
		// "Foggy"
		private _maxWind = 2;
		private _windX = (random _maxWind) - (0.5 * _maxWind);
		private _windY = (random _maxWind) - (0.5 * _maxWind);
		ncb_gv_intendedWeather = [
			0.2 + (random 0.5), // fog
			random 1, // overcast
			0, // rain
			[_windX,_windY,true], // wind
			(abs (_windX * _windY)) * 0.01, // waves
			date
		];
	};
	if (_this isEqualTo 3) exitWith {
		// "Rain"
		private _maxWind = 666 call _fncWind;
		private _windX = (random _maxWind) - (0.5 * _maxWind);
		private _windY = (random _maxWind) - (0.5 * _maxWind);
		_numb = random 0.3;
		ncb_gv_intendedWeather = [
			_numb, // fog
			0.7 + (random 0.3), // overcast
			0.7 + _numb, // rain
			[_windX,_windY,true], // wind
			(abs (_windX * _windY)) * 0.01, // waves
			date
		];
	};
};

if (ncb_gv_intendedWeather select 1 > 0.85) then {
	[
		[round time + 60,false],{
			call horde_fnc_getEachFrameArgs params ["_timeout","_activated"];
			if (_timeout > time) then {
				if (overcast > 0.85) then {
					_activated = true;
					private _dir = random 359;

					private _cand = if ([] isEqualTo playableUnits) then {[0,0,0]} else {
						(selectRandom playableUnits) getPos [randInteg(50,1000),random 359]
					};
					private _delay = (random 0.1) max 0.01;
					private _brightness = random 100;
					private _class = selectRandom ["lightning1_F","lightning2_F"];
					private _repeats = randInteg(1,5);
					private _bolt = spawnVeh("LightningBolt",_cand);
					_bolt setPosATL _cand;
					_bolt setDamage 1;

					// send to all players (less hassle tham iterating through to work out who's close etc)

					[_cand,_delay,_brightness,_dir,_class,_repeats] remoteExecCall [
					 	"horde_fnc_clientLightning",
						if (isDedicated) then {-2} else {0}
					];
					if (random 1 >= 0.02) then {
						[time + ((random 20) max 5),_activated] call horde_fnc_updateEachFrameArgs
					} else {
						call horde_fnc_removeEachFrame
					};
				} else {
					if (_activated) then {
						call horde_fnc_removeEachFrame
					}
				}
			}
		},
		1
	] call horde_fnc_addEachFrame;

};

true