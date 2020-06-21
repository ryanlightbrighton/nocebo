#include "\nocebo\defines\scriptDefines.hpp"
#define diag(a,b) (diag_log format [prefix + "setupDynamicGroupsMenu"" - " + a + ": %1",b])

private _invDisp = getVar(uiNamespace,"ncb_dynamicGroupsMenu");
private _toggleExtOptionsCtrl = _invDisp displayCtrl 2000;
private _extListBoxCtrl = _invDisp displayCtrl 3;
private _extActionButtonCtrl = _invDisp displayCtrl 5;
private _groupNameInputCtrl = _invDisp displayCtrl 7;
private _squadListBoxCtrl = _invDisp displayCtrl 8;
private _squadActionListBoxCtrl = _invDisp displayCtrl 10;
private _squadIconsPictureCtrl = _invDisp displayCtrl 12;
private _squadIconsListBoxCtrl = _invDisp displayCtrl 13;
private _privateStatusCheckBoxCtrl = _invDisp displayCtrl 16;

diag_log format ["setting up menu. %1",_invDisp];

horde_fnc_lbItemSelected = {
	/*_invDisp = getVar(uiNamespace,"ncb_dynamicGroupsMenu");
	_squadListBoxCtrl = _invDisp displayCtrl 8;
	_squadListBoxCtrl lbSetCurSel -1;*/
	// crashes game - stack overflow - lbSetCurSel triggers onLBSelChanged as well so A triggers B, which triggers A etc etc...
	// instead add mouse entered EH to deselect current list box selections
	private _data = (_this select 0) lbData (_this select 1);
	if (isNil "_data") then {
		_data = ""
	};
	diag_log format ["horde_fnc_lbItemSelected: %1",_data];
	(_this select 0) setVariable ["selectedItem",_data]
};
horde_fnc_openDynamicGroupExtMenuGroup = {
	private _invDisp = getVar(uiNamespace,"ncb_dynamicGroupsMenu");
	private _toggleExtOptionsCtrl = _invDisp displayCtrl 2000;
	private _extListBoxCtrl = _invDisp displayCtrl 3;
	private _extActionButtonCtrl = _invDisp displayCtrl 5;
	private _squadListBoxCtrl = _invDisp displayCtrl 8;
	private _squadIconsListBoxCtrl = _invDisp displayCtrl 13;

	_toggleExtOptionsCtrl ctrlSetText "Groups";
	_toggleExtOptionsCtrl ctrlRemoveAllEventHandlers "ButtonDown";
	_toggleExtOptionsCtrl ctrlSetEventHandler [
		"ButtonDown","
			diag_log format ['button down: %1',_this];
			0 call horde_fnc_openDynamicGroupExtMenuPlayer
		"
	];
	// deselect current selection
	/*_extListBoxCtrl lbSetCurSel -1;
	_squadListBoxCtrl lbSetCurSel -1;
	_squadIconsListBoxCtrl lbSetCurSel -1;*/

	// pass selected group to function

	_extActionButtonCtrl ctrlSetText "Join";
	_extActionButtonCtrl ctrlRemoveAllEventHandlers "ButtonDown";
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
	private _invDisp = getVar(uiNamespace,"ncb_dynamicGroupsMenu");
	private _toggleExtOptionsCtrl = _invDisp displayCtrl 2000;
	private _extListBoxCtrl = _invDisp displayCtrl 3;
	private _extActionButtonCtrl = _invDisp displayCtrl 5;
	private _squadListBoxCtrl = _invDisp displayCtrl 8;
	private _squadIconsListBoxCtrl = _invDisp displayCtrl 13;

	_toggleExtOptionsCtrl ctrlSetText "Players";
	_toggleExtOptionsCtrl ctrlRemoveAllEventHandlers "ButtonDown";
	_toggleExtOptionsCtrl ctrlSetEventHandler [
		"ButtonDown","
			call horde_fnc_openDynamicGroupExtMenuInvites
		"
	];
	// deselect current selection
	/*_extListBoxCtrl lbSetCurSel -1;
	_squadListBoxCtrl lbSetCurSel -1;
	_squadIconsListBoxCtrl lbSetCurSel -1;*/
	// pass selected player to function

	_extListBoxCtrl ctrlSetEventHandler [
		"LBSelChanged","
			_this call horde_fnc_lbItemSelected;
			false
		"
	];
	_extActionButtonCtrl ctrlSetText "Invite";
	_extActionButtonCtrl ctrlRemoveAllEventHandlers "ButtonDown";
	_extActionButtonCtrl ctrlSetEventHandler [
		"ButtonDown","
			call horde_fnc_playerSendInvite
		"
	];
};
horde_fnc_openDynamicGroupExtMenuInvites = {
	private _invDisp = getVar(uiNamespace,"ncb_dynamicGroupsMenu");
	private _toggleExtOptionsCtrl = _invDisp displayCtrl 2000;
	private _extListBoxCtrl = _invDisp displayCtrl 3;
	private _extActionButtonCtrl = _invDisp displayCtrl 5;
	private _squadListBoxCtrl = _invDisp displayCtrl 8;
	private _squadIconsListBoxCtrl = _invDisp displayCtrl 13;

	_toggleExtOptionsCtrl ctrlSetText "Invites";
	_toggleExtOptionsCtrl ctrlRemoveAllEventHandlers "ButtonDown";
	_toggleExtOptionsCtrl ctrlSetEventHandler [
		"ButtonDown","
			call horde_fnc_openDynamicGroupExtMenuGroup
		"
	];
	// deselect current selection
	/*_extListBoxCtrl lbSetCurSel -1;
	_squadListBoxCtrl lbSetCurSel -1;
	_squadIconsListBoxCtrl lbSetCurSel -1;*/
	// pass selected group to function
	_extListBoxCtrl ctrlSetEventHandler [
		"LBSelChanged","
			_this call horde_fnc_lbItemSelected;
			false
		"
	];
	_extActionButtonCtrl ctrlSetText "Accept";
	_extActionButtonCtrl ctrlRemoveAllEventHandlers "ButtonDown";
	_extActionButtonCtrl ctrlSetEventHandler [
		"ButtonDown","
			call horde_fnc_playerAcceptInvite
		"
	];
};
// joins group (if not private)
horde_fnc_playerJoinGroup = {
	private _invDisp = getVar(uiNamespace,"ncb_dynamicGroupsMenu");
	private _extListBoxCtrl = _invDisp displayCtrl 3;
	private _groupNew = groupFromNetId (_extListBoxCtrl getVariable ["selectedItem","no group"]);
	if (not isNull _groupNew
		and {not (group player isEqualTo _groupNew)}
		and {not (_groupNew getVariable ["ncb_privateGroup",false])}
		and {(_groupNew getVariable ["ncb_groupBans",[]]) find getPlayerUID player == -1}
	) then {
		player setVariable ["ncb_groupInvites",[]];
		[player,_groupNew] remoteExecCall [
			"horde_fnc_serverConfirmJoinGroup",
			2
		];
	};
};
// sends the invite (leaders only)
horde_fnc_playerSendInvite = {
	private _invDisp = getVar(uiNamespace,"ncb_dynamicGroupsMenu");
	private _extListBoxCtrl = _invDisp displayCtrl 3;
	private _player = objectFromNetId (_extListBoxCtrl getVariable ["selectedItem","no player"]);
	if (not isNull _player and {not (group player isEqualTo group _player)} and {player isEqualTo leader group player}) then {
		// unban if banned
		private _grp = group player;
		private _bans = _grp getVariable ["ncb_groupBans",[]];
		private _banIdx = _bans find (getPlayerUID _player);
		if (_banIdx > -1) then {
			_bans deleteAt _banIdx;
			_grp setVariable ["ncb_groupBans",_bans,true];
		};
		ncb_gv_extContents = [];  // update menu
		// exec
		[group player,name player] remoteExecCall [
			"horde_fnc_playerReceiveInvite",
			_player
		];
	};
};
// adds the invite on other players machine
horde_fnc_playerReceiveInvite = {
	params ["_grp","_name"];
	private _var = player getVariable ["ncb_groupInvites",[]];
	private _idx = _var pushBackUnique _grp;
	_var = _var - [grpNull];
	_var = _var - [group player];
	player setVariable ["ncb_groupInvites",_var];
	if (_idx > -1) then {
		private _text = format [
			"
				<t size='3.2'color='#FFFFFF'align='center'shadow='2'>
				%1 has invited you to join
				<br />
				%2
				</t>
			",
			_name,
			groupID _grp
		];
		_text call horde_fnc_displayActionConfMessage;
	}
};
// accepts invite (even from private group)
horde_fnc_playerAcceptInvite = {
	private _invDisp = getVar(uiNamespace,"ncb_dynamicGroupsMenu");
	private _extListBoxCtrl = _invDisp displayCtrl 3;
	private _groupNew = groupFromNetId (_extListBoxCtrl getVariable ["selectedItem","no group"]);
	if (not isNull _groupNew and {not (group player isEqualTo _groupNew)}) then {
		player setVariable ["ncb_groupInvites",[]];
		[player,_groupNew] remoteExecCall [
			"horde_fnc_serverConfirmJoinGroup",
			2
		]
	}
};
// executes selected squad order
horde_fnc_squadActionSelected = {
	params ["_ctrl","_index"];
	private _data = _ctrl lbData _index;
	private _player = objectFromNetId _data;
	private _action = _ctrl lbText _index;
	private _grp = group player;
	call {
		if (_action == "leave group") exitWith {
			_player remoteExecCall [
				"horde_fnc_serverConfirmLeaveGroup",
				2
			];
			private _text = format [
				"
					<t size='3.2'color='#FFFFFF'align='center'shadow='2'>
					%1 has left the group
					</t>
				",
				name _player
			];
			_text remoteExecCall [
				"horde_fnc_displayActionConfMessage",
				units _grp
			];
			_text = format [
				"
					<t size='3.2'color='#FFFFFF'align='center'shadow='2'>
					You have left %1
					</t>
				",
				groupID _grp
			];
			_text remoteExecCall [
				"horde_fnc_displayActionConfMessage",
				_player
			];
		};
		if (_action == "promote unit") exitWith {
			[group player,_player] call horde_fnc_selectLeaderGlobal;
			private _text = format [
				"
					<t size='3.2'color='#FFFFFF'align='center'shadow='2'>
					%1 has been promoted to group leader
					</t>
				",
				name _player
			];
			_text remoteExecCall [
				"horde_fnc_displayActionConfMessage",
				units _grp
			];
		};
		if (_action == "kick unit") exitWith {
			_player remoteExecCall [
				"horde_fnc_serverConfirmLeaveGroup",
				2
			];
			private _text = format [
				"
					<t size='3.2'color='#FFFFFF'align='center'shadow='2'>
					%1 has been kicked from the group
					</t>
				",
				name _player
			];
			_text remoteExecCall [
				"horde_fnc_displayActionConfMessage",
				units _grp - [_player]
			];
			_text = format [
				"
					<t size='3.2'color='#FFFFFF'align='center'shadow='2'>
					You have been kicked from %1
					</t>
				",
				groupID _grp
			];
			_text remoteExecCall [
				"horde_fnc_displayActionRejMessage",
				_player
			];
		};
		if (_action == "ban unit") exitWith {
			private _bans = _grp getVariable ["ncb_groupBans",[]];
			_bans pushBackUnique (getPlayerUID _player);
			_grp setVariable ["ncb_groupBans",_bans,true];
			_player remoteExecCall [
				"horde_fnc_serverConfirmLeaveGroup",
				2
			];
			private _text = format [
				"
					<t size='3.2'color='#FFFFFF'align='center'shadow='2'>
					%1 has been banned from the group
					</t>
				",
				name _player
			];
			_text remoteExecCall [
				"horde_fnc_displayActionConfMessage",
				units _grp - [_player]
			];
			_text = format [
				"
					<t size='3.2'color='#FFFFFF'align='center'shadow='2'>
					You have been banned from %1
					</t>
				",
				groupID _grp
			];
			_text remoteExecCall [
				"horde_fnc_displayActionRejMessage",
				_player
			];
		};
		if (_action == "CAS Remote Control") exitWith {
			ncb_gv_casPlyrGrpActnRemCtrl remoteExec [
				"horde_fnc_casAddPlayerRemoteControl",
				_player
			];
			removeAllActions ((ncb_gv_casPlyrGrpActnRemCtrl select 0) turretUnit [1]);
			ncb_gv_casPlyrGrpActnRemCtrl = nil;
		};
	};
};








