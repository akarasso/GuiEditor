#include "..\oop.h"
CLASS_EXTENDS("oo_makeOOPFile", "oo_makeFile")
	PUBLIC VARIABLE("string", "ClassName");
	PUBLIC VARIABLE("scalar", "IDD");

	PUBLIC VARIABLE("array", "Constructor");
	PUBLIC VARIABLE("array", "Functions");
	PUBLIC VARIABLE("array", "Variables");
	
	PUBLIC FUNCTION("string","constructor") { 
		private _string="
";
		MEMBER("IDD", 0);
		MEMBER("Tab", 0);
		MEMBER("CR", _string);
		MEMBER("Path", (_this + "|"));
		MEMBER("Mode", "");
		MEMBER("Buffer", "");

		private _v = ["public","display","DisplayName"];
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
		private "_newVar", "_function";
		MEMBER("Buffer", "");
		MEMBER("pushLine", '#include "oop.h"');
		private _s = format["CLASS('oo_%1')", MEMBER("ClassName", nil)];
		MEMBER("pushLine", _s );
		MEMBER("modTab", +1);

		//Adding variables to our class
		MEMBER("pushLineBreak", nil);
		{
			_newVar = format["%1 VARIABLES('%2','%3');",_x select 0, _x select 1, _x select 2];
			MEMBER("pushLine", _newVar);
		} forEach MEMBER("Variables", nil);
		MEMBER("pushLineBreak", nil);

		// //Constructor
		MEMBER("pushLine", "PUBLIC FUNCTION('', 'constructor'){" );
		
		MEMBER("modTab", +1);
		MEMBER("pushLine", "createDialog 'dialog.hpp';");
		_v = format["MEMBER('display', findDisplay %1);", MEMBER("IDD", nil)];
		MEMBER("pushLine", _v);
		{
			MEMBER("pushLine", _x);
		} forEach MEMBER("Constructor", nil);
		// //Add line to enable 
		MEMBER("modTab", -1);
		MEMBER("pushLine", '};' );
		MEMBER("pushLineBreak", nil);

		//Add function
		{
			_function = format["PUBLIC FUNCTION('%1','%2'){",_x select 0, _x select 1];
			MEMBER("pushLine", _function );
			MEMBER("modTab", +1);
			MEMBER("pushLineBreak", nil);
			MEMBER("modTab", -1);
			MEMBER("pushLine", '};' );
			MEMBER("pushLineBreak", nil);
		} forEach MEMBER("Functions", nil);

		MEMBER("modTab", -1);
		MEMBER("pushLine", '};');

		// //Spécifique Function
		copyToClipboard MEMBER("Buffer", nil);
	};

	PUBLIC FUNCTION("scalar","setIDD") {
		MEMBER("IDD", _this);
	};

	PUBLIC FUNCTION("string","setClassName") {
		MEMBER("ClassName", _this);
	};
ENDCLASS;