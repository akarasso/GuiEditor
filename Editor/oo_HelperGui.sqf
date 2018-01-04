#include "..\oop.h"
#include "..\dialog\define.hpp"
CLASS("oo_HelperGui")

	PUBLIC UI_VARIABLE("display", "Display");

	PUBLIC FUNCTION("","constructor") {};
	PUBLIC FUNCTION("display","constructor") { MEMBER("Display", _this);};
	PUBLIC FUNCTION("scalar","getControl") { MEMBER("Display", nil) displayCtrl _this;	};

	PUBLIC FUNCTION("scalar","clear") {
		private _a = [_this, ""];
		MEMBER("setString", "");
	};

	PUBLIC FUNCTION("scalar","clearAction") {
		private _a = [_this, ""];
		MEMBER("setAction", _a);
	};
	/*
	*	Function to set action on control type BUTTon
	*	@input:array
	*		0:scalar id of control
	*		1:string action 
	*	@return:bool
	*/
	PUBLIC FUNCTION("array","setAction") {
		if !(_this isEqualTypeParams [0,""]) exitWith {
			hint "You sent bad args to setAction";
		};
		private _control = MEMBER("getControl", (_this select 0));
		if (_control isEqualTo controlNull) exitWith {
			hint "Trying to setAction a controlNull";
			false;
		};
		if !(ctrlType _control isEqualTo CT_BUTTON) then {
			hint "Trying to setAction a non button control";
			false;
		};
		_control buttonSetAction (_this select 1);
		true;
	};

	PUBLIC FUNCTION("array","setString") {
		if (_this isEqualTypeParams [0,""]) exitWith {
			private _id = _this select 0;
			private _string = _this select 1;
			private _control = MEMBER("getControl", _id);
			if (_control isEqualTo controlNull) exitWith {
				hint "Trying to setString a controlNull";
			};
			_control ctrlSetText _string;
		};
		if (_this isEqualTypeParams [0,0]) exitWith {
			private _id = _this select 0;
			private _string = _this select 1;
			private _control = MEMBER("getControl", _id);
			if (_control isEqualTo controlNull) exitWith {
				hint "Trying to setString a controlNull";
			};
			_control ctrlSetText format["%1", _string];
		};
	};

	PUBLIC FUNCTION("scalar","getString") {
		private _a = [_this, ""];
		MEMBER("getString", _a);
	};

	/*
	* 	get text from control
	*	@input:array
	*		0:scalar id of control
	*		1:string default return value
	*	@output:string
	*/
	PUBLIC FUNCTION("array","getString") {
		if !(_this isEqualTypeParams [0,""]) exitWith {
			hint "Bad args sent to getString";
		};
		private _control = MEMBER("getControl", (_this select 0));
		if (_control isEqualTo controlNull) exitWith {
			_this select 1;
		};
		ctrlText _control;
	};

	PUBLIC FUNCTION("scalar","getScalar") {
		private _a = [_this, -1];
		MEMBER("getScalar", _a);
	};

	/*
	* 	get scalar text from control
	*	@input:array
	*		0:scalar id of control
	*		1:scalar default return value
	*	@output:scalar
	*/
	PUBLIC FUNCTION("array","getScalar") {
		if !(_this isEqualTypeParams [0,0]) exitWith {
			hint "Bad args send to getScalar";
		};
		private _control = MEMBER("getControl", _this select 0);
		if (_control isEqualTo controlNull) exitWith {
			_this select 1;
		};
		parseNumber (MEMBER("removeSpace", ctrlText _control));
	};

	/*
	*	Check if control is checked
	*	@input:scalar id of control
	*	@output:bool	
	*/
	PUBLIC FUNCTION("scalar","getCtrlChecked") {
		private _control = MEMBER("getControl", _this);
		if (_control isEqualTo controlNull) exitWith {
			hint "ControllNull getCtrlChecked";
			false;
		};
		if (!((ctrlType _control) isEqualTo 7) && ! ((ctrlType _control) isEqualTo 77)) exitWith {
			hint "Can't get ctrlChecked on this control";
			false;
		};
		ctrlChecked _control;
	};
	
	/*
	*	Check if string contain another string
	*	@input:array
	*		0:string 
	*		1:string pattern to search
	*	@output:bool
	*/
	PUBLIC FUNCTION("array","stringContain") {
		if ((_this select 0) find (_this select 1) > -1) exitWith {
			true;
		};
		false;
	};
	/*
	*	Format string that contain %n mark
	*	input:array => used Value to replace mark
	*/
	PUBLIC FUNCTION("array","stringFormat") {
		private _s = _this select 0;
		private "_arr";
		{
			_arr = [_s, ("%"+str (_forEachIndex+1)), _x];
			_s = MEMBER("stringReplace", _arr);
		} forEach (_this select 1);
		_s;
	};

	/*
	*	Function to remove all space from string
	*	@input:string..
	*/
	PUBLIC FUNCTION("string","removeSpace") {
		private _a = [_this, " ", ""];
		MEMBER("stringReplace", _a);
	};

	/*
	*	Replace all matched pattern in string by another string
	*	@array
	*		0:string
	*		1:string matched pattern
	*		2:string replace pattern
	*/
	PUBLIC FUNCTION("array","stringReplace") {
		if !(_this isEqualTypeParams ["","",""]) exitWith {
			hint "GUI HELPER stringReplace failed.. Bad args";
			_this select 0;
		};
		if (_this select 1 isEqualTo "") exitWith {	_this select 0;	};
		if!((_this select 2) find (_this select 1) isEqualTo -1) exitWith { _this select 0; };
		private _string = _this select 0;
		private _index = _string find (_this select 1);
		while {_index > -1} do {
			_string = (_string select [0, _index]) + (_this select 2) + (_string select [_index + (count (_this select 1)), (count _string) - _index + (count (_this select 1))]);
			_index = _string find (_this select 1);
		};
		_string;
	};

	/*
	*	Récupère la valeur de la selection courante
	*	@input:array => id:control id, defaultreturn: any
	*	@output:scalar
	*/
	PUBLIC FUNCTION("scalar","getLbSelValue") {
		private _a = [_this, -1];
		MEMBER("getLbSelValue", _a);
	};

	/*
	*	get value of selected item in listbox	
	*	@input:array
	*		1:id of list box
	*		2:default return
	*	@output:scalar
	*/
	PUBLIC FUNCTION("array","getLbSelValue") {
		if !(_this isEqualTypeParams [0,0]) exitWith {
			hint "Bad args send to getLbSelValue";
			_this select 1;
		};
		private _control = MEMBER("getControl", _this select 0);
		if (_control isEqualTo controlNull) exitWith {
			_this select 1;
		};
		private _index = MEMBER("getLbSelIndex", _control);
		_control lbValue _index;
	};

	/*
	* Récupère la valeur des selections courante
	* @input:array => id:control id, defaultreturn: any
	* @output:array of scalar
	*/
	PUBLIC FUNCTION("scalar","getMultiLbSelValue") {
		private _a = [_this, -1];
		MEMBER("getMultiLbSelValue", _a);
	};

	/*
	*	get multiple value of selected item in listbox	
	*	@input:array
	*		1:id of list box
	*		2:default return
	*	@output:array
	*/
	PUBLIC FUNCTION("array","getMultiLbSelValue") {
		if !(_this isEqualTypeParams [0,0]) exitWith {
			hint "Bad args send to getMultiLbSelValue";
			_this select 1;
		};
		private _control = MEMBER("getControl", (_this select 0));
		if (_control isEqualTo controlNull) exitWith {
			_this select 1;
		};
		private _index = MEMBER("getMultiLbSelIndex", _control);
		_control lbValue _index;
	};

	
	/*
	*	Récupère une string et la format dans un tableau
	*	input:string => chaine a formater
	*	input:array => default value
	*	Return type: Array
	*/
	PUBLIC FUNCTION("string","getArrayFromString") {
		private _arr = [_this, []];
		MEMBER("getArrayFromString", _arr);
	};

	/*
	*	Parse string into array
	*	@input:array
	*		1:string to parse
	*		2:array default value
	*	@output:array
	*/
	PUBLIC FUNCTION("array","getArrayFromString") {
		if !(_this isEqualTypeParams ["",[]]) exitWith {
			hint "Bad args sent to getArrayFromString";
		};
		private _input = _this select 0;
		private _a = [_input, (toString [39]), (toString [34])];
		_input = MEMBER("stringReplace", _a);
		_input = MEMBER("trim", _input);
		if !(MEMBER("isValidStringToArray", _input)) exitWith {
			_this select 1;
		};
		parseSimpleArray _input;
	};

	/*
	*	Remove space at beginning/ending of string
	*/
	PUBLIC FUNCTION("string","trim") {
		if (count _this isEqualTo 0) exitWith {_this;};
		private _array = toArray _this;
		while {(_array select 0) isEqualTo 32} do {
			_array deleteAt 0;
		};
		if (count _array isEqualTo 0) exitWith {
			toString _array;
		};
		while {_array select ((count _array)-1) isEqualTo 32} do {
			_array deleteAt ((count _array)-1);
		};
		toString _array;
	};

	/*
	*	Prends le text d'un control dans le gui et le format dans un tableau
	*	input:scalar => id du control
	*	input:array => default value
	*	Return type: Array
	*/
	PUBLIC FUNCTION("scalar","getArrayFromControl") {
		private _a = [_this, []];
		MEMBER("getArrayFromControl", _a);
	};

	/*
	*	Retrieve text control & parse it to array
	*	@input:array
	*		1:id of control
	*		2:array default return
	*	@output:array
	*/
	PUBLIC FUNCTION("array","getArrayFromControl") {
		if !(_this isEqualTypeParams [0,[]]) exitWith {
			hint format["Bad args sent to getArrayFromControl:%1", _this];
		};
		private _control = MEMBER("getControl", _this select 0);
		if (_control isEqualTo controlNull) exitWith {
			diag_log "ControlNull #getArrayFromControl";
			_this select 1;
		};
		private _a = [ctrlText _control, (toString [39]), (toString [34])];
		_input = MEMBER("stringReplace", _a);
		_input = MEMBER("trim", _input);
		if !(MEMBER("isValidStringToArray", _input)) exitWith {
			_default;
		};
		parseSimpleArray _input;
	};

	PUBLIC FUNCTION("scalar","getColor") {
		private _a = [_this, [-1,-1,-1,-1]];
		MEMBER("getColor", _a);
	};

	/*
	*	Retrieve text control & parse it to color
	*	@input:array
	*		1:id of control
	*		2:array default return
	*	@output:array
	*/
	PUBLIC FUNCTION("array","getColor") {
		private _arr = MEMBER("getArrayFromControl", _this);
		if !((count _arr) isEqualTo 4) exitWith {
			_this select 1;
		};
		if (format["%1", _arr] isEqualTo "[-1,-1,-1,-1]") exitWith {
			_arr;
		};
		{
			if (isNil "_x") then {
				_arr set [_forEachIndex, 1];
			}else{
				if !((typeName _x) isEqualTo "SCALAR") then {
					_arr set [_forEachIndex, 1];
				}else{
					if (_x > 1) then {
						_arr set [_forEachIndex, 1];
					};
					if (_x < 0) then {
						_arr set [_forEachIndex, 0];
					};
				};
			};
		} forEach _arr;
		_arr;
	};
	/*
	* Récupère l'index de la listbox
	*/
	PRIVATE FUNCTION("control","getLbSelIndex") { lbCurSel _this; };
	PRIVATE FUNCTION("control","getMultiLbSelIndex") { lbSelection _this; };

	PUBLIC FUNCTION("string","isValidStringToArray") {
		if (_this select [0,1] isEqualTo "[" && _this select [count _this-1, 1] isEqualTo "]") exitWith {
			true;
		};
		false;
	};
ENDCLASS;