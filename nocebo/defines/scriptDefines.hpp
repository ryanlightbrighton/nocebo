// params

#define ind0 ""
#define ind1 "	"
#define ind2 "		"
#define ind3 "			"
#define ind4 "				"
#define ind5 "					"
#define ind6 "						"
#define ind7 "							"
#define ind8 "								"
#define ind9 "									"
#define ind10 "										"

#define qty_2(a) a, a
#define qty_3(a) a, a, a
#define qty_4(a) a, a, a, a
#define qty_5(a) a, a, a, a, a
#define qty_6(a) a, a, a, a, a, a
#define qty_7(a) a, a, a, a, a, a, a
#define qty_8(a) a, a, a, a, a, a, a, a
#define qty_9(a) a, a, a, a, a, a, a, a, a
#define qty_10(a) a, a, a, a, a, a, a, a, a, a
#define qty_11(a) a, a, a, a, a, a, a, a, a, a, a
#define qty_12(a) a, a, a, a, a, a, a, a, a, a, a, a

// #define PREFIX myPrefix
// #define VARNAME(NAME) PREFIX##_##NAME
// #define GET(OBJECT,VNAM) ( OBJECT getVariable [#VARNAME(VNAM),nil] )
// #define TEST(A) GET(B,test)
// systemChat TEST(player);

#define prefix "horde_fnc_"

#define empty(a) (a isEqualTo [])
#define same(a,b) (a isEqualTo b)
#define diff(a,b) (not same(a,b))
#define sel(a,b) (a select b)
#define sel2(a,b,c) (a select b select c)
#define rand(a) (selectRandom a)
#define setVarShareWithServer(a,b,c) ([a,b,c] call horde_fnc_setAndShareVariableWithServer)
#define addEH(a,b,c) (a addEventHandler [b, {_this call c}])
#define setVarPlc(a,b,c) (a setVariable [b,c,true])
#define setVar(a,b,c) (a setVariable [b,c])
#define getVar(a,b) (a getVariable b)
#define getVarDef(a,b,c) (a getVariable [b,c])
#define spawnUnit(a,b,c) (a createUnit [b,c,[],0,"CAN_COLLIDE"])
#define spawnVeh(a,b) (createVehicle [a,b,[],0,"CAN_COLLIDE"])
#define players (playableUnits + switchableUnits)
#define playerIsNear(a,b) ([a,b] call horde_fnc_playerIsNear)
#define spawnDelay \
linearConversion [ \
	ncb_gv_spawnMinFps, \
	ncb_gv_spawnMaxFps, \
	diag_fps, \
	ncb_gv_spawnMaxDelay, \
	ncb_gv_spawnMinDelay, \
	true \
]

#define randomEnemySide (selectRandom [east,independent])
#define getEachFrameArgs call horde_fnc_getEachFrameArgs params
#define removeEachFrame call horde_fnc_removeEachFrame
#define updateEachFrameArgs(a) a call horde_fnc_updateEachFrameArgs

#define comp(a) compileFinal preProcessFileLineNumbers a
#define cfgVeh (configFile >> "CfgVehicles")
#define cfgWeap (configFile >> "CfgWeapons")
#define cfgMag (configFile >> "CfgMagazines")
#define cfgAmmo (configFile >> "CfgAmmo")
#define cfgZ (configFile >> "CfgZones")
// #define randInteg(a,b) (floor random (b - a)) + a + 1
// #define randInteg(a,b) (floor random (if (a == 0) then {b + 1} else {b}) + a)
#define randInteg(a,b) ([a,b] call horde_fnc_randomInteger)
#define aliveCrewCount(a) {alive _x} count crew a
#define aliveUnitsCount(a) {alive _x} count units a
#define zeroPos [0,0,0]
#define createUnitPos [100,100,100]
#define createObjectPos [200,200,200]
#define zeroHighPos [0,0,1500]

// database

#define createZoneConfig 0
#define startNewGame 1
#define loadPersistentGame 2

#define testMarker(a,b,c) \
private _tqx = createMarker [format ["%1",a],b]; \
_tqx setMarkerSize [1, 1]; \
_tqx setMarkerType "hd_dot"; \
_tqx setMarkerColor "colorBlack"; \
_tqx setMarkerAlpha 1; \
_tqx setMarkerText format ["%1", c]

#define diag(a) \
private _jkl = toArray str {a}; \
_jkl deleteAt count _jkl -1; \
_jkl deleteAt 0; \
private _lzx = __FILE__ splitString "\."; \
_lzx = _lzx select (count _lzx -2); \
diag_log format [_lzx + " " + toString _jkl + ": %1",a]

/*
	EXAMPLES

	testMarker(
		name (any data type) - must be unique,
		position (array),
		text (any data type)
	);

	0 s-p-a-w-n {
		sleep 3;
		if diff(player,0) then {
			player sideChat "diff!";
		};
	};

	0 s-p-a-w-n {
		sleep 5;
		if same(sel(getPos player,0),sel(getPos player,0)) then {
			player sideChat "val is same!";
		};
	};

	0 s-p-a-w-n {
		sleep 3.1;
		_numb = 0;
		for "_i" from 1 to 10 do {
			_numb = _numb + 90;
			player globalChat format ["%1",_numb]
		};
	};

*/


/*
macros vs local variables

0 = ["
	_v = configFile >> 'CfgVehicles';
	for '_i' from 0 to 400 do {
		_entry = _v select _i
	};
"] call bis_fnc_codePerformance;

0.97251

0 = ["
	for '_i' from 0 to 400 do {
		_entry = (configFile >> 'CfgVehicles') select _i
	};
"] call bis_fnc_codePerformance;

1.65142


*/
