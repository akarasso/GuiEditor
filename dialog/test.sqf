#include "..\oop.h"
CLASS("oo_Test")


	PUBLIC STATIC_UI_VARIABLE("display", "Display");
	PUBLIC STATIC_UI_VARIABLE("control", "OOP_Listbox_4");
	PUBLIC STATIC_UI_VARIABLE("control", "btnClose");

	PUBLIC FUNCTION("", "constructor"){
		disableSerialization;
		if!(createDialog "Test") exitWith { hint "Failed to open Test"; };
		MEMBER("Display", findDisplay 5000);
		MEMBER("OOP_Listbox_4", MEMBER("Display",nil) displayCtrl 4);
		MEMBER("Init_OOP_Listbox_4", nil);
		MEMBER("btnClose", MEMBER("Display",nil) displayCtrl 6);
	};

	PUBLIC FUNCTION("", "Init_OOP_Listbox_4"){
		for "_i" from 0 to 100 do {
			MEMBER("OOP_Listbox_4", nil) lbAdd format["Item:%1", _i];
			MEMBER("OOP_Listbox_4", nil) lbSetValue [_i, _i];
		};
	};

	PUBLIC FUNCTION("array", "onLBSelChanged_OOP_Listbox_4"){
		private _itemSel = MEMBER("OOP_Listbox_4", nil) lbValue (_this select 1);
		hint format["%1",_itemSel];
	};

	PUBLIC FUNCTION("", "btnAction_btnValide"){
		hint "Valider";
	};

	PUBLIC FUNCTION("array", "onMouseEnter_btnClose"){
		hint "you enter out from close btn";
	};

	PUBLIC FUNCTION("array", "onMouseExit_btnClose"){
		hint "you move out from close btn";
	};

	PUBLIC FUNCTION("", "btnAction_btnClose"){
		hint "Close";
	};

ENDCLASS;
