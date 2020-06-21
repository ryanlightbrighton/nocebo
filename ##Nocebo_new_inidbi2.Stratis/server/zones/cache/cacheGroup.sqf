#include "\nocebo\defines\scriptDefines.hpp"

// caches units and deletes group (called from server)

private _vehicles = [];

{
	if not (isNull _x) then {
		if (alive _x) then {
			[_x,false] call horde_fnc_allowDamageGlobal;
			private _veh = vehicle _x;
			if diff(_veh,_x) then {
				// account for getout eh on vehicle
				if (_vehicles pushBackUnique _veh > -1) then {
					_veh removeAllEventHandlers "getout";
				};
				unassignVehicle _x;
				moveOut _x;
			};
			_x setDamage 0;
			private _poolVarName = "";
			private _pos = [0,0,0];
			call {
				if ((typeOf _x) in ncb_gv_enemyUnitTypes) exitWith {
					_poolVarName = "ncb_gv_enemyUnitPool";
					_pos = ncb_gv_enemyUnitPoolPos;
				};
				if ((typeOf _x) in ncb_gv_enemySniperTypes) exitWith {
					_poolVarName = "ncb_gv_enemySniperPool";
					_pos = ncb_gv_enemySniperPoolPos;
				};
				if ((typeOf _x) in ncb_gv_enemyParaTypes) exitWith {
					_poolVarName = "ncb_gv_enemyParaPool";
					_pos = ncb_gv_enemyParaPoolPos;
				};
				if ((typeOf _x) in ncb_gv_enemyDiverTypes) exitWith {
					_poolVarName = "ncb_gv_enemyDiverPool";
					_pos = ncb_gv_enemyDiverPoolPos;
				};
				if ((typeOf _x) in ncb_gv_renegadeTypes) exitWith {
					_poolVarName = "ncb_gv_renegadePool";
					_pos = ncb_gv_renegadePoolPos;
				};
			};
			getVar(missionNamespace,_poolVarName) pushBack _x;
			if (rating _x < 5000) then {
				[_x,5000] call horde_fnc_setUnitRatingGlobal;
			};
			[_x] joinSilent group unitPoolGuy;
			/*[_x,"checkVisible"] remoteExecCall ["disableAI",2];*/
			_x disableAI "checkVisible"; // not sure if this works - test it!!!
			_x setPosASL _pos;
			_x enableSimulationGlobal false;
			_x hideObjectGlobal true;
		} else {
			deleteVehicle _x
		};
	};
	true
} count units _this;
_this call horde_fnc_deleteGroupGlobal;

true

