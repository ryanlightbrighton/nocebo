#include "\nocebo\defines\scriptDefines.hpp"
/*
	example:
	[
		ASLtoAGL getPosWorld player vectorAdd [0,0,1],
		["ncb_grenadeExp","ncb_grenadeSmoke1"],
		[[[0,0,0],10,[1,0.6,0.4],10000,[true,1,800],[0,0,0,2.2,500,1000],true]],
		1
	] call horde_fnc_timedParticleEffects;
*/

params ["_pos","_particles","_lights","_duration"];
private _arr = [];
{
	private _fx = "#particlesource" createVehicleLocal _pos;
	_arr pushBack _fx;
	_fx setParticleClass _x;
} count _particles;
{
	_x params ["_ambient","_bright","_color","_intensity","_flareData","_attenuation","_day"];
	_flareData params ["_flare","_size","_dist"];
	_light = "#lightpoint" createVehicleLocal _pos;
	_arr pushBack _light;
	_light setLightAmbient _ambient;
	_light setLightBrightness _bright;
	_light setLightColor _color;
	_light setLightIntensity _intensity;
	_light setLightUseFlare _flare;
	if (_flare) then {
		_light setLightFlareSize _size;
		_light setLightFlareMaxDistance _dist;
	};
	_light setLightAttenuation _attenuation;
	_light setLightDayLight _day;
} count _lights;
[
	[_arr],{
		call horde_fnc_getEachFrameArgs params ["_effects"];
		{
			deleteVehicle _x
		} count _effects;
		call horde_fnc_removeEachFrame
	},
	_duration
] call horde_fnc_addEachFrame;
true