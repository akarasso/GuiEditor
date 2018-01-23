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
call compile preprocessFileLineNumbers "Editor\oo_GuiEditorEvent.sqf";

call compile preprocessFileLineNumbers "Editor\oo_TreeDialog.sqf";

/*
*	Dialog
*/
call compile preprocessFileLineNumbers "View\oo_ctrlCreateDialog.sqf";
call compile preprocessFileLineNumbers "View\oo_ctrlModifyDialog.sqf";
call compile preprocessFileLineNumbers "View\oo_DisplayConfig.sqf";
call compile preprocessFileLineNumbers "View\oo_helpDialog.sqf";
call compile preprocessFileLineNumbers "View\oo_fakeDialog.sqf";

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
	"OOP_TextMulti",
	"OOP_TextRight",
	"OOP_Edit",
	"OOP_EditMulti",
	"OOP_Checkbox",
	"OOP_Tree",
	"OOP_Picture",
	"OOP_PictureKeepAspect",
	"OOP_StructuredText",
	"OOP_ActiveText",
	"OOP_ButtonTextOnly",
	"OOP_Slider",
	"OOP_Progress"
];
GuiObject = "new" call oo_GuiEditor;
(findDisplay 46) displayAddEventHandler["KeyDown", 'if( (_this select 1) isEqualTo 0x3B && (findDisplay 4500) isEqualTo displayNull) then{ GuiObject = "new" call oo_GuiEditor; false; };'];