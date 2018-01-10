#include "..\oop.h"
CLASS("oo_makeFile")

	
	PUBLIC VARIABLE("scalar", "Tab");
	PUBLIC VARIABLE("string", "Path");
	PUBLIC VARIABLE("string", "Buffer");
	
	PUBLIC FUNCTION("string","constructor") { 
		MEMBER("Tab", 0);
		MEMBER("Buffer", "");
	};

	/*
	*	Push string at the end of buffer
	*/
	PUBLIC FUNCTION("string","push") {
		MEMBER("Buffer", MEMBER("Buffer", nil) + _this );
	};

	/*
	*	Push string at the end of buffer & put CR
	*/
	PUBLIC FUNCTION("string","pushLine") {
		for "_i" from 0 to MEMBER("Tab", nil)-1 do {
			MEMBER("Buffer", MEMBER("Buffer", nil) + "	");
		};
		MEMBER("Buffer", MEMBER("Buffer", nil) + _this + endl );
	};

	/*
	*	Push CR
	*/
	PUBLIC FUNCTION("","pushLineBreak") {
		MEMBER("Buffer", MEMBER("Buffer", nil) + endl );
	};

	/*
	*	Modify number of tabulation to do before push line
	*/
	PUBLIC FUNCTION("scalar","modTab") {
		if ((MEMBER("Tab", nil) + _this) < 0) exitWith {};
		MEMBER("Tab", MEMBER("Tab", nil) + _this);
	};

	/*
	*	Copy all buffer inside clipboard
	*/
	PUBLIC FUNCTION("","exec") {
		copyToClipboard MEMBER("Buffer", nil);
		MEMBER("Buffer", "");
	};
ENDCLASS;