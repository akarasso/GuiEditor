#include "..\oop.h"

#define INDEX_ID 0
#define INDEX_POSITION 1
#define INDEX_TEXT 2
#define INDEX_NAME 3
#define INDEX_TP 4
#define INDEX_CONTROL_CLASS 5
#define INDEX_VISIBLE 6
#define INDEX_EVH 7

#define INDEX_TEXT_COLOR 8
#define INDEX_BGCOLOR 9
#define INDEX_FGCOLOR 10
#define INDEX_TP_COLOR_BOX 11
#define INDEX_TP_COLOR_SHADE 12
#define INDEX_TP_COLOR_TEXT 13

CLASS("oo_Control")
	PUBLIC STATIC_VARIABLE("code", "HelperGui");

	PUBLIC UI_VARIABLE("display", "Display");
	PUBLIC UI_VARIABLE("control", "Layer");
	PUBLIC UI_VARIABLE("control", "Control");

	PUBLIC VARIABLE("code", "GuiObject");
	PUBLIC VARIABLE("code", "Parent");
	PUBLIC VARIABLE("array", "Data");
	
	PUBLIC FUNCTION("array","constructor") { 
		disableSerialization;
		if (isNil {MEMBER("HelperGui", nil)}) then {
			private _g = "new" call oo_HelperGui;
			MEMBER("HelperGui", _g);
		};

		private _guiObject = param[0, {}, [{}]];
		private _display = param[1, displayNull, [displayNull]];
		private _parent = param[2, {}, [{}]];
		private _control = param[3, controlNull, [controlNull]];
		private _type = param[4, "NoType", [""]];
		private _id = param[5, -1, [0]];
		private _noColor = [-1,-1,-1,-1], _data = [];
		private _layerParent = "getControl" call _parent;

		MEMBER("GuiObject", _guiObject);
		MEMBER("Display", _display);
		MEMBER("Parent", _parent);
		MEMBER("Layer", _layerParent);
		MEMBER("Control", _control);
		
		_data set [INDEX_ID, _id];
		_data set [INDEX_POSITION, [0,0,0,0]];
		_data set [INDEX_TEXT, (ctrlText _control)];
		_data set [INDEX_NAME, ""];
		_data set [INDEX_TP, ""];
		_data set [INDEX_CONTROL_CLASS, _type];
		_data set [INDEX_VISIBLE, true];
		_data set [INDEX_EVH, []];
		
		_data set [INDEX_TEXT_COLOR, +_noColor];
		_data set [INDEX_BGCOLOR, +_noColor];
		_data set [INDEX_FGCOLOR, +_noColor];
		_data set [INDEX_TP_COLOR_BOX, +_noColor];
		_data set [INDEX_TP_COLOR_SHADE, +_noColor];
		_data set [INDEX_TP_COLOR_TEXT, +_noColor];
		MEMBER("Data", _data);
	};	

	PUBLIC FUNCTION("","colorizeControl") {
		_self spawn {
			disableSerialization;
			private _data = "getData" call _this;
			if (!_data select INDEX_VISIBLE) exitWith {};
			private _highlightControl = ("getDisplay" call _this) ctrlCreate["RscBackgroundGUI", -1, ("getLayer" call _this)];
			_highlightControl ctrlSetPosition (_data select INDEX_POSITION);
			_highlightControl ctrlSetFade 1;
			_highlightControl ctrlSetBackgroundColor [0.81,0.06,0,1];
			_highlightControl ctrlCommit 0;
			_highlightControl ctrlSetFade 0;
			_highlightControl ctrlCommit 0.5;
			sleep 0.5;
			_highlightControl ctrlSetFade 1;
			_highlightControl ctrlCommit 0.5;
			sleep 0.5;
			ctrlDelete _highlightControl;
		}; 
	};

	PUBLIC FUNCTION("array","setPos") {
		private _data = MEMBER("Data", nil);
		private _position = _data select INDEX_POSITION;
		private _control = MEMBER("Control", nil);
		if (count _this isEqualTo 1) then {
			_position set [0, _this select 0];
		};
		if (count _this isEqualTo 2) then {
			_position set [0, _this select 0];
			_position set [1, _this select 1];
		};
		if (count _this isEqualTo 3) then {
			_position set [0, _this select 0];
			_position set [1, _this select 1];
			_position set [2, _this select 2];
		};
		if (count _this isEqualTo 4) then {
			_position = _this;
		};
		_control ctrlSetPosition _this;
		_control ctrlCommit 0;
	};

	PUBLIC FUNCTION("string","setEvent") {
		private _data = MEMBER("Data", nil);
		private _evhArray = _data select INDEX_EVH;	
		_evhArray pushBackUnique _this;	
	};

	PUBLIC FUNCTION("string","getEventState") {
		private _evhArray = MEMBER("Data", nil) select INDEX_EVH;
		private _r = false;
		{
			if (_x isEqualTo _this) exitWith {
				_r = true;
			};
		} forEach _evhArray;
		_r;
	};

	PUBLIC FUNCTION("scalar","setNewID") {
		private _data = MEMBER("Data", nil);
		if (_data select INDEX_ID isEqualTo _this) exitWith {};
		_data set[INDEX_ID, _this];
		"refreshControl" call MEMBER("ParentLayer", nil);
	};

	PUBLIC FUNCTION("scalar","setID") {	
		if (_this > 0) then {
			MEMBER("Data", nil) set[INDEX_ID, _this];
			true;
		};
		false;
	};

	PUBLIC FUNCTION("","refreshControl") {
		disableSerialization;
		ctrlDelete MEMBER("Control", nil);
		private _data = MEMBER("Data", nil);
		private _refreshCtrl = MEMBER("Display", nil) ctrlCreate[_data select INDEX_CONTROL_CLASS, MEMBER("ID", nil), MEMBER("Layer", nil)];
		MEMBER("Control", _refreshCtrl);
		_refreshCtrl ctrlEnable _false;
		_refreshCtrl ctrlSetPosition MEMBER("Position", nil);
		_refreshCtrl ctrlSetText MEMBER("Text", nil);
		_refreshCtrl ctrlSetTooltip MEMBER("Tooltip", nil);

		if(!(_data select INDEX_TP_COLOR_BOX) isEqualTo [-1,-1,-1,-1]) then {
			_refreshCtrl ctrlSetTooltipColorBox (_data select INDEX_TP_COLOR_BOX);
		};

		if(!(_data select INDEX_TP_COLOR_SHADE) isEqualTo [-1,-1,-1,-1]) then {
			_refreshCtrl ctrlSetTooltipColorShade (_data select INDEX_TP_COLOR_SHADE);
		};

		if(!(_data select INDEX_TP_COLOR_TEXT) isEqualTo [-1,-1,-1,-1]) then {
			_refreshCtrl ctrlSetTooltipColorText (_data select INDEX_TP_COLOR_TEXT);
		};

		if(!(_data select INDEX_BGCOLOR) isEqualTo [-1,-1,-1,-1]) then {
			_refreshCtrl ctrlSetBackgroundColor (_data select INDEX_BGCOLOR);
		};

		if(!(_data select INDEX_FGCOLOR) isEqualTo [-1,-1,-1,-1]) then {
			_refreshCtrl ctrlSetForegroundColor (_data select INDEX_FGCOLOR);
		};

		if(!(_data select INDEX_TP_COLOR_TEXT) isEqualTo [-1,-1,-1,-1]) then {
			_refreshCtrl ctrlSetTextColor (_data select INDEX_TP_COLOR_TEXT);
		};
		_refreshCtrl ctrlCommit 0;
		if !(_data select INDEX_VISIBLE) then {
			_refreshCtrl ctrlShow false;
		};
	};

	PUBLIC FUNCTION("code","exportHPP") {
		private _data = MEMBER("Data", nil);
		private _helperGui = MEMBER("HelperGui", nil);
		private _pos = _data select INDEX_POSITION;
		private _id = _data select INDEX_ID;
		private _textColor = _data select INDEX_TEXT_COLOR;
		private _controlClass = _data select INDEX_CONTROL_CLASS;
		private _bgColor = _data select INDEX_BGCOLOR;
		private _fgColor = _data select INDEX_FGCOLOR;
		private _ttColor = _data select INDEX_TEXT_COLOR;
		private _ttColorBox = _data select INDEX_TP_COLOR_BOX;
		private _ttColorShade = _data select INDEX_TP_COLOR_TEXT;
		private _text = _data select INDEX_TEXT;
		private _tp = _data select INDEX_TP;
		private _display = MEMBER("Display", nil);
		private _name = (_data select INDEX_NAME);
		private _evhArray = (_data select INDEX_EVH);
		private _actionEvent = "";

		if ((_data select INDEX_NAME) isEqualTo "") then {
			_name = _controlClass + "_" + (str _id);
		};

		["pushLine", format[("class %1_%2: %1 {"), _controlClass, _id]] call _this;
		["modTab", +1] call _this;
		["pushLine", format["idc = %1;", _id]] call _this;
		["pushLine", format["x = %1 * pixelGrid * pixelW;", (((_pos select 0))/(pixelGrid * pixelW))]] call _this;
		["pushLine", format["y = %1 * pixelGrid * pixelH;", (((_pos select 1))/(pixelGrid * pixelH))]] call _this;
		["pushLine", format["w = %1 * pixelGrid * pixelW;", (((_pos select 2))/(pixelGrid * pixelW))]] call _this;
		["pushLine", format["h = %1 * pixelGrid * pixelH;", (((_pos select 3))/(pixelGrid * pixelH))]] call _this;
		["pushLine", format['text = "%1";', _text]] call _this;
		
		if !(_textColor isEqualTo [-1,-1,-1,-1]) then {
			["pushLine", format["colorText[] = {%1, %2, %3, %4};", _textColor select 0, _textColor select 1, _textColor select 2, _textColor select 3]] call _this;
		};
		if !(_bgColor isEqualTo [-1,-1,-1,-1]) then {
			["pushLine", format["colorBackground[] = {%1, %2, %3, %4};", _bgColor select 0, _bgColor select 1, _bgColor select 2, _bgColor select 3]] call _this;
		};
		if !(_fgColor isEqualTo [-1,-1,-1,-1]) then {
			["pushLine", format["colorForeground[] = {%1, %2, %3, %4};", _fgColor select 0, _fgColor select 1, _fgColor select 2, _fgColor select 3]] call _this;
		};
		if !(_tp isEqualTo "") then {
			["pushLine", format['tooltip = "%1";', _tp]] call _this;
		};
		if !(_ttColorShade isEqualTo [-1,-1,-1,-1]) then {
			["pushLine", format["tooltipColorShade[] = {%1, %2, %3, %4};", _ttColorShade select 0, _ttColorShade select 1, _ttColorShade select 2, _ttColorShade select 3]] call _this;
		};
		if !(_ttColor isEqualTo [-1,-1,-1,-1]) then {
			["pushLine", format["tooltipColorText[] = {%1, %2, %3, %4};", _ttColor select 0, _ttColor select 1, _ttColor select 2, _ttColor select 3]] call _this;
		};
		if !(_ttColorBox isEqualTo [-1,-1,-1,-1]) then {
			["pushLine", format["tooltipColorBox[] = {%1, %2, %3, %4};", _ttColorBox select 0, _ttColorBox select 1, _ttColorBox select 2, _ttColorBox select 3]] call _this;
		};		
		{
			if !((_x select 0) isEqualTo "Init") then {
				_actionEvent = "['static', ['%1', _this]] call oo_%2;";
				_actionEvent = ["stringFormat", [_actionEvent ,[((_x select 0)+"_"+_name), _display]]] call _helperGui;
				_actionEvent = format['%1 = "%2";', (_x select 0), _actionEvent];
				["pushLine", _actionEvent] call _this;
			};
		} forEach _evhArray;

		if (ctrlType MEMBER("Control", nil) isEqualTo 1) then {
			_actionEvent = "['static', ['%1', nil]] call oo_%2;";
			_actionEvent = ["stringFormat", [_actionEvent ,[("btnAction_"+_name), _display]]] call _helperGui;
			_actionEvent = format['action = "%1";', _actionEvent];
			["pushLine", _actionEvent] call _this;
		};
		["modTab", -1] call _this;
		["pushLine", "};"] call _this;
	};

	PUBLIC FUNCTION("code","exportOOP") {
		private _data = MEMBER("Data", nil);
		private _name = _data select INDEX_NAME;
		private _idString = str (_data select INDEX_ID);
		private _hasFunction = false;
		private _actionEvent = "";
		private _f = "";
		private _foundFnc = false;
		private _helperGui = MEMBER("HelperGui", nil);
		if (_name isEqualTo "") then {
			_name = (_data select INDEX_CONTROL_CLASS) + "_" + _idString;
		};

		{
			if (!_foundFnc) then {
				["addUIVar", ["public", "control", _name]] call _this;
				_actionEvent = "MEMBER(%1, MEMBER(%2,nil) displayCtrl %3);";
				_f = format['"%1"', _name];
				_actionEvent = ["stringFormat", [_actionEvent, [_f, '"Display"', _idString]]] call _helperGui;
				["addSuper", _actionEvent] call _this;
			};
			if (!_x isEqualTo "Init") then {
				_actionEvent = "MEMBER(%1, nil);";
				_f = format['"Init_%1"',_name];
				_actionEvent = ["stringFormat", [_actionEvent, [_f]]] call _helperGui;
				["addSuper", _actionEvent] call _this;
				["addFunction", ["", format["%1_%2", _x select 0, _name]]] call _this;
			}else{
				["addFunction", format["%1_%2", _x select 0, _name]] call _this;
			};
			_foundFnc = true;
		} forEach (_data select INDEX_EVH);

		if!(_data select INDEX_VISIBLE) then {
			if (!_foundFnc) then {
				["addUIVar", ["public", "control", _name]] call _this;
				_actionEvent = "MEMBER(%1, MEMBER(%2,nil) displayCtrl %3);";
				_f = format['"%1"', _name];
				_actionEvent = ["stringFormat", [_actionEvent, [_f, '"Display"', _idString]]] call _helperGui;
				["addSuper", _actionEvent] call _this;
			};
			_actionEvent = "MEMBER(%1, nil) ctrlShow false;";
			_f = format['"%1"',_name];
			_actionEvent = ["stringFormat", [_actionEvent, [_f]]] call _helperGui;
			["addSuper", _actionEvent] call _this;
		};
		if (ctrlType MEMBER("Control", nil) isEqualTo 1) then {
			["addFunction", ["", format["%1_%2","btnAction", _name]]] call _this;
		};
	};

	PUBLIC FUNCTION("array","fillDisplayTree") {
		disableSerialization;
		private _data = MEMBER("Data", nil);
		private _tree = _this select 0;
		private _path = _this select 1;
		private _index = _tree tvAdd[_path, format["%1_#%2", (_data select INDEX_CONTROL_CLASS), (_data select INDEX_ID)]];
		private _nPath = _path + [_index];
		_tree tvSetData [_nPath, format["%1",_self]];
		if (MEMBER("Visible", nil)) then {
			_tree tvSetPictureRight [_nPath, "coreimg\visible.jpg"];
		}else{
			_tree tvSetPictureRight [_nPath, "coreimg\invisible.jpg"];
		};
	};	

	PUBLIC FUNCTION("","moveUpControl") {
		["moveUpInChilds", _self] call MEMBER("Parent", nil);
	};

	PUBLIC FUNCTION("","moveDownControl") {
		["moveDownInChilds", _self] call MEMBER("Parent", nil);
	};	

	PUBLIC FUNCTION("","getData") { MEMBER("Data", nil); };
	PUBLIC FUNCTION("","getTypeName") { _class; };
	PUBLIC FUNCTION("","getDisplay") FUNC_GETVAR("Display");
	PUBLIC FUNCTION("","getParent") FUNC_GETVAR("Parent");
	PUBLIC FUNCTION("","getLayer") FUNC_GETVAR("Layer");
	PUBLIC FUNCTION("","getControl") FUNC_GETVAR("Control");
	PUBLIC FUNCTION("","getParentCountChilds") { "getCountChilds" call MEMBER("Parent", nil); };
	PUBLIC FUNCTION("","getPositionInChilds") {	("getChilds" call MEMBER("Parent", nil)) find _self; };
	PUBLIC FUNCTION("","isEnabled") { ctrlEnabled MEMBER("Control", nil); };

	PUBLIC FUNCTION("string","setTooltip") { 
		private _data = MEMBER("Data", nil);
		_data set [INDEX_TP, _this];
		MEMBER("Control", nil) ctrlSetTooltip _this;
	};

	PUBLIC FUNCTION("string","setText") {
		private _data = MEMBER("Data", nil);
		_data set [INDEX_TEXT, _this];
		MEMBER("Control", nil) ctrlSetText _this; 
	};

	PUBLIC FUNCTION("control","setControl") { 
		MEMBER("Control", _this);	
	};

	PUBLIC FUNCTION("bool","setVisible") { 
		private _data = MEMBER("Data", nil);
		_data set [INDEX_VISIBLE, _this];
		MEMBER("Control", nil) ctrlShow _this; 
	};

	PUBLIC FUNCTION("string","setName") {
		private _name = ["trim", _this] call MEMBER("HelperGui", nil);
		if !(["stringContain", [_name, " "]] call MEMBER("HelperGui", nil)) exitWith {
			private _data = MEMBER("Data", nil);
			_data set[INDEX_NAME, _name];
			true;
		};
		false;		
	};

	PUBLIC FUNCTION("array","setTooltipColorBox") { 
		private _data = MEMBER("Data", nil);
		_data set[INDEX_TP_COLOR_BOX, _this];
		if !(_this isEqualTo [-1,-1,-1,-1]) then {
			MEMBER("Control", nil) ctrlSetTooltipColorBox _this; 
		}else{
			"refreshControl" call MEMBER("Parent", nil);
		};
	};

	PUBLIC FUNCTION("array","setTooltipColorText") { 
		private _data = MEMBER("Data", nil);
		_data set[INDEX_TP_COLOR_TEXT, _this];
		if !(_this isEqualTo [-1,-1,-1,-1]) then {
			MEMBER("Control", nil) ctrlSetTooltipColorText _this; 
		}else{
			"refreshControl" call MEMBER("Parent", nil);
		};
	};

	PUBLIC FUNCTION("array","setTooltipColorShade") {
		private _data = MEMBER("Data", nil);
		_data set[INDEX_TP_COLOR_SHADE, _this];
		if !(_this isEqualTo [-1,-1,-1,-1]) then {
			MEMBER("Control", nil) ctrlSetTooltipColorShade _this; 
		}else{
			"refreshControl" call MEMBER("Parent", nil);
		};
	};

	PUBLIC FUNCTION("array","setBackgroundColor") { 
		private _data = MEMBER("Data", nil);
		_data set[INDEX_BGCOLOR, _this];
		if !(_this isEqualTo [-1,-1,-1,-1]) then {
			MEMBER("Control", nil) ctrlSetBackgroundColor _this; 
		}else{
			"refreshControl" call MEMBER("Parent", nil);
		};
	};

	PUBLIC FUNCTION("array","setForegroundColor") { 
		private _data = MEMBER("Data", nil);
		_data set[INDEX_FGCOLOR, _this];
		if !(_this isEqualTo [-1,-1,-1,-1]) then {
			MEMBER("Control", nil) ctrlSetForegroundColor _this; 
		}else{
			"refreshControl" call MEMBER("Parent", nil);
		};
	};

	PUBLIC FUNCTION("array","setTextColor") { 
		private _data = MEMBER("Data", nil);
		_data set[INDEX_TEXT_COLOR, _this];
		if !(_this isEqualTo [-1,-1,-1,-1]) then {
			MEMBER("Control", nil) ctrlSetTextColor _this;
		}else{
			"refreshControl" call MEMBER("Parent", nil);
		};
	};

	PUBLIC FUNCTION("","getPos") {
		ctrlPosition MEMBER("Control", nil);
	};

	PUBLIC FUNCTION("","getID") {
		private _data = MEMBER("Data", nil);
		_data select INDEX_ID;
	};
	PUBLIC FUNCTION("","deconstructor") { 
		disableSerialization;
		_c = MEMBER("Control", nil);
		ctrlDelete _c;
		["deleteCtrl", _self] call MEMBER("Parent", nil);
		DELETE_VARIABLE("GuiObject");
		DELETE_VARIABLE("Parent");
		DELETE_VARIABLE("Data");
		DELETE_UI_VARIABLE("Display");
		DELETE_UI_VARIABLE("Control");
		DELETE_UI_VARIABLE("ParentLayer");
	};
ENDCLASS;