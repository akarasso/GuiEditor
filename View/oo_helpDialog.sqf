#include "..\oop.h"
CLASS("oo_helpDialog")

	PUBLIC STATIC_UI_VARIABLE("control", "MainLayer");
	PUBLIC STATIC_UI_VARIABLE("display", "Display");

	PUBLIC FUNCTION("", "constructor"){
		disableSerialization;
		if!(createDialog "helpDialog") exitWith { hint "Failed to open helpDialog"; };
		private _display = findDisplay 9009;
		MEMBER("Display", _display);
		MEMBER("MainLayer", _display displayCtrl 0);

		MEMBER("Init", nil);
	};
	PUBLIC FUNCTION("", "Init"){
		//Add your content here to init display
	};
	PUBLIC FUNCTION("", "getDisplay") FUNC_GETVAR("Display");
	PUBLIC FUNCTION("", "getMainLayer") FUNC_GETVAR("MainLayer");
	PUBLIC FUNCTION("control", "setMainLayer"){ MEMBER("MainLayer", _this); };
	PUBLIC FUNCTION("display", "setDisplay"){ MEMBER("Display", _this); };
	PUBLIC FUNCTION("", "deconstructor"){
		closeDialog 0;
		DELETE_UI_VARIABLE("MainLayer");
		DELETE_UI_VARIABLE("Display");
	};
ENDCLASS;
