#include "..\oop.h"
#include "..\dialog\define.hpp"
CLASS("oo_HelperGui")

	PUBLIC UI_VARIABLE("display", "Display");

	PUBLIC FUNCTION("","constructor") {};

	PUBLIC FUNCTION("display","constructor") { 
		MEMBER("Display", _this);
	};

	PUBLIC FUNCTION("scalar","getControl") {
		MEMBER("Display", nil) displayCtrl _this;
	};

	PUBLIC FUNCTION("scalar","clear") {
		private _a = [_this, ""];
		MEMBER("setString", "");
	};

	PUBLIC FUNCTION("scalar","clearAction") {
		private _a = [_this, ""];
		MEMBER("setAction", _a);
	};	
	PUBLIC FUNCTION("array","setAction") {
		if !(_this isEqualTypeParams [0,""]) exitWith {
			hint "You sent bad args to setAction";
		};
		private _id = _this select 0;
		private _action = _this select 1;
		private _control = MEMBER("getControl", _id);
		if (_control isEqualTo controlNull) exitWith {
			hint "Trying to setAction a controlNull";
		};
		if !(ctrlType _control isEqualTo CT_BUTTON) then {
			hint "Trying to setAction a non button control";
		};
		_control buttonSetAction _action;
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

	PUBLIC FUNCTION("array","getString") {
		if !(_this isEqualTypeParams [0,""]) exitWith {
			hint "Bad args sent to getString";
		};
		private _id = _this select 0;
		private _default = _this select 1;
		private _control = MEMBER("getControl", _id);
		if (_control isEqualTo controlNull) exitWith {
			_default;
		};
		ctrlText _control;
	};

	PUBLIC FUNCTION("scalar","getScalar") {
		private _a = [_this, -1];
		MEMBER("getScalar", _a);
	};

	PUBLIC FUNCTION("array","getScalar") {
		if !(_this isEqualTypeParams [0,0]) exitWith {
			hint "Bad args send to getScalar";
		};
		private _id = _this select 0;
		private _default = _this select 1;
		private _control = MEMBER("getControl", _id);
		if (_control isEqualTo controlNull) exitWith {
			_default;
		};
		parseNumber (MEMBER("removeSpace", ctrlText _control));
	};

	PUBLIC FUNCTION("scalar","getCtrlChecked") {
		private _control = MEMBER("getControl", _this);
		if (_control isEqualTo controlNull) exitWith {
			hint "ControllNull getCtrlChecked";
		};
		if (!((ctrlType _control) isEqualTo 7) && ! ((ctrlType _control) isEqualTo 77)) exitWith {
			hint "Can't get ctrlChecked on this control";
		};
		ctrlChecked _control;
	};
	
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
			diag_log format["At pos:%1 s:%2",_forEachIndex, _s];
		} forEach (_this select 1);
		_s;
	};

	PUBLIC FUNCTION("string","removeSpace") {
		private _a = [_this, " ", ""];
		MEMBER("stringReplace", _a);
	};

	PUBLIC FUNCTION("array","stringReplace") {
		if !(_this isEqualTypeParams ["","",""]) exitWith {
			hint "GUI HELPER stringReplace failed.. Bad args";
		};
		if (_this select 1 isEqualTo "") exitWith {
			_this select 0;
		};
		private _string = _this select 0;
		private _match = _this select 1;
		private _replace = _this select 2;
		private _index = _string find _match;
		while {_index > -1} do {
			_string = (_string select [0, _index]) + _replace + (_string select [_index + (count _match), (count _string) - _index + (count _match)]);
			_index = _string find _match;
		};
		_string;
	};

	/*
	* Récupère la valeur de la selection courante
	* @input:array => id:control id, defaultreturn: any
	* @output:scalar
	*/
	PUBLIC FUNCTION("scalar","getLbSelValue") {
		private _a = [_this, -1];
		MEMBER("getLbSelValue", _a);
	};

	PUBLIC FUNCTION("array","getLbSelValue") {
		if !(_this isEqualTypeParams [0,0]) exitWith {
			hint "Bad args send to getLbSelValue";
		};
		_id = _this select 0;
		_default = _this select 1;
		private _control = MEMBER("getControl", _id);
		if (_control isEqualTo controlNull) exitWith {
			_default;
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

	PUBLIC FUNCTION("array","getMultiLbSelValue") {
		if !(_this isEqualTypeParams [0,0]) exitWith {
			hint "Bad args send to getMultiLbSelValue";
		};
		private _id = _this select 0;
		private _default = _this select 1;
		private _control = MEMBER("getControl", _id);
		if (_control isEqualTo controlNull) exitWith {
			_default;
		};
		private _index = MEMBER("getMultiLbSelIndex", _control);
		_control lbValue _index;
	};

	
	/*
	* Récupère une string et la format dans un tableau
	* input:string => chaine a formater
	* input:array => default value
	* Return type: Array
	*/
	PUBLIC FUNCTION("string","getArrayFromString") {
		private _arr = [_this, []];
		MEMBER("getArrayFromString", _arr);
	};

	PUBLIC FUNCTION("array","getArrayFromString") {
		if !(_this isEqualTypeParams ["",[]]) exitWith {
			hint "Bad args sent to getArrayFromString";
		};
		private _input = _this select 0;
		private _default = _this select 1;
		
		private _a = [_input, (toString [39]), (toString [34])];
		_input = MEMBER("stringReplace", _a);
		_input = MEMBER("trim", _input);
		if !(MEMBER("isValidStringToArray", _input)) exitWith {
			_default;
		};
		parseSimpleArray _input;
	};

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
	* Prends le text d'un control dans le gui et le format dans un tableau
	* input:scalar => id du control
	* input:array => default value
	* Return type: Array
	*/
	PUBLIC FUNCTION("scalar","getArrayFromControl") {
		private _a = [_this, []];
		MEMBER("getArrayFromControl", _a);
	};

	PUBLIC FUNCTION("array","getArrayFromControl") {
		if !(_this isEqualTypeParams [0,[]]) exitWith {
			hint format["Bad args sent to getArrayFromControl:%1", _this];
		};
		private _id = _this select 0;
		private _control = MEMBER("getControl", _id);
		private _default = _this select 1;
		if (_control isEqualTo controlNull) exitWith {
			diag_log "ControlNull #getArrayFromControl";
			_default;
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
	PRIVATE FUNCTION("control","getLbSelIndex") {
		lbCurSel _this;
	};

	PRIVATE FUNCTION("control","getMultiLbSelIndex") {
		lbSelection _this;
	};

	PUBLIC FUNCTION("string","isValidStringToArray") {
		if (_this select [0,1] isEqualTo "[" && _this select [count _this-1, 1] isEqualTo "]") exitWith {
			true;
		};
		false;
	};
ENDCLASS;