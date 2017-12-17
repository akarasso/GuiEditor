#include "..\oop.h"
CLASS("oo_makeFile")
	PUBLIC VARIABLE("string", "Path");
	PUBLIC VARIABLE("string", "Name");
	PUBLIC VARIABLE("array", "File");

	/*
	* Constructor
	* @input:string => PathTo
	*/
	PUBLIC FUNCTION("string", "constructor") {
		private _a = toArray _this;
		if !((_a select ((count _a)-1)) isEqualTo 47) then {
			_a pushBack 47;
		};
		_this = toString _a;
		MEMBER("Path", _this);
		MEMBER("Name", "");
	};

	/*
	*	Clean and write all file
	*/
	PUBLIC FUNCTION("string","write") {
		MEMBER("write", [_this]);
	};

	/*
	*	Clean and write all file
	*/
	PUBLIC FUNCTION("array", "write") {
		private _string = "";
		if ((MEMBER("Name", nil)) isEqualTo "") exitWith {
			hint "You must specify file name";
		};
		for "_i" from 0 to count _this -1 do {
			_s = _this select _i;
			_string = _string + _s + "\n";
		};
		private _cmd = format["%1%2|%3", MEMBER("Path", nil), MEMBER("Name", nil), _string];
		diag_log _cmd;
		private _return = "make_file" callExtension _cmd;
		if (_return isEqualTo "OK") then {
			hint format["Success to add line to file:%2 in %1", MEMBER("Path", nil), MEMBER("Name", nil)];
		};
	};

	PUBLIC FUNCTION("string", "setFileName") {
		MEMBER("Name", _this);
	};

	PUBLIC FUNCTION("","getPath") FUNC_GETVAR("Path");
	PUBLIC FUNCTION("","getName") FUNC_GETVAR("Name");
ENDCLASS;