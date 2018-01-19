#include "..\oop.h"

#define CT_STATIC           0
#define CT_BUTTON           1
#define CT_EDIT             2
#define CT_SLIDER           3
#define CT_COMBO            4
#define CT_LISTBOX          5
#define CT_TOOLBOX          6
#define CT_CHECKBOXES       7
#define CT_PROGRESS         8
#define CT_HTML             9
#define CT_STATIC_SKEW      10
#define CT_ACTIVETEXT       11
#define CT_TREE             12
#define CT_STRUCTURED_TEXT  13
#define CT_CONTEXT_MENU     14
#define CT_CONTROLS_GROUP   15
#define CT_SHORTCUTBUTTON   16
#define CT_HITZONES         17
#define CT_VEHICLETOGGLES   18
#define CT_CONTROLS_TABLE   19
#define CT_XKEYDESC         40
#define CT_XBUTTON          41
#define CT_XLISTBOX         42
#define CT_XSLIDER          43
#define CT_XCOMBO           44
#define CT_ANIMATED_TEXTURE 45
#define CT_MENU             46
#define CT_MENU_STRIP       47
#define CT_CHECKBOX         77
#define CT_OBJECT           80
#define CT_OBJECT_ZOOM      81
#define CT_OBJECT_CONTAINER 82
#define CT_OBJECT_CONT_ANIM 83
#define CT_LINEBREAK        98
#define CT_USER             99
#define CT_MAP              100
#define CT_MAP_MAIN         101
#define CT_LISTNBOX         102
#define CT_ITEMSLOT         103
#define CT_LISTNBOX_CHECKABLE 104
#define CT_VEHICLE_DIRECTION 105

#define NUMERIC [48,49,50,51,52,53,54,55,56,57]
#define ALPHA [97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122]
#define UPPER_ALPHA [65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90]

