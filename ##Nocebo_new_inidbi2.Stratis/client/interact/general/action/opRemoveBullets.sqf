#include "\nocebo\defines\scriptDefines.hpp"

params ["_medic","_injured","_bullets","_stage","_item"];

call {
	if (_stage == "REQUEST") exitWith {
		[_medic,_injured,ncb_gv_playerLodgedBullets,"REPLY",_item] remoteExec [
		 	"horde_fnc_opRemoveBullets",
			_medic
		];
	};
	if (_stage == "REPLY") exitWith {
		if (_bullets > 0) then {
			setVar(missionNamespace,"playerPerformingAction","IN_PROGRESS");
			[player,false] call horde_fnc_selectActionAnim;
			sleep 0.5;
			/*[player,"CfgWeapons",_item] call horde_fnc_broadcastActionSound;*/
			private _idx = player addEventHandler ["AnimDone",{
				if (sel(_this,1) == getVar(missionNamespace,"playerActionAnim")) then {
					setVar(missionNamespace,"playerPerformingAction","FINISHED")
				};
			}];
			private _frameHandlerID = (findDisplay 46) displayAddEventHandler ["KeyDown",{
				_this call horde_fnc_abortAction
			}];

			// spawn items around player

			private _actionItems = ["medical",_item] call horde_fnc_spawnActionItems;

			private _actionArgs = getVar(missionNamespace,"NETWORK_ACTION_ARGS");
			private _conditions = sel(_actionArgs,2);
			_conditions set [0,["not isNil {missionNamespace getVariable 'playerPerformingAction'}",""]];
			_conditions set [1,["missionNamespace getVariable 'playerPerformingAction' == 'IN_PROGRESS'",""]];
			_actionArgs set [2,_conditions];

			private _playerDir = getDir player;
			waitUntil {
				if diff(getDir player,_playerDir) then {
					player setDir _playerDir
				};
				private _proceed = _actionArgs call horde_fnc_testInteractionConditions;
				if (
					not _proceed
					and {diff(getVar(missionNamespace,"playerPerformingAction"),"ABORTED")}
					and {diff(getVar(missionNamespace,"playerPerformingAction"),"FINISHED")}
				) then {
					0 call horde_fnc_resetAnims
				};
				not _proceed
			};

			player removeEventHandler ["AnimDone",_idx];
			(findDisplay 46) displayRemoveEventHandler ["KeyDown",_frameHandlerID];

			_conditions set [0,["not isNil {missionNamespace getVariable 'playerPerformingAction'}",""]];
			_conditions set [1,["missionNamespace getVariable 'playerPerformingAction' == 'FINISHED'","Action aborted"]];
			_actionArgs set [2,_conditions];

			if (_actionArgs call horde_fnc_testInteractionConditions) then {
				[_medic,_injured,_bullets,"ACTION",_item] remoteExec [
				 	"horde_fnc_opRemoveBullets",
					_injured
				];
				private _string = "a bullet";
				if (_bullets > 1) then {
					_string = format ["%1 bullets",_bullets];
				};
				private _text = format [
					"
						<t size='3.2'color='#FFFFFF'align='center'shadow='2'>
						You removed %2 from %1.
						</t>
					",
					name _injured,
					_string
				];
				_text call horde_fnc_displayActionConfMessage;
			};
			{
				deleteVehicle _x
			} count _actionItems;
			setVar(missionNamespace,"playerPerformingAction",nil);
		} else {
			// fail message
			private _text = format [
				"
					<t size='3.2'color='#FF0000'align='center'shadow='2'>
					%1 has not got any bullets lodged in their body.
					</t>
				",
				name _injured
			];
			_text call horde_fnc_displayActionRejMessage;
		};
	};
	if (_stage == "ACTION") exitWith {
		ncb_gv_playerLodgedBullets = 0;
	};
};

true

