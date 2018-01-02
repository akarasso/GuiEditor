#include "..\oop.h"
CLASS("oo_makeOPPFile")
	PUBLIC STATIC_VARIABLE("string", "CR");
	PUBLIC VARIABLE("scalar", "Tab");
	PUBLIC VARIABLE("string", "Path");
	PUBLIC VARIABLE("string", "Mode");


	PUBLIC VARIABLE("string", "ClassName");
	PUBLIC VARIABLE("array", "Constructor");
	PUBLIC VARIABLE("array", "Vars");
	
	PUBLIC VARIABLE("string", "Buffer");
	
	PUBLIC FUNCTION("string","constructor") { 
		private _string="
";
		MEMBER("Tab", 0);
		MEMBER("CR", _string);
		MEMBER("Constructor", []);
		MEMBER("Vars", []);

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

	PUBLIC FUNCTION("string","addConstructorLine") {
		MEMBER("Constructor", nil) pushBack _this;
	};

	PUBLIC FUNCTION("array","addVars") {
		private _privacy = toUpper (_this select 0);
		private _type = toLower (_this select 1);
		private _name = _this select 2;
		MEMBER("Vars", nil) pushBack (format['%1 VARIABLE("%2", "%3");', _privacy, _type, _name]);
	};

	PUBLIC FUNCTION("","exec") {
		"make_file" callExtension (MEMBER("Path", nil) + MEMBER("Mode", nil) + MEMBER("Buffer", nil));
		MEMBER("Buffer", "");
	};

	PUBLIC FUNCTION("","constructBuffer") {
		MEMBER("Buffer", "");
		MEMBER("pushLine", '#include "oop.h"');
		MEMBER("pushLine", format['CLASS("oo_%1")', MEMBER("ClassName", nil)] );

		//Constructor
		MEMBER("modTab", +1);
		MEMBER("pushLine", 'PUBLIC FUNCTION ("", "constructor"){' );
		MEMBER("modTab", +1);
		MEMBER("pushLine", 'createDialog "dialog.hpp";');
		MEMBER("pushLine", format['MEMBER("Display", %1);', 1000]);
		{
			MEMBER("pushLine", _x);
		} forEach MEMBER("Constructor", nil);
		//Add line to enable 

		MEMBER("modTab", -1);
		MEMBER("pushLine", '};' );

		//Spécifique Function

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

	

	PUBLIC FUNCTION("","getBuffer") {
		MEMBER("Buffer", nil);
	};

	PUBLIC FUNCTION("string","setClassName") {
		MEMBER("ClassName", _this);
	};
ENDCLASS;