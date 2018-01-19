#include "..\oop.h"
CLASS("oo_ctrlCreateDialog")

	PUBLIC STATIC_UI_VARIABLE("control", "btnClose");
	PUBLIC STATIC_UI_VARIABLE("control", "btnValider");
	PUBLIC STATIC_UI_VARIABLE("control", "listControl");
	PUBLIC STATIC_UI_VARIABLE("control", "MainLayer");
	PUBLIC STATIC_UI_VARIABLE("control", "title");
	PUBLIC STATIC_UI_VARIABLE("display", "Display");

	PUBLIC FUNCTION("display", "constructor"){
		disableSerialization;
		MEMBER("Display", _this);
		MEMBER("MainLayer", _this displayCtrl 100);
		MEMBER("btnClose", _this displayCtrl 105);
		MEMBER("btnValider", _this displayCtrl 104);
		MEMBER("listControl", _this displayCtrl 103);
		MEMBER("title", _this displayCtrl 102);
		MEMBER("Init", nil);
	};
	PUBLIC FUNCTION("", "Init"){
		//Add your content here to init display
		{
			MEMBER("listControl", nil) lbAdd _x;
			MEMBER("listControl", nil) lbSetData[_forEachIndex, _x];
		}forEach OOP_GuiEditor_ListControl;
	};

	//You could check: https://community.bistudio.com/wiki/User_Interface_Event_Handlers
	PUBLIC FUNCTION("any", "Init_listControl") {
		//import your content
		
	};

	/*
	*	onLBDblClick:
	*		Double click on some row in listbox.
	*		Returns the control and the selected element index.
	*/
	PUBLIC FUNCTION("array", "onLBDblClick_listControl") {
		private _control = _this select 0;
		private _index = _this select 1;
		MEMBER("btnAction_btnValider", nil);
	};

	/*
	*	onLBSelChanged:
	*		The selection in a listbox is changed. The left mouse button has been released and the new selection is fully made.
	*		Returns the control and the selected element index.
	*/
	PUBLIC FUNCTION("array", "onLBSelChanged_listControl") {
		private _control = _this select 0;
		private _index = _this select 1;
		hint ((_this select 0) lbData (_this select 1));
	};

	PUBLIC FUNCTION("", "btnAction_btnValider") {
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

	PUBLIC FUNCTION("", "btnAction_btnClose") {
		closeDialog 0;
	};
	PUBLIC FUNCTION("", "getbtnClose") FUNC_GETVAR("btnClose");
	PUBLIC FUNCTION("", "getbtnValider") FUNC_GETVAR("btnValider");
	PUBLIC FUNCTION("", "getDisplay") FUNC_GETVAR("Display");
	PUBLIC FUNCTION("", "getlistControl") FUNC_GETVAR("listControl");
	PUBLIC FUNCTION("", "getMainLayer") FUNC_GETVAR("MainLayer");
	PUBLIC FUNCTION("", "gettitle") FUNC_GETVAR("title");
	PUBLIC FUNCTION("control", "setbtnClose"){ MEMBER("btnClose", _this); };
	PUBLIC FUNCTION("control", "setbtnValider"){ MEMBER("btnValider", _this); };
	PUBLIC FUNCTION("control", "setlistControl"){ MEMBER("listControl", _this); };
	PUBLIC FUNCTION("control", "setMainLayer"){ MEMBER("MainLayer", _this); };
	PUBLIC FUNCTION("control", "settitle"){ MEMBER("title", _this); };
	PUBLIC FUNCTION("display", "setDisplay"){ MEMBER("Display", _this); };
	PUBLIC FUNCTION("", "deconstructor"){
		DELETE_UI_VARIABLE("btnClose");
		DELETE_UI_VARIABLE("btnValider");
		DELETE_UI_VARIABLE("listControl");
		DELETE_UI_VARIABLE("MainLayer");
		DELETE_UI_VARIABLE("title");
		DELETE_UI_VARIABLE("Display");
	};
ENDCLASS;