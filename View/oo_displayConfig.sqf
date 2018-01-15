#include "..\oop.h"
CLASS("oo_displayConfig")

	PUBLIC STATIC_UI_VARIABLE("control", "btnClose");
	PUBLIC STATIC_UI_VARIABLE("control", "btnValider");
	PUBLIC STATIC_UI_VARIABLE("control", "editID");
	PUBLIC STATIC_UI_VARIABLE("control", "editName");
	PUBLIC STATIC_UI_VARIABLE("control", "MainLayer");
	PUBLIC STATIC_UI_VARIABLE("display", "Display");

	PUBLIC FUNCTION("", "constructor"){
		disableSerialization;
		if!(createDialog "displayConfig") exitWith { hint "Failed to open NewDialog"; };
		private _display = findDisplay 9008;
		MEMBER("Display", _display);
		MEMBER("MainLayer", _display displayCtrl 0);

		MEMBER("btnClose", _display displayCtrl 10);
		MEMBER("btnValider", _display displayCtrl 9);
		MEMBER("editID", _display displayCtrl 8);
		MEMBER("editName", _display displayCtrl 7);
		MEMBER("Init", nil);
	};
	PUBLIC FUNCTION("", "Init"){
		["setString", [MEMBER("editName", nil), "getDisplayName" call GuiObject]] call HelperGui;
		["setString", [MEMBER("editID", nil), "getDisplayIDD" call GuiObject]] call HelperGui;
	};
	PUBLIC FUNCTION("", "btnAction_btnValider") {
		private _name = ["getString", MEMBER("editName", nil)] call HelperGui;
		_name = ["trim", _name] call HelperGui;
		if (["containSpace", _name] call HelperGui) exitWith {
			hint "Name couldn't have spaces";
		};		
		["setDisplayName", _name ] call GuiObject;
		private _nID = ["getScalar", MEMBER("editID", nil)] call HelperGui;
		hint format["ID:%1",_nID];
		["setDisplayIDD",  _nID] call GuiObject;
		closeDialog 0;
	};

	PUBLIC FUNCTION("", "btnAction_btnClose") {
		closeDialog 0;
	};
	PUBLIC FUNCTION("", "getbtnClose") FUNC_GETVAR("btnClose");
	PUBLIC FUNCTION("", "getbtnValider") FUNC_GETVAR("btnValider");
	PUBLIC FUNCTION("", "getDisplay") FUNC_GETVAR("Display");
	PUBLIC FUNCTION("", "geteditID") FUNC_GETVAR("editID");
	PUBLIC FUNCTION("", "geteditName") FUNC_GETVAR("editName");
	PUBLIC FUNCTION("", "getMainLayer") FUNC_GETVAR("MainLayer");
	PUBLIC FUNCTION("control", "setbtnClose"){ MEMBER("btnClose", _this); };
	PUBLIC FUNCTION("control", "setbtnValider"){ MEMBER("btnValider", _this); };
	PUBLIC FUNCTION("control", "seteditID"){ MEMBER("editID", _this); };
	PUBLIC FUNCTION("control", "seteditName"){ MEMBER("editName", _this); };
	PUBLIC FUNCTION("control", "setMainLayer"){ MEMBER("MainLayer", _this); };
	PUBLIC FUNCTION("display", "setDisplay"){ MEMBER("Display", _this); };
	PUBLIC FUNCTION("", "deconstructor"){
		closeDialog 0;
		DELETE_UI_VARIABLE("btnClose");
		DELETE_UI_VARIABLE("btnValider");
		DELETE_UI_VARIABLE("editID");
		DELETE_UI_VARIABLE("editName");
		DELETE_UI_VARIABLE("MainLayer");
		DELETE_UI_VARIABLE("Display");
	};
ENDCLASS;
