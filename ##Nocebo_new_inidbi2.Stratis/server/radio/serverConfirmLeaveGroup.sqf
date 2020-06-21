#include "\nocebo\defines\scriptDefines.hpp"

// player to remove is _this

if not (isNull _this) then {
	private _origGrp = group _this;
	private _grp = createGroup west;
	[
		[_this,_grp],{
			call horde_fnc_getEachFrameArgs params ["_unit","_grp"];
			if not (isNull _grp) then {
				[_unit] joinSilent _grp;
				private _markers = [];
				private _ncb_gv_playerTentList = missionNamespace getVariable ["ncb_gv_playerTentList",[]];
				diag(_ncb_gv_playerTentList);
				{
					private _tent = _x;
					if (!isNil {_tent} and {! isNull _tent} and {alive _tent}) then {
						_details = _tent getVariable ["tentOwnerDetails",[]];
						if not (_details isEqualTo []) then {
							_details params ["_ownerUID","_mkr"];
							{
								if (getPlayerUID _x == _ownerUID
									and {_mkr find "respawn_west_tent_group" > -1}
								) exitWith {
									_markers pushBack [_tent,_mkr];
								};
							} forEach units _grp;
						} else {
							diag_log "tent had no 'tentOwnerDetails' and was deleted - why is this?";
							diag(_tent);
							deleteVehicle _tent;
						};
					};
				} forEach getVarDef(missionNamespace,"ncb_gv_playerTentList",[]);


				_markers remoteExecCall [
					"horde_fnc_playerAddGroupTentMarkers",
					units _grp
				];
				// remove non-group respawn markers from players machines
				true remoteExecCall [
					"horde_fnc_playerRemoveNonGroupTentMarkers",
					0
				];
				call horde_fnc_removeEachFrame
			}
		},
		0
	] call horde_fnc_addEachFrame;
};

true