// set up ext (groups/players/invites)

_extListBoxCtrl ctrlSetEventHandler [
	"LBSelChanged","
		_this call horde_fnc_lbItemSelected;
		false
	"
];

// paste the unit insignia into the listbox (remember this is setting up the dialog)
{

	private _index = _squadIconsListBoxCtrl lbAdd (getText(_x >> "displayName"));
	_squadIconsListBoxCtrl lbSetPicture [_index,getText(_x >> "texture")];
	_squadIconsListBoxCtrl lbSetData [_index,configName _x];
	_squadIconsListBoxCtrl lbSetValue [_index,_index];
} forEach ncb_gv_unitInsigniaCfgs;

// https://community.bistudio.com/wiki/Arma_3_Unit_Insignia
_squadIconsListBoxCtrl ctrlSetEventHandler [
	"LBSelChanged","
		private _data = (_this select 0) lbData (_this select 1);
		if (not isNil {_data} and {_data != ''}) then {
			private _tex = '';
			if (isClass (configFile >> 'CfgUnitInsignia' >> _data)) then {
				_tex = getText (configFile >> 'CfgUnitInsignia' >> _data >> 'texture');
			} else {
				_tex = getText (missionConfigFile >> 'CfgUnitInsignia' >> _data >> 'texture');
			};
			if (group player getVariable ['ncb_groupInsignia',''] != _tex) then {
				{
					[_x,_data] call BIS_fnc_setUnitInsignia
				} forEach units group player;
				diag_log format ['insignia changed: %1',_tex];
				group player setVariable ['ncb_groupInsignia',_tex,true]
			}
		};
		false
	"
];

