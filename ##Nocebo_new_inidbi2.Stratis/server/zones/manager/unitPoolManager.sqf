#include "\nocebo\defines\scriptDefines.hpp"
#define zeroHighPos [0,0,1500]

// build up pools of units

private _grp = group unitPoolGuy;

ncb_gv_renegadePool = [];
ncb_gv_enemyUnitPool = [];
ncb_gv_enemySniperPool = [];
ncb_gv_enemyParaPool = [];
ncb_gv_enemyDiverPool = [];

ncb_gv_renegadePoolPos = [1000,0,10];
ncb_gv_enemyUnitPoolPos = [0,0,10];
ncb_gv_enemySniperPoolPos = [0,0,20];
ncb_gv_enemyParaPoolPos = [0,0,30];
ncb_gv_enemyDiverPoolPos = [0,0,50];

{

	private _qty = sel(_x,1);

	for "_i" from 1 to _qty do {
		private _data = call getVar(missionNamespace,sel(_x,0));
		private _poolVarName = sel2(_data,0,0);
		private _pos = sel2(_data,0,1);
		private _types = sel2(_data,0,2);
		private _type = selectRandom _types;
		private _unit = spawnUnit(_grp,_type,createUnitPos);
		_unit allowDamage false;
		_unit setPosASL _pos;
		_unit enableSimulationGlobal false;
		_unit hideObjectGlobal true;

		getVar(missionNamespace,_poolVarName) pushBack _unit;
		_unit addEventHandler ["take", {
			_this call horde_fnc_unitTake
		}];
		_data set [0,_unit];
		_data call horde_fnc_enemyEquip;
		_unit setVariable ["loadout",getUnitLoadout _unit];
	};
	true
} count [
	["ncb_gv_enemyUnitVariables",200],
	["ncb_gv_enemySniperVariables",100],
	["ncb_gv_enemyParaVariables",70],
	["ncb_gv_enemyDiverVariables",70],
	["ncb_gv_renegadeVariables",100]
];


true