#include "\nocebo\defines\scriptDefines.hpp"

private _hitPointArr = [];
private _type = typeOf _this;
private _cfgHouse = cfgVeh >> _type;
private _cfgHitPoints = (_cfgHouse >> "HitPoints");
if not empty(_cfgHitPoints) then {
	for "_i" from 0 to count _cfgHitPoints - 1 do {
		private _cfgEntry = sel(_cfgHitPoints,_i);
		private _name = configName _cfgEntry;
		if (_name select [0,7] == "Hitzone") then {
			_hitPointArr pushBack (getText (_cfgEntry >> "name"));
		};
	};
};

setVar(_this,"structureHitZones",_hitPointArr);
setVar(_this,"structureOriginalPos",getPosATL _this);

_this addEventHandler ["hit",{
	private _house = sel(_this,0);
	private _broke = false;
	private _hitZones = getVar(_house,"structureHitZones");
	if (not isNil "_hitZones") then {
		{
			if (_house getHit _x == 1) then {
				_broke = true;
			};
			true
		} count _hitZones;
		if (_broke) then {
			private _rad = sizeOf typeOf _house;
			private _origHousePos = getVar(_house,"structureOriginalPos");
			private _players = [_origHousePos,50] call horde_fnc_allPlayersInRange;
			if not([] isEqualTo _players) then {
				_house remoteExecCall [
					"horde_fnc_blowUpFurniture",
					_players
				];
			};
			{
				detach _x
			} count (_origHousePos nearEntities [
				"StaticWeapon",
				_rad
			]);
			{
				deleteVehicle _x
			} count (nearestObjects [
				_origHousePos,
				["ReammoBox"],
				_rad
			]);
			_house removeAllEventHandlers "hit";
			// remove any other variables here!
			setVar(_house,"structureHitZones",nil);
			setVar(_house,"structureOriginalPos",nil);
		}
	}
}];

true