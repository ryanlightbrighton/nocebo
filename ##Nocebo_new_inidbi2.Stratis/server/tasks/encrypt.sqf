#include "\nocebo\defines\scriptDefines.hpp"

// ex: _encryptedArray = ["Encrypt this string","this is the key"] call horde_fnc_encrypt;

params ["_input","_key"];
private _encryptMe = toArray _input;
private _counter = 0;
private _array = toArray _key;
for '_i' from 0 to count _encryptMe -1 do {
	if (_counter > count _array -1) then {
		_counter = 0;
	};
	private _var = (_encryptMe select _i) * (_array select _counter);
	_encryptme set [_i,_var];
	_counter = _counter + 1;
};
_encryptMe