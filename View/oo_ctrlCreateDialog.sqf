#include "..\oop.h"
CLASS("oo_ctrlCreateDialog")

	PUBLIC STATIC_UI_VARIABLE("display", "Display");
	PUBLIC STATIC_UI_VARIABLE("control", "listControl");
	PUBLIC STATIC_UI_VARIABLE("control", "btnValider");
	PUBLIC STATIC_UI_VARIABLE("control", "btnClose");


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
		private _guiHelperEvent = "getGuiHelperEvent" call GuiObject;
		private _clickPos = "getMouseClick" call _guiHelperEvent;
		["setPos", _clickPos] spawn _newInstance;
		closeDialog 0;
		hint "VALIDER";
	};

	PUBLIC FUNCTION("", "btnAction_btnClose"){
		closeDialog 0;
		hint "CLOSE";
	};	
ENDCLASS;