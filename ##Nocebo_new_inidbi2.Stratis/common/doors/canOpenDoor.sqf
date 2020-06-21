#include "\nocebo\defines\scriptDefines.hpp"

params ["_house","_doorType","_selectionName"];

private _worldPos = _house modelToWorld (_house selectionPosition _selectionName);
private _sesame = objNull;
private _nearPlayers = [];
private _houseKeyName = "";
scopeName "0";
{
	private _unit = _x;
	if (isPlayer _unit) then {
		_nearPlayers pushBack _unit;
		private _houseKeyInfo = getVar(_house,"objectAcceptedAccessPasses");

		if (isNil "_houseKeyInfo") exitWith {
			_sesame = _unit;
			breakTo "0"
		};

		_houseKeyName = sel(_houseKeyInfo,0);
		{
			private _key = _x;
			if (_key in (items _unit)) then {
				/*private _passType = getText (configfile >> "CfgWeapons" >> _key >> "horde_pass_type");
				if (_passType == _doorType
					or {_passType == "all"}
				) then {*/
					_sesame = _unit;
					breakTo "0"
				/*};*/
			};
		} count sel(_houseKeyInfo,1);
	} else {
		 // ai automatically go through
		_sesame = _unit;
		breakTo "0"
	};
	true
} count (_worldPos nearEntities [["CAManBase"], 3]);


[_worldPos,_sesame,_nearPlayers,_houseKeyName]