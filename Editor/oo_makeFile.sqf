#include "..\oop.h"
CLASS("oo_makeFile")
	PUBLIC STATIC_VARIABLE("string", "CR");
	PUBLIC VARIABLE("scalar", "Tab");
	PUBLIC VARIABLE("string", "Path");
	PUBLIC VARIABLE("string", "Mode");
	PUBLIC VARIABLE("string", "Buffer");
	
	PUBLIC FUNCTION("string","constructor") { 
		private _string="
";
		MEMBER("Tab", 0);
		MEMBER("CR", _string);
		MEMBER("Path", (_this + "|"));
		MEMBER("Mode", "");
		MEMBER("Buffer", "");
	};

	PUBLIC FUNCTION("string","setMode") {
		if !(_this in ["write", "add"]) exitWith {
			hint "Only mode write|add are available";
		};
		MEMBER("Mode", (_this + "|"));
	};

	PUBLIC FUNCTION("string","push") {
		MEMBER("Buffer", MEMBER("Buffer", nil) + _this );
	};

	PUBLIC FUNCTION("string","pushLine") {
		for "_i" from 0 to MEMBER("Tab", nil)-1 do {
			MEMBER("Buffer", MEMBER("Buffer", nil) + "	");
		};
		MEMBER("Buffer", MEMBER("Buffer", nil) + _this + MEMBER("CR", nil) );
	};

	PUBLIC FUNCTION("","pushLineBreak") {
		MEMBER("Buffer", MEMBER("Buffer", nil) + MEMBER("CR", nil) );
	};

	PUBLIC FUNCTION("string","setPath") {
		MEMBER("Path", (_this + "|"));
	};

	PUBLIC FUNCTION("scalar","modTab") {
		if ((MEMBER("Tab", nil) + _this) < 0) exitWith {};
		MEMBER("Tab", MEMBER("Tab", nil) + _this);
	};

	PUBLIC FUNCTION("","exec") {
		"make_file" callExtension (MEMBER("Path", nil) + MEMBER("Mode", nil) + MEMBER("Buffer", nil));
		MEMBER("Buffer", "");
	};

	PUBLIC FUNCTION("","getBuffer") {
		MEMBER("Buffer", nil);
	};
ENDCLASS;