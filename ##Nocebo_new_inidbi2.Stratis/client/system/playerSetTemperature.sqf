#include "\nocebo\defines\scriptDefines.hpp"


/*
	consider:
	in water
	what you are wearing
	day/night
	in the shade if day
	weight of inventory
	stance
	running/walking/stationary
	in a vehicle (covered)
*/

// range
/*

	*********** HOT ***********

	44 °C or more – Almost certainly death will occur; however, people have been known to survive up to 46.5 °C (115.7 °F).
	43 °C – Normally death, or there may be serious brain damage, continuous convulsions and shock. Cardio-respiratory collapse will likely occur.
	42 °C – Subject may turn pale or remain flushed and red. They may become comatose, be in severe delirium, vomiting, and convulsions can occur. Blood pressure may be high or low and heart rate will be very fast.
	41 °C – (Medical emergency) – Fainting, vomiting, severe headache, dizziness, confusion, hallucinations, delirium and drowsiness can occur. There may also be palpitations and breathlessness.
	40 °C – Fainting, dehydration, weakness, vomiting, headache and dizziness may occur as well as profuse sweating. Starts to be life-threatening.
	39 °C – Severe sweating, flushed and red. Fast heart rate and breathlessness. There may be exhaustion accompanying this. Children and people with epilepsy may be very likely to get convulsions at this point.
	38 °C  – (this is classed as hyperthermia if not caused by a fever) Feeling hot, sweating, feeling thirsty, feeling very uncomfortable, slightly hungry. If this is caused by fever, there may also be chills.

	*********** NORMAL ***********

	37 °C – Normal internal body temperature (which varies between about 36.12–37.8 °C)

	*********** COLD ***********

	36 °C – Feeling cold, mild to moderate shivering (body temperature may drop this low during sleep). May be a normal body temperature.
	35 °C – (Hypothermia is less than 35 °C (95 °F)) – Intense shivering, numbness and bluish/grayness of the skin. There is the possibility of heart irritability.
	34 °C – Severe shivering, loss of movement of fingers, blueness and confusion. Some behavioural changes may take place.
	33 °C – Moderate to severe confusion, sleepiness, depressed reflexes, progressive loss of shivering, slow heart beat, shallow breathing. Shivering may stop. Subject may be unresponsive to certain stimuli.
	32 °C – (Medical emergency) Hallucinations, delirium, complete confusion, extreme sleepiness that is progressively becoming comatose. Shivering is absent (subject may even think they are hot). Reflex may be absent or very slight.
	31 °C – Comatose, very rarely conscious. No or slight reflexes. Very shallow breathing and slow heart rate. Possibility of serious heart rhythm problems.
	28 °C – Severe heart rhythm disturbances are likely and breathing may stop at any time. Patient may appear to be dead.
	24–26 °C or less – Death usually occurs due to irregular heart beat or respiratory arrest; however, some patients have been known to survive with body temperatures as low as 14.2 °C
*/

/*
	Map temps!

	configFile >> worldName >> "weather" >> ....

	temperatureDayMax[] = {10, 12, 15, 20, 25, 35, 35, 35, 25, 20, 10, 10};
	temperatureDayMin[] = {-10, -6, -5, -1, 5, 6, 7, 10, 5, 2, -5, -10};
	temperatureNightMax[] = {5, 6, 8, 10, 13, 18, 26, 25, 15, 13, 8, 4};
	temperatureNightMin[] = {-10, -10, -10, -5, 0, 4, 5, 6, 5, 0, -5, -10};
	overcastTemperatureFactor = 0.4;
	blackSurfaceTemperatureDelta = 5;
	whiteSurfaceTemperatureDelta = -2
*/

/*
	// sun angle

	_lat = -1 * getNumber(configFile >> "CfgWorlds" >> worldName >> "latitude"); //Arma latitude is negated for some odd reason.
	_day = 360 * (dateToNumber date); //Convert current day to 360 for trigonometric calculations.
	_hour = (daytime / 24) * 360; //Convert current hours to 360 for trigonometric calculations.
	sunangle = ((12 * cos(_day) - 78) * cos(_lat) * cos(_hour)) - (24 * sin(_lat) * cos(_day));
*/

