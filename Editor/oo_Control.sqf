#include "..\oop.h"

#define INDEX_POSITION 0
#define INDEX_TEXT 1
#define INDEX_NAME 2
#define INDEX_TP 3
#define INDEX_CONTROL_CLASS 4
#define INDEX_VISIBLE 5
#define INDEX_EVH 6

#define INDEX_TEXT_COLOR 7
#define INDEX_BGCOLOR 8
#define INDEX_FGCOLOR 9
#define INDEX_TP_COLOR_BOX 10
#define INDEX_TP_COLOR_SHADE 11
#define INDEX_TP_COLOR_TEXT 12

CLASS("oo_Control")

	PUBLIC UI_VARIABLE("display", "Display");
	PUBLIC UI_VARIABLE("control", "Control");

	PUBLIC VARIABLE("array", "BoundBox");
	PUBLIC VARIABLE("code", "Parent");
	PUBLIC VARIABLE("array", "Data");
	PUBLIC VARIABLE("scalar", "ID");
	
	PUBLIC FUNCTION("array","constructor") { 
		disableSerialization;

		private _display = param[0, displayNull, [displayNull]];
		private _parent = param[1, {}, [{}]];
		private _control = param[2, controlNull, [controlNull]];
		private _type = param[3, "NoType", [""]];
		private _id = param[4, -1, [0]];
		private _noColor = [-1,-1,-1,-1], _data = [];

		MEMBER("Display", _display);
		MEMBER("Parent", _parent);
		MEMBER("Control", _control);
		MEMBER("ID", _id);

		_data set [INDEX_POSITION, (ctrlPosition _control)];
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

	/*
	*	Colorize control on press space
	*/
	PUBLIC FUNCTION("","colorizeControl") {
		MEMBER("this", nil) spawn {
			disableSerialization;
			private _data = "getData" call _this;
			if (isNil "_data") exitWith {};
			if (!(_data select INDEX_VISIBLE)) exitWith {};
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

	PUBLIC FUNCTION("bool","setEnable") {
		private _control = MEMBER("Control", nil);
		if (isNil "_control") exitWith {};
		_control ctrlEnable _this;
	};

	/*
	*	Set position of control	
	*	@input:array pos	
	*/
	PUBLIC FUNCTION("array","setPos") {
		disableSerialization;
		private _data = MEMBER("Data", nil);
		if (isNil "_data") exitWith {diag_log "data null";};
		private _position = _data select INDEX_POSITION;
		private _control = MEMBER("Control", nil);
		if (isNil "_control") exitWith {diag_log "control null";};
		if (isNull _control) exitWith {diag_log "control null";};
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
		diag_log format["Set %1 to %2", _control, _position];
		_data set[INDEX_POSITION, _position];
		_control ctrlSetPosition _position;
		_control ctrlCommit 0;
	};

	/*
	*	Add eventHandler to control
	*	@input:string => name of event handler
	*/
	PUBLIC FUNCTION("string","addEvent") {
		private _data = MEMBER("Data", nil);
		if (isNil "_data") exitWith {};
		private _evhArray = _data select INDEX_EVH;	
		if(_evhArray pushBackUnique _this > -1) then {
			true;
		}else{
			false;
		};
	};

	/*
	*	Remove eventHandler from control
	*	@input:string => name of event handler
	*/
	PUBLIC FUNCTION("string","rmEvent") {
		private _data = MEMBER("Data", nil);
		if (isNil "_data") exitWith {};
		private _index = (_data select INDEX_EVH) find _this;
		if !(_index isEqualTo -1) then {
			true;
			(_data select INDEX_EVH) deleteAt _index;
		}else{
			false;
		};
	};

	PUBLIC FUNCTION("scalar","findControlByID") {
		private _return = -1;
		if (MEMBER("ID", nil) isEqualTo _this) exitWith {
			_return = MEMBER("this", nil);
		};
		_return;
	};

	/*
	*	get eventHandler state from control
	*	@input:string => name of event handler
	*/
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

	/*
	*	Refresh control in display to show real z-index
	*/
	PUBLIC FUNCTION("","refreshControl") {
		disableSerialization;
		ctrlDelete MEMBER("Control", nil);
		MEMBER("Control", controlNull);
		private _layer = "getControl" call MEMBER("Parent", nil);
		if (_layer isEqualTo controlNull) exitWith {};
		private _data = MEMBER("Data", nil);
		private _refreshCtrl = MEMBER("Display", nil) ctrlCreate[(_data select INDEX_CONTROL_CLASS), MEMBER("ID", nil), _layer];
		MEMBER("Control", _refreshCtrl);
		_refreshCtrl ctrlEnable false;
		_refreshCtrl ctrlSetPosition (_data select INDEX_POSITION);
		_refreshCtrl ctrlSetText (_data select INDEX_TEXT);
		_refreshCtrl ctrlSetTooltip (_data select INDEX_TP);

		if!((_data select INDEX_TP_COLOR_BOX) isEqualTo [-1,-1,-1,-1]) then {
			_refreshCtrl ctrlSetTooltipColorBox (_data select INDEX_TP_COLOR_BOX);
		};

		if!((_data select INDEX_TP_COLOR_SHADE) isEqualTo [-1,-1,-1,-1]) then {
			_refreshCtrl ctrlSetTooltipColorShade (_data select INDEX_TP_COLOR_SHADE);
		};

		if!((_data select INDEX_TP_COLOR_TEXT) isEqualTo [-1,-1,-1,-1]) then {
			_refreshCtrl ctrlSetTooltipColorText (_data select INDEX_TP_COLOR_TEXT);
		};

		if!((_data select INDEX_BGCOLOR) isEqualTo [-1,-1,-1,-1]) then {
			_refreshCtrl ctrlSetBackgroundColor (_data select INDEX_BGCOLOR);
		};

		if!((_data select INDEX_FGCOLOR) isEqualTo [-1,-1,-1,-1]) then {
			_refreshCtrl ctrlSetForegroundColor (_data select INDEX_FGCOLOR);
		};

		if!((_data select INDEX_TP_COLOR_TEXT) isEqualTo [-1,-1,-1,-1]) then {
			_refreshCtrl ctrlSetTextColor (_data select INDEX_TP_COLOR_TEXT);
		};
		_refreshCtrl ctrlCommit 0;
		if!(_data select INDEX_VISIBLE) then {
			_refreshCtrl ctrlShow false;
		};
	};

	/*
	*	exportHPP copy to your clipboard the hpp
	*/
	PUBLIC FUNCTION("code","exportHPP") {
		private _data = MEMBER("Data", nil);
		if (isNil "_data") exitWith {};
		private _pos = _data select INDEX_POSITION;
		private _id = MEMBER("ID", nil);
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
		private _displayName = "getDisplayName" call GuiObject;
		private _name = (_data select INDEX_NAME);
		private _evhArray = (_data select INDEX_EVH);
		private _actionEvent = "";

		if ((_data select INDEX_NAME) isEqualTo "") then {
			_name = _controlClass + "_" + (str _id);
		};

		["pushLine", format[("class %1_%2: %3 {"), _name, _id, _controlClass]] call _this;
		["modTab", +1] call _this;
		["pushLine", format["idc = %1;", _id]] call _this;
		["pushLine", format["x = %1 * pixelGrid * pixelW;", (((_pos select 0))/(pixelGrid * pixelW))]] call _this;
		["pushLine", format["y = %1 * pixelGrid * pixelH;", (((_pos select 1))/(pixelGrid * pixelH))]] call _this;
		["pushLine", format["w = %1 * pixelGrid * pixelW;", (((_pos select 2))/(pixelGrid * pixelW))]] call _this;
		["pushLine", format["h = %1 * pixelGrid * pixelH;", (((_pos select 3))/(pixelGrid * pixelH))]] call _this;
		if!(_text isEqualTo "") then {
			["pushLine", format['text = "%1";', _text]] call _this;
		};
		
		
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
			if !(_x isEqualTo "Init") then {
				_actionEvent = "['static', ['%1', _this]] call oo_%2;";
				_actionEvent = ["stringFormat", [_actionEvent ,[(_x+"_"+_name), _displayName]]] call HelperGui;
				_actionEvent = format['%1 = "%2";', _x, _actionEvent];
				["pushLine", _actionEvent] call _this;
			};
		} forEach _evhArray;

		if (ctrlType MEMBER("Control", nil) isEqualTo 1) then {
			_actionEvent = "['static', ['%1', nil]] call oo_%2;";
			_actionEvent = ["stringFormat", [_actionEvent ,[("btnAction_"+_name), _displayName]]] call HelperGui;
			_actionEvent = format['action = "%1";', _actionEvent];
			["pushLine", _actionEvent] call _this;
		};
		["modTab", -1] call _this;
		["pushLine", "};"] call _this;
	};

	/*
	*	exportOOP class to your clipboard
	*/
	PUBLIC FUNCTION("code","exportOOP") {
		private _data = MEMBER("Data", nil);
		if (isNil "_data") exitWith {};
		private _name = _data select INDEX_NAME;
		private _idString = str (MEMBER("ID", nil));
		private _string = "";
		if (_name isEqualTo "") then {
			_name = (_data select INDEX_CONTROL_CLASS) + "_" + _idString;
		};

		if (!((_data select INDEX_NAME) isEqualTo "") || (count (_data select INDEX_EVH)) > 0 || !(_data select INDEX_VISIBLE) || ctrlType MEMBER("Control", nil) isEqualTo 1 || "Init" in (_data select INDEX_EVH)) then {
			["addUIVar", ["public", "control", _name]] call _this;
			_string = "MEMBER(" + format['"%1", _display displayCtrl %2);', _name, _idString];
			["addSuperSetter", _string] call _this;
		};

		{
			if(_x isEqualTo "Init") then {
				_string = "MEMBER(" + format['"Init_%1", nil);', _name];
				["addSuper", _string] call _this;
				["addFunction", [_x, _name, ""]] call _this;
			}else{
				["addFunction", [_x, _name, "array"]] call _this;
			};
		} forEach (_data select INDEX_EVH);

		if!(_data select INDEX_VISIBLE) then {
			_string = "MEMBER(" +format['"%1", nil) ctrlShow false;',_name];
			["addSuper", _string] call _this;
		};
		if (ctrlType MEMBER("Control", nil) isEqualTo 1) then {
			["addFunction", ["btnAction", _name, ""]] call _this;
		};
	};

	PUBLIC FUNCTION("array","fillDisplayTree") {
		disableSerialization;
		private _data = MEMBER("Data", nil);
		if (isNil "_data") exitWith {};
		private _tree = _this select 0;
		private _path = _this select 1;
		private "_index";
		if((_data select INDEX_NAME) isEqualTo "") then {
			_index = _tree tvAdd[_path, format["%1_#%2", (_data select INDEX_CONTROL_CLASS), (MEMBER("ID", nil))]];
		}else{
			_index = _tree tvAdd[_path, (_data select INDEX_NAME)];
		};
		private _nPath = _path + [_index];
		_tree tvSetData [_nPath, format["%1",MEMBER("this", nil)]];
		if (_data select INDEX_VISIBLE) then {
			_tree tvSetPictureRight [_nPath, "coreimg\visible.jpg"];
		}else{
			_tree tvSetPictureRight [_nPath, "coreimg\invisible.jpg"];
		};
	};

	PUBLIC FUNCTION("","moveUpControl") {
		["moveUpInChilds", MEMBER("this", nil)] call MEMBER("Parent", nil);
	};

	PUBLIC FUNCTION("","moveDownControl") {
		["moveDownInChilds", MEMBER("this", nil)] call MEMBER("Parent", nil);
	};	

	PUBLIC FUNCTION("","getData") { MEMBER("Data", nil); };
	PUBLIC FUNCTION("","getDuplicateData") { +MEMBER("Data", nil); };
	PUBLIC FUNCTION("","getTypeName") { _class; };
	PUBLIC FUNCTION("","getDisplay") FUNC_GETVAR("Display");
	PUBLIC FUNCTION("","getParent") FUNC_GETVAR("Parent");
	PUBLIC FUNCTION("","getLayer") { "getControl" call MEMBER("Parent", nil); };
	PUBLIC FUNCTION("","getControl") FUNC_GETVAR("Control");
	PUBLIC FUNCTION("","getParentCountChilds") { "getCountChilds" call MEMBER("Parent", nil); };
	PUBLIC FUNCTION("","getPositionInChilds") {	("getChilds" call MEMBER("Parent", nil)) find MEMBER("this", nil); };
	PUBLIC FUNCTION("","isEnabled") { ctrlEnabled MEMBER("Control", nil); };
	
	PUBLIC FUNCTION("array","setData") { 
		MEMBER("Data", _this); 
		MEMBER("refreshControl", nil); 
	};
	PUBLIC FUNCTION("string","setTooltip") { 
		private _data = MEMBER("Data", nil);
		if (isNil "_data") exitWith {};
		_data set [INDEX_TP, _this];
		MEMBER("Control", nil) ctrlSetTooltip _this;
	};

	PUBLIC FUNCTION("string","setText") {
		private _data = MEMBER("Data", nil);
		if (isNil "_data") exitWith {};
		_data set [INDEX_TEXT, _this];
		MEMBER("Control", nil) ctrlSetText _this; 
	};

	PUBLIC FUNCTION("control","setControl") { 
		MEMBER("Control", _this);	
	};

	PUBLIC FUNCTION("bool","setVisible") { 
		private _data = MEMBER("Data", nil);
		if (isNil "_data") exitWith {};
		_data set [INDEX_VISIBLE, _this];
		MEMBER("Control", nil) ctrlShow _this; 
	};

	PUBLIC FUNCTION("string","setName") {
		private _name = ["trim", _this] call HelperGui;
		if !(["stringContain", [_name, " "]] call HelperGui) exitWith {
			private _data = MEMBER("Data", nil);
			if (isNil "_data") exitWith {};
			_data set[INDEX_NAME, _name];
			true;
		};
		false;		
	};

	PUBLIC FUNCTION("array","setTooltipColorBox") { 
		private _data = MEMBER("Data", nil);
		if (isNil "_data") exitWith {};
		_data set[INDEX_TP_COLOR_BOX, _this];
		if !(_this isEqualTo [-1,-1,-1,-1]) then {
			MEMBER("Control", nil) ctrlSetTooltipColorBox _this; 
		};
	};

	PUBLIC FUNCTION("array","setTooltipColorText") { 
		private _data = MEMBER("Data", nil);
		if (isNil "_data") exitWith {};
		_data set[INDEX_TP_COLOR_TEXT, _this];
		if !(_this isEqualTo [-1,-1,-1,-1]) then {
			MEMBER("Control", nil) ctrlSetTooltipColorText _this; 
		};
	};

	PUBLIC FUNCTION("array","setTooltipColorShade") {
		private _data = MEMBER("Data", nil);
		if (isNil "_data") exitWith {};
		_data set[INDEX_TP_COLOR_SHADE, _this];
		if !(_this isEqualTo [-1,-1,-1,-1]) then {
			MEMBER("Control", nil) ctrlSetTooltipColorShade _this; 
		};
	};

	PUBLIC FUNCTION("array","setBackgroundColor") { 
		private _data = MEMBER("Data", nil);
		if (isNil "_data") exitWith {};
		_data set[INDEX_BGCOLOR, _this];
		if!(_this isEqualTo [-1,-1,-1,-1]) then {
			MEMBER("Control", nil) ctrlSetBackgroundColor _this; 
		};
	};

	PUBLIC FUNCTION("array","setForegroundColor") { 
		private _data = MEMBER("Data", nil);
		if (isNil "_data") exitWith {};
		_data set[INDEX_FGCOLOR, _this];
		if !(_this isEqualTo [-1,-1,-1,-1]) then {
			MEMBER("Control", nil) ctrlSetForegroundColor _this; 
		};
	};

	PUBLIC FUNCTION("array","setTextColor") { 
		private _data = MEMBER("Data", nil);
		if (isNil "_data") exitWith {};
		_data set[INDEX_TEXT_COLOR, _this];
		if !(_this isEqualTo [-1,-1,-1,-1]) then {
			MEMBER("Control", nil) ctrlSetTextColor _this;
		};
	};

	PUBLIC FUNCTION("","getPos") {
		ctrlPosition MEMBER("Control", nil);
	};

	PUBLIC FUNCTION("","getID") {
		MEMBER("ID", nil);
	};

	PUBLIC FUNCTION("","getType") {
		private _data = MEMBER("Data", nil);
		if (isNil "_data") exitWith {};
		_data select INDEX_CONTROL_CLASS;
	};

	PUBLIC FUNCTION("array","serializeControl") {
		_this pushBack MEMBER("getSerializeData", nil);
		_this;
	};

	PUBLIC FUNCTION("bool","ctrlShow") {
		private _data =	MEMBER("Data", nil);
		if (isNil "_data") exitWith {};
		if (_this) then {
			if ((_data select INDEX_VISIBLE)) then {
				MEMBER("Control", nil) ctrlShow _this;
			};
		}else{
			MEMBER("Control", nil) ctrlShow _this;
		};		
	};

	PUBLIC FUNCTION("","centerH") {
		private _parentPos = ctrlPosition ("getControl" call MEMBER("Parent", nil));
		private _pos = ctrlPosition MEMBER("Control", nil);
		private _a = [((_parentPos select 2)/2) - (_pos select 2)/2, _pos select 1, _pos select 2, _pos select 3];
		MEMBER("setPos", _a);
	};

	PUBLIC FUNCTION("","centerV") {
		private _parentPos = ctrlPosition ("getControl" call MEMBER("Parent", nil));
		private _pos = ctrlPosition MEMBER("Control", nil);
		private _a = [_pos select 0, ((_parentPos select 3)/2) - (_pos select 3)/2, _pos select 2, _pos select 3];
		MEMBER("setPos", _a);
	};

	PUBLIC FUNCTION("","getSerializeData") {
		private _data = MEMBER("Data", nil);
		if (isNil "_data") exitWith {};
		private _pos = _data select INDEX_POSITION;
		private _posString = [
			format["%1 * pixelGrid * pixelW", (((_pos select 0))/(pixelGrid * pixelW))],
			format["%1 * pixelGrid * pixelH", (((_pos select 1))/(pixelGrid * pixelH))],
			format["%1 * pixelGrid * pixelW", (((_pos select 2))/(pixelGrid * pixelW))],
			format["%1 * pixelGrid * pixelH", (((_pos select 3))/(pixelGrid * pixelH))]
		];
		private _a = [
			[
				_posString,
				_data select INDEX_TEXT,
				_data select INDEX_NAME,
				_data select INDEX_TP,
				_data select INDEX_CONTROL_CLASS,
				_data select INDEX_VISIBLE,
				_data select INDEX_EVH,
				_data select INDEX_TEXT_COLOR,
				_data select INDEX_BGCOLOR,
				_data select INDEX_FGCOLOR,
				_data select INDEX_TP_COLOR_BOX,
				_data select INDEX_TP_COLOR_SHADE,
				_data select INDEX_TP_COLOR_TEXT
			]
		];
		_a;
	};
	
	PUBLIC FUNCTION("array","setColorBoundbox") {
		diag_log "SetColor";
		{
			_x ctrlSetBackgroundColor _this;
		} forEach MEMBER("Boundbox", nil);
	};

	PUBLIC FUNCTION("array","RefreshBoundBox") {
		private _active = param[0, {}, [{}]];
		private _parentColor = param[1, [], [[]]];
		private _activeColor = param[2, [], [[]]];
		private _childColor = param[3, [], [[]]];
		private _isParent = param[4, false, [false]];
		private _boundbox = MEMBER("Boundbox", nil);
		if !(MEMBER("couldActiveBoundbox", nil)) exitWith {};
		MEMBER("boundboxEnable", true);
		MEMBER("refreshPosBoundbox", nil);
		
		if (MEMBER("this", nil) isEqualTo _active) then {
			_this set[4, false];
			MEMBER("setColorBoundbox", _activeColor);
		}else{
			if (_isParent) then {
				MEMBER("setColorBoundbox", _parentColor);
			};
			if (!_isParent) then {
				MEMBER("setColorBoundbox", _childColor);
			};
		};	
	};

	

	PUBLIC FUNCTION("","refreshPosBoundbox") {
		private _boundBox = MEMBER("Boundbox", nil);
		if (count _boundBox > 0) then {
			diag_log "Refresh position boundbox";
			private _thicknessX = 0.001 * safezoneH;
			private _thicknessY = _thicknessX * 4/3;

			private _control = MEMBER("Control", nil);
			private _posControl = ctrlPosition _control;
			(_boundBox select 0) ctrlSetPosition [
				0,
				0, 
				(_posControl select 2), 
				2*_thicknessY
			];
			(_boundBox select 1) ctrlSetPosition [
				0,
				0, 
				2*_thicknessX, 
				_posControl select 3
			];
			(_boundBox select 2) ctrlSetPosition [
				0,
				(_posControl select 3) - (2*_thicknessY), 
				(_posControl select 2), 
				2*_thicknessY
			];
			(_boundBox select 3) ctrlSetPosition [
				(_posControl select 2) - (2*_thicknessX),
				0, 
				(2*_thicknessX), 
				_posControl select 3
			];
			{
				_x ctrlCommit 0;
			} forEach _boundBox;
		};
	};

	PUBLIC FUNCTION("bool","boundboxEnable") {
		disableSerialization;
		if (_this) exitWith {
			diag_log "Enable boundbox";
			private _display = MEMBER("Display", nil);
			private _control = MEMBER("Control", nil);
			private _parentControl = MEMBER("Control", nil);
			private _boundBox = MEMBER("BoundBox", nil);
			if (count _boundBox > 0) then {
				{
					ctrlDelete _x;
				} forEach _boundBox;
				_boundBox = [];
			};			
			_boundBox pushBack (_display ctrlCreate ["RscText", -40, _parentControl]);
			_boundBox pushBack (_display ctrlCreate ["RscText", -41, _parentControl]);
			_boundBox pushBack (_display ctrlCreate ["RscText", -42, _parentControl]);
			_boundBox pushBack (_display ctrlCreate ["RscText", -43, _parentControl]);
		};
		if (!_this) then {
			private _boundBox = MEMBER("BoundBox", nil);
			{
				ctrlDelete _x;
			} forEach _boundBox;
			MEMBER("BoundBox", []);
		};
	};

	/**
	*	Interface
	**/
	PUBLIC FUNCTION("","couldBeWorkground") {
		false;
	};

	PUBLIC FUNCTION("","couldActiveBoundbox") {
		diag_log "control acti";
		false;
	};

	PUBLIC FUNCTION("","deconstructor") { 
		disableSerialization;
		ctrlDelete MEMBER("Control", nil);		
		DELETE_VARIABLE("Parent");
		DELETE_VARIABLE("Data");
		DELETE_UI_VARIABLE("Display");
		DELETE_UI_VARIABLE("Control");
		DELETE_UI_VARIABLE("Layer");
	};
ENDCLASS;