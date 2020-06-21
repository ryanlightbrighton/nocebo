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
	private _worldPosATL = ASLtoAGL (getPosWorld _object);
	private _modPos = player worldToModel _worldPosATL;
	private _relDir = (getDir _object) - (getDir player);
	_relDir = _relDir call horde_fnc_normalDir;
	_object attachTo [player,_modPos];
	_object setDir _relDir;
	player playAction "grabDrag";
	sleep 0.5;
	private _dragID = (findDisplay 46) displayAddEventHandler ["KeyDown",{
		_this call horde_fnc_abortDrag
	}];
	private _killedID = player addEventHandler ["Killed", {
		setVar(missionNamespace,"playerPerformingAction",nil);
		private _var = getVar(missionNamespace,"ncb_gv_abortDragInfo");
		if (not isNil "_var") then {
			(findDisplay 46) displayRemoveEventHandler ["KeyDown",sel(_var,0)];
			detach sel(_var,1);
			player removeEventHandler ["Killed",sel(_var,2)];
			player removeEventHandler ["AnimChanged",sel(_var,3)];
			setVar(missionNamespace,"ncb_gv_abortDragInfo",nil);
		};
		true
	}];
	private _animDoneID = player addEventHandler ["AnimChanged", {
		if diff(vehicle player,player) then {
			setVar(missionNamespace,"playerPerformingAction",nil);
			private _var = getVar(missionNamespace,"ncb_gv_abortDragInfo");
			if (not isNil "_var") then {
				(findDisplay 46) displayRemoveEventHandler ["KeyDown",sel(_var,0)];
				detach sel(_var,1);
				player removeEventHandler ["Killed",sel(_var,2)];
				player removeEventHandler ["AnimChanged",sel(_var,3)];
				setVar(missionNamespace,"ncb_gv_abortDragInfo",nil);
			};
		};
		true
	}];
	missionNamespace setVariable ["ncb_gv_abortDragInfo",[_dragID,_object,_killedID,_animDoneID]];
};

true