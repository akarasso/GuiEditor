#include "..\oop.h"
CLASS("oo_ctrlCreateDialog")

	PUBLIC STATIC_UI_VARIABLE("display", "Display");
	PUBLIC STATIC_UI_VARIABLE("control", "listControl");
	PUBLIC STATIC_UI_VARIABLE("control", "btnValider");
	PUBLIC STATIC_UI_VARIABLE("control", "btnClose");
	
	PUBLIC STATIC_UI_VARIABLE("array", "MetaControl");

	//[ [id, {control}] ]
	PUBLIC FUNCTION("", "constructor"){
		disableSerialization;
		if!(createDialog "ctrlCreateDialog") exitWith { hint "Failed to open ctrlCreateDialog"; };
		MEMBER("Display", findDisplay 9000);
		MEMBER("listControl", (MEMBER("Display",nil) displayCtrl 4));
		MEMBER("Init_listControl", nil);
		MEMBER("btnValider", (MEMBER("Display",nil) displayCtrl 5));
		MEMBER("btnClose", (MEMBER("Display",nil) displayCtrl 6));
	};

	PUBLIC FUNCTION("", "Init_listControl"){
		{
			MEMBER("listControl", nil) lbAdd _x;
			MEMBER("listControl", nil) lbSetData[_forEachIndex, _x];
		}forEach OOP_GuiEditor_ListControl;
	};

	PUBLIC FUNCTION("array", "onLBDblClick_listControl"){
		MEMBER("btnAction_btnValider", nil);
	};

	PUBLIC FUNCTION("array", "onLBSelChanged_listControl"){
		hint ((_this select 0) lbData (_this select 1));
	};

	PUBLIC FUNCTION("", "btnAction_btnValider"){
		disableSerialization;
		private _selection = MEMBER("listControl", nil) lbData (lbCurSel MEMBER("listControl", nil));
		private _newInstance = ["ctrlCreate", _selection] call GuiObject;
		if (_newInstance isEqualTo {}) exitWith {};
		private _workground = "getWorkground" call GuiObject;
		["pushChild", _newInstance] call _workground;
		private _guiHelperEvent = "getGuiHelperEvent" call GuiObject;
		private _clickPos = "getMouseClick" call _guiHelperEvent;
		"refreshTree" call _guiHelperEvent;
		["setPos", _clickPos] call _newInstance;
		closeDialog 0;
	};

	PUBLIC FUNCTION("scalar","requestMeta") {
		private _return = {};
		{
			if (_x select 0 isEqualTo _this) exitWith {
				_return = _x select 1;
			};
		} forEach MEMBER("MetaControl", nil);
		_return;
	};

	PUBLIC FUNCTION("", "btnAction_btnClose"){
		closeDialog 0;
	};	
ENDCLASS;