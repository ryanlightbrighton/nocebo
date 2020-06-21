SONS OF MIDAS

// STEAM WORKSHOP CACHE:  E:\Documents\Arma 3\Saved\steam
// ALSO: E:\Applications\Steam\userdata\47985158\ugc\referenced
// MODS C:\Games\Arma3\steamapps\workshop\content\107410\....

search filters:

// <open folders>,<open files>,-*/compressedFunctionsZ/*,-*scratchpad.sqf,-*compressFunctions.hpp



0 = 0 execFSM "server\zones\manager\zoneManager.fsm"

copyToClipBoard loadFile "misc\editorVehsInit.sqf"
copyToClipBoard loadFile "a3\functions_f_mp_mark\dynamicgroups\fn_dynamicgroups.sqf"
copyToClipBoard str BIS_fnc_dynamicGroups
copyToClipBoard preprocessFile "misc\editorVehsInit.sqf"
copyToClipBoard preprocessFileLineNumbers "misc\editorVehsInit.sqf"
copyToClipBoard preprocessFileLineNumbers "misc\editorVehsInit.sqf"
copyToClipBoard str horde_fnc_oldEmptyVehicleSpawn
copyToClipBoard str horde_fnc_masterLootManager
copyToClipBoard str horde_fnc_spawnAmphInsInflatable
copyToClipBoard str horde_fnc_checkReinforcements
copyToClipBoard str horde_fnc_spawnAtCoast
copyToClipBoard str horde_fnc_removeStackedEventHandler
copyToClipBoard str BIS_fnc_executeStackedEventHandler
copyToClipBoard str BIS_fnc_dynamicGroups

copyToClipBoard (preprocessFileLineNumbers "server\zones\manager\unitPoolManager.sqf" splitString toString [13,10] joinString " ")

_seeingUnits = [];
{
	if (p1 distance _x < 100) then {
		_seeingUnits pushBack _x;
		true
	};
} count [m1,m2,m3];
// 0.0143005 ms (return is either a bool or nothing)

{
	_x setDamage 1;
} forEach (player nearEntities ["SoldierEB",50])

diag_log format ["zone %1", _zone];
diag_log format ["max squads %1", _zone getVariable "zoneMaxSquadCount"];
diag_log format ["number of possible patrols %1", count _patrolLandASLData];
diag_log format ["number of staticweapondata %1", _staticWeaponData];
diag_log format ["Var does zone have static weapons %1", _zone getVariable "zoneHasStaticPositions"];

Protocol bin\config.bin/RadioProtocolPER/: Missing word obj_building

PLAYER DISCONNECTING ON DS LEAVES EMPTY GROUP! !!!

More bandages/medkits
more explosives
more scopes!
Player starts with wrench
Perhaps make tent personal - ie, you can only ever have one active.  At the moment, you can use multiple tents to teleport around the map.

 class Respawn_Sleeping_bag_F : Land_Sleeping_bag_F {
	author = "Bohemia Interactive";
	scope = 1;
	displayName = "Camp (Green Sleeping Bag)";
	faction = "Interactive_F";
	vehicleClass = "Respawn";
	respawnType = "inf";
	respawnNearbyPlayers = 0;
	DLC = "Curator";
	class Eventhandlers {
		init = "_this spawn bis_fnc_initRespawnBackpack;";
	};
	class assembleInfo {
		primary = 1;
		base = "";
		assembleTo = "";
		displayName = "";
		dissasembleTo[] = {"B_respawn_Sleeping_bag_F"};
	};
};

hmm, one tent each to respawn at but you can still respawn at friends tents (with no weapons)

or

as many tents as you like but you get no weapons when you spawn at a tent.  (Maybe skills are partially lost as well)..

With skills, maybe do something to decrease thirst/ food
decrease fatigue
and when spawning at coast or from tent, then it lowers those skills...

// NOTES   !!!!

Task setup needs reworking, plus also have min distance between bases (like 3km or similar)

at the moment, it just checks that another base isn't in the same zone.

Weather syncs a minute into mission...

ACE workaround overcast, so they only ever change rain and fog based on what the engine is doing

empty vehicles....

need some rules.

zone vehicles and empties don't need to be added to ABANDONED_ARRAY if they are still in the zone and it is active.
They are deleted on zone despawn (unless outside the zone)

Vehicle has "vehicleAssignedZone" to track which zone it belongs to



This should all be in the getout EH

Rules -



/*or just have it that if it's isPlayer then add it to array - don't add AI driven vehicles as they are accounted for already.


{alive _x} count units _grp == 0

({if (alive _x) exitWith {1}} count units _grp) isEqualTo 0
_isSomeone = ({isPlayer _x} count _list) > 0
_isSomeone = {if (isPlayer _x) exitWith {1}} count _list > 0

{player in _x} count _blocked isEqualTo 0

({if (player in _x) exitWith {1}} count _blocked) isEqualTo 0

{_finalPosATL distance _x < 1500} count (playableUnits + switchableUnits) == 0

({if (_x distance _finalPosATL < 1500) exitWith {1}} count (playableUnits + switchableUnits)) isEqualTo 0

{side _x == east or {side _x == independent}} count _nearEntities == 0

({if (side _x isEqualTo east or {side _x isEqualTo independent}) exitWith {1}} count (playableUnits + switchableUnits)) isEqualTo 0

{if (side _x isEqualTo east or {side _x isEqualTo independent}) exitWith {1}} count _friendlies isEqualTo 0

{
						(side _x isEqualTo east)
						or {(side _x isEqualTo independent)}
					} count _friendlies == 0

{_x distance _veh < 300} count (playableUnits + switchableUnits) == 0

{if (_x distance _veh < 300) exitWith {1}} count (playableUnits + switchableUnits) isEqualTo 0

{alive _x} count crew _veh isEqualTo 0

{if (alive _x) exitWith {1}} count crew _veh isEqualTo 0

{alive _x} count units _grp ==  0

{if (alive _x) exitWith {1}} count units _grp isEqualTo 0

{alive _x} count units _grp > 0


*/

OIL_SPILL_F  !!!

0 = [] spawn {
	_arr = [];
	while {true} do {
		_pos = player modelToWorld [((random 4) - 2),random 2,0];
		_pos set [2,0];
		_thing = createVehicle ["oil_spill_f",_pos,[],0,"can_collide"];
		_thing setDir random 360;
		_arr pushBack _thing;
		sleep 1;
		if (count _arr > 10) then {
			deleteVehicle (_arr deleteAt 0)
		};
	};
};

take triggers for vehicles!!!!!!!

/*{
	this addEventHandler [_x,format ["player sideChat format ['%1',%1]",_x]];
} forEach [
	"AnimChanged",
	"AnimDone",
	"AnimStateChanged",
	"ContainerClosed",
	"ContainerOpened",
	"ControlsShifted",
	"Dammaged",
	"Engine",
	"EpeContact",
	"EpeContactEnd",
	"EpeContactStart",
	"Explosion",
	"Fired",
	"FiredNear",
	"Fuel",
	"Gear",
	"GetIn",
	"GetOut",
	"HandleDamage",
	"HandleHeal",
	"HandleRating",
	"HandleScore",
	"Hit",
	"HitPart",
	"Init",
	"IncomingMissile",
	"InventoryClosed",
	"InventoryOpened",
	"Killed",
	"LandedTouchDown",
	"LandedStopped",
	"Local",
	"Put",
	"Respawn",
	"RopeAttach",
	"RopeBreak",
	"SoundPlayed",
	"Take",
	"WeaponAssembled",
	"WeaponDisassembled",
	"WeaponDeployed",
	"WeaponRested"
];*/

/*options:

keep them as one big squad and cache/uncache as needed

Tie in to the zones spawning.

or don't spawn a group and spawn as part of "static" when spawning zones*/

0 = 0 spawn {
	{
		_zone = _x;
		player attachTo [_zone,[0,0,300]];
		sleep 20;
	} forEach  = ncb_gv_zoneList;
};

arr1 = [];

{if(isNil "_x" or {not isNil "_x"}) exitWith {1}} count arr1 isEqualTo 0

0.00419922 ms (empty arr)

0.00830078 ms (big arr)

arr1 isEqualTo []

0.00430298 ms (empty arr)

0.00390015 ms (big arr)



player sideChat format ["is array empty: %1", {if(isNil "_x" or {not isNil "_x"}) exitWith {1}} count arr1 isEqualTo 0];



W E A T H E R

https://community.bistudio.com/wiki/overcastForecast
https://community.bistudio.com/wiki/nextWeatherChange
Number = nextWeatherChange
Number = overcastForecast
Number = fogForecast
0 = 0 spawn {
	while {true} do {
		hintSilent format [
			"
				time: %1 sec\n
				time: %2 min\n
				overcast: %3\n
				fog: %4\n
				\n
				next change: %5 sec\n
				next change: %6 min\n
				oc forecast: %7\n
				fog forecast: %8\n
			",
			time,
			time / 60,
			overcast,
			fog,
			nextWeatherChange,
			nextWeatherChange / 60,
			overcastForecast,
			fogForecast
		];
		sleep 2;
	};
};

_this call (
	uinamespace getvariable (gettext (configFile >> "CfgAmmo" >> (_this select 4) >> "muzzleEffect"))
);

Things to check out:

respawn rate
radios!


SQF

Shared group stuff

start positions.....
start game as diver/skydiver?? Maybe override the login par of FSM and treat as
in game start
also, poss option to spawn at random/closest/closest to group (if group is more than just one player)

rewrite garbage to be nicer*/

{
	_place = getPos _x;
	_mkr = createMarker [str _x,_place];
	_mkr setMarkerSize [50,50];
	_mkr setMarkerShape "Ellipse";
	_mkr setMarkerBrush "SolidBorder";
	_mkr setMarkerColor "ColorRed";
	_mkr setMarkerAlpha 0.3;
} forEach allMissionObjects "Wreck_base_F";

Heli wrecks need better resources maybe..  (bodged to give just ammo for the moment - need to set up the fuel and work out large ones)

// _class = "Horde_Ammo_Box_m";

SPawn multiple rens??


// test handing over to HC (waited until all groups are spawned before iterating through them.

// check HC is connected

_HeadlessCs = entities "HeadlessClient_F";

if not (_headlessCs isEqualTo []) then {
	_HC = _headlessCs select floor random count _headlessCs;
	if (_HC getVariable ["HC_rEADY",false]) then {
		// palm all the ai groups off onto it
		{
			if ((_x getVariable "groupData") select 0 != "static") then {
				_result = _x setGroupOwner (owner _HC);
				diag_log format ["group locality changed: %1 %2",_x, _result];
			};
		} forEach _groups;
	};
};

// ICE9's color corrections
// http://forums.bistudio.com/showthread.php?187037-Color-Corrections-(Medit-Afghan)&p=2855458#post2855458


// TEST SPAWNED SCRIPT - DELETE AS SOON AS GOOD (OR PROVED BAD)

// include as part of player monitor or another existing loop client-side
/*[] spawn {
	 = ncb_mediterraneanColor = ppEffectCreate ["colorCorrections", 2015];
	 = ncb_mediterraneanColor ppEffectEnable true;
	waitUntil {
		_value = linearConversion [0,1,sunOrMoon,0.05,-0.2,true];
		 = ncb_mediterraneanColor ppEffectAdjust [
			1.04,
			1.04,
			_value,
			[0.2, 0.29, 0.4, -0.22],
			[1, 1, 1, 1.3],
			[0.45, 0.09, 0.09, 0.0]
		];
		 = ncb_mediterraneanColor ppEffectCommit 59;
		sleep 60;
		false
	};
};*/

// EXPERIMENT WITH INVENTORY

/*playMusic "Soundtrack_3";
addMusicEventHandler ["MusicStop", {
	_oldTrack = sel(_this,0);
	_chars = _oldTrack select [11,2];
	_oldNumb = parseNumber _chars;
	_numb = _oldNumb + 1;
	if (_oldNumb == 34) then {
		_numb = 3;
	};
	_newTrack = "Soundtrack_" + str _numb;
	playMusic _newTrack;
}];*/

weapons box at radio stations and artillery places!!!

need a flexible fillbox script

(input some classes or config path and approx qty and let it do its stuff)
maybe base it on the loot config like the aircarte one.

Radio Station Gunners rotation worked on when drunk!


scopeName "root";
for "_i" from 0 to count (configFile / "CfgZones" / worldName) - 1 do {
	_zoneName = configName ((configFile / "CfgZones" / worldName) select _i);
	diag_log format ["%1", _zoneName];
	_arr = getArray (configfile / "CfgZones" / worldName / _zoneName / "Objects" / "O_iNDUSTRIAL_pIPE");
	{
		diag_log format ["%1", _x];
		if (_x select 1 == "Land_indPipe2_big_ground1_F") then {
			player setPosASL (_x select 2);
			breakTo "root"
		};
	} count _arr;
};




scopeName "root";
for "_i" from 0 to count (configFile / "CfgZones" / worldName) - 1 do {
	_zoneName = configName ((configFile / "CfgZones" / worldName) select _i);
	diag_log format ["%1", _zoneName];
	_arr = getArray (configfile / "CfgZones" / worldName / _zoneName / "Objects" / "O_iNDUSTRIAL_pIPE");
	{
		diag_log format ["%1", _x];
		if (_x select 1 == "Land_indPipe2_big_18ladder_F") then {
			player setPosASL (_x select 2);
			breakTo "root"
		};
	} count _arr;
};

0 = 0 spawn {
	while {true} do {
		player sideChat format ["%1", linearConversion [
			 = ncb_gv_spawnMinFps,
			 = ncb_gv_spawnMaxFps,
			diag_fps,
			 = ncb_gv_spawnMaxDelay,
			 = ncb_gv_spawnMinDelay,
			true
		]];
		sleep 0.5;
	};
}

0 = 0 spawn {
	while {true} do {
		diag_log format ["bloke %1, supp %2",cursorTarget,getSuppression cursorTarget];
		sleep 0.5;
	};
}

/*

numb1 = 1;
diag_log "ACTIVE SQF";
{
	diag_log format ["%1 - %2",numb1, _x];
	numb1 = numb1 + 1
} forEach diag_activeSQFScripts;



diag_log "ACTIVE FSM";
numb2 = 1;
{
	diag_log format ["%1 - %2",numb2, _x];
	numb2 = numb2 + 1
} forEach diag_activeMissionFSMs;


*/

http://forums.bistudio.com/showthread.php?168240-Fatigue-Feedback-(dev-branch)&p=2770238&viewfull=1#post2770238

onEachFrame {
	_regPerSec = 0.015;
	_bodyWeight = 80;
	_vel = velocity player;
	_up = _vel select 2;
	_vel set [2,0];
	_k = switch (stance player) do {
		case "CROUCH" : {0.5};
		case "PRONE" : {2.5};
		case "STAND" : {0.25};
	};
	_time = diag_tickTime - (player getVariable ["lastCheck", diag_tickTime]);
	_expPerSec = if (vehicle player != player) then [
		{0},
		{linearConversion [0, 100, (loadAbs player / 10 + _bodyWeight) * ((vectorMagnitude _vel + _up) ^ 2) / 2, 0, 0.01, false] * _k}
	];
	_fatigue = 0 max ((player getVariable ["fatigue", 0]) + _time * (_expPerSec - _regPerSec)) min 1;
	player setVariable ["fatigue", _fatigue];
	player setVariable ["lastCheck", diag_tickTime];
	player setFatigue _fatigue;
	hintSilent str _fatigue;
};

0.00889893 ms

0.00629883 ms


swap choppers back to Lynx

Need more waypoints around mil bases

"NameCityCapital",
"CityCenter",
"NameCity",
"NameVillage",
"NameLocal",
"NameMarine",
"Hill"

Need to change over loot to number based modifier

Maybe more than 1 mag per gun again....


horde_fnc_findMilWaypointCenters = {
	// feed in zone pos ASL
	_posArr = [];
	{
		/*diag_log format ["name %1 text %2", name _x,text _x]*/
		if (text _x == "military") then {
			_pos = locationPosition _x;
			_posArr pushBack _pos;
			testMarker(
				_x,
				_pos,
				"MILITARY LOC"
			);
		};
	} forEach nearestLocations [
		ASLtoATL _this, [
			"NameCityCapital",
			"CityCenter",
			"NameCity",
			"NameVillage",
			"NameLocal",
			"NameMarine",
			"Hill"
		],
		1000
	];
	// look for cargo towers / domes

	{
		// not near water
		if (0 isEqualTo (selectBestPlaces [getPosATL _x,300, "sea",50,1]) select 0 select 1) then {
			_posArr pushBack getPosATL _x
		};
	} forEach nearestObjects [ASLtoATL _this,["Land_dome_Big_F","Cargo_Tower_base_F"],1000];

	_posArr
};

{
	_loc = _x;
	diag_log format ["%1 %2", _x text _x];
} forEach nearestLocations [
	ASLtoATL _this, [
		"NameCityCapital",
		"CityCenter",
		"NameCity",
		"NameVillage",
		"NameLocal",
		"NameMarine",
		"Hill"
	],
	900
];

PAINKILLERS - EITHER GET RID TOTALLY (ON RENS) OR IMPLEMENT

AMMO BOXES CAN BE DESTROYED...

FATIGUE & LOAD

WEATHER - NEED SYSTEM THAT QUERIES SERVER CURRENT ON CLIENT CONNECT AND SERVER FORECAST

hintSilent parseText format [
	"<t size='1.8'color='#FFFFFF'align='center'shadow='2'>
	-- ENEMY --<br />
	Enemy groups: %1<br />
	Enemy units: %2<br />
	Dead units: %3<br />
	-- NEAR ZONE --<br />
	</t>",
	true,
	true,
	1
];

test_fnc2 = {
	player sideChat format ["end: %1", _this];
};

test_fnc1 = {
	private ["_value"];
	_value = [_this,"String2"];
	_value call test_fnc2
};

"String1" call test_fnc1;

"string1" call {[_this,"String2"] call {player sideChat format ["end: %1", _this]}}

{player reveal [_x,4]} forEach nearestObjects [player,[],10]; thing1 = cursorTarget; thing1 attachTo [car1, [-0.0625,-1.73438,0.3479]]

{if (alive _x and {not (_x isEqualTo _object)} and {isNil {_x getVariable "vehicleCargo"}} and {isClass (configFile / "CfgVehicles" / typeOf _object / "logistics")}) exitWith {1}} count (_object nearEntities [["LandVehicle","Air","Ship_F"],10]) isEqualTo 1

_veh = objNull;
_object = cursorTarget;
{
	if (not isNull _x
		and {alive _x}
		and {not (_x isEqualTo _object)}
		and {isNil {_x getVariable "vehicleCargo"}}
		and {isClass (configFile / "CfgVehicles" / typeOf _x / "logistics")}
		and {[getPosATL _x,((getDir _x) + 180) % 360,30,getPosATL _object] call BIS_fnc_inAngleSector}
	) exitWith {
		_veh = _x;
	}
} count (_object nearEntities [["LandVehicle","Air","Ship_F"],10]);

hintSilent format ["%1",_veh];

_inAngleSector = [getPosATL _x,((getDir _x) + 180) % 360,30,getPosATL _object] call BIS_fnc_inAngleSector;

class Logistics {
	class Config_1 {
		class slot_1 {
			choices[] = {
				{"Horde_Ammo_Box_m",{-0.0625,-1.73438,0.3479},{{1,0,0},{0,0,1}}},
				{"Horde_Ammo_Box_L",{-0.0625,-1.73438,0.3479},{{1,0,0},{0,0,1}}},
				{"Horde_Fuel_Supply_m",{-0.0234375,-1.73242,0.217911},{{1,0,0},{0,0,1}}},
				{"Horde_repair_parts_Box_m",{-0.0625,-1.73438,0.3479},{{1,0,0},{0,0,1}}}
			};
		};
		class slot_2 {
			choices[] = {
				{"Horde_Ammo_Box_m",{-0.0625,-1.73438,0.3479},{{1,0,0},{0,0,1}}},
				{"Horde_Ammo_Box_L",{-0.0625,-1.73438,0.3479},{{1,0,0},{0,0,1}}},
				{"Horde_Fuel_Supply_m",{-0.0234375,-1.73242,0.217911},{{1,0,0},{0,0,1}}},
				{"Horde_repair_parts_Box_m",{-0.0625,-1.73438,0.3479},{{1,0,0},{0,0,1}}}
			};
		};
	};
};

and {count getVarDef(_x"vehicleCargo",[]) < }

crate1
test_offroad_1
0 = 0 spawn {
	_moveToPos = [-0.0625,-1.73438,0.3479];
	for "_i" from 1 to 8 do {
		_modelPos = test_offroad_1 worldToModel (ASLtoATL getPosWorld crate1);
		_diff = _moveToPos vectorDiff _modelPos;
		_newDiff = _diff vectorMultiply 0.2;
		_newModPos = _modelPos vectorAdd _newDiff;
		crate1 attachTo [test_offroad_1,_newModPos];
		sleep 0.2;
	};
	crate1 attachTo [test_offroad_1,_moveToPos];
	sleep 3;
	detach crate1;
};
for "_i" from 1 to 5 do {
	test_offroad_1 lockCargo [_i,true];
};

box41 attachTo [car4,[0.02,-0.8,0.3]];
box42 attachTo [car4,[0.02,-2.4,0.3]];
box43 attachTo [car4,[0.02,-4,0.3]];

q41 attachTo [car4,[0.07,-0.95,0.9]];
q42 attachTo [car4,[0.07,-3.4,0.9]];


hintSilent format ["%1", test_offroad_1 getCargoIndex player]; for "_i" from 1 to 5 do {   test_offroad_1 lockCargo [_i,true];  };

add action to add remove cargo to vehicle (chassis)

add repair and cargo to boats however, this may affect the boat push script as that is a player action and not tied to the boat

also, this may affect the interaction script as I think it only works for helis and cars.  OK just checked it:

if (isClass (configFile / "CfgVehicles" / "myClass" / "interactionInfo")) then {
	// general
} else {
	// vehicle
};


0 = 0 spawn {
	crate1 attachTo [car1,[-0.0625,-1.73438,0.3479]];
	sleep 1;
	_worldPos = car1 modelToWorld [0,-7,0];
	_worldPos set [2,0];
	_moveToPos = car1 worldToModel _worldPos;
	for "_i" from 1 to 8 do {
		_modelPos = car1 worldToModel (ASLtoATL getPosWorld crate1);
		_diff = _moveToPos vectorDiff _modelPos;
		_newDiff = _diff vectorMultiply 0.2;
		_newModPos = _modelPos vectorAdd _newDiff;
		crate1 attachTo [car1,_newModPos];
		sleep 0.2;
	};
	sleep 2;
	detach crate1;
};

0 = 0 spawn {
	crate1 attachTo [car1,[-0.0625,-1.73438,0.3479]];
	sleep 1;
	_worldPos = car1 modelToWorld [0,-7,0];
	_worldPos set [2,0];
	_moveToPos = car1 worldToModel _worldPos;
	for "_i" from 1 to 8 do {
		_modelPos = car1 worldToModel (ASLtoATL getPosWorld crate1);
		_diff = _moveToPos vectorDiff _modelPos;
		_newDiff = _diff vectorMultiply 0.2;
		_newModPos = _modelPos vectorAdd _newDiff;
		crate1 attachTo [car1,_newModPos];
		sleep 0.2;
	};
	sleep 2;
	detach crate1;
};

0 = 0 spawn {
	crate1 attachTo [car1,[-0.0625,-1.73438,0.3479]];
	sleep 1;
	_worldPos = car1 modelToWorld [0,-7,0];
	_worldPos set [2,((ASLtoATL getPosWorld crate1) select 2) - ((getPos crate1) select 2)];
	_moveToPos = car1 worldToModel _worldPos;
	for "_i" from 1 to 8 do {
		_modelPos = car1 worldToModel (ASLtoATL getPosWorld crate1);
		_diff = _moveToPos vectorDiff _modelPos;
		_newDiff = _diff vectorMultiply 0.2;
		_newModPos = _modelPos vectorAdd _newDiff;
		crate1 attachTo [car1,_newModPos];
		sleep 0.2;
	};
	sleep 2;
	detach crate1;
};

http://forums.bistudio.com/showthread.php?191004-List-of-all-hidden-texture-inits&p=2952343&viewfull=1#post2952343

horde_fnc_cargoIndexes = {
	// get cargoindexes of vehicle
	// nothing = cursorTarget call horde_fnc_cargoIndexes;
	if (not isNull _this) then {
		_grp = createGroup west;
		while {
			_this emptyPositions "cargo" > 0
		} do {
			_man = _grp createUnit ["B_Soldier_F",getPos player,[],0,"none"];
			_man assignAsCargo _this;
			_man moveInCargo _this;
			_pos = getPos _man;
			_index = _this getCargoIndex _man;
			_handle = addMissionEventHandler ["Draw3D",compile format ["drawIcon3D ['', [1,0,1,1], %1, 0, 0, 0, '%2', 1, 0.03, 'PuristaMedium'];",_pos,_index]];
		};

		{
			deleteVehicle _x
		} forEach units _grp;
	};
};

horde_fnc_cargoIndexes = {
	if (not isNull _this) then {
		_grp = createGroup west;
		while {
			_this emptyPositions "cargo" > 0
		} do {
			_man = _grp createUnit ["B_Soldier_F",getPos player,[],0,"none"];
			_man assignAsCargo _this;
			_man moveInCargo _this;
			_pos = getPos _man;
			_index = _this getCargoIndex _man;
			_handle = addMissionEventHandler ["Draw3D",compile format ["drawIcon3D ['', [1,0,1,1], %1, 0, 0, 0, '%2', 1, 0.03, 'PuristaMedium'];",_pos,_index]];
		};

		{
			deleteVehicle _x
		} forEach units _grp;
		deleteGroup _grp;
	};
};
0 = cursorTarget call horde_fnc_cargoIndexes;

horde_fnc_cargoIndexes = {
	if (not isNull _this) then {
		_grp = createGroup west;
		while {
			_this emptyPositions "cargo" > 0
		} do {
			_man = _grp createUnit ["B_Soldier_F",getPos player,[],0,"none"];
			_man assignAsCargo _this;
			_man moveInCargo _this;
			_pos = getPos _man;
			_index = _this getCargoIndex _man;
			_handle = addMissionEventHandler ["Draw3D",compile format ["drawIcon3D ['', [1,0,1,1], %1, 0, 0, 0, '%2', 1, 0.03, 'PuristaMedium'];",_pos,_index]];
		};
	};
};
0 = cursorTarget call horde_fnc_cargoIndexes;

 3:27:31 Wrong text element '46'
 3:27:32 Wrong text element '46'
 3:27:54 Wrong text element '659'
 3:27:54 Wrong text element '659'
 3:29:28 Wrong text element '76'
 3:29:35 Wrong text element '486'
 3:30:20 Wrong text element 'JF132'

 This is from selecting the Weapon Mount on the Orca (engineer = [10,10];)

 // http://forums.bistudio.com/showthread.php?192793-need-guidance-in-regards-to-intro-presentation

 > turning speed is defined in actionset (manactions) and animation speed is definable per state
for those asking about that some day ago

WATER SUPPLY FOR PLAYERS IN WRECKED CHOPPERS??

player enableMimics true; player setFaceAnimation 4; player setmimic "angry";

if (isServer and {not isMultiplayer}) then {
   _grp = group this;
   deleteVehicle this;
   deleteGroup _grp
} else {
	this enableMimics true;
	this setFaceAnimation 1;
	this setmimic "angry";
}

this enableMimics true; this setFaceAnimation 1; this setmimic "angry";

_myoldbody = player;
_myOldGroup = group player;
_myoldbody hideObjectGlobal true;
_mynewbody = _myOldGroup createUnit["Horde_player_skill3",position player,[],0,"can_collide"];
addSwitchableUnit _mynewbody;
setPlayable _mynewbody;
selectPlayer _mynewbody;
deleteVehicle _myOldBody;






Also, got to think about client actions being interupted by disconnection and leaving things in an indeterminate state (like loading/unloading vehicles)

Also interaction with vehicles could get buggered up.  Workaround could be instead of this:

setVarPlc(_object,"vehiclePlayerInteracting",true);

do this:

setVarPlc(_object,"vehiclePlayerInteracting",player);

_variable = getVarDef(_object,"vehiclePlayerInteracting",objNull);

and then check if (isPlayer _variable) then {
	// actual player is working on this vehicle so run action
} else {
	// player has left/isNull so reset
	setVarPlc(_object,"vehiclePlayerInteracting",nil);
};

will also need to change horde_fnc_checkInteractionValid


DONE (for vehicles not and cargo but not meds)  :)

Actually, it might be sorted anyway for meds as they check for "isNull _object"



SHIT!  This also affects some of the callback medical stuff.
EG: The "spawnActionItems" script spawns some items but if player disconnects, they will not get cleared up.
Maybe put something in the disconnect mission eventHandler to clear them.  (Made objects local for now)






Will need to write safeguard there too...

{sel(getVar(_x,"generatorIsRunning"),1)} count (player nearEntities ["Land_portable_generator_F",10]])

if (({if sel(getVar(_x,"generatorIsRunning"),1) exitWith {1}} count (player nearEntities ["Land_portable_generator_F",6]])) isEqualTo 1) then {
	// there is a generator running nearby
};

{diag_log format ["%1", typeOf _x]} forEach (attachedObjects cursorTarget);

static guns not reloading
UAV gunners - is it laser beam?  If so, what could benefit from targetting the players?


put in code to add flies to corpses but it is not working properly yet (affects unitKilled, hideBody and garbage.fsm)
commented out for now

actionitems spawning through buildings. done.

Grenade launcher static weapons!!!

Hmm, added configs but i do not think the "horde_fnc_staticWeaponReload" and "horde_fnc_staticWeaponUnload" scripts are set up yet for mag >> hopper so it ejects and expects "96Rnd_40mm_G_Hopper"


Also, new idea.  Have optional <pacify the airport> mission where if you destroy/flick switch on the control towers then
the airport becomes neutral (delete the zones there to remove the spawning of troops).

this addEventHandler ["fired",{
	drop ["\A3\data_f\ParticleEffects\Universal\Refract","","Billboard",1,0.1,getPos _bullet,[0,0,0],0,1.275,1,0,[0.02*_caliber,0.01*_caliber],[[0,0,0,0.65],[0,0,0,0.2]],[1,0],0,0,"","",""];
}]


TEMP:  REMOVED SMOKES FROM renegadeArm.sqf (PUT BACK WHEN BI FIX)

(findDisplay 46) displayRemoveAllEventHandlers "KeyDown";
(findDisplay 46) displaySetEventHandler ["KeyDown","_this call MY_KEYDOWN_FNC; false;"];

MY_KEYDOWN_FNC = {
private ["_shift","_key", "_handled"];

_key = _this select 1;
_shift = _this select 2;
_handled = false;
player sideChat format ["%1", _key];
if(!alive player) exitWith {_handled};
	switch (_key) do {
		 case 21: {
			if (_shift) then {
				player sideChat "Actions_menu";
			};
		};

		_handled;
	};
};

medic anims

AinvPknlMstpSlayWpstDnon_medicOther
AinvPknlMstpSlayWlnrDnon_medicOther
AinvPknlMstpSlayWrflDnon_medicOther

AinvPknlMstpSnonWnonDnon_medic0
AinvPknlMstpSnonWnonDnon_medic1
AinvPknlMstpSnonWnonDnon_medic2
AinvPknlMstpSnonWnonDnon_medic3
AinvPknlMstpSnonWnonDnon_medic4
AinvPknlMstpSnonWnonDnon_medic5

// about 6 seconds long (with defib)

TIMEGG = time;
player playMoveNow "AinvPknlMstpSlayWrflDnon_medicOther";
CURRENTANIMEHIDX = player addEventHandler ["AnimDone",{
	player removeEventHandler ["AnimDone",CURRENTANIMEHIDX];
	hintSilent format ["%1", time - TIMEGG]
}];

// about 19 seconds long (without defib)

TIMEGG = time;
GVAR_currentAnimFrame = 1;
player playMoveNow "AinvPknlMstpSnonWnonDnon_medic0";
CURRENTANIMEHIDX = player addEventHandler ["AnimDone",{
	if (GVAR_currentAnimFrame < 6) then {
		player playMoveNow ("AinvPknlMstpSnonWnonDnon_medic" + (str GVAR_currentAnimFrame));
		GVAR_currentAnimFrame = GVAR_currentAnimFrame + 1;
	} else {
		player removeEventHandler ["AnimDone",CURRENTANIMEHIDX];
		hintSilent format ["%1", time - TIMEGG]
	};
}];

// anim sounds

http://forums.bistudio.com/showthread.php?177500-Animation-explanation-of-the-magic-behind&p=2699667&viewfull=1#post2699667

fn_shake = {
	params ["_veh","_weap","_muzz","_mode","_ammo","mag","proj"];
	// shake to all units or just gunner??
	_cal = getNumber(configFile / "CfgAmmo" / _ammo / "caliber");
	_hit = getNumber(configFile / "CfgAmmo" / _ammo / "hit");
	_reloadTime = getNumber(configFile / "CfgWeapons" / _muzz / "reloadTime");
	{
		if (isPlayer _x) then {
			addCamShake [
				_cal * 0.1 * _hit,  // power
				_reloadTime * 1.5 max 2,    // duration
				_reloadTime * 400 max 100   // frequency
			]
		};
	} forEach crew _veh;
};

fn_shake = {
	params ["_veh","_weap","_muzz","_mode","_ammo","_mag","_proj"];
	_cal = getNumber(configFile / "CfgAmmo" / _ammo / "caliber");
	_hit = getNumber(configFile / "CfgAmmo" / _ammo / "hit");
	_reloadTime = getNumber(configFile / "CfgWeapons" / _muzz / "reloadTime");
	{
		if (isPlayer _x) then {
			addCamShake [
				_cal * 0.05 * _hit,
				_reloadTime * 1.5 max 2,
				_reloadTime * 400 max 100
			]
		};
	} forEach crew _veh;
};

nearestTerrainObjects !

https://forums.bistudio.com/topic/185482-gui-and-the-aspect-ratio-how-can-i-get-my-gui-seperated-from-the-aspect-ratio/?p=2926684

#define SZ_SCREEN_UNIT_W(w) (w * safeZoneW / 100)
#define SZ_SCREEN_UNIT_H(h) (h * safeZoneH / 100)
#define POS_SCREEN_UNIT_X(x) (safeZoneX + (x * safeZoneW / 100))
#define POS_SCREEN_UNIT_Y(y) (safeZoneY + (y * safeZoneH / 100))
#define TEXT_SIZE(s) (sqrt(safeZoneW*safeZoneH*s*s))

maxStamina (seconds)  = 60 * (1 - load player)
Stamina recovery rate/second = 1.333333 * (1 - load player)
Sprint requires 1/3 maxStamina

sphere = "Sign_Sphere10cm_F" createVehicle [0,0,0];
onEachFrame {
	_begPos = positionCameraToWorld [0,0,0];
	_begPosASL = AGLToASL _begPos;
	_endPos = positionCameraToWorld [0,0,1000];
	_endPosASL = AGLToASL _endPos;
	_ins = lineIntersectsSurfaces [_begPosASL, _endPosASL, player, objNull, true, 1, "VIEW", "GEOM"];
	if (_ins isEqualTo []) exitWith {sphere setPosASL [0,0,0]};
	_ins select 0 params ["_pos", "_norm", "_obj", "_parent"];
	_arr = [];
	{
		_ins2 = [_parent, _x] intersect [_begPos, _endPos];
		_arr pushBack _ins2;
	} forEach ["FIRE","VIEW","GEOM","IFIRE"];
	hintSilent format ["%1",_arr]
};

replace every (needs to be local) command with remoteExec equivalant???

consider CBA (eventhandlers for units/vehs etc)

consider something in description.ext to do certain vehicle config stuff (rather then plugging for ex the load cargo system directly into config)

So we have:

CfgVehicles {
	class Sample_Vehicle {
		class Logistics {
			class Config_1 {
				class slot_1 {
					cargoLockIndices[] = {1,2,3,4};
					choices[] = {
						{"Horde_Ammo_Box_M",{-0.0625,-1.73438,0.3479},{{1,0,0},{0,0,1}}},
						{"Horde_Ammo_Box_L",{-0.0625,-1.73438,0.3479},{{1,0,0},{0,0,1}}},
						{"Horde_Fuel_Supply_M",{-0.0234375,-1.73242,0.217911},{{1,0,0},{0,0,1}}},
						{"Horde_Repair_Parts_Box_M",{-0.0625,-1.73438,0.3479},{{1,0,0},{0,0,1}}}
					};
				};
			};
			class Config_2 {
				class slot_1 {
					cargoLockIndices[] = {1,2,3,4};
					choices[] = {
						{"Horde_O_Quadbike_01_F",{[0.02,-1.6,0.7},{{1,0,0},{0,0,1}}}
					};
				};
			};
		};
	};
};

and then check it via:
_vehClass = missionConfigFile / "CfgVehicles" / "Sample_Vehicle";
if (isClass _vehClass) then {
	_arr = getArray (_vehClass / "Logistics" / "Config_1" / "slot_1" / "choices");
	if not empty(_arr) then {
		// some more code
	};
};

sort out actions (maybe move over to dialog updating each frame so it can check conditions in real time)...

for vehicles, maybe have interior and exterior actions (so if you are in it, you can move to other seats,or moor it if it is a boat)

	maybe block out the in-game actions with this:

	https://community.bistudio.com/wiki/inGameUISetEventHandler




sphere = "Sign_Sphere10cm_F" createVehicle [0,0,0];
onEachFrame {
	_begPos = positionCameraToWorld [0,0,0];
	_begPosASL = AGLToASL _begPos;
	_endPos = positionCameraToWorld [0,0,1000];
	_endPosASL = AGLToASL _endPos;
	_ins = lineIntersectsSurfaces [_begPosASL, _endPosASL, player, objNull, true, 1, "FIRE", "NONE"];
	if (_ins isEqualTo []) exitWith {sphere setPosASL [0,0,0]};
	_ins select 0 params ["_pos", "_norm", "_obj", "_parent"];
	if !(getModelInfo _parent select 2) exitWith {sphere setPosASL [0,0,0]};
	_ins2 = [_parent, "FIRE"] intersect [_begPos, _endPos];
	if (_ins2 isEqualTo []) exitWith {sphere setPosASL [0,0,0]};
	_ins2 select 0 params ["_name", "_dist"];
	_posASL = _begPosASL vectorAdd ((_begPosASL vectorFromTo _endPosASL) vectorMultiply _dist);
	drawIcon3D ["", [1,1,1,1], ASLToAGL _posASL, 0, 0, 0, _name, 1, 0.03, "PuristaMedium"];
	sphere setPosASL _posASL;
};

for intersecting with objects, check intersection point for closest selections (use intersect command) plus,
for parts that don't have a selection "motor" for example, will then need to defer to closest intersection config entry

so if lineintersectssurfaces doesn't return a selection, then check the config for nearest part to intersection point...

replace typeName a == "ARRAY" with a isEqualType []

look at removing the huge list of classes (z1,z2,z3 etc)

code is in serverPreInit.sqf (line 1230)

_configs = "diag_log configName _x; true" configClasses (configFile / "RscMapControl");


check configClasses speed vs current method for damage to vehicles (and poss interaction)

recheck tent code - may need to move away from player object and move to player UID completely

BIS_mainScope (check out what it is - apparently you can group unused units/logics to it.)


{
	diag_log format ["object: %1", _x];
	diag_log format ["type: %1", typeOf _x];
} forEach nearestTerrainObjects [
	player,
	[
		"Legend",
		"ActiveMarker",
		"Command",
		"Task",
		"CustomMark",
		"Tree",
		"SmallTree",
		"Bush",
		"Church",
		"Chapel",
		"Cross",
		"Rock",
		"Bunker",
		"Fortress",
		"Fountain",
		"ViewTower",
		"Lighthouse",
		"Quay",
		"Fuelstation",
		"Hospital",
		"BusStop",
		"Transmitter",
		"Stack",
		"Ruin",
		"Tourism",
		"Watertower",
		"Waypoint",
		"WaypointCompleted",
		"power",
		"powersolar",
		"powerwave",
		"powerwind",
		"Shipwreck"
	],
	200
];

horde_junk = [];
for "_i" from 0 to 999999 do {
	horde_junk pushback [player,1,2,3,4,5,6,7,8,9,["data"]];
};

profileNamespace setVariable ["junk",horde_junk];
saveProfileNamespace;

{
	diag_log format ["%1",_x]
} forEach (nearestObjects [player,[],20])

onEachFrame {
	hintSilent format ["surf: %1", surfaceType player]
};

s
fnc_relPos >> obj getRelPos [dist,dir]
fnc_dirTo >> obj1/pos1 getDir obj2/pos2
fnc_relPos >> obj1/pos1 getPos [dist,dir]
fnc_relativeDirTo >>  obj1 getRelDir obj2/pos2
newPos = [10,10,10];
[
	(newPos select 0) + 100 * sin 45,
	(newPos select 1) + 100 * cos 45,
	(newPos select 2)
];

(ASLtoAGL newPos) getPos [100,45];

onEachFrame {
	_ins = lineIntersectsSurfaces [
		AGLToASL positionCameraToWorld [0,0,0],
		AGLToASL positionCameraToWorld [0,0,1000],
		player
	];
	if (count _ins > 0) exitWith {hintSilent str _ins};
};

onEachFrame {
	_ins = intersect [
		positionCameraToWorld [0,0,0],
		positionCameraToWorld [0,0,1000],
		player
	];
	if (count _ins > 0) exitWith {hintSilent str _ins};
};

{
	_ob = _x;
	_class = typeOf _ob;
	_cfg = configFile / "CfgVehicles" / _class / "staticWeaponData";
	_arr = getArray _cfg;
	if not (_arr isEqualTo []) then {
		{
			_gunData = _x;
			_gun = createVehicle ["O_HMG_01_high_F",_ob modelToWorld (_gunData select 5), [] ,0 ,"can_collide"];
			_gun setDir (_ob getRelDir (_gunData select 2));
		} forEach _arr;
	}
} forEach (nearestObjects [player,["NonStrategic"],500])


{
	_ob = _x;
	_class = typeOf _ob;
	_cfg = configFile / "CfgVehicles" / _class / "staticWeaponData";
	_arr = getArray _cfg;
	if not (_arr isEqualTo []) then {
		{
			_gunData = _x;
			_gun = createVehicle ["O_HMG_01_high_F",_ob modelToWorld (_gunData select 3), [] ,0 ,"can_collide"];

		} forEach _arr;
	}
} forEach (nearestObjects [player,["NonStrategic"],500])

//_gun setDir (_ob getRelDir (_gunData select 1));


// need to calc z diff between attachTo pos and worldPos

_attachPos = getPos _gun;
_attachZ = (_gun worldToModel _attachPos) select 2;
_attachRelPos =  _zoneGunLog worldToModel [_attachPos select 0, _attachPos select 1, (_attachPos select 2) - _attachZ];


gun_1 attachTo [player]; // prob wrong
gun_1 attachTo [player,[0,0,boundingBoxReal gun_1 select 0 select 2]]; // << CORRECT!

spawn any house via logic and give it a global name.

run the code on it to compile its config entries into global vars

try and spawn snipers and statics from the global vars
0 = 0 spawn {
	while {true} do {
		{
			diag_log str _x
		} forEach diag_activeSQFScripts;

		{
			diag_log str _x
		} forEach diag_activeMissionFSMs;
	};
	uiSleep 10;
};

// poss new static code in zone manager - it is more like snipers

_staticWeaponData = (_zone getVariable "zoneStaticPoints") call BIS_fnc_arrayShuffle;
_spawnCount = 0;
_staticData = [];
if (_count > 0) then {
	{
		_entry = _x;
		_posASL = AGLtoASL (_obj modelToWorld (_entry select 1));

		if (not _airBaseZone
			or {_airBaseZone and {_posASL distance2D ((_zone getVariable "zoneMapHelipads") select 0) < 500}}
		) then {
			_underPosASL = _posASL vectorAdd [0,0,-2];
			_intersect = lineIntersects [_posASL,_underPosASL];
			if (_intersect) then {
				if (({if (_x distance _posASL < 200) exitWith {1}} count _players) isEqualTo 0) then {
					_staticData pushBack _entry;
					_spawnCount = _spawnCount + 1;
				};
			} else {
				_staticWeaponData set [_index,666];
			};
		};
		if (_spawnCount isEqualTo _count) exitWith {};
	} forEach _staticWeaponData;
	_staticWeaponData = _staticWeaponData - [666];
	(_zone setVariable ["zoneStaticPoints",_staticWeaponData]);
};

if ((_zone getVariable ["zoneStaticPoints",[]]) isEqualTo []) then {
	_zone setVariable ["zoneHasStaticPositions",false]
};

0.13454

_cfgPatches = configFile / "CfgPatches";
for "_i" from 0 to count _cfgPatches - 1 do {
	_cfgEntry = _cfgPatches select _i;
	_name = configName _cfgEntry;
	if (_i == count _cfgPatches - 1) then {
		diag_log format ["%1", _name];
		} else {
		diag_log format ["%1,", _name];
	};
};



{
	diag_log format ["group %1", _x];
	_var = _x getVariable ["groupData",[]];
	if not (_var isEqualTo []) then {
		diag_log format ["gd %1", _var];
		diag_log format ["units %1", units _x];
		diag_log format ["count alive units %1", {not isNull _x and {alive _x}} count units _x];
		diag_log format ["leader pos %1", getPos leader _x];
	};
} forEach allGroups;

targknow: [
	true, // known by group
	true, // known by the unit
	16.174, // last time the target was seen by the unit
	-2.14748e+006, // last time the target endangered the unit
	EAST, // target side
	0.0031708, // position error
	[1997.54,5795.61,7.60077] // target position ASL
]
neartargs: [
	[1997.54,5795.61,1.34658], // Position (perceived, includes judgment and memory errors),
	"Horde_gunmanUnit", // Type (perceived, gives only what was recognized),
	EAST, // Side (perceived side),
	1.27154e+007, // Subjective Cost (positive for enemies, more positive for more important or more dangerous enemies),
	man1, // (object type, can be used to get more information if needed)
	0.0031708 // (since build 5209:) position accuracy (assumed accuracy of the perceived position)
]
Getting some of this on Stratis:

 4:57:20 Out of path-planning region for O Alpha 2-3:2 at 2207.0,5798.0, node type Road
 4:57:20 Error O Alpha 2-3:2: Invalid path from [2208.53, 5.57, 5799.26] to [2215.87, 5.70, 5797.14].
 4:57:20 Out of path-planning region for O Alpha 2-3:4 at 2207.0,5798.0, node type Road
 4:57:20 Error O Alpha 2-3:4: Invalid path from [2208.70, 5.57, 5798.43] to [2213.53, 5.63, 5794.26].
 4:57:20 Out of path-planning region for O Alpha 2-3:6 at 2207.0,5798.0, node type Road
 4:57:20 Error O Alpha 2-3:6: Invalid path from [2208.53, 5.57, 5799.26] to [2213.70, 5.62, 5793.43].

The coord I ve entered is ASLtoAGL  [2208.53,5799.26,5.56955] (which is on the road on Stratis)

{
	{2208.53,5799.26,5.56955}, {
		{2358,5783},
		{2357,5569},
		{2114.28,5605.99},
		{2179,5974},
		{1907.41,5817.43}
	};
},


0 = 0 spawn {
	while {true} do {
		uiSleep 0.5;
		_oef = [];
		{
			_oef pushBack (_x select 0)
		} forEach (missionNamespace getVariable ["BIS_stackedEventHandlers_onEachFrame",[]]);
		hintSilent parseText format [
			"
				<t size='0.7'color='#FFFFFF'align='center'shadow='2'>-- ENEMY --<br />
				Active OEF: %1<br />
				<br />
				</t>
			",
			_oef
		];
	};
};


_surf = toLower surfaceType _pos;
{if (_surf find _x > -1) exitWith {1}} count ["dirt","forest","grass","beach","thorn"] > 0



fnc_rgbaToColorArray = {
	_color = _this;

	for "_i" from 0 to 2 do {
		if !( _color select _i isEqualTo 0 ) then {
			_color set [ _i, ( _color select _i ) / 255 ];
		};
	};

	_color
}; // 0.0242676 ms

fnc_rgbaToColorArray2 = {
	_alpha = _this select 3;
	_color = _this apply {_x / 255};
	_color set [3,_alpha];
	_color
}; // 0.0167969 ms

Hcolor = [2,4,6,8] apply {if (_x < 6) then {_x *0.5} else {_x}};
diag_log format ["value: %1", Hcolor];

// MUST DO "ELSE" WHEN USING "IF"

fnc_hexToColorArray = {
	params[ "_color" ];
	_hexArray = toArray toUpper _color;
	{
		_hexArray set [ _forEachIndex, toString [ _x ] ];
	}forEach _hexArray;

	if ( _hexarray select 0 isEqualTo "#" ) then {
		_nul = _hexArray deleteAt 0;
	};

	_hex = [ "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F" ];

	_value = [];
	for "_i" from 0 to ( count _hexArray ) -1 step 2 do {
		_nul = _value pushBack ( [ ((( _hex find ( _hexArray select _i )) * 16 ) + ( _hex find ( _hexArray select ( _i + 1 )))) / 255, 3 ] call BIS_fnc_cutDecimals );
	};

	_value
};

"#FFFFFFFF" call fnc_hexToColorArray;


// common target if multiple arty units firing at same time
if (random 1 > 0.97) then {
	_artyTarget = _zone getPos [3000 + (random 1000),random 360];
	_lookPos = _zonePos vectorFromTo _artyTarget;
	_lookPos set [2,0.9];
	_lookPos = _lookPos vectorMultiply 100;
};



{
	diag_log "---------------------";
	diag_log format ["%1", _x];
	{
		diag_log format ["%1", _x];
	} forEach (profileNameSpace getVariable [_x,["no entry"]])
} forEach [
	"altis_hordezone_52_vantagePointsAirBaseHigh",
	"altis_hordezone_52_vantagePointsAirBaseLow",
	"altis_hordezone_52_vantagePointsHigh",
	"altis_hordezone_52_vantagePointsLow",
	"altis_hordezone_52_staticPointsAirBase",
	"altis_hordezone_52_staticPoints"
]

{
	diag_log "---------------------";
	diag_log format ["%1", _x];
	{
		diag_log format ["%1", _x];
	} forEach (profileNameSpace getVariable [_x,["no entry"]])
} forEach [
	"altis_hordezone_51_vantagePointsAirBaseHigh",
	"altis_hordezone_51_vantagePointsAirBaseLow",
	"altis_hordezone_51_vantagePointsHigh",
	"altis_hordezone_51_vantagePointsLow",
	"altis_hordezone_51_staticPointsAirBase",
	"altis_hordezone_51_staticPoints"
]

// for executing a script OFF the server if HC are present, and ON the server if not

horde_fnc_selectFreeExecutor = {
	params ["_args","_fnc","_jip"];
	_target = 2;
	_drones = entities "HeadlessClient_F" select {_x getVariable ["droneLoaded",false]};
	if not (_drones isEqualTo []) then {
		_target = selectRandom _drones;
	};
	_args remoteExecCall [_fnc,_target,_jip];
};

// for executing a script OFF the server

horde_fnc_selectFreeHeadlessClientExecutor = {
	params ["_args","_fnc","_jip"];
	_target = 2;
	_drones = entities "HeadlessClient_F" select {_x getVariable ["droneLoaded",false]};
	if not (_drones isEqualTo []) then {
		_target = selectRandom _drones;
	};
	_args remoteExecCall [_fnc,_target,_jip];
};

horde_fnc_selectFreeHeadlessClientOwner = {
	private ["_drones","_result"];
	_drones = entities "HeadlessClient_F" select {_x getVariable ["droneLoaded",false]};
	if not (_drones isEqualTo []) then {
		_target = selectRandom _drones;
		{
			if ((_x getVariable "groupData") select 0 != "static") then {
				_result = _x setGroupOwner (owner _target);
				diag_log format ["group locality changed: %1 %2",_x, _result];
			};
		} forEach _this;
	};
	true
};


TEST AGENT IN BOAT WITH STATIC BLOKE (hmm, more work to make "waypoints")


COLLISION KILL OWNER VEHICLE  (no, still null object as source)


{
	if (toLower _x find "hordezone" > -1) then {
		profileNamespace setVariable [_x,nil]
	};
} forEach (allVariables profileNamespace);
saveProfileNamespace;

{
	if (toLower _x find "ncb_param_" > -1) then {
		profileNamespace setVariable [_x,nil]
	};
} forEach (allVariables profileNamespace);
saveProfileNamespace;

{
	diag_log format ["%1", _x]
} forEach (allVariables profileNamespace);

{
	profileNamespace setVariable [_x,nil]
} forEach (allVariables profileNamespace);
saveProfileNamespace;

for 0.00620117 ms
forEach 0.00712891 ms
count 0.00649414 ms

BIS_fnc_cutDecimals

Example: [123.4567, 2] call BIS_fnc_cutDecimals; //123.45


------------------------------
1 - CHANGE RESPAWN SYSTEM:
------------------------------

login needs adjusting to be more consistent (plus check to see if player is relogging back onto server - does he have tents etc - check DB in initPlayerServer and PV var to player - players machine will need to wait until this var exists (also update it in case they skip back to role assignment for any reason))

system for respawning at coast and para needs adjusting (allow player to choose a location away from tasks)

(if allow player to para-spawn on group leader then starting loadout should be reduced to sidearm.  Would this devalue the tents system if allowed????)

system for revive needs changing (change damageEH so unit never dies).  Therefore they are not teleported to respawn marker and enemy will not need to be despawned...

at the moment, zoneManager.fsm checks if player is conscious:

if (_pl getVariable "playerConscious") then {.....}  <check new zones box>

so when unit is incapacitated and can be revived, do not set this variable to FALSE.

Also, add in timer for revive (change allowed time in params)

However, if player chooses to respawn from menu and not wait to be revived, then set variable to FALSE as per current system

------------------------------
3 - RANDOM STUFF:
------------------------------

Build campfires!

One of the supply boxes can't be dragged.

Maybe add code to let Arty defenders look around etc (they don't reload at the moment either)

Check system for ejecting dead units from vehicles (can do it by script unit setPos getPos unit) so maybe no need for config eject edits

Think about NVG/Thermal in vehicles:
https://community.bistudio.com/wiki/disableNVGEquipment
https://community.bistudio.com/wiki/disableTIEquipment
Plus scopes...

Surrendered units are staying in zones after zone despawn - DONE

SOme more tasks maybe (submarine based)

Think about AI villagers and how they could work (revealing info in exchange for something etc)

Possibility for AI units to revive (will have to add handleDamage EH like players...hmm)

HC support (how will this work with disableAI and locality change) - use local eventhandler (done on units, will i need to do it for vehicles????)

Annoying stuff like delay in killedEH for AI to check if they are in a vehicle etc - cannot remember why I did that

Also, not sure if code to give killed Mortar operators a shell is working - maybe have ammo box near them instead.

StaticGrp AI in boats with "agent" driver..

Units reload weapons forever - good for guns, not so much for grenades and missiles etc - DONE

Remove fatigue from player monitor (also maybe remove lodged bullets as it shows up in health) - DONE

Option to disable local furniture - DONE

Tighten up support helis - kill them if tail rotor disabled etc

Possibility for zones to make passing "attackHeli" aware of players...

Interact in 3rd person goes from camto world - needs to be eyepos...

Place charge in 3rd person goes from camto world - needs to be eyepos - DONE

change generator so assemble option is in inventory and disassemble is on object.  Do not inherit from existing backpack (so not on scroll menu as well)

AI attackheli poilots not engaging:

solved with local function in their fsm (to enable) and change to cacheHeli to disable autocombat if param dictates (when they go back to main group).

16:12:47 "### Artillery ETA is ZERO ###"
16:12:47 "mortar: O Alpha 2-2:15"
16:12:47 "posASL mortar: [4344.47,3756.57,227.268]"
16:12:47 "finishPos: [0,0,0]"
16:12:47 "mag: 8Rnd_82mm_Mo_shells"
16:12:47 "---------------------------"

Caused by player dying, then moving to [0,0,0] to be respawned.  Player is then out of range so ETA is zero. - FIXED

{
	man1 disableAI _x
} forEach [
	"TARGET",
	"AUTOTARGET",
	"MOVE",
	"ANIM",
	"TEAMSWITCH",
	"FSM",
	"AIMINGERROR",
	"SUPPRESSION",
	"CHECKVISIBLE",
	"COVER",
	"AUTOCOMBAT"
];
man1 enableStamina false;

_fnc_setupHeliCrewAI = {
	if (_lv_aiAutoCombat == 0) then {
		{
			_x enableAI "autocombat"
		} forEach units _this;
	};
};


need to do boat bit and:

finish off fires

explode attached cargo stuff in killedEH (_this select 0) call horde_fnc_vehicleKilled;

_geomObj = "FLAY_FireGeom" createVehicleLocal [250,250,250];
_geomObj setMass 999999;
_geomObj allowDamage false;
{
	_geomObj disableCollisionWith _x;
} forEach ((getPOs player) nearEntities 10);
_geomObj setObjectTexture [0, "#(rgb,8,8,3)color(1,0,0,1)"];
_geomObj setPosASL eyePos player;
_geomObj setVelocity (((eyePos player) vectorFromTo (getPosASL cursorObject))vectorMultiply 30);
0 = 0 spawn {
	for "_i" from 1 to 20 do {
		for "_j" from 1 to 20 do {
			_coord = position player vectorAdd [_i,_j,0];
			_unit = createAgent [typeOf player,_coord,[],0,"none"];
			_unit setBehaviour "careless";
			_unit disableAI "fsm";
			_unit disableAI "target";
			_unit disableAI "autotarget";
			_unit disableAI "autocombat";
			_unit disableAI "cover";
			_unit disableAI "aimingerror";
			_unit disableAI "suppression";
			_unit disableAI "checkvisible";
			_unit disableAI "teamswitch";
			_unit enableStamina false;
			_unit setVariable ["BIS_fnc_animalBehaviour_disable", true];
			uiSleep 0.05;
		};
	};
};


NOTE: DO NOT FORGET THAT GROUPS ARE SET TO GO TO HC IF CONNECTED !!!

_groups call horde_fnc_selectFreeHeadlessClientOwner; (in "no cars left" zonemanager.fsm)

Boats in zones!

not bothered about saving them if they are moved

spawn them,

add them to zone variable

if when zone despawns they are near a player or have players in them, then leave them.  Otherwise, despawn.

need to keep track of ropes and pillars!  delete them at zone despawn

Ok, so boats are done (maybe change the code so hideObject on the map pillar and spawn new one at mission start)

_thing = createVehicle ["B_9x21_Ball",[100,100,100],[],0,"can_collide"];

0.0712891 ms

// vs

_thing = "B_9x21_Ball" createVehicle [100,100,100];

0.0640137 ms

_thing = createVehicle ["B_9x21_Ball",[100,100,100],[],0,"none"];

0.0844238 ms

Need to do interactions with rope

Cut rope (on rope object - destroys rope)
Detach rope (should be on object)
Detach rope and hold (should be on object - player is now attached to rope)


medic skill

medic can remove 1 bullet auto-successfully per level (no chance to fail)


checking through zoneManager.fsm

variable "ncb_param_zoneReinforcementTimer" controls how often we check all active zones if they need reinforcing

"zoneTimeLastSpawned" is only updated at zone spawn and total reinforce (currently ok to spawn if 30 secs have elapsed since last initial spawn or total reinforcement)

so this stops any checks for 30 secs after initial spawn or qrf

0 = 0 spawn {
	onEachFrame {
		hintSilent format ["FPS: %1", diag_fps]
	};
	_start = diag_tickTime;
	_thing = "Land_ButaneCanister_F" createVehicleLocal (position player);
	_position1 = getPos player;
	_position2 = getPosWorld _thing;
	deleteVehicle _thing;
	for "_i" from 1 to 100 do {
		for "_j" from 1 to 100 do {
			_coord = _position1 vectorAdd [_i,_j,_position2 select 2];
			_thing = createSimpleObject ["A3\Structures_F_EPA\Items\Tools\ButaneCanister_F.p3d",_coord];
		};
	};
	diag_log format ["finished in %1 seconds",diag_tickTime - _start];
	systemChat format ["finished in %1 seconds",diag_tickTime - _start];
};

/*_thing setPos ATLtoASL _coord vectorAdd [0,0,- (boundingBoxReal _thing select 1 select 2)];*/

0 = 0 spawn {
	onEachFrame {
		hintSilent format ["FPS: %1", diag_fps]
	};
	_start = diag_tickTime;
	_position1 = getPos player;
	for "_i" from 1 to 100 do {
		for "_j" from 1 to 100 do {
			_coord = _position1 vectorAdd [_i,_j,0];
			_thing = createVehicle ["Land_ButaneCanister_F",_coord,[],0,"can_collide"];
			_thing enableSimulationGlobal false;
		};
	};
	diag_log format ["finished in %1 seconds",diag_tickTime - _start];
	systemChat format ["finished in %1 seconds",diag_tickTime - _start];
};

DESIGNATORS - SPAWN LOCALLY, AND ALSO HIDE OTHER PLAYERS (WITH COOL PARTICLE FX).  THAT WAY, PLAYER IS ALONE.

_boat addAction ["Lower Rope",
{
	_boat = _this select 0;
	_id = _this select 2;
	_boat removeAction _id;
	_ropes = ropes _boat;
	{
		_ropeLength = ropeLength _x;
		_boatPos = getPosATL _boat;
		_seaFloor = _boatPos select 2;
		_newLength = (_seaFloor * 1.25) - _ropeLength;
		ropeUnwind [_x, 5, _newLength];
	} forEach _ropes;
}];


https://forums.bistudio.com/topic/188045-confusion-with-custom-classes-in-descriptionext/?p=2980140
_hitPoints = [];
_hitPointsCfgs = configProperties [
	configFile >> "CfgVehicles" >> "O_Truck_02_box_F" >> "HitPoints",
	"true",
	true
];
hint str (_hitPointsCfgs apply {configName _x});
_header = getMissionConfig "Header"

0 = 0 execFSM "server\zones\manager\zoneManager.fsm"

tr = createTrigger ["EmptyDetector", player modelToWorld [0, 10, 0]];
tr setTriggerArea [5, 5, 0, true];
tr setTriggerActivation ["CIV", "PRESENT", true];
rabbits = [];
private "_r";
for "_i" from 1 to 10 do {
	_r = createAgent ["Turtle_F", position tr, [], 0, "NONE"];
	_r setVariable ["BIS_fnc_animalBehaviour_disable", true];
	rabbits pushBack _r;
};
tr setTriggerStatements [
	"if (rabbits isEqualTo thisList) exitWith {
		_r = thisList select floor random count thisList;
		_r moveTo (_r modelToWorld [2.5 - random 5, 2.5 - random 5, 0]);
	};
	_esc = rabbits - thisList;
	doStop _esc;
	{_x moveTo position thisTrigger} forEach _esc;
	systemChat str [time, _esc];
	false",
	"",
	""
];

tr = createTrigger ["EmptyDetector", player modelToWorld [0, 10, 0]];
tr setTriggerArea [5, 5, 0, true];
tr setTriggerActivation ["CIV", "PRESENT", true];
animals = [];
private "_animal";
for "_i" from 1 to 10 do {
	_animal = createAgent ["Turtle_F", position tr, [], 0, "NONE"];
	_animal setVariable ["BIS_fnc_animalBehaviour_disable", true];
	_animal setBehaviour "careless";
	_animal disableAI "fsm";
	animals pushBack _animal;
};
tr setTriggerStatements [
	"if (animals isEqualTo thisList) exitWith {
		_animal = selectRandom thisList;
		_animal moveTo (_animal modelToWorld [2.5 - random 5, 2.5 - random 5, 0]);
	};
	_esc = animals - thisList;
	doStop _esc;
	{_x moveTo position thisTrigger} forEach _esc;
	systemChat str [time, _esc];
	false",
	"",
	""
];

pick up rope (only attached at one end)
attach rope to xxx (while carrying rope)
undo and carry rope (action is on object)

_cfgs = configProperties [
	configFile / "CfgVehicles" / "Horde_O_Quadbike_01_F" / "VehicleInteractionInfo",
	"true",
	true
];
{
	diag_log format ["%1", _x]
} count _cfgs;

_cfgs = configProperties [
	configFile / "CfgVehicles" / "Horde_O_Quadbike_01_F" / "VehicleInteractionInfo",
	"true",
	false
];

0.0221924 ms

---

_cfgs = configProperties [
	configFile / "CfgVehicles" / "Horde_O_Quadbike_01_F" / "VehicleInteractionInfo",
	"configName _x != 'chassis'",
	false
];

0.0349976 ms

---

_cfgInteraction = configFile / "CfgVehicles" / "Horde_O_Quadbike_01_F" / "VehicleInteractionInfo";
for "_i" from 0 to count _cfgInteraction - 1 do {
	_action = sel(_cfgInteraction,_i);
};

0.027002 ms

---

_cfgs = [];
_cfgInteraction = configFile / "CfgVehicles" / "Horde_O_Quadbike_01_F" / "VehicleInteractionInfo";
for "_i" from 0 to count _cfgInteraction - 1 do {
	_cfgs pushBack (_cfgInteraction select _i);
};

0.0244995 ms

add actions for rope

change/add actions for portable Generator

action on backpack and action to disassemble

change/add items in wreck boxes

problem found with apc - units will not embark after being in combat

at the moment, they are set to allowGetIn false then they disembark due to combat behaviour via the getOutVehicle script.

They should be allowed back in when

units group allowGetIn true solves this - need to look at the scripts

if ((_grp getVariable ["groupData",[""]]) select 0 != "infantry") then {
	units _grp allowGetin true
};

added in zm.fsm in "patrolling" action box

(alternative is to expand behaviour for reacting to players to other ai)


need to start moving skills to server validation plus add action to tents (save and logout)
PLUS ALSO OPTION TO CONFIRM KILLS AT TENT (not during play as players will use it to confirm kill unfairly)

0 = 0 spawn {
	waitUntil {
		sleep 1;
		globalChat format ["%1",animationState player];
		false
	};
};



test setHit and handledamage EH on helis!!!!!!

changed unitKilled and getOutVehicle EH.


Is a rope an attached object?

damaged truck:

diag_log format ["%1", attachedObjects cursorTarget];

11:17:37 "[167389: smokegrenade_white.p3d]"

now do ropeCreate

rope1 = ropeCreate [cursorTarget,[0,0,0],20]

11:18:45 "[167389: smokegrenade_white.p3d]"

now check with

[player,[0,0,0],[0,0,0]] ropeAttachTo (ropes cursorTarget select 0);

diag_log format ["%1", attachedObjects player];

11:24:01 "[]"

options for tasks:

All at once (set up like it is now)
Sequential (like domination)

and also for sequential mode:

Finite amount: infinite,1,2,3,4,5 etc

Plus: activate end mission yes/no

_list = [];
_configs = "_list pushBackUnique configSourceMod _x;true" configClasses (configFile >> "CfgVehicles");
_configs = "_list pushBackUnique configSourceMod _x;true" configClasses (configFile >> "CfgWeapons");
_configs = "_list pushBackUnique configSourceMod _x;true" configClasses (configFile >> "CfgMagazines");
{
	diag_log format ["%1",_x]
} forEach _list;

 0:13:29 "@nocebo"
 0:13:29 "curator"
 0:13:29 "heli"
 0:13:29 "@cup terrains - core"
 0:13:29 ""
 0:13:29 "@cba_a3"
 0:13:29 "@cup vehicles"
 0:13:29 "@cup terrains - maps"
 0:13:29 "mark"
 0:13:29 "kart"
 0:13:29 "@cup weapons"
 0:13:29 "@cup units"

 0:15:48 ""
 0:15:48 "curator"
 0:15:48 "heli"
 0:15:48 "mark"
 0:15:48 "kart"

_list = [];
_configs = "_list pushBackUnique (getText (_x / 'dlc'));true" configClasses (configFile >> "CfgVehicles");
_configs = "_list pushBackUnique (getText (_x / 'dlc'));true" configClasses (configFile >> "CfgWeapons");
_configs = "_list pushBackUnique (getText (_x / 'dlc'));true" configClasses (configFile >> "CfgMagazines");
_configs = "_list pushBackUnique (getText (_x / 'dlc'));true" configClasses (configFile >> "CfgAmmo");
{
	diag_log format ["%1",_x]
} forEach _list;



issues with mod equipment!!!!

disposable weapons use scope=1 mag... (at the moment, checking for scope2 mags in enemyequip, but this might add the launcher and no mag)
some cup weapons have ace mags with scope=1
cannot work out how to check if items are compatible with joint rails
_opticlist = ["LMG_Mk200_F", 201] call CBA_fnc_compatibleItems;
_alllist = ["LMG_Mk200_F"] call CBA_fnc_compatibleItems;

_list = "not ([] isEqualTo (getArray (_x / 'magazines') select {toLower _x find 'ace_' > -1}))" configClasses (configFile >> "CfgWeapons");

{
	diag_log format ["%1",configName _x]
} forEach _list;

_list = "configName _x isKindOf ['Pistol',configFile / 'CfgWeapons']" configClasses (configFile >> "CfgWeapons");
{
	diag_log format ["%1",getText (_x / "descriptionShort")]
} forEach _list;
numbs = [];
_list = "numbs pushBackUnique getNumber (_x / 'ItemInfo' / 'HitpointsProtectionInfo' / 'Head' / 'armor');true" configClasses (configFile >> "CfgWeapons");
diag_log format ["helmet armor: %1",numbs]

_numbs = [];
_list = "_numbs pushBackUnique getNumber (_x / 'ItemInfo' / 'HitpointsProtectionInfo' / 'Chest' / 'armor');true" configClasses (configFile >> "CfgWeapons");
diag_log format ["vest armor: %1",_numbs]


at the moment, affected scripts are serverpreinit.sqf and enemyequip.sqf

equip options

ai equipment
equipment in supply crates
loot - ?

have master list (all equip from all sides - respect no vanilla and no DLC)

Then sub lists can setup:
IR scopes included
TI scopes included
Side specific

For master list, do I do it like this:

[item,item,item]

or

[[item,[0,1,2]],[item,[0,2]],[item,[2]]]

item and array of sides that will use it.  That way, the game would not need to check every item through cfgVehicles.

Also, do the check as the game loads up and save in uiNamespace

https://community.bistudio.com/wiki/Functions_Library_(Arma_3)#Path

class CfgFunctions {
	class myTag {
		class myCategory {
			class myFunction {
				preStart = 1; // 1 to call the function upon game start, before title screen, but after all addons are loaded.
			};
		};
	};
};

adjusted repack option to consolidate existing new ammo as well


make the tier system dependent on data, so for helmets:

 2:11:10 "helmet armor ranges: [0,4,6,8,10,12]"

 we do:

 _range = [0,4,6,8,10,12];

 for "_i" from 0 to count _range - 1 do {
	// err, later
 }

 _inheritClass = getText (_cfgInfo >> "uniformClass");
_cfgHitPoints = _cfgVehicles / _inheritClass / "HitPoints";
_total = 0;
for "_j" from 0 to count _cfgHitPoints - 1 do {
	_cfgHP = _cfgHitPoints select _j;
	_armour = getNumber (_cfgHP / "armor");
	_total = _total + _armour;
};
diag_log format ["%1 - - - - %2",_class,_total];

0 = 0 execVM "server\init\itemCategory.sqf";
button
	soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1};
	soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1};
	soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1};
	soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1};

class WeaponSlotsInfo {
	mass = 140.8;
	class CUP_PicatinnyTopMountM110 {
		iconPosition[] = {0.62, 0.41};
		iconScale = 0.12;
		iconPicture = "\A3\Weapons_F\Data\UI\attachment_top.paa";
		iconPinPoint = "Bottom";
		class compatibleItems {
			optic_Nightstalker = 1;
			optic_tws = 1;
			optic_tws_mg = 1;
			optic_NVS = 1;
			optic_SOS = 1;
			optic_MRCO = 1;
			optic_Arco = 1;
			optic_aco = 1;
			optic_ACO_grn = 1;
			optic_aco_smg = 1;
			optic_ACO_grn_smg = 1;
			optic_hamr = 1;
			optic_Holosight = 1;
			optic_Holosight_smg = 1;
			optic_DMS = 1;
			optic_LRPS = 1;
			optic_AMS = 1;
			optic_AMS_khk = 1;
			optic_AMS_snd = 1;
			optic_KHS_blk = 1;
			optic_KHS_hex = 1;
			optic_KHS_old = 1;
			optic_KHS_tan = 1;
			CUP_optic_SB_3_12x50_PMII = 1;
			CUP_optic_AN_PAS_13c2 = 1;
			CUP_optic_AN_PAS_13c1 = 1;
			CUP_optic_LeupoldMk4 = 1;
			CUP_optic_HoloBlack = 1;
			CUP_optic_HoloWdl = 1;
			CUP_optic_HoloDesert = 1;
			CUP_optic_CompM4 = 1;
			CUP_optic_SUSAT = 1;
			CUP_optic_Eotech533 = 1;
			CUP_optic_ACOG = 1;
			CUP_optic_CWS = 1;
			CUP_optic_Leupold_VX3 = 1;
			CUP_optic_AN_PVS_10 = 1;
			CUP_optic_CompM2_Black = 1;
			CUP_optic_CompM2_Woodland = 1;
			CUP_optic_CompM2_Woodland2 = 1;
			CUP_optic_CompM2_Desert = 1;
			CUP_optic_RCO = 1;
			CUP_optic_RCO_desert = 1;
			CUP_optic_LeupoldM3LR = 1;
			CUP_optic_LeupoldMk4_10x40_LRT_Desert = 1;
			CUP_optic_LeupoldMk4_10x40_LRT_Woodland = 1;
			CUP_optic_ElcanM145 = 1;
			CUP_optic_Eotech533Grey = 1;
			CUP_optic_LeupoldMk4_CQ_T = 1;
			CUP_optic_ELCAN_SpecterDR = 1;
			CUP_optic_LeupoldMk4_MRT_tan = 1;
			CUP_optic_SB_11_4x20_PM = 1;
			CUP_optic_ZDDot = 1;
			CUP_optic_MRad = 1;
			CUP_optic_TrijiconRx01_desert = 1;
			CUP_optic_TrijiconRx01_black = 1;
			CUP_optic_AN_PVS_4 = 1;
		};
		linkProxy = "\A3\data_f\proxies\weapon_slots\TOP";
		displayName = "Optics Slot";
		access = 0;
		scope = 0;
	};
	class CUP_PicatinnySideMountM110 {
		iconPosition[] = {0.45, 0.46};
		iconScale = 0.15;
		iconPicture = "\A3\Weapons_F\Data\UI\attachment_side.paa";
		iconPinPoint = "Center";
		linkProxy = "\A3\data_f\proxies\weapon_slots\SIDE";
		displayName = "Pointer Slot";
		class compatibleItems {
			acc_flashlight = 1;
			acc_pointer_IR = 1;
			CUP_acc_ANPEQ_15 = 1;
			CUP_acc_ANPEQ_2 = 1;
			CUP_acc_Flashlight = 1;
			CUP_acc_Flashlight_wdl = 1;
			CUP_acc_Flashlight_desert = 1;
			CUP_acc_ANPEQ_2_camo = 1;
			CUP_acc_ANPEQ_2_desert = 1;
			CUP_acc_ANPEQ_2_grey = 1;
			CUP_acc_XM8_light_module = 1;
		};
		access = 0;
		scope = 0;
	};
	class MuzzleSlot {
		linkProxy = "\A3\data_f\proxies\weapon_slots\MUZZLE";
		compatibleItems[] = {"CUP_muzzle_snds_M110"};
		iconPosition[] = {0.19, 0.48};
		iconScale = 0.2;
		iconPicture = "\A3\Weapons_F\Data\UI\attachment_muzzle.paa";
		iconPinPoint = "Right";
	};
	class CUP_PicatinnyUnderMountM110 {
		iconPosition[] = {0.38, 0.52};
		iconScale = 0.2;
		iconPicture = "\A3\Weapons_F_Mark\Data\UI\attachment_under.paa";
		iconPinPoint = "Top";
		linkProxy = "\A3\Data_F_Mark\Proxies\Weapon_Slots\UNDERBARREL";
		class compatibleItems {
			bipod_01_F_snd = 1;
			bipod_01_F_blk = 1;
			bipod_01_F_mtp = 1;
			bipod_02_F_blk = 1;
			bipod_02_F_tan = 1;
			bipod_02_F_hex = 1;
			bipod_03_F_blk = 1;
			bipod_03_F_oli = 1;
			CUP_bipod_Harris_1A2_L = 1;
			CUP_bipod_VLTOR_Modpod = 1;
		};
		access = 0;
		scope = 0;
	};
	class CowsSlot {
	};
	class PointerSlot {
		compatibleItems[] = {"acc_flashlight", "acc_pointer_IR"};
		iconPicture = "\A3\Weapons_F\Data\UI\attachment_side.paa";
		iconPinpoint = "Center";
		linkProxy = "\A3\data_f\proxies\weapon_slots\SIDE";
		displayName = "Pointer Slot";
		access = 1;
		scope = 0;
		iconPosition[] = {0, 0};
		iconScale = 0;
	};
	allowedSlots[] = {901};
};

// http://www.mpgh.net/forum/showthread.php?t=839384&page=2

encrypt = {
	params ["_input","_key"];
	_encryptMe = toArray _input;
	_counter = 0;
	_array = toArray _key;
	for '_i' from 0 to count _encryptMe -1 do {
		if (_counter > count _array -1) then {
			_counter = 0;
		};
		_var = (_encryptMe select _i) * (_array select _counter);
		_encryptme set [_i,_var];
		_counter = _counter + 1;
	};

	_encryptMe
};

diag_log format ["%1",["hint 'test encryption'",'7i6brv65ece7{*(U{ UrcMH35UHM2PPUS(*)){ML:OHJvynyK>?HLI'] call encrypt];


decrypt = {
	params ["_decryptMe","_key"];
	_counter = 0;
	_array = toArray _key;
	for '_i' from 0 to count _decryptMe -1 do {
		if (_counter > count _array -1) then {
			_counter = 0;
		};
		_var = (_decryptMe select _i) / (_array select _counter);
		_decryptme set [_i,_var];
		_counter = _counter + 1;
	};
	toString _decryptMe
};
call compile ([[5720,11025,5940,11368,3648,4602,6264,5353,11615,11484,3232,5555,13530,4158,4560,10285,13776,3712,8925,12654,10890,3003],'7i6brv65ece7{*(U{ UrcMH35UHM2PPUS(*)){ML:OHJvynyK>?HLI'] call decrypt)

obfuscator = {
	_contents = loadFile "client\interact\general\action\cutFence.sqf";
	[_contents,"jhgjgj"] call encrypt;
	_contents = loadFile "client\interact\general\action\cutFence.sqf";
	copyToClipboard str ([([_contents,"jhgjgj"] call encrypt),"jhgjgj"] call decrypt);
	_compile = compile _contents;
	copyToClipboard _contents;

}

encrypt = {
	params ["_input","_key"];
	_encryptMe = toArray _input;
	_counter = 0;
	_array = toArray _key;
	for '_i' from 0 to count _encryptMe -1 do {
		if (_counter > count _array -1) then {
			_counter = 0;
		};
		_var = (_encryptMe select _i) * (_array select _counter);
		_encryptme set [_i,_var];
		_counter = _counter + 1;
	};

	_encryptMe
};

decrypt = {
	params ["_decryptMe","_key"];
	_counter = 0;
	_array = toArray _key;
	for '_i' from 0 to count _decryptMe -1 do {
		if (_counter > count _array -1) then {
			_counter = 0;
		};
		_var = (_decryptMe select _i) / (_array select _counter);
		_decryptme set [_i,_var];
		_counter = _counter + 1;
	};
	toString _decryptMe
};

_contents = loadFile "detect_windows.sqf";
_contents = [_contents,"1"] call encrypt;
_contents = [_contents,"2"] call decrypt;

_contents = [_contents,"2"] call encrypt;
_contents = [_contents,"1"] call decrypt;
copyToClipboard _contents


_value = empty array;
if (count array > 0) then {_value = array};
-----------------------------
_value = if (count array > 0) then {array}else{empty array};
-----------------------------
_value = if (count array > 0) then [{array},{empty array}];

_guns= [
	this,
	[10,15,1,1],
	[],
	[],
	[10,15,1,1],
	[],
	[],
	[],
	[],
	[],
	[],
	[]
] call horde_fnc_fillCrate;

_meds = [
	this,
	[],
	[],
	[],
	[],
	[],
	[],
	[20,30,1,3],
	[],
	[],
	[],
	[]
] call horde_fnc_fillCrate;

_fuel = [
	this,
	[],
	[],
	[],
	[],
	[],
	[],
	[],
	[],
	[],
	[],
	[20,30,1,3]
] call horde_fnc_fillCrate;

_tools = [
	this,
	[],
	[],
	[],
	[],
	[],
	[],
	[],
	[],
	[20,30,1,3],
	[],
	[]
] call horde_fnc_fillCrate;


mission 0.00439453 ms

ui 0.00449219 ms
// author = "CUP_AUTHOR_STRING";
_mods = configSourceModList (configFile >> "CfgVehicles" >> "CUP_B_FR_Soldier_10");
diag_log format ["10 %1",_mods];
// author = "Community Upgrade Project";
_mods = configSourceModList (configFile >> "CfgVehicles" >> "CUP_B_FR_Soldier_4");
diag_log format ["4 %1",_mods];
// author = "Community Upgrade Project";
_mods = configSourceModList (configfile >> "CfgWeapons" >> "CUP_arifle_Mk17_STD");
diag_log format ["mk17 %1",_mods];
// author = "CUP_AUTHOR_STRING";
_mods = configSourceModList (configfile >> "CfgWeapons" >> "CUP_B_USMC_Navy_Green");
diag_log format ["usmc %1",_mods];

_mods = configSourceModList (configFile >> "CfgVehicles" >> "CUP_B_FR_Soldier_10");
diag_log format ["10 %1",_mods];
_mods = configSourceModList (configFile >> "CfgVehicles" >> "CUP_B_FR_Soldier_4");
diag_log format ["4 %1",_mods];
_mods = configSourceModList (configfile >> "CfgWeapons" >> "CUP_arifle_Mk17_STD");
diag_log format ["mk17 %1",_mods];
_mods = configSourceModList (configfile >> "CfgWeapons" >> "arifle_Katiba_F");
diag_log format ["%1",_mods];


fnc_isWeaponAccCompatible = {
	scopeName "root";
	params ["_weaponClass","_accClass",["_typeNumb", -1]];
	_cfgWeapons = configFile / "cfgWeapons";
	_compatible = false;
	{
		_cfgCompatibleItems = _x / "compatibleItems";
		if (isArray _cfgCompatibleItems) then {
			_items = getArray _cfgCompatibleItems;
			if (not (_items isEqualTo []) and {_typeNumb == -1 or {_typeNumb == getNumber (_cfgWeapons / (_items select 0) / "ItemInfo" / "type")}}) then {
				{
					if (_accClass == _x) exitWith {
						_compatible = true;
						breakTo "root"
					};
				} forEach _items
			};
		} else {
			if (isClass _cfgCompatibleItems) then {
				{
					if (getNumber _x > 0 and {configName _x == _accClass}) then {
						_compatible = true;
						breakTo "root"
					};
				} forEach configProperties [
					_cfgCompatibleItems,
					"isNumber _x"
				];
			};
		};
	} forEach configProperties [
		configFile / "CfgWeapons" / _weaponClass / "WeaponSlotsInfo",
		"isClass _x",
		true
	];
	_compatible
};
fnc_isWeaponAccCompatible2 = {
	scopeName "root";
	params ["_weaponClass","_accClass",["_typeNumb", -1]];
	_cfgWeapons = configFile / "cfgWeapons";
	_compatible = false;
	{
		_cfgCompatibleItems = _x / "compatibleItems";
		if (isArray _cfgCompatibleItems) then {
			_items = getArray _cfgCompatibleItems;
			if (not (_items isEqualTo []) and {_typeNumb == -1 or {_typeNumb == getNumber (_cfgWeapons / (_items select 0) / "ItemInfo" / "type")}}) then {
				{
					if (_accClass == _x) exitWith {
						_compatible = true;
						breakTo "root"
					};
				} forEach _items
			};
		} else {
			if (isClass _cfgCompatibleItems) then {
				for "_i" from 0 to count _cfgCompatibleItems - 1 do {
					_name = str (_cfgCompatibleItems select _i);
					diag_log format ["%1",_numb];
					_numb = getNumber (_cfgCompatibleItems select _i);
					diag_log format ["%1",_numb];
				};
			};
		};
	} forEach configProperties [
		configFile / "CfgWeapons" / _weaponClass / "WeaponSlotsInfo",
		"isClass _x",
		true
	];
	_compatible
};

diag_log format ["%1", ["hgun_PDW2000_F","muzzle_snds_B",101] call fnc_isWeaponAccCompatible];
diag_log format ["%1", ["hgun_PDW2000_F","muzzle_snds_B",101] call fnc_isWeaponAccCompatible2];
diag_log format ["%1", ["CUP_arifle_Sa58RIS1","optic_Hamr",201] call fnc_isWeaponAccCompatible];
diag_log format ["%1", ["CUP_arifle_Sa58RIS1","optic_Hamr",201] call fnc_isWeaponAccCompatible2];
diag_log format ["%1", ["CUP_arifle_Sa58RIS1","muzzle_snds_B",101] call fnc_isWeaponAccCompatible];
diag_log format ["%1", ["CUP_arifle_Sa58RIS1","muzzle_snds_B",101] call fnc_isWeaponAccCompatible2];

diag_log format ["%1", ["hgun_PDW2000_F","muzzle_snds_B",101] call fnc_isWeaponAccCompatible];
diag_log format ["%1", ["hgun_PDW2000_F","muzzle_snds_B",101] call fnc_isWeaponAccCompatible2];
diag_log format ["%1", ["arifle_MX_SW_F","optic_Hamr",201] call fnc_isWeaponAccCompatible];
diag_log format ["%1", ["arifle_MX_SW_F","muzzle_snds_B",201] call fnc_isWeaponAccCompatible2];

["hgun_PDW2000_F","muzzle_snds_B",101] call fnc_isWeaponAccCompatible;
["hgun_PDW2000_F","muzzle_snds_B",101] call fnc_isWeaponAccCompatible2;

					if (getNumber _thing > 0 and {configName _thing == _accClass}) then {
						_compatible = true;
						breakTo "root"
					};

0 = 0 execFSM "server\zones\manager\zoneManager.fsm"; player setCaptive true; player linkItem "itemPass_MasterAll"; diag_log format [" rand: %1", floor random [0,random 3,1]];

// we expect 0 - 6 as returned val
_arr = [];
_houseValue = 0;
_countlootArrays = 5;
for "_i" from 1 to 10000 do {
	_numb = (floor random [
		0,
		linearConversion [0,4,random _houseValue,0,_countlootArrays,true],
		_countlootArrays - 1
	]);
	_arr pushBack _numb;
};

for "_i" from 0 to 7 do {
	diag_log format ["res: %1 - times: %2",_i,{_x == _i} count _arr]
};

[
	format ["<img shadow='0.2' size='6' image='%1' />", "rvg_missions\images\rvg_logo.paa"],
	safeZoneX+0.71, safeZoneY+safeZoneH-1.15, 8, 7, 0, 889
] spawn bis_fnc_dynamicText;
sleep 7;
[
	"<t  size = '0.5'>An Arma3 Mod by Haleks</t>",
	safeZoneX+0.71, safeZoneY+safeZoneH-0.83, 4, 4, 0, 890
] spawn bis_fnc_dynamicText;

tools > mass over 10

sort out mags for combine etc (mod mags do not work)
ropes


class XCA_ContainerBackground : RscText {
	idc = 1620;
	x = "1 * (((safezoneW / safezoneH) min 1.2) / 40) + (safezoneX + (safezoneW - ((safezoneW / safezoneH) min 1.2))/2)";
	y = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
	w = "12 * (((safezoneW / safezoneH) min 1.2) / 40)";
	h = "23 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	colorBackground[] = {0.05, 0.05, 0.05, 0.7};
};
class XGroundContainer : RscListBox {
	class DLCTemplate : RscDisplayInventory_DLCTemplate {
	};
	idc = 632;
	sizeEx = "0.8 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	sizeEx2 = "0.8 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	rowHeight = "2 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	canDrag = 1;
	colorText[] = {1, 1, 1, 1};
	colorBackground[] = {0, 0, 0, 0};
	itemBackground[] = {1, 1, 1, 0.1};
	itemSpacing = 0.001;
	x = "1.5 * (((safezoneW / safezoneH) min 1.2) / 40) + (safezoneX + (safezoneW - ((safezoneW / safezoneH) min 1.2))/2)";
	y = "3.7 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
	w = "11 * (((safezoneW / safezoneH) min 1.2) / 40)";
	h = "18.4 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
};

fnc_handleDam = {
	_unit = _this select 0;
	_hitSelection = _this select 1;
	_passedDamage = _this select 2;

	if (_hitSelection isEqualTo "legs") then {
		if (_passedDamage > 0.49) then {
			_passedDamage = 0.49
		};
	};
	_passedDamage
};

fnc_handleDam = {
	params ["_unit","_selName","_damage","_source","_projClass","_hitPartIndex"];

	_legs = getAllHitPointsDamage _unit select 1 find "legs";
	diag_log str _this;
	diag_log str _legs;
	if (_legs isEqualTo _hitPartIndex) then {
		if (_damage > 0.49) then {
			_damage = 0.49
		};
	};
	diag_log str _damage;
	_damage
};

this addEventHandler ["handledamage",{_this call fnc_handleDam}];

hmm, default system for equipment is ok, but would be better if there was another option:

so

ncb_param_vanillaWeaponsAllowed (applies to guns)
ncb_param_vanillaEquipmentAllowed (applies to anything else)

so check by author and if sides use it.

ammo = "F_40mm_White";
ammo = "G_40mm_HE";

{this disableAI _x}

have documents on soldiers with unique code:

https://forums.bistudio.com/topic/188195-how-to-protect-the-mission-from-theft/?p=2983538

class ItemAccessCodeLocationDoc

_code = format ["secret weapons stash at %1",_coords];

// function to find interaction points on vehs from selections

horde_fnc_getSelectionPositions = {
	diag_log format ["%1",typeOf _this];
	getAllHitPointsDamage _this params ["_hpNames","_selNames"];
	{
		_hpName = _X;
		_selName = _selNames select _forEachIndex;
		{
			_selPos = _this selectionPosition [_selName,_x];
			if not (_selPos isEqualTo [0,0,0]) then {
				diag_log format ["hitpoint: %1",_hpName];
				diag_log format ["sel name: %1",_selName];
				diag_log format ["sel pos: %1",_selPos];
				diag_log "";
				_worldPos = _this modelToWorld _selPos;
				_ball = "Sign_Sphere25cm_F" createVehicleLocal _worldPos;
				_ball setPos _worldPos;
				_handle = addMissionEventHandler ["Draw3D",compile format ["drawIcon3D ['', [1,0,0,1], %1, 0, 0, 0, '%2', 1, 0.03, 'PuristaMedium'];",_worldPos,_hpName + " - " + _selName + " - " + _x]];
			};
		} forEach [
			"Memory",
			"Geometry",
			"FireGeometry",
			"LandContact",
			"HitPoints"
		];
	} forEach _hpNames;
	diag_log "";
};

HOW WILL PLAYER PERSISTENCE WORK

1 - PLAYER LOGS IN FOR 1ST TIME ON SERVER (0 SKILLS AND GIVEN CHOICE TO SPAWN )

2 - DURING PLAY, PLAYER MAY ACCRUE TENTS AND SKILLS

3 - IF THEY DISCONNECT (ALT F4 ETC) THEN THEY LOSE SKILLS - HOW WILL TENTS WORK AS THEY ARE BOUND TO PLAYER BY UID)?

4 - IF THEY LOG OUT AT TENT, THEN WHEN THEY RECONNECT, THEY WILL RESPAWN AT WHICHEVER TENTS THEY STILL OWN

5 - LOOKS LIKE CANNOT KEEP TRACK OF GROUPS - PLAYERS CAN JUST REJOIN WHEN THEY RECONNECT

6 - ALSO, PROBABLY EASIER TO LET PLAYERS KEEP TENTS (IN CASE THEY DISCONNECT ACCIDENTALLY/CRASH OUT)

7 - NEED TO ACCOUNT FOR LEADER OF GROUP LOGGING OUT (WHAT HAPPENS TO TENTS)?

NEED TO EDIT:

CLIENT\INIT\CLIENTPOSTINIT.SQF
AND:

CLIENT\SYSTEM\RESPAWN.FSM

MAYBE GET RID OF LOGIN STUFF IN THE INIT AND SET UP AS "NO REVIVE"THEN MODIFY THE RESPAWN.FSM ACCORDINGLY

ALSO, UPDATE THE RESPAWN DIALOG TO:

1 - NOT LOOK SO CRAPPY
2 - POSSIBLY NOT SHOW THE TENTS OPTION IF PLAYER HAS NO TENTS.


// new dynamic spawn shit guns scripts needed for respawn

_fnc_selectBasicRifle = {
	_cfgWeapons = configFile / "cfgWeapons";
	_weapon = "";
	_slotsMax = 99;
	{
		_slots = 0;
		{
			_cfgCompatibleItems = _x / "compatibleItems";
			if (isArray _cfgCompatibleItems) then {
				if not (_cfgCompatibleItems isEqualTo []) then {
					_slots = _slots + 1;
				};
			} else {
				if (isClass _cfgCompatibleItems) then {
					if not (configProperties [_cfgCompatibleItems,"isNumber _x"] isEqualTo []) then {
						_slots = _slots + 1;
					};
				};
			};
		} forEach configProperties [
			_cfgWeapons / _x / "WeaponSlotsInfo",
			"isClass _x",
			true
		];
		if (_slots < _slotsMax) then {
			_weapon = _x;
			_slotsMax = _slots;
		};
	} forEach ncb_gv_crateRiflesTier_1;
	_mags = getArray (_cfgWeapons / _weapon / "magazines");
	_mags = _mags select {getText(configFile / "CfgAmmo" / (getText (configFile / "CfgMagazines" / _x / "ammo")) / "effectFly") != "AmmoUnderwater"};
	player addMagazines [_mags select 0,3];
	player addWeapon _weapon;
	_weapon = ncb_gv_cratePistolsTier_0 select 0;
	player addMagazines [getArray (_cfgWeapons / _weapon / "magazines") select 0,2];
	player addWeapon _weapon;
};

fnc_thing = {
	params ["_name"];
	_myPos = [];

	if (_name isEqualType objNull) then {
		_myPos = getPos _name
	} else {
		if (_name isEqualType "") then {
			// Let's pretend that _name is a marker to begin with
			if ("variableName" in allMapMarkers) then {
				_myPos = markerPos _name
			} else {
				// assume it is now object
				_myPos = getPos (missionNamespace getVariable [_name,[]]);
			};
		};
	};

	if (_myPos isEqualTo []) then {
		// exception code here
	} else {
		{deleteVehicle _x} forEach nearestObjects [_myPos, [], 800]
	};
};

_cfgWeapons = configFile / "cfgWeapons";
_weapon = "";
_slotsMax = 99;
{
	if (count getArray (_cfgWeapons / _x / "muzzles") < 2) then {
		_slots = 0;
		{
			_cfgCompatibleItems = _x / "compatibleItems";
			if (isArray _cfgCompatibleItems) then {
				if not (_cfgCompatibleItems isEqualTo []) then {
					_slots = _slots + 1;
				};
			} else {
				if (isClass _cfgCompatibleItems) then {
					if not (configProperties [_cfgCompatibleItems,"isNumber _x"] isEqualTo []) then {
						_slots = _slots + 1;
					};
				};
			};
		} forEach configProperties [
			_cfgWeapons / _x / "WeaponSlotsInfo",
			"isClass _x",
			true
		];
		if (_slots < _slotsMax) then {
			_weapon = _x;
			_slotsMax = _slots;
		};
	};
} forEach ncb_gv_crateRiflesTier_1;

{
	diag_log format ["%1 - %2",_x,cursorTarget skillFinal _x]
} forEach [
	"aimingAccuracy",
	"aimingShake",
	"aimingSpeed",
	"endurance",
	"spotDistance",
	"spotTime",
	"courage",
	"reloadSpeed",
	"commanding",
	"general"
];

// remove whitespace 32 = space, 9 = tab, 13 = carriage return, 10 = newline

splitString toString [32,9,13,10] joinString ""


//////////////////////////////

IMPORTANT

MUST disableAI "checkvisible" for all cached units and enable when unit is needed

affected files:

zoneManager.fsm
spawnVehicle.sqf
helicopter_manager.fsm
cacheGroup
createRenegade
enemyEquip (runs for all new units)

Look for lines like these:

_unit enableSimulationGlobal true
_unit hideObjectGlobal false

// player data and score
_prefix = "nocebo_player_" + (getPlayerUID _player);
_playerDB = ["new",_prefix] call OO_INIDBI;

_playerKills = ["read",[_prefix,"playerKills",0]] call _playerDB;
_aiKills = ["read",[_prefix,"aiKills",0]] call _playerDB;

"exists" call _playerDB;

_bool = ["write",[_prefix,"playerKills",someValue]] call _playerDB;

"_position","_direction","_stance","_playerKills","_aiKills","_uniform","_vest","_backpack","_weapons","_assignedItems","_headgear","_goggles","_food","_water","_bleeding","_lodgedBullets","_damage","_hitPoints","_skillCook","_skillEngineer","_skillFuelling","_skillLogistics","_skillSurgeon","_skillTyreFitter","_skillMagazineFitter","_skillWeaponFitter"

abort button: findDisplay 49 displayCtrl 104

need to update skill system (done - only messgaes need looking at)

need to sort out server shutdown

Also, if player saves with modded guns, then reloads with no mods, there needs to be a default system (either remove all or remove and replace with some default crap)

_cfgWeapons = configFile / "CfgWeapons";
_cfgMagazines = configFile / "CfgMagazines";
_cfgVehicles = configFile / "CfgVehicles";
_cfgGlasses = configFile / "CfgGlasses";

_fnc_isClass = {
	false;
	if (isClass (_cfgWeapons / _this)) exitWith {
		true
	};
	if (isClass (_cfgMagazines / _this)) exitWith {
		true
	};
	if (isClass (_cfgVehicles / _this)) exitWith {
		true
	};
	if (isClass (_cfgGlasses / _this)) exitWith {
		true
	};
};

_uniformData params ["_class","_contents"];
if not (_class isEqualTo "") then {
	if (_class call _fnc_isClass) then {
		player forceAddUniform _class;
		_uniform = uniformContainer player;
		{
			call {
				if (_forEachIndex isEqualTo 0) exitWith {
					{
						if (_class call _fnc_isClass) then {
							player addItemToUniform _x;
						};
					} count (_contents select 0);
				};
				if (_forEachIndex isEqualTo 1) then {
					{
						if ((_x select 0) call _fnc_isClass) then {
							_uniform addMagazineAmmoCargo [(_x select 0),1,(_x select 1)];
						};
					} count (_contents select 1);
				} else {
					[_uniform,_contents select 2] call horde_fnc_addWeaponsWithItems;
				};
			};
		} forEach _contents;
	} else {
		diag_log format ["you are trying to load a mod uniform that isn't supported: %1",_class]
	};
};

_vestData params ["_class","_contents"];
if not (_class isEqualTo "") then {
	player addVest _class;
	_vest = vestContainer player;
	{
		call {
			if (_forEachIndex isEqualTo 0) exitWith {
				{
					player addItemToVest _x;
				} count (_contents select 0);
			};
			if (_forEachIndex isEqualTo 1) then {
				{
					_vest addMagazineAmmoCargo [(_x select 0),1,(_x select 1)];
				} count (_contents select 1);
			} else {
				[_vest,(_contents select 2)] call horde_fnc_addWeaponsWithItems;
			};
		};
	} forEach _contents;
};

_backpackData params ["_class","_contents"];
if not (_class isEqualTo "") then {
	player addBackpackGlobal _class;
	_backpack = backpackContainer player;
	clearItemCargoGlobal _backpack;
	clearMagazineCargoGlobal _backpack;
	clearWeaponCargoGlobal _backpack;
	{
		call {
			if (_forEachIndex isEqualTo 0) exitWith {
				{
					player addItemToBackpack _x;
				} count (_contents select 0);
			};
			if (_forEachIndex isEqualTo 1) then {
				{
					_backpack addMagazineAmmoCargo [(_x select 0),1,(_x select 1)];
				} count (_contents select 1);
			} else {
				[_backpack,(_contents select 2)] call horde_fnc_addWeaponsWithItems;
			};
		};
	} forEach _contents;
};

{
	player addMagazine (_x select 4);
	player addWeapon (_x select 0);
	call {
		if ((weapons _unit select _forEachIndex) isEqualTo primaryWeapon _unit) exitWith {
			for "_i" from 1 to 3 do {
				if not ((_x select _i) isEqualTo "") then {
					_unit addPrimaryWeaponItem (_x select _i);
				};
			};
		};
		if ((weapons _unit select _forEachIndex) isEqualTo secondaryWeapon _unit) exitWith {
			for "_i" from 1 to 3 do {
				if not ((_x select _i) isEqualTo "") then {
					_unit addSecondaryWeaponItem (_x select _i);
				};
			};
		};
		if ((weapons _unit select _forEachIndex) isEqualTo handgunWeapon _unit) exitWith {
			for "_i" from 1 to 3 do {
				if not ((_x select _i) isEqualTo "") then {
					_unit addHandgunItem (_x select _i);
				};
			};
		};
	};
} forEach _weapons;

{
	player linkItem _x;
} count _assignedItems;

if (_headgear != "") then {
	player addHeadgear _headgear;
};

if (_goggles != "") then {
	player addGoggles _goggles;
};

player selectWeapon _currentMuzzle;

ropes do not behave as i expect them to.

it seems man class cannot create ropes

Only vehicles can, and they must always be attached to them (possibly)

You cannot create on a veh, then detach and attach to player.

rope class is in CfgNonAIVehicles

//

 configSourceAddonList
 inArea

setSpeciality (can make player quieter/less visible to AI)

player setSpeciality [<speciality_name>, <value>,[<isCustom>]]]

Medic (bool)
Engineer (bool)
Pyrotechnic (bool)
UavHacker (bool)

CamouflageCoef (float)
AudibleCoef (float)
FatigueCoef (float)

https://forums.bistudio.com/topic/150500-development-branch-captains-ai-log/?p=2989127

Horde_ImpactSparksSabot1Small

_fire = createVehicle ["Campfire_burning_F",player modelToWorld [0,2,0],[],0,"can_collide"];

horde_gv_windSoundSourceDistance = 0; 0 = 0 execVM "wind\sys_3d_wind\create_3d_wind.sqf";
0 = 0 execVM "wind\sys_tree_wind\play_tree_wind_sounds.sqf";

if (isServer) then {
	["Initialize"] call horde_fnc_dynamicGroups;
};
if (hasInterface) then {
	["InitializePlayer", [player]] call horde_fnc_dynamicGroups;
};

player linkItem "ItemGrinder"; player addItem "ItemMatchBox";

[player,player,player,objNull,objNull] - [objNull]
0.00689697 ms
[player,player,player,objNull,objNull] select {not isNull _x}
0.0136108 ms

[objNull,objNull,objNull,objNull,objNull] - [objNull]
0.00670166 ms
[objNull,objNull,objNull,objNull,objNull] select {not isNull _x}
0.0130859 ms


backpack that can be deployed as a para respawn beacon (using new "Land_DataTerminal_01_F")

click on map and respawn above marker (or slightly behind) - it still means loss of skills etc but at least groups can benefit of it.

edit respawnMapClicked to have new option for "beacon"

	_nearBeacons = nearestObjects [_worldPos, ["Land_DataTerminal_01_F"],100];
	if not empty(_nearBeacons) then {
		_beacon = sel(_nearBeacons,0);
			_retPos = getPos _beacon; //(make higher??)
			missionNamespace setVariable ["playerRespawnType","paradrop"];
			missionNameSpace setVariable ["playerOkToCloseRespawnMenu",true];
			missionNamespace setVariable ["playerTentRespawnPosASL",_retPos];
			[player,'playerConscious',true] call horde_fnc_setAndShareVariableWithServer;
			forceRespawn player;
		/*};*/
	};

and edit respawnMenuMapMarkerManager to add in valid para respawns

edit all functions in client\tent folder to incorporate data terminal and markers

edit horde_fnc_serverSetTentOwner

edit horde_fnc_dynamicGroups to add in what happens to player/group tents/data terminals when player joins new group.  (code should be in radio.sqf)



spawn horde_fnc_disassembleParaBeacon

[_this,'side'] spawn horde_fnc_unpackParaBeacon

//

[objNull,"view"] checkVisibility [eyePos man1,eyePos man2]
0.00891113 ms (blocked)
0.010498 ms (not blocked)
lineIntersects [eyePos man1,eyePos man2]
0.00749512 ms (blocked)
0.00839844 ms (not blocked)

0 = 0 spawn {
	while {alive player} do {
		uiSleep 1;
		systemChat format ["netID group player: %1",netID group player];
	}
};


FIXES  !!!!

cfgLoot needs sorting

look at base class for beacon and generator backpacks (maybe change the beacon to thingX and not static)

(maybe add medical backpack)

GUTTING ANIMALS

ANIMAL FSM SCRIPTS (RUN ON CLIENT AND DELETE IF CLIENT DISCONNECTS)

MAYBE ADD FLICKER TO LIGHTS ON BEACON WHEN OPENING

FINISH DYNAMIC GROUPS (TENTS GO WITH PLAYER WHEN SWITCHING GROUPS)

_mode == "OnKicked"
_mode == "OnGroupDisbanded"
_mode == "OnGroupLeave"
_mode == "OnGroupJoin"
_mode == "AddGroupMember"
_mode == "RemoveGroupMember"
_mode == "SwitchGroup"
_mode == "KickPlayer"
_mode == "UnKickPlayer"

MARKERS ON RESPAWN MENU MAP - CAN THEY BE SORTED TWIXT TENTS AND BEACONS?  MAYBE HAVE SLIGHTLY DIFFERENT MARKER ICON AND CHECK FOR THAT???

LOCK ENEMY VEHICLES ??

MUST CHANGE TARGET ALLOCATION SYSTEM:

horde_effectiveEngagementSecWeapMag[] = {"Titan_AP","RPG32_HE_F","RPG32_F","NLAW_F","Titan_AT"};
horde_primWeapMinCalLevel = 1;

(in horde_fnc_getZoneTargets)

READ BOOKS TO GAIN SKILLS (NEED MODEL AND PICTURE) - USE THE LADYBIRD MECHANIC ONE  :)

http://oddcentric.com/2015/09/25/friday-funnies/

MAYBE MAKE NEW NORMAL SYSTEM TO PLACE FURROWS ON WRECKS

LOAD SERVER/SAVE SERVER

SAVING MAGS ON VEHICLES IS A BIT BOTCHED - SORT IT OUT!

this addEventHandler ["take",{diag_log (str _this + "   take")}];
this addEventHandler ["put",{diag_log (str _this + "   put")}];

1:40:34 "[B Alpha 1-1:1 (Horde),<NULL-object>,"100Rnd_127x99_mag_Tracer_Yellow"]   take v"

Paraglide



addMissionEventHandler ["HandleDisconnect", {
	private ["_unit","_grp","_pos","_wholder"];
	_unit  = _this select 0;

	// save unit stats stuff here

	if (allPlayers isEqualTo []) then {

		// save server stuff here

		endMission "end1" // shuts down server
	};

	false
}];


["IP_DiscoEH", "onPlayerDisconnected", {
	// log it
	_allPlayers = allPlayers select {not (_x isKindOf "HeadlessClient_F")};
	diag_log format ["count _allPlayers: %1",count _allPlayers];
	{
		diag_log format ["obj: %1 - type: %2",_x,typeOf _x];
	} forEach _allPlayers;
	if (_allPlayers isEqualTo [] ) then {
		[] call IP_fnc_saveProgress;
		["Won"] call BIS_fnc_endMissionServer;
	};
}] call BIS_fnc_addStackedEventHandler;




"sea - waterDepth + (waterDepth factor [2,10]) * (1 - houses) * (1 - forest) * (1 - trees) * (1 - meadow)",

_bestPlaces = selectBestPlaces [
	getPos player,
	30,
	"sea - waterDepth + (waterDepth factor [2,10])",
	50,
	3
];
if not (_bestPlaces isEqualTo []) exitWith {
	{
		_x params ["_position2D","_cost"];
		if (_cost >= 1) exitWith {
			if (surfaceIsWater _position2D) then {
				_position2D set [2,((getPos player) select 2) min -1.5];
				_name = format ["mkr_%1",str (round random 99999)];
				_mkr = createMarker [_name,_position2D];
				_mkr setMarkerType "hd_dot";
				_mkr setMarkerColor "ColorBlue";
				_mkr setMarkerAlpha 1;
			};
		};
	} forEach _bestPlaces;
};

{
	deleteMarker _x
} forEach allMapMarkers;

rewrite ambient animals (commented out init in loading.fsm (end box))

Things to condider

(1 - rainy) - add in for land creatures
perhaps separate spawn and despawn distances for land/sea animals
sort out sea spawn and "waypoints"
limit on number of animals (3 maybe - remember that other players will spawn animals too)

fnc_getFullestMoonInRange = {
	params ["_minYear","_maxYear"];
	if (_maxYear < _minYear) then {
		_maxYear = _minYear
	};
	_bestDate = date;
	for "_year" from _minYear to _maxYear step 1 do {
		for "_month" from 1 to 12 step 1 do {
			for "_day" from 1 to 31 step 1 do {

			};
		};
	};
}

// Returns array of dates for given year when moon is at its fullest
fnc_fullMoonDates = {
	private _year = param [0, 2035];
	private ["_date", "_phase", "_fullMoonDate"];
	private _fullMoonPhase = 1;
	private _day = 1 / 365;
	private _waxing = false;
	private _fullMoonDates = [];
	for "_i" from -_day to dateToNumber [_year, 12, 31, 23, 59] step _day do {
		_date = numberToDate [_year, _i];
		_phase = moonPhase _date;
		call {
			if (_phase > _fullMoonPhase) exitWith {
				_waxing = true;
				_fullMoonDate = _date;
			};
			if (_waxing) exitWith {
				_waxing = false;
				_fullMoonDates pushBack _fullMoonDate;
			};
		};
		_fullMoonPhase = _phase;
	};
	_fullMoonDates
};

//set random full moon date in year 1970
setDate selectRandom (1970 call fnc_fullMoonDates);

hint format ["%1", [objNull,"view"] checkVisibility [eyePos man1,eyePos man2]];

[objNull,"view"] checkVisibility [eyePos man1,eyePos man2]
0.01 ms (blocked)
0.0139 ms (not blocked)
lineIntersects [eyePos man1,eyePos man2]; terrainIntersectASL [eyePos man1,eyePos man2];
0.0069 ms (blocked)
0.0077 ms (not blocked)

0 = 0 spawn {
	while {true} do {
		diag_log format [
			"player isKindOf Parachute %1,
			vehicle player isKindOf Parachute %2,
			animationState player == 'halofreefall_f' %3,
			animationState player %4",
			player isKindOf "ParachuteBase",
			vehicle player isKindOf "ParachuteBase",
			animationState player == "halofreefall_f",
			animationState player
		];
		uiSleep 1
	}
};

 {_x commandSuppressiveFire (getPos car1)} forEach units someGroup1

cursorObject commandSuppressiveFire (getPos car1)

load server with no missions.

Join and login as admin then use #missions

rewrite how the mission uses preinit/postinit scripts etc,

could have common init as a script to call from server and client scripts, so it is not executed at a random time.

client scripts should be dependent on server loaded (so maybe get rid of pre/post init on client and wait until server loaded)

error!

Weather was forced to change
Error in expression <forceSize interpolate [150,150.1,-1,1]>
  Error position: <forceSize interpolate [150,150.1,-1,1]>
  Error Undefined variable in expression: forcesize
Ragdoll - loading of ragdoll source "Soldier" started.
Ragdoll - loading of ragdoll source "Soldier" finished successfully.
Server: Object 3:21 not found (message Type_91)
Server: Object 3:23 not found (message Type_91)
Server: Object 3:22 not found (message Type_119)
Server: Object 3:42 not found (message Type_116)
Server: Object 3:41 not found (message Type_422)
Server: Object 3:45 not found (message Type_91)
Error: Object(3 : 45) not found
Error: Object(3 : 51) not found
Error: Object(3 : 56) not found
NetServer: trying to send too large non-guaranteed message (1352 bytes long, max 1348 allowed)
Message not sent - error 0, message ID = ffffffff, to 2105987704 (Horde)
NetServer: trying to send too large non-guaranteed message (1352 bytes long, max 1348 allowed)
Message not sent - error 0, message ID = ffffffff, to 2105987704 (Horde)
NetServer: trying to send too large non-guaranteed message (1352 bytes long, max 1348 allowed)
Message not sent - error 0, message ID = ffffffff, to 2105987704 (Horde)
NetServer: trying to send too large non-guaranteed message (1352 bytes long, max 1348 allowed)
Message not sent - error 0, message ID = ffffffff, to 2105987704 (Horde)
NetServer: trying to send too large non-guaranteed message (1352 bytes long, max 1348 allowed)
Message not sent - error 0, message ID = ffffffff, to 2105987704 (Horde)
NetServer: trying to send too large non-guaranteed message (1352 bytes long, max 1348 allowed)
Message not sent - error 0, message ID = ffffffff, to 2105987704 (Horde)
NetServer: trying to send too large non-guaranteed message (1352 bytes long, max 1348 allowed)
Message not sent - error 0, message ID = ffffffff, to 2105987704 (Horde)
NetServer: trying to send too large non-guaranteed message (1352 bytes long, max 1348 allowed)
Message not sent - error 0, message ID = ffffffff, to 2105987704 (Horde)
NetServer: trying to send too large non-guaranteed message (1352 bytes long, max 1348 allowed)
Message not sent - error 0, message ID = ffffffff, to 2105987704 (Horde)
NetServer: trying to send too large non-guaranteed message (1352 bytes long, max 1348 allowed)
Message not sent - error 0, message ID = ffffffff, to 2105987704 (Horde)
Server: Object 3:66 not found (message Type_124)
Server: Object 3:67 not found (message Type_115)
Admin logged out, player: Horde, playerUID: 12345678912345678, IP: 192.168.0.5:2314.


// ex: ["hgun_PDW2000_F","optic_DMS"] call horde_fnc_isWeaponAccCompatible;
// ex: ["hgun_PDW2000_F","muzzle_snds_B"] call horde_fnc_isWeaponAccCompatible;
/*horde_fnc_isWeaponAccCompatible = {
	params ["_weaponClass","_accClass"];
	_compatible = false;
	_cfgs = configProperties [
		configFile >> "CfgWeapons" >> _weaponClass >> "WeaponSlotsInfo",
		"isClass _x",
		true
	];
	{
		{
			if (_x == _accClass) exitWith {
				_compatible = true
			};
		} forEach getArray (_x / "compatibleItems");
	} forEach _cfgs;
	_compatible
};*/
horde_fnc_isWeaponAccCompatible = {
	params ["_weaponClass","_accClass"];
	_compatible = false;
	{
		if (_accClass in (getArray (_x / "compatibleItems"))) exitWith {
			_compatible = true
		};
	} forEach configProperties [
		configFile >> "CfgWeapons" >> _weaponClass >> "WeaponSlotsInfo",
		"isClass _x",
		true
	];
	_compatible
};
/*diag_log format ["res: %1",["arifle_TRG21_F","muzzle_snds_B"] call horde_fnc_isWeaponAccCompatible];
diag_log format ["res: %1",["hgun_PDW2000_F","muzzle_snds_B"] call horde_fnc_isWeaponAccCompatible];*/

// ex: "hgun_PDW2000_F" call horde_fnc_allCompatibleItems;
// ex: "arifle_TRG21_F" call horde_fnc_allCompatibleItems;

horde_fnc_allCompatibleItems = {
	_items = [];
	{
		_items append (getArray (_x / "compatibleItems"));
	} forEach configProperties [
		configFile >> "CfgWeapons" >> _this >> "WeaponSlotsInfo",
		"isClass _x",
		true
	];
	_items
};
/*diag_log format ["res: %1","arifle_TRG21_F" call horde_fnc_allCompatibleItems];
diag_log format ["res: %1","hgun_PDW2000_F" call horde_fnc_allCompatibleItems];*/

"personal" and "group" tents belonging to players should register when they join the server - code is in "horde_fnc_initPlayerServer".  Not sure about "side" tents (maybe something in serverpreinit for when they are reloaded in save game)

diag_log magazinesAmmo cursorTarget;

[
	["250Rnd_30mm_APDS_shells",250],
	["250Rnd_30mm_HE_shells",250],
	["8Rnd_LG_scalpel",8],
	["38Rnd_80mm_rockets",38]
]

diag_log magazinesAmmoFull cursorTarget;

[
	["250Rnd_30mm_APDS_shells",250,false,-1,""],
	["250Rnd_30mm_HE_shells",250,true,65536,"gatling_30mm"],
	["8Rnd_LG_scalpel",8,true,65536,"missiles_SCALPEL"],
	["38Rnd_80mm_rockets",38,true,65536,"rockets_Skyfire"]
]

diag_log magazines cursorTarget;

[
	"250Rnd_30mm_APDS_shells",
	"250Rnd_30mm_HE_shells",
	"8Rnd_LG_scalpel",
	"38Rnd_80mm_rockets"
]

{diag_log _x;diag_log cursorTarget magazinesTurret _x} forEach allTurrets [cursorTarget,false]


path = [0]
[
	"250Rnd_30mm_APDS_shells",
	"250Rnd_30mm_HE_shells",
	"8Rnd_LG_scalpel",
	"38Rnd_80mm_rockets"
]

diag_log magazinesAmmo cursorTarget;
diag_log magazinesAmmoFull cursorTarget;
diag_log magazines cursorTarget;
_paths = allTurrets [cursorTarget,false];
_paths = _paths + [[-1]];
{diag_log _x;diag_log (cursorTarget magazinesTurret _x)} forEach _paths

[
	["2000Rnd_65x39_Minigun_Hopper",2000],
	["12Rnd_PG_missile_Hopper",12],
	["168Rnd_CMFlare_Chaff_Magazine",168]
]
[
	["2000Rnd_65x39_Minigun_Hopper",2000,true,65536,"Horde_LMG_Minigun_heli"],
	["12Rnd_PG_missile_Hopper",12,true,65536,"Horde_12_rack_DAGR_hardpoint"],
	["168Rnd_CMFlare_Chaff_Magazine",168,true,65536,"CMFlareLauncher"]
]
["2000Rnd_65x39_Minigun_Hopper","12Rnd_PG_missile_Hopper","168Rnd_CMFlare_Chaff_Magazine"]
[0]
[]

still a problem with parachuting into zones from spawning and the spawn of the force.

I got no snipers or statics and the squads that appeared were in boats

also, tell the boats to pick different landing points

Maybe look at randomising some of a groups waypoints (maybe base it on their type - houses for infantry and woods/meadows for armed vehicles or something)
loop1 = true;
0 spawn {
	while {loop1} do {
		systemChat format ["vect %1 magnitude %2",velocity player,vectorMagnitude velocity player];
		uiSleep 1;
	};
};
player allowDamage false;
player setPos (getPos player vectorAdd [0,0,10000]);
player addBackpack "B_Parachute";

_beachHeads = [1];
for "_i" from 1 to 50 step 1 do {
	if (count _beachHeads >= 7) exitWith {};
	_beachHeads append _beachHeads;
	diag_log _beachHeads
};

maybe a check every minute to count groups or zones around players and adjust the zone spawn/despawn radii accordingly (or check each players proxinity to each other and work out how many enemy groups and therefore zones can be used so cut spawn and despawn radius down)
0 - figure out some good radii settings.  Currently, the settings are:

ncb_gv_zoneTriggerRad = 1250;
despawn radius is _triggerRad + 500

this means that a player can have up to 3 zones around him

so some other settings like:

ncb_gv_zoneTriggerRad = ???

//ncb_gv_zoneBaseTriggerRad = 1500;

setVar(_zone,"zoneTriggerRadius",ncb_gv_zoneTriggerRad);

1 - work out how many players (in seperate zones) are needed to exceed the group total (144 east +144 independent)

2 - every minute check amount of players

_targets = player targetsQuery [objNull,west,"",getPos target1, 10];
diag_log format ["%1", _targets];
systemChat format ["%1", _targets];

maybe profile all vehicle types against all calibers at the start of mission (do it in fsm):

1 - cycle through vehicle types and spawn a vehicle for each one

Add a handleDamage EH to stop veh exploding (in case bullet kills it)
spawn a bullet above it
add neg velocity
wait until bullet is null and check damage on vehicle (cycle through HitPoints)

this addEventHandler ["EpeContactStart",{
	params ["_veh","_object"];
	if (isNull _object or {_object isKindOf "man"}) exitWith {};
	if (time - (_veh getVariable ["lastCollision",0]) < 3) exitWith {};
	_intersections = lineIntersectsSurfaces [
		getPosWorld _veh,
		getPosWorld _object,
		_veh,
		objNull,
		true,
		1,
		"VIEW",
		"FIRE"
	];
	systemChat format ["epestart %1", _this];
	if not (_intersections isEqualTo []) then {
		(_intersections select 0) params ["_intersectPosASL","_surfaceNormal","_intersectObject","_parentObject"];
		_spoon = createVehicle [
			"Land_Tablet_01_F",
			ASLToAGL _intersectPosASL,
			[],
			0,
			"can_collide"
		];
		_spoon spawn {
			uiSleep 10;
			deleteVehicle _this
		};
		_veh setVariable ["lastCollision",round time];
		systemChat format ["spoon %1", _spoon];
	};
}];

knock on vehicles

https://forums.bistudio.com/topic/188632-knock-on-tanks/

Also, make exception for vehicles with driver and gunner - when it is only them left, they merge into another group

warning: preNLOD format in object ca\misc3\fort_bagfence_round.p3d

ErrorMessage: Warning: preNLOD format in object ca\misc3\fort_bagfence_round.p3d

_buildings = nearestObjects [player,["Static"],10000];
_types = [];
{
	_types pushBackUnique (typeOf _x)
} forEach _buildings;

{
	if (toLower configSourceMod (configFile / "CfgVehicles" / _x) find "nocebo" < 0) then {
		diag_log format ["class %1",_x];
	};
} forEach _types;

 0:02:33 "IniDBI: write failed nocebo_abramia_HordeZone_13 vantagePointsLow_27 data too big > 8K"
 0:02:33 "IniDBI: write failed nocebo_abramia_HordeZone_13 vantagePointsLow_28 data too big > 8K"
 0:02:33 "IniDBI: write failed nocebo_abramia_HordeZone_13 vantagePointsLow_29 data too big > 8K"
 0:02:33 "IniDBI: write failed nocebo_abramia_HordeZone_13 vantagePointsLow_30 data too big > 8K"
 0:02:33 "IniDBI: write failed nocebo_abramia_HordeZone_13 vantagePointsLow_31 data too big > 8K"

 change _countSubArrays = ceil (_countSubArrays / 4000); to _countSubArrays = ceil (_countSubArrays / 2000);

 updated horde_fnc_cacheGroup and horde_fnc_setupDisabledAI so that "checkVisible" should be disabled when caching unit

_veh disableNVGEquipment ncb_param_aiDisableVehicleVisionNV;
_veh disableTIEquipment ncb_param_aiDisableVehicleVisionTI;

houses.hpp is only good for furniture - the rest is shit and superceeded by testHouses...
[] spawn {
	_object = cursorObject;
	_cfgAnimSources = configProperties [
		configFile / "CfgVehicles" / (typeOf _object) / "AnimationSources",
		"true",
		true
	];
	_cfgAnimSources = _cfgAnimSources select {getText (_x / "source") == "user"};
	systemChat format ["cfgAnimSources: %1", _cfgAnimSources];
	_countSources = count _cfgAnimSources;
	systemChat format ["_countSources: %1", _countSources];
	if not (_countSources isEqualTo 0) then {
		{
			for "_i" from 0 to count _cfgAnimSources - 1 step 1 do {
				_cfgSource = _cfgAnimSources select _i;
				_name = configName _cfgSource;
				systemChat format ["name: %1", _name];
				systemChat format ["phase: %1", _x];
				_object animateSource [_name,_x];
			};
			uiSleep 1;
		} forEach [0,1,0];
	};
};

[] spawn {
	_object = cursorObject;
	_cfgAnimSources = configProperties [
		configFile / "CfgVehicles" / (typeOf _object) / "AnimationSources",
		"true",
		true
	];
	systemChat format ["cfgAnimSources: %1", _cfgAnimSources];
	_countSources = count _cfgAnimSources;
	systemChat format ["_countSources: %1", _countSources];
	if not (_countSources isEqualTo 0) then {
		for "_i" from 0 to count _cfgAnimSources - 1 step 1 do {
			_cfgSource = _cfgAnimSources select _i;
			_name = configName _cfgSource;
			systemChat format ["name: %1", _name];
			{
				systemChat format ["phase: %1", _x];
				_object animateSource [_name,_x];
				uiSleep 1;
			} forEach [0,1,0];
		};
	};
};

update loot to use "horde_objectLootSpots"

CURRENT:

_houseValue = getNumber (_cfgHouse / "horde_lootPriority"); // 0 - 4

INTENDED:

_houseValue = getNumber (_cfgHouse / "horde_objectLootSpots"); // 0 - 4
call {
	if (_houseValue < 6) exitWith {
		_houseValue = 0
	}
	if (_houseValue < 11) exitWith {
		_houseValue = 1
	};
	if (_houseValue < 31) exitWith {
		_houseValue = 2
	};
	if (_houseValue < 61) exitWith {
		_houseValue = 3
	};
	_houseValue = 4
};

update

problem with turret ammo scripts is on ststic guns.

The mag isnt removed properly:
diag_log (magazinesAllTurrets vehicle player):
Array - in the following format: [[<className>,<turretPath>,<ammoCount>,<id>,<creator>],...]
gives us

[["100Rnd_127x99_mag",[0],0,1.00218e+007,2]]

so have to remove, then can add..
vehicle player removeMagazineTurret ["100Rnd_127x99_mag",[0]];

Also, it lets us add another mag (for a total of two) but zeros the ammo on the first mag which stops the new one from reloading.

(not that it should allow two mags I think - or zero anything)

[["100Rnd_127x99_mag_TG",[0],0,1.00218e+007,2],["100Rnd_127x99_mag",[0],100,1.00218e+007,2]]

vehicle player addMagazineTurret ["100Rnd_127x99_mag_TG",[0],0];
vehicle player addMagazineTurret ["100Rnd_127x99_mag_TG",[0],100];
vehicle player addMagazineTurret ["100Rnd_127x99_mag_TG",[0],0];
vehicle player addMagazineTurret ["100Rnd_127x99_mag_TG",[0],50];

[
 ["FakeWeapon",[-1],1,1.00218e+007,2],
 ["100Rnd_127x99_mag_TG",[0],0,1.00218e+007,2],
 ["100Rnd_127x99_mag_TG",[0],100,1.00218e+007,2],
 ["100Rnd_127x99_mag_TG",[0],0,1.00218e+007,2],
 ["100Rnd_127x99_mag_TG",[0],50,1.00218e+007,2]
]

vehicle player removeMagazineTurret ["100Rnd_127x99_mag_TG",[0]];
vehicle player removeMagazineTurret ["100Rnd_127x99_mag_TG",[0]];
[
 ["FakeWeapon",[-1],1,1.00218e+007,2],
 ["100Rnd_127x99_mag_TG",[0],0,1.00218e+007,2],
 ["100Rnd_127x99_mag_TG",[0],50,1.00218e+007,2]
 ]

 vehicle player removeMagazineTurret ["FakeWeapon",[-1]];
_object = vehicle player;
_allStaticMags = magazinesAllTurrets _object;
for "_i" from 0 to count _allStaticMags - 1 do {
	(_allStaticMags select _i) params ["_mag","_turret"];
	[_object,[_mag,_turret]] remoteExecCall [
		"removeMagazineTurret",
		_object turretOwner _turret
	];
};

ncb_gv_faceTypes = [];
_cfgFaceGroups = configFile / "CfgFaces";
for "_i" from 0 to count _cfgFaceGroups - 1 do {
	ncb_gv_faceTypes pushBack (configName (_cfgFaceGroups select _i))
};
diag_log ncb_gv_faceTypes
ncb_gv_faceTypes pushBack ((configProperties [_cfgFaceGroups select _i,"getText (_x / 'head') != ''",true]) apply {configName _x});

ncb_gv_faceTypes = [];
_cfgFaceGroups = configFile / "CfgFaces";
for "_i" from 0 to count _cfgFaceGroups - 1 do {
	_cfgGroup = _cfgFaceGroups select _i;
	for "_j" from 0 to count _cfgGroup - 1 do {
		_cfgFace = _cfgGroup select _j;
		if (getText (_cfgFace / "head") != "") then {
			ncb_gv_faceTypes pushBack (configName _cfgFace)
		};
	};
};
diag_log ncb_gv_faceTypes

------------

axe /sword

create weapon anim like here:

https://forums.bistudio.com/topic/131902-tutorial-creating-custom-weapon-animations/

Then the swing is actually the reload anim (weapon reloads automatically)

https://forums.bistudio.com/topic/143871-custom-reload-gestures/

------------

Maybe there is a problem with the new AI detection system (combat or patrol):

The AI units break off attack too quickly imo.  Maybe mix both old and new  (snipers = old, all other groups = new)

This mission has the old system (nearTargets, not findNearestEnemy)

E:\Documents\Arma 3 - Other Profiles\Horde\MPMissions\##Nocebo_persistence.Altis

------------

Debug in getZoneTargets (find an error)

if not (_thing isEqualType 0) then {
	diag_log _secLoadedMag;
	diag_log _thing;
};

// change back from calculating positional error to using _posAccuracy

11:05:38 Warning Message: No entry 'E:\Documents\Arma 3 - Other Profiles\Horde\mpmissions\##Nocebo_inidbi2.Altis\description.ext/Horde_respawnMenu/Controls/map.LineMarker'.
11:05:38 Warning Message: No entry '.lineWidthThin'.
11:05:38 Warning Message: '/' is not a value
11:05:38 Warning Message: No entry '.lineWidthThick'.
11:05:38 Warning Message: '/' is not a value
11:05:38 Warning Message: No entry '.lineDistanceMin'.
11:05:38 Warning Message: '/' is not a value
11:05:38 Warning Message: No entry '.lineLengthMin'.
11:05:38 Warning Message: '/' is not a value

if not (isNull _veh) then {
	_delTime = _veh getVariable ["deadDeleteTime",-1];
	if (_delTime isEqualTo -1) then {
		if (typeOf _veh != "") then {
			_veh setVariable ["deadDeleteTime",(round time) + _removeDeadTimeout];
		} else {
			// exception for non-classed (createSimpleObjects)
			if (random 1 > 0.7) then {
				deleteVehicle _veh
			};
		};
	};
	if (time > _delTime) then {
		deleteVehicle _veh
	};
};

collapse tree groups on opening squad interface

https://community.bistudio.com/wiki/tvCollapse

{
	diag_log format ["group %1",_x];
	diag_log format ["group data: %1",_x getVariable ["groupData",[]]];
	diag_log "------------";
} forEach allGroups

_tgtData = _leader nearTargets ((_leader distance vehicle _player) + 10);

_tgtData = (_leader nearTargets ((_leader distance vehicle _player) + 10)) select {_x select 4 == vehicle _player};

((gunner gun1) nearTargets (((gunner gun1) distance vehicle player) + 10)) select {_x select 4 == vehicle player};

0.0576 ms

(gunner gun1) targetKnowledge player

0.003 ms

highvoltagecolumn_f
highvoltagecolumnwire_f

{
	_grp = _x;
	if ((_grp getVariable ["groupData",[""]]) select 0 in ["infantry","static"]) then {
		_targetArr = _grp getVariable "groupCurrentTargetData";
		if (not isNil "_targetArr") then {
			_targetArr params ["_targetData",""];
			_targetData params ["_target","_targetPosAGL","_distError"];
diag_log _targetData;
			if (not isNull _target
				and {isNull objectParent _target}
			) then {
				_house = objNull;
				{
					if (_x isKindOf "House_F") exitWith {
						_house = _x
					};
					true
				} count (lineIntersectsWith [
					(AGLtoASL _targetPosAGL) vectorAdd [0,0,0.2],
					(AGLtoASL _targetPosAGL) vectorAdd [0,0,10]
				]);
				if (not isNull _house) then {
					{
						if (isNull objectParent _x) then {
systemChat format ["%1 starting suppression on %2", _x,_target];
diag_log format ["%1 starting suppression on %2", _x,_target];
								_x doSuppressiveFire _target
						};
						true
					} forEach units _grp;
				};
			};
		};
	};
} count _validGroups;

_fnc_getHouseTarget = {
	_house = objNull;
	if (not isNull _target
		and {isNull objectParent _target}
	) then {
		{
			if (_x isKindOf "House_F") exitWith {
				_house = _x
			};
			true
		} count (lineIntersectsWith [
			(AGLtoASL _targetPosAGL) vectorAdd [0,0,0.2],
			(AGLtoASL _targetPosAGL) vectorAdd [0,0,10]
		]);
	};
	_house
};

_fnc_closestBuildingPos = {
	// gets closest building position to unit.  IF none found, then empty array is returned
	params ["_unit","_house"];
	private ["_distance","_closestPos","_buildingPos"];
	scopeName "0";
	_closestPos = [];

	_distance = 9999;
	for "_i" from 0 to 999 do {
		_buildingPos = _house buildingPos _i;
		if same(_buildingPos,zeroPos) exitWith {};
		if (_buildingPos distance _unit < _distance) then {
			_distance = _buildingPos distance _unit;
			_closestPos = _buildingPos
		};
	};

	_closestPos
};

//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////

_grp = _validGroups select _grpIndex;
_grpIndex = _grpIndex + 1;

if not (isNull _grp) then {
	_leader = leader _grp;
	if not (isNull _leader and {alive _leader}) then {
		_leaderPosATL = getPosATL _leader;
		(_grp getVariable ["groupData",["none",objNull,0,0,-1,false]]) params ["_groupType","_groupVehicle","_scanDist","_threatIndex","_coverDist","_owner"];
		_targetArr = _grp getVariable "groupCurrentTargetData";
		if (not isNil "_targetArr") then {
			_targetArr params ["_targetData","_doNotChase"];
			_targetData params ["_target","_targetPosAGL","_positionalError"];
			call {
				if (_groupType isEqualTo "static") exitWith {
					// suppress if enemy is in house
					if (not isNull (0 call _fnc_getHouseTarget)) then {
						{
							if (isNull objectParent _x) then {
								systemChat format ["STATIC: %1 starting suppression on %2", _x,_target];
								diag_log format ["STATIC: %1 starting suppression on %2", _x,_target];
								_x doSuppressiveFire _target
							};
							true
						} forEach units _grp;
					};
				};
				if (_groupType isEqualTo "infantry") then {
					if (_doNotChase) then {
						_destPos = _leaderPosATL;
						if (count _destPos > 2) then {
							_destPos resize 2
						};
						[_grp,_destPos] call _fnc_setHoldWp
					} else {
						_currWpIndex = currentWaypoint _grp;
						_waypointPos = waypointPosition [_grp,_currWpIndex];
						if (_positionalError > 48) then {
							// search for enemy
							if not (_grp call _fnc_isGroupSearching) then {
								[_grp,_waypointPos] call _fnc_startSearchWp
							};
						} else {
							// knows exactly where enemy is
							// suppress if enemy is in house and storm house
							_house = 0 call _fnc_getHouseTarget
							if (not isNull _house) then {
								// suppress
								{
									if (isNull objectParent _x) then {
										systemChat format ["INFANTRY: %1 starting suppression on %2", _x,_target];
										diag_log format ["INFANTRY: %1 starting suppression on %2", _x,_target];
										_x doSuppressiveFire _target
									};
									true
								} forEach units _grp;
								// waypoints
								_searchHousePos = [_target,_house] call _fnc_closestBuildingPos;
								if not empty(_searchHousePos) then {
									// give WP to search house
									[_grp,_searchHousePos] call _fnc_setAdvanceWp
								} else {
									// default advance behaviour
									if (_currWpIndex > 1
										or {_waypointPos distance _targetPosAGL > 150}
									) then {
										_destPos = +_targetPosAGL;
										if (count _destPos > 2) then {
											_destPos resize 2
										};

										_dist = (floor random (50 - 10)) + 10 + 1;
										_dir = random 359;
										_destPos = [
											(_destPos select 0) + _dist * sin _dir,
											(_destPos select 1) + _dist * cos _dir
										];
										[_grp,_destPos] call _fnc_setAdvanceWp
									};
								};
							};
						}
					}
				};
				// any other types
				if (_doNotChase) then {
					_destPos = _leaderPosATL;
					if (count _destPos > 2) then {
						_destPos resize 2
					};
					[_grp,_destPos] call _fnc_setHoldWp
				} else {
					_currWpIndex = currentWaypoint _grp;
					_waypointPos = waypointPosition [_grp,_currWpIndex];
					if (_positionalError > 48) then {
						// search for enemy
						if not (_grp call _fnc_isGroupSearching) then {
							[_grp,_waypointPos] call _fnc_startSearchWp
						};
					} else {
						// knows exactly where enemy is
						if (_currWpIndex > 1
							or {_waypointPos distance _targetPosAGL > 150}
						) then {
							_destPos = +_targetPosAGL;
							if (count _destPos > 2) then {
								_destPos resize 2
							};

							_dist = (floor random (50 - 10)) + 10 + 1;
							_dir = random 359;
							_destPos = [
								(_destPos select 0) + _dist * sin _dir,
								(_destPos select 1) + _dist * cos _dir
							];
							_roads = _destPos nearRoads 100;
							if not (_roads isEqualTo []) then {
								_destPos = getPosATL (selectRandom _roads);
								_destPos resize 2;
							};
							[_grp,_destPos] call _fnc_setAdvanceWp
						};
					};
				};
			};
		} else {
			if not (_groupType isEqualTo "static") then {
				[
					[_grp],
					_zonePosATL,
					_coverPlaceDataArr,
					false,
					true
				] call _fnc_zoneGroupsFindHideWaypoint;
			};
		};
	};
};




o alpha 1-2 hold 3 search


{
	diag_log "------------";
	if (not isNil {_x getVariable "groupData"}) then {
		diag_log format ["%1",_x];
		diag_log format ["%1",position leader _x];
		diag_log format ["%1",_x getVariable "groupData"];
	};
} forEach allGroups

on the dynamic groups interface

idd = 60490

idc = 9877

maybe set up waituntil ctrl loaded and minimise the tree


_vehSpawnPosASL = player modelToWorld [0,100,0];
_vehSpawnPosASL set [2,0];
([
 selectRandom ncb_gv_enemyInflatableTypes,
 _vehSpawnPosASL,
 "new",
 "ncb_gv_enemyUnitPool",
 "ncb_gv_enemyUnitPool",
 createGroup civilian
] call horde_fnc_spawnVehicle)

test:  added units _grp orderGetIn true to "patrolling" cond in zone_manager.fsm

Idea: setup different way of doing waypoints


horde_fnc_objectVar = {
	params [
		["_object",objNull,[objNull]]
	];
	if (isNull _object) exitwith {""};

	private _var = _object getVariable ["#var",""];

	if (_var == "") then {
		//calculate dynamic variable
		_var = vehiclevarname _object;
		if (_var == "") then {
			private ["_varID","_netID","_netIDseparator"];
			_var = param [1,"bis_o",[""]];
			if (ismultiplayer) then {
				_netID = netid _object;
				_netIDseparator = _netID find ":";
				_var = _var + (_netID select [0,_netIDseparator]) + "_" + (_netID select [_netIDseparator + 1,100]);
			} else {
				_varID = [_var,1] call bis_fnc_counter;
				_var = _var + str _varID;
			};
		};

		_object setvariable ["#var",_var,true];
		missionnamespace setvariable [_var,_object];
		publicvariable _var;

		//execute where the unit is local, otherwise changes would not be restored after respawn
		if !(local _object) then {
			[_object,_var] remoteExecCall ["horde_fnc_objectVar",_object]
		};
	};
	if (local _object && {vehiclevarname _object == ""}) then {
		_object setvehiclevarname _var;
		_object addeventhandler ["local",{
			[_this select 0] remoteExecCall ["horde_fnc_objectVar",_this select 0]
		}];
	};
	_var
};

var1 = ["paul","bob"];
diag_log (var1 apply {var1 find _x})

var1 = 1;

while {var1 < 11} do {var1 = var1 + 1};

0.0321 ms

for "_i" from 1 to 10000 do {
	if (var1 == 10) exitWith {};
	var1 = var1 + 1
};

0.0358 ms
_waypointGroups = [];
_positions = [[2340,2341],[6782,6871],[3123,4345],[6564,3245],[3456,6788],[2345,4321],[2374,2674],[5678,2348],[6543,3688],[4287,6574]];
for "_i" from 1 to 10 do {
	if (_positions isEqualTo []) exitWith {};
	_entry = [];
	for "_j" from 0 to count _positions - 1 do {
		if (_positions - [objNull] isEqualTo []) exitWith {};
		if (count _entry == 6 or {count _entry > 2 and {random 1 > 0.75}}) exitWith {
			_waypointGroups pushBack _entry
		};
		_pos = _positions select _j;
		diag_log format ["pos %1",_pos];
		diag_log format ["entry %1",{if (_x distance2D _pos < 50) exitWith {1}} count _entry];
		if ({if (_x distance2D _pos < 50) exitWith {1}} count _entry isEqualTo 0) then {
			_entry pushBack _pos;
			_positions set [_j,objNull];
		};
	};
	_positions = _positions - [objNull]
};
diag_log format ["wpg %1",_waypointGroups]

fnc_closestBuildingPos = {
	params ["_unit","_house"];
	private ["_distance","_closestPos","_buildingPos"];
	scopeName "0";
	_closestPos = [];

	_distance = 9999;
	for "_i" from 0 to 999 do {
		_buildingPos = _house buildingPos _i;
		if (_buildingPos isEqualTo [0,0,0]) exitWith {};
		if (_buildingPos distance _unit < _distance) then {
			_distance = _buildingPos distance _unit;
			_closestPos = _buildingPos
		};
	};

	_closestPos
};

diag_log ([player,nearestBuilding player] call fnc_closestBuildingPos)

// pv functions from server to client

1 - in clintpostinit add an EH

"ncb_pv_sendFunctionsToClient" addPublicVariableEventHandler {
	params ["","_array"];
	{
		_x params ["_fncName","_code"];
		missionNameSpace setVariable [_fncName,_code]
	} forEach _array;
	ncb_gv_functionsReceived = true;
};

ncb_pv_requestClientFunctions = player;
publicVariableServer "ncb_pv_requestClientFunctions";

waitUntil {
	not isNil "ncb_gv_functionsReceived"
};

2 - on server, add an EH to send functions on request (make sure these exist on server and are compiled in description.ext) !

ncb_pv_clientFunctions = [];
_cfgFncs = missionConfigFile / "CfgFunctions" /"Horde" / "test" // change to "client"
for "_i" from 0 to count _cfgFncs -1 do {
	_cfgFnc = _cfgFncs select _i;
	_fncName = "horde_fnc_" + (configName _cfgFnc);
	ncb_pv_clientFunctions pushBack [_fncName,missionNameSpace getVariable _fncName;
};
"ncb_pv_requestClientFunctions" addPublicVariableEventHandler {
	params ["","_player"];
	(owner _player) publicVariableClient "ncb_pv_clientFunctions"
};

{
	diag_log format ["%1", _x]
} forEach allVariables missionNameSpace


B_LSV_01_armed_F
O_LSV_02_armed_F
O_LSV_02_unarmed_F

comment "Related vehicle classes:";
comment "O_T_LSV_02_armed_F";
comment "O_LSV_02_armed_F";
comment "O_LSV_02_unarmed_F";

_veh = createVehicle ["O_T_LSV_02_armed_F",position player,[],0,"NONE"];
[
	_veh,
	["Arid",1],
	["Unarmed_Doors_Hide",1]
] call BIS_fnc_initVehicle;
[
	_veh,
	[
		["B_Soldier_VR_F","driver"],
		["C_man_1","gunner",[5]]
	]
] call BIS_fnc_initVehicleCrew;

drawingInMap = 0;

{
	diag_log format [
	"Group %1 - waypoint type %2 - waypoint index %3 - groupData %4 - all wp pos %5",
	_x,
	waypointType [_x,(currentWaypoint _x)],
	currentWaypoint _x,
	_x getVariable ["groupData",["none"]],
	(waypoints _x) apply {waypointPosition _x}]
} forEach allGroups;


player linkItem "ItemPass_MasterAll";
diag_log (typeOf cursorObject);
{_x forceAddUniform (uniform player)} forEach (player nearEntities ["CAManBase", 500])

_grp = createGroup (side player);
{
	_bloke = _grp createUnit ["B_Pilot_F",[666,666,666],[],0,"can_collide"];
	_bloke assignAsTurret _x;
	_bloke moveInTurret _x;
} forEach [[0,0],[0,1],[0,2],[0,3]];

hint format ["%1",fullcrew [_veh,"",true]];

20:38:32 "obj Land_Shop_Town_01_F"
20:39:08 "obj Land_Shop_Town_03_F"
20:56:27 "obj Land_Hotel_02_F"
"obj 9496: watertank_01_f.p3d"

{
	if random 1 < 0.5 then {
		_x hideObjectGlobal true;
		_x enableSimulationGlobal false;
	};
} forEach nearestTerrainObjects [_zone, ["Tree","Small Tree","Bush"], 1000, false];

OpenDoor_1
condition = "((this animationPhase 'Door_1A_rot') < 0.5) && ((this getVariable ['bis_disabled_Door_1',0]) != 1) && (cameraOn isKindOf 'CAManBase')";
statement = "([this, 'Door_1A_rot', 'Door_Handle_1A_rot_1', 'Door_Handle_1A_rot_2', 'Door_1B_rot', 'Door_Handle_1B_rot_1', 'Door_Handle_1B_rot_2'] call BIS_fnc_TwoWingDoorTwoHandleOpen)";

vtol setVehicleCargo cargo; - loads cargo into vtol
getVehicleCargo vtol; - Returns list of vehicles in cargo
vtol canVehicleCargo cargo; - Return whether cargo can be loaded into vtol
vtol enableVehicleCargo bool; - Enable or disable cargo capability
isVehicleCargo cargo; - Returns the vehicle cargo is loaded in
vehicleCargoEnabled vtol: - Returns whether cargo loading is enabled/disabled

https://forums.bistudio.com/topic/191890-the-new-revive-system-what-could-be-interferring-with-it/?p=3049382

class CfgRemoteExec // applies only to clients
{
	class Functions
	{
		#ifndef A3W_DEBUG
		mode = 1; // 0 = block all, 1 = whitelist, 2 = allow all
		#else
		mode = 2; // debug mode, don't touch
		#endif

		#include "client\CfgRemoteExec_fnc.hpp"
	};
	class Commands
	{
		#ifndef A3W_DEBUG
		mode = 1; // 0 = block all, 1 = whitelist, 2 = allow all
		#else
		mode = 2; // debug mode, don't touch
		#endif
	};
};

Change "search" mode for groups of infantry who are currently searching a house (add some sort of variable to indicate they are doing that, then check for it in the "search" code in the fsm)

Aerial and Amphib QRF

Aerial:

Heli slinging vehicle
VTOL dropping infantry
VTOL dropping vehicle
(VTOL could land or drop by parachute)

Amphib:

RHIB dropping off divers
Patrol boat dropping off divers (maybe patrol boat could be marine equivalent of QRF attack chopper)
Jetski SF Divers (one driving, one on the back)
SDV dropping off divers???

this setSkill 1;
this setSkill ["aimingAccuracy",1];
this setSkill ["aimingShake",1];
this setSkill ["aimingSpeed",1];
this setSkill ["commanding",1];
this setSkill ["courage",1];
this setSkill ["endurance",1];
this setSkill ["reloadSpeed",1];
this setSkill ["spotDistance",1];
this setSkill ["spotTime",1];

{
	if ({alive _x} count crew _x < 1) then {
		{
			deleteVehicle _x
		} count (crew _x);
		deleteVehicle _x
	}
} forEach (player nearEntities ["landvehicle",14000])

{
	if ({alive _x} count crew _x < 1
		and {}
	) then {
		{
			deleteVehicle _x
		} count (crew _x);
		deleteVehicle _x
	}
} forEach (player nearEntities ["landvehicle",14000])

cleanup = player nearEntities ["landvehicle",14000];
{
	if ({alive _x} count crew _x < 1) then {
		cleanUp set [_forEachIndex,objNull];
		{
			deleteVehicle _x
		} count (crew _x);
		deleteVehicle _x
	};

} forEach cleanUp;
cleanup = cleanup - [objNull];

diag_log "--------";
{
	diag_log _x
} forEach cleanup;
_players = [];
{
	if (lifestate _x != "INCAPACITATED") then {
		_players pushBack _x
	};
} forEach (player nearEntities [
	"Horde_player_base",
	1250
]);
0.0039 ms
_players = (player nearEntities [
	"Horde_player_base",
	1250
]) select {lifestate _x != "INCAPACITATED"};
0.0041 ms

add change waypoint code !

[""infantry"",objNull,600,0,200,""del_me"",_zoneName]

LET FFV PASSENGERS TURN OUT

https://community.bistudio.com/wiki/isTurnedOut

https://community.bistudio.com/wiki/Arma_3_Actions#TurnIn_.2F_TurnOut

TankOne action ["TurnIn", TankOne];

[player, objnull, [0.706, 0.0745, 0.0196, 1]] call BIS_fnc_dirIndicator;

(_beachHeads deleteAt 0) params ["_landingPosASL","_ingressPosASL","_depthAtIngressPos"];

_beachHead = [];
{
	if (_beachHead isEqualTo []) then {
		_beachHead = _x
	} else {

	}
} forEach _beachHeads

https://forums.bistudio.com/topic/166592-object-tracking-device-script-ideas/?p=3061493

(AGLtoASL _respawnPos) spawn

19:40:42 Error in expression <intStatements ["true",""];
};
} forEach _waypointData;

_wp = _grp addWaypoint [>
19:40:42   Error position: <_waypointData;

_wp = _grp addWaypoint [>
19:40:42   Error Undefined variable in expression: _waypointdata
19:40:42 File E:\Documents\Arma 3 - Other Profiles\Horde\mpmissions\##Nocebo_new_inidbi2.Tanoa\server\zones\waypoints\setupGroupWaypoints.sqf, line 138

On TAVU (Tanoa) 010077

{
	if not ((missionNamespace getVariable _x) isEqualType {}
	) then {
		diag_log format ["%1 - %2",_x,missionNamespace getVariable _x]
	}
} forEach (allVariables missionNameSpace)

looks like we can get rid of this "playerReviveNotAllowed" variable.  It only seems to control whether a black out will happen

instead of sending huge array of spawn places to all clients, maybe spawn the markers and pv a "init done" variable.  The clents can then use the markers for spawning.

_shell = createVehicle ["SmokeLauncherAmmo",player modelToWorld [0,2,2],[],0,"can_collide"];
	[player,"SmokeLauncher","SmokeLauncher","SmokeLauncher","SmokeLauncherAmmo","SmokeLauncherMag",_shell] call (uiNamespace getVariable (gettext (configFile / "CfgAmmo" / "SmokeLauncherAmmo" / "muzzleEffect")));
_shell setVelocity [0,0,5]
vehicle player addEventHandler ["fired", {diag_log _this}]; vehicle player action ["UseWeapon",vehicle player,player,0];

cursorObject addEventHandler ["fired",{diag_log _this}]

ncb_layer_playerMonitor cutText ["","plain"];
["playerSetNeeds","onEachFrame"] call horde_fnc_removeStackedEventHandler;
["pfh_playerMonitor","onEachFrame"] call horde_fnc_removeStackedEventHandler;


_handle = addMissionEventHandler [
	"Draw3D",
	format [
		"drawIcon3D [
			'',
			%5,
			%1,
			0,
			0,
			0,
			'%2 - %3 - %4',
			1,
			0.03,
			'PuristaMedium'
		];",
		_pos,
		_name,
		_partHealth,
		_nameItem,
		[1,1,0,1]
	]
];

// new suppression ok - maybe stop it if enemy units are too close (< 25m)

Add divers to boats

Add abandoned boats (rework code)

if ({side _x isEqualTo civilian} count allGroups > 130) exitWith {};


[position player,25,"sea - waterDepth",10,5,5,-1,-1,1,true,player,"Horde_O_Boat_Armed_01_minigun_F"] call horde_fnc_getSafePosNew;

for "_i" from 1 to 50 do {
	_pos = [_x,1000,"sea - waterDepth",2,1,5,-1,-1,2,true,player,"Horde_O_Boat_Armed_01_minigun_F"] call horde_fnc_getSafePosNew;
	if not empty(_pos) then {
		if (horde_gvar_displayMarkers) then {
			_mkr = createMarker [str _pos + str (random 400) ,_pos];
			_mkr setMarkerSize [5,5];
			_mkr setMarkerShape "Ellipse";
			_mkr setMarkerBrush "Solid";
			_mkr setMarkerColor "ColorBlue";
			_mkr setMarkerAlpha 0.5;
		};
	};
};

{
	_x params ["_pos","_expressionResult"];
	if (_expressionResult > 0) then {
		if (horde_gvar_displayMarkers) then {
			_mkr = createMarker [str _pos + str (random 400) ,_pos];
			_mkr setMarkerSize [5,5];
			_mkr setMarkerShape "Ellipse";
			_mkr setMarkerBrush "Solid";
			_mkr setMarkerColor "ColorBlue";
			_mkr setMarkerAlpha 0.5;
		};
	};
} forEach selectBestPlaces [position player,1000,"sea - waterDepth + (waterDepth factor [0.05, 0.5])",2,100];


// men sit round campfire (optional one of them works on vehicle if not "infantry")

_units = units group;

if (count _units < 3) exitWith {};

if (GROUP_HAS_A_VEHICLE) then {
	// one soldier works on vehicle
	_mechanic = _units deleteAt floor random count _units;
};
// find pos to place campfire
_fire = createVehicle

for "_ang" from 0 to (360 - (360 / count _units)) step (360 / count _units) do {
	_ang = (_ang + 10 - (random 20)) % 360;
	_dist = 2 + (random 2);

};
_pos = getPos cursorObject;
_pos set [2,2];
_posASL =
_plane = createVehicle ["I_C_Plane_Civil_01_F",getPos cursorObject,[],0,"can_collide"];
_plane setDir getDir cursorObject;


_v1 = [0,0,0];
_v2 = _v1; // _v2 = +_v1;
_v2 set [0,6];
_v2 set [1,6];
_v2 set [2,6];

 1:52:04 "V1 [6,6,6]"
 1:52:04 "V2 [6,6,6]"
 1:52:38 "V1 [0,0,0]"
 1:52:38 "V2 [6,6,6]"

diag_log format ["V1 %1",_v1];
diag_log format ["V2 %1",_v2];
fnc_isClear = {
	params ["_pos","_radius"];
	private _isClear = true;
	for "_direction" from 0 to 355 step 5 do {
		private _testPosASL = [
			(_pos select 0) + _radius * sin _direction,
			(_pos select 1) + _radius * cos _direction,
			_pos select 2
		];
		if (lineIntersects [_pos,_testPosASL]) exitWith {
			_isClear = false
		};
	};
	_isClear
};

fnc_isClear = {
	params ["_pos","_radius"];
	private _isClear = true;
	for "_direction" from 0 to 355 step 5 do {
		_helper = createVehicle ["Sign_Sphere10cm_F", _pos getPos [_radius,_direction], [], 0, "CAN_COLLIDE"];
		if (lineIntersects [_pos,AGLtoASL (_pos getPos [_radius,_direction])]) exitWith {
			_isClear = false
		};
	};
	_isClear
};

fnc_isClear = {
	params ["_pos","_radius"];
	private _isClear = true;
	for "_direction" from 0 to 355 step 5 do {
		if (lineIntersects [_pos,_pos vectorAdd [_radius * sin _direction,_radius * cos _direction,0]]) exitWith {
			_isClear = false
		};
	};
	_isClear
};

fnc_getSurfaceTypes = {
	params ["_upper","_step"];
	_types = [];
	for "_xValue" from 0 to _upper step _step do {
		for "_yValue" from 0 to _upper step _step do {
			_types pushBackUnique (surfaceType [_xValue,_yValue])
		};
	};
	_types
};

{
	diag_log _x
} forEach ([10000,100] call fnc_getSurfaceTypes);

// tanoa

 9:26:54 "#GdtSeabed"
 9:26:54 "#GdtBeach"
 9:26:54 "#GdtGrassShort"
 9:26:54 "#GdtGrassTall"
 9:26:54 "#GdtRedDirt"
 9:26:54 "#GdtForest"
 9:26:54 "#GdtAsphalt"
 9:26:54 "#GdtRock"
 9:26:54 "#GdtVolcano"
 9:26:54 "#GdtVolcanoBeach"

nearestObjects [player,["Building"],0.9 * horde_gvar_scanRadius]
2.89855 ms
nearestTerrainObjects [player, ["BUILDING","HOUSE","CHURCH","CHAPEL","CROSS","BUNKER","FORTRESS","FOUNTAIN","VIEW-TOWER","LIGHTHOUSE","QUAY","FUELSTATION","HOSPITAL","TRANSMITTER","STACK","RUIN","TOURISM","WATERTOWER","POWERSOLAR","POWERWAVE","POWERWIND"],0.9 * horde_gvar_scanRadius,false]
1.16414 ms

https://forums.bistudio.com/topic/192702-any-way-to-filter-small-roads-on-tanoa/?p=3065454

0.0049 ms

_ffvTurrets = allTurrets [_veh,true] - allTurrets [_veh,false];


fnc_isTurnOutTurret = {
	// getin EH provides turretpath on (_this select 3)
	_isTurnOut = false;
	_array = [];
	_role = assignedVehicleRole _this;
	if (count _role > 1) then {
	   _path = _role select 1;
		_cfgTurrets = configfile >> "CfgVehicles" >> (typeOf vehicle player) >> "Turrets";
		{
			_cfgTurrets = _cfgTurrets / configName (_cfgTurrets select _x);
		} forEach _path;
		_array = getArray (_cfgTurrets / "TurnOut" / "limitsArrayBottom");
		if not (_array isEqualTo []) then {
			_isTurnOut = true
		};
	};
	_isTurnOut
};

player sideChat format ["isTurnOut %1", player call fnc_isTurnOutTurret];



_cfgTurrets = configfile >> "CfgVehicles" >> (typeOf _veh) >> "Turrets";
{
	_cfgTurrets = _cfgTurrets / configName (_cfgTurrets select _x);
} forEach _path;
if not (getArray (_cfgTurrets / "TurnOut" / "limitsArrayBottom") isEqualTo []) then {
	_unit action ["TurnOut",_veh];
};

{
	_path = _x;
	_unit = _veh turretUnit _path;
	if not (isNull _unit) then {

		_cfgTurrets = _cfgVeh / "Turrets";
		{
			_cfgTurrets = _cfgTurrets / configName (_cfgTurrets select _x);
		} forEach _path;
		if not (getArray (_cfgTurrets / "TurnOut" / "limitsArrayBottom") isEqualTo []) then {
			_unit action ["TurnOut",_veh];
		};
	};
} forEach ([[-1]] + allTurrets [_veh,true]);

test_fnc = {
	_cfgVeh = configFile / "cfgVehicles" / (typeOf _this);
	{
		_path = _x;
		_unit = _this turretUnit _path;
		if not (isNull _unit) then {
			_cfgTurrets = _cfgVeh / "Turrets";
			{
				_cfgTurrets = _cfgTurrets / configName (_cfgTurrets select _x);
			} forEach _path;
			if not (getArray (_cfgTurrets / "TurnOut" / "limitsArrayBottom") isEqualTo []) then {
				_unit action ["TurnOut",_veh];
			} else {
				if (getNumber(_cfgTurrets / "forceHideGunner") == 0) then {
					_unit action ["TurnOut",_this];
				};
			}
		};
	} forEach (allTurrets [_this,true]);
}; vehicle player call test_fnc

test_fnc = {
	_cfgVeh = configFile / "cfgVehicles" / (typeOf _this);
	{
		_path = _x;
		_unit = _this turretUnit _path;
		if not (isNull _unit) then {
			_cfgTurrets = _cfgVeh / "NewTurret";
			if (_forEachIndex > 0) then {
				_cfgTurrets = _cfgVeh / "Turrets";
				{
					_cfgTurrets = _cfgTurrets / configName (_cfgTurrets select _x);
				} forEach _path;
			};

			if not (getArray (_cfgTurrets / "TurnOut" / "limitsArrayBottom") isEqualTo []) then {
				_unit action ["TurnOut",_veh];
			} else {
				if (getNumber(_cfgTurrets / "forceHideGunner") == 0) then {
					_unit action ["TurnOut",_this];
				};
			}
		};
	} forEach ([[-1]] + allTurrets [_this,true]);
}; vehicle player call test_fnc

test_fnc = {
	diag_log format ["typeOf _this %1", typeOf _this];
	_cfgVeh = configFile / "cfgVehicles" / (typeOf _this);
	{
		_path = _x;
		_unit = _this turretUnit _path;
		if not (isNull _unit) then {
			diag_log format ["_unit %1", _unit];
			_cfgTurrets = _cfgVeh / "NewTurret";
			if (_forEachIndex > 0) then {
				_cfgTurrets = _cfgVeh / "Turrets";
				{
					_cfgTurrets = _cfgTurrets / configName (_cfgTurrets select _x);
				} forEach _path;
			};
			diag_log format ["_cfgTurrets %1", _cfgTurrets];
			diag_log format ["getArray (_cfgTurrets / TurnOut / limitsArrayBottom) %1", getArray (_cfgTurrets / "TurnOut" / "limitsArrayBottom")];
			if not (getArray (_cfgTurrets / "TurnOut" / "limitsArrayBottom") isEqualTo []) then {
				_unit action ["TurnOut",_this];
			} else {
				diag_log format ["getNumber(_cfgTurrets / forceHideGunner) %1", getNumber(_cfgTurrets / "forceHideGunner")];
				if (getNumber(_cfgTurrets / "forceHideGunner") == 0) then {
					_unit action ["TurnOut",_this];
				};
			}
		};
	} forEach ([[-1]] + allTurrets [_this,true]);
}; cursorObject call test_fnc





			if (_zoneName =="Hordezone_7") then {
				fnc_searchRoads = {
					private ["_testRoad"];
					{
						_testRoad = (_x nearRoads 1) select 0;
						/*_testRoad setVariable ["test",true];
						diag_log (_testRoad getVariable ["test",false]);*/
						if (not (_testRoad in gvar_checkedRoads)
							and {_testRoad in ((_this nearRoads 35) - [_this])}
						) then {
							gvar_checkedRoads pushBackUnique _testRoad;
							if (gvar_currPositions pushBackUnique _x > -1) then {
								diag_log format ["gvar_currPositions %1",gvar_currPositions];
								_testRoad call fnc_searchRoads;

							};
						};
					} forEach gvar_positions;
				};
				gvar_masterPositions = [];
				gvar_checkedRoads = [];
				gvar_currPositions = [];
				{

					_road = (_x nearRoads 1) select 0;
					if not (_road in gvar_checkedRoads) then {
						gvar_checkedRoads pushBack _road;
						_road call fnc_searchRoads;
						diag_log format ["COMPARING - gvar_currPositions %1",gvar_currPositions];
						diag_log format ["COMPARING - gvar_masterPositions %1",gvar_masterPositions];
						if (count gvar_currPositions > count gvar_masterPositions) then {
							gvar_masterPositions = + gvar_currPositions;
							diag_log format ["gvar_masterPositions %1",gvar_masterPositions];
							gvar_currPositions = [];
						};
					};
				} forEach gvar_positions;

				_positions = gvar_masterPositions; /* call horde_fnc_arrayShuffle;*/

				diag_log format ["gvar_positions %1",count gvar_positions];
				diag_log format ["gvar_masterPositions %1",count gvar_masterPositions];
				diag_log format ["gvar_positions %1",gvar_positions];
				diag_log format ["gvar_masterPositions %1",gvar_masterPositions];

				{
					_mkr = createMarker ["master" + str _x,_x];
					_mkr setMarkerSize [10, 10];
					_mkr setMarkerShape "Ellipse";
					_mkr setMarkerBrush "SolidBorder";
					_mkr setMarkerColor "ColorBlack";
					_mkr setMarkerAlpha 1;
				} forEach gvar_masterPositions;

				{
					_mkr = createMarker ["position" + str _x,_x];
					_mkr setMarkerSize [15, 15];
					_mkr setMarkerShape "Ellipse";
					_mkr setMarkerBrush "SolidBorder";
					_mkr setMarkerColor "ColorYellow";
					_mkr setMarkerAlpha 0.5;
				} forEach gvar_positions;
			};

horde_fnc_scanCircleUniformly = {
	params ["_pos","_radius","_limit","_step","_gridValsLand","_gridValsWater","_testPos"];

	_pos params ["_xPos","_yPos"];
	// generate grid
	_gridValsLand = [];
	_gridValsWater = [];
	/*diag_log format ["- %1",round (_xPos - _radius)];
	diag_log format ["+ %1",round (_xPos + _radius)];*/
	for "_xValue" from (round (_xPos - _radius)) to (round (_xPos + _radius)) step _step do {
		for "_yValue" from (round (_yPos - _radius)) to (round (_yPos + _radius)) step _step do {
			_testPos = [_xValue,_yValue];
			/*diag_log format ["testPos %1",_testPos];*/
			if (_testPos distance2D _pos < _limit) then {
				if (surfaceIsWater _testPos) then {
					_gridValsWater pushBack _testPos;
				} else {
					_gridValsLand pushBack _testPos;
				};
			};
		};
	};
	[_gridValsLand,_gridValsWater]
};

if (_zoneName == "Hordezone_7") then {

	fnc_waterBetweenPoints = {
		params ["_pos1","_pos2","_step"];
		_isWater = false;
		_dir = _pos1 getDir Pos2;
		for "_dist" from 0 to round (_pos1 distance2D _pos2) step _step do {
			_testPos = _pos1 getPos [_dist,_dir];
			if (surfaceIsWater _testPos) exitWith {
				_isWater = true;
			};
		};
		_isWater
	};


	f_coords = [_zonePosASL,1000,1000,100] call horde_fnc_scanCircleUniformly;
	f_index = 0;
	fnc_searchLandMasses = {
		{
			if (_x distance _this < 150
				and {not (_x isEqualTo _this)}
				and {not (_x in f_checked)}
				and {not [_x,_this,20] call fnc_waterBetweenPoints}
			) then {
				if (f_array pushBackUnique _x > -1) then {
					_x call fnc_searchLandMasses;
				};
			};
		} forEach f_coords;
	};
	f_checked = [];
	{
		f_array = [];
		_x call fnc_searchLandMasses;
		if (count f_array > count (missionSpace getVariable ["f_landMassArray" + str f_index,[]])) then {
			missionSpace setVariable ["f_landMassArray" + str f_index,+f_array];
			f_index = f_index + 1;
		};
		f_checked pushBack _x;
	} forEach f_coords;

	for "_i" from 0 to 10 do {
		_arr = missionSpace getVariable ["f_landMassArray" + str f_index,[]];
		if (_arr isEqualTo []) exitWith {
			diag_log format ["no array %1",_i];
		};
		diag_log format ["var f_landMassArray%1",_1];
		diag_log format ["arr %1",_arr];
		{
			_mkr = createMarker ["masterland" + str _x,_x];
			_mkr setMarkerSize [10, 10];
			_mkr setMarkerShape "Ellipse";
			_mkr setMarkerBrush "SolidBorder";
			_mkr setMarkerColor "ColorBlack";
			_mkr setMarkerAlpha 1;
		} forEach _arr;
	};
};

// change ncb_pv_playerSpawnPlaces to markers!!!

run new function to check for different land masses

If a zone has more than one land mass - then it will need to calculate waypoints and spawn positions accordingly

Also - these type of zones will have to use amphibious units/vehicles to patrol them

Note: What about zones with different land masses but connected by bridge?

check which land masses are connected by searching for the ends of the bridge

nearestTerrainObjects [player, ["hide"], 100];  // finds bridges

so find different land masses, then run the spawn points over them.  Look for roads on same land mass or connected land mass and add the JUNCTIONS and ENDS to an array the positions can use for waypoints.  So there is a set of spawn positions with normal waypoints for infantry and another set of road waypoints for vehicles


{
  if (isPlayer _x) exitWith {true};
  false
} count [m1,m2,m3];

0.0072 ms

{if (isPlayer _x) exitWith {1}} count [m1,m2,m3] isEqualTo 0

0.0068 ms

{isPlayer _x} count [m1,m2,m3] isEqualTo 0

0.0054 ms


{
  if (isPlayer _x) exitWith {true};
  false
} count [m1,player,m3];

0.0063 ms

{if (isPlayer _x) exitWith {1}} count [m1,player,m3] isEqualTo 0

0.0062 ms

{isPlayer _x} count [m1,player,m3] isEqualTo 0

0.0057 ms

this addEventHandler ["Fired",{
	_ammo = (_this select 4);
	if (_ammo isKindOf "BulletCore"
		or {_ammo isKindOf "ShellCore"}
	) then {
	  (_this select 6) setVelocity ((velocity (_this select 6)) vectorDiff (velocity (_this select 0)));
	};
}];

this addEventHandler ["Fired",{
	systemChat format ["%1",_this];
	(_this select 6) setVelocity ((velocity (_this select 6)) vectorDiff (velocity (_this select 0)));
}];

this addEventHandler ["Fired",{
	systemChat format ["%1",_this];
	(_this select 6) setVelocity ((velocity (_this select 6)) vectorDiff (velocity (_this select 0)));
}];

_array1 = getArray (configFile / "CfgZones" / "Tanoa" / "hordezone_11" / "Beachhead" / "ingressDataASL")

0.028 ms

player setVariable ["someName",getArray (configFile / "CfgZones" / "Tanoa" / "hordezone_11" / "Beachhead" / "ingressDataASL")];

_array1 = player getVariable ["someName",[]];

0.0023 ms

_array1 = + (player getVariable ["someName",[]]);

0.0111 ms

player addEventHandler ["WeaponRested",{systemChat format ["%1",_this]}]

parsingNamespace setVariable ["someName",getArray (configFile / "CfgZones" / "Tanoa" / "hordezone_11" / "Beachhead" / "ingressDataASL")];
missionNamespace setVariable ["someName",getArray (configFile / "CfgZones" / "Tanoa" / "hordezone_11" / "Beachhead" / "ingressDataASL")];
uiNamespace setVariable ["someName",getArray (configFile / "CfgZones" / "Tanoa" / "hordezone_11" / "Beachhead" / "ingressDataASL")];

_array1 = + (parsingNamespace getVariable ["someName",[]]);
0.0091 ms
_array1 = + (missionNamespace getVariable ["someName",[]]);
0.0092 ms
_array1 = + (uiNamespace getVariable ["someName",[]]);
0.0092 ms

// Main keydown check
keydown_fnc = {
	//This block is ran for every key pressed while in game.  Dont do much (or any) evaluation here.
	//If you already have code for detecting keypresses I reccomend you MOVE lines 15 to 21 there and DELETE lines 62 to 64.
	switch (_this) do {
		{
			case _x: {
				[] spawn ANIM_jump;
			};
		} foreach actionkeys "GetOver";
	};
};

ANIM_jump = {
	if (speed player > 8
		&& {vehicle player == player}
		&& {isTouchingGround player}
		&& {getfatigue player < 0.80}
		&& {player getvariable["ANIM_jump_ready",true]}
	) then {
		player setvariable ["ANIM_jump_ready",false];
		[player,""] remoteexec ['switchMove'];//Stop the regular climbover animation.
		_height = 5-((load player)*4.25);   //"5-" is the starting upwards acceleration. Keep between 4-7. Higher numbers means more altitude.
											//"*4.25" is the weight penalty curve.  Keep between 0-15.  Higher numbers means more penalty for having weight.
		_speed = 0.5;   //This is the added forward velocity during the jump.
						//0 will cause the person jumping to rely on their forward momentum.  Adding to it "pushes" them forward during the jump.  Numbers past 5 cause injury.

		//Math!
		player setVelocity [
			(velocity player select 0) + (sin direction player *_speed),
			(velocity player select 1) + (cos direction player *_speed),
			(velocity player select 2) + _height
		];
		// for X and Y we are taking the original velocity of the player and propeling them the direction they face with _speed.
		// for Z we are just taking their original velocity (in case of hill, etc) and adding the load adjusted jump _height above.

		[player,"AovrPercMrunSrasWrflDf"] remoteexec ['switchMove'];
		player setFatigue (getfatigue player + 0.2); //Here we cause fatigue.
		waitUntil {isTouchingGround player};
		sleep 0.1;
		player setvariable ["ANIM_jump_ready",true]; //Re-enable the jump.
	};

	//This bottom block is to avoid issues with pushing the button while mid air.  Without it, a repeat push will cause the slow climb over when youve landed.
	if !((isTouchingGround player) && (player getvariable["ANIM_jump_ready",true])) then {
	waitUntil {(animationState player == "AovrPercMstpSrasWrflDf")};
	player switchMove "";
	};
};

//Start the EH to trigger keydown_fnc
waituntil {!isnull (finddisplay 46)};
(findDisplay 46) displayAddEventHandler ["KeyDown","_this select 1 call keydown_fnc;false;"];

E:\Applications\swapadd\swapadd.exe R:\pagefile.sys 4096M 4096M

// vars

playerAntiButtonSpam = 0;
playerLastRespawnTime = 0;
ncb_gv_playerCharges = [[],[]];
playerOnTruckerPills = nil;
ncb_gv_playerBleedingRate = 0;
ncb_gv_playerLastBullet = objNull;
ncb_gv_playerLodgedBullets = 0;
ncb_gv_playerFood = 100;
ncb_gv_playerWater = 100;

// skills

player setVariable ["skillCook",[0,0]];
player setVariable ["skillEngineer",[0,0]];
player setVariable ["skillFuelling",[0,0]];
player setVariable ["skillLogistics",[0,0]];
player setVariable ["skillSurgeon",[0,0]];
player setVariable ["skillTyreFitter",[0,0]];
player setVariable ["skillMagazineFitter",[0,0]];
player setVariable ["skillWeaponFitter",[0,0]];

// equip

removeAllContainers player;
removeAllWeapons player;
removeHeadgear player;
removeGoggles player;
removeAllAssignedItems player;
player forceAddUniform "U_B_Wetsuit";
player addBackpackGlobal "Diver_Pack";
_cfgWeapons = configFile / "cfgWeapons";
_weapons = [];

// filter by slots

_slotsMax = 99;
{
	if (count getArray (_cfgWeapons / _x / "muzzles") < 2
		and {not (isClass (_cfgWeapons / _x / "opticsmodes"))}
	) then {
		_slots = 0;
		{
			_cfgCompatibleItems = _x / "compatibleItems";
			if (isArray _cfgCompatibleItems) then {
				if not (_cfgCompatibleItems isEqualTo []) then {
					_slots = _slots + 1;
				};
			} else {
				if (isClass _cfgCompatibleItems) then {
					if not (configProperties [_cfgCompatibleItems,"isNumber _x"] isEqualTo []) then {
						_slots = _slots + 1;
					};
				};
			};
		} forEach configProperties [
			_cfgWeapons / _x / "WeaponSlotsInfo",
			"isClass _x",
			true
		];
		if (_slots < _slotsMax) then {
			_weapons = [_x];
			_slotsMax = _slots;
		} else {
			if (_slots == _slotsMax) then {
				_weapons pushBack _x
			}
		}
	};
} forEach (ncb_gv_crateRiflesTier_0 + ncb_gv_crateRiflesTier_1);

// now filter by ammo count
_weapons2 = [];
_currentCount = 999999;
{
	if (getNumber (configFile / "CfgMagazines" / ((configFile / "CfgWeapons" / _x / "magazines") select 0) / "count") < _currentCount) then {
		_weapons2 = [_x]
	} else {
		if (getNumber (configFile / "CfgMagazines" / ((configFile / "CfgWeapons" / _x / "magazines") select 0) / "count") == _currentCount) then {
			_weapons2 pushBack _x
		}
	}
} forEach _weapons;

_weapon = selectRandom _weapons;
_mags = getArray (_cfgWeapons / _weapon / "magazines");
_mags = _mags select {getText (configFile / "CfgAmmo" / (getText (configFile / "CfgMagazines" / _x / "ammo")) / "effectFly") != "AmmoUnderwater"};
player addMagazines [_mags select 0,3];
player addWeapon _weapon;
_weapon = ncb_gv_cratePistolsTier_0 select 0;
player addMagazines [getArray (_cfgWeapons / _weapon / "magazines") select 0,2];
player addWeapon _weapon;
for "_i" from 1 to 3 do {player addItem "ItemBandage"};
for "_i" from 1 to 1 do {player addItem "ItemFirstAidKit"};
for "_i" from 1 to 2 do {player addItem "MiniGrenade"};
player addVest "V_RebreatherB";
player addGoggles "G_O_Diving";
if (ncb_param_playerStartMap == 1) then {
	player linkItem "ItemMap";
};
if (ncb_param_playerStartRadio == 1) then {
	player linkItem "ItemRadio";
};
player linkItem "ItemWrench";

// spawn pos

0 call horde_fnc_selectRespawnPos params ["_respawnPos","_respawnDir"];

player setPosATL _respawnPos;
player setVectorUp surfaceNormal _respawnPos;
player setDir _respawnDir;
[player,"AmovPpneMstpSrasWrflDnon"] remoteExecCall [
	"horde_fnc_switchMoveGlobal",
	0
];

getNumber (configFile / "CfgMagazines" / (getArray (configFile / "CfgWeapons" / _x / "magazines") select 0) / "count") < _currentCount)

22:35:58 Error: EntityAI SubSkeleton index was not initialized properly (repeated 191x in the last 60sec)
22:35:58 name: Land_FuelStation_01_workshop_F, shape: a3\structures_f_exp\commercial\fuelstation_01\fuelstation_01_workshop_f.p3d, index: -1, matrices: 1
22:36:54 Loading movesType CfgMovesSnakes_F
22:37:22 Error: EntityAI SubSkeleton index was not initialized properly (repeated 167x in the last 60sec)
22:37:22 name: Land_Shop_City_03_F, shape: a3\structures_f_exp\commercial\shop_city_03\shop_city_03_f.p3d, index: -1, matrices: 4
22:38:17 DX11 error : CreateTexture failed : E_OUTOFMEMORY
22:38:17 DX11 error : CreateTexture failed : E_OUTOFMEMORY
22:38:17 DX11 error : CreateTexture failed : E_OUTOFMEMORY
22:38:17 DX11 error : CreateTexture failed : E_OUTOFMEMORY
22:38:17 DX11 error : CreateTexture failed : E_OUTOFMEMORY
22:38:17 DX11 error : CreateTexture failed : E_OUTOFMEMORY
22:38:17 DX11 error : CreateTexture failed : E_OUTOFMEMORY
22:38:17 DX11 error : CreateTexture failed : E_OUTOFMEMORY
22:38:17 DX11 error : CreateTexture failed : E_OUTOFMEMORY
22:38:17 DX11 error : CreateTexture failed : E_OUTOFMEMORY
22:38:17 CreateTexture failed : w = 2048, h = 2048, format = BC1_UNORM, err = E_OUTOFMEMORY.
22:38:17 DX11 error : CreateTexture failed : E_OUTOFMEMORY
22:38:17 Virtual memory total 4095 MB (4294836224 B)
22:38:17 Virtual memory free 164 MB (172306432 B)
22:38:17 Physical memory free 4810 MB (5044551680 B)
22:38:17 Page file free 3869 MB (4057964544 B)
22:38:17 Process working set 1695 MB (1777594368 B)
22:38:17 Process page file used 3431 MB (3598106624 B)
22:38:17 Longest free VM region: 5566464 B
22:38:17 VM busy 4140195840 B (reserved 215633920 B, committed 3924561920 B, mapped 228495360 B), free 154640384 B
22:38:17 Small mapped regions: 27, size 122880 B
22:38:17 VID: dedicated: 3221225472, shared 1073676288, system: 0, max: 2906652672, used: 2770108416
ErrorMessage: DX11 error : CreateTexture failed : E_OUTOFMEMORY

change video ram setting


addMissionEventHandler ["EachFrame", {
	removeMissionEventHandler ["EachFrame",_thisEventHandler]
}];

0.0015 ms

addMissionEventHandler ["EachFrame",
	 format ["%1 call {params ['_one','_two']; diag_log _one;diag_log _two}",["someArgs",666]]
];

addMissionEventHandler ['EachFrame',
	format ['%1 call horde_fnc_playerSetNeeds',[time + 2,_thisEventHandler]]
];

addMissionEventHandler ['EachFrame',
	format ['[%1,_thisEventHandler] call horde_fnc_playerSetNeeds',time + 2]
];

addMissionEventHandler ['EachFrame',
	format ['diag_log _thisEventHandler',[_thisEventHandler]]
];

addMissionEventHandler ['EachFrame',
	format ['([_thisEventHandler] append %1) call horde_fnc_playerMonitor',[time + 0.1]]
];

params [];

SOMEOBJECTS = [];

private _thisEventHandler = addMissionEventHandler [
	'EachFrame',
	format [
		'([_thisEventHandler] + %1) call %2',
		[/* some params */],
		{
		}
	]
];

missionNamespace setVariable ["ncb_gv_ehIdArgs_" + str _thisEventHandler,/*SOMEOBJECTS*/];


#define ind0 ""
#define ind1 "  "
#define ind2 "      "
#define ind3 "          "
#define ind4 "              "
#define ind5 "                  "
#define ind6 "                      "
#define ind7 "                          "
#define qty_2(a) a, a

"mb_fileio" CallExtension "open_w|config_dump.txt";

"mb_fileio" CallExtension Format["write|/* %1 %2.%3 */", ProductVersion select 0, ProductVersion select 2, ProductVersion select 3];

"mb_fileio" CallExtension Format["write|%1%2", _indents select _depth, _this];

"mb_fileio" CallExtension "close";

Think about weather

setRain is Server only
setFog is Server only
SetOvercast controls wind
setWind is server only
setDate is Server only
timeMultiplier affects transition time:
(transtime * timeMultiplier) setOvercast 1

{
	if (not isPlayer _x and {_x distance2D player <1200}) then {
		_x setDamage 1
	}
} forEach allUnits

_zoneName = "Hordezone_44";
_cfgZone = configFile >> "CfgZones" >> worldName >> _zoneName;
_cfgHeliData = _cfgZone >> "QuickReactionForceHeli";
_originArr = getArray (_cfgHeliData >> "origins");
_originPosASL = selectRandom _originArr;
_destLand = getArray (_cfgHeliData >> "destinationLand");
_emptyPlacesASL = getArray (_cfgZone >> "EmptyPlaces" >> "EmptyPlacesASL_20");
_reinforceDist = 100;
_reinforceDir = 90;
_vehSpawnPosASL = [
	(_originPosASL select 0) + _reinforceDist * sin _reinforceDir,
	(_originPosASL select 1) + _reinforceDist * cos _reinforceDir,
	(_originPosASL select 2) + 100
];

_randDir = round random 359;
_randDist = 100 + random 200;
_patrolPosATL = [
	(_destLand select 0) + _randDist * sin _randDir,
	(_destLand select 1) + _randDist * cos _randDir,
	100
];

_overshootPosATL = _vehSpawnPosASL getPos [
	(_vehSpawnPosASL distance2D _patrolPosATL) + 700,
	_vehSpawnPosASL getDir _patrolPosATL
];

_overShootPosATL set [2,100];

_mkr = createMarker [_zoneName + "_m1_" + str _vehSpawnPosASL,_vehSpawnPosASL];
_mkr setMarkerSize [20,20];
_mkr setMarkerShape "Ellipse";
_mkr setMarkerBrush "Solid";
_mkr setMarkerColor "ColorWhite";
_mkr setMarkerAlpha 1;

_mkr = createMarker [_zoneName + "_m2_" + str _vehSpawnPosASL,_vehSpawnPosASL];
_mkr setMarkerType "hd_dot";
_mkr setMarkerColor "ColorBlack";
_mkr setMarkerAlpha 1;
_mkr setMarkerText format ["_vehSpawnPosASL %1",_vehSpawnPosASL];

_mkr = createMarker [_zoneName + "_m1_" + str _patrolPosATL,_patrolPosATL];
_mkr setMarkerSize [10,10];
_mkr setMarkerShape "Ellipse";
_mkr setMarkerBrush "Solid";
_mkr setMarkerColor "ColorGreen";
_mkr setMarkerAlpha 1;

_mkr = createMarker [_zoneName + "_m2_" + str _patrolPosATL,_patrolPosATL];
_mkr setMarkerType "hd_dot";
_mkr setMarkerColor "ColorBlack";
_mkr setMarkerAlpha 1;
_mkr setMarkerText format ["_patrolPosATL %1",_patrolPosATL];

_mkr = createMarker [_zoneName + "_m1_" + str _overShootPosATL,_overShootPosATL];
_mkr setMarkerSize [10,10];
_mkr setMarkerShape "Ellipse";
_mkr setMarkerBrush "Solid";
_mkr setMarkerColor "ColorBlue";
_mkr setMarkerAlpha 1;

_mkr = createMarker [_zoneName + "_m2_" + str _overShootPosATL,_overShootPosATL];
_mkr setMarkerType "hd_dot";
comment "mil_arrow";
_mkr setMarkerColor "ColorBlack";
_mkr setMarkerAlpha 1;
_mkr setMarkerText format ["_overShootPosATL %1",_overShootPosATL];



for "_i" from 1 to 4 do {
	private _pos = [
		(_patrolPosATL select 0) + (random 1600) - 800,
		(_patrolPosATL select 1) + (random 1600) - 800,
		100
	];
	_mkr = createMarker [_zoneName + "_testMkr_" + str _pos + str _i,_pos];
	_mkr setMarkerSize [10,10];
	_mkr setMarkerShape "Ellipse";
	_mkr setMarkerBrush "Solid";
	_mkr setMarkerColor "ColorOrange";
	_mkr setMarkerAlpha 1;

	_mkr = createMarker [_zoneName + "_m3_" + str _pos + str _i,_pos];
	_mkr setMarkerType "hd_dot";
	_mkr setMarkerColor "ColorBlack";
	_mkr setMarkerAlpha 1;
	_mkr setMarkerText format ["_patrol %1",_pos];
};

save position of runways to change spawns for zones with airstrips.

This is seperate to gvt airbases and is just designed to make snipers spawn near the airstrip by saving the runway centre and radius to use in server init when generating sniper positions.

ISSUES

Vehicles get damaged but crew do not repair them

passenger units seem to jump out at weird times

Maybe alter logic to regard renegades as threat to opfor (so they react properly etc)

No reloading logic for renegade vehicles

No reloading logic for opfor not in combat with players but in combat with renegades.

update some of the zone & building configs

Not much military stuff on tanoa

Leader of qrf boats teleports back in water (not an issue now they are divers - comment out code)

Maybe assignSs.... in horde_fnc_spawnVehicle - also could not waiting for the vehicle to be spawned be a problem?

Make the cool fortress on tanoa at Lijnhaven spawn loot.  Heres how:

str cursorObject splitString ": " select 1 splitstring "." select 0
returns a string of the model
now compare against the model entry in configs

fnc_getClassFromObject = {
	_str = str cursorObject splitString ": " select 1 splitstring "." select 0;
	diag_log format ["_str %1",_str];
	_class = "";
	{
		diag_log format ["model %1",getText (_x >> "model")];
		if (toLower getText (_x >> "model") find _str > -1) exitWith {
			_class = configName _x
		};
	} forEach configProperties [
		configFile >> "CfgVehicles",
		"configName _x isKindOf 'Static'"
	];
	_class
};
systemChat format ["class %1",0 call fnc_getClassFromObject];

fnc_getClassFromObject = {
	_str = str cursorObject splitString ": " select 1 splitstring "." select 0;
	_class = "";
	{
		if (toLower getText (_x >> "model") find _str > -1) exitWith {
			_class = configName _x
		};
	} forEach configProperties [
		configFile >> "CfgVehicles",
		"isClass _x"
	];
	_class
};
systemChat format ["class %1",0 call fnc_getClassFromObject];

fnc_getClassFromObject = {
	_str = str cursorObject splitString ": " select 1;
	_class = "";
	{
		if (toLower getText (_x >> "model") find _str > -1) exitWith {
			_class = configName _x
		};
	} forEach configProperties [
		configFile >> "CfgVehicles",
		"isClass _x"
	];
	_class
};
systemChat format ["class %1",0 call fnc_getClassFromObject];

// slow version

fnc_getClassFromObject = {
	_str = str cursorObject splitString ": " select 1;
	_class = "";
	{
		_arr = getText (_x >> "model") splitString "\";
		if not (_arr isEqualTo []) then {
			_str2 = _arr select (count _arr - 1);
			if (_str == _str2) exitWith {
				_class = configName _x
			};
		};
	} forEach configProperties [
		configFile >> "CfgVehicles",
		"isClass _x"
	];
	_class
};
systemChat format ["class %1",0 call fnc_getClassFromObject];

// configClass version


Update some of the spawn positions for boats in zone_builder

22:37:56 Error in expression <sTurret (assignedVehicleRole _commander select 1);
if (_weap in _weapons) then {>
22:37:56   Error position: <select 1);
if (_weap in _weapons) then {>
22:37:56   Error Zero divisor
22:37:56 File E:\Documents\Arma 3 - Other Profiles\Horde\mpmissions\##Nocebo_new_inidbi2.Tanoa\common\getOutVehicle.sqf, line 44

REPLICATED ERROR BY SITTING IN DRIVER SEAT OF STRIDER AND CALLING:

(vehicle player) weaponsTurret ((assignedVehicleRole commander vehicle player) select 1)

_veh = vehicle player;
_commander = commander _veh;
if (not isNull _commander) then {
	_weapons = _veh weaponsTurret (assignedVehicleRole _commander select 1);
};

removed all references to selecting the leader of group by effectiveCommander (as a test)

setVelocity [0,0,0] when player dies maybe...

remove player waypoint on death (the one yoou click to place)

Have special loot spawns (srtup at beginning of game and managed by trigger/fsm)


{
	if (true) exitWith {
		player setPos getPos _x
	};
} forEach (nearestObjects [player,["Land_PillboxBunker_01_big_F"],5000])

if you gut a fish in the water, it uses bad anim and stops you from swimming

{
	if (toLower str _x find "o alpha 4" > -1) then {
		diag_log format ["rating %1",(units _x) apply {rating _x}];
		diag_log format ["classes %1",(units _x) apply {typeOf _x}];
		diag_log format ["grpData %1",_x getVariable ["groupData","none"]];
		diag_log format ["waypoints %1",waypoints _x];
		diag_log format ["waypointPos %1",waypoints _x apply {waypointPosition _x}]
	}
} forEach allGroups

{
	if (true) then {
		diag_log "";
		diag_log "";
		diag_log format ["SIDE %1",(side _x)];
		diag_log format ["units %1",(units _x)];
		diag_log format ["rating %1",(units _x) apply {rating _x}];
		diag_log format ["classes %1",(units _x) apply {typeOf _x}];
		diag_log format ["grpData %1",_x getVariable ["groupData","none"]];
		diag_log format ["waypoints %1",waypoints _x];
		diag_log format ["waypointPos %1",waypoints _x apply {waypointPosition _x}];
		diag_log format ["current WP idx %1",currentWaypoint _x];
		diag_log "";
		diag_log "";
	}
} forEach allGroups

Vyron Manetta > Greek name!

14:32:16 "rating [500]"
14:32:16 "classes [""Horde_renegadeUnit""]"
14:32:16 "grpData none"
14:32:16 "waypoints [[O Alpha 4-2,0]]"
14:32:16 "waypointPos [[1000,0,9.95163]]"


player setCaptive true;
player linkItem "ItemMap";
0 = 0 spawn {
	while {true} do {
		{
			if ({alive _x} count units _x == 1
				and {side _x == east}
				and {isNil {_x getVariable "groupData"}}
			) then {
				playSound3D [
					"a3\sounds_f\sfx\Beep_Target.wss",
					vehicle player,
					false,
					position player,
					2,
					1,
					0
				];
				sleep 1;
				playSound3D [
					"a3\sounds_f\sfx\Beep_Target.wss",
					vehicle player,
					false,
					position player,
					2,
					1,
					0
				];
				sleep 1;
				playSound3D [
					"a3\sounds_f\sfx\Beep_Target.wss",
					vehicle player,
					false,
					position player,
					2,
					1,
					0
				];
				player globalChat "**** bad group created ****";
				systemchat "**** bad group created ****";
			}
		} forEach allGroups;
		sleep 1;
	};
};

https://forums.bistudio.com/topic/149731-created-group-becomes-null-group/#post2438215

SOLVED ISSUE (I THINK)

Vehicle spawns in a bad place and blows up

Driver is assigned to vehicle and dies

Killed EH is called and deletes group

Rest of units then join whatever group as the orig one is null!!!!!

Solution,

// create al-gore-rhythm that checks if position is clear

// if over land, checks xm above the terrain surface
// if over water, checks xm above sea level

0.442282 ms

horde_fnc_positionIsClearASL = {
	params ["_pos","_radius","_height","_step"];
	private _isClear = true;
	private _testPos = [];
	for "_direction" from 0 to 355 step _step do {
		_testPos = _pos getPos [_radius,_direction];
		_testPos set [2,_height];
		if (lineIntersects [_pos,_testPos]) exitWith {
			_isClear = false
		};
	};
	_isClear
};

0.424448 ms

horde_fnc_positionIsClearASL = {
	params ["_p","_r","_h","_s"];
	private _iC = true;
	private _tP = [];
	for "_d" from 0 to 355 step _s do {
		_tP = _p getPos [_r,_d];
		_tP set [2,_h];
		if (lineIntersects [_p,_tP]) exitWith {
			_iC = false
		};
	};
	_iC
};

conds for spawning zone

isMan and not is paracending
or isAir and speed < 200 and not isParachute

check the loot on this: "Land_Airport_01_controlTower_F"

rename first aid kit!!

empty vehicle inv on helis and indy apc strider

grinder trees?

// rgb olive 142 142 56

Shadow distance !!

randomise mags in supply crates (diff ammo counts)

18:41:35 Error in expression <[_this,HordeZone_7,'Baie d'Orange',[11605.2,2164.81,-0.0642974]] ca>
18:41:35   Error position: <Orange',[11605.2,2164.81,-0.0642974]] ca>
18:41:35   Error Missing ]
18:41:35 Error in expression <[_this,HordeZone_7,'Baie d'Orange',[11605.2,2164.81,-0.0642974]] ca>
18:41:35   Error position: <Orange',[11605.2,2164.81,-0.0642974]] ca>
18:41:35   Error Missing ]

thing = "Baie d'Orange";  if (thing find "'" > -1) then {thing = thing splitString "'"  joinstring """'"""}; this addEventHandler ["killed",
		format [
		  "[
		   _this,
		   %1,
		   '%2'
		  ] call {}",
		  "someZone",
		 thing
		 ]
		];



// this one makes pretty patterns

0=0spawn{
	_veh = b1;
	_ticker = time + 60;
	_boost = 4;
	waitUntil {
		_boost = _boost + 0.001;
		_unitVector = (getPos _veh) vectorFromTo (markerPos "mkr1");
		_boostVel = _unitVector vectorMultiply _boost;
		_veh setVectorDir _unitVector;
		_veh setVelocity _boostVel;
		not alive _veh
		or {time > _ticker}
		or {not surfaceIsWater getPos _veh}
		or {terrainIntersectASL [
				getPosASL _veh,
				getPosASL _veh vectorAdd [0,0,-0.1]
			]
		}
	};
};



0=0spawn{
	_veh = b1;
	_veh engineOn true;
	_ticker = time + 60;
	_boost = 4;
	waitUntil {
		_boost = _boost + 1;
		_unitVector = (getPos _veh) vectorFromTo (markerPos "mkr1");
		_boostVel = _unitVector vectorMultiply _boost;
		_veh setVelocity (_unitVector vectorMultiply 15);
		_veh setVectorDir _unitVector;

		hintSilent format ["%1",_unitVector];
		sleep 0.2;
		not alive _veh
		or {time > _ticker}
		or {not surfaceIsWater getPos _veh}
		or {terrainIntersectASL [
				getPosASL _veh,
				getPosASL _veh vectorAdd [0,0,-0.1]
			]
		}
	};
};

_objects = lineIntersectsWith [
	_testPos vectorAdd [0,0,5],
	_testPos vectorAdd [0,0,-5]
];

// eject units from sub

horde_fnc_handleDamageAIBoat = {
	params ["_veh","_selName","_damage","_source","_projClass","_hitPartIndex"];
	systemChat format ["hd fired: %1",_this];
	if (_hitPartIndex > -1) then {
		getAllHitPointsDamage _veh params ["_hpNames"];
		systemChat format ["_hpNames: %1",_hpNames];
		systemChat format ["_hp: %1",_hpNames select _hitPartIndex];
		if (toLower (_hpNames select _hitPartIndex) in ["hitengine","hitbody"]) exitWith {
			if (damage _veh == 1) exitWith {
				_damage = 0
			}
			if (_damage > 0.99) then {
				systemChat format ["damage! - eject: %1",_damage];
				{
					_x action ["eject", _veh]
				} count crew _veh;
				_veh setDamage 1;
				_veh removeAllEventHandlers "handleDamage"
			};
		};
	};
	_damage
};
this addEventHandler ["handleDamage",{_this call horde_fnc_handleDamageAIBoat}];

//////////////////////////////////////////////////////////////


horde_fnc_findRenWaypoints = {
	params ["_testPos","_radius"];
	private _waypointPositions = [];
	{
		params ["_position","_suitability"];
		if (_suitability > 0
			and {not (surfaceIsWater _position)}
		) then {
			private _building = (ATLtoASL _position) call horde_fnc_isPosInEnterableBuilding;
			private _buildingPositions = _building buildingPos -1;
			if (isNull _building or {_buildingPositions isEqualTo []}) then {
				_waypointPositions pushBack _position
			} else {
				_waypointPositions pushBack (selectRandom _buildingPositions)
			};
		};
	} count (selectBestPlaces [
		_testPos,
		_radius,
		"houses + meadow + forest - sea",
		30,
		8
	]);
	_waypointPositions
};






// old!!!!

// randomise destination

_finalPos = _finishPos getPos [35 + random 165,random 359];

// wp 1

_wp = _grp addWaypoint [
	_finalPos,
	0
];
_wp setWaypointBehaviour "AWARE";
_wp setWaypointCombatMode "RED";
_wp setWaypointCompletionRadius 50;
_wp setWaypointSpeed "FULL";

_wp setWaypointStatements ["true",""];
_wp setWaypointType "move";

// wp 2

_finalPos = _finalPos getPos [35 + random 35,random 359];

_wp = _grp addWaypoint [
	_finalPos,
	0
];
_wp setWaypointCombatMode "RED";
_statement = "
	if (local (group this)) then {
		this call horde_fnc_renWaypointComplete
	};
";
_wp setWaypointStatements ["true",_statement];
_wp setWaypointType "SAD";

ncb_gv_renGrps pushBack _grp;

diag_log format ["ren squad ncb_gv_renGrps %1",ncb_gv_renGrps];


{
	_mkr = createMarker [str _this,getPos _this];
	_mkr setMarkerSize [1,1];
	_mkr setMarkerType "hd_dot";
	_mkr setMarkerColor "colorBlack";
	_mkr setMarkerAlpha 1;
	_mkr setMarkerText format ["%1", name _this];
} _buildings = nearestTerrainObjects [
	_position,
	["BUILDING","HOUSE","CHURCH","CHAPEL","BUNKER","FORTRESS","VIEW-TOWER","LIGHTHOUSE","FUELSTATION","HOSPITAL","TRANSMITTER","STACK"],
	300,
	false
];

"Land_Boat_05_wreck_F" >> update this!

boxer truck - no interaction on L rear wheel

{
	_mkr = createMarker [str _x + str random 99999,(_x select 0)];
	_mkr setMarkerSize [1,1];
	_mkr setMarkerType "hd_dot";
	_mkr setMarkerColor "colorBlack";
	_mkr setMarkerAlpha 1;
	_mkr setMarkerText format ["%1", _x];
} count (selectBestPlaces [
	position player,
	500,
	"waterDepth + 20",
	30,
	10
]);

{
	deleteMarker _x
} forEach allMapMarkers;
{
	_mkr = createMarker [str _x + str random 99999,(_x select 0)];
	_mkr setMarkerSize [1,1];
	_mkr setMarkerType "hd_dot";
	_mkr setMarkerColor "colorBlack";
	_mkr setMarkerAlpha 1;
	_mkr setMarkerText format ["%1", _x];
} count (selectBestPlaces [
	position player,
	500,
	"sea - waterDepth + (waterDepth + 1.5)",
	30,
	10
]);

fnc_waterBetweenPoints = {
	params ["_pos1","_pos2","_step"];
	_isWater = false;
	_dir = _pos1 getDir Pos2;
	for "_dist" from 0 to round (_pos1 distance2D _pos2) step _step do {
		_testPos = _pos1 getPos [_dist,_dir];
		if (surfaceIsWater _testPos) exitWith {
			_isWater = true;
		};
	};
	_isWater
};
bestPath = [];
currentDistance = -1;
distToEnd = 99999;
fnc_checkPath = {
	params ["startPos","_endPos","_path","_thisNode"];
	_path pushBack _thisNode;
	{
		_locToCheck = _x;
		if (not (_locToCheck in _path)
			and {not (lineIntersects [AGLtoASL locationPosition (_path select (count _path - 1))),AGLtoASL locationPosition _locToCheck)}
			and {_locToCheck distance2D _endPos  < }
		) then {
			_pathTest =
		};
	} forEach SOME_GRID_OF_LOCS;

};


I thought it might be worth looking at different agents and their properties.  You could (if you want to ofc) define different logics as "emitters" and have a few new config properties to describe how the contaminant works.

So then, your script can pickup on this and apply effects to the player accordingly (whether it is biological, chemical or nuclear based)

In these examples, I am ignoring bodily contact as a vector as I think it might be too hard to determine for the scripter

Something like (maybe)

class Logic;
class NBC_Agent_Base : Logic {};
class Anthrax : NBC_Agent_Base {
	JS_airBorneVector = 1;           // 0=mask not needed 1=mask needed
	JS_contactVector = 3;   // -1=does not transmit by contact - any other number is the distance that the infection can be transmitted from one person to another
	JS_fullBodySuitRequiredForImmunity = 1; //0=not required 1=yes
	JS_incubationPeriod = 300;  // time from initial infection until symptoms manifest
	JS_nbcInitFunction = "JS_fnc_nbcAgentAnthrax";
	JS_remedy[] = {"JS_itemAntibiotics"};
	JS_epicentric = 0; // 0=no epicentre 1=damage highest at epicentre, lowest at circumference
};
class MustardGas : NBC_Agent_Base {
	JS_airBorneVector = 1;
	JS_contactVector = -1;
	JS_fullBodySuitRequiredForImmunity = 1;
	JS_incubationPeriod = 300;
	JS_nbcInitFunction = "JS_fnc_nbcAgentAnthrax";
	JS_remedy[] = {"JS_itemAntibiotics"};
	JS_epicentric = 0;
};
class RadiationSource : NBC_Agent_Base {
	JS_airBorneVector = 1;
	JS_contactVector = -1;
	JS_fullBodySuitRequiredForImmunity = 1;
	JS_incubationPeriod = 0;
	JS_nbcInitFunction = "JS_fnc_nbcAgentRadiation";
	JS_remedy[] = {"JS_itemAntiRadiationPills"};
	JS_epicentric = 1;
};

Loot spawning in vests and uniforms etc

reconfig fuel pumps!

Land_FuelStation_01_pump_F
Land_FuelStation_02_pump_F

done!

//--- Newspapers
_result = if (_newspapers && false) then {
	_newsParams = [["\A3\Missions_PMC\gnews1.p3d", 1, 0, 1], "", "SpaceObject", 1, 5, [0, 0, 1], _velocity, 1, 1.25, 1, 0.2, [0,1,1,1,0], [[1,1,1,1]], [0.7], 1, 0, "", "", _obj];
	_newsRandom = [0, [30, 30, 0], [5, 5, 0], 2, 0.3, [0, 0, 0, 0], 10, 0];
	_newsCircle = [0.1, [1, 1, 0]];
	_newsInterval = 1;

	_times = "#particlesource" createVehicleLocal _pos;
	_times setParticleParams _newsParams;
	_times setParticleRandom _newsRandom;
	_times setParticleCircle _newsCircle;
	_times setDropInterval _newsInterval;

	_newsParams set [0,["\A3\Missions_PMC\gnews2.p3d", 1, 0, 1]];
	_herald = "#particlesource" createVehicleLocal _pos;
	_herald setParticleParams _newsParams;
	_herald setParticleRandom _newsRandom;
	_herald setParticleCircle _newsCircle;
	_herald setDropInterval _newsInterval;

	_newsParams set [0,["\A3\Missions_PMC\gnews3.p3d", 1, 0, 1]];
	_tribune = "#particlesource" createVehicleLocal _pos;
	_tribune setParticleParams _newsParams;
	_tribune setParticleRandom _newsRandom;
	_tribune setParticleCircle _newsCircle;
	_tribune setDropInterval _newsInterval;

	[_ps,_times,_herald,_tribune]
} else {
	[_ps]
};

BIS_fnc_terrainGradAngle  // hmm

Also, add script to keep the moon at full phase every night!


/*fnc_bloodbath = {
	params ["_turntable","_largeSplash","_smallSplash"];

	_turntable = createVehicle ["UserTexture1m_F",_this select 0,[],0,"CAN_COLLIDE"];
	_turntable setPosATL [getPosATL _turntable select 0, (getPosATL _turntable select 1)+10, getPosATL _turntable select 2];
	_turntable hideObjectGlobal true;
	_largeSplash = createSimpleObject ["a3\characters_f\blood_splash.p3d", getPosWorld _turntable];
	_largeSplash setDir random 360;
	_largeSplash attachTo [_turntable];
	_smallSplash = createSimpleObject ["a3\characters_f\data\slop_00.p3d", getPosWorld _turntable];
	_smallSplash setDir random 360;
	_smallSplash attachTo [_turntable];
	_smallSplash setVectorUp surfaceNormal getPosWorld _smallSplash;
	_turntable setDir random 360;

};

[position player] call fnc_bloodBath*/

player remoteExecCall [
	"horde_fnc_serverConfirmLeaveGroup",
	2
];

[_unit,group player] remoteExecCall [
	"horde_fnc_serverConfirmJoinGroup",
	2
];
Dog_Idle_Bark
Dog_Idle_Growl
Dog_Run
dog_sprint


player linkItem "ItemMap";
{
	_mkr = createMarker [str _x,_x select 0];
	_mkr setMarkerSize [10,10];
	_mkr setMarkerShape "Ellipse";
	_mkr setMarkerBrush "SolidBorder";
	_mkr setMarkerColor "ColorRed";
	_mkr setMarkerAlpha 1;
} forEach  ncb_pv_playerSpawnPlaces


2016/09/17, 22:24:38 Error in expression <_veh = ncb_gv_abandonedVehicles select _index;

if (not isNil "_veh" and>
2016/09/17, 22:24:38   Error position: <select _index;

if (not isNil "_veh" and>
2016/09/17, 22:24:38   Error Zero divisor

hmm flaws in logic

1 - if vehicle does not have an abandoned time, then it is removed from the queue and not deleted

2 - if vehicle has abandoned time but is in an active zone, then it will not be deleted until zone is inactive (ok for cars maybe but not boats)

poss solution:

Check into this:  (used in getOut)

_zone  = getVar(_veh,"vehicleAssignedZone");   // var is on server

// seems to be assigned to statics, empty vehicles and qrf vehicles (but not zone patrol vehicles)

// NOT ACTUALLY USED BY ANYTHING EXCEPT GETOUT AND ZONE MANAGER - DOESN@T DO ANYTHING THOUGH!!

// change it so it's assigned to all vehicles and used by garbage collector

ok so, statics need to remain if they are unoccupied and in the zone - same as empty vehs.

But qrf boats and abandoned vehicles can be deleted.

_veh = ncb_gv_abandonedVehicles select _index;

if (not isNil "_veh" and {not isNull _veh}) then {
	_abandonedTime = _veh getVariable ["vehicleAbandonedTime",-1];
	if (_abandonedTime isEqualTo -1 or {not alive _veh}) then {
		// veh is repopulated or destroyed - remove from array
		ncb_gv_abandonedVehicles = ncb_gv_abandonedVehicles - [_veh]
	} else {
		_isBoat = if (_veh isKindOf "Ship_F") then {true} else {false};
		_threshold = if (_isBoat) then {_removeAbandonedBoatTimeout} else {_removeAbandonedVehTimeout};
		if (time > _abandonedTime + _threshold) then {
			// check not in an active zone
			_activeNearZones = (_veh nearEntities ["Zone_Logic",1000]) select {_x getVariable ["zoneIsActive",false]};
			if ([] isEqualTo _activeNearZones) then {
				if (isNull (getPosATL _veh nearestObject "Horde_Land_TentDome_F")
					and {not ([_veh,500] call horde_fnc_playerIsNear)}
				) then {
					{
						deleteVehicle _x
					} count attachedObjects _veh;
					deleteVehicle _veh
				};
			} else {
				// in an active zone - if veh is boat, then delete
				if (_isBoat) then {
					{
						deleteVehicle _x
					} count attachedObjects _veh;
					deleteVehicle _veh
				};
			}
		};
	};
};
_index = _index + 1;
_timeOut = time + 0.05;


this addEventHandler ["fired",{
	params ["_v","_w","_mz","","","_mg"];
	if (_v ammo _mz == 1) then {
		private _p = [];
		{
			if (_w in (_v weaponsTurret _x)) exitWith {
				_p = _x
			};
		} forEach (allTurrets _v + [-1]);
		_v addMagazineTurret [_mg,_p]
	};
}];

this addEventHandler ["fired",{
	params ["_v","_w","_mz","_md","","_mg","","_g"];
	if (_v ammo _mz == 1) then {
		private _p = [];
		{
			if (_w in (_v weaponsTurret _x)) exitWith {
				_p = _x
			};
		} forEach (allTurrets _v + [-1]);
		_v addMagazineTurret [_mg,_p];
		_g forceWeaponFire [_mz,_md]
	};
}];

if (not hasInterface and {not isServer}) then {{if (local _x) then {_x enableAI "all"}} forEach allUnits};

(allGroups select {not isNil {_x getVariable "groupData"}}) spawn horde_fnc_selectFreeHeadlessClientOwner

{
	_x setGroupOwner 2
} forEach (allGroups select {not isNil {_x getVariable "groupData"}})

CRC packet mismatch of client and server

scripted hud + weapon cursors needed for action menu

write a standalone mod to stop you standing up when you are prone...

player addEventHandler ["animchanged"]

2016/09/19,  1:21:51 "[2728,3866,3922,4020]" < time abandoned for 4 vehicles
2016/09/19,  1:22:42 "4973.69" < time now
2016/09/19,  1:24:15 "300" < timeout
2016/09/19,  1:27:07 "[HordeZone_14]" < near zones
2016/09/19,  1:29:06 "[true,true,true,true]" < all of them are isKindOf "ship_f"

sort out steering on rhib
crew of amphibious QRFs should be divers

params do not exist on HC!


backpack = "B_Kitbag_rgr_Para_3_F";

uniform/vest/Backpack itemActions

Move contents to backpack > vest > floor
Move contents to vest > backpack > floor

Move contents to backpack > uniform > floor
Move contents to uniform > backpack > floor

Move contents to vest > uniform > floor
Move contents to uniform > vest > floor

Sort out vehicles spawning in shit locations (will need better system)...

showHud [
	true,
	true,
	true,
	true,
	true,
	true,
	true,
	true,
	true
];

showHud [
	false,
	false,
	false,
	false,
	false,
	false,
	false,
	false,
	false
];

o_lsv_armed_viper_f / turrets / cargoturret_01 / : cannot find base class cargoturret_01

set max limits for dead and abandoned vehicles

if not ((playableUnits + switchableUnits) isEqualTo []) then {
	// tidy up old groups
	{
		_grp = _x;
		if not (isNull _grp) then {
			if (vehicle leader _grp isKindOf "air") then {
				if not ([leader _grp,2000] call _fnc_playerIsNear) then {
					_grp call _fnc_cacheGroup
				};
			} else {
				if not ([leader _grp,1000] call _fnc_playerIsNear) then {
					_grp call _fnc_cacheGroup
				};
			};

		};
		true
	} count ncb_gv_renGrps;
	ncb_gv_renGrps = ncb_gv_renGrps - [grpNull];

DELETED ALL THE CRAP OUT OF THE PLAYER INIT BOXES:

P1 =

this enableMimics true; this setFaceAnimation 1; this setmimic "angry"; if (not isMultiplayer) then { this allowDamage false;   this linkItem "ItemRadio";   this linkItem "ItemMap";   this allowDamage false;   this linkItem "ItemPass_MasterAll";   this linkItem "ItemCompass";   this enableFatigue false;   this addBackPack "B_Carryall_oli";   this addItem "ItemWrench";   selectPlayer this  };

EVERYONE ELSE:

if (isServer and {not isMultiplayer}) then {     _grp = group this;     deleteVehicle this;     deleteGroup _grp  } else {   this enableMimics true;   this setFaceAnimation 1;   this setmimic "angry";  }



setDestination

car1 setDestination [[12860.7,3491.7,0],"LEADER DIRECT",true]

provision for "stuck units":  monitor movement - if none in last 30 seconds, then set the destination manually,

0 spawn {
	waitUntil {
		_grps = [];
		{
			if (simulationEnabled _x and {not isPlayer _x}) then {
				diag_log format ["simmed and not player: %1", _x];
				_oldPosWorld = _x getVariable ["lastPosWorld4",[0,0,0]];
				diag_log format ["unit _oldPosWorld: %1", _oldPosWorld];
				diag_log format ["unit not moved: %1", getPos _x distance _oldPosWorld < 5];
				if (getPos _x distance _oldPosWorld < 5) then {
					_grp = group _x;
					_grps pushBackUnique _grp;
					_dest = waypointPosition [_grp,currentWaypoint _grp];
					vehicle _x setDestination [_dest,"LEADER DIRECT",true];

				};
				_x setVariable ["lastPosWorld4",getPos _x];
				sleep 0.01;
			};
		} forEach allUnits;
		hintSilent format ["stuck groups4: %1",_grps];
		sleep 30;
		false
	};
};

0 spawn {
	waitUntil {
		_grps = [];
		{
			_x getVariable ["groupData",[""]] params ["_type"];
			if (_type != "static") then {
				_ldr = leader _x;
				_veh = vehicle _ldr;
				if (simulationEnabled _ldr and {not isPlayer _ldr}) then {
					_oldPosWorld = _x getVariable ["lastPosWorld",[0,0,0]];
					if (getPos _veh distance _oldPosWorld < 5) then {
						_grps pushBack _x;
						_dest = waypointPosition [_x,currentWaypoint _x];
						_veh setDestination [_dest,"LEADER DIRECT",true];
						if (_veh isKindOf "ship_f") then {
							_veh spawn {
								_unitVector = (getPos _this) vectorFromTo (_this getPos [10,(getDir _this + 180) % 360]);
								_boostVel = _unitVector vectorMultiply 10;
								for "_i" from 1 to 10 do {
									[_this,_boostVel] call horde_fnc_setVelocityGlobal;
									sleep 0.5;
								};
							};
						};
						if (_veh isKindOf "car") then {
							_veh spawn {
								if (alive driver _this and {_this call horde_fnc_gotFlatTyre}) then {
									_driver = driver _this;
									_driver action ["eject", _this];
									_driver disableAI "path";
									_driver doWatch _this;
									_driver playMoveNow  "Horde_anim_fixVehicleKneel";
									sleep 10;
									getAllHitPointsDamage _this params ["_hpNames"];
									{
										if (toLower _x find "wheel" > -1) then {
											_this setHitPointDamage [_x,0];
										};
									} forEach _hpNames;
									_driver enableAI "path";
									_driver moveInDriver _this;
								}
							};
						};

					};
					_x setVariable ["lastPosWorld",getPos _veh];
					sleep 0.01;
				};
			};
		} forEach allGroups;
		hintSilent format ["stuck groups: %1",_grps];
		sleep 30;
		false
	};
};

{
	diag_log format ["%1 %2",_x,_x getVariable "groupData"]
} forEach allGroups

17:24:43 Error in expression <
_patrolLandASLData = getArray(_cfgZone >> _path >> "patrolLandASL");

_reinforc>
17:24:43   Error position: <>> _path >> "patrolLandASL");

_reinforc>
17:24:43   Error >>: Type Array, expected String
17:24:43 Error in expression <not (_patrolDataArr isEqualTo [])>
17:24:43   Error position: <_patrolDataArr isEqualTo [])>
17:24:43   Error Undefined variable in expression: _patroldataarr
17:24:43 "possible error: no patrol paths free to spawn squads at HordeZone_7.  Check the patrol config to make sure there's some waypoints provided"

some "static" groups are converting to "infantry".  I think this is because the patrol scripts count "static" in _validGroups and then convert them as they assume no vehicle is present.

18:40:45 "O Alpha 2-3: [""infantry"",<NULL-object>,600,0,200,""del_me"",""HordeZone_2""]" < genuine infantry (see the 200)
18:40:45 "O Alpha 3-1: [""infantry"",<NULL-object>,600,0,-1,""del_me"",""HordeZone_2""]" < converted (see the -1)

{
	_grp = _x;
	if (not isNull _grp
		and {{if (alive _x) exitWith {1}} count units _grp > 0}
	) then {
		if (isNil {_grp getVariable "groupIngressData"}) then {
			_validGroups pushBack _grp;
			_leader = leader _grp;
			_leaderTarget = _leader findNearestEnemy _leader;
			// if (not isNull _leaderTarget and {isPlayer _leaderTarget}) then {
			if (not isNull _leaderTarget) then {
				_zoneInCombat = true;
				([
					_leader,
					_zonePosATL,
					_zoneTargets,
					_players,
					_playersInAdjZones
				] call _fnc_getLeaderTargets) params ["_zoneTargets","_playersInAdjZones"];
			};
		};
	};
	true
} count (_zone getVariable "zoneCurrentGroups");

_fnc_getLeaderTargets = {
	params ["_leader","_zonePosATL","_zoneTargets","_players","_playersInAdjZones"];

	{
		private _player = _x;
		private _tgtData = (_leader nearTargets ((_leader distance vehicle _player) + 100)) select {_x select 4 == vehicle _player};
		if not (_tgtData isEqualTo []) then {
			_tgtData select 0 params ["_tgtPosAGL","","","","","_posAccuracy"];
			if (_tgtPosAGL distance _zonePosATL < ncb_gv_zoneRadius) then {
				scopeName "indent_3";
				private _inArray = false;
				_tgtData = [
					_player,
					_tgtPosAGL,
					_posAccuracy
				];
				{
					_x params ["_player2","","_posAccuracy2"];
					if same(_player,_player2) then {
						if (_posAccuracy < _posAccuracy2) then {
							_zoneTargets set [_forEachIndex,_tgtData];
						};
						_inArray = true;
						breakTo "indent_3";
					};
				} forEach _zoneTargets;
				if (not _inArray) then {
					_zoneTargets pushBack _tgtData;
				};
			} else {
				_playersInAdjZones = true;
			};
		};
		true
	} count _players;
 diag_log format ["%1",[_zoneTargets,_playersInAdjZones]];
	[_zoneTargets,_playersInAdjZones]
};

{if (alive _x) exitWith {1}} count units group player > 0
0.0053 ms
{alive _x} count units group player > 0
0.0043 ms

{
	private _grp = _x;
	if (not isNull _grp
		and {{if (alive _x) exitWith {1}} count units _grp > 0}
	) then {
		if (isNil {_grp getVariable "groupIngressData"}) then {
			_validGroups pushBack _grp;
			_leader = leader _grp;
			_leaderTarget = _leader findNearestEnemy _leader;
			// new bit  - makes any static unit able to call in targets
			if (_grp getVariable ["groupdata",["none"]] select 0 isEqualTo "static") then {
				{
					private _target = _x findNearestEnemy _x;
					if (not isNull _target) exitWith {
						_leaderTarget = _target;
						_leader = _x;
					};
				} count units _grp;
			};
			// if (not isNull _leaderTarget and {isPlayer _leaderTarget}) then {
			if (not isNull _leaderTarget) then {
				_zoneInCombat = true;
				([
					_leader,
					_zonePosATL,
					_zoneTargets,
					_players,
					_playersInAdjZones
				] call _fnc_getLeaderTargets) params ["_zoneTargets","_playersInAdjZones"];
			};
		};
	};
	true
} count (_zone getVariable "zoneCurrentGroups");

or {({not (isNull (_x findNearestEnemy _x))} count (_object getVariable "SIREN_UNITS") isEqualTo 0)}

//trip the alarms

if (isNil {_zone getVariable "zoneSirenTimeTriggered"}) then {
	// trigger it
	_zone setVariable ["zoneSirenTimeTriggered",time];

	{
		private _building = _x;
		private _alarmUnits = _building getVariable ["alarmUnits",[]];
		if not ([] isEqualTo _alarmUnits
			and {{alive _x} count _alarmUnits > 0}
		) then {
			_siren = createSoundSource [
				"Sound_Alarm2",
				(getPosATL _building) vectorAdd [0,0,3],
				[],
			 0
			];
			_building setVariable ["alarmSpeaker",_siren];
		};
	} forEach (_zone getVariable ["alarmBuildings",[]]);
} else {
	// check if still needs it
	{
		private _building = _x;
		private _alarmUnits = _building getVariable ["alarmUnits",[]];
		if not [] isEqualTo _alarmUnits) then {
			if (not alive _building
				or {{not isNull _x and {alive _x}} count _alarmUnits == 0}) then {
				_building setVariable ["alarmUnits",nil];
				_siren = _building getVariable ["alarmSpeaker",objNull];
				if not (isNull _siren) then {
					deleteVehicle _siren
				};
			};
		};
	} forEach (_zone getVariable ["alarmBuildings",[]]);
};

if (all groups are holding (wp 8) then call in airstrike maybe)

diag_log format ["nl: %1", nearestLocations [[0,0,0],["NameVillage"],10000]];

diag_log format ["nl: %1", nearestLocations [[0,0,0],["NameVillage"],10000] apply {locationPosition _x}];

// script to generate a text string of years (or any other numbers)
_years = [];
for "_i" from 1914 to 2050 step 1 do {
	_years pushBack str _i;
};
diag_log _years;



[_object,_x,false] call horde_fnc_lockCargoGlobal
_veh setVehicleLock "LOCKEDPLAYER";

save vehicles locked status in database


"UnderwaterMine" // boats (f;oats)
"UnderwaterMineAB" // boats (sea bed)
"UnderwaterMinePDM" // anything (sea bed)


maybe try and have a "minimum time" in advance/combat mode for zones (wait until groups have a chance to check something out)
_equipCoast = {
	// equip

if (_zoneInCombat and {not ([] isEqualTo _zoneTargets)}) then {
	if (_lv_zoneSupportGunships == 0) then {
		_heliGrp = _zone getVariable ["attackHeliGroup",grpNull];
		if (not isNull _heliGrp
			and {{if (alive _x) exitWith {1}} count units _heliGrp > 0}
		) then {
			{
				if (_x select 2 < 25) then {
					_heliGrp reveal [_x select 0,4];
				};
			} count _zoneTargets;
		} else {
			_zone setVariable ["attackHeliGroup",nil];
		};
	} else {
		_pilot = _zone getVariable ["casPilot",objNull];
		if (not isNull _pilot
			and {alive _pilot}
			and {not isNull objectParent _pilot}
		) then {
			{
				if (_x select 2 < 25) then {
					group _pilot reveal [_x select 0,4];
				};
			} count _zoneTargets;
		} else {
			// check if cas needed
			private _pinnedGrps = _validGroups select {(_x getVariable ["groupdata",["none"]]) select 0 != "static"};
			if ({waypointType [_x,currentWaypoint _x] == "hold"} count _pinnedGrps == count _pinnedGrps) then {
				{
					_pilot = driver _x;
					if (not isNull _pilot
						and {not isPlayer _pilot}
						and {side _pilot isEqualTo east}
						and {group _pilot getVariable ["groupData",["none"]] select 0 == "patrolHeli"}
					) then {
						_casData = group _pilot getVariable "casData";
						if (isNil "_casData") then {
							// pilot is not on call, so request CAS
							group _pilot setVariable ["casData",[_zone,(round time) + 300]];
							_zone setVariable ["casPilot",_pilot];
							{
								if (_x select 2 < 25) then {
									group _pilot reveal [_x select 0,4];
								};
							} count _zoneTargets;
						};
					};
					true
				} count (_zone nearEntities [["Helicopter_Base_F","VTOL_Base_F"],_lv_zoneSupportGunships])
			};
		};

	};
};

ncb_param_invincible = 1;
ncb_gv_playerFood = 100;
ncb_gv_playerWater = 100;
vehicle player setDamage 0;


0.390778 ms

{
	nil
} count allUnits

{
	true
} count allUnits

{
	_newload set _x
} count [
	[0,["LMG_Zafir_F","","","optic_Arco_blk_F",["150Rnd_762x54_Box_TG",150],[],""]],
	[1,[]],
	[2,[]],
	[4,["V_TacVest_brn",[]]],
	[5,[]]
];

_unit setUnitLoadout _newLoad;
_unit setVariable ["load",_loadout];

0 spawn {
	_hello = [];
	_time = diag_ticktime;
	for "_i" from 1 to 10000 do {
		_hello pushBack _i
	};
	diag_log format ["count hello: %1", count _hello];
	diag_log format ["time: %1", diag_ticktime - _time]
};

11:06:19 "count hello: 10000"
11:06:19 "time: 0.0499268"

0 spawn {
	_hello = [];
	_time = diag_ticktime;
	for "_i" from 1 to 10000 do {
		isNil {_hello pushBack _i}
	};
	diag_log format ["count hello: %1", count _hello];
	diag_log format ["time: %1", diag_ticktime - _time]
};

11:06:43 "count hello: 10000"
11:06:43 "time: 0.100098"

0 spawn {
	_hello = [];
	_time = diag_ticktime;

	isNil {
		for "_i" from 1 to 10000 do {
			_hello pushBack _i
		}
	};
	diag_log format ["count hello: %1", count _hello];
	diag_log format ["time: %1", diag_ticktime - _time]
};

11:08:38 "count hello: 10000"
11:08:38 "time: 0.0170898"

0 = 0 spawn {
	waitUntil {time > 1 and {not isNull player} and {player == player}};
	0 = [] spawn bis_fnc_camera;
	sleep 1;
	setAccTime 1;
	0 = [1,3] spawn horde_fnc_scanBuildings;
	sleep 1;
	setAccTime 1;
};

14:11:17 Error in expression <s getVariable "LOOT_HOLDER_OBJECTS");

[_time,_holderArr]
>
14:11:17   Error position: <_time,_holderArr]
>
14:11:17   Error Undefined variable in expression: _time
14:11:17 File E:\Documents\Arma 3 - Other Profiles\Horde\mpmissions\##Nocebo_new_inidbi2.Stratis\server\loot\despawnHouseLoot.sqf, line 17

14:15:46 Error in expression <OUSE,_object]);
};
} else {
if (time - _timeLastGenerated > (60 * ncb_param_loo>
14:15:46   Error position: <_timeLastGenerated > (60 * ncb_param_loo>
14:15:46   Error Undefined variable in expression: _timelastgenerated

configfile >> "CfgWeapons" >> "H_HelmetO_ViperSP_hex_F" >> "subItems" // subItems[] = {"Integrated_NVG_TI_1_F"};

d_getUniformData = {
	private _manClass = getText(configfile >> "CfgWeapons" >> _this >> "ItemInfo" >> "uniformClass");
	private _armor = 0;
	{
		_armor = _armor + (getNumber (_x >> "armor"));
	} forEach configproperties [configFile >> "CfgVehicles">> _manClass >> "HitPoints","isclass _x"];
	[_armor,getNumber(configFile >> "CfgVehicles">> _manClass >> "side")]
};

diag_log format ["hps %1", "U_B_CombatUniform_mcam" call d_getUniformData];

d_getUniformData = {
	private _manClass = getText(configfile >> "CfgWeapons" >> _this >> "ItemInfo" >> "uniformClass");
	private _armor = 0;
	{
		_armor = _armor + (getNumber (_x >> "armor"));
	} forEach configproperties [configFile >> "CfgVehicles">> _manClass >> "HitPoints","isclass _x"];
	[_armor,getNumber(configFile >> "CfgVehicles">> _manClass >> "modelsides")]
};
{
	diag_log format ["uniform %1  hp/sides %2",_x,_x call d_getUniformData];
} forEach ((uiNamespace getVariable ["ncb_uv_masterUniforms",[]]) apply {_x select 0});



// v2 get ranges

d_getUniformData = {
	private _manClass = getText(configfile >> "CfgWeapons" >> _this >> "ItemInfo" >> "uniformClass");
	private _armor = 0;
	{
		_armor = _armor + (getNumber (_x >> "armor"));
	} forEach configproperties [configFile >> "CfgVehicles">> _manClass >> "HitPoints","isclass _x"];
	_armor
};
d_someVar = [];
{
	d_someVar pushBackUnique (_x call d_getUniformData)
} forEach ((uiNamespace getVariable ["ncb_uv_masterUniforms",[]]) apply {_x select 0});

diag_log format ["hp ranges %1", d_someVar];

"hp ranges [1010,1017,1036,1011,1014,1049]"

configfile >> "CfgWeapons" >> "CUP_hgun_glock17_flashlight_snds" >> "WeaponSlotsInfo" >> "PointerSlot"

	if (ncb_param_playerStartHandgunWeapon) then {
		_weapon = ncb_gv_cratePistolsTier_0 select 0;
		player addMagazines [
			getArray (_cfgWeapons >>  _weapon >> "magazines") select 0,
			if (ncb_param_playerStartPrimaryWeapon) then {2} else {4}
		];
		player addWeapon _weapon;
	};
	private _canAdd = {
		params ["_item","_qty"];
		for "_i" from 1 to _qty do {
			if (player canAddItemToUniform _item) then {
				player addItemToUniform _item
			}
		}
	};

	if (sunOrMoon == 1) then {
		// filter by slots
		_weapons = [];
		_slotsMax = 99;
		{
			if (count getArray (_cfgWeapons >>  _x >> "muzzles") < 2
				and {not (isClass (_cfgWeapons >>  _x >> "opticsmodes"))}
			) then {
				_slots = 0;
				{
					_cfgCompatibleItems = _x >> "compatibleItems";
					if (isArray _cfgCompatibleItems) then {
						if not (_cfgCompatibleItems isEqualTo []) then {
							_slots = _slots + 1;
						};
					} else {
						if (isClass _cfgCompatibleItems) then {
							if not (configProperties [_cfgCompatibleItems,"isNumber _x"] isEqualTo []) then {
								_slots = _slots + 1;
							};
						};
					};
				} forEach configProperties [
					_cfgWeapons >>  _x >> "WeaponSlotsInfo",
					"isClass _x",
					true
				];
				if (_slots < _slotsMax) then {
					_weapons = [_x];
					_slotsMax = _slots;
				} else {
					if (_slots == _slotsMax) then {
						_weapons pushBack _x
					}
				}
			};
		} forEach ncb_gv_cratePistolsTier_0;
		// now filter by ammo count
		_weapons2 = [];
		_currentCount = 999999;
		{
			_ct = getNumber (_cfgMagazines >> (getArray (_cfgWeapons >>  _x >> "magazines") select 0) >> "count");
			if (_ct < _currentCount) then {
				_currentCount  = _ct;
				_weapons2 = [_x]
			} else {
				if (_ct == _currentCount) then {
					_weapons2 pushBack _x
				}
			}
		} forEach _weapons;
		_weapon = selectRandom _weapons2;
		_mags = getArray (_cfgWeapons >>  _weapon >> "magazines");
		_mags = _mags select {getText (configFile >> "CfgAmmo" >> (getText (configFile >> "CfgMagazines" >> _x >> "ammo")) >> "effectFly") != "AmmoUnderwater"};
		player addMagazines [_mags select 0,if (ncb_param_playerStartPrimaryWeapon) then {2} else {4}];
		player addWeapon _weapon;
	} else {
		// filter by slots (but make sure pointerslot is there)
		_weapons = [];
		_slotsMax = 99;
		{
			if (count getArray (_cfgWeapons >>  _x >> "muzzles") < 2
				and {not (isClass (_cfgWeapons >>  _x >> "opticsmodes"))}
			) then {
				_slots = 0;
				_hasPointer = false;
				{
					if (configName _x == "PointerSlot") then {
						_hasPointer = true;
					};
					_cfgCompatibleItems = _x >> "compatibleItems";
					if (isArray _cfgCompatibleItems) then {
						if not (_cfgCompatibleItems isEqualTo []) then {
							_slots = _slots + 1;
						};
					} else {
						if (isClass _cfgCompatibleItems) then {
							if not (configProperties [_cfgCompatibleItems,"isNumber _x"] isEqualTo []) then {
								_slots = _slots + 1;
							};
						};
					};
				} forEach configProperties [
					_cfgWeapons >>  _x >> "WeaponSlotsInfo",
					"isClass _x",
					true
				];
				if (_hasPointer) then {
					if (_slots < _slotsMax) then {
						_weapons = [_x];
						_slotsMax = _slots;
					} else {
						if (_slots == _slotsMax) then {
							_weapons pushBack _x
						}
					}
				};
			};
		} forEach ncb_gv_cratePistolsTier_0;
		// now filter by ammo count
		_weapons2 = [];
		_currentCount = 999999;
		{
			_ct = getNumber (_cfgMagazines >> (getArray (_cfgWeapons >>  _x >> "magazines") select 0) >> "count");
			if (_ct < _currentCount) then {
				_currentCount  = _ct;
				_weapons2 = [_x]
			} else {
				if (_ct == _currentCount) then {
					_weapons2 pushBack _x
				}
			}
		} forEach _weapons;
		_weapon = selectRandom _weapons2;
		_mags = getArray (_cfgWeapons >>  _weapon >> "magazines");
		_mags = _mags select {getText (configFile >> "CfgAmmo" >> (getText (configFile >> "CfgMagazines" >> _x >> "ammo")) >> "effectFly") != "AmmoUnderwater"};
		player addMagazines [_mags select 0,if (ncb_param_playerStartPrimaryWeapon) then {2} else {4}];
		player addWeapon _weapon;
		player addHandgunItem ((getArray (configfile >> "CfgWeapons" >> _weapon >> "WeaponSlotsInfo" >> "PointerSlot" >> "compatibleItems")) select 0);
	};


	if ({_className isKindOf _x} count ["Land_Campfire_F","ProtectionZone_F","Helper_Base_F","Camping_base_F","Land_Sign_Mines_F","FlagCarrierCore","ReammoBox","Pavements_base_F","SportsGrounds_base_F","TargetBase","Graffiti_base_F","Leaflet_base_F","LuggageHeap_base_F","Lightning_F","Lightning1_F","Lightning2_F","UserTexture1m_F","VR_Block_base_F","Land_DataTerminal_01_F","Sphere_3DEN","MineGeneric","VR_Helper_base_F"] > 0) exitWith {};

[getPosASL player,0.5,[["middle",0.95],["up",1.65]]] call {
	params ["_originASL","_radius","_heightArr"];
	_originASL = _originASL vectorAdd [0,0,0.08];
	private _good = true;
	_heightArr = _heightArr apply {_x select 1};
	if ({lineIntersects [_originASL,_originASL vectorAdd [0,0,_x]]} count _heightArr > 0) exitWith {
		_good = false;
	};
	for "_direction" from 0 to 355 step 5 do {
		private _testPosASL = [
			(_originASL select 0) + _radius * sin _direction,
			(_originASL select 1) + _radius * cos _direction,
			(_originASL select 2)
		];

		if (lineIntersects [_originASL,_testPosASL]) exitWith {
			_good = false;
		};
		if not (lineIntersects [_testPosASL,_testPosASL vectorAdd [0,0,-0.15]]) exitWith {
			_good = false;
		};
	};
	_good
}

0.0389 ms

wirefence = "Land_TTowerBig_1_F" createVehicle position player;
arrow = "Sign_Arrow_F" createVehicle [0,0,0];
onEachFrame {
	_ins = lineIntersectsSurfaces [
		AGLToASL positionCameraToWorld [0,0,0],
		AGLToASL positionCameraToWorld [0,0,1000],
		player,
		objNull,
		true,
		1,
		"GEOM",
		"NONE"
	];
	if (count _ins == 0) exitWith {arrow setPosASL [0,0,0]};
	arrow setPosASL (_ins select 0 select 0);
	arrow setVectorUp (_ins select 0 select 1);
	hintSilent str _ins;
};

wirefence = "Land_WIP_F" createVehicle position player;
arrow = "Sign_Arrow_F" createVehicle [0,0,0];
arrow2 = "Sign_Arrow_Blue_F" createVehicle [0,0,0];
onEachFrame {
	_ins = lineIntersectsSurfaces [
		AGLToASL positionCameraToWorld [0,0,0],
		AGLToASL positionCameraToWorld [0,0,1000],
		player,
		objNull,
		true,
		2,
		"FIRE",
		"NONE"
	];
	if (count _ins == 0) exitWith {arrow setPosASL [0,0,0],arrow2 setPosASL [0,0,0]};
	arrow setPosASL (_ins select 0 select 0);
	arrow setVectorUp (_ins select 0 select 1);
	if (count _ins > 1) then {
		arrow2 setPosASL (_ins select 1 select 0);
		arrow2 setVectorUp (_ins select 1 select 1);
	};
	hintSilent str _ins;
};

{
	_str = (str _x) splitString ": .";
	if (count _str > 1) then {
		_class = "Land_" + (_str select 1);
		if (isClass (configFile >> "CfgVehicles" >> _class)) then {
			diag_log format ["type: %1",_class];
		} else {
			_class = _class + "_F";
			if (isClass (configFile >> "CfgVehicles" >> _class)) then {
				diag_log format ["type: %1",_class];
			};
		};
	};
} forEach nearestTerrainObjects [player, [ "ROCK","FORTRESS","WALL","ROCKS"],1000,false,true]

mortar1 addEventHandler ["firedNear",{
	params ["_mortar","_objFired","_dist","_weap","_muzz","_mode","_ammo","_gunnerObjFired"];
	private _gunner = gunner _mortar;
	if (isNull _gunner or {isPlayer _gunner}) exitWith {};
	if (side _objFired in [west,resistance]) then {
		if (_gunner knowsAbout _objFired > 1.5) then {
			[_gunner] allowGetIn false;
			[_mortar,_gunner] spawn {
				params ["_mortar","_gunner"];
				waitUntil {
					uiSleep 10;
					_enemy = _gunner findNearestEnemy _gunner;
					not alive _gunner
					or {not alive _mortar}
					isNull _enemy
					or {_enemy distance _gunner > 69}
				};
				if (alive _gunner and {alive _mortar}) then {
					[_gunner] allowGetIn true;
					_gunner action ["getInGunner",_mortar];
				} else {
					_mortar removeAllEventHandlers "firedNear"
				}
			}
		};
	}
}];


_fnc_firedNearMortar = {
	params ["_mortar","_objFired","_dist","_weap","_muzz","_mode","_ammo","_gunnerObjFired"];
	private _gunner = gunner _mortar;
	diag_log format ["_gunner %1", _gunner];
	diag_log format ["_isPlayer %1",isPlayer _gunner];
	diag_log format ["isNull _gunner %1",isNull _gunner];
	if (isNull _gunner or {isPlayer _gunner}) exitWith {};
	diag_log format ["side _objFired %1", side _objFired];
	if (side _objFired in [west,resistance]) then {
		diag_log format ["_gunner knowsAbout _objFired %1",_gunner knowsAbout _objFired];
		if (_gunner knowsAbout _objFired > 1.5) then {
			[_gunner] allowGetIn false;
			[_mortar,_gunner] spawn {
				params ["_mortar","_gunner"];
				waitUntil {
					uiSleep 10;
					_enemy = _gunner findNearestEnemy _gunner;
					diag_log format ["_enemy %1",_enemy];
					diag_log format ["alive _gunner %1",alive _gunner];
					diag_log format ["alive _mortar %1",alive _mortar];
					diag_log format ["isNull _enemy %1",isNull _enemy];
					diag_log format ["_enemy distance _gunner > 69 %1",_enemy distance _gunner > 69];
					not alive _gunner
					or {not alive _mortar}
					or {isNull _enemy}
					or {_enemy distance _gunner > 69}
				};
				if (alive _gunner and {alive _mortar}) then {
					[_gunner] allowGetIn true;
					_gunner action ["getInGunner",_mortar];
				} else {
					diag_log format ["removing EH %1",_mortar];
					_mortar removeAllEventHandlers "firedNear"
				}
			}
		};
	}
};

_veh addEventHandler ["firedNear",{
	params ["_mortar","_objFired","_dist","_weap","_muzz","_mode","_ammo","_gunnerObjFired"];
	private _gunner = gunner _mortar;
	if (isNull _gunner or {isPlayer _gunner}) exitWith {};
	if (side _objFired in [west,resistance]) then {
		if (_gunner knowsAbout _objFired > 1.5) then {
			[_gunner] allowGetIn false;
			[_mortar,_gunner] spawn {
				params ["_mortar","_gunner"];
				waitUntil {
					uiSleep 10;
					_enemy = _gunner findNearestEnemy _gunner;
					not alive _gunner
					or {not alive _mortar}
					or {isNull _enemy}
					or {_enemy distance _gunner > 69}
				};
				if (alive _gunner and {alive _mortar}) then {
					[_gunner] allowGetIn true;
					_gunner action ["getInGunner",_mortar];
				} else {
					_mortar removeAllEventHandlers "firedNear"
				}
			}
		};
	}
}];

loot in the sea!

>> Done!

Too much loot!

>> Done!

Floating snipers!

>> Done!  (needs checking)

Mortars/AA should be checked first and given a big area to spawn in (at least 4m)!

No loot should be on piers!

Loot should maybe spawn on ground level (where there is no floor except the terrain)

>>> can possibly check 2 intersections and only ever take the one with the object (unless they are both null obj)

Maybe tie loot density into the size of building

Snipers think docks/piers are really good to spawn at...

sel(_worldPos,2) > 15

Check blacklist markers are working!

>> fixed by making markers invisible and not deleting them

Enemy should destroy tents!

>> Done!

Heal enemies!


22:18:44 "check loot 2085"
22:18:45 "check new zones 2086"
22:18:45 "check despawn old zones 2086"
22:18:45 "check spawn new zones 2086"
22:18:45 "check reinforce 2086"
22:18:45 "check waypoints 2086"
22:18:46 Error in expression <= _grp getVariable "groupData";
_type = _grpData select 0;
_veh = _grpData selec>
22:18:46   Error position: <_grpData select 0;
_veh = _grpData selec>
22:18:46   Error Undefined variable in expression: _grpdata
22:18:46 Error in expression <_type == "infantry">
22:18:46   Error position: <_type == "infantry">
22:18:46   Error Undefined variable in expression: _type
22:18:46 Error in expression <_type in ["car","truck","technical","apc>
22:18:46   Error position: <_type in ["car","truck","technical","apc>
22:18:46   Error Undefined variable in expression: _type
22:18:46 "check empty veh sim 2087"
22:18:46 "check rens 2087"
22:18:46 "check loot 2087"
22:18:47 "check new zones 2089"
22:18:47 "check despawn old zones 2089"
22:18:47 "check spawn new zones 2089"
22:18:47 "check reinforce 2089"
22:18:47 "check waypoints 2089"

IF ARTILLERY CREW ARE KILLED, THEY ADD THE SOCHOR TO THE ABANDONED VEHICLES ARRAY!

_fnc_roundNumber = {
	params ["_numb","_decimals"];
	_numb = _numb * (10 ^ _decimals);
	_numb = round _numb;
	_numb = _numb / (10 ^ _decimals);
	_numb
};

horde_fnc_drawIcon = {
	params ["_thisEventHandler","_unit"];
	_unit = missionNameSpace getVariable [_unit,objNull];
	if (alive _unit and {simulationEnabled _unit}) then {
		call compile format [
			"drawIcon3D ['', [1,0,0,1], %1 modelToWorld (%1 selectionPosition 'head'), 0, 0, 0, 'GRP: %2 DTA: %3 WP: %4 TYP: %5', 1, 0.05, 'PuristaMedium']",
			_unit,
			group _unit,
			group _unit getVariable ["groupData", ["n/a"]],
			currentWaypoint group _unit,
			waypointType currentWaypoint group _unit,
		];
	} else {
		removeMissionEventHandler ["eachFrame",_thisEventHandler];
	};
};

horde_fnc_addIcon = {
	_this = _this call BIS_fnc_objectVar;
	addMissionEventHandler ['EachFrame',
		format ['([_thisEventHandler] + %1) call horde_fnc_drawIcon',[_this]]
	];
};


test_fnc = {
	removeMissionEventHandler ["EachFrame",scriptID];
};
scriptIDXX = addMissionEventHandler ["EachFrame", {
	{
		if (_x select 0 == "zoneManager") exitWith {
			diag_log _x
		};
	} forEach diag_activeMissionFSMs
}];

0 = 0 spawn {
	_followerDogTypes = ["Fin_blackwhite_F","Fin_ocherwhite_F","Fin_tricolour_F","Alsatian_Black_F","Alsatian_Sandblack_F"];
	_pack = [player getPos [50,random 360], 7, "Alsatian_Sand_F", _followerDogTypes, 75] call JBOY_dogPackCreate;
};

0 = 0 spawn {
	_followerDogTypes = ["Fin_blackwhite_F","Fin_ocherwhite_F","Fin_tricolour_F","Alsatian_Black_F","Alsatian_Sandblack_F"];
	_pack = [player modelToWorld [0,500,0], 7, "Alsatian_Sand_F", _followerDogTypes, 75] call JBOY_dogPackCreate;
};


0 = 0 spawn {
	_followerDogTypes = ["Feral_Fin_blackwhite_F","Feral_Fin_ocherwhite_F","Feral_Fin_tricolour_F","Feral_Alsatian_Black_F","Feral_Alsatian_Sandblack_F"];
	_pack = [player getPos [50,random 360], 7, "Feral_Alsatian_Sand_F", _followerDogTypes, 75] call JBOY_dogPackCreate;
};

2 new ideas!

Save tasks and also vehicles...

position of all vehicles / objects
status of all tasks

Vehicles - move cfgInteraction definitions to missioncfg (to easily add modded vehicles).

Also, do not fiddle with vehicle mags, but use scripts to break them down into boxes (so abandon the hopper idea) and have a number of classes of 100 round boxes to break them into.  When filling vehs with ammo, check against the config value for the turret so it cannot be overloaded.

EG:  LSV patrol car has 3 * 500 round boxes of ammo for the minigun.  Have option to remove 500 rounds at a time and it gives us 5 boxes of 6.5 X 100 rnd green ammo (might have to use isKindOf a lot here)


_dog

class TargetSoldierBase : StaticWeapon {
	author = "Bohemia Interactive";
	mapSize = 1.78;
	_generalMacro = "TargetSoldierBase";
	scope = 0;
	scopeCurator = 0;
	displayName = "Invisible Target Soldier";
	model = "\A3\Structures_F\Training\InvisibleTarget_F.p3d";
	editorSubcategory = "EdSubcat_Targets";
	vehicleClass = "Training";
	cost = 200000;
	accuracy = 0.05;
	destrType = "DestructNo";
	side = 5;
	alwaysTarget = 1;
	armor = 3;
	type = 0;
	class Turrets {
		class MainTurret : NewTurret {
			body = "";
			gun = "";
		};
	};
};
class B_TargetSoldier : TargetSoldierBase {
	author = "Bohemia Interactive";
	class SimpleObject {
		animate[] = {};
		hide[] = {"zasleh"};
		verticalOffset = 0;
	};
	_generalMacro = "B_TargetSoldier";
	scope = 1;
	scopeCurator = 0;
	crew = "B_UAV_AI";
	typicalCargo[] = {"B_UAV_AI"};
	side = 1;
	faction = "BLU_F";
};
class O_TargetSoldier : TargetSoldierBase {
	author = "Bohemia Interactive";
	class SimpleObject {
		animate[] = {};
		hide[] = {"zasleh"};
		verticalOffset = 0;
	};
	_generalMacro = "O_TargetSoldier";
	scope = 1;
	scopeCurator = 0;
	crew = "O_UAV_AI";
	typicalCargo[] = {"O_UAV_AI"};
	side = 0;
	faction = "OPF_F";
};
class I_TargetSoldier : TargetSoldierBase {
	author = "Bohemia Interactive";
	class SimpleObject {
		animate[] = {};
		hide[] = {"zasleh"};
		verticalOffset = 0;
	};
	_generalMacro = "I_TargetSoldier";
	scope = 1;
	scopeCurator = 0;
	crew = "I_UAV_AI";
	typicalCargo[] = {"I_UAV_AI"};
	side = 2;
	faction = "IND_F";
};

_thing = createVehicle ["Horde_InvisibleTargetMan",getPos player vectorAdd [0,0,3],[],0,"can_collide"];
_thing enableSimulation false;

_thing = createVehicle ["Horde_InvisibleTargetVehicle",getPos player vectorAdd [0,0,3],[],0,"can_collide"];
_thing enableSimulation false;

_thing = createVehicle ["Horde_InvisibleTargetHeavyVehicle",getPos player vectorAdd [0,0,3],[],0,"can_collide"];
_thing enableSimulation false;


_thing = createVehicle ["Horde_InvisibleTargetMan2",player modelToWorld [0,3,3],[],0,"can_collide"];
createVehicleCrew _thing;
_thing enableSimulation false;
{
	diag_log [_x, faction _x, side _x, side group _x];
} forEach crew _thing;


SplitByLevels = {
	params ["_positions", "_levels"]; private _res = _levels apply {[]};
	{private _pos = _x; {if (_pos select 2 <= _x) exitWith {(_res select _forEachIndex) pushBack _pos}} forEach _levels} forEach _positions;
	_res
};

//Usage:
[_positions, [6,10,14,17,99]] call SplitByLevels;

/*Result:
[
[[3900.02,12299,5.21225]],
[[3896.13,12291.7,9.13203]],
[[3894.12,12293.8,13.5114],[3898.92,12290,13.192],[3902.52,12289,13.0732]],
[[3903.62,12294.3,15.7627],[3902.56,12300.5,16.273],[3897.97,12301.9,16.535],[3893.56,12290.4,16.1607],[3900.34,12293.4,15.8484]],
[[3904.05,12295.8,18.1884],[3902.79,12300.7,18.5969],[3896.11,12297.7,18.654],[3893.78,12294.9,18.5645],[3892.87,12292.4,18.5547],[3900.19,12289.1,18.1284],[3902.99,12288.8,18.1067],[3904.24,12291.4,18.0172]]]*/

0:03:53 "_groupData [""static"",<NULL-object>,1000,0,-1,""del_me"",""HordeZone_12""]"
 0:03:53 "_targetType "
 0:03:53 "_threatArr []"
 0:03:53 "_threatIndex 0"
 0:03:53 Error in expression <;

if ((_threatIndex isEqualTo 0) and {_threat >= 0.5}) then {
if not (_targetT>
 0:03:53   Error position: <_threat >= 0.5}) then {
if not (_targetT>
 0:03:53   Error Undefined variable in expression: _threat
 0:03:53 File E:\Documents\Arma 3 - Other Profiles\Horde\mpmissions\##Nocebo_new_inidbi2.Stratis\server\zones\waypoints\getZoneTargets.sqf, line 47

 rhsusf_weap_MP7A2

 baseweapon = "rhsusf_weap_MP7A2";

 {diag_log _x} forEach (uiNamespace getVariable "ncb_uv_masterRiflesTier_2")

/*
	Author: Karel Moricky

	Description:
	Return base weapon (i.e., weapon without any attachments)

	Parameter(s):
		0: STRING - weapon class

	Returns:
	STRING - weapon class
*/
fnc_baseWeapon = {
	private ["_class","_cfg"];
	_class = _this param [0,"",[""]];

	_cfg = configfile >> "cfgweapons" >> _class;
	if !(isclass _cfg) exitwith {
		if (_class != "") then {["Class '%1' not found in CfgWeapons",_class] call bis_fnc_error};
		_class
	};

	private ["_return"];
	_return = _class;
	{
		if (count (_x >> "linkeditems") == 0) exitwith {_return = configname _x;};
	} foreach (_cfg call bis_Fnc_returnparents);
	_return
};

18:17:22 "tripped revive code: [p1,"""",1,<NULL-object>,"""",-1,<NULL-object>]"
18:17:22 "time: 245.01"
18:17:22 "tripped no revive death: [p1,"""",1,<NULL-object>,"""",-1,<NULL-object>]"
18:17:22 "time: 245.01"
18:17:22 Client: Nonnetwork object 57df8080.
18:17:22 Client: Nonnetwork object 3f5fa180.
18:17:22 "tripped revive code: [p1,"""",1.1,<NULL-object>,"""",-1,<NULL-object>]"
18:17:22 "time: 245.01"
18:17:22 "tripped no revive death: [p1,"""",1.1,<NULL-object>,"""",-1,<NULL-object>]"
18:17:22 "time: 245.01"

Why 3 times?

"Land_Church_03" - no loot!

"Land_Hangar_2" - airplane spawns - bang!

crew cursorObject select {alive _x} isEqualTo []
0.0067 ms
{alive _x} count crew cursorObject isEqualTo 0
0.0061 ms

fnc_scanPosition = {
	params ["_originASL","_radius","_heightArr"];
	_originASL = _originASL vectorAdd [0,0,0.08];
	private _good = true;
	_heightArr = _heightArr apply {_x select 1};
	if ({lineIntersects [_originASL,_originASL vectorAdd [0,0,_x]]} count _heightArr > 0) exitWith {
		_good = false;
		_good
	};
	for "_direction" from 0 to 355 step 5 do {
		private _testPosASL = [
			(_originASL select 0) + _radius * sin _direction,
			(_originASL select 1) + _radius * cos _direction,
			(_originASL select 2)
		];
		if not ([] isEqualTo lineIntersectsSurfaces [_originASL,_testPosASL,player,objNull,true,1,"FIRE","GEOM"]) exitWith {
			_good = false;
		};
		if ([] isEqualTo lineIntersectsSurfaces [_testPosASL,_testPosASL vectorAdd [0,0,-1.5],player,objNull,true,1,"GEOM","NONE"]) exitWith {
			_good = false;
		};
	};
	_good
};player sideChat format ["good pos %1", [getPosASL player,1,[["loot",1.5]]] call fnc_scanPosition]

issue where some floors cannot be detected by lineIntersects and also only by "geom" in lineIntersectsSurfaces....

class CfgVehicles {
	class All {
		class EventHandlers {
			class someClass {
				init = "diag_log format ['thing created: %1',_this]";
			};
		};
	};
};
_data = call (missionNamespace getVariable "ncb_gv_enemyUnitVariables");
_data set [0,player];
_data call horde_fnc_enemyEquip

0 = 0 spawn {
	uiSleep 3;
	hintSilent "starting";
	uiSleep 1;
	isNil {
		for "_unscheduledLockup" from 1 to 999999 do {
			selectBestPlaces [
				position player,
				10000,
				"(2 * (waterDepth interpolate [1,16,0,1]) * ((0.1+houses factor [0.1,0.8]) * (randomGen 1 + houses)))",
				0.1,
				500
			]
		}
	}
};

addMissionEventHandler ['EachFrame',
	{systemChat format ['hello %1',_thisEventHandler]}
];

horde_gvar_perFrameManager = createLocation [ "Hill" , [-9999,-9999,9999],1,1];

fnc_thingy = {
	diag_log format ["PASSED to thingy: %1", _this];
	systemChat format ["PASSED to thingy: %1", _this]
};

horde_fnc_addPerFrameHandler = {
	params ["_functionName","_delay","_args"];
	{
		if (_x isEqualType objNull
			and {not isNull _x}
			and {isNil {missionNamespace getVariable str _x}}
		) then {
			hintSilent "not null and no missionspace var";
			private _var = vehicleVarName _x;
			if (_var == "") then {
				_var = "horde_obj" + str (["horde_obj",1] call bis_fnc_counter);
				_x setVehicleVarName _var;
			};
			missionNameSpace setVariable [_var,_x];
			systemChat format ["new var %1",_var];
			systemChat format ["new name %1",_x];
		}
	} forEach _args;
	systemChat format ["args %1",_args];
	_thisEventHandler = addMissionEventHandler ['EachFrame',
		format ['([_thisEventHandler] + %1 + %2) call %3',[time + _delay],_args,_functionName]
	];
	_thisEventHandler
};
fnc_test = {
	removeMissionEventHandler ["EachFrame",_this select 0];
};

jj = ["fnc_test",0,[]] call horde_fnc_addPerFrameHandler
removeMissionEventHandler ["EachFrame",jj];








fnc_thingy = {
	diag_log format ["PASSED to thingy: %1", _this];
	systemChat format ["PASSED to thingy: %1", _this]
};

horde_fnc_addPerFrameHandler = {
	params ["_fnc","_delay","_args"];
	diag_log format ["passed to handler %1",_this];
	_thisEventHandler = addMissionEventHandler ['EachFrame', {
		[_thisEventHandler,_delay,_args] call (missionNamespace getVariable _fnc)
	}];
	diag_log format ["_thisEventHandler %1",_thisEventHandler];
	_thisEventHandler
};

horde_fnc_removePerFrameHandler = {
	removeMissionEventHandler ["EachFrame",_this];
};

jjj = ["fnc_thingy",0,[cursorObject,player]] call horde_fnc_addPerFrameHandler







fnc_thingy = {
	diag_log format ["PASSED to thingy: %1", _this];
	systemChat format ["PASSED to thingy: %1", _this]
};

horde_fnc_addPerFrameHandler = {
	params ["_fnc","_delay","_args"];
	diag_log format ["passed to handler %1",_this];
	_thisEventHandler = addMissionEventHandler ['EachFrame',
		compile systemChat format ["%1", _this];
		diag_log format ["%1", _this];
	];
	diag_log format ["_thisEventHandler %1",_thisEventHandler];
	_thisEventHandler
};

horde_fnc_removePerFrameHandler = {
	removeMissionEventHandler ["EachFrame",_this];
};

jjj = ["fnc_thingy",0,[cursorObject,player]] call horde_fnc_addPerFrameHandler

Door_1_source

Door_1_SOUND_source
horde_fnc_getWheelSelections = {
	private _cfgVehicles = configFile >> "CfgVehicles";
	for "_i" from 0 to count _cfgVehicles - 1 do {
		private _cfg = _cfgVehicles select _i;
		private _class = configName _cfg;
		if (_class isKindOf "LandVehicle"
			and {getNumber (_cfg >> "scope") > 2}
			and {_class isKindOf "Car"}
		) then {
			private _veh = createVehicle [_class,player modelToWorld [0,0,15],[],0,"can_collide"];
			private _selections = selectionNames _veh;
			private _balls = [];
			{
				if (toLower _x find "wheel" > -1) then {
					private _ball = createVehicle ["Sign_Sphere10cm_F",__veh modelToWorld (_veh selectionPosition _x),[],0,"can_collide"];
					_balls pushBack _ball;
				}
			} forEach _selections;
			sleep 3;
			{
				deleteVehicle _x
			} forEach _balls;
			deleteVehicle _veh;
		}
	}
};

fhandle = addMissionEventHandler ["Draw3D",compile format ["drawLine3D [%1,%2,[1,0,1,1]]",cursorTarget modelToWorld [10,0,1.1],cursorTarget modelToWorld [-10,0,1.1]]];

c1 addForce [[10000,10000,10000],[-10000,-10000,-10000]]
c1 addTorque [-100000,100000,100000]

{
	diag_log _x;
	_ball =
} forEach selectionNames c1

{
	_selPos = c1 selectionPosition _x;
	if not (_selPos isEqualTo [0,0,0]) then {
		diag_log format ["sel name: %1",_x];
		diag_log format ["sel pos: %1",_selPos];
		diag_log "";
		_worldPos = c1 modelToWorld _selPos;
		_ball = "Sign_Sphere25cm_F" createVehicleLocal _worldPos;
		_ball setPos _worldPos;
		_handle = addMissionEventHandler ["Draw3D",compile format ["drawIcon3D ['', [1,0,0,1], %1, 0, 0, 0, '%2', 1, 0.03, 'PuristaMedium'];",_worldPos,_x]];
	};
} forEach selectionNames c1

"Land_i_House_Small_01_b_yellow_F" DLC = "Argo";





 0:27:03 "ncb_gv_ArtilleryPositions

 [
	[HordeZone_12,""AYHordeZone_12"",[2798,5400,0],10],
	[HordeZone_12,""AYHordeZone_12"",[3198,6400,-9.53674e-007],191],
	[HordeZone_12,""AYHordeZone_12"",[2478,5640,0],178],
	[
		HordeZone_12,""AYHordeZone_12"",[[[2798,5400,0],10,
	[1dd00af4080# 164100: mbt_02_arty_f.p3d]],[[3198,6400,-9.53674e-007],191,
	[1ddc938a040# 164171: mbt_02_arty_f.p3d]],[[2478,5640,0],178,
	[1dd01f0e040# 164227: mbt_02_arty_f.p3d]]]
	]
]"
 0:27:03 "_saveData
 [[HordeZone_12,""AYHordeZone_12"",[[2798,any,1,[]],[5400,any,1,[]],[0,any,1,[]]]],
 [HordeZone_12,""AYHordeZone_12"",[[3198,any,1,[]],[6400,any,1,[]],[-9.53674e-007,any,1,[]]]],
 [HordeZone_12,""AYHordeZone_12"",[[2478,any,1,[]],[5640,any,1,[]],[0,any,1,[]]]],
 [HordeZone_12,""AYHordeZone_12"",[[[2798,5400,0],10,0,[]],[[3198,6400,-9.53674e-007],191,0.0113673,[]],[[2478,5640,0],178,0,[]]]]]"
 0:27:03

 "IniDBI: write failed, artillery_0 zones data contains object should be ARRAY, SCALAR, STRING type"

  _saveData
  [
	[HordeZone_2,""AYHordeZone_2"",[[[2532,1380,7.62939e-006],336,0,[]]]]
]

[[3958.63,8006.99,189.486],""Horde_O_Heli_Light_02_F"",UNKNOWN,5.60212,O Alpha 1-2:1 (bis_o2_1466),16.6758]
[[3688.29,8306.42,1.23647],""Horde_renegadeUnit"",GUER,-9.99996e+006,bis_o2_3886,0]
[[3704.19,8279.35,1.22823],""Horde_renegadeUnit"",GUER,-9.99996e+006,bis_o2_3864,0]
[[3742.05,8295.39,0.143784],""Horde_renegadeUnit"",GUER,-9.99996e+006,bis_o2_3890,0]
[[3730.04,8293.53,0.127045],""Horde_renegadeUnit"",GUER,-9.99999e+006,bis_o2_3875,0]
[[3744.42,8275.12,0.786301],""Horde_renegadeUnit"",GUER,-9.99999e+006,bis_o2_3883,0]
[[3694.67,8301.54,0.126617],""Horde_renegadeUnit"",GUER,-9.99999e+006,bis_o2_3879,0]
[[3698.58,8298.36,0.135635],""Horde_renegadeUnit"",GUER,-9.99999e+006,bis_o2_3871,0]
[[3724.1,8292.07,0.779922],""Horde_renegadeUnit"",GUER,-9.99999e+006,bis_o2_3868,0]
[[3720.22,8275.67,0.121201],""Horde_renegadeUnit"",GUER,-9.99999e+006,bis_o2_3860,0]
[[3708.73,8276.56,0.119873],""Horde_renegadeUnit"",GUER,-9.99999e+006,bis_o2_3857,0]
[[4330.13,9000,-0.00151062],""Zone_Logic"",LOGIC,-100000,HordeZone_37,0]
[[4330.13,9000,-0.00151062],""StaticWeapon_Logic"",LOGIC,-100000,L Bravo 1-4:2,0]
[[3538.67,8696.48,0],""StartledBirds_Logic"",LOGIC,-100000,<No group>:0 (StartledBirds_Logic),0]
[[3620.26,8563.37,3.77853],""Land_LampShabby_F"",CIV,-100000,225d4fd3580# 239438: lampshabby_f.p3d,0]
[[3557.12,8526.61,3.79233],""Land_LampShabby_F"",CIV,-100000,225d4fe3580# 239748: lampshabby_f.p3d,0]
[[4469.92,8350.71,3.75485],""Land_LampShabby_F"",CIV,-100000,225d4ffe080# 503559: lampshabby_f.p3d,0]
[[4537.42,8016.63,3.0697],""Land_LampStreet_small_F"",CIV,-100000,225d4ffeb00# 505815: lampstreet_small_f.p3d,0]
[[3075.23,8511.61,3.55932],""Land_LampShabby_F"",CIV,-100000,225f5500100# 236746: lampshabby_f.p3d,0]
[[3056.34,8451.91,3.54625],""Land_LampShabby_F"",CIV,-100000,225b7530b80# 236792: lampshabby_f.p3d,0]
[[2992.13,8523.9,6.95622],""Land_LampShabby_F"",CIV,-100000,225f5500b80# 236714: lampshabby_f.p3d,0]
[[3356.23,8205.32,4.06226],""Land_BarGate_F"",CIV,-100000,226765bab00# 627102: bargate_f.p3d,0]
[[3350.34,8209.06,0.856331],""Land_BagBunker_Small_F"",CIV,-100000,22634bf8100# 627103: bagbunker_small_f.p3d,0]
[[3362.41,8202.07,0.851952],""Land_BagBunker_Small_F"",CIV,-100000,22634bf9600# 627104: bagbunker_small_f.p3d,0]
[[3600.19,8510.6,3.77097],""Land_LampShabby_F"",CIV,-100000,225d4fe2080# 239849: lampshabby_f.p3d,0]
[[3506.62,8537.8,6.93039],""Land_BellTower_02_V2_F"",CIV,-100000,225d4ffc100# 239646: belltower_02_v2_f.p3d,0]
[[3002.63,7782.89,4.03233],""Land_BarGate_F"",CIV,-100000,22634e01600# 627108: bargate_f.p3d,0]
[[2996.16,7785.19,0.855812],""Land_BagBunker_Small_F"",CIV,-100000,22633bf4b80# 627109: bagbunker_small_f.p3d,0]
[[3009.55,7781.09,0.855804],""Land_BagBunker_Small_F"",CIV,-100000,22633bf5600# 627110: bagbunker_small_f.p3d,0]
[[3464.45,7499.61,0.00280762],""Zone_Logic"",LOGIC,-100000,HordeZone_31,0]
[[3464.45,7499.61,0.00280762],""StaticWeapon_Logic"",LOGIC,-100000,L Bravo 1-4:4,0]
[[3622.11,8511.29,0.850822],""Land_HelipadEmpty_F"",CIV,-100000,22635406b00# 634599: helipadempty_f.p3d,0]
[[3002.63,7782.89,4.03233],""Land_BarGate_F"",CIV,0,22634e01600# 627108: bargate_f.p3d,0]
[[2996.16,7785.19,0.855812],""Land_BagBunker_Small_F"",CIV,0,22633bf4b80# 627109: bagbunker_small_f.p3d,0]
[[3009.55,7781.09,0.855804],""Land_BagBunker_Small_F"",CIV,0,22633bf5600# 627110: bagbunker_small_f.p3d,0]
[[5234.77,9012.11,0],""StartledBirds_Logic"",LOGIC,0,<No group>:0 (StartledBirds_Logic),0]
[[5111.31,9061.98,2.39902],""Land_fs_roof_F"",CIV,0,225f5a10b80# 301557: fs_roof_f.p3d,0]
[[5099.2,9063.79,3.06567],""Land_LampStreet_small_F"",CIV,0,224890cc100# 301574: lampstreet_small_f.p3d,0]
[[4884.77,9141.8,0],""StartledBirds_Logic"",LOGIC,0,<No group>:0 (StartledBirds_Logic),0]
[[4384.77,9841.8,0],""StartledBirds_Logic"",LOGIC,0,<No group>:0 (StartledBirds_Logic),0]
[[4877.41,8644.19,3.75336],""Land_LampShabby_F"",CIV,0,225d4fc1600# 501759: lampshabby_f.p3d,0]
[[5073.95,8420.1,3.80783],""Land_LampShabby_F"",CIV,0,225d4fc2b00# 502551: lampshabby_f.p3d,0]
[[3029.9,9022.72,223.849],""Horde_O_Heli_Light_02_F"",EAST,0,O Alpha 1-2:1 (bis_o2_1466),0]
[[3635.55,8547.27,0],""Land_HelipadEmpty_F"",CIV,0,22635406b00# 634599: helipadempty_f.p3d,0]
[[2598.08,9000,0.057016],""Zone_Logic"",LOGIC,0,HordeZone_36,0]
[[2598.08,9000,0.057016],""StaticWeapon_Logic"",LOGIC,0,L Bravo 1-4:3,0]

{diag_log format ["targ %1",_x]} forEach (cameraOn nearTargets 500)

{
	_un = _x;
	_targs = _un nearTargets 2000;
	{
		_un forgetTarget (_x select 4)
	} forEach _targs
} forEach units group cameraOn

[_leader,"aware"] remoteExecCall [
	"setBehaviour",
	_leader
];

// including in fsm files

// #include "\nocebo\defines\scriptDefines.hpp" // #include directive not supported here Cannot include file \nocebo\defines\scriptDefines.hpp
// call compile preprocessFileLineNumbers "\nocebo\defines\scriptDefines.hpp"; cannot call a .hpp
// call compile preprocessFileLineNumbers "common\scriptDefines.sqf"; <<== calls but includes here are not local to FSM
// defining in fsm init-code line works but only is defined for that init-code box


http://killzonekid.com/arma-scripting-tutorials-a-few-tips-and-tricks/
call compile preprocessFileLineNumbers "includes.hpp";

B_SAM_System_01_F
B_SAM_System_02_F
B_AAA_System_01_F

// check these (weird no arrays)

uiNamespace setVariable ["ncb_uv_masterUniformsTier_0",_uniformsTier0];
uiNamespace setVariable ["ncb_uv_masterUniformsTier_1",_uniformsTier1];
uiNamespace setVariable ["ncb_uv_masterUniformsTier_2",_uniformsTier2];
uiNamespace setVariable ["ncb_uv_masterUniformsTier_3",_uniformsTier3];
uiNamespace setVariable ["ncb_uv_masterUniformsTier_4",_uniformsTier4];



[
	[/*_args*/],{
		call horde_fnc_getEachFrameArgs params ["_arg1","_arg2","_arg3"];
		call horde_fnc_removeEachFrame
	},
	0
] call horde_fnc_addEachFrame;

[
	[diag_tickTime + 10,player],{
		call horde_fnc_getEachFrameArgs params ["_timeout","_unit"];
		if (diag_tickTime > _timeout) then {
			systemChat format ["end: %1",_unit];
			call horde_fnc_removeEachFrame
		} else {
			systemChat format ["cycling: %1",time];
		}
	},
	2
] call horde_fnc_addEachFrame;

[
	[/*_args*/],{
		call horde_fnc_getEachFrameArgs params ["_arg1","_arg2","_arg3"];
		/*execute after 3 secs*/
		[
			{
				call horde_fnc_getEachFrameArgs params ["_arg1","_arg2","_arg3"];
				/*execute after 1 sec*/
				call horde_fnc_removeEachFrame
			},
			1
		] call horde_fnc_updateEachFrameData
	},
	3
] call horde_fnc_addEachFrame;


[
	[player],{
		call horde_fnc_getEachFrameArgs params ["_unit"];
		systemChat format ["3 secs: %1 %2",time,_unit];
		[
			[_unit],
			{
				call horde_fnc_getEachFrameArgs params ["_unit"];
				systemChat format ["1 sec: %1 %2",time,_unit];
				call horde_fnc_removeEachFrame
			},
			1
		] call horde_fnc_updateEachFrame
	},
	3
] call horde_fnc_addEachFrame;

[
	[0],{
		call horde_fnc_getEachFrameArgs params ["_zero"];
		call horde_fnc_removeEachFrame
	},
	0
] call horde_fnc_addEachFrame;


doggy = createVehicle ["babe_pastor_F",getPos player,[],0,"can_collide"];
doggy switchMove  "babe_pastor_Stop"
doggy switchMove  "babe_pastor_Run"
doggy switchMove  "babe_pastor_Sprint"
doggy switchMove  "babe_pastor_Walk"

 "babe_pastor_Attack1", "babe_pastor_Attack2"
badbenson: gestures: "pastorBiteGesture1", "pastorBiteGesture2"

cameraOn switchMove "babe_pastor_Attack2"

myGroup = creategroup civilian;

w_agent = myGroup createUnit ["babe_pastor_F", position player, [], 0, "can_collide"];

{w_agent disableAI _x} foreach ["FSM","AIMINGERROR","SUPPRESSION","AUTOTARGET","TARGET","COVER","SUPPRESSION","AUTOCOMBAT","CHECKVISIBLE"];
w_agent setBehaviour "Careless";
w_agent allowSprint true;


[[w_agent, "babe_pastor_Stop"],
	{
		(_this select 0) switchMove (_this select 1);
	}
] remoteExec ["call", 0, true];

_cfgAmmo = configFile >> "cfgammo";
_array = [];
for "_i" from 0 to count _cfgAmmo - 1 do {
	_cfgEntry = _cfgAmmo select _i;
	if (isClass _cfgEntry) then {
		_class = configName _cfgEntry;
		if toLower configSourceMod _cfgEntry find "project infinite" > -1) then {
			_array pushBack _class
		}
	}
};

{
	diag_log format ["%1",_x]
} forEach _array;

_cfgWeapons = configFile >> "CfgWeapons";
_cfgMagazines = configFile >> "CfgMagazines";
_cfgAmmo = configFile >> "cfgammo";
_array = [];
{
	_mags = getArray (_cfgWeapons >> (_x select 0) >> "magazines");
	_mag = _mags select 0;
	_ammo = getText (_cfgMagazines >> _mag >> "ammo");
	_array pushBackUnique [(_x select 0),_ammo];
} forEach (uiNamespace getVariable ["ncb_uv_masterRiflesTier_0",[]]);

{
	diag_log format ["%1",_x]
} forEach _array;

dogs or taunus??

gv_iterateData = [];

fn_addIterateArrayEachFrame = {
	params ["_array","_code"];
	_thisEventHandler = addMissionEventHandler [
		'EachFrame',
		fn_IterateArrayEachFrameRepeat
	];
	gv_iterateData pushBack [
		_thisEventHandler,
		_array,
		[_code,diag_frameno,0]
	];
	_thisEventHandler
};

fn_IterateArrayEachFrameRepeat = {
	{
		_x params ["_id","_array","_data"];
		if (_id isEqualTo _thisEventHandler) exitWith {
			_data params ["_code","_frame","_index"];
			if (diag_frameno > _frame) then {
				if (_index < count _array) then {
					[_array select _index] call _code;
					gv_iterateData set [_forEachIndex,[_thisEventHandler,_array,[_code,diag_frameno,_index + 1]]];
				} else {
					removeMissionEventHandler ["EachFrame",_thisEventHandler];
					private _ret = gv_iterateData deleteAt _forEachIndex;
				}
			}
		}
	} forEach gv_iterateData
};

myVar = [1,2,3,4,5];

[myVar,{
	{
		systemChat format ["%1 - %2",_x,diag_frameno]
	} forEach _this
}] call fn_addIterateArrayEachFrame

horde_fnc_iterateArrayEachFrame = {
	if (isNil "horde_gv_iterateData") then {
		horde_gv_iterateData = []
	};
	params ["_array","_code"];
	private _idx = addMissionEventHandler [
		'EachFrame',
		{
			{
				_x params ["_id","_array","_data"];
				if (_id isEqualTo _thisEventHandler) exitWith {
					_data params ["_code","_frame","_index"];
					if (diag_frameno > _frame) then {
						if (_index < count _array) then {
							[_array select _index] call _code;
							horde_gv_iterateData set [_forEachIndex,[_thisEventHandler,_array,[_code,diag_frameno,_index + 1]]];
						} else {
							removeMissionEventHandler ["EachFrame",_thisEventHandler];
							horde_gv_iterateData deleteAt _forEachIndex;
						}
					}
				}
			} forEach horde_gv_iterateData
		}
	];
	horde_gv_iterateData pushBack [
		_idx,
		+_array,
		[_code,diag_frameno,0]
	];
	true
};

_myArray = [1,2,3,4,5];

_code = {
	{
		systemChat format ["%1 - %2",_x,diag_frameno]
	} forEach _this
};

[_myArray,_code] call horde_fnc_iterateArrayEachFrame



_test = {systemChat format ["%1 - %2",_x,diag_frameno]};

{
	call _test
} forEach ["hello",1,true];



// test old functions vs remoteExec

[cursorObject,0.1] call horde_fnc_setFuelGlobal
0.0126 ms

[cursorObject,0.1] remoteExecCall [
	"setFuel",
	2
];

0.0037 ms


[player,"hitHead", 0.5] call horde_fnc_setHitPointDamageGlobal
0.014 ms


[player,["hitHead", 0.5]] remoteExecCall [
	"setHitPointDamage",
	2
];
0.0044 ms

list of my functions
setFuelGlobal ==> REPLACE
setHitPointDamageGlobal ==> REPLACE
setUnitRatingGlobal ==> MODIFY FNC
setVectorDirAndUpGlobal ==> REPLACE
setVehicleAmmoDefGlobal ==> REPLACE
setVelocityGlobal ==> REPLACE
setWeaponAmmoGlobal ==> REPLACE
staticWeaponReloadGlobal ==> MODIFY FNC
switchMoveGlobal ==> REPLACE
removeMagazineTurretGlobal ==> REPLACE
playMoveNowGlobal ==> REPLACE
lockCargoGlobal ==> REPLACE
enableSimulationGlobal ==> REPLACE
deleteGroupGlobal ==> REPLACE
allowDamageGlobal ==> REPLACE
addWeaponGlobal ==> REPLACE
addMagazineTurretGlobal ==> REPLACE
addMagazineGlobal ==> REPLACE

[ob,0] remoteExecCall [
	"setFuel",
	ob
];
[ob,["",0]] remoteExecCall [
	"setHitPointDamage",
	ob
];
[ob,vect] remoteExecCall [
	"setVectorDirAndUp",
	ob
];
[ob,vel] remoteExecCall [
	"setVelocity",
	ob
];
[ob,["",0]] remoteExecCall [
	"setAmmo",
	ob
];
[ob,""] remoteExecCall [
	"switchMove",
	0
];
[ob,["",path]] remoteExecCall [
	"removeMagazineTurret",
	ob
];
[ob,""] remoteExecCall [
	"playMoveNow",
	ob
];
[ob,[idx,bool]] remoteExecCall [
	"lockCargo",
	ob
];
[ob,bool] remoteExecCall [
	"enableSimulationGlobal",
	2
];
_grp remoteExecCall [
	"deleteGroup",
	_grp
];
[ob,bool] remoteExecCall [
	"allowDamage",
	ob
];
[ob,weap] remoteExecCall [
	"addWeapon",
	ob
];
[ob,["",path,ammocount (optional)]] remoteExecCall [
	"addMagazineTurret",
	ob
];
ob addMagazine ["magazineName", ammoCount]  // hmm or

[ob,"magazineName"] remoteExecCall [
	"addMagazine",
	ob
];

 0:10:54 A nil group passed as a target to RemoteExec(Call) 'deletegroup'
 0:10:54 A nil group passed as a target to RemoteExec(Call) 'deletegroup'
 0:10:54 A nil group passed as a target to RemoteExec(Call) 'deletegroup'
 0:10:54 A nil group passed as a target to RemoteExec(Call) 'deletegroup'
 0:10:54 A nil group passed as a target to RemoteExec(Call) 'deletegroup'
 0:10:54 A nil group passed as a target to RemoteExec(Call) 'deletegroup'
 0:10:54 A nil group passed as a target to RemoteExec(Call) 'deletegroup'
 0:10:54 A nil group passed as a target to RemoteExec(Call) 'deletegroup'
 0:10:54 A nil group passed as a target to RemoteExec(Call) 'deletegroup'



 Random question (with super-long-pretext).

When Arma was just 32 bit, you could execute this command and it would make the game freak out (presumably because either the floating point precision in Arma was 32 bit as well)

player setPosASL [9999999,9999999,0];

It seems as if Arma is OK with 6sf, but no more.  [999999,999999,0] is OK.  [1000000,1000000,0] is not..

Now that Arma is 64 bit, one would expect the precision to be of a greater magnitude.  (That was one of Star Citizens reasons to go to 64 bit as an example).

But if you execute the same command, then Arma still freaks out.

So I am thinking that the scripting engine in Arma is still 32 bit, whereas the game is 64 bit.

So my question is:

Given that adding missionEventHandlers increment an index, will there be a practical point at which the game cannot read the index of the EH you just asked for?

<btw, I am not asking about converting to string, but keeping the EH indexes as integers>


// format into waypoint statements

https://forums.bistudio.com/forums/topic/205996-make-ai-perform-custom-action/?do=findComment&comment=3204307

_wp1 setWaypointStatements [
   "true",
   format [
   "_plane = %1 call BIS_fnc_objectFromNetID;
   _plane action ['User',_plane,0]",
   str( _plane call BIS_fnc_netID )
   ]
];


	if (not isNull _grp
		and {[] isEqualTo units _grp}
	) then {
		_grp remoteExecCall [
			"deleteGroup",
			_grp
		];
	};

// powershell script to update server mods
https://forums.bistudio.com/forums/topic/183435-rhs-escalation-afrf-and-usaf/?do=findComment&comment=3204965

idd = 60492;
idc = 88829;



 9:13:46 "finding display 0"
 9:13:46 "allDisp [Display #0,Display #8,Display #17,Display #313,Display #70,Display #52]"
 9:13:46 "IGUI [Display #305,Display #311,Display #313,Display #315,Display #312,Display #303,No display,No display,No display]"
 9:13:46 "GUI [Display #0,Display #8,Display #17,Display #70,Display #52]"


 9:14:11 "finding display 21.085"
 9:14:11 "allDisp [Display #0,Display #8,Display #17,Display #313,Display #70,Display #46,Display #49,Display #12]"
 9:14:11 "IGUI [Display #305,Display #311,Display #313,Display #315,Display #312,Display #303,No display,No display,No display]"
 9:14:11 "GUI [Display #0,Display #8,Display #17,Display #70,Display #46,Display #12,Display #49,Display #228]"

dog1 = cursorObject;
dog1 switchMove "babe_pastor_Stop";
helper1 = createVehicle ["Sign_Sphere10cm_F",getPos player,[],0,"CAN_COLLIDE"];
helper1 setPos (dog1 modelToWorld [0,0.8,0.7]);
[dog1,helper1] call BIS_fnc_attachToRelative;

//helper1 attachTo [dog1,[0,0.9,1.6]];


helper1 = createVehicle ["Sign_Sphere10cm_F",getPos player,[],0,"CAN_COLLIDE"];
helper1 setPos (player modelToWorld (player selectionPosition "spine3"));

B_12G_Pellet
B_12Gauge_Pellets


ON DEDI WHEN MOVING ITEMS FROM VEST TO BACKPACK, OLD ITEMS ARE NOT DELETED

CHECK GETOUT EH FIRES IF UNITS ARE KILLED AND SETPOSSED FROM THE VEHICLE

JETS DLC FILTER

RELOAD GL ON SOCHOR

DO NOT ADD SOCHOR TO ABANDONED VEHS WHEN CREW DESPAWN

RETHINK ABANDONED VEHICLES (if disabled in zone then add) clearGarbage.fsm

ALSO:  WORK OUT WHAT TO DO WITH SURRENDERED UNITS (5 min timer then kill them)

FUEL IN INDY CHOPPERS TOO LOW?

WAYPOINTS FOR INDY CHOPPERS - ONLY NEED ONE BASED ON FINDNEARESTENEMY


variableItems params ["_classes","_count"];

for "_i" from 0 to count _classes - 1 do {
	supplyBox addItemCargo [_classes select _i,_count select _i]
};

[group driver cameraOn,2] waypointAttachVehicle player; group driver cameraOn setCurrentWaypoint [group driver cameraOn,2]

2017/07/14,  2:55:54 "horde_fnc_serverPostInit"" - zone - not found air base vehicle spawn pos: HordeZone_13"
2017/07/14,  2:55:54 "ncb_gv_AirBasePositions [[HordeZone_13,""ABHordeZone_13"",""military base"",[9705.4,3963.21,38.91],[],[]]]"

_ins = lineIntersectsSurfaces [
	AGLToASL positionCameraToWorld [0,0,0],
	AGLToASL positionCameraToWorld [0,0,1000],
	player
];
if ([] isEqualTo _ins) exitWith {systemChat "no intersection"};

_ins select 0 params ["_posASL"];

["c130",ASLtoATL _posASL] call horde_fnc_cas;

{group gunner cameraOn reveal [_x,4]} forEach [cameraOn nearEntities ["camanbase",1000]]

{diag_log _x} forEach selectionNames cameraOn
GunnerTurret_01
 1:28:35 "zbytek"
 1:28:35 "howitzer"
 1:28:35 "gatling"
 1:28:35 "cannon"
 1:28:35 "gatling_muzzleflash"
 1:28:35 "cannon_muzzleflash"
 1:28:35 "gatling_barrels"
 1:28:35 "cannon_barrel"
 1:28:35 "howitzer_barrel"

 player setCaptive true; ncb_param_invincible = 1; [200,500] call horde_fnc_cas;
fnc_getBoatPositions = {
	_zone = (nearestObjects [getPos player,["Zone_logic"],2000]) select 0;

	private _fnc_noLand = {
		private _noLand = true;
		for "_i" from 0 to 350 step 10 do {
			if (getTerrainHeightASL (_this getPos [100,_i]) > 0) exitWith {
				_noLand = false
			};
		};
		_noLand
	};

	_cfgVSD = configFile >> "CfgZones" >> worldName >> (str _zone) >> "VehicleSpawnData";

	_arr = getArray (_cfgVSD >> "beachingDataAGL");

	_wpPositions = [];
	{
		_pos = _x;
		for "_i" from 0 to 350 step 10 do {
			_tPos = _pos getPos [110,_i];
			if (_tPos call _fnc_noLand
				and {getTerrainHeightASL _tPos < -10}
			) then {
				_wpPositions pushBack _tPos
			}
		}
	} forEach _arr;

	{
		_mkr = createMarker [str _x + "INIT",_x];
		_mkr setMarkerSize [10, 10];
		_mkr setMarkerShape "Ellipse";
		_mkr setMarkerBrush "SolidBorder";
		_mkr setMarkerColor "ColorBlue";
		_mkr setMarkerAlpha 1;
	} forEach _wpPositions;
};



stole car (from ai)

parked it up

logged out but left server running

logged back in

car has disappeared

logs show this:

2017/07/16, 22:35:46 "garbage script"
2017/07/16, 22:35:46 "ncb_gv_abandonedVehicles [13cdf020080# 632833: mrap_03_unarmed_f.p3d REMOTE]"
2017/07/16, 22:35:46 "types ncb_gv_abandonedVehicles [""Horde_I_MRAP_03_F""]"
2017/07/16, 22:35:46 "count ncb_gv_abandonedVehicles 1"
2017/07/16, 22:35:59 "--------------------------------------------------------"
2017/07/16, 22:35:59 "horde_fnc_serverPlayerLogOut"" - started: [false,p1,66.9109,33.6718,0,0,[0,0],[0,0],[0,0],[1,1],[0,0],[2,2],[0,0],[0,0]]"
2017/07/16, 22:35:59 "--------------------------------------------------------"
2017/07/16, 22:36:07 Warning: Cleanup player - person 3:25 not found
2017/07/16, 22:36:22 "HCMANAGER - drones []"
2017/07/16, 22:36:48 "garbage script"
2017/07/16, 22:36:48 "ncb_gv_abandonedVehicles [<NULL-object>]"
2017/07/16, 22:36:48 "types ncb_gv_abandonedVehicles [""""]"
2017/07/16, 22:36:48 "count ncb_gv_abandonedVehicles 1"

so presumably, I parked the car in the zone.

Then when I logged out, the zone despawned and took the car (part of the _zoneVehicles variable in zonemanager.fsm)

Solution:  Need a way of tagging the car as being player owned

1) player has variable which keeps track of last vehicle driven (use shareVarWithServer)

On players machine, the var is assigned to the player

Like:

player setVariable ["playerCurrentVehicle",vehicleA];

It sends a message to server which assigns the var to the vehicle

_vehicle setVariable ["ncb_garbageExcluded",true];

Then when the player switches vehicles, a message is sent to the server to assign the current vehicle a var
and the var is removed off the old vehicle

player:
_oldVehicle = player getVariable ["playerCurrentVehicle",objNull];
_vehicle setVariable ["playerCurrentVehicle",vehicleB];
server:
_oldVehicle setVariable ["ncb_garbageExcluded",nil];
_vehicle setVariable ["ncb_garbageExcluded",true];

The abandoned vehicles fsm already has this built in, so only the "despawn empty zones" condition in zoneManager.fsm will need to be updated.

Plus horde_fnc_getInVehicle will need to have some code added (NOTE THAT IT RUNS ON THE SERVER).

Potential pitfalls:

What if someone else gets in first?  (then vehicle is "theirs")

What if player amasses some vehicles in a zone then logs out?  Only the last one they drove would be saved.

Is this ok????

Way around this would be to trip some code in horde_fnc_getInVehicle which scans for active zones around the player, then
we can search the "zoneCurrentVehicles" variable for each of those zones and if the vehicle is found, then remove it.
Not ideal though as this is out of sequence with the fsm and could lead to overwriting it incorrectly.
Or maybe introduce another variable once a vehicle has been driven by a player, but then this would produce weird results for
empty vehicles spawned when the zone is activated (or maybe not as they could be added to abandonedVehicles variable)

code:


PLAYER CAN LOG OUT OF THE SERVER AT ANYONES TENT!!!!!!!!!!! SHOULD ONLY BE HIS PERSONAL TENT, HIS OWN GROUP, OR SIDE!!

Or maybe do not bother as the player could take the tent down, then pitch it then log out...

(to change it, edit horde_fnc_serverSetTentOwner and change this to public setVar(_tent,"tentOwnerDetails",_details);  >> then edit the conditions in interactioninfo.hpp)

2017/07/17,  3:43:44 Error in expression <eli;
if (isNull _enemy) then {
[_grp,1] setWaypointPosition ((_heli getPos [400 >
2017/07/17,  3:43:44   Error position: <setWaypointPosition ((_heli getPos [400 >
2017/07/17,  3:43:44   Error 3 elements provided, 2 expected

group menu:

groups (containing players) - also maybe ungrouped as well or have them in their separate groups
(maybe have the players in a tooltip)

Join button
Invite button
Private tickbox
option to edit group name
Maybe some nice icons next to peoples names ()

https://community.bistudio.com/wiki/showHUD seems to have changed - need to update!

 BIS_fnc_exportGUIBaseClasses
https://forums.bistudio.com/forums/topic/201433-gui-editor-why-are-rsc-classes-not-predefined/?do=findComment&comment=3137980


I FORGOT THE INVITES BUTTON  !!!!!!

horde_fnc_openDynamicGroupExtMenuGroup = {
	_invDisp = getVar(uiNamespace,"ncb_dynamicGroupsMenu");
	_toggleExtOptionsCtrl = _invDisp displayCtrl 2000;
	_extListBoxCtrl = _invDisp displayCtrl 3;
	_extActionButtonCtrl = _invDisp displayCtrl 5;
	_groupNameTextCtrl = _invDisp displayCtrl 6;
	_groupNameInputCtrl = _invDisp displayCtrl 7;
	_squadListBoxCtrl = _invDisp displayCtrl 8;
	_squadActionListBoxCtrl = _invDisp displayCtrl 10;
	_squadIconsPictureCtrl = _invDisp displayCtrl 12;
	_squadIconsListBoxCtrl = _invDisp displayCtrl 13;
	_privateStatusCheckBoxCtrl = _invDisp displayCtrl 16;
	_toggleExtOptionsCtrl ctrlSetText "Groups";
	_toggleExtOptionsCtrl ctrlSetEventHandler [
		"ButtonDown","
			diag_log format ['button down: %1',_this];
			0 call horde_fnc_openDynamicGroupExtMenuPlayer
		"
	];
	// need a way of passing selected group to function

	_extListBoxCtrl ctrlSetEventHandler [
		"LBSelChanged","
			diag_log format ['group selected %1',(_this select 0) lbData (_this select 1)];
			(_this select 0) setVariable ['selectedItem',(_this select 0) lbData (_this select 1)]
		"
	];
	lbClear _extListBoxCtrl;
	// update menu (this bit needs to be on each frame)
	{
		if (side _x isEqualTo west) then {
			_index = _extListBoxCtrl lbAdd str _x;
			_tooltip = "Group Members:" + endl;
			{
				_tooltip = _tooltip + (name _x) + endl;
				nil
			} count units _x;

			_extListBoxCtrl lbSetColor [_index,if (_x getVariable ["ncb_privateGroup",false]) then {[1,0,0,0.5]} else {[0,1,0,0.5]}];
			_extListBoxCtrl lbSetPicture [_index,_x getVariable ["ncb_iconGroup","\nocebo\images\led_green.paa"]];
			_extListBoxCtrl lbSetTooltip [_index,_tooltip];
			_extListBoxCtrl lbSetData [_index,netID _x];
			_extListBoxCtrl lbSetValue [_index,_index];
		};
	} forEach allGroups;  // {_allGroupsWithPlayers pushBackUnique group _x} forEach allPlayers - entities "HeadlessClient_F";
	//
	_extActionButtonCtrl ctrlSetText "Join";

	// join this group if not private
	_extActionButtonCtrl ctrlSetEventHandler [
		"ButtonDown","
			call horde_fnc_playerJoinGroup
		"
	];
	_toggleExtOptionsCtrl ctrlCommit 0;
	_extListBoxCtrl ctrlCommit 0;
	_extActionButtonCtrl ctrlCommit 0;
};
horde_fnc_openDynamicGroupExtMenuPlayer = {
	_invDisp = getVar(uiNamespace,"ncb_dynamicGroupsMenu");
	_toggleExtOptionsCtrl = _invDisp displayCtrl 2000;
	_extListBoxCtrl = _invDisp displayCtrl 3;
	_extActionButtonCtrl = _invDisp displayCtrl 5;
	_groupNameTextCtrl = _invDisp displayCtrl 6;
	_groupNameInputCtrl = _invDisp displayCtrl 7;
	_squadListBoxCtrl = _invDisp displayCtrl 8;
	_squadActionListBoxCtrl = _invDisp displayCtrl 10;
	_squadIconsPictureCtrl = _invDisp displayCtrl 12;
	_squadIconsListBoxCtrl = _invDisp displayCtrl 13;
	_privateStatusCheckBoxCtrl = _invDisp displayCtrl 16;
	_toggleExtOptionsCtrl ctrlSetText "Players";
	_toggleExtOptionsCtrl ctrlSetEventHandler [
		"ButtonDown","
			call horde_fnc_openDynamicGroupExtMenuInvites
		"
	];

	// need a way of passing selected player to function

	_extListBoxCtrl ctrlSetEventHandler [
		"LBSelChanged","
			diag_log format ['player selected %1',(_this select 0) lbData (_this select 1)];
			(_this select 0) setVariable ['selectedItem',(_this select 0) lbData (_this select 1)]
		"
	];
	lbClear _extListBoxCtrl;
	// update menu (this bit needs to be on each frame)
	{
		if (side _x isEqualTo west) then {
			_index = _extListBoxCtrl lbAdd name _x;
			_extListBoxCtrl lbSetPicture [_index,"\nocebo\images\led_green.paa"];
			_extListBoxCtrl lbSetColor [_index,[1,1,1,0.5]];
			_extListBoxCtrl lbSetData [_index,netID _x];
			_extListBoxCtrl lbSetValue [_index,_index];
		};
	} forEach allUnits;
	//
	_extActionButtonCtrl ctrlSetText "Invite";
	_extActionButtonCtrl ctrlSetEventHandler [
		"ButtonDown","
			call horde_fnc_playerSendInvite
		"
	];
	_toggleExtOptionsCtrl ctrlCommit 0;
	_extListBoxCtrl ctrlCommit 0;
	_extActionButtonCtrl ctrlCommit 0;
};
horde_fnc_openDynamicGroupExtMenuInvites = {
	_invDisp = getVar(uiNamespace,"ncb_dynamicGroupsMenu");
	_toggleExtOptionsCtrl = _invDisp displayCtrl 2000;
	_extListBoxCtrl = _invDisp displayCtrl 3;
	_extActionButtonCtrl = _invDisp displayCtrl 5;
	_groupNameTextCtrl = _invDisp displayCtrl 6;
	_groupNameInputCtrl = _invDisp displayCtrl 7;
	_squadListBoxCtrl = _invDisp displayCtrl 8;
	_squadActionListBoxCtrl = _invDisp displayCtrl 10;
	_squadIconsPictureCtrl = _invDisp displayCtrl 12;
	_squadIconsListBoxCtrl = _invDisp displayCtrl 13;
	_privateStatusCheckBoxCtrl = _invDisp displayCtrl 16;
	_toggleExtOptionsCtrl ctrlSetText "Invites";
	_toggleExtOptionsCtrl ctrlSetEventHandler [
		"ButtonDown","
			call horde_fnc_openDynamicGroupExtMenuGroup
		"
	];

	// pass selected group to function

	_extListBoxCtrl ctrlSetEventHandler [
		"LBSelChanged","
			diag_log format ['invite selected %1',(_this select 0) lbData (_this select 1)];
			(_this select 0) setVariable ['selectedItem',(_this select 0) lbData (_this select 1)]
		"
	];
	lbClear _extListBoxCtrl;
	// update menu (this bit needs to be on each frame)
	{
		if (not isNull _x) then {
			_index = _extListBoxCtrl lbAdd groupID _x;
			_extListBoxCtrl lbSetPicture [_index,"\nocebo\images\led_green.paa"];
			_extListBoxCtrl lbSetColor [_index,[1,1,1,0.5]];
			_extListBoxCtrl lbSetData [_index,netID _x];
			_extListBoxCtrl lbSetValue [_index,_index];
		};
	} forEach (player getVariable ["ncb_groupInvites",[]]);
	//
	_extActionButtonCtrl ctrlSetText "Accept";
	_extActionButtonCtrl ctrlSetEventHandler [
		"ButtonDown","
			call horde_fnc_playerAcceptInvite
		"
	];
	_toggleExtOptionsCtrl ctrlCommit 0;
	_extListBoxCtrl ctrlCommit 0;
	_extActionButtonCtrl ctrlCommit 0;
};

0 spawn {
	_grp = [getPos player, west, 5] call BIS_fnc_spawnGroup;
	waitUntil {not isNull _grp};
	_grp deleteGroupWhenEmpty true;
	_grp setGroupIDGlobal [format ["dudeGroup%1",name leader _grp]];
	_var = player getVariable ["ncb_groupInvites",[]];
	_var pushBackUnique _grp;
	_var = _var - [grpNull];
	player setVariable ["ncb_groupInvites",_var];
};
0 spawn {
	for "_i" from 1 to 5 do {
		sleep (3 + random 3);
		_grp = [player modelToWorld [0,7 * _i,0], west, 5] call BIS_fnc_spawnGroup;
		waitUntil {not isNull _grp};
		_grp deleteGroupWhenEmpty true;
		_grp setGroupIDGlobal [format ["dudeGroup%1",name leader _grp]];
		_var = player getVariable ["ncb_groupInvites",[]];
		_var pushBackUnique _grp;
		_var = _var - [grpNull];
		player setVariable ["ncb_groupInvites",_var];
		_grp spawn {
			sleep (3 + random 3);
			_this setVariable ["ncb_privateGroup",true];
			sleep (3 + random 3);
			_this setVariable ["ncb_privateGroup",false];
			sleep (3 + random 3);
			_this setVariable ["ncb_privateGroup",true];
			sleep (3 + random 3);
			_this setVariable ["ncb_privateGroup",false];
			sleep (3 + random 3);
			{
				deleteVehicle _x
			} count units _this;
			deleteGroup _this
		};
	};
};

[_x,_data] call BIS_fnc_setUnitInsignia
[player,"111thID"] call BIS_fnc_setUnitInsignia


cannon_105mm_VTOL_01
magazines[] = {
	"40Rnd_105mm_APFSDS",
	"40Rnd_105mm_APFSDS_T_Red",
	"40Rnd_105mm_APFSDS_T_Green",
	"40Rnd_105mm_APFSDS_T_Yellow",
	"100Rnd_105mm_HEAT_MP",
	"20Rnd_105mm_HEAT_MP",
	"20Rnd_105mm_HEAT_MP_T_Red",
	"20Rnd_105mm_HEAT_MP_T_Green",
	"20Rnd_105mm_HEAT_MP_T_Yellow"
};

// turret

magazines[] = {"100Rnd_105mm_HEAT_MP","4000Rnd_20mm_Tracer_Red_shells"};

ammo = "Sh_105mm_HEAT_MP";
aiAmmoUsageFlags = "64 + 128 + 256";

https://forums.bistudio.com/forums/topic/71194-drag-and-drop-between-two-listbox/?do=findComment&comment=1272733

[400,1000] call horde_fnc_cas;
ncb_param_invincible = 1;
newGrp = createGroup east;
[player] joinSilent newGrp;
 player enableStamina false

 Alternative to setting up tasks:

 https://forums.bistudio.com/forums/topic/176638-error-zero-divisor-multi-dimensional-array/?do=findComment&comment=2771709

 read secret file and tasks are generated!


// sending functions to client
// use joinstring to create a string from the code then send to client where they compileFinal it

// example
(([{
	_this addMPEventHandler ["MPKilled", {
		_this = _this select 0;
		{
			deleteVehicle _x;
		} forEach (_this getVariable ["effects", []]);
		if (isServer) then {
			deleteVehicle _this;
		};
	}];
	_this setDamage 1;
}] joinString "") splitString toString [32,9,13,10] joinString "")

// returns this:

{  _this addMPEventHandler ["MPKilled", {   _this = _this select 0;   {    deleteVehicle _x;   } forEach (_this getVariable ["effects", []]);   if (isServer) then {    deleteVehicle _this;   };  }];  _this setDamage 1; }

fnc_whitespace = {
	private _noWhitespace = toArray(_this);
	{
		if ([32, 9, 13, 10] find _x > -1) then
		{
			_noWhitespace set [_forEachIndex,objNull];
		};
	} forEach _noWhitespace;
	_noWhitespace = _noWhitespace - [objNull];
	toString(_noWhitespace)
};

([{
	_this addMPEventHandler ["MPKilled", {
		_this = _this select 0;
		{
			deleteVehicle _x;
		} forEach (_this getVariable ["effects", []]);
		if (isServer) then {
			deleteVehicle _this;
		};
	}];
	_this setDamage 1;
}] joinString "") call fnc_whitespace

{  _this addMPEventHandler ["MPKilled", {   _this = _this select 0;   {    deleteVehicle _x;   } forEach (_this getVariable ["effects", []]);   if (isServer) then {    deleteVehicle _this;   };  }];  _this setDamage 1; }

https://forums.bistudio.com/forums/topic/187752-script-release-remove-whitespace/?do=findComment&comment=2974300


returns "_var" !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

#define diag(a) \
private _arr = toArray str {a}; \
_arr deleteAt count _arr -1; \
_arr deleteAt 0; \
 diag_log format [toString _arr + ": %1",a]

 #define diag(a) \
_arr = toArray str {a}; \
_arr deleteAt count _arr -1; \
_arr deleteAt 0; \
 diag_log format [toString _arr + ": %1",a]


[
	[""100Rnd_105mm_HEAT_MP"",100,true,65536,""cannon_105mm_VTOL_01""],
	[""4000Rnd_20mm_Tracer_Red_shells"",4000,true,65536,""gatling_20mm_VTOL_01""]
]

[
	""105mm HEAT-MP(100/100)[id/cr:10023610/2]"",
	""20 mm Shells(4000/4000)[id/cr:10023611/2]""
]

squad actions (does not matter if leader)

- if player has "documents" or something, then he can request a CAS aircraft (option in group menu, opens map)

- if player is in CAS aircraft, then under squad actions, he can request a group member to join him.  They then get an action on their menu (accept)



fnc_replaceWithTracer = {
	_magTypesToDel = [];
	_tracerTypes = [];
	{
		if (toLower _x find "tracer" > -1) then {
			_tracerTypes pushBack _x
		} else {
			_magTypesToDel pushBack _x
		}
	} forEach (getArray(configfile>>"cfgWeapons">>(primaryWeapon _this)>>"magazines"));
	_magsToRemove = [];
	_magsToAdd = [];
	_removedPrimary = false;
	{
		_currMag = _x;
		if (_currMag in _magTypesToDel) then {
			_count = getNumber(configfile>>"cfgMagazines">>_currMag>>"count");
			{
				if (_count == getNumber(configfile>>"cfgMagazines">>_x>>"count")) exitWith {
					_magsToRemove pushBack _currMag;
					_magsToAdd pushBack _x;
				}
			} forEach _tracerTypes;
			if (_forEachIndex == 0) then {
				_this removePrimaryWeaponItem (primaryWeaponMagazine _this);
				_removedPrimary = true;
			}
		}
	} forEach ([currentMagazine _this] + magazines _this);
	{
		_this removeMagazine _x
	} forEach _magsToRemove;
	{
		if (_forEachIndex == 0 and {_removedPrimary}) then {
			_this addPrimaryWeaponItem _x
		} else {
			_this addMagazine _x
		}
	} forEach _magsToAdd;

};


MAKE NICE FLOCKS OF SHEEP, TRIBE OF GOATS, PACK OF DOGS ETC


uiNamespace getVariable "uiInteractionInfo" - use this for interaction with objects that are not vehicles

Already set ()!  [_object,_type,_cfgObject,_cfgInteract,_intersectPos]

This is the dialog:  "Horde_interactionMenu_general"

This opens setupGeneralMenuDlg, which tests the conditions:

So try changing _object and _intersectPos in interactioninfo.hpp to ((uiNamespace getVariable 'uiInteractionInfo') select 0) and ((uiNamespace getVariable 'uiInteractionInfo') select 4)


ADD IN THE NEW WRECKS

DO SOMETHING ABOUT THE PARA BEACON BLEEPING

blur ON PARADROP BROKEN   ppEffectCreate ["dynamicBlur"

This fixed it:  for "_i" from 0 to 9999 do {ppEffectDestroy _i}

Maybe there is a bug with repacking - it seems one of the new options is displayed as the mag you have...

capture the main airbase by throwing a switch in the control tower

rescue the hostages and they give you a code to unlock one of the hangars with a jet in it

unlock the aircraft carrier somehow

// https://forums.bistudio.com/forums/topic/202398-hangar-doors/
"Land_Airport_01_hangar_F"

I forgot about para beacons!

antenna_source
lock_source
sesame_source

if (cursorObject animationSourcePhase "sesame_source" == 0) then {
	cursorObject animateSource ["sesame_source",1];
	cursorObject animateSource ["antenna_source",1];
	cursorObject animateSource ["lock_source",1];
} else {
	cursorObject animateSource ["sesame_source",0];
	cursorObject animateSource ["antenna_source",0];
	cursorObject animateSource ["lock_source",0];
};

2017/07/30, 22:31:55 "/****garbage script****/"
2017/07/30, 22:31:55 "time now: 1959"
2017/07/30, 22:31:55 "ncb_gv_abandonedVehicles: [20e52634080# 620251: lsv_02_f.p3d REMOTE]"
2017/07/30, 22:31:55 "types: [""Horde_O_LSV_02_armed_F""]"
2017/07/30, 22:31:55 "time abandoned: [424]"
2017/07/30, 22:31:55 "count: 1"
2017/07/30, 22:31:55 "/*******************/"
2017/07/30, 22:31:55 "garbage - deleting vehicle case C: 20e52634080# 620251: lsv_02_f.p3d REMOTE"

car deleted next to my tent.  I went off into another zone leaving them both there.

Case C means: // if is car/plane/heli and is disabled or if not assigned to a zone (rens etc) then delete

Need to change logic so that whetever the case is, if there is a tent/para-beacon in 50m then do not delete

Looks like in the getout function that only players add to abandoned vehicles (because AI driven vehicles are deleted by zone )

_unit setPos getPos _unit triggers the "getout" EH !  (so nothing needed in unit killed!!)

OK - solution is this:

Anytime a vehicle is abandoned, it gets pushed to the list (this is when all crew are out or died and are pushed out)

Then the getin EH nils the "vehAbandonedTime" variable

update the zoneManager despawn EMPTY zones cond

and garbage.fsm

And get rid of that variable "vehicleassignedZone"

and horde_fnc_despawnEmptyVehicles


_zone setVariable ["zoneMortarData",[_veh,_unit,[]]];


player switchMove "AmovPercMstpSnonWnonDnon_exerciseKata"

"276 functions compressed in 51.669 seconds"

// writ fnc to add mags to vehicles on spawn.

ncb_fnc_addExtraVehicleMags = {
	_info = missionNamespace getVariable ("ncb_gv_extraVehicleMagData_" + (typeOf _this));
	if not (isNil "_info") then {
		{
			_x params ["_path","_mags"];
			{
				// maybe just do it locally as the vehicles have just been created on the server
				_this addMagazineTurret [_x,_path]
				/*[_this,[_x,_path]] remoteExecCall [
					"addMagazineTurret",
					_veh turretOwner _path
				];*/
			} forEach _mags
		} forEach _info
	} else {
		diag("extra mag info missing for this class");
		diag(typeOf _this);
	}
};
// GREAT PLACE FOR A BASE !
["Malden",[6703.17,5092.8,2.35454],341.09,0.75,[-30.4741,0],0,0,819.74,0.114112,0,1,0,1]


PUT LIMIT ON RENEGADES + CHECK SPAWNING TIMES!

ADD ACTIONS TO MALDEN CLASSNAMES

copyToClipboard str (uiNamespace getVariable "horde_fnc_setupDynamicGroupsMenu")
plane1 selectWeapon "BombCluster_01_F";
0 = 0 spawn {
	for "_i" from 1 to 4 do {
		systemChat format ["fired %1",[plane1,"BombCluster_01_F"] call bis_fnc_fire];
		sleep 0.1
	}
}
"BombCluster_03_F"
"BombCluster_01_F"

feint_shark
feint_shark2

[getPosASL p1,getPosASL p2] execVM "waypointFinder.sqf"
[getPosASL p1,getPosASL p2] execVM "waypointFinderLocations.sqf"

hint str (terrainIntersectASL[getPosASL p1,AGLtoASL (p1 modelToWorld [0,0,-4])])

hint str (terrainIntersectASL[AGLtoASL (p1 modelToWorld [0,0,10]),AGLtoASL (p1 modelToWorld [0,0,-4])])


onEachFrame {
	hintSilent str (lineIntersectsSurfaces [
		AGLtoASL (p1 modelToWorld [5,0,10]),
		AGLtoASL (p1 modelToWorld [5,0,-4]),
		p1
	])
}

player addEventHandler [
	"WeaponAssembled", {
		params ["_unit","_obj"];
		if (_obj isKindOf "UAV_01_base_F") then {
			{_x disableUAVConnectability [_obj,true]} forEach (allPlayers - [_unit])
		}
	}
];
// add to lootlists
"B_UAV_01_backpack_F" // cfgvehicle
"B_UavTerminal" // cfgWeapons

AA Missile:
AMRAAM : Radar Active Homing (RAH)
R77 Adder: RAH
Zephyr: RAH
BIM-9X: IR guidance
R73 Archer : IR guidance
Falchion 22 : IR guidance
Sahr 3: IR guidance
ASRAAM : IR guidance

AG Missile:
Macer: IR guidance only
Sharur : IR guidance only
KH 25 Kedge: IR guidance only
Scalpel : IR and Laser guidance
DAGR : IR and Laser guidance
DAR : Dumb fire
Shrieker : Dumb fire
Tratnyr : Dumb fire
DAR: Dumb fire (but burst mode)

Bomb:
LOM-250G (KAB-250): Laser guided bomb
GBU-12 : Laser guided bomb
Mk82 : Dumb Bomb

updated cas scripts - can now get friend for chopper gunner
added uavs - they do not trigger ememies, but cannot be hijacked by other players
updated loot a bit
need to check out mlrs and drones
must add spawning cap in for indfor
add tracer mags back in and update all the guns.
get rid of 6.5mm miniguns!
finish dogs
finish group menu (few odds and ends)
make some inventory pictures




_configs = "toLower getText(_x >> 'ammo') find '762x51' > -1" configClasses (configFile / "cfgmagazines");
{diag_log configName _x} count _configs

_configs = "toLower getText(_x >> 'ammo') find '762x51' > -1 and {configName _x isKindOf ['VehicleMagazine',configFile >>'cfgMagazines']}" configClasses (configFile / "cfgmagazines");
{diag_log configName _x} count _configs

Make some proper crew for blackfish + cas (with getout EH so they die)

// some aircraft could/should be based on dynamic loadout aircraft

_animals = [];
for "_i" from 0 to 30 do {
	_animal = createAgent ["Salema_F",getPos player, [], 0,"CAN_COLLIDE"];
	if (_i == 0) then {
		_animal hideObject true
	} else {
		_animal setVariable ["BIS_fnc_animalBehaviour_disable",true];
	};
	_animals pushBack _animal;
	_animal setVariable ["startpos",getPosASL _animal];
	_animal setVariable ["endpos",getPosASL (_animals select 0)];
	_animal addEventHandler ["AnimDone", {
		_animal = _this select 0;
		_leader = (_animal getVariable ["animals",[_animal]]) select 0;
		_animal setVariable ["startpos",_animal getVariable "endpos"];
		_animal setVariable ["endpos",getPosASL _leader vectorAdd [random [-0.7,0,0.7],random [-0.7,0,0.7],random [-0.7,0,0.7]]];
		_animal setVariable ["endpos",getPosASL _leader vectorAdd (_leader vectorModelToWorld [random [-1,0,1],random [-1,0,1],random [0,-0.5,-1]])];
	}];
};
{
	_x setVariable ["animals",_animals];
	_x switchMove "Fishes_Swim";
} forEach _animals;

[
	[_animals],{
		call horde_fnc_getEachFrameArgs params ["_animals"];
		_leader = _animals select 0;
		{
			_x setVelocityTransformation [
				_x getVariable "startpos",
				_x getVariable "endpos",
				[0,0,0],
				[0,0,0],
				[0,1,0],
				[0,1,0],
				[0,0,1],
				[0,0,1],
				moveTime _x
			];
			_dir = ((_x getVariable "startpos") getDir (_x getVariable "endpos"));
			_adj = (_x getVariable "startpos") distance2D (_x getVariable "endpos");
			if (_adj == 0) then {_adj = 0.01};
			_opp = ((_x getVariable "endpos") select 2) - ((_x getVariable "startpos") select 2);
			_angle = atan (_opp / _adj);;
			_pitch = 0;
			_vecdx = sin(_dir) * cos(_angle);
			_vecdy = cos(_dir) * cos(_angle);
			_vecdz = sin(_angle);
			_vecux = cos(_dir) * cos(_angle) * sin(_pitch);
			_vecuy = sin(_dir) * cos(_angle) * sin(_pitch);
			_vecuz = cos(_angle) * cos(_pitch);
			_x setVectorDirAndUp [ [_vecdx,_vecdy,_vecdz], [_vecux,_vecuy,_vecuz] ];
		} forEach (_animals - [_leader])
	},
	0
] call horde_fnc_addEachFrame;

0 = 0 spawn {
	waitUntil {not isNull findDisplay 46 and {not isNull player}};
	_ID = (findDisplay 46) displayAddEventHandler ["KeyDown",{
		private _handled = false;
		if ((_this select 1) in (actionKeys "ReloadMagazine")) then {
			player setAnimSpeedCoef 0.5;
		};
		_handled
	}];
	player addEventHandler ["reloaded", {player setAnimSpeedCoef 1}];
};

add water sources to interaction info - DONE (script error in compression (had to format var into configClasses))
not getting sochor destroyed messages - DONE (remoteExecCall)
possibly save all abandoned sochor positions for server reload
some sort of AA for sochors (either static AA or remote turrets)
work out way of getting Blackfish documents (either small side mission or add to mil buildings loot)
Mortar gunner (reveal player) - DONE (ALTERED ZONE_MANAGER AND LEADERTARGETS)
surrendered units!

setFlagTexture !!!!  Jolly Roger

cursorObject setFlagTexture "\nocebo\images\jolly_roger.paa"

configfile >> "CfgVehicles" >> "O_HMG_01_high_F" >> "Turrets" >> "MainTurret"
["MainTurret","MainTurret","MainTurret","MainTurret","NewTurret"]

anim ui vehicles weapons

{
	if (alive _x) then {
		_x getVariable ["lookAroundData",["",[],[]]] params ["_type","_data","_data2"];
		call {
			if (_type == "sniper") exitWith {
				if (random 3 > 2) then {
					(selectRandom _data2) params ["_wp","_stance"];
					_x doWatch _wp;
					_x setUnitPos _stance
				};
			};
			if (_type == "static") exitWith {
				if (random 3 > 2) then {
					_x doWatch ((selectRandom _data2) vectorAdd [0,0,10 - random 30])
				}
			};
			if (_type == "artillery") exitWith {
				_data params ["_veh","_turretPath","_timeNextSalvo"];
				if (not isNull _veh
					and {alive _veh}
				) then {
					if (_x == gunner _veh) then {
						if (time > _timeNextSalvo) then {
							_salvoCount = floor random [2,6,6];
							_veh setVariable ["salvoCount", [(getPosATL _veh) vectorAdd _lookPos,1,_salvoCount]];
							// (commander _veh) doWatch objNull;
							_veh doArtilleryFire [
								_artyTarget,
								"32Rnd_155mm_Mo_shells",
								_salvoCount
							];
							_reloadTime  = getNumber (configfile >> "CfgWeapons" >> "mortar_155mm_AMOS" >> "reloadTime");
							_data set [2,round (time + (_reloadTime * _salvoCount) + 10 + (random 20))]; // update variable
						};
					} else {
						// commander
						// _x doWatch ((getPosATL _veh) vectorAdd _lookPos);
					};
				};
			};
			if (_type == "antiair") exitWith {
				_data params ["_veh","_path"];
				if (not isNull _veh
					and {alive _veh}
				) then {
					if (_x == gunner _veh) then {
						if (random 1 > 0.6) then {
							_aim = _veh getPos [1000,random 360];
							_aim set [2,600 + random 600];
							_x doWatch _aim;
							private _weapons = _veh weaponsTurret _path;
							_weap = _weapons select 0;
							/*_veh action ["UseWeapon",_veh,_x,0];*/
							[_x,_weap] spawn {
								params ["_unit","_weap"];
								for "_i" from 1 to 15 do {
									_unit forceWeaponFire [_weap,_weap];
									sleep 0.15
								}
							}

						}
					}
				}
			}
		}
	}
} count units _grp;

0 = 0 spawn {{_x setDamage 1;uiSleep 0.05} forEach ((player nearEntities ["SoldierEB",2000]) select {simulationEnabled _x}};



{private _js=(_this getvariable["tentOwnerDetails",[]]);if !(_js isequalto[])then{_js params["_jj","_jr","_jv"];call{if(_jv=="personal")exitwith{{if(getplayeruid _x==_jj)exitwith{_jr remoteexeccall["horde_fnc_playerRemoveTentMarker",_x]}}foreach allplayers};if(_jv=="group")exitwith{_jr remoteexeccall["horde_fnc_playerRemoveTentMarker",0]};if(_jv=="side")exitwith{deletemarker _jr}}};_this setvariable["deadDeleteTime",(round time)+60];ncb_gv_garbagecontents pushback _this;true
}

{
	private _js = (_this getvariable["tentOwnerDetails", []]);
	if !(_js isequalto[]) then {
		_js params["_jj", "_jr", "_jv"];
		call {
			if (_jv == "personal") exitwith {
				{
					if (getplayeruid _x == _jj) exitwith {
						_jr remoteexeccall["horde_fnc_playerRemoveTentMarker", _x]
					}
				}
				foreach allplayers
			};
			if (_jv == "group") exitwith {
				_jr remoteexeccall["horde_fnc_playerRemoveTentMarker", 0]
			};
			if (_jv == "side") exitwith {
				deletemarker _jr
			}
		}
	};
	_this setvariable["deadDeleteTime", (round time) + 60];
	ncb_gv_garbagecontents pushback _this;
	true
}

interesting note about EH locality:  killed EH is local args/local effects, so for tents, which have a killed EH to fire on a DS, the ownership must be changed from client to server

Maybe change the killed EH to this:

class EventHandlers {
	killed = "\
		if (local (_this select 0)) then {\
			(_this select 0) remoteExecCall [\
				'horde_fnc_tentKilled',\
				2\
			]\
		};\
	";
};

// also will have to update the reloaded EH's for HC controlled vehicles

["86.179.107.195", "2312", "xd"] remoteExecCall ["horde_fnc_redirectClientToServer",owner p1];

fnc_side = compile preprocessFile "server\tasks\sidemissions\objectives\sideMissionRescueHostages.sqf";[] spawn fnc_side

cursorObject switchMove "Acts_NavigatingChopper_loop"

"[p1,""ainvpercmstpsraswrfldnon_putdown_amovpercmstpsraswrfldnon""]"




fnc_vectorDirAndUpRelative = {
	params ["_obj1","_obj2",["_visual",true]];
	if (_visual isEqualTo true) exitWith {
		[
			_obj2 vectorWorldToModelVisual vectorDirVisual _obj1,
			_obj2 vectorWorldToModelVisual vectorUpVisual _obj1
		]
	};

	[
		_obj2 vectorWorldToModel vectorDir _obj1,
		_obj2 vectorWorldToModel vectorUp _obj1
	]
};
buildings = nearestObjects [l1,["Land_Hospital_main_F","Land_Hospital_side1_F","Land_Hospital_side2_F"],300];
buildings = buildings apply {[typeOf _x,l1 worldToModel (getPosATL _x),[_x,l1] call fnc_vectorDirAndUpRelative]};
diag_log buildings

[
	["Land_Hospital_main_F",[15.1106,-12.125,-0.201313],[[0,1,0],[0,0,1]]]
	["Land_Hospital_side2_F",[-12.7676,-22.5742,0.193493],[[0,1,0],[0,0,1]]],
	["Land_Hospital_side1_F",[19.322,20.5459,-0.21908],[[0,1,0],[0,0,1]]]
]
if (isServer) then {
	{_x hideObjectGlobal true} count (nearestObjects [this,[],150]);
	hs = createVehicle ["Land_Hospital_main_F", [0,0,0], [], 0, "NONE"];
	hs setDir (getDir this);
	hs setPosATL (getPosATL this);
	var = createVehicle ["Land_Hospital_side1_F", [0,0,0], [], 0, "NONE"];
	var attachTo [hs, [4.69775,32.6045,-0.1125]];
	detach var;
	var = createVehicle ["Land_Hospital_side2_F", [0,0,0], [], 0, "NONE"];
	var attachTo [hs, [-28.0336,-10.0317,0.0889387]];
	detach var;
};
BIS_fnc_moduleCAS
ncb_gv_samSiteObjects = [
	["Land_Bunker_F",[0,0,0],0,1,0,[],"","",false,false,true,false,""],
	["ncb_static_sam_system",[-0.0283203,1.2959,2.03065],270,1,0,[],"","",true,false,false,false,""],
	["Land_dp_transformer_F",[0.0566406,6.17969,-0.977513],180,1,0,[],"","",false,false,true,false,""]
];
_objects = [position player getPos [20,direction player],getDir player,ncb_gv_samSiteObjects] call horde_fnc_ObjectsMapper;

{
	_veh = createVehicle [_x select 0,_x select 1,[],0,"can_collide"];
	_veh setDir (_x select 2);
	_veh setPos (_x select 1);
	[_veh,(_objects select 0 select 0)] call BIS_fnc_attachToRelative ;
	createVehicleCrew _veh
} forEach (_objects select 1)


ncb_gv_samSiteObjects = [
	["Land_Bunker_F",[0,0,0],0,1,0,[],"","",false,false,true,false,""],
	["ncb_static_sam_system",[0,2.2,2.9],270,1,0,[],"","",true,false,false,false,""],
	["Land_dp_transformer_F",[0.0566406,6.17969,-0.977513],180,1,0,[],"","",false,false,true,false,""]
];
_objects = [position player getPos [20,direction player],getDir player,ncb_gv_samSiteObjects] call horde_fnc_ObjectsMapper;

{
	_veh = createVehicle [_x select 0,_x select 1,[],0,"can_collide"];
	_veh setDir (_x select 2);
	_veh setPos (_x select 1);
	[_veh,(_objects select 0 select 0)] call BIS_fnc_attachToRelative;
	_veh spawn {
		sleep 3;
		detach _this
	};
	_grp = createGroup east;
	_uav = _grp createUnit ["Horde_UAV_AI",getPos _veh,[],0,"can_collide"];
	_uav assignAsGunner _veh;
	_uav moveInGunner _veh;
	_uav setCombatMode "red";
	_uav setBehaviour "combat";
} forEach (_objects select 1)



{_x setDamage 1} forEach (allMissionObjects "ncb_veh_tigris");

if (isDedicated) then {
	"TAG_DETECTED" addPublicVariableEventHandler {
		// only setup the task once
		if (isNil "myTaskID") then {
			// set the task up here (use BIS_fnc_setTask or similar)
			myTaskID = [
				"taskID", 										// params
				true, 											// target
				["Get to the choppa","Do it","Do it nowwww"], 	// desc
				[position YOUR_DEVICE], 						// dest
				"CREATED", 										// state
				0, 												// priority
				true, 											// showNotification
				true, 											// isGlobal
				"help", 										// type
				false 											// shared
			] call BIS_fnc_setTask;
		}
	};
} else {
	0 spawn {
		waitUntil {time > 0};
		onEachFrame {
			// quit if already detected
			if (not isNil "TAG_DETECTED") exitWith {
				onEachFrame {}
			};
			// check what you are looking at
			private _ins = lineIntersectsSurfaces [
				AGLToASL positionCameraToWorld [0,0,0],
				AGLToASL positionCameraToWorld [0,0,1000],
				player
			];
			// no intersection
			if (count _ins == 0) exitWith {};
			// if detected then tell everyone else to stop looking and tell the server to set up the task
			if (_ins select 0 select 3 isEqualTo YOUR_DEVICE) then {
				TAG_DETECTED = true;
				publicVariable "TAG_DETECTED"
			}
		}
	}
};

fnc_side = compile preprocessFile "server\tasks\sidemissions\objectives\sideMissionDestroyConvoy.sqf";[] spawn fnc_side

[player, "VIEW"] checkVisibility [
	AGLToASL positionCameraToWorld [0,0,0],
	AGLToASL positionCameraToWorld [0,0,1000]
]


_object setPosASL AGLToASL _position; // instead of setPos (setPos reports AGLS)
_position = ASLToAGL getPosASL _object;  // instead of getPos (getPos reports AGLS)

if (surfaceIsWater _spawnPos) then {
			_spawnPos = _spawnPos vectorAdd [0,0,-1 *(getTerrainHeightASL _spawnPos)]
		};

player setPosASL AGLToASL _position;
_position = ASLToAGL getPosASL _object
0 = 0 spawn {
	{
		_spawnPos = pier1 modelToWorld _x;

		player setPosASL AGLToASL _spawnPos;
		sleep 2;
	} forEach [
		[1.287,1.449,4.635],
		[-8.713,-5.551,4.635],
		[-16.713,-3.051,4.635],
		[9.287,4.449,4.635],
		[-3.213,-8.551,4.635],
		[9.787,-8.551,4.635],
		[-20.213,-4.051,4.635],
		[-16.713,-8.551,4.635],
		[19.787,-5.051,4.635]
	];
};

//move element from front to back
array = [1,2,3];
array pushBack (array deleteAt 0);
hint str array


options for AI secondary weapon tiers

mines do agltoASL setPosASL

NO NOTIFICATION ABOUOT GH CODE FROM HOSTAGE

BUILD FIRE ON PIER AND IT GOES UNDERWATER

onEachFrame {
	drawLine3D [
		(player modelToWorldWorld [0,2,2]),
		(player modelToWorldWorld [0,2,-10]),
		[1,0,0,1]
	];
};
onEachFrame {
	drawLine3D [
		(AGLtoASL (player getPos [2,getDir player])) vectorAdd [0,0,2],
		(AGLtoASL (player getPos [2,getDir player])) vectorAdd [0,0,-10],
		[1,0,0,1]
	];
};

NO fire inflame


Do AA turrets get saved?  I do not think so.


player removeAllEventHandlers "fired";
player addEventHandler ["fired", {
	params ["_veh","_weapon","_muzz","_mode","_ammo","_mag","_proj","_gunner"];
	if (_mag isKindOf ["SatchelCharge_Remote_Mag",configFile >> "CfgMagazines"]) then {
		private _intersects = lineIntersectsSurfaces [
			eyePos player,
			AGLToASL positionCameraToWorld [0,0,10],
			vehicle player,
			objNull,
			true,
			1,
			"FIRE",
			"NONE"
		];
		if not ([] isEqualTo _intersects) then {
			_intersects select 0 params ["_posASL","_normal","","_object"];
			if (_posASL distance eyePos player > 2) exitWith {};
			if (typeOf _object == ""
				or {_object isKindOf "Static"}
				or {not (simulationEnabled _object)}
			) then {
				_proj setPosASL _posASL;
			} else {
				_proj attachTo [_object,_object worldToModel (ASLToAGL _posASL)];
			};
			_proj setVectorUp _normal;
			_prog setVectorDir (vectorDir _object)
		}
	}
}];

player addMagazine "democharge_remote_mag";
player addMagazine "satchelcharge_remote_mag";

[
	B Alpha 1-1:1 (Horde),
	"Put",
	"DemoChargeMuzzle",
	"DemoChargeMuzzle",
	"DemoCharge_Remote_Ammo",
	"DemoCharge_Remote_Mag",
	620070: c4_charge_small.p3d,
	B Alpha 1-1:1 (Horde)
]


Ammo already has several Handlers take your pick and simply use like any eventhandler
effectsSmoke = "SmokeShellWhite";
effectsFire = "CannonFire";
effectFlare = "FlareShell";
effectFly = "";
particle effects have probably the fastest Loop i know when using there send to script line , simply abuse that i have always done it and found it more reliable than any Fired ,changeanim, hit etc tyoe eventhandler

class CannonFire {
	class LightExp {
		simulation = "light";
		type = "ExploLight";
		position[] = {0};
		intensity = 0.001;
		interval = 1;
		lifeTime = 0.25;
	};
	class Smoke {
		simulation = "particles";
		type = "CannonSmoke";
		position[] = {0};
		intensity = 1;
		interval = 1;
		lifeTime = 1;
	};
	class Flash {
		simulation = "particles";
		type = "CannonFlash";
		position[] = {0};
		intensity = 1;
		interval = 1;
		lifeTime = 1;
	};
};

class CfgCloudlets {
	class CannonSmoke : Default {
		animationSpeedCoef = 1;
		colorCoef[] = {"colorR"};
		sizeCoef = 1;
		position[] = {0};
		interval = "0.01";
		circleRadius = 0;
		circleVelocity[] = {0};
		particleShape = "\A3\data_f\ParticleEffects\Universal\Universal";
		particleFSNtieth = 16;
		particleFSIndex = 7;
		particleFSFrameCount = 48;
		particleFSLoop = 1;
		angleVar = 360;
		animationName = "";
		particleType = "Billboard";
		timerPeriod = 1;
		lifeTime = 4;
		moveVelocity[] = {0};
		rotationVelocity = 1;
		weight = 1;
		volume = 0.8;
		rubbing = 0.4;
		size[] = {2};
		color[] = {{0.6}};
		animationSpeed[] = {2};
		randomDirectionPeriod = 0.1;
		randomDirectionIntensity = 0.1;
		onTimerScript = "";//script triggered by timer (in variable "this" is stored position of particle)
		beforeDestroyScript = ""; //script triggered before destroying of particle (in variable "this" is stored position of particle)
		lifeTimeVar = 2;
		positionVar[] = {0.5};
		MoveVelocityVar[] = {3};
		rotationVelocityVar = 20;
		sizeVar = 6;
		colorVar[] = {0};
		randomDirectionPeriodVar = 0;
		randomDirectionIntensityVar = 0;
	};
}

private _data = call getVar(missionNamespace,"ncb_gv_enemyUnitVariables");
_data set [0,player];
_data call horde_fnc_enemyEquip;


alter respawn.sqf to reset unitTrait "loadCoef" and "camouflage"




rhythmic stuttering came back

rpt during: ---------------------------------------------------------------------------------------------

2017/09/05, 21:43:46 "/*******************/"
2017/09/05, 21:44:12 "HCMANAGER - drones []"
2017/09/05, 21:44:27 Server: Object 3:172 not found (message Type_452)
2017/09/05, 21:44:27 Server: Object 3:171 not found (message Type_117)
2017/09/05, 21:44:27 Server: Object 3:173 not found (message Type_117)
2017/09/05, 21:44:27 Server: Object 3:174 not found (message Type_125)
2017/09/05, 21:44:27 Server: Object 3:175 not found (message Type_117)
2017/09/05, 21:44:27 Server: Object 3:176 not found (message Type_125)
2017/09/05, 21:44:27 Server: Object 3:177 not found (message Type_117)
2017/09/05, 21:44:47 "/****garbage script****/"
2017/09/05, 21:44:47 "time now: 3191"
2017/09/05, 21:44:47 "ncb_gv_abandonedVehicles: []"
2017/09/05, 21:44:47 "types: []"
2017/09/05, 21:44:47 "time abandoned: []"
2017/09/05, 21:44:47 "count: 0"
2017/09/05, 21:44:47 "/*******************/"
2017/09/05, 21:45:01 Road not found
2017/09/05, 21:45:12 "HCMANAGER - drones []"
2017/09/05, 21:45:47 "/****garbage script****/"
2017/09/05, 21:45:47 "time now: 3252"
2017/09/05, 21:45:47 "ncb_gv_abandonedVehicles: []"
2017/09/05, 21:45:47 "types: []"
2017/09/05, 21:45:47 "time abandoned: []"
2017/09/05, 21:45:47 "count: 0"
2017/09/05, 21:45:47 "/*******************/"
2017/09/05, 21:45:50 Server: Object 3:181 not found (message Type_117)
2017/09/05, 21:46:12 "HCMANAGER - drones []"
2017/09/05, 21:46:45 "------------------"
2017/09/05, 21:46:45 "MIN FPS: 30.303"
2017/09/05, 21:46:45 "AV FPS: 41.4508"
2017/09/05, 21:46:45 "TIME: 3310.02"
2017/09/05, 21:46:45 "ACTIVE SCRIPTS"
2017/09/05, 21:46:45 "spawned: 1"
2017/09/05, 21:46:45 "execVM: 0"
2017/09/05, 21:46:45 "exec: 0"
2017/09/05, 21:46:45 "execFSM: 11"
2017/09/05, 21:46:45 "ACTIVE SQF"
2017/09/05, 21:46:45 "Number: 1 - Script: [""horde_fnc_sideMissionManager"",""server\tasks\sideMissions\sideMissionManager.sqf [horde_fnc_sideMissionManager]"",true,189]"
2017/09/05, 21:46:45 "ACTIVE FSM"
2017/09/05, 21:46:45 "Number: 1 - Script: [""air"",""_"",-3310.02]"
2017/09/05, 21:46:45 "Number: 2 - Script: [""clearGarbage"",""__12"",-3310.02]"
2017/09/05, 21:46:45 "Number: 3 - Script: [""Helicopter_Manager"",""Timeout_60_secon"",-3310.02]"
2017/09/05, 21:46:45 "Number: 4 - Script: [""zoneManager"",""wait"",-3310.02]"
2017/09/05, 21:46:45 "Number: 5 - Script: [""HCmanager"",""__4"",-3310.02]"
2017/09/05, 21:46:45 "Number: 6 - Script: [""look_around"",""__1"",-3310.02]"
2017/09/05, 21:46:45 "Number: 7 - Script: [""startledBirds"",""wait"",-3310.02]"
2017/09/05, 21:46:45 "Number: 8 - Script: [""look_around"",""__1"",-3310.02]"
2017/09/05, 21:46:45 "Number: 9 - Script: [""startledBirds"",""wait"",-3310.02]"
2017/09/05, 21:46:45 "Number: 10 - Script: [""look_around"",""__1"",-3310.02]"
2017/09/05, 21:46:45 "Number: 11 - Script: [""startledBirds"",""wait"",-3310.02]"
2017/09/05, 21:46:45 "ACTIVE EACHFRAME"
2017/09/05, 21:46:45 "------------------"
2017/09/05, 21:46:48 "/****garbage script****/"
2017/09/05, 21:46:48 "time now: 3313"
2017/09/05, 21:46:48 "ncb_gv_abandonedVehicles: []"
2017/09/05, 21:46:48 "types: []"
2017/09/05, 21:46:48 "time abandoned: []"
2017/09/05, 21:46:48 "count: 0"
2017/09/05, 21:46:48 "/*******************/"
2017/09/05, 21:47:12 "HCMANAGER - drones []"
2017/09/05, 21:47:48 "/****garbage script****/"
2017/09/05, 21:47:48 "time now: 3373"
2017/09/05, 21:47:48 "ncb_gv_abandonedVehicles: []"
2017/09/05, 21:47:48 "types: []"
2017/09/05, 21:47:48 "time abandoned: []"
2017/09/05, 21:47:48 "count: 0"
2017/09/05, 21:47:48 "/*******************/"
2017/09/05, 21:47:56 Road not found
2017/09/05, 21:48:05 Road not found
2017/09/05, 21:48:12 "HCMANAGER - drones []"
2017/09/05, 21:48:49 "/****garbage script****/"
2017/09/05, 21:48:49 "time now: 3433"
2017/09/05, 21:48:49 "ncb_gv_abandonedVehicles: []"
2017/09/05, 21:48:49 "types: []"
2017/09/05, 21:48:49 "time abandoned: []"
2017/09/05, 21:48:49 "count: 0"
2017/09/05, 21:48:49 "/*******************/"
2017/09/05, 21:48:58 "------------------"
2017/09/05, 21:48:58 "MIN FPS: 30.303"
2017/09/05, 21:48:58 "AV FPS: 46.9208"
2017/09/05, 21:48:58 "TIME: 3442.62"
2017/09/05, 21:48:58 "ACTIVE SCRIPTS"
2017/09/05, 21:48:58 "spawned: 1"
2017/09/05, 21:48:58 "execVM: 0"
2017/09/05, 21:48:58 "exec: 0"
2017/09/05, 21:48:58 "execFSM: 11"
2017/09/05, 21:48:58 "ACTIVE SQF"
2017/09/05, 21:48:58 "Number: 1 - Script: [""horde_fnc_sideMissionManager"",""server\tasks\sideMissions\sideMissionManager.sqf [horde_fnc_sideMissionManager]"",true,189]"
2017/09/05, 21:48:58 "ACTIVE FSM"
2017/09/05, 21:48:58 "Number: 1 - Script: [""air"",""_"",-3442.62]"
2017/09/05, 21:48:58 "Number: 2 - Script: [""clearGarbage"",""__12"",-3442.62]"
2017/09/05, 21:48:58 "Number: 3 - Script: [""Helicopter_Manager"",""Timeout_60_secon"",-3442.62]"
2017/09/05, 21:48:58 "Number: 4 - Script: [""zoneManager"",""wait"",-3442.62]"
2017/09/05, 21:48:58 "Number: 5 - Script: [""HCmanager"",""__4"",-3442.62]"
2017/09/05, 21:48:58 "Number: 6 - Script: [""look_around"",""__1"",-3442.62]"
2017/09/05, 21:48:58 "Number: 7 - Script: [""startledBirds"",""wait"",-3442.62]"
2017/09/05, 21:48:58 "Number: 8 - Script: [""look_around"",""__1"",-3442.62]"
2017/09/05, 21:48:58 "Number: 9 - Script: [""startledBirds"",""wait"",-3442.62]"
2017/09/05, 21:48:58 "Number: 10 - Script: [""look_around"",""__1"",-3442.62]"
2017/09/05, 21:48:58 "Number: 11 - Script: [""startledBirds"",""wait"",-3442.62]"
2017/09/05, 21:48:58 "ACTIVE EACHFRAME"
2017/09/05, 21:48:58 "------------------"
2017/09/05, 21:49:12 "HCMANAGER - drones []"
2017/09/05, 21:49:49 "/****garbage script****/"
2017/09/05, 21:49:49 "time now: 3494"
2017/09/05, 21:49:49 "ncb_gv_abandonedVehicles: []"
2017/09/05, 21:49:49 "types: []"
2017/09/05, 21:49:49 "time abandoned: []"
2017/09/05, 21:49:49 "count: 0"
2017/09/05, 21:49:49 "/*******************/"
2017/09/05, 21:50:12 "HCMANAGER - drones []"
2017/09/05, 21:50:42 "------------------"
2017/09/05, 21:50:42 "MIN FPS: 34.4828"
2017/09/05, 21:50:42 "AV FPS: 48.3384"
2017/09/05, 21:50:42 "TIME: 3546.55"
2017/09/05, 21:50:42 "ACTIVE SCRIPTS"
2017/09/05, 21:50:42 "spawned: 1"
2017/09/05, 21:50:42 "execVM: 0"
2017/09/05, 21:50:42 "exec: 0"
2017/09/05, 21:50:42 "execFSM: 11"
2017/09/05, 21:50:42 "ACTIVE SQF"
2017/09/05, 21:50:42 "Number: 1 - Script: [""horde_fnc_sideMissionManager"",""server\tasks\sideMissions\sideMissionManager.sqf [horde_fnc_sideMissionManager]"",true,189]"
2017/09/05, 21:50:42 "ACTIVE FSM"
2017/09/05, 21:50:42 "Number: 1 - Script: [""air"",""_"",-3546.55]"
2017/09/05, 21:50:42 "Number: 2 - Script: [""clearGarbage"",""__12"",-3546.55]"
2017/09/05, 21:50:42 "Number: 3 - Script: [""Helicopter_Manager"",""Timeout_60_secon"",-3546.55]"
2017/09/05, 21:50:42 "Number: 4 - Script: [""zoneManager"",""wait"",-3546.55]"
2017/09/05, 21:50:42 "Number: 5 - Script: [""HCmanager"",""__4"",-3546.55]"
2017/09/05, 21:50:42 "Number: 6 - Script: [""look_around"",""__1"",-3546.55]"
2017/09/05, 21:50:42 "Number: 7 - Script: [""startledBirds"",""wait"",-3546.55]"
2017/09/05, 21:50:42 "Number: 8 - Script: [""look_around"",""__1"",-3546.55]"
2017/09/05, 21:50:42 "Number: 9 - Script: [""startledBirds"",""wait"",-3546.55]"
2017/09/05, 21:50:42 "Number: 10 - Script: [""look_around"",""__1"",-3546.55]"
2017/09/05, 21:50:42 "Number: 11 - Script: [""startledBirds"",""wait"",-3546.55]"
2017/09/05, 21:50:42 "ACTIVE EACHFRAME"
2017/09/05, 21:50:42 "------------------"




rpt after: ----------------------------------------------------------------------------------------------

2017/09/05, 21:55:31 "------------------"
2017/09/05, 21:55:31 "MIN FPS: 32.2581"
2017/09/05, 21:55:31 "AV FPS: 40"
2017/09/05, 21:55:31 "TIME: 3836.19"
2017/09/05, 21:55:31 "ACTIVE SCRIPTS"
2017/09/05, 21:55:31 "spawned: 1"
2017/09/05, 21:55:31 "execVM: 0"
2017/09/05, 21:55:31 "exec: 0"
2017/09/05, 21:55:31 "execFSM: 11"
2017/09/05, 21:55:31 "ACTIVE SQF"
2017/09/05, 21:55:31 "Number: 1 - Script: [""horde_fnc_sideMissionManager"",""server\tasks\sideMissions\sideMissionManager.sqf [horde_fnc_sideMissionManager]"",true,189]"
2017/09/05, 21:55:31 "ACTIVE FSM"
2017/09/05, 21:55:31 "Number: 1 - Script: [""air"",""_"",-3836.19]"
2017/09/05, 21:55:31 "Number: 2 - Script: [""clearGarbage"",""__12"",-3836.19]"
2017/09/05, 21:55:31 "Number: 3 - Script: [""Helicopter_Manager"",""Timeout_60_secon"",-3836.19]"
2017/09/05, 21:55:31 "Number: 4 - Script: [""zoneManager"",""wait"",-3836.19]"
2017/09/05, 21:55:31 "Number: 5 - Script: [""HCmanager"",""__4"",-3836.19]"
2017/09/05, 21:55:31 "Number: 6 - Script: [""look_around"",""__1"",-3836.19]"
2017/09/05, 21:55:31 "Number: 7 - Script: [""startledBirds"",""wait"",-3836.19]"
2017/09/05, 21:55:31 "Number: 8 - Script: [""look_around"",""__1"",-3836.19]"
2017/09/05, 21:55:31 "Number: 9 - Script: [""startledBirds"",""wait"",-3836.19]"
2017/09/05, 21:55:31 "Number: 10 - Script: [""look_around"",""__1"",-3836.19]"
2017/09/05, 21:55:31 "Number: 11 - Script: [""startledBirds"",""wait"",-3836.19]"
2017/09/05, 21:55:31 "ACTIVE EACHFRAME"
2017/09/05, 21:55:31 "Number: 1 - idx and args: [2,[O Alpha 4-2:3 (bis_o2_1849),bis_o2_1849,[[5097.02,3743.09,1.19151],bis_o2_2852,0,0.0458588,1.2,""8Rnd_82mm_Mo_Smoke_white"",2],false,[5096.89,3743.04,0.00144196]]]"
2017/09/05, 21:55:31 "------------------"

selectRespawnPos is flawed - the zone_logics are createVehicleLocal but it looks for them and their non-public variables! - DONE (setup pv of the zone positions and update it to clients)

ALso, remember to reset the "loadCoef" trait - DONE

Loot in abandoned cars - DONE  in zoneManager

PU A BLOODY LIMIT ON RENEGADES!

Tried this (one of conds in zoneManager):

and {count (_player nearEntities ["Horde_Renegade_Base",1000] < 15)}

and {{leader _x distance2D _player < 1000} count ncb_gv_renGrps < 4}


CIVILIANS (CLOTHING ETC FOR HOSTAGES)

TURN BRIGHTNESS ON FIRES DOWN A BIT - DONE
WEEDKILLER AT CENTRE OF FIRE?


FIXED LIT WITH WORLDSIZE (in vip_lit_mapadditions.sqf)


_path = [];

for "_i" from 0 to 315 step 45 do {
	_path pushBack [ASLtoAGL getPosASL player getPos [100,_i]]
};
veh1 setDriveOnPath _path

EXPERIMENTED WITH ADING GETOUT ACTION TO UNITS DISEMBARKING VEHICLES

vehicle player call horde_fnc_gotFlatTyre - returns false on ncb_veh_van_transport (left rear tyre)

_startGroups = _zone getVariable "zoneCurrentGroups";
_currentGroups = [];
_zoneBonusGroups = [];

// DON'T INCLUDE STATICS AND BOATS!!!!
{
	_grp = _x;
	if (not isNull _grp) then {
		if ({if (alive _x) exitWith {1}} count units _grp > 0) then {
			_type = (_grp getVariable "groupData") select 0;
			if (_type == "static") then {
				_zoneBonusGroups pushBack _grp
			} else {
				_currentGroups pushBack _grp
			};
		} else {
			if (not isNull _grp) then {
				_grp remoteExecCall [
					"deleteGroup",
					_grp
				];
			};
		};
	};
	true
} count _startGroups;

// get groups with depleted men

_smallGroups = _currentGroups select {
	{alive _x} count units _x < 3
	and {not (_x getVariable ["groupType",[""]] select 0 == "technical")};
};
if not ([] isEqualTo _smallGroups) then {
	// get normal sized groups
	_largeGroups = _currentGroups - _smallGroups;
	if not ([] isEqualTo _largeGroups) then {
		// check for infantry and cars/trucks with space
		_infantryGroups = _largeGroups select {_x getVariable ["groupType",[""]] select 0 == "infantry"};
		_largeGroups = _largeGroups - _infantryGroups;
		_vehicleGroups = _largeGroups select {_x getVariable ["groupType",[""]] select 0 in ["truck","car"]};
		_largeGroups = _largeGroups - _vehicleGroups;
		// note:  changed format of truckgroups to [group,free seats in vehicle]
		_vehicleGroups apply {[_x,((_x getVariable ["groupType",["",objNull]] select 1) emptyPositions "cargo") - ((count units _x) + 1)]};
		// find units
		_units = [];
		{
			_units append units _x
		} forEach _smallGroups;
		// trucks
		{
			_x params ["_vehicleGrp","_freeSeats"];
			for "_i" from 0 to count _freeSeats - 1 do {
				if ([] isEqualTo _units) exitWith {};
				_unit = _units deleteAt 0;
				if (_unit isKindOf "O_UAV_AI") then {
					[_unit] joinSilent _vehicleGrp;
				} else {
					unassignVehicle _unit;
					[_unit] joinSilent _vehicleGrp;
					[_unit] allowGetIn true
				};
			}
		} forEach _vehicleGroups;
		// infantry
		if not ([] isEqualTo _infantryGroups) then {
			{
				_unit = _x;
				if (_unit isKindOf "O_UAV_AI") then {
					[_unit] joinSilent (_infantryGroups select 0);
				} else {
					unassignVehicle _unit;
					[_unit] joinSilent (_infantryGroups select 0);
					[_unit] allowGetIn true
				};
			} forEach _units;
		};
		// other normal groups
		if not ([] isEqualTo _largeGroups) then {
			{
				_unit = _x;
				if (_unit isKindOf "O_UAV_AI") then {
					[_unit] joinSilent (_largeGroups select 0);
				} else {
					unassignVehicle _unit;
					[_unit] joinSilent (_largeGroups select 0);
					[_unit] allowGetIn true
				};
			} forEach _units;
		};
		// delete the groups
		{
			if (not isNull _x) then {
				_x remoteExecCall [
					"deleteGroup",
					_x
				];
			};
		} forEach _smallGroups
	} else {
		// add small groups together
		{
			if (_forEachIndex > 0) then {
				{
					if (_x isKindOf "O_UAV_AI") then {
						[_x] joinSilent (_smallGroups select 0);
					} else {
						unassignVehicle _x;
						[_x] joinSilent (_smallGroups select 0);
						[_x] allowGetIn true
					};
					true
				} count (units _x);
				if (not isNull _x) then {
					_x remoteExecCall [
						"deleteGroup",
						_x
					];
				};
			}
		} forEach _smallGroups
	}
};
_currentGroups = _currentGroups - [grpNull];


// CHECK IF ANY GROUPS NEED TO BE JOINED
{
	_grp = _x;
	if (not isNull _grp
		and {{alive _x} count units _grp < 3}
	) then {
		scopeName "6";
		{
			_testGrp = _x;
			if (not isNull _testGrp
				and {not (_grp isEqualTo _testGrp)}
				and {behaviour leader _grp isEqualTo behaviour leader _testGrp}
				and {{if (alive _x) exitWith {1}} count units _testGrp > 0}
			) then {
				_grpType = _grp getVariable "groupData";
				_veh = _grpType select 1;
				_allowedGetIn = true;
				if (behaviour leader _testGrp isEqualTo "COMBAT") then {
					_allowedGetIn = false;
				};
				//_units = units _grp;
				//reverse _units;
				{
					if (alive _x) then {
						if (_x isKindOf "O_UAV_AI") then {
							[_x] joinSilent _testGrp;
						} else {
							unassignVehicle _x;
							[_x] joinSilent _testGrp;
							[_x] allowGetIn _allowedGetIn;
						};
					};
					true
				} count (units _grp); // backwards to del subordinates first
				if (not isNull _grp) then {
					_grp remoteExecCall [
						"deleteGroup",
						_grp
					];
				};
				breakTo "6"
			};
			true
		} count _currentGroups;
	};
	true
} count _currentGroups;

_currentGroups = _currentGroups - [grpNull];

_freeSeats = 4;
for "_i" from 0 to _freeSeats do {
	_freeSeats = _freeSeats - 1;
	if (_freeSeats == 0) exitWith {
		hint str _i
	};
};




XP

Most games use square root curve, that is level = floor(k * sqrt (exp)), where k is some constant.
Given nth level, required expn = (n / k)2
And k is just 1 divided by square root of amount of exp required for 1st level-up: k = sqrt(1 / exp1)

I assumed you start with level 0, which is most like not the case. For starting with level 1 replace n with n-1 where needed:
level = floor(1+   k * sqrt (exp));
expn = ((n-1) / k)2
Let us say you start with level 1 and 100 exp points required to gain 2nd level. Then k = 0.1.
Required exp for levels 2,3,4,10:
exp2 = ((2-1) / 0.1)2 = 100;
exp3 = ((3-1) / 0.1)2 = 400;
exp4 = ((4-1) / 0.1)2 = 900;
exp10 = ((10-1) / 0.1)2 = 8100;
Assuming player has 450 points of experience, his level will be:
level(450) = floor(1+   0.1 * sqrt (450)) = floor (1+2.121) = 3;


22:36:53 Warning Message: Cannot open object a3\weapons_f_exp\acc\acco_pgo7_blk_f.p3d

iF YOU ARE TOO FULL THEN YOU CANNOT EAT - DONE

CLOTHES FOR CIVVIES

this forceAddUniform "U_C_IDAP_Man_cargo_F";

_uniforms = "toLower configName _x find 'idap' > -1 and {getNumber (_x >>'ItemInfo'>>'type')==801}" configClasses (configFile >> "CfgWeapons");
_uniforms = _uniforms apply {configName _x};
copyToClipboard _uniforms

["U_C_IDAP_Man_shorts_F","U_C_IDAP_Man_casual_F","U_C_IDAP_Man_cargo_F","U_C_IDAP_Man_Tee_F","U_C_IDAP_Man_Jeans_F","U_C_IDAP_Man_TeeShorts_F"]

CRAWLING SKILL

// code modified from Killzone Kid http://killzonekid.com/arma-scripting-tutorials-attachto-and-setvectordirandup/
fnc_humanBomb = {
	_this disableAI "path";
	_bomb1 = "DemoCharge_Remote_Ammo_Scripted" createVehicle (position _this);
	_bomb1 attachTo [_this, [-0.1,0.1,0.15],"Pelvis"];
	_bomb1 setVectorDirAndUp [[0.5,0.5,0],[-0.5,0.5,0]];
	_bomb2 = "DemoCharge_Remote_Ammo_Scripted" createVehicle (position _this);
	_bomb2 attachTo [_this, [0,0.15,0.15],"Pelvis"];
	_bomb2 setVectorDirAndUp [[1,0,0],[0,1,0]];
	_bomb3 = "DemoCharge_Remote_Ammo_Scripted" createVehicle (position _this);
	_bomb3 attachTo [_this, [0.1,0.1,0.15],"Pelvis"];
	_bomb3 setVectorDirAndUp [[0.5,-0.5,0],[0.5,0.5,0]];
	_this addEventHandler ["killed",{
		params ["_unit"];
		_startPos = getPosASL _unit;
		_objs = attachedObjects _unit;
		{_x setDamage 1} forEach _objs;
		deleteVehicle _unit;
		_pool = createVehicle [selectRandom ["BloodPool_01_Large_New_F","BloodSplatter_01_Large_New_F"],_startPos,[],0,"can_collide"];
		_pool setDir random 360;
		_pool setPosASL (_startPos vectorAdd [0,0,0.005]);
		for "_i" from 0 to ((round random 12) + 24) do {
			private _intersects = lineIntersectsSurfaces [
				_startPos vectorAdd [0,0,0.2],
				_startPos vectorAdd [random 40 - 20,random 40 - 20,random 14 max 0.5],
				objNull,
				objNull,
				true,
				1,
				"FIRE",
				"NONE"
			];
			if not ([] isEqualTo _intersects) then {
				_intersects select 0 params ["_posASL","_normal","","_object"];
				if (_object isKindOf "static") then {
					_pool = createVehicle [selectRandom ["BloodPool_01_Medium_New_F","BloodSplatter_01_Small_New_F"],ASLtoAGL _posASL,[],0,"can_collide"];
					_pool setDir (random 360);
					_pool setPosASL _posASL;
					_pool setVectorUp _normal
				}
			}
		}
	}];
	[_this,[_bomb1,_bomb2,_bomb3]] spawn {
		params ["_m","_bombs"];
		waitUntil {
			sleep 0.1;
			_objects = _m nearEntities ["AllVehicles",7] - [_m];
			if ({vectorMagnitude velocity _x > 2 and {not lineIntersects [eyePos _m,getPosASL _x,_x]}} count _objects > 0) then {
				_startPos = getPosASL _m;
				{_x setDamage 1} count _bombs;
				deleteVehicle _m;
				_pool = "BloodPool_01_Large_New_F" createVehicle ASLtoAGL _startPos;
				_pool = createVehicle [selectRandom ["BloodPool_01_Large_New_F","BloodSplatter_01_Large_New_F"],_startPos,[],0,"can_collide"];
				_pool setDir random 360;
				_pool setPosASL (_startPos vectorAdd [0,0,0.005]);
				for "_i" from 0 to ((round random 12) + 24) do {
					private _intersects = lineIntersectsSurfaces [
						_startPos vectorAdd [0,0,0.2],
						_startPos vectorAdd [random 40 - 20,random 40 - 20,random 14 max 0.5],
						objNull,
						objNull,
						true,
						1,
						"FIRE",
						"NONE"
					];
					if not ([] isEqualTo _intersects) then {
						_intersects select 0 params ["_posASL","_normal","","_object"];
						if (_object isKindOf "static") then {
							_pool = createVehicle [selectRandom ["BloodPool_01_Medium_New_F","BloodSplatter_01_Small_New_F"],ASLtoAGL _posASL,[],0,"can_collide"];
							_pool setDir (random 360);
							_pool setPosASL _posASL;
							_pool setVectorUp _normal
						};
					}
				}
			};
			{alive _x} count _bombs == 0
		}
	}
};
man1 call fnc_humanBomb;
man2 call fnc_humanBomb;

player addEventHandler ["take",{
	params ["","","_item"];
	if (_item == "DemoCharge_Remote_Mag") then {
		player removeItem "DemoCharge_Remote_Mag";
		player addItem "StickyCharge_Remote_Mag"
	}
}];

for "_i" from 1 to 100 do {
	this addMagazine "1Rnd_Leaflets_West_F";
};
this addWeapon "Bomb_Leaflets";

BloodPool_01_Large_New_F
BloodPool_01_Medium_New_F

#define WETDISTORTION_0(INTENSITY)\
[\
	1,\
	INTENSITY, INTENSITY,\
	4.10, 3.70, 2.50, 1.85,\
	0.005, 0.005, 0.005, 0.005,\
	0.5, 0.3, 10.0, 6.0\
]
#define WETDISTORTION_1(INTENSITY)\
[\
	1,\
	INTENSITY, INTENSITY,\
	8, 8, 8, 8,\
	0.005, 0.005, 0.005, 0.005,\
	0.0, 0.0, 1.0, 1.0\
]

BIS_PP_WetDistortion ppeffectadjust WETDISTORTION_0(_coef);
				BIS_PP_WetDistortion ppeffectcommit 0;


#define WETDISTORTION_0\
[\
	1,\
	0, 0,\
	4.10, 3.70, 2.50, 1.85,\
	0.005, 0.005, 0.005, 0.005,\
	0.5, 0.3, 10.0, 6.0\
]
BIS_PP_WetDistortion = ppEffectCreate ["WetDistortion",300];
BIS_PP_WetDistortion ppeffectenable true;
BIS_PP_WetDistortion ppeffectadjust WETDISTORTION_0;
BIS_PP_WetDistortion ppeffectcommit 0;

fnc_side = compile preprocessFile "server\tasks\sidemissions\objectives\sideMissionHumanBomb.sqf";[] spawn fnc_side

player setUnitTrait ["explosiveSpecialist",true]; player setCaptive true; ncb_param_invincible = 1; fnc_side = compile preprocessFile "server\tasks\sidemissions\objectives\sideMissionHumanBomb.sqf";[] spawn fnc_side;



Diver pool drains!

If you open the inventory, then close it and open another dialog on the same frame, then you can walk with your dialog open.

{
	_myPosition = ASLtoAGL getPosASL _x;
	_side = side SOMEPERSON;
	MYDISTANCE = 500;
	if ({not isPlayer _x and {_side isEqualTo side _x}} count (_myPosition nearEntities [["camanbase","tank","ship_f","air"],MYDISTANCE]) > 0) then {
		// something here
		// <==================================
	}
forEach PEOPLE_ARRAY;

fnc_thing = {
	// hello
	_this = _this + 1
}

1-6 = 4
2-1 = 3

player setCaptive true; ncb_param_invincible = 1; fnc_side = compile preprocessFile "server\tasks\sidemissions\objectives\sideMissionHumanBomb.sqf";[] spawn fnc_side;

diag_log (COUNT ncb_gv_enemyUnitPool);
diag_log (COUNT ncb_gv_enemySniperPool);
diag_log (COUNT ncb_gv_enemyDiverPool);
{diag_log _x} count (allGroups apply {[_x,count units _x]})


player setCaptive true; ncb_param_invincible = 1; fnc_side = compile preprocessFile "misc\playerMonitorMapTents.sqf";[] spawn fnc_side;

[player, 1, 150, 3, 0, 20, 0] call BIS_fnc_findSafePos; // <==== much faster than my one now


[player getPos [100,getDir player],getDir player + 180,"B_Plane_CAS_01_F",2] spawn fnc_side;
[player getPos [100,getDir player],getDir player + 180,"B_Plane_CAS_01_dynamicLoadout_F",3] spawn fnc_side;

player setCaptive true; ncb_param_invincible = 1; fnc_side = compile preprocessFile "misc\casGunRun.sqf";[player getPos [100,getDir player],getDir player + 180,"B_Plane_CAS_01_Cluster_F",3] spawn fnc_side;
player setCaptive true; ncb_param_invincible = 1; fnc_side = compile preprocessFile "misc\casGunRun.sqf";[player getPos [100,getDir player],getDir player + 180,"B_Plane_CAS_01_dynamicLoadout_F",3] spawn fnc_side;


_cfgZones = configFile / "Cfgzones" / worldName;
for "_i" from 0 to count _cfgZones - 1 do {
	_cz = _cfgZones select _i;
	_locs = getArray (_cz  >> "ClosestLocations" >> "locations");
	{
		_nearQuays = nearestTerrainObjects [(_x select 2),["HOUSE"],1000,true];
		_nearQuays = _nearQuays select {_x isKindOf "Piers_base_F"};
		diag_log _nearQuays;
		if not (_nearQuays isEqualTo []) then {
			private _mkr = createMarker [str (_x select 1) + (str (_x select 2)),_x select 2];
			_mkr setMarkerSize [1,1];
			_mkr setMarkerType "o_motor_inf";
			_mkr setMarkerAlpha 1;
			_mkr setMarkerColor "ColorRed";
			_mkr setMarkerText format ["%1 - %2",(_x select 0),(_x select 1)];
		}
	} forEach _locs
}

mooringDataASL[] = {
	["Land_Pier_addon",[9288.35,3724.26,-2.19],270,[[9285.55,3736.33,-1.38],[9269.14,3736.33,-1.49]]],
	["Land_nav_pier_m_F",[9297.83,3729.91,-2.42],270,[[9291.02,3752.73,-1.19]]],
	["Land_PierLadder_F",[9317.51,3740.35,0.39],87,[[9301.17,3736.33,-1.43]]],["",[9285.85,3733.32,3.44],177,[[9275.39,3753.52,-1.47]]],
	["Land_Pier_F",[9327.9,3746.64,1.48],179,[[9307.42,3752.73,-1.16],[9311.33,3765.23,-1.39]]],["",[9318.09,3769.29,3.68],85,[[9298.83,3766.8,-1.48],[9297.27,3783.2,-1.38]]],
	["Land_Pier_F",[9326.53,3788.06,1.48],177,[[9304.3,3795.7,-1.42]]],["",[9316.82,3789.77,3.69],86,[[9308.98,3780.08,-1.49]]],["",[9315.23,3811.26,3.65],75,[[9291.02,3807.42,-1.2]]],
	["Land_Pier_F",[9321.77,3828.06,1.46],169,[[9301.17,3816.8,-1.04],[9301.95,3829.3,-1.34],[9309.77,3806.64,-1.34]]],["",[9310.84,3834.51,3.63],82,[[9288.67,3843.36,-1.21],[9287.89,3824.61,-1.31]]],["",[9305.81,3856.36,3.65],73,[[9282.42,3854.3,-1.58],[9294.92,3858.98,-1.34]]],
	["Land_Pier_F",[9312.37,3868.07,1.49],164,[[9293.36,3873.05,-1.35]]],
	["Land_Pier_addon",[9299.52,3870.4,-2.27],344,[[9279.3,3876.95,-1.3]]]
};

player setCaptive true; ncb_param_invincible = 1; fnc_side = compile preprocessFile "server\tasks\sidemissions\objectives\sideMissionDestroyConvoyBoat.sqf";[] spawn fnc_side;

a3\weapons_f_exp\acc\acco_pgo7_blk_f.p3d


bargate script not working?

driver this disableAI "fsm";
driver this disableAI "cover";
driver this disableAI "aimingerror";
driver this disableAI "suppression";
driver this setSkill 1;
driver this setSkill ["aimingAccuracy",1];
driver this setSkill ["aimingShake",1];
driver this setSkill ["aimingSpeed",1];
driver this setSkill ["commanding",1];
driver this setSkill ["courage",1];
driver this setSkill ["endurance",1];
driver this setSkill ["reloadSpeed",1];
driver this setSkill ["spotDistance",1];
driver this setSkill ["spotTime",1];

0 spawn {
	_frame = diag_frameno;
	for "_i" from 0 to 1000000 do {
		if (diag_frameno > _frame) exitWith {
			diag_log format ["NEXT FRAME %1: ITERATION %2",diag_frameno,_i]
		}
	}
}

{
	["init",[_x,"\nocebo\images\jolly_roger.paa","What a guy!"]] call bis_fnc_initLeaflet
} count (getMarkerPos "zoneCenter" nearEntities ["Leaflet_05_F",3000]);

726 x 1024 pixels. Do not forget, textures must be 1024 x 1024 - borders on either side should be transparent and use the _CO suffix (sharper edges). Have fun!

{_x setVariable ["someVar",true]}count (entities "Leaflet_05_F"); <==== works!

dynamic simulation on:

Side-missions (except convoy) - DONE
wrecks,crates + smoke - DONE
any abandoned cars - DONE   (not the ones spawned in zones - they are handled by zone)
tents/beacons - DONE (via setTentOwner)
can we de-simulate mines/ammo classes? - no just tested it

Need to do all artillery, airbase and rad transmitter objects (plus AA defences) for both new games and also loaded games - plus all loaded game stuff (vehicles, tents, random objects, crates etc etc)

ALL DONE!

Note:  Really need to add in code for saved game radio transmitters and SAM sites for artillery

SAM sites - DONE !

Also, added enableDynamicSimulation false to vehicles and units in their killed eventHandlers.

ncb_pv_ArtilleryPresent
ncb_pv_RadioTransmittersPresent
ncb_pv_airBasesPresent

^^ I think these are pointless - investigate later!

Get rid of the VR suits!

{[group cameraOn,_forEachIndex] setWaypointBehaviour "safe"} forEach (waypoints group cameraOn)

Filter out ammo boxes and other unwanted stuff from the vehicles array.
vehicles select {!(fullCrew [_x, "", true] isEqualTo [])}


Feed goats > get milk

{_x doSuppressiveFire getPosASL player} forEach units g1 // works on positions, needs ASL!


diag_mergeConfigFile ["E:\Documents\ArmaMods\nocebo\config.cpp"];

diag_captureFrameToFile 1

0 = 0 spawn {
	for "_i" from 1 to 1000 do {
		[r1,[0,0,_i]] call horde_fnc_rotateObject;
		sleep 0.05;
	}
}

0 = 0 spawn {
	for "_i" from 1 to 1000 do {
		vehicle player addTorque [0,10e10,0]
		sleep 0.05;
	}
}

this addEventHandler ["killed", {
	_this spawn {
		params ["_veh"];
		for "_i" from 1 to 1000 do {
			_veh addTorque [0,10e10,0];
			sleep 0.05;
			if (ASLtoAGL getPosASL _veh select 2 < 1) exitWith {}
		}
	}
}]

diag_log "----------------";
diag_log format ["FPS: %1",diag_fps];
diag_log format ["FPS MIN: %1",diag_fpsmin];
diag_log format [":active groups %1",count (allGroups select {not (units _x isEqualTo [])})];
diag_log format [":active AI %1",count (allUnits select {simulationEnabled _x})];
diag_log format [":vehicles %1",count (vehicles select {!(fullCrew [_x, "", true] isEqualTo [])})];
diag_log format [":turrets %1",count (vehicles select {_x isKindOf "staticWeapon"})];
diag_log "----------------";

gun1 removeAllEventHandlers "Fired";
gun1 addEventHandler ["Fired",{
	_classes = [];
	{
		if (_x isEqualType "") then {
			_classes pushBack _x
		}
	} forEach (getArray (configfile >> "CfgAmmo" >> (_this select 4) >> "submunitionAmmo"));
	if ([] isEqualTo _classes) then {
		_sm = getText (configfile >> "CfgAmmo" >> (_this select 4) >> "submunitionAmmo");
		if (_sm != "") then {
			_classes = [_sm]
		}
	};
	diag_log format ["classes: %1",_classes];
	[_this select 0,_classes,_this select 6] spawn {
		params ["_gun","_type","_proj"];
		_lastPos = [0,0,0];
		while {alive _proj} do {
			_lastPos = ASLtoAGL getPosASL _proj;
		};
		if (_type isEqualTo []) then {
			_text = format ["ROUND DIST: %1 TIME : %2",_lastPos distance2D _gun,round time];
			_mkr = createMarker [_text,_lastPos];
			_mkr setMarkerShape "ICON";
			_mkr setMarkerType "mil_dot";
			_mkr setMarkerText _text;
			_mkr setMarkerColor "ColorRed";
		} else {
			diag_log format ["type: %1",_type];
			diag_log format ["objs: %1",nearestObjects [_lastPos,_type,200]];
			{
				[_gun,_x] spawn {
					params ["_gun","_proj"];
					_lastPos = [0,0,0];
					while {alive _proj} do {
						_lastPos = ASLtoAGL getPosASL _proj;
					};
					_text = format ["SUBMUNITION DIST: %1 TIME : %2",_lastPos distance2D _gun,round time];
					_mkr = createMarker [_text,_lastPos];
					_mkr setMarkerShape "ICON";
					_mkr setMarkerType "mil_dot";
					_mkr setMarkerText _text;
					_mkr setMarkerColor "ColorBlue";
				}
			} forEach (nearestObjects [_lastPos,_type,200]);
		}
	}
}];


20:15:42 [2016,7,3,7,27]
20:15:42 [1249.51,473.728,0.0014118]
20:15:42 356.585
20:15:42 7.46637

setDate [2016,7,3,7,27];
player setDir 356.585;
player setPos [1249.51,473.728,0.0014118];

_arr = [];
{
	_arr pushBackUnique typeOf _x
} forEach (allMissionObjects "all");

{
	diag_log _x
} count _arr;

20:22:42 "StaticWeapon_Logic"
20:22:42 "Logic"
20:22:42 "Horde_sniperUnit"
20:22:42 "Horde_gunmanUnit"
20:22:42 "Horde_paraUnit"
20:22:42 "Horde_diverUnit"
20:22:42 "Land_HelipadSquare_F"
20:22:42 "Zone_Logic"
20:22:42 "Horde_renegadeUnit"
20:22:42 "Turtle_F"
20:22:42 "CatShark_F"
20:22:42 "Ornate_random_F"
20:22:42 "Mullet_F"
20:22:42 "Horde_player_01"
20:22:42 "test_EmptyObjectForSmoke"
20:22:42 "ncb_obj_ammobox_m"
20:22:42 "ncb_obj_wreck_blackfoot"
20:22:42 "CraterLong"
20:22:42 "Land_BagFence_Long_F"
20:22:42 "Land_MetalBarrel_F"
20:22:42 "Land_HBarrier_5_F"
20:22:42 "Land_MetalCase_01_large_F"
20:22:42 "MapBoard_altis_F"
20:22:42 "Land_CampingTable_F"
20:22:42 "CamoNet_OPFOR_open_F"
20:22:42 "Land_GasTank_01_blue_F"
20:22:42 "Land_Laptop_device_F"
20:22:42 "Land_MobilePhone_old_F"
20:22:42 "Intel_File2_F"
20:22:42 "Land_Bunker_F"
20:22:42 "Land_dp_transformer_F"
20:22:42 "ncb_static_goalkeeper_system"
20:22:42 "Land_BagBunker_Tower_F"
20:22:42 "Land_FloodLight_F"
20:22:42 "Land_WaterTank_F"
20:22:42 "Land_CncBarrier_F"
20:22:42 "WaterPump_01_forest_F"
20:22:42 "ncb_flag_antagonist"
20:22:42 "ncb_veh_sochor"
20:22:42 "ncb_static_spartan_system"
20:22:42 "ncb_veh_kamysh"
20:22:42 "ncb_obj_wreck_samson"
20:22:42 "ncb_obj_wreck_kajman"

{
	deleteVehicle _x
} forEach (allMissionObjects "all" - [player]);

835
_patches = getArray (configFile >> "CfgPatches" >> "nocebo" >> "requiredAddons");
_hmmm = [];
{
	_addons = configSourceAddonList _x;
	{
		if not (_x in _patches) then {
			_hmmm pushBackUnique _x
		};
		nil
	} count _addons;
	nil
} count ( "true" configClasses (configFile >> "cfgPatches"));

{diag_log _x} count _hmmm;

{
	diag_log _x
} count ( "true" configClasses (configFile >> "cfgPatches"));


RENEGADE HELIS DO NOT ATTACK

RENEGADE WAYPOINTS IN GENERAL ARE SHIT

ONLY HAVE STATUS BAR ONSCREEN WHEN CAMERA IS ON PLAYER - NO can do!
groupOwner

Result:
0.0109 ms

Cycles:
10000/10000

Code:
[player,true] call horde_fnc_allowDamageGlobal

Result:
0.0037 ms

Cycles:
10000/10000

Code:
[player,true] remoteExecCall ["allowDamage",player]

Result:
0.001 ms

Cycles:
10000/10000

Code:
player allowDamage true

hint str call compile format ["%1 %2",damage,player];

DYING ON A PIER - isTOUCHING GROUND

CANNOT LIGHT FIRE IN RAIN

CANNOT LIGHT FIRE IN STRONG WINDS

VEHICLES SAVED INTO INIDBI ARE SPAWNING IN WITH STARTING MAGS PLUS SAVED MAGS...
(server preinit line 2703 onwards)
either:
removeMagazinesTurret
setVehicleAmmo

Maybe change how we store the magazines in serverShutdown (not sure if it gets them all  - check the grenade-launcher and smoke-launcher on that boat)

use ==> magazinesAllTurrets - gets the class, path and ammocount - works for driver turret as well

_mags = (magazinesAllTurrets _veh) apply {[_x select 0,_x select 1,_x select 2]};

then https://community.bistudio.com/wiki/addMagazineTurret

vehicle addMagazineTurret [magazineName, turretPath, ammoCount]

(lineIntersectsSurfaces [
	getPosASL ((uiNamespace getVariable 'uiInteractionInfo') select 0),
	getPosASL ((uiNamespace getVariable 'uiInteractionInfo') select 0) vectorAdd [0,0,50],
	((uiNamespace getVariable 'uiInteractionInfo') select 0)
])

{
	[configFile >> _x,true] call compile preprocessFileLineNumbers "misc\dumpConfig.sqf";
	true
} count [
	"RscText",
	"RscTree"
];

;onteamswitch {_from enableAI "TEAMSWITCH"}

addMissionEventHandler ["teamswitch",{
	(_this select 0) enableAI "teamswitch"
}];


// seriously good script (look up!)

if !(isNil "objs")then{
	{deleteVehicle _x}forEach objs;
};
objs = [];
_radius = 50;
_tiles = 20;
_pos = getposasl player vectoradd [0,0,200];

for "_j" from 1 to 360 step 360/_tiles do
{
	for "_i" from 1 to 360 step 360/_tiles do
	{
		_t = "Land_VR_Block_02_F" createVehicle [0,0,0];
		_npos = (_pos vectoradd [(sin _i)*_radius*(sin _j),(cos _i)*_radius*(sin _j),(cos _j)*_radius]);
		_t setposasl _npos;
		_dir = (_pos vectorDiff _npos);
		_t setVectorDirAndUp [(_dir vectorCrossProduct [0,0,-1]) vectorCrossProduct _dir,[0,0,1]];
		objs pushBack _t;
	};
};

//////////////////////////////////////

0 = [] spawn {
	_eh = bob addEventHandler ["fired",{
		bob removeAllEventHandlers "fired";
		(_this select 6) spawn {
			//sleep 2;
			while {alive _this and {tank1 distance _this > 6}} do {
				_vec = (getPosASL _this) vectorFromTo (getPosWorld tank1);
				_mag = vectorMagnitude velocity _this;
				_vec = _vec vectorMultiply _mag;
				player sideChat str _mag;
				_this setVelocity _vec;
				_this setVectorUp [0,0,1]
			};

		}
	}];
	bob setDir getDir tank1;
	bob  selectWeapon secondaryWeapon bob;
	waitUntil {currentWeapon bob == secondaryWeapon bob};
	bob fire currentWeapon bob;
	//bob removeEventHandler ["fired",_eh];
};

started:
[
	Control #1002,
	[
		["2 x Smoke",93,"['ncb_2rnd_smoke_refill',2]"]
	]
]
dropped:
[
	Control #1001,
	0.293878,
	0.893197,
	1002,
	[
		["2 x Smoke",93,"['ncb_2rnd_smoke_refill',2]"]
	]
]

// when drag operation started, need to block off the idcs we canont transfer to:
// not enough room on player or in cargo, and also wrong turrets

// when dropped, then function to remove the mag from where it was and add it to where it needs to go

// note:  will need to make sure it is still where it came from (eg someone might empty the cargo or pick up a box off the floor)


c1 removeMagazineGlobal "500Rnd_127x99_mag_Tracer_Green";
magazines[] = {"96Rnd_40mm_G_belt","500Rnd_127x99_mag_Tracer_Green"};
magazines[] = {"680Rnd_35mm_AA_shells_Tracer_Green","4Rnd_Titan_long_missiles"};
magazines[] = {"140Rnd_30mm_MP_shells_Tracer_Green","60Rnd_30mm_APFSDS_shells_Tracer_Green","1000Rnd_65x39_Belt_Green","2Rnd_GAT_missiles"};
magazines[] = {"140Rnd_30mm_MP_shells_Tracer_Green","60Rnd_30mm_APFSDS_shells_Tracer_Green","1000Rnd_65x39_Belt_Green","2Rnd_GAT_missiles"};
magazines[] = {"SmokeLauncherMag"};
holder1 = createVehicle ["GroundWeaponHolder_Scripted",getPos this,[],0,"can_collide"];
holder1 addMagazineAmmoCargo ["ncb_32rnd_40mm_g_refill",1,10];
holder1 addMagazineAmmoCargo ["ncb_60rnd_flare_refill",1,60];
holder1 addMagazineAmmoCargo ["ncb_60rnd_chaff_refill",1,60];
holder1 addMagazineAmmoCargo ["ncb_2rnd_smoke_refill",1,2];
holder1 addMagazineAmmoCargo ["ncb_100rnd_20mm_cannon_refill",1,100];
holder1 addMagazineAmmoCargo ["ncb_100rnd_25mm_cannon_refill",1,100];
holder1 addMagazineAmmoCargo ["ncb_50rnd_30mm_cannon_refill",1,50];
holder1 addMagazineAmmoCargo ["ncb_40rnd_35mm_cannon_refill",1,40];
holder1 addMagazineAmmoCargo ["ncb_30rnd_40mm_cannon_refill",1,30];
holder1 addMagazineAmmoCargo ["ncb_100rnd_127x99_refill",1,100];
holder1 addMagazineAmmoCargo ["ncb_100rnd_127x108_refill",1,100];
holder1 addMagazineAmmoCargo ["ncb_100Rnd_762x51_refill",1,100];
holder1 addMagazineAmmoCargo ["ncb_100Rnd_65x39_refill",1,100];
holder1 addMagazineAmmoCargo ["ncb_PG_missile_refill",1,1];
holder1 addMagazineAmmoCargo ["ncb_DAR_missile_refill",1,1];
holder1 addMagazineAmmoCargo ["ncb_scalpel_missile_refill",1,1];
holder1 addMagazineAmmoCargo ["Titan_AT",1,1];
holder1 addMagazineAmmoCargo ["Titan_AA",1,1];

_fnc_turretsCfg = {
	private _vehConfig = configFile >> "CfgVehicles" >> typeOf _this;
	private _vehTurretsCfg = [_vehConfig];
	private _fnc_getTurretsCfg = {
		{
			if (getNumber(_x >> "isPersonTurret") < 1) then {
				_vehTurretsCfg pushBack _x;
				if (isClass (_x >> "Turrets")) then {_x call _fnc_getTurretsCfg};
			}
		} forEach ("true" configClasses (_this >> "Turrets"));
	};

	_vehConfig call _fnc_getTurretsCfg;
	_vehTurretsCfg
};


//from config

// configfile >> "CfgVehicles" >> "ncb_veh_tigris" >> "Turrets" >> "MainTurret" >> "Turrets" >> "CommanderOptics" >> "magazines"

// from function

/*[
	bin\config.bin/CfgVehicles/ncb_veh_tigris,
	bin\config.bin/CfgVehicles/O_APC_Tracked_02_AA_F/Turrets/MainTurret,
	bin\config.bin/CfgVehicles/O_APC_Tracked_02_AA_F/Turrets/MainTurret/Turrets/CommanderOptics
]*/


_manipulate = "My first line<br/>My second line<br/>Third line<br/>you guessed it, fifth line<br/>I lied that was the fourth.";
_manipulate = _manipulate splitString "<br/>";
diag_log _manipulate


21:47:38 Warning Message: No entry 'bin\config.bin/CfgMagazines.82mm_mortar_shell'.

new magazine overhaul

pros - no messing with vehicle configs or weapon configs

easy-to-use system for loading/unloading vehicle magazines

things like grenade launchers can be included in game

modded vehicles/statics much easier to add to missions

cons - (things to do)

need to change interaction system for vehicles - add to chassis menu - also weapon damage will change possibly
need to change magazine interaction system for statics - DONE (maybe)
need to change assemble/disassemble scripts for statics - DONE - amended loading.fsm (weaponassembled EH) and horde_fnc_staticWeaponDisassemble
need to delete empty statics from configs - DONE
need to change mortar death script - DONE (deleted)

look for these in script:
ncb_static_hmg_low_unloaded

delete horde_fnc_staticWeaponReload
delete horde_fnc_staticWeaponUnload
delete horde_fnc_addMagazineToTurret
delete horde_fnc_removeMagazineFromTurret
delete horde_fnc_createPartialMagazineOnFloor
delete horde_fnc_setVehicleMagazineDlg
delete horde_fnc_setVehicleMagazineTypeDlg
delete horde_fnc_setHolderOnFloor
delete horde_fnc_hasRightMagsForAction
delete horde_fnc_staticWeaponReload
possibly horde_fnc_repairVehicleWeapon

Need to remove the refill mags from the itemCategory.sqf script (no combining into vehicle mags - except refills!)


_cfgAmmo = configFile >> "CfgAmmo";
_cfgMags = configFile >> "CfgMagazines";
for "_i" from 0 to (count _cfgAmmo - 1) do {
	_cfgAmmoEntry = _cfgAmmo select _i;
	_ammoClass = configName _cfgAmmoEntry;
	if (isClass _cfgAmmoEntry) then {
		if ({if (_ammoClass isKindOf _x) exitWith {1}} count ["BulletBase","ShotgunBase","F_40mm_White","G_40mm_HE","G_40mm_Smoke"] > 0
			and {toLower _ammoClass find "base" == -1}
		) then {
			_arr = [];
			// iterate through cfgMags
			for "_j" from 0 to count _cfgMags - 1 do {
				_cfgMagEntry = _cfgMags select _j;
				_magClass = configName _cfgMagEntry;
				_isVehicleMag = _magClass isKindOf ["VehicleMagazine",_cfgMags];
				if (isClass _cfgMagEntry
					and {getNumber (_cfgMagEntry >> "scope") == 2}
					and {getText (_cfgMagEntry >> "model") != ""}
					and {getText (_cfgMagEntry >> "picture") != ""}
					and {getText (_cfgMagEntry >> "ammo") == _ammoClass}
					//and {
					//	getText (_cfgMagEntry >> "ammo") isKindOf _ammoClass
					//	or {
					//		_ammoClass isKindOf (getText (_cfgMagEntry >> "ammo"))
					//	}
					//}
					and {
						not _isVehicleMag
						or {_isVehicleMag and {getNumber (_cfgMagEntry >> "ncb_refill") == 1}}
					}
				) then {
					_arr pushBack _magClass;
				};
			};
			uiNamespace setVariable ["ncb_uv_ammoMags_" + _ammoClass,_arr];
			diag_log format ["'%1' - %2",_ammoClass,_arr];
		};
	};
};


sound of reloading - some weapons have it some donot

reloadMagazineSound[] = {"A3\Sounds_F\arsenal\weapons_static\HMG_127mm_static\HMG127mm_static_reload",1,1,10};
reloadSound[] = {"",1,1};
reloadMagazineSound[] = {"A3\Sounds_F\arsenal\weapons_static\Static_HMG\reload_static_HMG",10,1,20}; // <== this one

this intermittent pause - i suspect a zone is trying to spawn/reinforce and it is something
 to do with that dijstrika code i added

 stop q & e being pressed when no gun

diag_log "----------------------";
diag_log "----------------------";
diag_log "----------------------";
{
	if (side _x isEqualTo east) then {
		diag_log "----------------------";
		diag_log format ["group %1",_x];
		diag_log format ["groupID %1",groupID _x];
		diag_log format ["leader %1",leader _x];
		diag_log format ["type leader %1",typeOf leader _x];
		diag_log format ["vehicle leader %1",typeOf vehicle leader _x];
		diag_log format ["position leader %1",position leader _x];
		diag_log format ["units group %1",count units _x];
		diag_log "----------------------";
	}
} forEach allGroups;
diag_log "----------------------";


 1:25:38 "----------------------"
 1:25:38 "group O Alpha 1-2"
 1:25:38 "groupID Alpha 1-2"
 1:25:38 "leader O Alpha 1-2:1 REMOTE"
 1:25:38 "type leader Horde_UAV_AI"
 1:25:38 "vehicle leader ncb_static_spartan_system"
 1:25:38 "position leader [1536.93,1392.89,1.73148]"
 1:25:38 "units group 1"
 1:25:38 "----------------------"
 1:25:38 "----------------------"
 1:25:38 "group O Alpha 1-3"
 1:25:38 "groupID Alpha 1-3"
 1:25:38 "leader O Alpha 1-3:1 REMOTE"
 1:25:38 "type leader Horde_UAV_AI"
 1:25:38 "vehicle leader ncb_static_spartan_system"
 1:25:38 "position leader [1778.92,1605.19,1.75546]"
 1:25:38 "units group 1"
 1:25:38 "----------------------"
 1:25:38 "----------------------"
 1:25:38 "group O Alpha 1-4"
 1:25:38 "groupID Alpha 1-4"
 1:25:38 "leader O Alpha 1-4:1 REMOTE"
 1:25:38 "type leader Horde_UAV_AI"
 1:25:38 "vehicle leader ncb_static_spartan_system"
 1:25:38 "position leader [1183.45,1306.26,1.73147]"
 1:25:38 "units group 1"
 1:25:38 "----------------------"


 hmm, so it does not look like it is the zoneManager (good) because the pauses continued after it was paused.

 Possibly look_around.fsm, but i think more likely at this point it is animal manager.fsm


 LOCATIONS!  Added some locations in serverPreInit but they do not show up on player maps
 because locations are local.  Add some code to broadcast them.

 loading saved mission artillery seems broken

 16:15:49 Error in expression <ble _zoneName;
_totalBaseZones pushBack _zone;
_allGuns = [];
_allMen = [];
_sav>
16:15:49   Error position: <_zone;
_allGuns = [];
_allMen = [];
_sav>
16:15:49   Error Undefined variable in expression: _zone
16:15:49 File server\init\serverPostInit.sqf [horde_fnc_serverPostInit], line 707

fnc_bandage = {
	player sideChat "started";
	private _helm = headgear player;
	if (_helm != "") then {
		removeHeadgear player;
		if (player canAdd _helm) then {
			player addItem _helm
		} else {
			if (isNull objectParent player) then {
				private _holder = createVehicle [
					"GroundWeaponHolder",
					ASLtoAGL getPosASL player,
					[],
					0,
					"can_collide"
				];
				_holder addItemCargoGlobal [_helm,1]
			} else {
				objectParent player addItemCargoGlobal _helm
			}
		}
	};
	player playActionNow "Medic";
	player removeItem "FirstAidKit";
	_idx = player addEventHandler ["animDone",{
		if (alive player and {lifeState player != "unconscious"}) then {
			player setVariable ["ncb_bandageData",[damage player,time + 300]];
			player setDamage 0;
			player addHeadgear "H_HeadBandage_bloody_F";
		};
		player removeEventHandler ["animDone",player getVariable ["ncb_healingDone",-1]];
		player setVariable ["ncb_healingDone",nil];
	}];
	player setVariable ["ncb_healingDone",_idx];
};

player addAction [
	"Bandage wounds",

	"0 spawn fnc_bandage",
	[],
	6,
	false,
	true,
	"",
	"alive _this and {damage _this > 0} and {not (toLower animationState _this select [1,3] in ['sdv','ssw','swm'])} and {ASLtoAGL getPosASL player select 2 >= 0} and {'FirstAidKit' in items player}",
	3,
	false,
	""
];

player addEventHandler ["take",{
	params ["","","_item"];
	player getVariable ["ncb_bandageData",[0,0]] params ["_oldDamage","_timeout"];
	if (headgear player != "H_HeadBandage_bloody_F"
		and {time < _timeout}
		and {damage player < _oldDamage}
	) then {
		player setDamage _oldDamage
	}
}];
player addEventHandler ["put",{
	params ["","","_item"];
	player getVariable ["ncb_bandageData",[0,0]] params ["_oldDamage","_timeout"];
	if (headgear player != "H_HeadBandage_bloody_F"
		and {time < _timeout}
		and {damage player < _oldDamage}
	) then {
		player setDamage _oldDamage
	}
}];
"call {0 spawn fnc_bandage}",
// 0 spawn fnc_bandage


weapons[] = {"HMG_127"}; // ifrit
weapons[] = {"autocannon_30mm_CTWS","LMG_M200","missiles_titan"}; // kamysh
weapons[] = {"HMG_127_APC","GMG_40mm"}; // marid
weapons[] = {"HMG_127_APC","GMG_40mm","SmokeLauncher"}; // sochor
weapons[] = {"HMG_127"}; // strider

hmm

kamysh lmg is 6.5x39 - 1000rds

varsuk lmg is 7.62x51 - 2 x 2000rds // LMG_coax

all miniguns are now 7.62x51 - orca, qulin, boats

sochor hmg is 129x99 - 500 rds

boat hmgs are 127x99 - 3 x 200rds

gorgon lmg is 6.5x39 - 1000 rds


// define

class H_PilotHelmetFighter_B

in the helmet

subItems[] = {"Integrated_NVG_F"};

then this item takes up the nvg slot

so if we have a dummy backpack as a subitem for ghillie...


	class ncb_obj_dummy_backpack : Bag_Base {
		author = "Das Attorney";
		displayName = "Ghille suit";
		mapSize = 0.01;
		model = "\A3\weapons_f\empty";
		maximumLoad = 0;
		mass = 0;
		transportMaxWeapons = 0;
		transportMaxMagazines = 0;
	};
	class U_B_GhillieSuit : Uniform_Base {
		subItems[] = {"ncb_obj_dummy_backpack"};
	};


player addEventHandler ["take", {
	params ["","","_item"];
	PLAYER sideChat format ["time : %1, item : %2",time,_item];
	if (_item == "U_B_GhillieSuit" and {backpack player != ""}) then {
		_gwh = "GroundWeaponHolder_Scripted" createVehicle position player;
		player action ["DropBag", _gwh, typeOf unitBackpack player];
	}
}]

player addEventHandler ["take", {
	params ["","","_item"];
	PLAYER sideChat format ["time : %1, item : %2",time,_item];
	if (_item == "U_B_GhillieSuit" and {backpack player != ""}) then {
		removeBackpack player
	}
}]


10:57:27 "[B Alpha 1-1:1 (Horde),""amovpercmstpsraswrfldnon_amovpknlmstpsraswrfldnon""]"
10:57:28 "[B Alpha 1-1:1 (Horde),""ainvpknlmstpslaywrfldnon_medic""]"
10:57:34 "[B Alpha 1-1:1 (Horde),""ainvpknlmstpslaywrfldnon_medicdummyend""]"
10:57:34 "[B Alpha 1-1:1 (Horde),""amovpknlmstpsraswrfldnon""]"

0 = 0 spawn {
	waitUntil {time > 1};
	group1 = createGroup [east, false];
	man1 = group1 createUnit ["Horde_UAV_AI",[0,0,0],[],0,"can_collide"];
	man1 assignAsDriver t1;
	man1 moveInDriver t1;
	man2 = group1 createUnit ["Horde_UAV_AI",[0,0,0],[],0,"can_collide"];
	man2 assignAsGunner t1;
	man2 moveInGunner t1;
	man3 = group1 createUnit ["Horde_UAV_AI",[0,0,0],[],0,"can_collide"];
	man3 assignAsCommander t1;
	man3 moveInCommander t1;
	man4 = group1 createUnit ["Horde_UAV_AI",[0,0,0],[],0,"can_collide"];
	man4 assignAsDriver t2;
	man4 moveInDriver t2;
	man5 = group1 createUnit ["Horde_UAV_AI",[0,0,0],[],0,"can_collide"];
	man5 assignAsGunner t2;
	man5 moveInGunner t2;
	man6 = group1 createUnit ["Horde_UAV_AI",[0,0,0],[],0,"can_collide"];
	man6 assignAsCommander t2;
	man6 moveInCommander t2;
	wp1 = group1 addWaypoint [markerPos "m1",0];
	wp1 setWaypointType "move";
	wp1 setWaypointBehaviour "careless";
	wp1 setWaypointFormation "column";
	wp1 setWaypointSpeed "normal";
};

chat channels only switch on after spectator is closed
no GPS???
DOES MORTAR GUNNER USE INFO FROM HIS OWN GROUP?? - NO IT IS NOT RELOADING!  (CHECK RPT - PROB NOT ADDED IN ARRAY IN SERVER.PREINIT)

2017/10/15, 21:31:27 "ncb_static_mortar - [[[-1],[""FakeWeapon""]],[[0],[""8Rnd_82mm_Mo_shells"",""8Rnd_82mm_Mo_Flare_white"",""8Rnd_82mm_Mo_Smoke_white""]]]"

hmm, reload EH not working maybe on DS?

DS!!!
client crash on unloading ncb_veh_ifrit_hmg from gun to cargo

4000 lines of this:

 2:46:02 "reloadMenu _this: [1f536c34080# 620057: mrap_02_hmg_f.p3d REMOTE,[""ncb_100rnd_127x108_mag"",[0]]]"

 3:03:28 "fnc_removeMagazinesTurret"
 3:03:28 "reloadMenu _this: [212cf0c0080# 626080: mrap_02_hmg_f.p3d REMOTE,[""smokelaunchermag"",[-1]]]"

turret functions need to be global & also when mag is added, it is not updating the menu (have to close and reopen it to see updated ammo)

// reimplement these (because remoteExecCall is automatically network - no local check)

setFuelGlobal ==> REPLACE
setHitPointDamageGlobal ==> REPLACE
setUnitRatingGlobal ==> MODIFY FNC
setVectorDirAndUpGlobal ==> REPLACE
setVehicleAmmoDefGlobal ==> REPLACE
setVelocityGlobal ==> REPLACE
setWeaponAmmoGlobal ==> REPLACE
staticWeaponReloadGlobal ==> MODIFY FNC // hmm function is depreciated as is rest of script
switchMoveGlobal ==> REPLACE
removeMagazineTurretGlobal ==> REPLACE
playMoveNowGlobal ==> REPLACE
lockCargoGlobal ==> REPLACE
enableSimulationGlobal ==> REPLACE
deleteGroupGlobal ==> REPLACE
allowDamageGlobal ==> REPLACE
addWeaponGlobal ==> REPLACE
addMagazineTurretGlobal ==> REPLACE
addMagazineGlobal ==> REPLACE

Also, I think the reloadMenu does not update correctly on dedi as the "ncb_gv_vehicleAmmoChanged" variable is triggered before the mag updates on a remote object, so either make it check on every frame, or send it back from owner with remoteExecCall

{diag_log _x} forEach (animationNames vehicle player)

"damagehide"
"damagehidevez"
"damagehidehlaven"
"wheel_1_1_destruct"
"wheel_1_2_destruct"
"wheel_1_3_destruct"
"wheel_1_4_destruct"
"wheel_2_1_destruct"
"wheel_2_2_destruct"
"wheel_2_3_destruct"
"wheel_2_4_destruct"
"wheel_1_1_destruct_unhide"
"wheel_1_2_destruct_unhide"
"wheel_1_3_destruct_unhide"
"wheel_1_4_destruct_unhide"
"wheel_2_1_destruct_unhide"
"wheel_2_2_destruct_unhide"
"wheel_2_3_destruct_unhide"
"wheel_2_4_destruct_unhide"
"wheel_1_3_damage"
"wheel_1_4_damage"
"wheel_2_3_damage"
"wheel_2_4_damage"
"wheel_1_3_damper_damage_backanim"
"wheel_1_4_damper_damage_backanim"
"wheel_2_3_damper_damage_backanim"
"wheel_2_4_damper_damage_backanim"
"glass1_destruct"
"glass2_destruct"
"glass3_destruct"
"glass4_destruct"
"glass5_destruct"
"glass6_destruct"
"fuel"
"wheel_1_1"
"wheel_2_1"
"wheel_1_2"
"wheel_2_2"
"wheel_1_1_damper"
"wheel_2_1_damper"
"wheel_1_2_damper"
"wheel_2_2_damper"
"daylights"
"pedal_thrust"
"pedal_brake"
"wheel_1_1_damage"
"wheel_1_2_damage"
"wheel_2_1_damage"
"wheel_2_2_damage"
"wheel_1_1_damper_damage_backanim"
"wheel_1_2_damper_damage_backanim"
"wheel_2_1_damper_damage_backanim"
"wheel_2_2_damper_damage_backanim"
"vehicletransported_antenna_hide"
"drivingwheel"
"steering_1_1"
"steering_2_1"
"indicatorspeed"
"indicatorfuel"
"indicatorrpm"
"indicatortemp"
"indicatortemp_move"
"indicatortemp2"
"indicatortemp2_move"
"reverse_light"
"door_lf"
"door_rf"
"door_lb"
"door_rb"
"mainturret"
"maingun"
"joystick_gunner_x"
"joystick_gunner_y"
"turret_indicator"
"damagehlaven"
"mg_muzzle"
"zaslehrot"


{vehicle player animate [_x,1]} forEach [
	"door_lf",
	"door_rf",
	"door_lb",
	"door_rb"
]
{
	vehicle player animateDoor [_x,1,false]
} forEach [
	"door_lf",
	"door_rf",
	"door_lb",
	"door_rb"
]

{vehicle player animate [_x,1]} forEach (animationNames vehicle player)
{vehicle player animateDoor [_x,1,false]} forEach (animationNames vehicle player)

{
	diag_log format ["HCMANAGER - eligible group: %1 Current owner: %2",_x,groupOwner _x]
} count _groups;

disassemble generator does not work DS - NEED TO MAKE SCRIPT
MORTAR?? ncb_1rnd_155mm_cannon_refill - gone somehow!
vehicle aMMO - ADD TO CRATES
CRATES FOR FUEL
4 CRATES AT BIG PLANE???

Check whether functions should be in common, some of them (getInVeh, getOutVeh etc) are server only


dism /export-image /SourceImageFile:install.esd /SourceIndex:3 /DestinationImageFile:install.wim /Compress:max /CheckIntegrity

dism /Get-WimInfo /WimFile:C:\sources\install.wim

Dism /Online /Cleanup-Image /RestoreHealth /Source:%USERPROFILE%\Desktop\mount\install.wim /LimitAccess

Dism /mount-wim /wimFile:%USERPROFILE%\Desktop\install.wim /index:1 /MountDir:%USERPROFILE%\Desktop\mount



dism /export-image /SourceImageFile:install.esd /SourceIndex:3 /DestinationImageFile:install.wim /Compress:max /CheckIntegrity

Dism /Online /Cleanup-Image /RestoreHealth /Source:G:\Windows /LimitAccess


DISM /Online /Cleanup-Image /RestoreHealth /Source:D:\sources\Install.esd
DISM /Online /Cleanup-Image /RestoreHealth /Source:G:\Windows\sources\install.wim /LimitAccess
DISM /Online /Cleanup-Image /RestoreHealth /Source:G:\Windows /LimitAccess

Dism /Online /Cleanup-Image /RestoreHealth /Source:wim:G:\Windows\Sources\Install.wim:3 /limitaccess

Dism /Online /Cleanup-Image /RestoreHealth /Source:wim:D:\Sources\Install.wim:3 /limitaccess

DISM /Online /Cleanup-Image /RestoreHealth /source:esd:D:\sources\install.esd\3 /LimitAccess

DISM /Online /Cleanup-Image /RestoreHealth /Source:WIM:c:\install.wim:1 /LimitAccess


--------------------------
change dir
dism /Get-WimInfo /WimFile:install.esd

idx = 3

dism /export-image /SourceImageFile:install.esd /SourceIndex:3 /DestinationImageFile:install.wim /Compress:max /CheckIntegrity
// if multiple windows versions
dism /Get-WimInfo /WimFile:C:\ryanfix\install.wim
// then export the one we want to
dism /export-image /SourceImageFile:C:\ryanfix.install.wim /SourceIndex:1 /DestinationImageFile:C:\install.wim /Compress:max /CheckIntegrity

DISM /Online /Cleanup-Image /RestoreHealth /Source:WIM:c:\ryanfix\install.wim:1 /LimitAccess


Dism /Online /Cleanup-Image /ScanHealth
Dism /Online /Cleanup-Image /CheckHealth
Dism /Online /Cleanup-Image /StartComponentCleanup


update on rhythmic stutter bug - skydive spawn on Tanoa triggered it.

Pressed 006 to kill all AI units in 2km cured it.  So it was either infantry units, or snipers (not vehicles or statics as the script only kills SoldierEB)

Next time this happens, check the pools.  I have a feeling there is not enough units left in one of the pools so it is skipping like a bastard.

Best time to check would be when one of the side missions like assassination/destroyAA comes up.

// change the pars to array

25.10.2017 02:52:44: Horde (109.158.46.19:2316) 5639fa2103f8d7e9a6b6150ebc7cb5cd - #0 "horde_fnc_serverplayerconfirmkills p1"
25.10.2017 02:52:58: Horde (109.158.46.19:2316) 5639fa2103f8d7e9a6b6150ebc7cb5cd - #0 "horde_fnc_tentkilled 1f548f00b80# 645178: tentdome_f.p3d REMOTE"
25.10.2017 02:53:51: Horde (109.158.46.19:2316) 5639fa2103f8d7e9a6b6150ebc7cb5cd - #0 "horde_fnc_servershutdown true"

revive fully heals (could be a cheat)
revive did not heal bleeding - should this be stopped in ko mode??


option to remove bullets needs to be removed if no bullets & it might be bugged anyway

onEachFrame {hintSilent "empty grps: " + str count (allGroups select {count units _x != 0})}

// problem with HC and reinforcement - does not seem to want to add new groups when merge is ran - investigate!!

hordezone_38 getVariable ["zoneCurrentGroups",[]]

[
	O HordeZone_38_infantry_O Alpha 2-3,
	O HordeZone_38_infantry_O Alpha 1-6,
	O HordeZone_38_static_O Alpha 2-4
]

hordezone_38 getVariable ["zoneValue",[]]

// notes for group menu

// not clear player/group/invite button is actually a button!

// maybe tooltip in lb should indicate group is public/private

// groups - when highlighted groups is private - maybe disable button/change colour

// players - when highlighted player is group member then disable button/delete text on button/change colour
//
// players - list players in group with leader at top??

// invites - maybe have decline option???  Would need to rework menu...

// invite sent message maybe!

// tooltip for private button needs updating

// exit button

// do something about multiple boxes highlighted (maybe small fnc that deselects lbs) #ctrl lbSetSelected [index,t/f]






// as a test, commented this line in respawn.fsm  player switchMove ""

// get rid of large fuel and repair crates

// no tasks for jip!!!

2017/10/27,  0:14:22 Scripting function 'bis_fnc_settasklocal' is not allowed to be remotely executed
2017/10/27,  0:14:22 Scripting function 'bis_fnc_settasklocal' is not allowed to be remotely executed
2017/10/27,  0:14:22 Scripting function 'bis_fnc_settasklocal' is not allowed to be remotely executed
2017/10/27,  0:14:22 Scripting function 'bis_fnc_settasklocal' is not allowed to be remotely executed
2017/10/27,  0:14:22 Scripting function 'bis_fnc_settasklocal' is not allowed to be remotely executed
2017/10/27,  0:14:22 Scripting function 'bis_fnc_execvm' is not allowed to be remotely executed

// weather nice - needs to be synched up for players connected at mission start though - also, clouds are NOT syncing up.
// server at 0.8 overcast, both clients at 0.3

// save radio scripts off properly

2017/10/27,  0:19:46 Error in expression <use getVariable "LOOT_HOLDER_OBJECTS";
[_lootHolderObjs,false] remoteExecCall [
>
2017/10/27,  0:19:46   Error position: <_lootHolderObjs,false] remoteExecCall [
>
2017/10/27,  0:19:46   Error Undefined variable in expression: _lootholderobjs



19:18:44 "steal vehicle: 'Land_Shed_Big_F'"19:15:56 "steal vehicle: '#GdtConcrete'"19:09:45 "steal vehicle: 'Land_Hangar_F'"19:09:10 "steal vehicle: 'Land_TentHangar_V1_F'"

how to find concrete areas???

["HitLFWheel","HitLF2Wheel","HitRFWheel","HitRF2Wheel","HitReserveWheel","HitFuel","HitHull","HitEngine","HitBody","HitGlass1","HitGlass2","HitGlass3","HitGlass4","HitGlass5","HitGlass6","HitGlass7","HitGlass8","HitGlass9","HitGlass10","HitGlass11","HitRGlass","HitLGlass","HitLBWheel","HitLMWheel","HitRBWheel","HitRMWheel","","","","","","","HitTurret","HitGun"]

weapons[] = {"cannon_125mm","ncb_weap_762x54_lmg_coax_2000"};
magazines[] = {"24Rnd_125mm_APFSDS_T_Green","12Rnd_125mm_HE_T_Green","12Rnd_125mm_HEAT_T_Green","ncb_mag_762x54_2000_w","ncb_mag_762x54_2000_w"};
0 = 0 spawn {
	_cfgs = "configName _x find 'ncb_' > -1 and {not (configName _x isKindOf 'Man')} and {configName _x isKindOf 'AllVehicles'} and {getNumber (_x >> 'scope') == 2} and {getText (_x >> 'model') != ''}" configClasses (configFile >> "CfgVehicles");
	_cfgs = _cfgs apply {configName _x};
	_pos = p1 getPos [17,0];
	{
		_class = _x;
		diag_log format ["TEST SPAWNING %1 -----------------------------------------------------",_class];
		_veh = createVehicle [_class,_pos,[],0,"can_collide"];
		_veh call horde_fnc_addExtraVehicleMags;
		_veh allowDamage false;
		createVehicleCrew _veh;
		sleep 3;
		{
			_x setDamage 1;
			waitUntil {
				not alive _x
			};
		} forEach crew _veh;
		deleteVehicle _veh;
		waitUntil {
			isNull _veh
		};
	} forEach _cfgs;
};



reinforcements appear to be broken  (maybe the groups did not merge)


No No No !   If the static group dies, then it spawns a reinforcement.....

Maybe go back to the other zoneManager and repair

Good zone to test is HordeZone_12 on Malden (near Le Port)

Hmm, maybe store static group in their own variable....

{if (_forEachIndex < 2) then {_x setDamage 1}} forEach units group cameraOn

(cursorObject emptyPositions "cargo") + (cursorObject emptyPositions "driver") + (cursorObject emptyPositions "commander") + (cursorObject emptyPositions "gunner");

(cursorObject emptyPositions "cargo") + (count ([[-1]] + allTurrets [cursorObject,false]))

hordezone_12 getVariable "zoneReinforceTickets"



// check if patrolling

// check if all units are in vehicle  - {isNull objectParent _x} count units _grp > 0

_grp getVariable ["groupData",["",objNull]] params ["_grpType","_veh"];
if (_grpType != "infantry") then {
	if (not isNull _veh
		and {damage _veh < 1}
		and {canMove _veh}
		and {not (_veh call _fnc_cannotMove)}
		and {{alive _x and {isPlayer _x}} count crew _veh isEqualTo 0}
	) then {
		// ok to check like this as the new group merge system will not add more units than there are free seats
		if ({isNull objectParent _x} count units _grp > 0) then {
			units _grp allowGetin true;
			units _grp orderGetIn true;
			[_grp,ASLtoAGL getPosASL _veh] call _fnc_setGetinWp
		}
	} else {
		if not (isNull _veh) then {
			_grp leaveVehicle _veh;
			{
				unassignVehicle _x;
				_x action ["getout",_veh]
			} count units _grp;
		};
		[_grp,11] setWaypointSpeed "NORMAL";
		_grpData set [0,"infantry"];
		_grpData set [1,objNull];
		_grpData set [2,600];
		(_grp setVariable ["groupData",_grpData]);
		units _grp allowGetIn true;
		_grp call _fnc_startPatrolWp
	};
};


zones with unengageable enemies should be able to redirect chopper to engage the bad guy!

group cameraOn setCurrentWaypoint [group cameraOn, 1]

{_x forgetTarget vehicle player} count units group cameraOn

["HitBody","HitEngine"]

_val = toArray str ((t1 worldToModel (ASLtoAGL getPosASL s1)) apply {parseNumber (_x toFixed 3)});
_val deleteAt 0;
_val deleteAt (count _val - 1);
toString _val;

ncb_val = toArray str ((t1 worldToModel (ASLtoAGL getPosASL s1)) apply {parseNumber (_x toFixed 3)});
ncb_val deleteAt 0;
ncb_val deleteAt (count ncb_val - 1);
copyToClipboard (toString ncb_val);


_threshold = (_x select 1);
if  (_dmg >= _threshold) then {
if (_animType>
 1:18:06   Error position: <_dmg >= _threshold) then {
if (_animType>
 1:18:06   Error Undefined variable in expression: _dmg
 1:18:06 File nocebo\functions\server\vehicleDamageAnimSetup.sqf [Horde_fnc_vehicleDamageAnimSetup], line 186
 1:18:06 Error in expression <ct 0);
_threshold = (_x select 1);
if  (_dmg >= _threshold) then {
if (_animType>
 1:18:06   Error position: <_dmg >= _threshold) then {
if (_animType>
 1:18:06   Error Undefined variable in expression: _dmg
 1:18:06 File nocebo\functions\server\vehicleDamageAnimSetup.sqf [Horde_fnc_vehicleDamageAnimSetup], line 186
 1:18:07 No speaker given for
 1:18:08 "HCMANAGER - drones []"
 1:18:09 No speaker given for
 1:18:18 No speaker given for

 _beachHeads = getArray (_cfgZone >> "BeachHead" >> "ingressDataASL");

 (_beachHeads deleteAt (floor random count _beachHeads)) params ["_landingPosASL","_ingressPosASL","_depthAtIngressPos"];

 _ingressPosASL == NOT USED
 _depthAtIngressPos = NOT USED


could swap for ==>> getArray ("VehicleSpawnData" >> "beachingDataAGL")

Experiment to limit spawn positions to withing 500m of locations only!


Things to do:

Add missions in where encrypted data is given to players - leads to knackered tank/heli

Add final mission in (change all zones to value 1, then spawn in the loot crate)

Make some models for meat and crate full of nazi gold!


0 = 0 spawn {
	_cfgs = "configName _x find 'ncb_' > -1 and {not (configName _x isKindOf 'Man')} and {configName _x isKindOf 'AllVehicles'} and {getNumber (_x >> 'scope') == 2} and {getText (_x >> 'model') != ''}" configClasses (configFile >> "CfgVehicles");
	_cfgs = _cfgs apply {configName _x};
	_pos = p1 getPos [17,0];
	{
		_class = _x;
		diag_log format ["TEST SPAWNING %1 -----------------------------------------------------",_class];
		_veh = createVehicle [_class,_pos,[],0,"can_collide"];
		_veh call horde_fnc_addExtraVehicleMags;
		_veh allowDamage false;
		_veh call horde_fnc_vehicleDamageAnimSetup;
		sleep 0.5;
		deleteVehicle _veh;
		waitUntil {
			isNull _veh
		};
	} forEach _cfgs;
};

_this select 0 addEventHandler["FiredNear",{
	_civ=_this select 0;
	_numb = floor random 3;
	call {
		if (_numb == 0) exitWith {
			_civ playMoveNow "ApanPknlMstpSnonWnonDnon_G01";_civ setSpeedMode "FULL"
		};
		if (_numb == 1) exitWith {
			_civ switchMove "ApanPercMstpSnonWnonDnon_G01";_civ setSpeedMode "FULL"
		};
		_civ playMoveNow "ApanPpneMstpSnonWnonDnon_G01";_civ setSpeedMode "FULL"
	};

	_nH = nearestTerrainObjects [
		_civ,
		["BUILDING", "HOUSE", "CHURCH", "CHAPEL", "BUNKER", "FORTRESS", "LIGHTHOUSE", "FUELSTATION", "HOSPITAL", "RUIN"],
		100,
		false
	];

	_nH = _nh select {not (_x buildingPos 1 isEqualTo [0,0,0])};

	if not (_nH isEqualTo []) then {
		_civ doMove (selectRandom ((selectRandom _nH) buildingPos -1));
	} else {
		_civ doMove (_civ getPos [50 + random 50,random 360])
	};
	_civ removeAllEventHandlers "FiredNear";
	_civ setVariable ["ncb_civPanicOverAt",120];
}];

			_pos = player modelToWorld [0,0.5,0];
			_tex1 = 'a3\data_f\rainbow_ca.paa';
			_mat1 =  'A3\characters_f_bootcamp\Data\VR_Soldier_F.rvmat';
			_rainbow = "O_MRAP_02_F" createVehicle (_pos);
			_rainbow setObjectTextureGlobal [0,_tex1];
			_rainbow setObjectTextureGlobal [1,_tex1];
			_rainbow setObjectTextureGlobal [2,_tex1];
			_rainbow setObjectMaterialGlobal [0,_mat1];
			_rainbow setObjectMaterialGlobal [1,_mat1];
			_rainbow setObjectMaterialGlobal [2,_mat1];


_tex1 = 'a3\data_f\rainbow_ca.paa';
_tex1 = 'A3\Map_Stratis\data\sky_semicloudy_sky.paa';
_tex1 = 'a3\data_f\noise_raw.paa';
_tex1 = '\A3\Weapons_F\Data\clear_empty.paa';
_mat1 =  'A3\characters_f_bootcamp\Data\VR_Soldier_F.rvmat';
_rainbow = vehicle player;
_rainbow setObjectTextureGlobal [0,_tex1];
_rainbow setObjectTextureGlobal [1,_tex1];
_rainbow setObjectTextureGlobal [2,_tex1];
_rainbow setObjectMaterialGlobal [0,_mat1];
_rainbow setObjectMaterialGlobal [1,_mat1];
_rainbow setObjectMaterialGlobal [2,_mat1];


// added more medpacks + bandages to AI

// changed revive health to 0.5

// removed mags and weapons from civs

// added drag player option (may need some work)

// added nvg option (respawn.fsm)

// made player dead body timer separate (deletePlayerTimeout fnc added and also clearGarbage.fsm updated)

// SORTED OUT THE FUCKING  CAMP FIRE DAMAGE !!!!! (new cfgCloudlets class)

// notes

// add downed icon to unconscious units for their group members (horde_fnc_playerDownIcon)

// possible bug with loot despawning for some players if one player leaves building and another is still in the building

// error when charges not selected and trying to place charge

// MEDIGEL - BANDAGE INSTANTLY

// check apex weapons - seem to be added even though option disabled

// create reload magazine for "apfsds-t" (t100 varsuk)   16Rnd_125mm_APFSDS_T_Green  ["20Rnd_125mm_APFSDS","VehicleMagazine"

//Food values


create configs for these

//B_G_Offroad_01_AT_F
//I_Truck_02_MRL_F
//I_G_Offroad_01_AT_F

// have i put in IR proof camo nets????

// what is this error?  (appears on client)

22:28:56 Warning Message: No entry 'bin\config.bin.'.
22:28:56 Warning Message: No entry '.NormalCommand'.
22:28:56 Warning Message: No entry '.priority'.
22:28:56 Warning Message: '/' is not a value
22:28:56 Warning Message: No entry '.timeout'.
22:28:56 Warning Message: '/' is not a value


// blodd bag should be like MedPack is now and MedPak should heal bleeding and give health

_veh = createVehicle ["O_MBT_02_arty_F",position player,[],0,"NONE"];
[
	_veh,
	["Hex",1],
	["showAmmobox",1,"showCanisters",1,"showCamonetTurret",1,"showCamonetHull",1,"showLog",1]
] call BIS_fnc_initVehicle;



_veh = createVehicle ["O_APC_Wheeled_02_rcws_v2_F",position player,[],0,"NONE"];
[
	_veh,
	["Hex",1],
	["showBags",1,"showCanisters",1,"showTools",1,"showCamonetHull",1,"showSLATHull",1]
] call BIS_fnc_initVehicle;


{
	if (random 1 > 0.5) then {
		_this#0 animate [_x,1]
	}
} count [
	"showBags",
	"showCanisters",
	"showTools",
	"showCamonetHull",
	"showSLATHull"
];


// disabled ui.hpp for an experiment to see what is going on with vanilla values

// make option to spawn on group leader (or any other group members)

// alter respawn.fsm
// alter respawnMenu.hpp

// option to choose player to spawn on?  Or defaults to first living player in group???


/*13:57:47 Error in expression <icPathToOrigin") apply {getPosASL _x});
_waypointsASL pushBack _endPosASL;

priv>
13:57:47   Error position: <_waypointsASL pushBack _endPosASL;

priv>
13:57:47   Error Undefined variable in expression: _waypointsasl
13:57:47 File misc\waypointFinder.sqf [horde_fnc_waypointFinder], line 316*/




0 = [] execVM 'server\tasks\endTask\setup.sqf';

// updated the respawn to allow you to spawn on team members

// cn fire cannon on ship like this:

// hammer doArtilleryFire [screenToWorld [0.5,0.5], "magazine_ShipCannon_120mm_HE_shells_x32", 8]

{
	diag_log format ["%1", [typeOf _x, destroyer_base worldToModel (getPos _x), direction _x]]
} forEach [
	hammer,
	vls,
	prae_fwd,
	prae_port,
	prae_starboard,
	spartan,
	centurion
]

[
	["B_Ship_Gun_01_F",[0.0578613,-78.6045,12.0094],180],
	["B_Ship_MRLS_01_F",[0.0189209,-62.1714,-0.147498],0],
	["B_AAA_System_01_F",[-0.0793457,-47.9985,1.35557],180],
	["B_AAA_System_01_F",[9.67822,8.66748,0.0965715],180],
	["B_AAA_System_01_F",[-9.85852,8.01465,0.0612447],180],
	["B_SAM_System_01_F",[-0.0379639,50.5366,-0.139764],0],
	["B_SAM_System_02_F",[0.316284,35.4458,0.227651],0]
]


// commented out this to try and fix radioProtocol fuckup

class CfgVoice {
	class Base;
	class ENG : Base {
		protocol = "";
	};

	class ENGB : Base {
		protocol = "";
	};
};


if (isServer) then {
	{
		player disableUAVConnectability [_x,true];
	} forEach [
		ncb_obj_destroyer_hammer,
		ncb_obj_destroyer_vls,
		ncb_obj_destroyer_praetorian_fwd,
		ncb_obj_destroyer_praetorian_port,
		ncb_obj_destroyer_praetorian_starboard,
		ncb_obj_destroyer_centurion,
		ncb_obj_destroyer_spartan
	];
};


magazines[] = {"200Rnd_556x45_Box_Tracer_F","200Rnd_556x45_Box_Tracer_F","200Rnd_556x45_Box_Tracer_F"};


200Rnd_556x45_Box_Tracer_F3:53:08 Error in expression <l;

_unit enableAI "checkVisible";

if (_alarmBuilding) then {
private _objs = l>
 3:53:08   Error position: <_alarmBuilding) then {
private _objs = l>
 3:53:08   Error Undefined variable in expression: _alarmbuilding
 3:53:08 Error in expression <l;

_unit enableAI "checkVisible";

if (_alarmBuilding) then {
private _objs = l>
 3:53:08   Error position: <_alarmBuilding) then {
private _objs = l>
 3:53:08   Error Undefined variable in expression: _alarmbuilding
 3:53:08 Error in expression <l;

_unit enableAI "checkVisible";

if (_alarmBuilding) then {
private _objs = l>
 3:53:08   Error position: <_alarmBuilding) then {
private _objs = l>
 3:53:08   Error Undefined variable in expression: _alarmbuilding
 3:53:09 Error in expression <l;

_unit enableAI "checkVisible";

// also another error

11:55:07 Error in expression <2) params ["_wp","_stance"];
_x doWatch _wp;
_x setUnitPos _stance
}
};
if (_typ>
11:55:07   Error position: <_wp;
_x setUnitPos _stance
}
};
if (_typ>
11:55:07   Error Undefined variable in expression: _wp

// looks like not enough information is being saved.  For example:

// _vantagePointsHigh pushBack [_worldPos, _worldDir, _targetPositions,_alarmBuilding,surfaceIsWater _worldPos];


// _radioTransmitterVantagePointsHigh pushBack [_worldPos,_worldDir,_targetPositions];

fix this and look at cfgpatches

// this is how they're defined, with root cfgpatch (A3_Static_F_Exp) and others referencing it in their "addonRootClass" property

class A3_Static_F_Exp {
		author = "Bohemia Interactive";
		name = "Arma 3 Apex - Turrets";
		url = "https://www.arma3.com";
		requiredAddons[] = {"A3_Data_F_Exp"};
		requiredVersion = 0.1;
		units[] = {};
		weapons[] = {};
	};
	class A3_Static_F_Exp_AA_01 {
		addonRootClass = "A3_Static_F_Exp";
		requiredAddons[] = {"A3_Static_F_Exp"};
		requiredVersion = 0.1;
		units[] = {"B_T_Static_AA_F"};
		weapons[] = {};
	};
	class A3_Static_F_Exp_AT_01 {
		addonRootClass = "A3_Static_F_Exp";
		requiredAddons[] = {"A3_Static_F_Exp"};
		requiredVersion = 0.1;
		units[] = {"B_T_Static_AT_F"};
		weapons[] = {};
	};
	class A3_Static_F_Exp_GMG_01 {
		addonRootClass = "A3_Static_F_Exp";
		requiredAddons[] = {"A3_Static_F_Exp"};
		requiredVersion = 0.1;
		units[] = {"B_T_GMG_01_F"};
		weapons[] = {};
	};


// get configSourceAddonList _cfgItem;

// that returns something like:

// 10:38:48 "serverPreInit _cmal: [""A3_Weapons_F_Mark_LongRangeRifles_DMR_03""]"

// then find matching addon:

class CfgAddons {
	class PreloadAddons {
		class A3 {
			list[] = {.....};
		};
		class A3_Curator {
			list[] = {.....};
		};
		class A3_Kart {
			list[] = {.....};
		};
		class A3_Bootcamp {
			list[] = {.....};
		};
		class A3_Heli {
			list[] = {.....};
		};
		class A3_Mark {
			list[] = {....... "A3_Weapons_F_Mark_LongRangeRifles_DMR_03".......};
		};
	 };
};



need to inherit from marid v2 (anim errors)



2018/09/14, 21:30:42 Error in expression <use getVariable "LOOT_HOLDER_OBJECTS";
[_lootHolderObjs,false] remoteExecCall [
>
2018/09/14, 21:30:42   Error position: <_lootHolderObjs,false] remoteExecCall [
>
2018/09/14, 21:30:42   Error Undefined variable in expression: _lootholderobjs
2018/09/14, 21:31:02 "/****garbage script****/"
2018/09/14, 21:31:02 "time now: 734"
2018/09/14, 21:31:02 "ncb_gv_abandonedVehicles: []"
2018/09/14, 21:31:02 "types: []"
2018/09/14, 21:31:02 "time abandoned: []"
2018/09/14, 21:31:02 "count: 0"
2018/09/14, 21:31:02 "/*******************/"
2018/09/14, 21:31:06 "HM check casdata nil"
2018/09/14, 21:31:19 "HCMANAGER - drones []"
2018/09/14, 21:31:41 Error in expression <use getVariable "LOOT_HOLDER_OBJECTS";
[_lootHolderObjs,false] remoteExecCall [
>
2018/09/14, 21:31:41   Error position: <_lootHolderObjs,false] remoteExecCall [
>
2018/09/14, 21:31:41   Error Undefined variable in expression: _lootholderobjs




2018/09/14, 22:17:46 Error in expression <{alive _tent}
) then {
private _details = ;
if not ((_details isEqualTo [])) the>
2018/09/14, 22:17:46   Error position: <= ;
if not ((_details isEqualTo [])) the>
2018/09/14, 22:17:46   Error Generic error in expression
2018/09/14, 22:17:46 Error in expression <{alive _tent}
) then {
private _details = ;
if not ((_details isEqualTo [])) the>
2018/09/14, 22:17:46   Error position: <= ;
if not ((_details isEqualTo [])) the>
2018/09/14, 22:17:46   Error Generic error in expression
2018/09/14, 22:17:46 Error in expression <{alive _tent}
) then {
private _details = ;
if not ((_details isEqualTo [])) the>
2018/09/14, 22:17:46   Error position: <= ;
if not ((_details isEqualTo [])) the>
2018/09/14, 22:17:46   Error Generic error in expression
2018/09/14, 22:17:46 Error in expression <{alive _tent}
) then {
private _details = ;


2018/09/14, 23:11:55 Error in expression <use getVariable "LOOT_HOLDER_OBJECTS";
[_lootHolderObjs,false] remoteExecCall [
>
2018/09/14, 23:11:55   Error position: <_lootHolderObjs,false] remoteExecCall [
>
2018/09/14, 23:11:55   Error Undefined variable in expression: _lootholderobjs

errors in loot, join/leave groups (with tents)

disappearing guns (dropped by enemy)

blood bag (needs to be assigned)...

interior/exterior keys..

multiple markers on respawn screen for Tracey

spawn amphib vehs slightly in  air (=in case engine shuts off???)


// hmm wtf?? Hordezone_10 on Malden

11:38:30 Error in expression <tGlobal false;
_unit setPosASL AGLToASL _spawnPos;
[_unit,true] call horde_fnc_a>
11:38:30   Error position: <_spawnPos;
[_unit,true] call horde_fnc_a>
11:38:30   Error Undefined variable in expression: _spawnpos
11:38:30 File server\tasks\sideMissions\objectives\sideMissionHumanBomb.sqf [horde_fnc_sideMissionHumanBomb], line 276
11:38:30 Error in expression < random 1) + 1 do {
private _spawnPos = ASLtoAGL ([_buildingPosition,0,100,2,0,1>
11:38:30   Error position: <ASLtoAGL ([_buildingPosition,0,100,2,0,1>
11:38:30   Error 0 elements provided, 3 expected
11:38:30 File server\tasks\sideMissions\objectives\sideMissionHumanBomb.sqf [horde_fnc_sideMissionHumanBomb], line 266
11:38:31 Error in expression <tGlobal false;
_unit setPosASL AGLToASL _spawnPos;
[_unit,true] call horde_fnc_a>
11:38:31   Error position: <_spawnPos;
[_unit,true] call horde_fnc_a>
11:38:31   Error Undefined variable in expression: _spawnpos



// spectator cam

["Initialize", [player, [west], true, false, true, true, true, true, true, true]] call BIS_fnc_EGSpectator;

// terminate

/ The custom array for Initialize function can contain:
_this select 0 : The target player object
_this select 1 : Whitelisted sides, empty means all
_this select 2 : Whether AI can be viewed by the spectator
_this select 3 : Whether Free camera mode is available
_this select 4 : Whether 3th Person Perspective camera mode is available
_this select 5 : Whether to show Focus Info stats widget
_this select 6 : Whether or not to show camera buttons widget
_this select 7 : Whether to show controls helper widget
_this select 8 : Whether to show header widget
_this select 9 : Whether to show entities / locations lists

If the spectator mode is active and you would like to terminate it, run the following function:
["Terminate"] call BIS_fnc_EGSpectator;

//edited canOpenDoor.sqf so it ignores external/internal



// can't open doors

"Land_FuelStation_01_shop_F"
"Land_School_01_F"
"Land_House_Small_04_F"
"Land_Shop_Town_01_F"
"Land_Shop_Town_03_F"
"Land_House_Small_04_F"

delete light fire options (scroll menu)

Make fire last longer!

Sort out inventory (drag and menu does not disappear)

get rid of objects in watch slot

spawn with weapon at tent!  (shit weapon though)

Currently this mode deletes units on disxonect - maybe leave the corpse there???

weapons disappearing // forceSupply = 0; added to config (left off pending fix to cleargarbage below)



// client

23:23:54 "closing respawn dialog at 4165.5"
23:23:54 Error in expression <




horde_reviveCam camSetPos ASLtoATL eyePo>
23:23:54   Error position: <horde_reviveCam camSetPos ASLtoATL eyePo>
23:23:54   Error Undefined variable in expression: horde_revivecam

// server

Scripting function 'bis_fnc_execvm' is not allowed to be remotely executed


// tracey said about white screen when in spectator cam (nvg in daytime??)


// fixed bug in clearGarbage (no need for exception of simple objects as they all support setVariable now)
// was deleting everything

// changed defines for vehicle dialog buttons so they are off the screen by default

// added code so action menu button (user13) can now close the interaction menus

// need to find hpp for reload menu....

// get rid of crappy shit at top of inventory - done

// fix fires (no option to light),,,, - done

// replace logics with locations in marine waypoint finder script



player addEventHandler ["InventoryOpened", {
	0 = 0 spawn {
		sleep 3;
		disableSerialization;
		_ctrl = findDisplay 602 ctrlCreate ["CA_ContainerBackground",-1];
		_ctrl ctrlSetForegroundColor [1, 0, 0, 1];
		_ctrl ctrlSetBackgroundColor [1, 0, 0, 1];
		_ctrl ctrlSetText ("HELLO");
		{
			_numb = getNumber (_x >> "idc");
			_pos = ctrlPosition (findDisplay 602 displayCtrl _numb);
			(findDisplay 602 displayCtrl _numb) ctrlSetForegroundColor [0, 1, 0, 1];
			(findDisplay 602 displayCtrl _numb) ctrlSetBackgroundColor [0, 1, 0, 1];
			_ctrl ctrlSetPosition _pos;
			_ctrl ctrlSetText ("HELLO " + (str _numb));
			_ctrl ctrlCommit 0;
			sleep 0.5;
		} forEach ( "true" configClasses (configFile >> "RscDisplayInventory" >> "controls"));

		ncb_gv_invClosed = (findDisplay 602) displayAddEventHandler ["keydown", {
			if ((_this select 1) in (actionKeys "gear")) then {
				(findDisplay 602) displayRemoveEventHandler ["keydown",ncb_gv_invClosed];
				closeDialog 0
			}
		}];
	}
}];

// things to do

// check revive cam

// move assigneditems back to normal items (plus change code)

// locations not logics for marine WPs

// loot system!!!!

player addEventHandler ["InventoryOpened", {
	0 = 0 spawn {
		sleep 3;
		disableSerialization;
		_ctrl = findDisplay 602 ctrlCreate ["CA_ContainerBackground",-1];
		_ctrl ctrlSetForegroundColor [1, 0, 0, 1];
		_ctrl ctrlSetBackgroundColor [1, 0, 0, 1];
		_ctrl ctrlSetText ("HELLO");
		{
			_numb = getNumber (_x >> "idc");
			_pos = ctrlPosition (findDisplay 602 displayCtrl _numb);
			(findDisplay 602 displayCtrl _numb) ctrlSetForegroundColor [0, 1, 0, 1];
			(findDisplay 602 displayCtrl _numb) ctrlSetBackgroundColor [0, 1, 0, 1];
			_ctrl ctrlSetPosition _pos;
			_ctrl ctrlSetText ("HELLO " + (str _numb));
			_ctrl ctrlCommit 0;
			sleep 0.5;
		} forEach ( "true" configClasses (configFile >> "RscDisplayInventory" >> "controls"));

		ncb_gv_invClosed = (findDisplay 602) displayAddEventHandler ["keydown", {
			if ((_this select 1) in (actionKeys "gear")) then {
				(findDisplay 602) displayRemoveEventHandler ["keydown",ncb_gv_invClosed];
				closeDialog 0
			}
		}];
	}
}];
if (not isNil {HANDLE_X}) then {
	player removeEventHandler ["InventoryOpened",HANDLE_X];
};
HANDLE_X = player addEventHandler ["InventoryOpened", {
	0 = 0 spawn {
		sleep 1;
		disableSerialization;
		(findDisplay 602 displayCtrl 6191) ctrlAddEventHandler [
			"MouseButtonDown",
			{
				player groupChat format ["MouseButtonDown %1",round time];
			}
		];
		(findDisplay 602 displayCtrl 6191) ctrlAddEventHandler [
			"MouseExit",
			{
				player groupChat format ["MouseExit %1",round time];
			}
		];
		(findDisplay 602 displayCtrl 6191) ctrlAddEventHandler [
			"KillFocus",
			{
				player groupChat format ["KillFocus %1",round time];
			}
		];
		(findDisplay 602 displayCtrl 6191) ctrlAddEventHandler [
			"LBDrag",
			{
				player groupChat format ["LBDrag %1",round time];
			}
		];
		(findDisplay 602 displayCtrl 6191) ctrlAddEventHandler [
			"LBDragging",
			{
				player groupChat format ["LBDragging %1",round time];
			}
		];
		(findDisplay 602 displayCtrl 6191) ctrlAddEventHandler [
			"LBDrop",
			{
				player groupChat format ["LBDrop %1",round time];
			}
		];
		(findDisplay 602 displayCtrl 6191) ctrlAddEventHandler [
			"ObjectMoved",
			{
				player groupChat format ["ObjectMoved %1",round time];
			}
		];
		(findDisplay 602 displayCtrl 6191) ctrlAddEventHandler [
			"MouseButtonClick",
			{
				player groupChat format ["MouseButtonClick %1",round time];
			}
		];

		ncb_gv_invClosed = (findDisplay 602) displayAddEventHandler ["keydown", {
			if ((_this select 1) in (actionKeys "gear")) then {
				(findDisplay 602) displayRemoveEventHandler ["keydown",ncb_gv_invClosed];
				closeDialog 0
			}
		}];
	}
}];


Exception code: C0000094 INT_DIVIDE_BY_ZERO at CE71D04C

skill tyre fitter text

update respawn priority to one array  // made tent var "tentOwnerDetails" public so client can access it - updated respawnMapClicked

broken spectator cam

radio transmitter stuff not being recorded in serverShutdown.sqf  // also not setup in serverPostInit for reloads!



// errors (server)

2018/09/17, 22:56:25 Error in expression <{alive _tent}
) then {
private _details = ;
if not ((_details isEqualTo [])) the>
2018/09/17, 22:56:25   Error position: <= ;
if not ((_details isEqualTo [])) the>
2018/09/17, 22:56:25   Error Generic error in expression
2018/09/17, 22:56:25 Error in expression <{alive _tent}
) then {
private _details = ;
if not ((_details isEqualTo [])) the>
2018/09/17, 22:56:25   Error position: <= ;
if not ((_details isEqualTo [])) the>
2018/09/17, 22:56:25   Error Generic error in expression
2018/09/17, 22:56:25 Error in expression <{alive _tent}
) then {
private _details = ;
if not ((_details isEqualTo [])) the>
2018/09/17, 22:56:25   Error position: <= ;
if not ((_details isEqualTo [])) the>
2018/09/17, 22:56:25   Error Generic error in expression
2018/09/17, 22:56:25 Error in expression <{alive _tent}
) then {
private _details = ;
if not ((_details isEqualTo [])) the>
2018/09/17, 22:56:25   Error position: <= ;
if not ((_details isEqualTo [])) the>
2018/09/17, 22:56:25   Error Generic error in expression
2018/09/17, 22:56:25 Error in expression <{alive _tent}
) then {
private _details = ;
if not ((_details isEqualTo [])) the>
2018/09/17, 22:56:25   Error position: <= ;
if not ((_details isEqualTo [])) the>
2018/09/17, 22:56:25   Error Generic error in expression
2018/09/17, 22:56:25 Error in expression <{alive _tent}
) then {
private _details = ;
if not ((_details isEqualTo [])) the>
2018/09/17, 22:56:25   Error position: <= ;
if not ((_details isEqualTo [])) the>
2018/09/17, 22:56:25   Error Generic error in expression
2018/09/17, 22:56:25 Error in expression <{alive _tent}
) then {
private _details = ;

// tried to fix by adding nil check to serverConfirmJoinGroup and serverConfirmLeaveGroup - was dodgy getVar, not getVarDef

2018/09/17, 23:05:30 "addExtraVehicleMags ""extra mag info missing for this class"": extra mag info missing for this class"
2018/09/17, 23:05:30 "addExtraVehicleMags typeOf _this: ncb_veh_marid_unarmed"


radio is broken - cannot invite other players.... (no it is not - I forgot you can select groups/players/invites from same button)

// shot player in same group (same ID though) but players killed did not update

// clear inventory of blackfish gunners

// neoarmageddons cam script
escape >> functions >> HSC >> fn_createCam
ATHSC_fnc_createCam

// something to note for ammoboxes, they are not persistent if not near a tent.  So ammoboxes at artillery positions and radio transmitters will have different gear on reload if they are not near a tent.  In addition, if a tent is placed near an active artillery piece and it is still alive, then on reload it will be duplicated.  (one for the data in task and one for the vehicle near the tent)


var_playerTemp = 10; // min is 0 max is 20

fnc_addTemp = {
	params ["_add"];
	var_playerTemp = var_playerTemp + _add;
	if (var_playerTemp > 20) then {
		var_playerTemp = 20;
	} else {
		if (var_playerTemp < 0) then {
		var_playerTemp = 0;
	}
};
0 = 0 spawn {
	waitUntil {
		_night = if (sunOrMoon == 1) then {false} else {true};
		private _pos = getPosASL player;
		_tempChange = 0;
		// system will have warmup/same temp/colder
		// is player in a vehicle
		if (vehicle player != player) then {
			// if engine on then warmup otherwise same
			if (engineOn vehicle player) then {
				_tempChange = _tempChange + 1;
			}
		} else {
			// player is not in a vehicle
			// is player in water
			if (surfaceIsWater _pos and {_pos select 2 < 0}) then {
				// is player wearing wetsuit
				if (toLower uniform player find "wetsuit" == -1) then {
					if (vectorMagnitude velocity player < 1) then {
						_tempChange = _tempChange + -1;
					}
				}
			} else {
				// player is not in water
				if ()
			}
		}

		not alive player
	}

}

        occludeSoundsWhenIn = 0;
        obstructSoundsWhenIn = 0;
        attenuationEffectType


// bug - after a save is loaded, blowing up one part of a radio transmitter completes the task and the task for any other radio transmitters, and the parent task

// then a further save and load restores the task and destroyed part

// on checking this happens in a fresh game....




// LIST

PUT TENTS ON MAP (clientPostInit)

FIX BUILDINGS

"Land_FuelStation_01_shop_F" Done (not quite fixed - only one door opens)
"Land_School_01_F" - Done (not quite fixed - only one door opens)
"Land_House_Small_04_F" - Done
"Land_Shop_Town_01_F" Done (not quite fixed - only one door opens)
"Land_Shop_Town_03_F" - Done
"Land_House_Small_04_F"

_obs = nearestObjects[position player,["Land_Shop_Town_01_F"],10000]; player setPos getPos (_obs # 0);

- fixed horde_fnc_doorOpen - bit of a bodge, parses the door number out of the string to use on the noSound_source variant (for double doors)

WEAPONS SPAWN AT TENT - Done

CRATE IS TOO HEAVY? - commented out init EH hiding obj from DS

TRY AND MAKE IT CLEARER WHY YOU CANT RESPAWN ANY AFTER DYING IN THE AIR (reviveBleedoutTimer & playerHandleDamage & playerKilled & playerSetBleeding & playerSetNeeds)

FIX BUGGY SPECTATOR

SPAWN HELI SLIGHTLY OUT OF THE HANGAR

SIDEMISSIONS ARE BOAT ONLY

CHECK SIDEMISSION REWARDS!!

TOO MANY INDYS SPAWNING

WHY NO TRG???



////


fire too bright

sound effects for actions

// server (start of error)

2018/09/27, 23:25:54 Server: Object 0:0 not found (message Type_181)
2018/09/27, 23:25:54 Server: Object 0:0 not found (message Type_181)
2018/09/27, 23:25:55 NetServer: trying to send a too large non-guaranteed message (len=1348/1370) to 659358943
2018/09/27, 23:25:55 Message not sent - error 0, message ID = ffffffff, to 659358943 (Horde)

// client corresponding time in rpt

23:25:54 Ref to nonnetwork object 1d64bf78b80# 1704083: campfire_f.p3d REMOTE
23:25:55 Ref to nonnetwork object 1d7de1c4100# 1704087: campfire_f.p3d REMOTE

// server (end lines of error)

2018/09/27, 23:31:39 NetServer: trying to send a too large non-guaranteed message (len=1348/1354) to 324631452
2018/09/27, 23:31:39 Message not sent - error 0, message ID = ffffffff, to 324631452 (Rubberduckie)
2018/09/27, 23:31:39 NetServer: trying to send a too large non-guaranteed message (len=1348/1354) to 659358943
2018/09/27, 23:31:39 Message not sent - error 0, message ID = ffffffff, to 659358943 (Horde)

// client corresponding time in rpt

23:31:35 Client: Object 2:3999 (type Type_93) not found.
23:31:38 Client: Object 2:3999 (type Type_93) not found.
23:31:40 Client: Object 2:3999 (type Type_93) not found.
23:31:40 Setting invalid pitch -6331831187187354100000000000000.0000 for L Bravo 1-6:2 REMOTE

caused by turning out in rhs m113.  Maybe an arma vehicle does this?  Maybe entering a building?

// limit is defined here (as an int with i)
for (int i = 1, limit = 10 * i; i < limit; i++) {
	System.out.println("i: " + i);
	System.out.println("limit: " + limit);
}

