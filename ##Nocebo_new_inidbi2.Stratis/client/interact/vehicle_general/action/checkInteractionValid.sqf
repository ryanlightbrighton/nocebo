#include "\nocebo\defines\scriptDefines.hpp"

// _this = object

private _actionValid = true;
call {
	if (isNull player) exitWith {
		_actionValid = false;
	};
	if (not alive player) exitWith {
		_actionValid = false;
	};
	if (isNull _this) exitWith {
		private _msg = "
			<t size='3.2'color='#FF0000'align='center'shadow='2'>
			Debug message - you shouldn't see this!
			</t>
		";
		_msg call horde_fnc_displayActionRejMessage;
		_actionValid = false;
	};
	if (not alive _this) exitWith {
		private _msg = "
			<t size='3.2'color='#FF0000'align='center'shadow='2'>
			You can't interact with destroyed vehicles.
			</t>
		";
		_msg call horde_fnc_displayActionRejMessage;
		_actionValid = false;
	};
	if ({alive _x} count (crew _this) > 0) exitWith {
		private _msg = "
			<t size='3.2'color='#FF0000'align='center'shadow='2'>
			You can't work on a vehicle while it is occupied.
			</t>
		";
		_msg call horde_fnc_displayActionRejMessage;
		_actionValid = false;
	};
	if (isPlayer (_this getVariable ["vehiclePlayerInteracting",objNull])) exitWith {
		private _msg = "
			<t size='3.2'color='#FF0000'align='center'shadow='2'>
			Only one person can work on a vehicle at a time.
			</t>
		";
		_msg call horde_fnc_displayActionRejMessage;
		_actionValid = false;
	};
};

_actionValid