#include "\nocebo\defines\scriptDefines.hpp"

/*
	Author: Jiri Wainar

	Description:
	Types a structured text on the screen, letter by letter, cursor blinking.

	Parameter(s):
	_this: array containing blocks of text with same structured text formatting

	Remarks:
	* Every text block is an array of text and formatting tag.
	* Blocks don't have to span over whole line.

	Example:

	[
		[
			["CAMP ROGAIN,","align = 'center' shadow = '1' size = '0.7' font='PuristaBold'"],
			["RESSUPLY POINT","align = 'center' shadow = '1' size = '0.7'","#aaaaaa"],
			["","<br/>"],
			["10 MINUTES LATER ...","align = 'center' shadow = '1' size = '1.0'"]
		]

	] spawn BIS_fnc_typeText2;

	0=[[["CAMP ROGAIN, ","align = 'center' size = '0.7' font='PuristaBold'"],["RESSUPLY POINT","align = 'center' size = '0.7'","#aaaaaa"],["","<br/>"],["10 MINUTES LATER ...","align = 'center' size = '1.0'"]]] spawn BIS_fnc_typeText2;
*/

disableserialization;

#define DELAY_CHARACTER		0.06;
#define DELAY_CURSOR		0.04;

params [
	["_data",[],[[]]],
	["_posX",0,[123]],
	["_posY",0,[123]],
	["_alignBottom",true,[true]],
	["_rootFormat","<t >%1</t>",[""]],
	["_abortParams",[],[[]]],
	["_abortCond",{false},[{}]]
];

private _invisCursor = "<t color ='#00000000' shadow = '0'>_</t>";

//process the input data
private["_block","_format","_color","_blockArray","_blocks","_formats","_colors"];

private _blocks  = [];
private _formats = [];
private _colors	 = [];

{
	_x params [
		["_block","",[""]],
		["_format","align = 'center' size = '0.7'",[""]],
		["_color","#ffffff",[""]]
	];

	if (_format != "<br/>") then {
		_format	= format["<t color = '%2' shadow = '%3' %4>%1</t>","%1","%2","%3",_format];
	};

	//convert strings into array of chars
	private _blockArray = toArray _block;
	{_blockArray set [_forEachIndex, toString [_x]]} forEach _blockArray;

	_blocks pushBack _blockArray;
	_formats pushBack _format;
	_colors pushBack _color;
}
forEach _data;

//pre-process the characters

private _charsShown = [];
private _charsHidden = [];
private _charsPlain = [];

{
	private _chars 	 = _x;
	private _blockId = _forEachIndex;
	private _format  = _formats select _blockId;
	private _color   = _colors select _blockId;

	if (_chars isEqualTo []) then
	{
		_charsShown pushBack _format;
		_charsHidden  pushBack _format;
		_charsPlain  pushBack "";
	} else {
		{
			private _charShown = format[_format,_x,_color,1];
			private _charHidden = format[_format,_x,'#00000000',0];

			_charsShown pushBack _charShown;
			_charsHidden pushBack _charHidden;
			_charsPlain pushBack _x;
		} forEach _chars;
	};
}
forEach _blocks;

//pre-process the frames

private _frames = [];

{
	private _frame   = [];
	private _frameId = _forEachIndex;

	//combine the characters into frames
	{
		private _charId = _forEachIndex;

		if (_charId <= _frameId) then {
			_frame pushBack _x;
		} else {
			_frame  pushBack (_charsHidden select _charId);
		};
	}
	forEach _charsShown;

	//merge frame characters into a string
	private _frameMerged = "";

	{
		_frameMerged = _frameMerged + _x;
	} forEach _frame;

	_frames pushBack (parseText format[_rootFormat,_frameMerged]);
} forEach _charsShown;

//fadeout: create an index array & shuffle it

private _indexes =+ _charsShown;

{
	_indexes set [_forEachIndex,_forEachIndex];
} forEach _indexes;

_indexes = _indexes call horde_fnc_arrayShuffle;

//fadeout: pre-select chars for fadeout & pre-process the frames

private _charCount = count _indexes;
private _framesOut = [];

{
	private _step = _x;
	private _frameOut =+ _charsShown;

	{
		if (_forEachIndex == round(_charCount/_step)) exitWith {};

		_frameOut set [_x,_charsHidden select _x];
	} forEach _indexes;

	private _frameOutMerged = "";

	{
		_frameOutMerged = _frameOutMerged + _x;
	} forEach _frameOut;

	_framesOut pushBack (parseText format[_rootFormat,_frameOutMerged]);

} forEach [10,9,8,7,6,5,4,3,2,1];

//  initialize display control

private _display = uinamespace getVariable ["BIS_dynamicText",displayNull];
[_frames select 0, -2, -2, 10e10, 0, 0, 90] spawn BIS_fnc_dynamicText;
waitUntil{
	uinamespace getvariable ["BIS_dynamicText",displayNull] != _display
	&& {!isNull(uinamespace getvariable ["BIS_dynamicText",displayNull])}
};
_display = uinamespace getVariable ["BIS_dynamicText",displayNull];
private _control = _display displayctrl 9999;

if (_alignBottom) then {
	private _h = ctrlTextHeight _control;
	_control ctrlSetPosition [_posX,_posY - _h - 0.01,safeZoneW,_h];
	_control ctrlCommit 0;
} else {
	_control ctrlSetPosition [_posX,_posY,safeZoneW,safeZoneH];
	_control ctrlCommit 0;
};

waitUntil {
	ctrlCommitted _control
};

//print the pre-processed frames

{
	if (_abortParams call _abortCond) exitWith {};
	private _printedChar = _charsPlain select _forEachIndex;
	_control ctrlSetStructuredText _x;
	switch (_printedChar) do {
		case " " : {
			uiSleep 0.08;
		};
		case "" : {
			uiSleep 1.4;
		};
		default {
			playSound ["ReadoutClick", true];
			uiSleep 0.08;
		};
	};
}
forEach _frames;

private _t = time + 3;

waitUntil {
	time > _t or {_abortParams call _abortCond}
};

//print the pre-processed fadeout frames
{
	if (_abortParams call _abortCond) exitWith {};
	_control ctrlSetStructuredText _x;
	_control ctrlCommit 0;
	waituntil {
		ctrlCommitted _control
	};
	playSound ["ReadoutHideClick1", true];
	sleep 0.035;
}
forEach _framesOut;

//clean the screen
["", _posX, _posY, 5, 0, 0, 90] spawn BIS_fnc_dynamicText;

true