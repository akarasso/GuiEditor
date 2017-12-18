#include "..\oop.h"
CLASS("oo_HelperGui")

	PUBLIC UI_VARIABLE("display", "Display");

	PUBLIC FUNCTION("display","constructor") { 
		MEMBER("Display", _this);
	};

	PUBLIC FUNCTION("","constructor") {};

	PUBLIC FUNCTION("scalar","getControl") {
		DEBUG(#, "oo_HelperGui::getControl")
		private _validArgs = params[
			["_id", -1, [0]]
		];
		if !(_validArgs) exitWith {
			hint "GUI HELPER getControl failed.. You sent bad arguments";
			controlNull;
		};
		private _c = MEMBER("Display", nil) displayCtrl _id;
		if (_c isEqualTo controlNull) exitWith {
			hint "GUI HELPER getControl failed.. ControlNULL";
			controlNull;
		};
		_c;
	};

	PUBLIC FUNCTION("scalar","getString") {
		DEBUG(#, "oo_HelperGui::getString")
		private _a = [_this, ""];
		MEMBER("getString", _a);
	};

	PUBLIC FUNCTION("array","getString") {
		DEBUG(#, "oo_HelperGui::getString")
		private _validArgs = params[
			["_id", -1,[0]],
			["_default", "", [""]]
		];
		private _control = MEMBER("getControl", _id);
		if (_control isEqualTo controlNull) exitWith {
			hint "GUI HELPER getString failed.. ControlNULL";
		};
		ctrlText _control;
	};

	PUBLIC FUNCTION("scalar","getScalar") {
		DEBUG(#, "oo_HelperGui::getScalar")
		private _a = [_this, -1];
		MEMBER("getScalar", _a);
	};

	PUBLIC FUNCTION("array","getScalar") {
		DEBUG(#, "oo_HelperGui::getScalar")
		private _validArgs = params[
			["_id", -1,[0]],
			["_default", -1, [0]]
		];
		private _control = MEMBER("getControl", _id);
		if (_control isEqualTo controlNull) exitWith {
			hint "GUI HELPER getString failed.. ControlNULL";
		};

		//Replace , par .
	};

	/*
	* Correct error
	*/
	PUBLIC FUNCTION("array","stringReplace") {
		DEBUG(#, "oo_HelperGui::stringReplace")
		private _validArgs = params[
			["_string", "", [""]],
			["_match", "", [""]],
			["_replace", "", [""]]
		];
		if !(_validArgs) exitWith {
			hint "GUI HELPER stringReplace failed.. Bad args";
		};
		_stringArray = toArray _string;
		_matchArray = toArray _match;
		_replaceArtray = toArray _replace;
		private _doIt = true;
		while {_doIt} do {
			_doIt = false;
			{
				if (_x == (_matchArray select 0)) then {
					private _i = 0;
					private _countMatch = count _matchArray;
					private _s = true;
					while {_i < _countMatch && _s} do {
						if !((_stringArray select (_forEachIndex + _i)) isEqualTo (_matchArray select _i)) then {
							_s = false;
						};
						_i = _i +1;
					};

					if (_s) exitWith {
						private _newArray = [];
						for "_i" from 0 to _forEachIndex -1 do {
							_item = _stringArray select _i;
							_newArray pushBack _item;
						};
						for "_i" from 0 to count _replaceArtray -1 do {
							_item = _replaceArtray select _i;
							_newArray pushBack _item;
						};
						for "_i" from (_forEachIndex + (count _matchArray)) to count _stringArray -1 do {
							_item = _stringArray select _i;
							_newArray pushBack _item;
						};	
						diag_log format["%1", toString _newArray];
						_stringArray = _newArray;
						_doIt = true;				
					};
				};
			} forEach _stringArray;
		};
		toString _stringArray;
	};

	/*
	* Récupère la valeur de la selection courante
	* @input:array => id:control id, defaultreturn: any
	* @output:scalar
	*/
	PUBLIC FUNCTION("scalar","getLbSelValue") {
		DEBUG(#, "oo_HelperGui::getLbSelValue")
		private _a = [_this, -1];
		MEMBER("getLbSelValue", _a);
	};

	PUBLIC FUNCTION("array","getLbSelValue") {
		DEBUG(#, "oo_HelperGui::getLbSelValue")
		private _validArgs = params[
			["_id", -1, [0]],
			["_default", -1, [0]]
		];
		if !(_validArgs) exitWith {
			hint "GUI HELPER getLbSelValue failed.. You sent bad arguments";
		};
		private _control = MEMBER("getControl", _id);
		if (_control isEqualTo controlNull) exitWith {
			hint "GUI HELPER getLbSelValue failed.. ControlNULL";
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
		private _validArgs = params[
			["_id", -1, [0]],
			["_default", -1, [0]]
		];
		if !(_validArgs) exitWith {
			hint "GUI HELPER getMultiLbSelValue failed.. You sent bad arguments";
		};
		private _control = MEMBER("getControl", _id);
		if (_control isEqualTo controlNull) exitWith {
			hint "GUI HELPER getMultiLbSelValue failed.. ControlNULL";
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
		private _a = [_this, []];
		MEMBER("getArrayFromString", _a);
	};

	PUBLIC FUNCTION("array","getArrayFromString") {
		private _validArgs = params[
			["_input", "", [""]],
			["_default", [], [[]]]
		];
		if !(_validArgs) exitWith {
			hint "GUI HELPER getArrayFromString failed.. You sent bad arguments";
		};		
		private _a = [_input,"'",'"'];
		private _string = MEMBER("stringReplace", _a);
		hint format["%1",_string];
		// if !(MEMBER("isValidStringToArray", _string)) exitWith {
		// 	_default;
		// };
		// private _res = parseSimpleArray _string;
		// if (isNil "_res") then {
		// 	hint "Call compile failed cause your string is not valid.";
		// };
		// if (typeName _res != "ARRAY") exitWith {
		// 	_default;
		// };
		// _res;
	};

	/*
	* Prends le text d'un control dans le gui et le format dans un tableau
	* input:scalar => id du control
	* input:array => default value
	* Return type: Array
	*/
	PUBLIC FUNCTION("scalar","getArrayFromControl") {
		DEBUG(#, "oo_HelperGui::getArrayFromControl")
		private _a = [_this, []];
		MEMBER("getArrayFromControl", _a);
	};

	PUBLIC FUNCTION("array","getArrayFromControl") {
		DEBUG(#, "oo_HelperGui::getArrayFromControl")
		private _validArgs = params[
			["_id", -2, [0]],
			["_default", [], [[]]]
		];
		if !(_validArgs) exitWith {
			hint "GUI HELPER getArrayFromControl failed.. You sent bad arguments";
		};
		private _control = MEMBER("getControl", _id);
		if (_control isEqualTo controlNull) exitWith {
			hint "Can't access to displayCtrl #-1";
		};
		private _res = call compile format["%1", ctrlText _control];
		if (isNil "_res") then {
			hint "Call compile failed cause your string is not valid.";
		};
		if (typeName _res != "ARRAY") exitWith {
			_default;
		};
		_res;
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
		private _array = toArray _this;
		if ((_array select 0) == 91 && (_array select (count _array -1)) == 93) then {
			true;
		}else{
			false;
		};
	};
ENDCLASS;