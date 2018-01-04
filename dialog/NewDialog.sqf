#include "..\oop.h"
CLASS("oo_NewDialog")

	PUBLIC STATIC_UI_VARIABLE("display", "Display");
	PUBLIC STATIC_UI_VARIABLE("control", "btnValideDisplay");
	PUBLIC STATIC_UI_VARIABLE("control", "itemShop");


	PUBLIC FUNCTION("", "constructor"){
		disableSerialization;
		if!(createDialog "NewDialog") exitWith { hint "Failed to open NewDialog"; };
		MEMBER("Display", findDisplay 1000);
		MEMBER("btnValideDisplay", MEMBER("Display",nil) displayCtrl 3);
		MEMBER("Init_btnValideDisplay", nil);
		MEMBER("itemShop", MEMBER("Display",nil) displayCtrl 4);
		MEMBER("Init_itemShop", nil);
	};

	PUBLIC FUNCTION("", "Init_btnValideDisplay"){

	};

	PUBLIC FUNCTION("", "btnAction_btnValideDisplay"){
		hint "Valider";
	};

	PUBLIC FUNCTION("", "Init_itemShop"){
		for "_i" from 0 to 100 do {
			MEMBER("itemShop", nil) lbAdd format["Item:%1",_i];
		};
	};

ENDCLASS;
