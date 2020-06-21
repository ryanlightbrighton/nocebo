#include "\nocebo\defines\scriptDefines.hpp"

private _fnc_addWeapon = {
	_countArr = count _x;
	// muzz, side, optic
	for "_i" from 1 to 3 do {
		if diff(sel(_x,_i),"") then {
			_this addItemCargoGlobal [sel(_x,_i),1];
		};
	};
	//
	for "_i" from 4 to _countArr - 2 do {
		_arr = sel(_x,_i);
		if not empty(_arr) then {
			_this addMagazineAmmoCargo [sel(_arr,0),1,sel(_arr,1)];
		};
	};
	if diff(sel(_x,_countArr - 1),"") then {
		_this addItemCargoGlobal [sel(_x,_countArr - 1),1];
	};
	_this addWeaponCargoGlobal [sel(_x,0),1]
};

private _vestContainer = vestContainer player;

private _contents = [_vestContainer,false] call horde_fnc_totalContents;

if ([[],[],[],[]] isEqualTo _contents) then {
	private _text = "
		<t size='3.2'color='#FF0000'align='center'shadow='2'>
		You do not have anything in your vest.
		</t>
	";
	_text call horde_fnc_displayActionRejMessage;
	false
} else {
	clearItemCargoGlobal _vestContainer;
	clearMagazineCargoGlobal _vestContainer;
	clearWeaponCargoGlobal _vestContainer;
	private _backpackContainer = backpackContainer player;
	private _uniformContainer = uniformContainer player;
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
						if (player canAddItemToUniform _item) exitWith {
							player addItemToUniform _item
						};
						if (ncb_gv_currentInvContainer canAdd _item) exitWith {
							ncb_gv_currentInvContainer addItemCargoGlobal [_item,1]
						};
						player addItemToVest _item
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
						if (player canAddItemToUniform _x) exitWith {
							player addItemToUniform _x
						};
						if (ncb_gv_currentInvContainer canAdd _x) exitWith {
							ncb_gv_currentInvContainer addItemCargoGlobal [_x,1]
						};
						player addItemToVest _x
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
						if (player canAddItemToUniform sel(_x,0)) exitWith {
							_uniformContainer call _fnc_AddWeapon
						};
						if (ncb_gv_currentInvContainer canAdd sel(_x,0)) exitWith {
							ncb_gv_currentInvContainer call _fnc_AddWeapon
						};
						_vestContainer call _fnc_AddWeapon
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
						if (player canAddItemToUniform sel(_x,0)) exitWith {
							_uniformContainer addMagazineAmmoCargo [sel(_x,0),1,sel(_x,1)]
						};
						if (ncb_gv_currentInvContainer canAdd sel(_x,0)) exitWith {
							ncb_gv_currentInvContainer addMagazineAmmoCargo [sel(_x,0),1,sel(_x,1)]
						};
						_vestContainer addMagazineAmmoCargo [sel(_x,0),1,sel(_x,1)]
					};
				} forEach _x;
			};
		}
	} forEach _contents;
};
true