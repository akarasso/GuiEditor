call compile preprocessFileLineNumbers "Editor\oo_GuiEditor.sqf";
call compile preprocessFileLineNumbers "Editor\oo_GRIDLayer.sqf";
call compile preprocessFileLineNumbers "Editor\oo_Layer.sqf";
call compile preprocessFileLineNumbers "Editor\oo_Control.sqf";
call compile preprocessFileLineNumbers "Editor\oo_makeFile.sqf";
call compile preprocessFileLineNumbers "Editor\oo_makeOOPFile.sqf";
call compile preprocessFileLineNumbers "Editor\oo_HelperGui.sqf";
call compile preprocessFileLineNumbers "Editor\oo_HelperStyle.sqf";
call compile preprocessFileLineNumbers "Editor\oo_HelperControl.sqf";
call compile preprocessFileLineNumbers "Editor\oo_GuiEditorDialog.sqf";
call compile preprocessFileLineNumbers "Editor\oo_GuiEditorEvent.sqf";

/*
*	Dialog
*/
call compile preprocessFileLineNumbers "View\oo_ctrlCreateDialog.sqf";
call compile preprocessFileLineNumbers "View\oo_ctrlModifyDialog.sqf";

/*
*	Control
*/
call compile preprocessFileLineNumbers "Controls\oo_SliderH.sqf";
call compile preprocessFileLineNumbers "Controls\oo_ColorPicker.sqf";


waitUntil {!(isNull (findDisplay 46))};
disableSerialization;
HelperGui = "new" call oo_HelperGui;
OOP_GuiEditor_ListControl = [
	"OOP_SubLayer",
	"OOP_Button",
	"OOP_Listbox",
	"OOP_Text",
	"OOP_TextRight",
	"OOP_Edit",
	"OOP_Checkbox",
	"OOP_Tree",
	"OOP_Picture",
	"OOP_TextMulti",
	"OOP_StructuredText",
	"OOP_ActiveText",
	"OOP_ButtonTextOnly",
	"OOP_Slider",
	"RscColorPicker",
	"OOP_Progress"
];
GuiObject = "new" call oo_GuiEditor;

// createDialog "Empty";
// private _display = findDisplay 4500;
// private _colorPicker = ["new", [_display, controlNull, [0, 0, 57.9399 * pixelGrid * pixelW, 27.709 * pixelGrid * pixelH] ]] call oo_ColorPicker;
// ["setAllTopArrowSlider", [0,0,0,0]] call _colorPicker;
// ["setAllBottomArrowSlider", [0,0,0,0]] call _colorPicker;
// ["setFGSlider", ["red", [1]]] call _colorPicker;
// ["setFGSlider", ["blue", [0,0,1]]] call _colorPicker;
// ["setFGSlider", ["green", [0,1]]] call _colorPicker;
