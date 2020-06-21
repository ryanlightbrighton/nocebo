#include "\nocebo\defines\scriptDefines.hpp"

params ["_unit","_newGrp"];

private _oldGrp = group _unit;
// now check if he is the only unit in his group.  If so, then bring his tents over as well.
private _deleteThisGroup = false;
if (count units _oldGrp == 1) then {
	_deleteThisGroup = true;
};
/*[_unit] joinSilent _newGrp;*/
[[_unit],_newGrp] call horde_fnc_joinSilentGlobal;

// wait until unit is in new group

[
	[_deleteThisGroup,_oldGrp,_unit,_newGrp],{
		call horde_fnc_getEachFrameArgs params ["_deleteThisGroup","_oldGrp","_unit","_newGrp"];
		if (group _unit isEqualTo _newGrp) then {
			if (_deleteThisGroup) then {
				if (not isNull _oldGrp) then {
					_oldGrp call horde_fnc_deleteGroupGlobal;
				};
			};

			// also need to add joining units tents to group and all their tents to his machine.

			// find all the markers related to this group on the server
			// then send them to the group members and they sort loccally.

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
						} forEach units _newGrp;
					} else {
						diag_log "tent had no 'tentOwnerDetails' and was deleted - why is this?";
						diag(_tent);
						deleteVehicle _tent;
					};
				};
			} forEach getVarDef(missionNamespace,"ncb_gv_playerTentList",[]);


			_markers remoteExecCall [
				"horde_fnc_playerAddGroupTentMarkers",
				units _newGrp
			];

			// now delete markers that shouldn't be there on all machines

			true remoteExecCall [
				"horde_fnc_playerRemoveNonGroupTentMarkers",
				0
			];
			call horde_fnc_removeEachFrame
		}
	},
	0
] call horde_fnc_addEachFrame;

true


















/*if (_deleteThisGroup) then {
	if (not isNull _oldGrp) then {
		_oldGrp call horde_fnc_deleteGroupGlobal;
	};
};

// also need to add joining units tents to group and all their tents to his machine.

// find all the markers related to this group on the server
// then send them to the group members and they sort loccally.

private _markers = [];
{
	private _tent = _x;
	if not (isNull _tent
		and {alive _tent}
	) then {
		private _details = getVar(_tent,"tentOwnerDetails",[]);
		if not (empty(_details)) then {
			_details params ["_ownerUID","_mkr"];
			{
				if (getPlayerUID _x == _ownerUID
					and {_mkr find "respawn_west_tent_group" > -1}
				) exitWith {
					_markers pushBack [_tent,_mkr];
				};
			} forEach units _newGrp;
		} else {
			diag_log "tent had no 'tentOwnerDetails' and was deleted - why is this?";
			diag(,_tent);
			deleteVehicle _tent;
		};
	};
} forEach getVarDef(missionNamespace,"ncb_gv_playerTentList",[]);


_markers remoteExecCall [
	"horde_fnc_playerAddGroupTentMarkers",
	units _newGrp
];

// now delete markers that shouldn't be there on all machines

true remoteExecCall [
	"horde_fnc_playerRemoveNonGroupTentMarkers",
	0
];

true*/
