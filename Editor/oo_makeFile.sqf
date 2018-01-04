#include "..\oop.h"
CLASS("oo_makeFile")
	PUBLIC STATIC_VARIABLE("string", "CR");
	PUBLIC STATIC_VARIABLE("code", "HelperGui");
	PUBLIC VARIABLE("scalar", "Tab");
	PUBLIC VARIABLE("string", "Path");
	PUBLIC VARIABLE("string", "Mode");
	PUBLIC VARIABLE("string", "Buffer");
	
	PUBLIC FUNCTION("string","constructor") { 
		if (isNil {MEMBER("HelperGui", nil)}) then {
			private _g = "new" call oo_HelperGui;
			MEMBER("HelperGui", _g);
		};
		private _string="
";
		MEMBER("Tab", 0);
		MEMBER("CR", _string);
		MEMBER("Path", (_this + "|"));
		MEMBER("Mode", "");
		MEMBER("Buffer", "");
	};

	/*
	*	Change write mode : add/write new file
	*	@input:string [write/add]
	*/
	PUBLIC FUNCTION("string","setMode") {
		if !(_this in ["write", "add"]) exitWith {
			hint "Only mode write|add are available";
		};
		MEMBER("Mode", (_this + "|"));
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
		MEMBER("Buffer", MEMBER("Buffer", nil) + _this + MEMBER("CR", nil) );
	};

	/*
	*	Push CR
	*/
	PUBLIC FUNCTION("","pushLineBreak") {
		MEMBER("Buffer", MEMBER("Buffer", nil) + MEMBER("CR", nil) );
	};

	/*
	*	Change name of file to write
	*	@input:string Name of file
	*/
	PUBLIC FUNCTION("string","setPath") {
		MEMBER("Path", (_this + "|"));
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

	/*
	*	Return string Buffer
	*/
	PUBLIC FUNCTION("","getBuffer") {
		MEMBER("Buffer", nil);
	};
ENDCLASS;