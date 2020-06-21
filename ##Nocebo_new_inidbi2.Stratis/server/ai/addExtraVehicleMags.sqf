#include "\nocebo\defines\scriptDefines.hpp"

_info = missionNamespace getVariable ("ncb_gv_extraVehicleMagData_" + (typeOf _this));
if not (isNil "_info") then {
	{
		_x params ["_path","_mags"];
		{
			// maybe just do it locally as the vehicles have just been created on the server
			_this addMagazineTurret [_x,_path]
		} forEach _mags
	} forEach _info
} else {
	diag_log format ["addExtraVehicleMags: No extra mag data for '%1'",typeOf _this];
}