CLASS("oo_HelperGui")

	PUBLIC UI_VARIABLE("display", "Display");

	PUBLIC FUNCTION("","constructor") {};

	PUBLIC FUNCTION("display","setDisplay") {
		MEMBER("Display", _this);
	};

	PUBLIC FUNCTION("scalar","getControl") {
		MEMBER("Display", nil) displayCtrl _this;
	};

	/*
	*	Function to verify type of control
	*/
	PUBLIC FUNCTION("array","verifyType") {
		disableSerialization;
		if (_this isEqualTypeParams [controlNull, 0]) exitWith {
			if ((ctrlType (_this select 0)) isEqualTo (_this select 1)) exitWith {
				true;
			};
			false;
		};
		if (_this isEqualTypeParams [0, 0]) exitWith {
			private _control = MEMBER("getControl", _this select 0);
			if ((ctrlType _control) isEqualTo _this select 1) exitWith {
				true;
			};
			false;
		};
		diag_log format["Bad args sent to verifyType:%1", _this];
	};

	/*
	*	Function to set action on control type BUTTon
	*	@input:array
	*		0:scalar id of control
	*		1:string action 
	*	@return:bool
	*/
	PUBLIC FUNCTION("array","setAction") {
		if (_this isEqualTypeParams [controlNull, ""] || _this isEqualTypeParams [controlNull, {}]) exitWith {
			if ((_this select 0) isEqualTo controlNull) exitWith {
				diag_log ("[controlNull] Bad args sent to setAction:" + str _this);
				false;
			};
			private _a = [_this select 0, CT_BUTTON];
			if (MEMBER("verifyType", _a)) exitWith {
				(_this select 0) buttonSetAction (_this select 1);				
				true;
			};
			false;
		};
		if (_this isEqualTypeParams [0, ""] || _this isEqualTypeParams [0,{}]) exitWith {
			private _control = MEMBER("getControl", _this select 0);
			if (_control isEqualTo controlNull) exitWith {
				diag_log ("[controlNull] Bad args sent to setAction:" + str _this);
				false;
			};
			private _a = [_control, CT_BUTTON];
			if (MEMBER("verifyType", _a)) exitWith {
				_control buttonSetAction (_this select 1);				
				true;
			};
			false;
		};
		diag_log ("Bad args sent to setAction:" + str _this);
	};

	/*
	*	Set text control on current display
	*/
	PUBLIC FUNCTION("array","setString") {
		if (_this isEqualTypeParams [0,""]) exitWith {
			private _control = MEMBER("getControl", _this select 0);
			if (_control isEqualTo controlNull) exitWith {
				diag_log ("[controlNull] Bad args sent to setString:" + str _this);
				false;
			};
			_control ctrlSetText _string;
			true;
		};
		if (_this isEqualTypeParams [0,0]) exitWith {
			private _control = MEMBER("getControl", _this select 0);
			if (_control isEqualTo controlNull) exitWith {
				diag_log ("[controlNull] Bad args sent to setString:" + str _this);
				false;
			};
			_control ctrlSetText (str (_this select 1));
			true;
		};
		if (_this isEqualTypeParams [controlNull,""]) exitWith {
			if ((_this select 0) isEqualTo controlNull) exitWith {
				diag_log ("[controlNull] Bad args sent to setString:" + str _this);
				false;
			};
			(_this select 0) ctrlSetText (_this select 1);
			true;
		};
		if (_this isEqualTypeParams [controlNull,0]) exitWith {
			if ((_this select 0) isEqualTo controlNull) exitWith {
				diag_log ("[controlNull] Bad args sent to setString:" + str _this);
				false;
			};
			(_this select 0) ctrlSetText (str (_this select 1));
			true;
		};
		diag_log ("Bad args sent to setString" + str _this); 
		false;
	};

	/*
	* 	get text from control
	*	@input:array
	*		0:scalar id of control
	*		1:string default return value
	*	@output:string
	*/
	PUBLIC FUNCTION("scalar","getString") {
		private _a = [_this, ""];
		MEMBER("getString", _a);
	};

	PUBLIC FUNCTION("control","getString") {
		private _a = [_this , ""];
		MEMBER("getString", _a);;
	};
	
	PUBLIC FUNCTION("array","getString") {
		if (_this isEqualTypeParams [controlNull, ""]) exitWith {
			if ((_this select 0) isEqualTo controlNull) exitWith {
				diag_log ("getString on controlNull" + str _this);
				_this select 0;
			};
			ctrlText (_this select 0);
		};
		if(_this isEqualTypeParams [0,""]) exitWith {
			disableSerialization;
			private _control = MEMBER("getControl", _this select 0);
			if (_control isEqualTo controlNull) exitWith {
				diag_log ("getString on controlNull" + str _this);
				_this select 0;	
			};
			ctrlText (_control);
		};
		diag_log ("Bad args sent to getString:" + str _this);
	};	

	/*
	* 	get scalar text from control
	*	@input:array
	*		0:scalar id of control
	*		1:scalar default return value
	*	@output:scalar
	*/
	PUBLIC FUNCTION("scalar","getScalar") {
		private _a = [_this, -1];
		MEMBER("getScalar", _a);
	};

	PUBLIC FUNCTION("control","getScalar") {
		private _a = [_this, -1];
		MEMBER("getScalar", _a);
	};	
	PUBLIC FUNCTION("array","getScalar") {
		if (_this isEqualTypeParams [0,0]) exitWith {
			private _control = MEMBER("getControl", _this select 0);
			if (_control isEqualTo controlNull) exitWith {
				diag_log ("[controlNull] getScalar on controlNull" + str _this);
				_this select 1;
			};
			MEMBER("parseNumber", ctrlText (_this select 0));
		};
		if (_this isEqualTypeParams [controlNull,0]) exitWith {
			if ((_this select 0) isEqualTo controlNull) exitWith {
				diag_log ("[controlNull] getScalar on controlNull" + str _this);
				_this select 1;
			};
			MEMBER("parseNumber", ctrlText (_this select 0));
		};
		diag_log ("getScalar on controlNull" + str _this);
	};

	/*
	*	Check if control is checked
	*	@input:scalar id of control
	*	@output:bool	
	*/
	PUBLIC FUNCTION("control","getCtrlChecked") {
		private _control = MEMBER("getControl", _this);
		if (_this isEqualTo controlNull) exitWith {
			diag_log "ControllNull getCtrlChecked";
			false;
		};
		private _arr = [_this, CT_CHECKBOXES];
		private _arr2 = [_this, CT_CHECKBOX];
		if (!MEMBER("verifyType", _arr) && !MEMBER("verifyType", _arr2)) exitWith {
			diag_log "Can't get ctrlChecked on this control";
			false;
		};
		ctrlChecked _control;	
	};
	PUBLIC FUNCTION("scalar","getCtrlChecked") {
		private _control = MEMBER("getControl", _this);
		if (_control isEqualTo controlNull) exitWith {
			diag_log "ControllNull getCtrlChecked";
			false;
		};
		private _arr = [_control, CT_CHECKBOXES];
		private _arr2 = [_control, CT_CHECKBOX];
		if (!MEMBER("verifyType", _arr) && !MEMBER("verifyType", _arr2)) exitWith {
			diag_log "Can't get ctrlChecked on this control";
			false;
		};
		ctrlChecked _control;
	};
		
	PUBLIC FUNCTION("array","setLB") {
		private "_arr";
		_arr = [_this, "control"];
		private _index = MEMBER("findInPair", _arr);
		if (_index isEqualTo -1) exitWith {
			diag_log ("[No key 'control' set]" + str _this);
		};

		private _control = (_this deleteAt _index) select 1;
		if (_control isEqualType 0) then {
			_control = MEMBER("getControl", _control);
		};
		if (_control isEqualType controlNull) then {
			if (_control isEqualTo controlNull) exitWith {
				diag_log ("[controlNull] setLB on controlNull" + str _this);
			};
		};

		_arr = [_this, "list"];
		_index = MEMBER("findInPair", _arr);
		if (_index isEqualTo -1) exitWith {
			diag_log ("[No key 'list' set] " + str _this);
		};
		private _list = (_this deleteAt _index) select 1;
		if (count _list isEqualTo 0) exitWith {
			diag_log ("[Empty 'list']" + str _this);
		};
		private _countList = count (_list select 0);

		_arr = [_this, "name"];
		_index = MEMBER("findInPair", _arr);
		if (_index isEqualTo -1) exitWith {
			diag_log ("[No key 'name' set] " + str _this);
		};
		private _indexName = (_this deleteAt _index) select 1;

		if (_indexName > _countList -1) exitWith {
			diag_log ("[Key 'name' out of range] " + str (_list select 0));
		};

		_arr = [_this, "value"];
		_index = MEMBER("findInPair", _arr);
		private _indexValue = if (_index isEqualTo -1) then {
			-1;
		}else{
			_i = (_this deleteAt _index) select 1;
			if!(_i isEqualType 0) exitWith {
				diag_log "[Key 'value' is not a number]";
				-1;
			};
			if (_i > _countList -1) exitWith {
				diag_log ("[Key 'value' out of range] " + str (_list select 0));
				-1;
			};
			_i;
		};

		_arr = [_this, "picture"];
		_index = MEMBER("findInPair", _arr);
		private _indexPicture = if (_index isEqualTo -1) then {
			-1;
		}else{
			_i = (_this deleteAt _index) select 1;
			if!(_i isEqualType 0) exitWith {
				diag_log "[Key 'picture' is not a number]";
				-1;
			};
			if (_i > _countList -1) exitWith {
				diag_log ("[Key 'picture' out of range] " + str (_list select 0));
				-1;
			};
			_i;
		};
		_arr = [_this, "tooltip"];
		_index = MEMBER("findInPair", _arr);
		private _indexTooltip = if (_index isEqualTo -1) then {
			-1;
		}else{
			_i = (_this deleteAt _index) select 1;
			if!(_i isEqualType 0) exitWith {
				diag_log "[Key 'picture' is not a number]";
				-1;
			};
			if (_i > _countList -1) exitWith {
				diag_log ("[Key 'picture' out of range] "+ str (_list select 0));
				-1;
			};
			_i;
		};

		{
			_control lbAdd (_x select _indexName);
			_control lbSetData [_foreachindex, (str _x)];
			if (_indexValue isEqualTo -1) then {
				_control lbSetValue [_foreachindex, _foreachindex];
			}else{
				if ((_x select _indexValue) isEqualType 0) then {
					_control lbSetValue [_foreachindex, (_x select _indexValue)];
				}else{
					diag_log ("[Value is not a number] Current:" + (str (_x select _indexValue)));
				};
			};

			if!(_indexPicture isEqualTo -1) then {
				if ((_x select _indexPicture) isEqualType "") then {
					_control lbSetPicture [_foreachindex, (_x select _indexPicture)];
				}else{
					diag_log ("[Picture is not a string] Current:" + (str (_x select _indexPicture)));
				};
			};
			if!(_indexTooltip isEqualTo -1) then {
				if ((_x select _indexTooltip) isEqualType "") then {
					_control lbSetTooltip [_foreachindex, (_x select _indexTooltip)];
				}else{
					diag_log ("[Tooltip is not a string] Current:" + (str (_x select _indexTooltip)));
				};
			};

		} forEach _list;
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
	PUBLIC FUNCTION("control","getLbSelValue") {
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
		if (_this isEqualTypeParams [0, 0]) exitWith {
			disableSerialization;
			private _control = MEMBER("getControl", _this select 0);
			if (_control isEqualTo controlNull) exitWith {
				diag_log ("[controlNull] getLbSelValue on controlNull" + str _this);
				_this select 1;
			};
			_control lbValue (MEMBER("getLbSelIndex", _control));
		};
		if (_this isEqualTypeParams[controlNull, 0]) exitWith {
			private _arr = [_this select 0, CT_LISTBOX];
			if (!MEMBER("verifyType", _arr)) exitWith {
				diag_log ("[Bad type] getLbSelValue: " + str _this);
			};
			(_this select 0) lbValue (MEMBER("getLbSelIndex", (_this select 0)));
		};
		diag_log ("bad args sent to getLbSelValue:" +str _this);
		-1;
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
	PUBLIC FUNCTION("control","getMultiLbSelValue") {
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
		if (_this isEqualTypeParams [0, 0]) exitWith {
			disableSerialization;
			private _control = MEMBER("getControl", _this select 0);
			if (_control isEqualTo controlNull) exitWith {
				diag_log ("[controlNull] getMultiLbSelValue on controlNull" + (str _this));
				_this select 1;
			};
			_control lbValue (MEMBER("getMultiLbSelIndex", _control));
		};
		if (_this isEqualTypeParams[controlNull, 0]) exitWith {
			private _arr = [_this select 0, LB_MULTI];
			if (!MEMBER("verifyType", _arr)) exitWith {
				diag_log ("[Bad type] getMultiLbSelValue: " + str _this);
			};
			(_this select 0) lbValue (MEMBER("getMultiLbSelIndex", (_this select 0)));
		};
		diag_log ("bad args sent to getMultiLbSelValue:" +str _this);
		[];
	};

	/*
	*	Prends le text d'un control dans le gui et le format dans un tableau
	*	input:scalar/control => id du control
	*	input:array => default value
	*	Return type: Array
	*/
	PUBLIC FUNCTION("scalar","getArrayFromControl") {
		private _a = [_this, []];
		MEMBER("getArrayFromControl", _a);
	};
	PUBLIC FUNCTION("control","getArrayFromControl") {
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
		if (_this isEqualTypeParams [0,[]]) exitWith {
			_control = MEMBER("getControl", _this select 0);
			private _a = [ctrlText _control, (toString [39]), (toString [34])];
			private _text = MEMBER("stringReplace", _a);
			_text = MEMBER("trim", _text);
			if !(MEMBER("isValidStringToArray", _text)) exitWith {
				diag_log ("Invalid string to array 'getArrayFromControl' " + str _this);
				_this select 1;
			};
			parseSimpleArray _text;
		};

		if (_this isEqualTypeParams [controlNull,[]]) exitWith {
			private _a = [ctrlText (_this select 0), (toString [39]), (toString [34])];
			private _text = MEMBER("stringReplace", _a);
			_text = MEMBER("trim", _text);
			if !(MEMBER("isValidStringToArray", _text)) exitWith {
				diag_log ("Invalid string to array 'getArrayFromControl' " + str _this);
				_this select 1;
			};
			parseSimpleArray _text;
		};
		diag_log ("Bad args sent to getArrayFromControl :" + str _this);
		[];
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
		if (_this isEqualTypeParams ["",[]]) exitWith {
			private _a = [ctrlText (_this select 0), (toString [39]), (toString [34])];
			private _text = MEMBER("stringReplace", _a);
			_text = MEMBER("trim", _text);
			if (!MEMBER("isValidStringToArray", _text)) exitWith {
				diag_log ("Invalid string to array 'getArrayFromControl' " + str _this);
				_this select 1;
			};
			parseSimpleArray _text;
		};
		[];
	};

	/*
	*	Retrieve text control & parse it to color
	*	@input:array
	*		1:id of control
	*		2:array default return
	*	@output:array
	*/
	PUBLIC FUNCTION("scalar","getColor") {
		private _a = [_this, [-1,-1,-1,-1]];
		MEMBER("getColor", _a);
	};
	PUBLIC FUNCTION("control","getColor") {
		private _a = [_this, [-1,-1,-1,-1]];
		MEMBER("getColor", _a);
	};	
	PUBLIC FUNCTION("array","getColor") {
		if (_this isEqualTypeParams [controlNull, []] || _this isEqualTypeParams [0,[]]) exitWith {
			_arr = MEMBER("getArrayFromControl", _this);
			if !((count _arr) isEqualTo 4) exitWith {
				_this select 1;
			};
			if (_arr isEqualTo [-1,-1,-1,-1]) exitWith {
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
		diag_log ("Bad args sent to getColor" + _this);	
		[-1,-1,-1,-1];	
	};

	PUBLIC FUNCTION("array","relativeCtrlPosToParent") {
		disableSerialization;
		if (_this isEqualTypeParams [controlNull,controlNull]) then {
			private _control = _this select 0;
			private _relativeTo = _this select 1;
			private _pos = ctrlPosition _control;
			private _parent = ctrlParentControlsGroup _control;
			if (_parent isEqualTo _relativeTo) exitWith {
				_pos;
			};
			private _posParent = ctrlPosition _parent;
			private _newPos = [
				(_posParent select 0) + (_pos select 0),
				(_posParent select 1) + (_pos select 1),
				_pos select 2,
				_pos select 3
			];			
			_parent = ctrlParentControlsGroup _parent;
			while {!(_parent isEqualTo _relativeTo)} do {
				if (_parent isEqualTo controlNull) exitWith {};
				_posParent = ctrlPosition _parent;
				_newPos = [
					(_posParent select 0) + (_newPos select 0),
					(_posParent select 1) + (_newPos select 1),
					_newPos select 2,
					_newPos select 3
				];
				_parent = ctrlParentControlsGroup _parent;
			};
			_newPos;
		};
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
	*	String operation
	*/
	PUBLIC FUNCTION("string","containSpace") {
		if (_this find " " > -1) exitWith {
			true;
		};
		false;
	};

	PUBLIC FUNCTION("string","removeSpecialChar") {
		private _arr = toArray _this;
		for "_i" from count _arr -1 to 0 step -1 do {
			_char = _arr select _i;
			if!(_char in ALPHA || _char in UPPER_ALPHA || _char in NUMERIC) then {
				_arr deleteAt _i;
			};
		};
		toString _arr;
	};

	PUBLIC FUNCTION("string","haveSpecialChar") {
		private _return = false;
		private _arr = toArray _this;
		for "_i" from count _arr -1 to 0 step -1 do {
			_char = _arr select _i;
			if!(_char in ALPHA || _char in UPPER_ALPHA || _char in NUMERIC) exitWith {
				_return = true;
			};
		};
		_return;
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
			diag_log "GUI HELPER stringReplace failed.. Bad args";
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
	*	Function to convert color array to texture
	*/
	PUBLIC FUNCTION("array","getTextureFromArray") {
		private _return = "#(rgb,8,8,3)color(1,1,1,1)";
		if!(_this isEqualTypeAll 0 || _this isEqualTypeAll "") exitWith{
			_return;
		};
		private _def = [0,0,0,1];
		if (count _this isEqualTo 1) then {
			_def set [0, _this select 0];
		};
		if (count _this isEqualTo 2) then {
			_def set [0, _this select 0];
			_def set [1, _this select 1];
		};
		if (count _this isEqualTo 3) then {
			_def set [0, _this select 0];
			_def set [1, _this select 1];
			_def set [2, _this select 2];
		};
		if (count _this isEqualTo 4) then {
			_def =_this;
		};
		"#(rgb,8,8,3)color("+(str (_def select 0))+","+(str (_def select 1))+","+(str (_def select 2))+","+(str (_def select 3))+")";
	};

	/*
	*	Rewrite parseNumber function
	*/
	PUBLIC FUNCTION("string","parseNumber") {
		private _arr = toArray _this;
		for "_i" from count _arr -1 to 0 step -1 do {
			if!((_arr select _i) in [48,49,50,51,52,53,54,55,56,57]) then{
				_arr deleteAt _i;
			};
		};
		parseNumber (toString _arr);
	};

	/*
	* Récupère l'index de la listbox
	*/
	PRIVATE FUNCTION("control","getLbSelIndex") { lbCurSel _this; };
	PRIVATE FUNCTION("control","getMultiLbSelIndex") { lbSelection _this; };

	PUBLIC FUNCTION("string","isValidStringToArray") {
		if ((_this select [0,1]) isEqualTo "[" && (_this select [count _this-1, 1]) isEqualTo "]") exitWith {
			true;
		};
		false;
	};

	PUBLIC FUNCTION("array","findInPair") {
		private _index = -1;
		if (_this isEqualTypeParams [[], ""]) exitWith {
			{
				if ((_x select 0) isEqualTo (_this select 1) && count _x isEqualTo 2) exitWith {
					_index = _forEachIndex;
				};
			} forEach (_this select 0);
			_index;
		};
	};
ENDCLASS;