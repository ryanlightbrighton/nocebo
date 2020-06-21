#include "\nocebo\defines\scriptDefines.hpp"

params ["_unit","_anim"];

private _animStr = toLower (_anim select [11,10]);
If (alive _unit
    and {same(_animStr,"fixvehicle")}
    and {not isNil {getVar(uiNamespace,"ncb_ui_fixVehProgressBar")}}
) then {
	_unit playMoveNow _anim
};
true