/*
	// or mission

	// https://forums.bistudio.com/topic/188051-solar-and-climatological-functions/

	hintsilent (
		"\n\n\n\n" + ([] call llw_fnc_getDateTime)
		+ "\nSunrise hour: " + str ([] call llw_fnc_getSunrise select 0)
		+ "\nSunset hour: " + str ([] call llw_fnc_getSunrise select 1)
		+ "\nSolar azimuth: " + str ([] call llw_fnc_getSunAngle select 1)+"°"
		+ "\nSolar elevation: " + str ([] call llw_fnc_getSunAngle select 0)+"°"
		+ "\nElevation at noon: " + str ([] call llw_fnc_getSunElevationNoon)+"°"
		+ "\nSolar radiation: " + str ([player] call llw_fnc_getSunRadiation) + " W/m²"
		+ "\nAir: " + str ([] call llw_fnc_getTemperature select 0) +"°C"
		+ "\nSea: " + str ([] call llw_fnc_getTemperature select 1) +"°C"
		+ "\nPlayer in shadow: " + str ([player] call llw_fnc_inShadow)
		+ "\n\nTry fiddling with time, date, overcast, and fog."
	);
*/
playerTemp = 37;
tempTest = true;
while {tempTest
	and {not isNull player}
	and {alive player}
	and {lifeState player != "incapacitated"}
} do {
	/*
		consider:
		in water  >> player call horde_fnc_isUnitSwimming - COOLING
		what you are wearing
		day/night
		in the shade if day - COOLING
		running/walking/stationary - HEATING
		in a vehicle (covered) - HEATING
		are you near a fire? - HEATING
		Is it raining? - COOLING
		Is it windy? - COOLING
		Indoors - HEATING
	*/
	private _delta = 0;
	private _posWorld = getPosWorld player;
	private _overWater = surfaceIsWater _posWorld
	private _uniform = uniform player;
	private _isWetsuit = if (toLower _uniform find "wetsuit" > -1) then {true} else {false};
	private _vest = vest player;
	private _veh = objectParent player;
	private _attenuation = toLower getText (configFile >> "cfgvehicles" >> typeOf _veh >> "attenuationEffectType");
	private _openTopped = if (_attenuation find "open" > -1) then {
		if (_attenuation find "semi" > -1) then {
			1
		} else {
			2
		}
	} else {
		0
	}; // 0 = enclosed, 1 = partially enclosed, 2 = open topped
	private _velocity = vectorMagnitude velocity player;
	private _swimming = player call horde_fnc_isUnitSwimming;
	private _rain = rain;
	private _wind = vectorMagnitude wind;
	private _inShelter = not ([] isEqualTo (lineIntersectsWith [eyePos player,eyePos player vectorAdd [0,0,10],player]));
	private _nearFire = {inflamed _x} count (nearestObjects [player, ["All"],3]) > 0;
	private _solarRadiation = [player] call llw_fnc_getSunRadiation max 0;
	[] call llw_fnc_getAirTemperature params ["_airTemp","_seaTemp"];
	private _factor = 0;
	if (isNull _veh) then {
		// on foot or swimming or falling
		call {
			if (_swimming and {_velocity > 2}) exitWith {
				// GET HOTTER
				_factor  = _factor + 1;
			};
			if (isTouchingGround and {_velocity > 5}) exitWith {
				// GET HOTTER
				_factor  = _factor + 1;
			};
			if (_velocity < 1) exitWith {
				// GET COLDER
				_factor  = _factor - 1;
			};
		};
		if (_swimming) then {
			if (_isWetsuit) then {
				// ok
			} else {
				// GET COLDER
				_factor  = _factor - 1;
			};
		} else {
			if (_isWetsuit) then {
				// GET HOTTER
				_factor  = _factor + 1;
			} else {
				// ok
			};

			if (_nearFire) then {
				// GET HOTTER
				_factor  = _factor + 1;
			};
			if (_rain > 0.5 and {not _inShelter}) then {
				// GET COLDER
				_factor  = _factor - 1;
			};
			if (_wind > 7 and {not _inShelter}) then {
				// GET COLDER
				_factor  = _factor - 1;
			};
			_solarRadiation = _solarRadiation * 0.001; // GET HOTTER (already accounts for shade)

			_airTemp; // << HMM WHAT TO DO WITH THIS??
		};
	} else {
		// in vehicle (check if open topped)
	};
	sleep 10;
};

true