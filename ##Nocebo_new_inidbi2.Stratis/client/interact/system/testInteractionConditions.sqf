#include "\nocebo\defines\scriptDefines.hpp"

params ["_object","_cfgObject","_conditions","_assignedItem","_intersectPos","_distance","_input","_items","_magazines"];
private _proceed = true;
{
	if not (call compile format [
			sel(_x,0),
			_assignedItem,
			_distance,
			_input,
			_items,
			_magazines
		]
	) exitWith {
		_proceed = false;
		private _objName = getText (_cfgObject >> "displayname");
		if (_object isKindOf "CAManBase" and {alive _object}) then {
			_objName = name _object;
		};
		private _text = format [
			"
				<t size='3.2'color='#FF0000'align='center'shadow='2'>
				%1
				</t>
			",
			format [sel(_x,1),_objName]
		];
		_text call horde_fnc_displayActionRejMessage;
	};
	true
} count _conditions;

_proceed