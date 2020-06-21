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
	private _objectPosASL = getPosASL _object;
	private _objectDirAndUp = [vectorDir _object,vectorUp _object];
	[player,false] call horde_fnc_selectActionAnim;
	sleep 0.5;
	/*[player,"CfgVehicles",_type] call horde_fnc_broadcastActionSound;*/
	private _idx = player addEventHandler ["AnimDone",{
		if (sel(_this,1) == getVar(missionNamespace,"playerActionAnim")) then {
			setVar(missionNamespace,"playerPerformingAction","FINISHED")
		};
	}];
	private _frameHandlerID = (findDisplay 46) displayAddEventHandler ["KeyDown",{
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
		not _proceed
	};

	player removeEventHandler ["AnimDone",_idx];
	(findDisplay 46) displayRemoveEventHandler ["KeyDown",_frameHandlerID];

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
		private _output = (getArray (_cfgAction >> "output")) select 0;
		// note: setting damage to 1 will trip the EH and remove tent from group :)
		_object setDamage 1;

		// animate

		_object animate ["Upload_1_cover_hide_1",0];
		_object animate ["Upload_2_cover_hide_1",0];
		_object animate ["Upload_3_cover_hide_1",0];

		_object animate ["Wifi_1_hide_1",0];
		_object animate ["Wifi_2_hide_1",0];
		_object animate ["Wifi_3_hide_1",0];
		_object animate ["Wifi_4_hide_1",0];
		_object animate ["Wifi_5_hide_1",0];

		_object animate ["Vent_1_rot_1",0];
		_object animate ["Vent_2_rot_1",0];
		_object animate ["Vent_3_rot_1",0];
		_object animate ["Vent_4_rot_1",0];

		_object animate ["Base_stripes_1_1_move_1",0];
		_object animate ["Base_stripes_2_1_move_1",0];
		_object animate ["Base_stripes_3_1_move_1",0];
		_object animate ["Base_stripes_4_1_move_1",0];
		_object animate ["Lid_stripes_1_1_move_1",0];
		_object animate ["Lid_stripes_2_1_move_1",0];
		_object animate ["Lid_stripes_3_1_move_1",0];
		_object animate ["Lid_stripes_4_1_move_1",0];

		_object animate ["Base_stripes_1_2_move_1",0];
		_object animate ["Base_stripes_2_2_move_1",0];
		_object animate ["Base_stripes_3_2_move_1",0];
		_object animate ["Base_stripes_4_2_move_1",0];
		_object animate ["Lid_stripes_1_2_move_1",0];
		_object animate ["Lid_stripes_2_2_move_1",0];
		_object animate ["Lid_stripes_3_2_move_1",0];
		_object animate ["Lid_stripes_4_2_move_1",0];

		_object animate ["Base_stripes_1_2_move_2",0];
		_object animate ["Base_stripes_2_2_move_2",0];
		_object animate ["Base_stripes_3_2_move_2",0];
		_object animate ["Base_stripes_4_2_move_2",0];
		_object animate ["Lid_stripes_1_2_move_2",0];
		_object animate ["Lid_stripes_2_2_move_2",0];
		_object animate ["Lid_stripes_3_2_move_2",0];
		_object animate ["Lid_stripes_4_2_move_2",0];

		_object animate ["Base_stripes_1_3_move_1",0];
		_object animate ["Base_stripes_2_3_move_1",0];
		_object animate ["Base_stripes_3_3_move_1",0];
		_object animate ["Base_stripes_4_3_move_1",0];
		_object animate ["Lid_stripes_1_3_move_1",0];
		_object animate ["Lid_stripes_2_3_move_1",0];
		_object animate ["Lid_stripes_3_3_move_1",0];
		_object animate ["Lid_stripes_4_3_move_1",0];

		_object animate ["Lock_1_rot_1",0];
		_object animate ["Lock_2_rot_1",0];
		_object animate ["Lid_rot_1",0];
		_object animate ["Lid_pistons_rot_1",0];
		_object animate ["Base_pistons_rot_1",0];

		_object animate ["Button_7_rot_1",0];
		_object animate ["Switch_2_rot_1",0];
		_object animate ["Switch_5_rot_1",0];
		_object animate ["Switch_6_rot_1",0];

		_object animate ["Dish_1_01_rot_1",0];
		_object animate ["Dish_1_02_rot_1",0];
		_object animate ["Dish_1_03_rot_1",0];
		_object animate ["Dish_1_04_rot_1",0];
		_object animate ["Dish_1_05_rot_1",0];
		_object animate ["Dish_1_06_rot_1",0];
		_object animate ["Dish_1_07_rot_1",0];
		_object animate ["Dish_1_08_rot_1",0];
		_object animate ["Dish_1_09_rot_1",0];
		_object animate ["Dish_1_10_rot_1",0];
		_object animate ["Dish_1_11_rot_1",0];
		_object animate ["Dish_1_12_rot_1",0];
		_object animate ["Dish_1_13_rot_1",0];
		_object animate ["Dish_1_14_rot_1",0];
		_object animate ["Dish_1_15_rot_1",0];
		_object animate ["Dish_1_16_rot_1",0];
		_object animate ["Dish_1_17_rot_1",0];
		_object animate ["Dish_1_18_rot_1",0];
		_object animate ["Dish_1_19_rot_1",0];
		_object animate ["Dish_1_20_rot_1",0];

		_object animate ["Antenna_piston_1_move_1",0];
		_object animate ["Antenna_piston_2_move_1",0];
		_object animate ["Antenna_piston_3_move_1",0];
		_object animate ["Antenna_base_rot_1",0];
		_object animate ["Antenna_center_rot_1",0];

		_object animate ["Dish_2_01_rot_1",0];
		_object animate ["Dish_2_02_rot_1",0];
		_object animate ["Dish_2_03_rot_1",0];
		_object animate ["Dish_2_04_rot_1",0];
		_object animate ["Dish_2_05_rot_1",0];
		_object animate ["Dish_2_06_rot_1",0];
		_object animate ["Dish_2_07_rot_1",0];
		_object animate ["Dish_2_08_rot_1",0];
		_object animate ["Dish_2_09_rot_1",0];
		_object animate ["Dish_2_10_rot_1",0];
		_object animate ["Dish_2_11_rot_1",0];
		_object animate ["Dish_2_12_rot_1",0];
		_object animate ["Dish_2_13_rot_1",0];
		_object animate ["Dish_2_14_rot_1",0];
		_object animate ["Dish_2_15_rot_1",0];
		_object animate ["Dish_2_16_rot_1",0];
		_object animate ["Dish_2_17_rot_1",0];
		_object animate ["Dish_2_18_rot_1",0];
		_object animate ["Dish_2_19_rot_1",0];
		_object animate ["Dish_2_20_rot_1",0];

		_object animate ["Screen_1_text_01_fakeunhide_1",0];

		_object animate ["Cpu_cover_fakehide_1",0];
		_object animate ["Ram_cover_fakehide_1",0];
		_object animate ["Cpu_1_rot_1",0];
		_object animate ["Cpu_2_rot_1",0];
		_object animate ["Ram_1_rot_1",0];
		_object animate ["Ram_2_rot_1",0];

		_object animate ["Screen_1_text_02_fakeunhide_1",0];
		_object animate ["Screen_1_text_03_fakeunhide_1",0];
		_object animate ["Screen_1_text_04_fakeunhide_1",0];
		_object animate ["Screen_1_text_05_fakeunhide_1",0];
		_object animate ["Screen_1_text_06_fakeunhide_1",0];
		_object animate ["Screen_1_text_07_fakeunhide_1",0];
		_object animate ["Screen_1_text_08_fakeunhide_1",0];

		_object animate ["Screen_1_text_09_fakeunhide_1",0];
		_object animate ["Screen_1_text_10_fakeunhide_1",0];
		_object animate ["Screen_1_text_11_fakeunhide_1",0];

		_object animate ["Screen_1_text_12_fakeunhide_1",0];
		_object animate ["Screen_1_text_13_fakeunhide_1",0];
		_object animate ["Screen_1_text_14_fakeunhide_1",0];
		_object animate ["Screen_1_text_15_fakeunhide_1",0];
		_object animate ["Screen_1_text_16_fakeunhide_1",0];
		_object animate ["Screen_1_text_17_fakeunhide_1",0];
		_object animate ["Screen_1_text_18_fakeunhide_1",0];
		_object animate ["Screen_1_text_19_fakeunhide_1",0];
		_object animate ["Screen_1_text_20_fakeunhide_1",0];
		_object animate ["Screen_1_text_21_fakeunhide_1",0];
		_object animate ["Screen_1_text_22_fakeunhide_1",0];
		_object animate ["Screen_1_text_23_fakeunhide_1",0];

		_object animate ["Screen_1_text_24_fakeunhide_1",0];
		_object animate ["Screen_1_text_25_fakeunhide_1",0];
		_object animate ["Screen_1_text_26_fakeunhide_1",0];
		_object animate ["Screen_1_text_27_fakeunhide_1",0];

		_object animate ["Screen_1_logo_fakeunhide_1",0];

		_object animate ["Screen_2_text_01_fakeunhide_1",0];
		_object animate ["Screen_2_text_02_fakeunhide_1",0];
		_object animate ["Screen_2_text_03_fakeunhide_1",0];
		_object animate ["Screen_2_text_04_fakeunhide_1",0];
		_object animate ["Screen_2_text_05_fakeunhide_1",0];
		_object animate ["Screen_2_text_06_fakeunhide_1",0];

		_object animate ["Screen_2_text_07_fakeunhide_1",0];
		_object animate ["Screen_2_text_08_fakeunhide_1",0];
		_object animate ["Screen_2_text_09_fakeunhide_1",0];

		_object animate ["Screen_2_text_10_fakeunhide_1",0];
		_object animate ["Screen_2_text_11_fakeunhide_1",0];
		_object animate ["Screen_2_text_12_fakeunhide_1",0];
		_object animate ["Screen_2_text_13_fakeunhide_1",0];
		_object animate ["Screen_2_text_14_fakeunhide_1",0];
		_object animate ["Screen_2_text_15_fakeunhide_1",0];

		_object animate ["Upload_fakeunhide_1",0];
		_object animate ["Wifi_cover_fakehide_1",0];

		// set colour of lights blue/green/white

		private _texture = "#(argb,8,8,3)color(1,0,0,1)";
		private _material = "\A3\Props_F_Exp_A\Military\Equipment\Data\DataTerminal_red.rvmat";
		_object setObjectTextureGlobal [2,_texture];
		_object setObjectTextureGlobal [3,_texture];
		_object setObjectTextureGlobal [4,_texture];
		_object setObjectMaterialGlobal [2,_material];
		_object setObjectMaterialGlobal [3,_material];
		_object setObjectMaterialGlobal [4,_material];

		sleep 3.5;
		deleteVehicle _object;
		if (backpack player == "") then {
			player addBackpack _output;
		} else {
			private _holder = _objectPosASL call horde_fnc_returnNearestHolder;
			if (isNull _holder) then {
				private _holderSpawnPos = (ASLtoAGL _objectPosASL) vectorAdd [0,0,0.5];
				_holder = spawnVeh("WeaponHolderSimulated",_holderSpawnPos);
			};
			_holder addBackpackCargoGlobal [_output,1];
		};

		private _text = "
			<t size='3.2'color='#FFFFFF'align='center'shadow='2'>
			You disassembled the beacon.
			</t>
		";
		_text call horde_fnc_displayActionConfMessage;
	};
	setVar(missionNamespace,"playerPerformingAction",nil);
};

true