_privateStatusCheckBoxCtrl ctrlSetEventHandler [
	"CheckedChanged","
		if (_this select 1 == 1) then {
			group player setVariable ['ncb_privateGroup',true,true]
		} else {
			group player setVariable ['ncb_privateGroup',false,true]
		};
		false
	"
];

if (leader group player isEqualTo player) then {
	_groupNameInputCtrl ctrlSetText groupID group player;
};

// force repopulation of ext listbox by setting ncb_gv_extContents to empty array
_groupNameInputCtrl ctrlSetEventHandler [
	"KeyDown","
		if ((_this select 1) in [28,156]) then {
			group player setGroupIDGlobal [ctrlText (_this select 0)];
			ncb_gv_extContents = [];
			false
		}
	"
];

// squad listbox
_squadListBoxCtrl ctrlSetEventHandler [
	"LBSelChanged","
		_this call horde_fnc_lbItemSelected;
		false
	"
];

// squad actions listbox
_squadActionListBoxCtrl ctrlSetEventHandler [
	"LBSelChanged","
		_this call horde_fnc_squadActionSelected;
		false
	"
];

call horde_fnc_openDynamicGroupExtMenuGroup;

/// NOTE:  CHANGE CODE TO allPlayers and isPlayer - just testing with AI at the moment
// lines 466 and 499-503
// need a loop to run over all the controls and update accordingly (picture,listboxes,group name etc)
// use shitty loops for now - change to EachFrame When done

