#include "..\oop.h"
CLASS("oo_NewDialog")

	PUBLIC STATIC_UI_VARIABLE("control", "life_RscPicture_2");

	PUBLIC STATIC_VARIABLE("display", "Display");

	PUBLIC FUNCTION("", "constructor"){
		disableSerialization;
		if!(createDialog "NewDialog") exitWith { hint "Failed to open NewDialog"; };
		MEMBER("Display", findDisplay 1000);
		MEMBER("life_RscPicture_2", MEMBER("Display",nil) displayCtrl 2);
		MEMBER("life_RscPicture_2", nil) ctrlEnable true;
	};

	PUBLIC FUNCTION("array", "onMouseButtonDown_life_RscPicture_2"){
		hint "click";
	};

ENDCLASS;
