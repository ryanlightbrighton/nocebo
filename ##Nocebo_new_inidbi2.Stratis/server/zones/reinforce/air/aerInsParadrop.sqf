#include "\nocebo\defines\scriptDefines.hpp"

// run on someone in a vehicle

private _heli = vehicle _this;
if (_heli != _this) then {
	private _type = typeOf _heli;
	private _door = "CargoRamp_Open";
	if (_type isKindOf "Heli_Light_02_base_F") then {
		_door = "dvere1_posunZ";
	};
	[
		[assignedCargo _heli],{
			call horde_fnc_getEachFrameArgs params ["_paras"];
			if not (_paras isEqualTo []) then {
				private _para = _paras deleteAt 0;
				unassignVehicle _para;
				moveOut _para;
				_para execFSM "server\zones\manager\aiParadrop.fsm";
			};
			if (_paras isEqualTo []) then {
				call horde_fnc_removeEachFrame
			} else {
				[_paras] call horde_fnc_updateEachFrameArgs
			}
		},
		0.5
	] call horde_fnc_addEachFrame;

	_heli animate [_door,0];
};

true


