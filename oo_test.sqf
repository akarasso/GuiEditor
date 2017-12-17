#include "oop.h"
CLASS("OO_test")
	PUBLIC UI_VARIABLE("display", "D");
	PUBLIC UI_VARIABLE("control", "C");
	
	PUBLIC FUNCTION("","constructor") { 
		
	};

	PUBLIC FUNCTION("","test") {
		disableSerialization;
		if(createDialog "Empty") then {
			MEMBER("D", (findDisplay 4500));
			diag_log format["La variable display vaut:%1",MEMBER("D", nil)];
			private _c = (findDisplay 4500) ctrlCreate["FullBackground", 1];
			MEMBER("C", _c);
			diag_log format["La variable control vaut:%1",MEMBER("C", nil)];
		};
	};

	PUBLIC FUNCTION("","deconstructor") { 
		DELETE_UI_VARIABLE("D");
		DELETE_UI_VARIABLE("C");
		diag_log format["La variable display un fois delete vaut:%1",MEMBER("D", nil)];
		diag_log format["La variable control un fois delete vaut:%1",MEMBER("C", nil)];
	};
ENDCLASS;	