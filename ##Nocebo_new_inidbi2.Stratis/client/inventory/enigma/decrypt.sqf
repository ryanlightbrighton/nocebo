#include "\nocebo\defines\scriptDefines.hpp"

params ["_decryptMe","_key"];
private _counter = 0;
private _array = toArray _key;
for '_i' from 0 to count _decryptMe -1 do {
	if (_counter > count _array -1) then {
		_counter = 0;
	};
	private _var = (_decryptMe select _i) / (_array select _counter);
	_decryptme set [_i,_var];
	_counter = _counter + 1;
};
toString _decryptMe