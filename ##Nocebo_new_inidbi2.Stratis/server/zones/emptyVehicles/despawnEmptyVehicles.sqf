#include "\nocebo\defines\scriptDefines.hpp"

private _cars = getVarDef(_this,"zoneCurrentEmptyVehicles",[]);
private _savedVehData = [];
{
	if (not isNull _x
		and {damage _x < 1}
		and {_x distance _this < (_this getVariable ["zoneTriggerRadius",1000]) + 500}
		and {isNull (getPosATL _x nearestObject "ncb_obj_tent_dome")}
	) then {
		private _veh = _x;
		private _type = typeOf _veh;
		private _cfgType = cfgVeh >> _type;
		private _initTime = getVarDef(_x,"vehicleAbandonedTime",time);
		if ((round time) - _initTime < ncb_param_removeAbandonedVehicleTimeout) then {
			// save it!
			private _vehPosASL = getPosASL _veh;
			private _dir = getDir _veh;
			private _fuel = fuel _veh;
			private _damage = damage _veh;
			// damage & repairs
			private _cfgHitPoints = _cfgType >> "HitPoints";
			private _hitPointArr = [];
			private _toolPartArr = [];
			for "_i" from 0 to count _cfgHitPoints - 1 do {
				private _cfgEntry = sel(_cfgHitPoints,_i);
				if (isClass _cfgEntry) then {
					private _configName = configName _cfgEntry;
					private _hitPoints = _veh getHitPointDamage _configName;
					// fix for undefined _hitpoints error
					if not (isNil "_hitPoints") then {
						_hitPointArr pushBack [_configName,_hitPoints];
						/*NOW RECORD WHAT TOOLS ARE NEEDED FOR REPAIR
						INFO SAVED IN THIS FORMAT: [_PART, _TOOL]*/
						private _repairInfo = getVar(_veh,_configName);
						if not (isNil "_repairInfo") then {
							_toolPartArr pushBack [_configName,sel(_repairInfo,0),sel(_repairInfo,1)];
						};
					} else {
						// need to catch this bug
						diag_log "-----------------";
						diag_log "nil hitpoints - veh";
						diag(_veh);
						diag(_type);
						diag(_configName);
						diag_log "-----------------";
					};
				};
			};
			/*AMMO*/
			private _turretMagazinesArr = [];
			private _generalMagazinesArr = [];
			private _vehMagazines = getArray (_cfgType >> "Magazines");

			{
				if (_x in _vehMagazines) then {
					_generalMagazinesArr pushBack _x;
				};
				true
			} count magazines _veh;

			{
				_turretMagazinesArr pushBack _x;
				true
			} count magazinesAmmo _veh;

			/*CARGO*/

			private _cargoDataArr = [_veh,true] call horde_fnc_totalContents;

			/*TEXTURE*/

			private _textures = getObjectTextures _veh;
			if (isNil "_textures") then {
				_textures = [];
			};

			_savedVehData pushBack [
				_type,
				_vehPosASL,
				_dir,
				_fuel,
				_damage,
				_hitPointArr,
				_cargoDataArr,
				_turretMagazinesArr,
				_generalMagazinesArr,
				_toolPartArr,
				_initTime,
				_textures
			];
		};

		/*REMOVE ATTACHED PARTICLE EFFECTS*/

		{
			deleteVehicle _x;
		} count attachedObjects _veh;

		deleteVehicle _veh;
	};
	true
} count _cars;
setVar(_this,"zoneSavedEmptyVehicleData",_savedVehData);
setVar(_this,"zoneCurrentEmptyVehicles",[]);

true


/*{
	_type = typeOf _x;
	_items = getItemCargo _x;
	_mags = magazinesAmmoCargo _x;
	_weaps = weaponsItemsCargo _x;
	_packs = getBackpackCargo _x;
	_ebp = everyBackpack _x;
	_econt = everyContainer _x;
	diag_log format ["TYPE: %1", _type];
	diag_log format ["ITEMS: %1", _items];
	diag_log format ["MAGS: %1", _mags];
	diag_log format ["WEAPS: %1", _weaps];
	diag_log format ["PACKS: %1", _packs];
	diag_log format ["EVERY BP: %1", _ebp];
	diag_log format ["EVERY CONT: %1", _econt];
	diag_log "------";
} forEach everyBackpack car1;

// how to add back in
{
	_x addItemCargoGlobal ["itemGPS",1];
	_x addItemCargoGlobal ["G_Aviator",5];
} forEach everyBackpack car1;

diag_log format ["%1", everyBackpack car1];
diag_log format ["%1", everyContainer car1];


	car1 addItemCargoGlobal ["B_AssaultPack_dgtl",1];
	car1 addItemCargoGlobal ["V_TacVest_blk_POLICE",1];

	diag_log format ["PACK: %1", "B_AssaultPack_dgtl" isKindOf "Bag_Base"];
	diag_log format ["VEST: %1", "V_TacVest_blk_POLICE" isKindOf "Bag_Base"];

	// so it's ok to work from just the everyContainer command, as we can differentiate between vests and backpacks when adding them back in:
{
	_container = _x select 0;
	_contents = _x select 1;
	if(_container isKindOf "Bag_Base") then {
		_object addBackPackCargoGlobal ["B_AssaultPack_dgtl",1];
		_contID = (everyContainer _object select (count everyContainer _object - 1)) select 1;
		{

		} forEach _contents;
	} else {
		_object addItemCargoGlobal ["V_TacVest_blk_POLICE",1];
	};
} forEach _savedVehData;

// check if inherits from works for things like vests and uniforms


diag_log format ["PACK: %1", inheritsFrom (configFile >> "CfgWeapons" >> "U_O_GhillieSuit")];
diag_log format ["VEST: %1", inheritsFrom (configFile >> "CfgWeapons" >> "V_BandollierB_cbr")];
diag_log format ["VEST: %1", inheritsFrom (configFile >> "CfgWeapons" >> "V_BandollierB_khk")];
*/



// RULES: VESTS AND UNIFORMS CAN BE ADDED TO BACKPACKS, BUT ONLY IF THERE IS NOTHING IN THEM

// VESTS WILL SHOW UP UNDER GETITEMCARGO AND EVERYCONTAINER SEARCHES

// BACKPACKS CANNOT BE PUT INSIDE OTHER BACKPACKS

// COMMANDS EVERYBACKPACK AND EVERYCONTAINER RETURN IN THE ORDER THE CONTAINERS WERE ADDED

