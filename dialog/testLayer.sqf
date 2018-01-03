#include "..\oop.h"
CLASS("oo_NewDialog")


	PUBLIC STATIC_UI_VARIABLE("display", "Display");
	PUBLIC STATIC_UI_VARIABLE("control", "OOP_Button_4");
	PUBLIC STATIC_UI_VARIABLE("control", "OOP_Button_5");
	PUBLIC STATIC_UI_VARIABLE("control", "OOP_Button_6");
	PUBLIC STATIC_UI_VARIABLE("control", "OOP_Listbox_10");
	PUBLIC STATIC_UI_VARIABLE("control", "life_RscPicture_10");

	PUBLIC FUNCTION("", "constructor"){
		disableSerialization;
		if!(createDialog "NewDialog") exitWith { hint "Failed to open NewDialog"; };
		MEMBER("Display", findDisplay 1000);
		MEMBER("OOP_Button_4", MEMBER("Display",nil) displayCtrl 4);
		MEMBER("Init_OOP_Button_4", nil);
		MEMBER("OOP_Button_5", MEMBER("Display",nil) displayCtrl 5);
		MEMBER("Init_OOP_Button_5", nil);
		MEMBER("OOP_Button_6", MEMBER("Display",nil) displayCtrl 6);
		MEMBER("Init_OOP_Button_6", nil);
		MEMBER("OOP_Listbox_10", MEMBER("Display",nil) displayCtrl 10);
		MEMBER("Init_OOP_Listbox_10", nil);
		(MEMBER("Display", nil) displayCtrl 8) ctrlShow false;
		MEMBER("life_RscPicture_10", MEMBER("Display",nil) displayCtrl 10);
		
		//Version format["..."]
		(MEMBER("Display", nil) displayCtrl 9) ctrlShow false;
		//Version format['...'']
		([_classID, member, SAFE_VAR(args), access] call GETCLASS(className))

	};

	PUBLIC FUNCTION("", "Init_OOP_Button_4"){
		(MEMBER("Display", nil) displayCtrl 7) ctrlShow true;
		(MEMBER("Display", nil) displayCtrl 8) ctrlShow false;
		(MEMBER("Display", nil) displayCtrl 9) ctrlShow false;
	};

	PUBLIC FUNCTION("", "btnAction_OOP_Button_4"){
		(MEMBER("Display", nil) displayCtrl 7) ctrlShow true;
		(MEMBER("Display", nil) displayCtrl 8) ctrlShow false;
		(MEMBER("Display", nil) displayCtrl 9) ctrlShow false;
	};

	PUBLIC FUNCTION("", "Init_OOP_Button_5"){
		(MEMBER("Display", nil) displayCtrl 7) ctrlShow false;
		(MEMBER("Display", nil) displayCtrl 8) ctrlShow true;
		(MEMBER("Display", nil) displayCtrl 9) ctrlShow false;
	};

	PUBLIC FUNCTION("", "btnAction_OOP_Button_5"){
		(MEMBER("Display", nil) displayCtrl 7) ctrlShow false;
		(MEMBER("Display", nil) displayCtrl 8) ctrlShow true;
		(MEMBER("Display", nil) displayCtrl 9) ctrlShow false;
	};

	PUBLIC FUNCTION("", "Init_OOP_Button_6"){
		(MEMBER("Display", nil) displayCtrl 7) ctrlShow false;
		(MEMBER("Display", nil) displayCtrl 8) ctrlShow false;
		(MEMBER("Display", nil) displayCtrl 9) ctrlShow true;
	};

	PUBLIC FUNCTION("", "btnAction_OOP_Button_6"){
		(MEMBER("Display", nil) displayCtrl 7) ctrlShow false;
		(MEMBER("Display", nil) displayCtrl 8) ctrlShow false;
		(MEMBER("Display", nil) displayCtrl 9) ctrlShow true;
	};

	PUBLIC FUNCTION("", "Init_OOP_Listbox_10"){
		for "_i" from 0 to 100 -1 do {
			MEMBER("OOP_Listbox_10", nil) lbAdd format["Item:%1",_i];
		};
	};

	PUBLIC FUNCTION("array", "onLBSelChanged_OOP_Listbox_10"){
		hint format["Selection!%1", _this select 1];
	};

	PUBLIC FUNCTION("array", "onMouseEnter_life_RscPicture_10"){
		hint "you enter in red zone";
	};	

	PUBLIC FUNCTION("", "btnAction_btnV"){
		hint "valide";
	};

	PUBLIC FUNCTION("", "btnAction_btnClose"){
		hint "close";
	};

ENDCLASS;
