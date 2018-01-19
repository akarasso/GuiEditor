#include "..\oop.h"
CLASS_EXTENDS("oo_makeOOPFile", "oo_makeFile")
	
	PUBLIC VARIABLE("scalar", "IDD");
	PUBLIC VARIABLE("string", "ClassName");

	PUBLIC VARIABLE("array", "FunctionList");
	PUBLIC VARIABLE("array", "VariableList");
	PUBLIC VARIABLE("array", "ConstructorString");

	PUBLIC FUNCTION("array","constructor") {
		SUPER("constructor", nil);
		MEMBER("ClassName", _this select 0);
		MEMBER("IDD", _this select 1);

		MEMBER("ConstructorString", []);
		MEMBER("VariableList", []);
		MEMBER("FunctionList", []);

		private _v = ["ui","display","Display"];
		MEMBER("addVariable", _v);
		private _v = ["ui","control","MainLayer"];
		MEMBER("addVariable", _v);
	};

	/*
	*	same as addVar but in uiNamespace
	*/
	PUBLIC FUNCTION("array","addVariable") {
		private _namespace = tolower (_this select 0);
		private _typeName = toLower (_this select 1);
		private _name = _this select 2;
		MEMBER("VariableList", nil) pushBack [_namespace, _typeName, _name];
	};

	/*
	*	Must be in [scalar:order, "string"];
	*		order:	0 => Setter
	*				1 => exec line
	*/
	PUBLIC FUNCTION("array","addConstructorString") {
		MEMBER("ConstructorString", nil) pushBack _this;
	};

	/*
	*	add method to oop class
	*	@array:
	*		1:name of function
	*		2:string type of input args
	*		3:default line?
	*/
	PUBLIC FUNCTION("array","addFunction") {
		if (count _this isEqualTo 3) then {
			_this pushBack [];
		};
		MEMBER("FunctionList", nil) pushBack _this;
	};

	PUBLIC FUNCTION("","importVariableList") {
		{
			if (_forEachIndex isEqualTo 0) then { MEMBER("pushLineBreak", nil);	};
			if ((_x select 0) isEqualTo "ui") then {
				_string = "PUBLIC STATIC_UI_VARIABLE(" + format['"%1", "%2");',_x select 1, _x select 2];
				MEMBER("pushLine", _string);
			};
			if ((_x select 0) isEqualTo "") then {
				_string = "PUBLIC STATIC_VARIABLE(" + format['"%1", "%2");',_x select 1, _x select 2];
				MEMBER("pushLine", _string);
			};
		} forEach MEMBER("VariableList", nil);
	};

	PUBLIC FUNCTION("","importFunctionList") {
		private _f = "", _doc = [], _complete = [];
		{
			MEMBER("pushLineBreak", nil);
			if!(_f isEqualTo (_x select 0)) then {
				_f = _x select 0;
				_doc = MEMBER("documentFunction", _x select 0);
				_complete = MEMBER("completeFunction", _x select 0);
				for "_i" from 0 to count _doc -1 do {
					_item = _doc select _i;
					MEMBER("pushLine", _item );
				};
			};			
			_string = "PUBLIC FUNCTION(" + format['"%1", "%2_%3") {',_x select 2, _x select 0, _x select 1];
			MEMBER("pushLine", _string );
			MEMBER("modTab", +1);
			for "_i" from 0 to count _complete -1 do {
				_item = _complete select _i;
				MEMBER("pushLine", _item );
			};
			for "_i" from 0 to count (_x select 3) -1 do {
				_item = (_x select 3) select _i;
				MEMBER("pushLine", _item );
			};
			MEMBER("pushLineBreak", nil);
			MEMBER("modTab", -1);
			MEMBER("pushLine", '};' );
		} forEach MEMBER("FunctionList", nil);
	};

	PUBLIC FUNCTION("","sort") {
		MEMBER("Functions", nil) sort true;
		MEMBER("VariableList", nil) sort true;
		MEMBER("ConstructorString", nil) sort true;
	};

	PUBLIC FUNCTION("","makeGetterAndSetter") {
		private _arr = [];
		{
			_string = "PUBLIC FUNCTION("+ format['"", "get%1")',_x select 2] + " FUNC_GETVAR(" + format['"%1");', _x select 2];
			_arr pushBack [0, _string];

			_string = "PUBLIC FUNCTION("+ format['"%1", "set%2"){', _x select 1,_x select 2] + " MEMBER(" + format['"%1", _this); };', _x select 2];
			_arr pushBack [1, _string];
		} forEach MEMBER("VariableList", nil);
		_arr sort true;
		{
			MEMBER("pushLine", (_x select 1));
		} forEach _arr;
	};

	/*
	*	Construct all oop class et paste it into clipboard
	*/
	PUBLIC FUNCTION("","exec") {
		MEMBER("sort", nil);
		private _string = "", _doc = [], _complete = [];
		
		MEMBER("Buffer", "");

		MEMBER("pushLine", '#include "..\oop.h"');
		_string = "CLASS(" + format['"oo_%1")',MEMBER("ClassName", nil)];
		MEMBER("pushLine", _string);
		MEMBER("modTab", +1);

		MEMBER("importVariableList", nil);

		MEMBER("pushLineBreak", nil);
		//Constructor
		_string = "PUBLIC FUNCTION(" + '"display", "constructor"){';
		MEMBER("pushLine", _string );
		MEMBER("modTab", +1);
		MEMBER("pushLine", "disableSerialization;");
		_string = "MEMBER(" + '"Display", _this);';
		MEMBER("pushLine", _string);
		_string = "MEMBER(" + '"MainLayer", _this displayCtrl 100);';
		MEMBER("pushLine", _string);
		{
			MEMBER("pushLine", (_x select 1));
		} forEach MEMBER("ConstructorString", nil);
		// Add init defautl function 
		_string = "MEMBER(" + '"Init", nil);';
		MEMBER("pushLine", _string);
		MEMBER("modTab", -1);
		MEMBER("pushLine", "};" );

		//Add function
		_string = "PUBLIC FUNCTION(" + '"", "Init"){';
		MEMBER("pushLine", _string );
		MEMBER("modTab", +1);
		MEMBER("pushLine", "//Add your content here to init display" );
		MEMBER("modTab", -1);
		MEMBER("pushLine", '};' );
		
		MEMBER("importFunctionList", nil);

		MEMBER("makeGetterAndSetter", nil);
		// Deconstructor
		_string = "PUBLIC FUNCTION(%1, %2){";
		_string = ["stringFormat", [_string, ['""', '"deconstructor"']]] call HelperGui;
		MEMBER("pushLine", _string );
		MEMBER("modTab", +1);
		{
			if ((_x select 0) isEqualTo "ui") then {
				_string = "DELETE_UI_VARIABLE(" + format['"%1"', _x select 2] +");";
			};
			if ((_x select 0) isEqualTo "") then {
				_string = "DELETE_VARIABLE(" + format['"%1"', _x select 2] +");";
			};			
			MEMBER("pushLine", _string);
		} forEach MEMBER("VariableList", nil);

		MEMBER("modTab", -1);
		MEMBER("pushLine", "};" );

		MEMBER("modTab", -1);
		MEMBER("pushLine", "ENDCLASS;");

		// //Spécifique Function
		copyToClipboard MEMBER("Buffer", nil);
		MEMBER("Buffer", "");
	};

	PUBLIC FUNCTION("string","completeFunction") {
		switch (_this) do { 
			case "onLoad" : {
				["private _control = _this select 0;"];
			};
			case "onUnload" : {
				["private _display = _this select 0;",
				"private _exitCode = _this select 1;"];
			};
			case "onChildDestroyed" : {
				["private _display = _this select 0;",
				"private _child = _this select 1;",
				"private _exitCode = _this select 2;"];
			};
			case "onMouseEnter" : {
				["private _control = _this select 0;"];
			};
			case "onMouseExit" : {
				["private _control = _this select 0;"];
			};
			case "onSetFocus" : {
				["private _control = _this select 0;"];
			};
			case "onKillFocus" : {
				["private _control = _this select 0;"];
			};
			case "onTimer" : {
				["private _control = _this select 0;"];
			};
			case "onKeyDown" : {
				["private _control = _this select 0;",
				"private _keyCode = _this select 1;",
				"private _shiftState = _this select 2;",
				"private _ctrlState = _this select 3;",
				"private _altCode = _this select 4;"];
			};
			case "onKeyUp" : {
				["private _control = _this select 0;",
				"private _keyCode = _this select 1;",
				"private _shiftState = _this select 2;",
				"private _ctrlState = _this select 3;",
				"private _altState = _this select 4;"];
			};
			case "onChar" : {
				["private _control = _this select 0;",
				"private _char = _this select 1;"];
			};
			case "onChar" : {
				["private _control = _this select 0;",
				"private _char = _this select 1;"];
			};
			case "onIMEChar" : {
				["private _control = _this select 0;",
				"private _char = _this select 1;"];
			};
			case "onIMEComposition" : {
				["private _control = _this select 0;",
				"private _char = _this select 1;"];
			};
			case "onMouseButtonDown" : {
				["private _control = _this select 0;",
				"private _button = _this select 1;",
				"private _abs = _this select 2;",
				"private _ord = _this select 3;",
				"private _shiftState = _this select 4;",
				"private _ctrlState = _this select 5;",
				"private _altState = _this select 6;"];
			};
			case "onMouseButtonUp" : {
				["private _control = _this select 0;",
				"private _button = _this select 1;",
				"private _abs = _this select 2;",
				"private _ord = _this select 3;",
				"private _shiftState = _this select 4;",
				"private _ctrlState = _this select 5;",
				"private _altState = _this select 6;"];
			};
			case "onMouseButtonClick" : {
				["private _control = _this select 0;",
				"private _button = _this select 1;",
				"private _abs = _this select 2;",
				"private _ord = _this select 3;",
				"private _shiftState = _this select 4;",
				"private _ctrlState = _this select 5;",
				"private _altState = _this select 6;"];
			};
			case "onMouseButtonDblClick" : {
				["private _control = _this select 0;",
				"private _button = _this select 1;",
				"private _abs = _this select 2;",
				"private _ord = _this select 3;",
				"private _shiftState = _this select 4;",
				"private _ctrlState = _this select 5;",
				"private _altState = _this select 6;"];
			};
			case "onMouseMoving" : {
				["private _control = _this select 0;",
				"private _abs = _this select 1;",
				"private _ord = _this select 2;",
				"private _mouseOver = _this select 3;"];
			};
			case "onMouseHolding" : {
				["private _control = _this select 0;",
				"private _abs = _this select 1;",
				"private _ord = _this select 2;",
				"private _mouseOver = _this select 3;"];
			};
			case "onMouseZChanged" : {
				["private _control = _this select 0;",
				"private _move = _this select 1;"];
			};
			case "onCanDestroy" : {
				["private _control = _this select 0;",
				"private _exitCode = _this select 1;"];
			};
			case "onDestroy" : {
				["private _control = _this select 0;",
				"private _exitCode = _this select 1;"];
			};
			case "onButtonClick" : {
				["private _control = _this select 0;"];
			};
			case "onButtonDown" : {
				["private _control = _this select 0;"];
			};
			case "onButtonUp" : {
				["private _control = _this select 0;"];
			};
			case "onLBSelChanged" : {
				["private _control = _this select 0;",
				"private _index = _this select 1;"];
			};
			case "onLBListSelChanged" : {
				["private _control = _this select 0;",
				"private _index = _this select 1;"];
			};
			case "onLBDblClick" : {
				["private _control = _this select 0;",
				"private _index = _this select 1;"];
			};
			case "onLBDrag" : {
				["private _control = _this select 0;",
				"private _index = _this select 1;"];
			};
			case "onLBDragging" : {
				["private _control = _this select 0;",
				"private _abs = _this select 1;",
				"private _ord = _this select 2;"];
			};
			case "onLBDrop" : {
				["private _control = _this select 0;",
				"private _abs = _this select 1;",
				"private _ord = _this select 2;"];
			};
			case "onTreeSelChanged" : {
				["private _control = _this select 0;",
				"private _path = _this select 1;"];
			};
			case "onTreeSelChanged" : {
				["private _control = _this select 0;",
				"private _path = _this select 1;"];
			};
			case "onTreeLButtonDown" : {
				["private _control = _this select 0;"];
			};
			case "onTreeDblClick" : {
				["private _control = _this select 0;",
				"private _path = _this select 1;"];
			};
			case "onTreeExpanded" : {
				["private _control = _this select 0;"];
			};
			case "onTreeCollapsed" : {
				["private _control = _this select 0;"];
			};
			case "onTreeMouseMove" : {
				["private _control = _this select 0;"];
			};
			case "onTreeMouseHold" : {
				["private _control = _this select 0;"];
			};
			case "onTreeMouseExit" : {
				["private _control = _this select 0;"];
			};
			case "onToolBoxSelChanged" : {
				["private _control = _this select 0;",
				"private _index = _this select 1;"];
			};
			case "onCheckedChanged" : {
				["private _control = _this select 0;",
				"private _scalar = _this select 1;"];
			};
			case "onCheckBoxesSelChanged" : {
				["private _control = _this select 0;",
				"private _index = _this select 1;",
				"private _state = _this select 2;"];
			};
			case "onHTMLLink" : {
				["private _control = _this select 0;",
				"private _href = _this select 1;"];
			};
			case "onSliderPosChanged" : {
				["private _control = _this select 0;",
				"private _new = _this select 1;"];
			};
			case "onDraw" : {
				["private _control = _this select 0;"];
			};
			case "onVideoStopped" : {
				["private _control = _this select 0;"];
			};
			default { []; }; 
		};
	};

	PUBLIC FUNCTION("string","documentFunction") {
		switch (_this) do { 
			case "onLoad" : {
				["/*",
				"*	onLoad",
				"*		Fires when UI container is created.",
				"*		Returns the display or control in format Array.",
				"*/"];
			};
			case "onUnload" : {
				["/*",
				"*	onUnload",
				"*		Display is closed, but no controls are destroyed yet.",
				"*		Returns the display and exit code.",
				"*/"];
			};
			case "btnAction" : {
				[];
			};
			case "onChildDestroyed" : {
				["/*",
				"*	onChildDestroyed:",
				"*		Child display is closed.",
				"*		Returns the display and exit code.",
				"*/"];
			};
			case "onMouseEnter" : {
				["/*",
				"*	onMouseEnter:",
				"*		The mouse pointer enters the control area.",
				"*		Returns control.",
				"*/"];
			};
			case "onMouseExit" : {
				["/*",
				"*	onMouseExit:",
				"*		The mouse pointer exits the control area.",
				"*		Returns control.",
				"*/"];
			};
			case "onMouseEnter" : {
				["/*",
				"*	onMouseEnter:",
				"*		The mouse pointer enters the control area.",
				"*		Returns control.",
				"*/"];
			};
			case "onSetFocus" : {
				["/*",
				"*	onSetFocus:",
				"*		Input focus is on control. It now begins to accept keyboard input.",
				"*		Returns control.",
				"*/"];
			};
			case "onMouseEnter" : {
				["/*",
				"*	onMouseEnter:",
				"*		The mouse pointer enters the control area.",
				"*		Returns control.",
				"*/"];
			};
			case "onKillFocus" : {
				["/*",
				"*	onKillFocus:",
				"*		Input focus is no longer on control. It no longer accepts keyboard input.",
				"*		Returns control.",
				"*/"];
			};
			case "onMouseEnter" : {
				["/*",
				"*	onMouseEnter:",
				"*		The mouse pointer enters the control area.",
				"*		Returns control.",
				"*/"];
			};
			case "onTimer" : {
				["/*",
				"*	onTimer:",
				"*		After amount of time given by setTimer function.",
				"*		Returns control.",
				"*/"];
			};
			case "onKeyDown" : {
				["/*",
				"*	onKeyDown:",
				"*		Pressing any keyboard key. Fired before the onKeyUp event.",
				"*		Returns the control, the keyboard code and the state of Shift, Ctrl and Alt.",
				"*/"];
			};
			case "onKeyUp" : {
				["/*",
				"*	onKeyUp:",
				"*		Releasing any keyboard key. Fired after the onKeyDown event.",
				"*		Returns the control, the keyboard code and the state of Shift, Ctrl and Alt.",
				"*/"];
			};
			case "onChar" : {
				["/*",
				"*	onChar:",
				"*		When some readable characters is recognised.",
				"*		Returns the control and the char code.",
				"*/"];
			};
			case "onIMEChar" : {
				["/*",
				"*	onIMEChar:",
				"*		When IME character is recognized (used in Korean and other eastern languages).",
				"*		Returns the control and the char code.",
				"*/"];
			};
			case "onIMEComposition" : {
				["/*",
				"*	onIMEComposition:",
				"*		When partial IME character is recognized (used in Korean and other eastern languages).",
				"*		Returns the control and the char code.",
				"*/"];
			};
			case "onMouseButtonDown" : {
				["/*",
				"*	onMouseButtonDown:",
				"*		Pressing a mouse button. Followed by the onMouseButtonUp event.",
				"*		Returns the control, the pressed button, the x and y coordinates and the state of Shift, Ctrl and Alt.",
				"*/"];
			};
			case "onMouseButtonUp" : {
				["/*",
				"*	onMouseButtonUp:",
				"*		Releasing a mouse button. Follows the onMouseButtonDown event.",
				"*		Returns the control, the pressed button, the x and y coordinates and the state of Shift, Ctrl and Alt.",
				"*/"];
			};
			case "onMouseButtonClick" : {
				["/*",
				"*	onMouseButtonClick:",
				"*		Pressing and releasing a mouse button.",
				"*		Returns the control, the pressed button, the x and y coordinates and the state of Shift, Ctrl and Alt.",
				"*/"];
			};
			case "onMouseButtonDblClick" : {
				["/*",
				"*	onMouseButtonDblClick:",
				"*		Pressing and releasing a mouse button twice within very short time.",
				"*		Returns the control, the pressed button, the x and y coordinates and the state of Shift, Ctrl and Alt.",
				"*/"];
			};
			case "onMouseMoving" : {
				["/*",
				"*	onMouseMoving:",
				"*		https://community.bistudio.com/wiki/User_Interface_Event_Handlers.",
				"*/"];
			};
			case "onMouseHolding" : {
				["/*",
				"*	onMouseHolding:",
				"*		Fires continuously while mouse is not moving with a certain interval.",
				"*		Returns the control, the x and y coordinates and mouseOver. If used with a display, the mouseOver parameter is excluded.",
				"*/"];
			};
			case "onMouseZChanged" : {
				["/*",
				"*	onMouseZChanged:",
				"*		Fires when mouse wheel position is changed.",
				"*		Returns the display or control and the change of the scrollwheel.",
				"*/"];
			};
			case "onCanDestroy" : {
				["/*",
				"*	onCanDestroy:",
				"*		Ask this control if dialog can be closed.",
				"*		Returns the control and exit code.",
				"*/"];
			};
			case "onDestroy" : {
				["/*",
				"*	onDestroy:",
				"*		Destroying control.",
				"*		Returns the control and exit code.",
				"*/"];
			};
			case "onButtonClick" : {
				["/*",
				"*	onButtonClick:",
				"*		The attached button action is performed. When returned value is true, button's display remains opened.",
				"*		Returns control.",
				"*/"];
			};
			case "onButtonDblClick" : {
				["/*",
				"*	onButtonDblClick:",
				"*		https://community.bistudio.com/wiki/User_Interface_Event_Handlers",
				"*/"];
			};
			case "onButtonDown" : {
				["/*",
				"*	onButtonDown:",
				"*		The left mouse button is pressed over the button area or a key on the keyboard is pressed.",
				"*		Returns control.",
				"*/"];
			};
			case "onButtonUp" : {
				["/*",
				"*	onButtonUp:",
				"*		The left mouse buttons is released outside the button area and the attached button action is not performed.",
				"*		Returns control.",
				"*/"];
			};
			case "onLBSelChanged" : {
				["/*",
				"*	onLBSelChanged:",
				"*		The selection in a listbox is changed. The left mouse button has been released and the new selection is fully made.",
				"*		Returns the control and the selected element index.",
				"*/"];
			};
			case "onLBListSelChanged" : {
				["/*",
				"*	onLBListSelChanged:",
				"*		Selection in XCombo box changed.",
				"*		Returns the control and the selected element index.",
				"*/"];
			};
			case "onLBDblClick" : {
				["/*",
				"*	onLBDblClick:",
				"*		Double click on some row in listbox.",
				"*		Returns the control and the selected element index.",
				"*/"];
			};
			case "onLBDrag" : {
				["/*",
				"*	onLBDrag:",
				"*		Drag & drop operation started.",
				"*		Returns the control and the selected element index.",
				"*/"];
			};
			case "onLBDragging" : {
				["/*",
				"*	onLBDragging:",
				"*		Drag & drop operation is in progress.",
				"*		Returns the control and the x and y coordinates.",
				"*/"];
			};
			case "onLBDrop" : {
				["/*",
				"*	onLBDrop:",
				"*		Drag & drop operation finished.",
				"*		Returns the control and the x and y coordinates.",
				"*/"];
			};
			case "onTreeSelChanged" : {
				["/*",
				"*	onTreeSelChanged:",
				"*		Pressing and releasing left mouse button on a tree.",
				"*		Returns the control.",
				"*/"];
			};
			case "onTreeDblClick" : {
				["/*",
				"*	onTreeDblClick:",
				"*		Pressing and releasing twice on a tree entry.",
				"*		Returns the control and the current selection path.",
				"*/"];
			};
			case "onTreeExpanded" : {
				["/*",
				"*	onTreeExpanded:",
				"*		The tree folder structure has been expanded.",
				"*		Returns the control.",
				"*/"];
			};
			case "onTreeCollapsed" : {
				["/*",
				"*	onTreeCollapsed:",
				"*		The tree folder structure has been collapsed.",
				"*		Returns the control.",
				"*/"];
			};
			case "onTreeMouseMove" : {
				["/*",
				"*	onTreeMouseMove:",
				"*		Fires continuously while moving the mouse with a certain interval.",
				"*		Returns the control.",
				"*/"];
			};
			case "onTreeMouseHold" : {
				["/*",
				"*	onTreeMouseHold:",
				"*		Fires continuously while mouse is not moving with a certain interval.",
				"*		Returns the control.",
				"*/"];
			};
			case "onTreeMouseExit" : {
				["/*",
				"*	onTreeMouseExit:",
				"*		The mouse pointer exits the tree control area.",
				"*		Returns the control.",
				"*/"];
			};
			case "onToolBoxSelChanged" : {
				["/*",
				"*	onToolBoxSelChanged:",
				"*		Changed the selection in a toolbox.",
				"*		Returns the control and the selected element index.",
				"*/"];
			};
			case "onChecked" : {
				["/*",
				"*	onChecked:",
				"*		CheckBox checked.",
				"*/"];
			};
			case "onCheckedChanged" : {
				["/*",
				"*	onCheckedChanged:",
				"*		Checked state of CheckBox changed.",
				"*		Returns control and the checked state (0 or 1, not boolean).",
				"*/"];
			};
			case "onCheckBoxesSelChanged" : {
				["/*",
				"*	onCheckBoxesSelChanged:",
				"*		Changed the selection in a checkbox.",
				"*		Returns the control, the selected element index and the current state.",
				"*/"];
			};
			case "onHTMLLink" : {
				["/*",
				"*	onHTMLLink:",
				"*		Pressing and releasing a HTML link.",
				"*		Returns the control and href.",
				"*/"];
			};
			case "onSliderPosChanged" : {
				["/*",
				"*	onSliderPosChanged:",
				"*		Changing the position of a slider.",
				"*		Returns the control and the change.",
				"*/"];
			};
			case "onObjectMoved" : {
				["/*",
				"*	onObjectMoved:",
				"*		Moving an object.",
				"*		Returns the control and the offset on the x, y and z axes.",
				"*/"];
			};
			case "onDraw" : {
				["/*",
				"*	onDraw:",
				"*		Fires when the map is drawn (can occur more than once per second).",
				"*		Returns the map control",
				"*/"];
			};
			case "onVideoStopped" : {
				["/*",
				"*	onVideoStopped:",
				"*		Activated every time video ends (when looped, handler is executed after every finished loop).",
				"*		Returns the control",
				"*/"];
			};
			default { ["//You could check: https://community.bistudio.com/wiki/User_Interface_Event_Handlers"]; }; 
		};
	};

ENDCLASS;