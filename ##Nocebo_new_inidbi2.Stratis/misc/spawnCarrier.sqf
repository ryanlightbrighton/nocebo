if (isServer) then {
	// Spawn Carrier on Server
	private _carrier = createVehicle ["Land_Carrier_01_base_F",[1000,1000,0],[],0,"None"];
	_carrier setDir 270;
	_carrier setPosWorld [1000,1000,0];
	[_carrier] call BIS_fnc_Carrier01PosUpdate;

	/*_turrets = [];
	_turrets resize 7 ;
	{
		if (isNil {_x} or {typeName _x != "STRING"}) then {
			_turrets set [_forEachIndex,call {
				if (_forEachIndex in [2,5]) exitWith {"B_SAM_System_01_F"} ;
				if (_forEachIndex in [0,4]) exitWith {"B_SAM_System_02_F"} ;
				if (_forEachIndex in [1,3,6]) exitWith {"B_AAA_System_01_F"} ;
			}] ;
		} ;
	} forEach _turrets;

	_turretsData = [
		[[-30.3,-175,19.5],[0,0,0],180],
		[[-47,0.05,17.84],[-0.5,0,0],270],
		[[-24.8,115,16.42],[0,0,0],270],
		[[29.3,105.5,17.38],[0.52,0,0],90],
		[[29.3,100.8,19.14],[0,0,0],90],
		[[39.3,-178.5,19.72],[0,0,0],180],
		[[16.85,-188,10.99],[0,0,0],180]
	] ;

	{
		_x params ["_pos","_posAAA","_dir"] ;
		_class = _turrets select _forEachIndex ;
		_heightCoef = call {
			if (_class == "B_AAA_System_01_F") exitWith {0.73} ;
			if (_class == "B_SAM_System_02_F") exitWith {0.2} ;
			0
		} ;
		_turret = createVehicle [_class,[0,0,0],[],0,"CAN_COLLIDE"] ;
		_turret attachTo [_carrier,_pos vectorAdd [0,0,_heightCoef] vectorAdd ([[0,0,0],_posAAA] select (_class == "B_AAA_System_01_F")) vectorAdd _posCoef] ;
		_turret setDir _dir ;
		createVehicleCrew _turret;
	} forEach _turretsData;*/

	// Broadcast Carrier ID over network
	missionNamespace setVariable ["USS_FREEDOM_CARRIER",_carrier,true];

	/*_carrier spawn {
		private _startPos = getPos _this; // Place a marker
		private _startDir = 90; // Heading East

		while {true} do {
			_startPos = _startPos getPos [0.2,_startDir];
			_this setPosWorld ASLToATL _startPos;
			_this setDir (_startDir - 180);
			[_this] call BIS_fnc_Carrier01PosUpdate;
		};
	};*/
} else {
	[] spawn {
		// Clients wait for carrier
		waitUntil { !(isNull (missionNamespace getVariable ["USS_FREEDOM_CARRIER",objNull])) };

		// Work around for missing carrier data not being broadcast as expected
		if (count (USS_FREEDOM_CARRIER getVariable ["bis_carrierParts", []]) == 0) then {
			["Carrier %1 is empty. Client Fixing.",str "bis_carrierParts"] call BIS_fnc_logFormatServer;
			private _carrierPartsArray = (configFile >> "CfgVehicles" >> typeOf USS_FREEDOM_CARRIER >> "multiStructureParts") call BIS_fnc_getCfgDataArray;
			private _partClasses = _carrierPartsArray apply {_x select 0};
			private _nearbyCarrierParts = nearestObjects [USS_FREEDOM_CARRIER,_partClasses,500];
			{
				private _carrierPart = _x;
				private _index = _forEachIndex;
				{
					if ((_carrierPart select 0) isEqualTo typeOf _x) exitWith { _carrierPart set [0,_x]; };
				} forEach _nearbyCarrierParts;
				_carrierPartsArray set [_index,_carrierPart];
			} forEach _carrierPartsArray;
			USS_FREEDOM_CARRIER setVariable ["bis_carrierParts",_nearbyCarrierParts];
			["Carrier %1 was empty. Now contains %2.",str "bis_carrierParts",USS_FREEDOM_CARRIER getVariable ["bis_carrierParts", []]] call BIS_fnc_logFormatServer;
		};

		// Client Initiate Carrier Actions with slight delay to ensure carrier is sync'd
		[USS_FREEDOM_CARRIER] spawn { sleep 1; _this call BIS_fnc_Carrier01Init};
	};
};