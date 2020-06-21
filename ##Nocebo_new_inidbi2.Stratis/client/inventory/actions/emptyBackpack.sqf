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

private _backpackContainer = backpackContainer player;
private _contents = [_backpackContainer,false] call horde_fnc_totalContents;

if ([[],[],[],[]] isEqualTo _contents) then {
	private _text = "
		<t size='3.2'color='#FF0000'align='center'shadow='2'>
		You do not have anything in your backpack.
		</t>
	";
	_text call horde_fnc_displayActionRejMessage;
	false
} else {
	clearItemCargoGlobal _backpackContainer;
	clearMagazineCargoGlobal _backpackContainer;
	clearWeaponCargoGlobal _backpackContainer;
	private _uniformContainer = uniformContainer player;
	private _vestContainer = vestContainer player;
	{
		call {
			if (_forEachIndex == 0) exitWith {
				// containers (cannot have in uniform/vest) - can only have in BP if empty
				{
					private _item = _x select 0;
					call {
						if (player canAddItemToVest _item) exitWith {
							player addItemToVest _item
						};
						if (player canAddItemToUniform _item) exitWith {
							player addItemToUniform _item
						};
						if (ncb_gv_currentInvContainer canAdd _item) exitWith {
							ncb_gv_currentInvContainer addItemCargoGlobal [_item,1]
						};
						player addItemToBackpack _item
					};
				} forEach _x;
			};
			if (_forEachIndex == 1) exitWith {
				// items
				{
					call {
						if (player canAddItemToVest _x) exitWith {
							player addItemToVest _x
						};
						if (player canAddItemToUniform _x) exitWith {
							player addItemToUniform _x
						};
						if (ncb_gv_currentInvContainer canAdd _x) exitWith {
							ncb_gv_currentInvContainer addItemCargoGlobal [_x,1]
						};
						player addItemToBackpack _x
					};
				} forEach _x;
			};
			if (_forEachIndex == 2) exitWith {
				// weaps
				{
					call {
						if (player canAddItemToVest sel(_x,0)) exitWith {
							_vestContainer call _fnc_AddWeapon
						};
						if (player canAddItemToUniform sel(_x,0)) exitWith {
							_uniformContainer call _fnc_AddWeapon
						};
						if (ncb_gv_currentInvContainer canAdd sel(_x,0)) exitWith {
							ncb_gv_currentInvContainer call _fnc_AddWeapon
						};
						_backpackContainer call _fnc_AddWeapon
					};
				} forEach _x;
			};
			if (_forEachIndex == 3) exitWith {
				// mags
				{
					call {
						if (player canAddItemToVest sel(_x,0)) exitWith {
							_vestContainer addMagazineAmmoCargo [sel(_x,0),1,sel(_x,1)]
						};
						if (player canAddItemToUniform sel(_x,0)) exitWith {
							_uniformContainer addMagazineAmmoCargo [sel(_x,0),1,sel(_x,1)]
						};
						if (ncb_gv_currentInvContainer canAdd sel(_x,0)) exitWith {
							ncb_gv_currentInvContainer addMagazineAmmoCargo [sel(_x,0),1,sel(_x,1)]
						};
						_backpackContainer addMagazineAmmoCargo [sel(_x,0),1,sel(_x,1)]
					};
				} forEach _x;
			};
		}
	} forEach _contents;
};
true