// NOTE:  NEED TO CONVERT BAN SYSTEM OVER TO UID!!! <ncb_groupBans> getPlayerUID _player (also do not need to remove objNull now as it will be all strings )

0 spawn {
	disableSerialization;
	private _invDisp = getVar(uiNamespace,"ncb_dynamicGroupsMenu");
	private _toggleExtOptionsCtrl = _invDisp displayCtrl 2000;
	private _extListBoxCtrl = _invDisp displayCtrl 3;
	private _extActionButtonCtrl = _invDisp displayCtrl 5;
	private _groupNameInputCtrl = _invDisp displayCtrl 7;
	private _squadListBoxCtrl = _invDisp displayCtrl 8;
	private _squadActionListBoxCtrl = _invDisp displayCtrl 10;
	private _squadIconsPictureCtrl = _invDisp displayCtrl 12;
	private _squadIconsListBoxCtrl = _invDisp displayCtrl 13;
	private _privateStatusCheckBoxCtrl = _invDisp displayCtrl 16;

	ncb_gv_extContents = [];
	private _squadContents = [];
	waitUntil {
		//////////////////////////////////////////////////////
		//////////////////////////////////////////////////////
		//////////////////////////////////////////////////////
		systemChat format ["time: %1", time];

		private _isLeader = leader group player isEqualTo player;

		// update listbox

		call {
			private _text = ctrlText _toggleExtOptionsCtrl;
			if (_text == "groups") exitWith {
				private _groups = [];
				{
					if (side _x isEqualTo west
						and {alive _x and {isPlayer _x}} count units _x > 0 // <== changed this line (added isPlayer check)
					) then {
						_groups pushBack _x
					}
				} forEach allGroups;
				// only repopulate if changed
				private _repopulate = false;
				if not (ncb_gv_extContents isEqualTo _groups) then {
					_repopulate = true;
					lbClear _extListBoxCtrl;
					ncb_gv_extContents = _groups
				};
				{
					private _index = _forEachIndex;
					if (_repopulate) then {
						_index = _extListBoxCtrl lbAdd groupID _x;
					};

					private _tooltip = "Group Members:" + endl;
					{
						_tooltip = _tooltip + (name _x) + endl;
						nil
					} count units _x;
					_extListBoxCtrl lbSetColor [_index,if (_x getVariable ["ncb_privateGroup",false]) then {[1,0,0,0.5]} else {[0,1,0,0.5]}];
					_extListBoxCtrl lbSetPicture [_index,_x getVariable ["ncb_groupInsignia","\A3\Ui_f\data\GUI\Cfg\UnitInsignia\111thID_ca.paa"]];
					_extListBoxCtrl lbSetTooltip [_index,_tooltip];
					_extListBoxCtrl lbSetData [_index,netID _x];
					_extListBoxCtrl lbSetValue [_index,_index];
				} forEach _groups
			};
			if (_text == "players") exitWith {
				private _players = [];
				{
					if (side _x isEqualTo west) then {
						_players pushBack _x
					}
				} forEach allPlayers; // <== changed this from allUnits
				// only repopulate if changed
				private _repopulate = false;
				if not (ncb_gv_extContents isEqualTo _players) then {
					_repopulate = true;
					lbClear _extListBoxCtrl;
					ncb_gv_extContents = _players
				};
				{
					private _index = _forEachIndex;
					if (_repopulate) then {
						_index = _extListBoxCtrl lbAdd name _x;
					};
					_extListBoxCtrl lbSetPicture [_index,group _x getVariable ["ncb_groupInsignia","\A3\Ui_f\data\GUI\Cfg\UnitInsignia\111thID_ca.paa"]];
					if (getPlayerUID _x in (group player getVariable ["ncb_groupBans",[]])) then {
						_extListBoxCtrl lbSetColor [_index,[1,0,0,0.5]];
						_extListBoxCtrl lbSetTooltip [_index,"Banished!"];
					} else {
						if (group player == group _x) then {
							_extListBoxCtrl lbSetColor [_index,[0,1,0,0.5]];
							_extListBoxCtrl lbSetTooltip [_index,"Group" + endl + "member"];
						} else {
							_extListBoxCtrl lbSetColor [_index,[1,1,1,0.5]];
							_extListBoxCtrl lbSetTooltip [_index,""];
						}

					};

					_extListBoxCtrl lbSetData [_index,netID _x];
					_extListBoxCtrl lbSetValue [_index,_index];
				} forEach _players;
			};
			if (_text == "invites") exitWith {
				private _invites = [];
				{
					if (not isNull _x and {not (group player isEqualTo _x)}) then {
						_invites pushBack _x
					}
				} forEach (player getVariable ["ncb_groupInvites",[]]);
				// only repopulate if changed
				private _repopulate = false;
				if not (ncb_gv_extContents isEqualTo _invites) then {
					_repopulate = true;
					lbClear _extListBoxCtrl;
					ncb_gv_extContents = _invites
				};
				{
					private _index = _forEachIndex;
					if (_repopulate) then {
						_index = _extListBoxCtrl lbAdd groupID _x;
					};
					_extListBoxCtrl lbSetPicture [_index,_x getVariable ["ncb_groupInsignia","\A3\Ui_f\data\GUI\Cfg\UnitInsignia\111thID_ca.paa"]];;
					_extListBoxCtrl lbSetColor [_index,[1,1,1,0.5]];
					_extListBoxCtrl lbSetData [_index,netID _x];
					_extListBoxCtrl lbSetValue [_index,_index];
				} forEach _invites;
			};
			lbClear _extListBoxCtrl; // default
		};

		// squad icon

		if (_isLeader) then {
			if not (ctrlShown _squadIconsListBoxCtrl) then {
				_squadIconsListBoxCtrl ctrlShow true
			};
		} else {
			if (ctrlShown _squadIconsListBoxCtrl) then {
				_squadIconsListBoxCtrl ctrlShow false
			};
			private _squadInsignia = group player getVariable ["ncb_groupInsignia","\A3\Ui_f\data\GUI\Cfg\UnitInsignia\111thID_ca.paa"];
			if (ctrlText _squadIconsPictureCtrl != _squadInsignia) then {
				_squadIconsPictureCtrl ctrlSetText _squadInsignia
			};
		};

		// private status checkbox

		private _privateGroup = group player getVariable ["ncb_privateGroup",false];
		if (_privateGroup) then {
			if not (cbChecked _privateStatusCheckBoxCtrl) then {
				_privateStatusCheckBoxCtrl cbSetChecked true
			}
		} else {
			if (cbChecked _privateStatusCheckBoxCtrl) then {
				_privateStatusCheckBoxCtrl cbSetChecked false
			}
		};


		if (_isLeader) then {
			if not (ctrlEnabled _privateStatusCheckBoxCtrl) then {
				_privateStatusCheckBoxCtrl ctrlEnable true
			}
		} else {
			if (ctrlEnabled _privateStatusCheckBoxCtrl) then {
				_privateStatusCheckBoxCtrl ctrlEnable false
			}
		};

		// group name controls

		// _groupNameTextCtrl - not needed

		if (_isLeader) then {
			if not (ctrlEnabled _groupNameInputCtrl) then {
				_groupNameInputCtrl ctrlEnable true
			}
		} else {
			if (ctrlEnabled _groupNameInputCtrl) then {
				_groupNameInputCtrl ctrlEnable false
			};
			if (ctrlText _groupNameInputCtrl != groupID group player) then {
				_groupNameInputCtrl ctrlSetText groupID group player
			}
		};

		// _squadListBoxCtrl

		private _players = units group player;
		// only repopulate if changed
		private _repopulate = false;
		if not (_squadContents isEqualTo _players) then {
			_repopulate = true;
			lbClear _squadListBoxCtrl;
			_squadContents = _players
		};
		{
			private _index = _forEachIndex;
			if (_repopulate) then {
				_index = _squadListBoxCtrl lbAdd name _x;
			};
			_squadListBoxCtrl lbSetPicture [_index,if (lifeState _x == "healthy") then {"\nocebo\images\led_green.paa"} else {"\nocebo\images\led_red.paa"}];
			_squadListBoxCtrl lbSetColor [_index,[1,1,1,0.5]];
			_squadListBoxCtrl lbSetData [_index,netID _x];
			_squadListBoxCtrl lbSetValue [_index,_index];
		} forEach _players;

		// _squadActionListBoxCtrl

		// followers + leader
		// leave group

		// leader only
		// promote unit
		// kick unit
		// ban unit

		lbClear _squadActionListBoxCtrl;
		private _player = objectFromNetId (_squadListBoxCtrl getVariable ["selectedItem",""]);
		if not (isNull _player) then {
			if (count units player > 1) then {
				if (group player isEqualTo (group _player)) then {
					if (_player isEqualTo player) then {
						// leave group option
						private _tooltip = "Leave group:" + endl + "All of your tents"+ endl + "come with you";
						private _index = _squadActionListBoxCtrl lbAdd "Leave group";
						_squadActionListBoxCtrl lbSetPicture [_index,""];
						_squadActionListBoxCtrl lbSetColor [_index,[1,1,1,0.5]];
						_squadActionListBoxCtrl lbSetData [_index,netID _player];
						_squadActionListBoxCtrl lbSetTooltip [_index,_tooltip];
						_squadActionListBoxCtrl lbSetValue [_index,_index];
					} else {
						if (not isNil "ncb_gv_casPlyrGrpActnRemCtrl"
							and {lifeState _player != "incapacitated"}
						) then {
							// CAS Remote Control option
							private _tooltip = format["Add %1 as r/c gunner:",name _player] + endl + format["%1",name _player] + endl + "will join you immediately" + endl + "as second gunner";
							private _index = _squadActionListBoxCtrl lbAdd "CAS Remote Control";
							_squadActionListBoxCtrl lbSetPicture [_index,""];
							_squadActionListBoxCtrl lbSetColor [_index,[1,1,1,0.5]];
							_squadActionListBoxCtrl lbSetData [_index,netID _player];
							_squadActionListBoxCtrl lbSetTooltip [_index,_tooltip];
							_squadActionListBoxCtrl lbSetValue [_index,_index];
						};
						if (_isLeader) then {
							// promote option
							/*_tooltip = "Promote unit:" + endl + "Make this player"+ endl + "become group leader";*/
							private _tooltip = format["Promote %1:",name _player] + endl + format["Make %1",name _player] + endl + "become group leader";
							private _index = _squadActionListBoxCtrl lbAdd "Promote unit";
							_squadActionListBoxCtrl lbSetPicture [_index,""];
							_squadActionListBoxCtrl lbSetColor [_index,[1,1,1,0.5]];
							_squadActionListBoxCtrl lbSetData [_index,netID _player];
							_squadActionListBoxCtrl lbSetTooltip [_index,_tooltip];
							_squadActionListBoxCtrl lbSetValue [_index,_index];
							// kick option
							/*_tooltip = "Kick unit:" + endl + "Player will leave group"+ endl + "but can come back";*/
							private _tooltip = format["Kick %1:",name _player] + endl + format["%1 will leave group",name _player] + endl + "but can come back";
							private _index = _squadActionListBoxCtrl lbAdd "Kick unit";
							_squadActionListBoxCtrl lbSetPicture [_index,""];
							_squadActionListBoxCtrl lbSetColor [_index,[1,1,1,0.5]];
							_squadActionListBoxCtrl lbSetData [_index,netID _player];
							_squadActionListBoxCtrl lbSetTooltip [_index,_tooltip];
							_squadActionListBoxCtrl lbSetValue [_index,_index];
							// ban option
							/*_tooltip = "Ban unit:" + endl + "Can only return if invited"+ endl + "or unbanned";*/
							private _tooltip = format["Ban %1:",name _player] + endl + "Banishment!"+ endl + "Can only return if invited";
							private _index = _squadActionListBoxCtrl lbAdd "Ban unit";
							_squadActionListBoxCtrl lbSetPicture [_index,""];
							_squadActionListBoxCtrl lbSetColor [_index,[1,1,1,0.5]];
							_squadActionListBoxCtrl lbSetData [_index,netID _player];
							_squadActionListBoxCtrl lbSetTooltip [_index,_tooltip];
							_squadActionListBoxCtrl lbSetValue [_index,_index];
						}
					}
				}
			} else {
				// no option
				private _tooltip = "No options" + endl + "for lone units";
				private _index = _squadActionListBoxCtrl lbAdd "No options";
				_squadActionListBoxCtrl lbSetPicture [_index,""];
				_squadActionListBoxCtrl lbSetColor [_index,[1,1,1,0.5]];
				_squadActionListBoxCtrl lbSetData [_index,""];
				_squadActionListBoxCtrl lbSetTooltip [_index,_tooltip];
				_squadActionListBoxCtrl lbSetValue [_index,_index];
			}
		};

		//////////////////////////////////////////////////////
		//////////////////////////////////////////////////////
		//////////////////////////////////////////////////////
		not dialog
		or {not (toLower lifeState player in ["healthy","injured"])}
		or {not alive player}
		or {not ("ItemRadio" in (assignedItems player))}
	};
};