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

waitUntil {!(isNull (findDisplay 46))};
disableSerialization;

OOP_GuiEditor_ListControl = [
	"OOP_IGUIBack",
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
	"OOP_Progress",
	"RscControlsGroup"
];
"new" call oo_GuiEditor;
