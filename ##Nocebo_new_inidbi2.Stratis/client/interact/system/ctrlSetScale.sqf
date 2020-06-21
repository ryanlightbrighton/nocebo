#include "\nocebo\defines\scriptDefines.hpp"

params [
	["_displayName","",[""]],
	["_idc",-1,[0]],
	["_scale",1,[0]],
	["_commit",0,[0]]
];
private _display = getVar(uiNamespace,_displayName);
private _ctrl = _display displayCtrl _idc;

//--- Get current position
private _ctrlPos = ctrlPosition _ctrl;
private _ctrlPosX = _ctrlPos select 0;
private _ctrlPosY = _ctrlPos select 1;
private _ctrlPosW = (_ctrlPos select 2) * 0.5;
private _ctrlPosH = (_ctrlPos select 3) * 0.5;

//--- Calculate center
private _ctrlScale = ctrlScale _ctrl;
private _ctrlPosCenterX = _ctrlPosX + _ctrlPosW * _ctrlScale;
private _ctrlPosCenterY = _ctrlPosY + _ctrlPosH * _ctrlScale;

//--- Apply the changes
_ctrlPos = [
	_ctrlPosCenterX - _ctrlPosW * _scale,
	_ctrlPosCenterY - _ctrlPosH * _scale,
	_ctrlPosW * 2,
	_ctrlPosH * 2
];
_ctrl ctrlSetPosition _ctrlPos;
_ctrl ctrlSetScale _scale;
_ctrl ctrlCommit _commit;
_ctrlPos