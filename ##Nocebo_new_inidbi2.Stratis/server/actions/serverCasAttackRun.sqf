#include "\nocebo\defines\scriptDefines.hpp"

params ["_pos","_dir","_planeClass","_weaponTypesID"];

private _planeCfg = configfile >> "cfgvehicles" >> _planeClass;

//--- Detect gun
private _weaponTypes = switch _weaponTypesID do {
	case 0: {["machinegun"]};
	case 1: {["missilelauncher"]};
	case 2: {["machinegun","missilelauncher"]};
	case 3: {["bomblauncher"]};
	default {[]};
};
private _weapons = [];
{
	if (tolower ((_x call bis_fnc_itemType) select 1) in _weaponTypes) then {
		private _modes = getarray (configfile >> "cfgweapons" >> _x >> "modes");
		if (count _modes > 0) then {
			private _mode = _modes select 0;
			if (_mode == "this") then {
				_mode = _x
			};
			_weapons pushBack [_x,_mode]
		};
	};
} foreach (_planeClass call bis_fnc_weaponsEntityType);

private _targetPos = + _pos;


_pos set [2,(_pos select 2) + getterrainheightasl _pos];

private _dis = 3000;
private _alt = 1000;
private _pitch = atan (_alt / _dis);
private _speed = 400 / 3.6;
private _duration = ([0,0] distance [_dis,_alt]) / _speed;

//--- Create plane
private _planePos = [_pos,_dis,_dir + 180] call bis_fnc_relpos;
_planePos set [2,(_pos select 2) + _alt];
_planeSide = (getnumber (_planeCfg >> "side")) call bis_fnc_sideType;
private _planeArray = [_planePos,_dir,_planeClass,_planeSide] call bis_fnc_spawnVehicle;
private _plane = _planeArray select 0;
_plane setposasl _planePos;
_plane move ([_pos,_dis,_dir] call bis_fnc_relpos);
_plane disableai "move";
_plane disableai "target";
_plane disableai "autotarget";
_plane setcombatmode "blue";

/*_plane addEventHandler ["fired",{diag_log _this}];*/

/*if (_weaponTypesID == 3) then {
	// cluster
	{
		private _mags = _plane getCompatiblePylonMagazines _x;
		private _mag = "";
		call {
			if ("PylonMissile_1Rnd_BombCluster_01_F" in _mags) exitWith {
				_mag = "PylonMissile_1Rnd_BombCluster_01_F"
			};
			if ("PylonMissile_1Rnd_BombCluster_03_F" in _mags) exitWith {
				_mag = "PylonMissile_1Rnd_BombCluster_03_F"
			}
		};
		if (_mag != "") then {
			_plane setPylonLoadOut [_x,_mag,false,[]];
		};
	} forEach ("true" configClasses (
		configFile >> "CfgVehicles" >> _planeClass >> "Components" >> "TransportPylonsComponent" >>  "pylons"
	) apply {configName _x});
};*/

private _vectorDir = [_planePos,_pos] call bis_fnc_vectorFromXtoY;
private _velocity = [_vectorDir,_speed] call bis_fnc_vectorMultiply;
_plane setvectordir _vectorDir;
[_plane,-90 + atan (_dis / _alt),0] call bis_fnc_setpitchbank;
private _vectorUp = vectorup _plane;

//--- Remove all other weapons;

{
	if !(tolower ((_x call bis_fnc_itemType) select 1) in (_weaponTypes + ["countermeasureslauncher"])) then {
		_plane removeweapon _x;
	};
} foreach (weapons _plane);

//--- Approach
private _fire = [] spawn {waituntil {false}};
private _fireNull = true;
private _time = time;
private _offset = if ({_x == "missilelauncher"} count _weaponTypes > 0) then {20} else {0};
private _target = objNull;
waituntil {
	private _fireProgress = _plane getvariable ["fireProgress",0];

	//--- Set the plane approach vector
	_plane setVelocityTransformation [
		_planePos, [_pos select 0,_pos select 1,(_pos select 2) + _offset + _fireProgress * 12],
		_velocity, _velocity,
		_vectorDir,_vectorDir,
		_vectorUp, _vectorUp,
		(time - _time) / _duration
	];
	_plane setvelocity velocity _plane;

	//--- Fire!
	if ((getposasl _plane) distance _pos < 1000 && _fireNull) then {


		//--- Create laser target
		_target = ((_targetPos nearEntities ["LaserTarget",250])) param [0,objnull];
		if (isnull _target) then {
			_target = createvehicle ["LaserTargetW",_targetPos,[],0,"none"];
		};
		_plane reveal lasertarget _target;
		_plane dowatch lasertarget _target;
		_plane dotarget lasertarget _target;

		_fireNull = false;
		terminate _fire;
		_fire = [_plane,_weapons,_target,_weaponTypesID] spawn {
			params ["_plane","_weapons","_target","_weaponTypesID"];
			_planeDriver = driver _plane;
			_duration = 3;
			_time = time + _duration;
			_fired = 0;
			waituntil {
				{
					_planeDriver fireattarget [_target,(_x select 0)];
					/*[_plane,"BombCluster_01_F"] call bis_fnc_fire;*/
				} foreach _weapons;
				_fired = _fired + 1;
				_plane setvariable ["fireProgress",(1 - ((_time - time) / _duration)) max 0 min 1];
				sleep 0.1;
				time > _time || (_weaponTypesID == 3 and {_fired == 1}) || isnull _plane //--- Shoot only for specific period or only one bomb
			};
			sleep 1;
		};
	};

	sleep 0.01;
	scriptdone _fire  || isnull _plane
};
_plane setvelocity velocity _plane;
_plane flyinheight _alt;

//--- Fire CM
if ({_x == "bomblauncher"} count _weaponTypes == 0) then {
	for "_i" from 0 to 1 do {
		driver _plane forceweaponfire ["CMFlareLauncher","Burst"];
		private _time = time + 1.1;
		waituntil {time > _time || isnull _plane};
	};
};


waituntil {_plane distance _pos > _dis || !alive _plane};


//--- Delete plane
if (alive _plane) then {
	private _group = group _plane;
	private _crew = crew _plane;
	deletevehicle _plane;
	{deletevehicle _x} foreach _crew;
	deletegroup _group;
};
if (not isNull _target) then {
	deleteVehicle _target
};
