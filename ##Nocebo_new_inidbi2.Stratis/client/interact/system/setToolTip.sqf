#include "\nocebo\defines\scriptDefines.hpp"

params ["_ctrl","_tooltip","_color"];

private _display = uiNamespace getVariable "Horde_InteractionMenu";
private _button = _display displayCtrl _ctrl;
_button ctrlSetTooltip _tooltip;
_button ctrlSetTooltipColorBox _color;
_button ctrlSetTooltipColorShade [0, 0, 0, 1];
true