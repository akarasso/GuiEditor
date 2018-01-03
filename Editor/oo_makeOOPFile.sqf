#include "..\oop.h"
CLASS_EXTENDS("oo_makeOOPFile", "oo_makeFile")
	PUBLIC VARIABLE("string", "ClassName");
	PUBLIC VARIABLE("scalar", "IDD");

	PUBLIC VARIABLE("array", "Constructor");
	PUBLIC VARIABLE("array", "Functions");
	PUBLIC VARIABLE("array", "Variables");
	PUBLIC VARIABLE("array", "UIVariables");
	
	PUBLIC FUNCTION("string","constructor") { 
		if (isNil {MEMBER("HelperGui", nil)}) then {
			private _g = "new" call oo_HelperGui;
			MEMBER("HelperGui", _g);
		};
		private _string="
";
		MEMBER("IDD", 0);
		MEMBER("Tab", 0);
		MEMBER("CR", _string);
		MEMBER("Path", (_this + "|"));
		MEMBER("Mode", "");
		MEMBER("Buffer", "");

		private _v = ["public","display","Display"];
		MEMBER("addVar", _v);
		
	};

	PUBLIC FUNCTION("array","addVar") {
		if (isNil {MEMBER("Variables", nil)}) then {
			MEMBER("Variables", []);
		};
		private _level = toUpper (_this select 0);
		private _typeName = toLower (_this select 1);
		private _name = _this select 2;
		MEMBER("Variables", nil) pushBack [_level, _typeName, _name];
	};

	PUBLIC FUNCTION("array","addUIVar") {
		if (isNil {MEMBER("UIVariables", nil)}) then {
			MEMBER("UIVariables", []);
		};
		private _level = toUpper (_this select 0);
		private _typeName = toLower (_this select 1);
		private _name = _this select 2;
		MEMBER("UIVariables", nil) pushBack [_level, _typeName, _name];
	};

	PUBLIC FUNCTION("string","addSuper") {
		if (isNil {MEMBER("Constructor", nil)}) then {
			MEMBER("Constructor", []);
		};
		MEMBER("Constructor", nil) pushBack _this;
	};

	PUBLIC FUNCTION("array","addFunction") {
		if (isNil {MEMBER("Functions", nil)}) then {
			MEMBER("Functions", []);
		};
		MEMBER("Functions", nil) pushBack _this;
	};

	PUBLIC FUNCTION("string","addFunction") {
		if (isNil {MEMBER("Functions", nil)}) then {
			MEMBER("Functions", []);
		};
		MEMBER("Functions", nil) pushBack ["array",_this];
	};

	PUBLIC FUNCTION("","exec") {
		if (isNil {MEMBER("ClassName", nil)}) then {
			MEMBER("ClassName", "undefinded");
		};
		private "_newVar", "_function", _string = "", _string2 = "", _string3 = "";
		MEMBER("Buffer", "");
		MEMBER("pushLine", '#include "oop.h"');

		_string = "CLASS(%1)";
		_string2 = format['"oo_%1"', MEMBER("ClassName", nil)];
		_string = ["stringFormat", [_string, [_string2]]] call MEMBER("HelperGui", nil);

		MEMBER("pushLine", _string );
		MEMBER("modTab", +1);

		//Adding variables to our class
		MEMBER("pushLineBreak", nil);
		{
			_string = (_x select 0) + " STATIC_UI_VARIABLE(%1, %2);";
			_string2 = format['"%1"', _x select 1];
			_string3 = format['"%1"', _x select 2];
			_string = ["stringFormat", [_string, [_string2, _string3]]] call MEMBER("HelperGui", nil);
			MEMBER("pushLine", _string);
		} forEach MEMBER("UIVariables", nil);
		MEMBER("pushLineBreak", nil);
		{
			_string = (_x select 0) + " STATIC_VARIABLE(%1, %2);";
			_string2 = format['"%1"', _x select 1];
			_string3 = format['"%1"', _x select 2];
			_string = ["stringFormat", [_string, [_string2, _string3]]] call MEMBER("HelperGui", nil);
			MEMBER("pushLine", _string);
		} forEach MEMBER("Variables", nil);
		MEMBER("pushLineBreak", nil);

		//Constructor
		_string = "PUBLIC FUNCTION(%1, %2){";
		_string = ["stringFormat", [_string, ['""', '"constructor"']]] call MEMBER("HelperGui", nil);
		MEMBER("pushLine", _string );
		
		MEMBER("modTab", +1);
		MEMBER("pushLine", "disableSerialization;");
		private _s = format['if!(createDialog "%1") exitWith { hint "Failed to open %1"; };', MEMBER("ClassName", nil)];
		MEMBER("pushLine", _s);
		_string = "MEMBER(%1, findDisplay %2);";
		_string = ["stringFormat", [_string, ['"Display"', str MEMBER("IDD", nil)]]] call MEMBER("HelperGui", nil);
		MEMBER("pushLine", _string);
		{
			MEMBER("pushLine", _x);
		} forEach MEMBER("Constructor", nil);
		// //Add line to enable 
		MEMBER("modTab", -1);
		MEMBER("pushLine", "};" );
		MEMBER("pushLineBreak", nil);

		//Add function
		{
			_string = "PUBLIC FUNCTION(%1, %2){";
			_string2 = format['"%1"',_x select 0];
			_string3 = format['"%1"',_x select 1];
			_string = ["stringFormat", [_string, [_string2, _string3]] ] call MEMBER("HelperGui", nil);
			MEMBER("pushLine", _string );
			MEMBER("modTab", +1);
			MEMBER("pushLineBreak", nil);
			MEMBER("modTab", -1);
			MEMBER("pushLine", '};' );
			MEMBER("pushLineBreak", nil);
		} forEach MEMBER("Functions", nil);

		MEMBER("modTab", -1);
		MEMBER("pushLine", "ENDCLASS;");

		// //Spécifique Function
		copyToClipboard MEMBER("Buffer", nil);
		MEMBER("Buffer", "");
	};

	PUBLIC FUNCTION("scalar","setIDD") {
		MEMBER("IDD", _this);
	};

	PUBLIC FUNCTION("string","setClassName") {
		MEMBER("ClassName", _this);
	};
ENDCLASS;