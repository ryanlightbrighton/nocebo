#include "\nocebo\defines\scriptDefines.hpp"

// ran on server

[
	[_this],{
		call horde_fnc_getEachFrameArgs params ["_body"];
		// add body to queue
		_body setVariable ["deadDeleteTime",(round time) + ncb_param_removeDeadTimeout];
		_body removeAllEventHandlers "take";
		private _loadout = _body getVariable "loadout";
		// add new unit to pool
		private _unit = group unitPoolGuy createUnit [typeOf _body,createUnitPos,[],0,"can_collide"];
		// wait
		[
			[_unit,_loadout],
			{
				call horde_fnc_getEachFrameArgs params ["_unit","_loadout"];
				if not (isNull _unit) then {
					private _type = typeOf _unit;
					private _poolVarName = "";
					private _pos = [0,0,0];
					call {
						if (_type in ncb_gv_enemyUnitTypes) exitWith {
							_poolVarName = "ncb_gv_enemyUnitPool";
							_pos = ncb_gv_enemyUnitPoolPos;
							[_unit,_loadout] call horde_fnc_enemyCopyEquip
						};
						if (_type in ncb_gv_enemyParaTypes) exitWith {
							_poolVarName = "ncb_gv_enemyParaPool";
							_pos = ncb_gv_enemyParaPoolPos;
							[_unit,_loadout] call horde_fnc_enemyCopyEquip
						};
						if (_type in ncb_gv_enemySniperTypes) exitWith {
							_poolVarName = "ncb_gv_enemySniperPool";
							_pos = ncb_gv_enemySniperPoolPos;
							[_unit,_loadout] call horde_fnc_enemyCopyEquip
						};
						if (_type in ncb_gv_enemyDiverTypes) exitWith {
							_poolVarName = "ncb_gv_enemyDiverPool";
							_pos = ncb_gv_enemyDiverPoolPos;
							[_unit,_loadout] call horde_fnc_enemyCopyEquip
						};
						if (_type in ncb_gv_renegadeTypes) exitWith {
							_poolVarName = "ncb_gv_renegadePool";
							_pos = ncb_gv_renegadePoolPos;
							[_unit,_loadout] call horde_fnc_enemyCopyEquip
						};
					};
					_unit setVariable ["loadout",_loadout];
					[_unit,false] call horde_fnc_allowDamageGlobal;
					_unit setPosASL _pos;
					_unit enableSimulationGlobal false;
					_unit hideObjectGlobal true;
					getVar(missionNamespace,_poolVarName) pushBack _unit;
					_unit addEventHandler ["take", {
						_this call horde_fnc_unitTake
					}];
					call horde_fnc_removeEachFrame
				}
			},
			0.001
		] call horde_fnc_updateEachFrame
	},
	(random 10) + 2
] call horde_fnc_addEachFrame;

true