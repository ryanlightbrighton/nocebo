#include "\nocebo\defines\scriptDefines.hpp"

private _fnc_addWeapon = {
	private _countArr = count _x;
	// muzz, side, optic
	for "_i" from 1 to 3 do {
		if diff(sel(_x,_i),"") then {
			_this addItemCargoGlobal [sel(_x,_i),1];
		};
	};
	//
	for "_i" from 4 to _countArr - 2 do {
		private _arr = sel(_x,_i);
		if not empty(_arr) then {
			_this addMagazineAmmoCargo [sel(_arr,0),1,sel(_arr,1)];
		};
	};
	if diff(sel(_x,_countArr - 1),"") then {
		_this addItemCargoGlobal [sel(_x,_countArr - 1),1];
	};
	_this addWeaponCargoGlobal [sel(_x,0),1]
};

private _uniformContainer = uniformContainer player;
private _contents = [_uniformContainer,false] call horde_fnc_totalContents;

if ([[],[],[],[]] isEqualTo _contents) then {
	private _text = "
		<t size='3.2'color='#FF0000'align='center'shadow='2'>
		You do not have anything in your uniform.
		</t>
	";
	_text call horde_fnc_displayActionRejMessage;
	false
} else {
	clearItemCargoGlobal _uniformContainer;
	clearMagazineCargoGlobal _uniformContainer;
	clearWeaponCargoGlobal _uniformContainer;
	private _backpackContainer = backpackContainer player;
	private _vestContainer = vestContainer player;
	{
		call {
			if (_forEachIndex == 0) exitWith {
				// containers (cannot have in uniform/vest) - can only have in BP if empty
				{
					private _item = _x select 0;
					call {
						if (player canAddItemToBackpack _item) exitWith {
							player addItemToBackpack _item
						};
						if (player canAddItemToVest _item) exitWith {
							player addItemToVest _item
						};
						if (ncb_gv_currentInvContainer canAdd _item) exitWith {
							ncb_gv_currentInvContainer addItemCargoGlobal [_item,1]
						};
						player addItemToUniform _item
					};
				} forEach _x;
			};
			if (_forEachIndex == 1) exitWith {
				// items
				{
					call {
						if (player canAddItemToBackpack _x) exitWith {
							player addItemToBackpack _x
						};
						if (player canAddItemToVest _x) exitWith {
							player addItemToVest _x
						};
						if (ncb_gv_currentInvContainer canAdd _x) exitWith {
							ncb_gv_currentInvContainer addItemCargoGlobal [_x,1]
						};
						player addItemToUniform _x
					};
				} forEach _x;
			};
			if (_forEachIndex == 2) exitWith {
				// weaps
				{
					call {
						if (player canAddItemToBackpack sel(_x,0)) exitWith {
							_backPackContainer call _fnc_AddWeapon
						};
						if (player canAddItemToVest sel(_x,0)) exitWith {
							_vestContainer call _fnc_AddWeapon
						};
						if (ncb_gv_currentInvContainer canAdd sel(_x,0)) exitWith {
							ncb_gv_currentInvContainer call _fnc_AddWeapon
						};
						_uniformContainer call _fnc_addWeapon
					};
				} forEach _x;
			};
			if (_forEachIndex == 3) exitWith {
				// mags
				{
					call {
						if (player canAddItemToBackpack sel(_x,0)) exitWith {
							_backpackContainer addMagazineAmmoCargo [sel(_x,0),1,sel(_x,1)]
						};
						if (player canAddItemToVest sel(_x,0)) exitWith {
							_vestContainer addMagazineAmmoCargo [sel(_x,0),1,sel(_x,1)]
						};
						if (ncb_gv_currentInvContainer canAdd sel(_x,0)) exitWith {
							ncb_gv_currentInvContainer addMagazineAmmoCargo [sel(_x,0),1,sel(_x,1)]
						};
						_uniformContainer addMagazineAmmoCargo [sel(_x,0),1,sel(_x,1)]
					};
				} forEach _x;
			};
		}
	} forEach _contents;
};
true