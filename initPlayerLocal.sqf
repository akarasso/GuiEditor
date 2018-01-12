call compile preprocessFileLineNumbers "Editor\oo_GuiEditor.sqf";
call compile preprocessFileLineNumbers "Editor\oo_GRIDLayer.sqf";
call compile preprocessFileLineNumbers "Editor\oo_Layer.sqf";
call compile preprocessFileLineNumbers "Editor\oo_Control.sqf";
call compile preprocessFileLineNumbers "Editor\oo_metaControl.sqf";
call compile preprocessFileLineNumbers "Editor\oo_makeFile.sqf";
call compile preprocessFileLineNumbers "Editor\oo_makeOOPFile.sqf";
call compile preprocessFileLineNumbers "Editor\oo_makeMetaControl.sqf";
call compile preprocessFileLineNumbers "Editor\oo_HelperGui.sqf";
call compile preprocessFileLineNumbers "Editor\oo_HelperStyle.sqf";
call compile preprocessFileLineNumbers "Editor\oo_HelperControl.sqf";
call compile preprocessFileLineNumbers "Editor\oo_GuiEditorDialog.sqf";
call compile preprocessFileLineNumbers "Editor\oo_GuiEditorEvent.sqf";

call compile preprocessFileLineNumbers "Editor\oo_TreeDialog.sqf";

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
call compile preprocessFileLineNumbers "Controls\oo_newMeta.sqf";


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
	"OOP_Progress",
	"oo_newMeta"
];
GuiObject = "new" call oo_GuiEditor;

// private _test =  "new" call oo_makeMetaControl;
// ["addSuper", "string"] call _test;
// ["addSuperSetter", "string"] call _test;
// ["addSuperStatic", "string"] call _test;
// ["addSuperStaticSetter", "string"] call _test;
// ["addFunction", ["string"]] call _test;