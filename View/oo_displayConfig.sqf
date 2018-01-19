#include "..\oop.h"
CLASS("oo_DisplayConfig")

	PUBLIC STATIC_UI_VARIABLE("control", "btnClose");
	PUBLIC STATIC_UI_VARIABLE("control", "btnValider");
	PUBLIC STATIC_UI_VARIABLE("control", "editIDD");
	PUBLIC STATIC_UI_VARIABLE("control", "editName");
	PUBLIC STATIC_UI_VARIABLE("control", "MainLayer");
	PUBLIC STATIC_UI_VARIABLE("display", "Display");

	PUBLIC FUNCTION("display", "constructor"){
		disableSerialization;
		MEMBER("Display", _this);
		MEMBER("MainLayer", _this displayCtrl 100);
		MEMBER("btnClose", _this displayCtrl 108);
		MEMBER("btnValider", _this displayCtrl 107);
		MEMBER("editIDD", _this displayCtrl 106);
		MEMBER("editName", _this displayCtrl 105);
		MEMBER("Init", nil);
	};
	PUBLIC FUNCTION("", "Init"){
		//Add your content here to init display
		["setString", [MEMBER("editName", nil), "getDisplayName" call GuiObject]] call HelperGui;
		["setString", [MEMBER("editIDD", nil), "getDisplayIDD" call GuiObject]] call HelperGui;
	};

	PUBLIC FUNCTION("", "btnAction_btnValider") {
		private _name = ["getString", MEMBER("editName", nil)] call HelperGui;
		_name = ["trim", _name] call HelperGui;
		if (["containSpace", _name] call HelperGui) exitWith {
			hint "Name couldn't have spaces";
		};		
		["setDisplayName", _name ] call GuiObject;
		private _nID = ["getScalar", MEMBER("editIDD", nil)] call HelperGui;
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
	PUBLIC FUNCTION("", "geteditIDD") FUNC_GETVAR("editIDD");
	PUBLIC FUNCTION("", "geteditName") FUNC_GETVAR("editName");
	PUBLIC FUNCTION("", "getMainLayer") FUNC_GETVAR("MainLayer");
	PUBLIC FUNCTION("control", "setbtnClose"){ MEMBER("btnClose", _this); };
	PUBLIC FUNCTION("control", "setbtnValider"){ MEMBER("btnValider", _this); };
	PUBLIC FUNCTION("control", "seteditIDD"){ MEMBER("editIDD", _this); };
	PUBLIC FUNCTION("control", "seteditName"){ MEMBER("editName", _this); };
	PUBLIC FUNCTION("control", "setMainLayer"){ MEMBER("MainLayer", _this); };
	PUBLIC FUNCTION("display", "setDisplay"){ MEMBER("Display", _this); };
	PUBLIC FUNCTION("", "deconstructor"){
		DELETE_UI_VARIABLE("btnClose");
		DELETE_UI_VARIABLE("btnValider");
		DELETE_UI_VARIABLE("editIDD");
		DELETE_UI_VARIABLE("editName");
		DELETE_UI_VARIABLE("MainLayer");
		DELETE_UI_VARIABLE("Display");
	};
ENDCLASS;