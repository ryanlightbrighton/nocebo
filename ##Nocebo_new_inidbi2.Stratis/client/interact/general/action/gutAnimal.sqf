#include "\nocebo\defines\scriptDefines.hpp"

closeDialog 0;
getVar(uiNamespace,"uiInteractionInfo") params ["_object","_type","_cfgObject","_cfgActions","_intersectPos"];
private _cfgAction = sel(_cfgActions,_this);
private _conditions = getArray (_cfgAction >> "conditions");
private _assignedItem = getText (_cfgAction >> "assigneditem");
private _distance = getNumber (_cfgAction >> "distance");
private _input = getArray (_cfgAction >> "input");
private _items = getArray (_cfgAction >> "items");
private _magazines = getArray (_cfgAction >> "magazines");
private _proceed = [
	_object,
	_cfgObject,
	_conditions,
	_assignedItem,
	_intersectPos,
	_distance,
	_input,
	_items,
	_magazines
] call horde_fnc_testInteractionConditions;

if (_proceed) then {
	setVar(missionNamespace,"playerPerformingAction","IN_PROGRESS");
	private _objectPos = ASLtoAGL getPosASL _object;
	private _objectDirAndUp = [vectorDir _object,vectorUp _object];
	[player,false] call horde_fnc_selectActionAnim;
	sleep 0.5;
	/*[player,"CfgWeapons","ItemCanteenEmpty"] call horde_fnc_broadcastActionSound;*/
	private _idx = player addEventHandler ["AnimDone",{
		if (sel(_this,1) == getVar(missionNamespace,"playerActionAnim")) then {
			setVar(missionNamespace,"playerPerformingAction","FINISHED")
		};
	}];
	private _idx2 = (findDisplay 46) displayAddEventHandler ["KeyDown",{
		_this call horde_fnc_abortAction
	}];

	// update conditions

	_conditions set [0,["not isNil {missionNamespace getVariable 'playerPerformingAction'}",""]];
	_conditions set [1,["missionNamespace getVariable 'playerPerformingAction' == 'IN_PROGRESS'",""]];

	private _playerDir = getDir player;

	waitUntil {
		if diff(getDir player,_playerDir) then {
			player setDir _playerDir
		};
		_proceed = [
			_object,
			_cfgObject,
			_conditions,
			_assignedItem,
			_intersectPos,
			_distance,
			_input,
			_items,
			_magazines
		] call horde_fnc_testInteractionConditions;
		if (not _proceed
			and {diff(getVar(missionNamespace,"playerPerformingAction"),"ABORTED")}
			and {diff(getVar(missionNamespace,"playerPerformingAction"),"FINISHED")}
		) then {
			0 call horde_fnc_resetAnims
		};
		// chance of blood
		if (random 1 > 0.99) then {
			/*https://forums.bistudio.com/forums/topic/145648-how-to-create-blood-stains-on-ground-bullet-hit-blood-fx-and-burning-shard-fx/*/
			private _bloodPool = createSimpleObject ["a3\characters_f\blood_splash.p3d",_objectPos getPos [random 0.4,random 360]];
			_bloodPool setDir random 360;
			[_bloodPool,120] remoteExecCall [
				"horde_fnc_serverAddToGarbage",
				2
			];
		};
		not _proceed
	};

	player removeEventHandler ["AnimDone",_idx];
	(findDisplay 46) displayRemoveEventHandler ["KeyDown",_idx2];

	// update conditions

	_conditions set [0,["not isNil {missionNamespace getVariable 'playerPerformingAction'}",""]];
	_conditions set [1,["missionNamespace getVariable 'playerPerformingAction' == 'FINISHED'","Action aborted"]];

	_proceed = [
		_object,
		_cfgObject,
		_conditions,
		_assignedItem,
		_intersectPos,
		_distance,
		_input,
		_items,
		_magazines
	] call horde_fnc_testInteractionConditions;

	if (_proceed) then {
		// base quantity of meat on size of animal (plus maybe cook skill)
		/*boundingBoxReal _object params ["","_maxDimensions"];*/
		/*diag_log str _maxDimensions;*/
		/*_maxDimensions = _maxDimensions apply {2 * _x};*/
		/*diag_log str _maxDimensions;*/
		/*_maxDimensions params ["_distX","_distY","_distZ"];*/
		/*_volume = _distX * _distY * _distZ;*/
		/*diag_log format ["volume of animal (m^3): %1", _volume];*/
		/*diag_log format ["sizeOf animal (m^3): %1", sizeOf typeOf _object];*/
		/*systemChat format ["volume of animal (m^3): %1", _volume];*/
		/*_meatQty = (floor (_volume * 0.2)) max 1;*/
		private _meatQty = (round random (sizeOf typeOf _object)) max 1;
		// now remove carcass
		deleteVehicle _object;

		// generate some blood
		/*for "_i" from 1 to round random [3,4,7] do {
			_bloodPool = createSimpleObject ["a3\characters_f\blood_splash.p3d",_objectPos getPos [random 0.7,random 360]];
			_bloodPool setDir random 360;
			[_bloodPool,120] remoteExecCall [
				"horde_fnc_serverAddToGarbage",
				2
			];
		};*/

		// now create weaponHolder

		private _holder = spawnVeh("WeaponHolderSimulated",_objectPos);
		_holder setVectorUp surfaceNormal _objectPos;
		_holder addItemCargoGlobal ["ItemMeatRaw",_meatQty];

		player action ["gear",_holder];

		if (_meatQty == 1) then {
			private _text =
			"
				<t size='3.2'color='#FFFFFF'align='center'shadow='2'>
				<br />
				<br />
				<br />
				<br />
				<br />
				<br />
				<br />
				<br />
				You hacked out a lump of raw meat.
				</t>
			";
			_text call horde_fnc_displayActionConfMessage;
		} else {
			private _text = format [
				"
					<t size='3.2'color='#FFFFFF'align='center'shadow='2'>
					<br />
					<br />
					<br />
					<br />
					<br />
					<br />
					<br />
					<br />
					You hacked out %1 lumps of raw meat.
					</t>
				",
				_meatQty
			];
			_text call horde_fnc_displayActionConfMessage;
		};
	};
	setVar(missionNamespace,"playerPerformingAction",nil);
};
true
