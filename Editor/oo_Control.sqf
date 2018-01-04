#include "..\oop.h"
#define ALL_EVENTS [ \
	"Init", \
	"onDestroy", \
	"onLoad", \
	"onUnload", \
	"onSetFocus", \
	"onKillFocus", \
	"onTimer", \
	"onCanDestroy", \
	"onMouseButtonDown", \
	"onMouseButtonUp", \
	"onMouseButtonClick", \
	"onMouseButtonDblClick", \
	"onMouseMoving", \
	"onMouseHolding", \
	"onMouseZChanged", \
	"onButtonDblClick", \
	"onButtonDown", \
	"onButtonUp", \
	"onButtonClick", \
	"onMouseEnter", \
	"onMouseExit", \
	"onKeyDown", \
	"onKeyUp", \
	"onChar", \
	"onIMEChar", \
	"onIMEComposition", \
	"onJoystickButton", \
	"onLBSelChanged", \
	"onLBListSelChanged", \
	"onLBDblClick", \
	"onLBDrag", \
	"onLBDragging", \
	"onLBDrop", \
	"onTreeSelChanged", \
	"onTreeLButtonDown", \
	"onTreeDblClick", \
	"onTreeExpanded", \
	"onTreeCollapsed", \
	"onTreeMouseMove", \
	"onTreeMouseHold", \
	"onTreeMouseExit", \
	"onToolBoxSelChanged", \
	"onChecked", \
	"onCheckedChanged", \
	"onCheckBoxesSelChanged", \
	"onHTMLLink", \
	"onSliderPosChanged", \
	"onObjectMoved", \
	"onMenuSelected", \
	"onDraw", \
	"onVideoStopped" \
]

CLASS("oo_Control")
	PUBLIC STATIC_VARIABLE("code", "HelperGui");

	PUBLIC VARIABLE("code", "ParentLayer");
	PUBLIC VARIABLE("scalar", "ID");
	PUBLIC VARIABLE("string", "Type");
	PUBLIC UI_VARIABLE("control", "Control");

	PUBLIC VARIABLE("array", "TextColor");
	PUBLIC VARIABLE("array", "BGColor");
	PUBLIC VARIABLE("array", "FGColor");
	PUBLIC VARIABLE("array", "Position");
	PUBLIC VARIABLE("string", "Tooltip");
	PUBLIC VARIABLE("string", "Text");
	PUBLIC VARIABLE("array", "TooltipColorBox");
	PUBLIC VARIABLE("array", "TooltipColorShade");
	PUBLIC VARIABLE("array", "TooltipColorText");
	PUBLIC VARIABLE("array", "EventArray");
	PUBLIC VARIABLE("bool", "Visible");
	PUBLIC VARIABLE("string", "Name");

	PUBLIC FUNCTION("array","constructor") { 
		disableSerialization;
		if (isNil {MEMBER("HelperGui", nil)}) then {
			private _g = "new" call oo_HelperGui;
			MEMBER("HelperGui", _g);
		};
		private _parentLayer = param[0, {}, [{}]];
		private _control = param[1, controlNull, [controlNull]];
		private _type = param[2, "NoType", [""]];
		MEMBER("ParentLayer", _parentLayer);
		MEMBER("ID", -1);
		MEMBER("Type", _type);
		MEMBER("Name", "");
		MEMBER("Visible", true);
		MEMBER("Control", _control);
		MEMBER("Text", ctrlText _control);
		private _default_event = [];
		{
			_default_event pushBack [_x, false];
		} forEach ALL_EVENTS;
		MEMBER("EventArray", _default_event);
		private _noColor = [-1,-1,-1,-1];
		MEMBER("BGColor", _noColor);
		MEMBER("FGColor", _noColor);
		MEMBER("TooltipColorBox", _noColor);
		MEMBER("TooltipColorShade", _noColor);
		MEMBER("TooltipColorText", _noColor);
		MEMBER("TextColor", _noColor);
		MEMBER("Tooltip", "");
		MEMBER("Position", []);
	};	

	PUBLIC FUNCTION("","colorizeControl") {
		_self spawn {
			disableSerialization;
			if !("getVisible" call _this) exitWith {};
			private _layerParent = "getParentLayer" call _this;
			private _highlightControl = ("getDisplay" call _layerParent) ctrlCreate["RscBackgroundGUI", -1, ("getLayer" call _layerParent)];
			_highlightControl ctrlSetPosition ("getPos" call _this);
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
		if (count _this isEqualTo 1) then {
			MEMBER("Position", nil) set [0, _this select 0];
		};
		if (count _this isEqualTo 2) then {
			MEMBER("Position", nil) set [0, _this select 0];
			MEMBER("Position", nil) set [1, _this select 1];
		};
		if (count _this isEqualTo 3) then {
			MEMBER("Position", nil) set [0, _this select 0];
			MEMBER("Position", nil) set [1, _this select 1];
			MEMBER("Position", nil) set [2, _this select 2];
		};
		if (count _this isEqualTo 4) then {
			MEMBER("Position", _this);
		};		
		MEMBER("Control", nil) ctrlSetPosition _this;
		MEMBER("Control", nil) ctrlCommit 0;
	};

	PUBLIC FUNCTION("array","setEvent") {
		private _validArgs = params[
			["_name", "",[""]],
			["_bool", 0,[0]]
		];
		if (!_validArgs) exitWith {
			hint format["Bad args setEvent. Input send:%1", _this];
		};
		{
			if ((_x select 0) isEqualTo _name) exitWith {
				if (_bool isEqualTo 0) then {
					_x set[1, false];
				}else{
					_x set[1, true];
				};
			};
		} forEach MEMBER("EventArray", nil);
	};

	PUBLIC FUNCTION("string","getEventState") {
		private _r = false;
		{
			if (_x select 0 isEqualTo _this) exitWith {
				_r = _x select 1;
			};
		} forEach MEMBER("EventArray", nil);
		_r;
	};

	PUBLIC FUNCTION("scalar","setNewID") {
		if (MEMBER("ID", nil) isEqualTo _this) exitWith {};		
		MEMBER("ID", _this); 
		"refreshAllCtrl" call MEMBER("ParentLayer", nil);
	};

	PUBLIC FUNCTION("scalar","setID") {	
		if (_this > 0) then {
			MEMBER("ID", _this);
			true;
		};
		false;
	};

	PUBLIC FUNCTION("","refreshControl") {
		disableSerialization;
		ctrlDelete MEMBER("Control", nil);
		private _newCtrl = ("getDisplay" call MEMBER("ParentLayer", nil)) ctrlCreate[MEMBER("Type", nil), MEMBER("ID", nil), ("getLayer" call MEMBER("ParentLayer", nil))];
		MEMBER("Control", _newCtrl);
		MEMBER("ctrlEnable", false);
		MEMBER("Control", nil) ctrlSetPosition MEMBER("Position", nil);
		MEMBER("Control", nil) ctrlSetText MEMBER("Text", nil);
		MEMBER("Control", nil) ctrlSetTooltip MEMBER("Tooltip", nil);
		if !(MEMBER("TooltipColorBox", nil) isEqualTo [-1,-1,-1,-1]) then {
			MEMBER("Control", nil) ctrlSetTooltipColorBox MEMBER("TooltipColorBox", nil);
		};
		if !(MEMBER("TooltipColorShade", nil) isEqualTo [-1,-1,-1,-1]) then {
			MEMBER("Control", nil) ctrlSetTooltipColorShade MEMBER("TooltipColorShade", nil);
		};
		if !(MEMBER("TooltipColorText", nil) isEqualTo [-1,-1,-1,-1]) then {
			MEMBER("Control", nil) ctrlSetTooltipColorText MEMBER("TooltipColorText", nil);
		};
		if !(MEMBER("BGColor", nil) isEqualTo [-1,-1,-1,-1]) then {
			MEMBER("Control", nil) ctrlSetBackgroundColor MEMBER("BGColor", nil);
		};
		if !(MEMBER("FGColor", nil) isEqualTo [-1,-1,-1,-1]) then {
			MEMBER("Control", nil) ctrlSetForegroundColor MEMBER("FGColor", nil);
		};
		if !(MEMBER("TextColor", nil) isEqualTo [-1,-1,-1,-1]) then {
			MEMBER("Control", nil) ctrlSetTextColor MEMBER("TextColor", nil);
		};
		MEMBER("Control", nil) ctrlCommit 0;
		if !(MEMBER("Visible", nil)) then {
			MEMBER("hideControl", nil);
		};
	};

	PUBLIC FUNCTION("","hideControl") {
		MEMBER("Control", nil) ctrlShow false;
	};

	PUBLIC FUNCTION("code","exportHPP") {
		["pushLine", format[("class %1_%2: " + MEMBER("getType", nil) + " {"), MEMBER("getType",nil), MEMBER("ID", nil)]] call _this;
		["modTab", +1] call _this;
		["pushLine", format["idc = %1;", MEMBER("ID", nil)]] call _this;
		private _pos = MEMBER("getPos", nil);
		["pushLine", format["x = %1 * pixelGrid * pixelW;", (((_pos select 0))/(pixelGrid * pixelW))]] call _this;
		["pushLine", format["y = %1 * pixelGrid * pixelH;", (((_pos select 1))/(pixelGrid * pixelH))]] call _this;
		["pushLine", format["w = %1 * pixelGrid * pixelW;", (((_pos select 2))/(pixelGrid * pixelW))]] call _this;
		["pushLine", format["h = %1 * pixelGrid * pixelH;", (((_pos select 3))/(pixelGrid * pixelH))]] call _this;
		
		private _textColor = MEMBER("getTextColor", nil);
		private _bgColor = MEMBER("getBackgroundColor", nil);
		private _fgColor = MEMBER("getForegroundColor", nil);
		private _ttColor = MEMBER("getTooltipColorText", nil);
		private _ttColorBox = MEMBER("getTooltipColorBox", nil);
		private _ttColorShade = MEMBER("getTooltipColorShade", nil);

		["pushLine", format['text = "%1";', MEMBER("getText", nil)]] call _this;
		if !(_textColor isEqualTo [-1,-1,-1,-1]) then {
			["pushLine", format["colorText[] = {%1, %2, %3, %4};", _textColor select 0, _textColor select 1, _textColor select 2, _textColor select 3]] call _this;
		};
		if !(_bgColor isEqualTo [-1,-1,-1,-1]) then {
			["pushLine", format["colorBackground[] = {%1, %2, %3, %4};", _bgColor select 0, _bgColor select 1, _bgColor select 2, _bgColor select 3]] call _this;
		};
		if !(_fgColor isEqualTo [-1,-1,-1,-1]) then {
			["pushLine", format["colorForeground[] = {%1, %2, %3, %4};", _fgColor select 0, _fgColor select 1, _fgColor select 2, _fgColor select 3]] call _this;
		};
		if !(MEMBER("getTooltip", nil) isEqualTo "") then {
			["pushLine", format['tooltip = "%1";', MEMBER("getTooltip", nil)]] call _this;
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
		
		private _gui = "getGuiObject" call MEMBER("ParentLayer", nil);
		private _name = "";
		private _actionEvent = "";
		if (MEMBER("Name", nil) isEqualTo "") then {
			_name = MEMBER("Type", nil) + "_" + (str MEMBER("ID", nil));
		}else{
			_name = MEMBER("Name", nil);
		};
		{
			if ((_x select 1) && !((_x select 0) isEqualTo "Init")) then {
				_actionEvent = "['static', ['%1', _this]] call oo_%2;";
				_actionEvent = ["stringFormat", [_actionEvent ,[((_x select 0)+"_"+_name), "getDisplayName" call _gui]]] call MEMBER("HelperGui", nil);
				_actionEvent = format['%1 = "%2";', (_x select 0), _actionEvent];
				["pushLine", _actionEvent] call _this;
			};
		} forEach MEMBER("EventArray", nil);

		if (ctrlType MEMBER("Control", nil) isEqualTo 1) then {
			_actionEvent = "['static', ['%1', nil]] call oo_%2;";
			_actionEvent = ["stringFormat", [_actionEvent ,[("btnAction_"+_name), "getDisplayName" call _gui]]] call MEMBER("HelperGui", nil);
			_actionEvent = format['action = "%1";', _actionEvent];
			["pushLine", _actionEvent] call _this;
		};		

		["modTab", -1] call _this;
		["pushLine", "};"] call _this;
	};

	PUBLIC FUNCTION("code","exportOOP") {
		private _hasFunction = false;
		private _name = "";
		private _actionEvent = "";
		private _f = "";
		private _foundFnc = false;

		if (MEMBER("Name", nil) isEqualTo "") then {
			_name = MEMBER("Type", nil) + "_" + (str MEMBER("ID", nil));
		}else{
			_name = MEMBER("Name", nil);
		};

		{
			if (_x select 1) then {
				if (!_foundFnc) then {
					["addUIVar", ["public", "control", _name]] call _this;
					_actionEvent = "MEMBER(%1, MEMBER(%2,nil) displayCtrl %3);";
					_f = format['"%1"', _name];
					_actionEvent = ["stringFormat", [_actionEvent, [_f, '"Display"', str MEMBER("ID", nil)]]] call MEMBER("HelperGui", nil);
					["addSuper", _actionEvent] call _this;
				};		
				if (_x select 0 isEqualTo "Init") then {
					_actionEvent = "MEMBER(%1, nil);";
					_f = format['"Init_%1"',_name]; 
					_actionEvent = ["stringFormat", [_actionEvent, [_f]]] call MEMBER("HelperGui", nil);
					["addSuper", _actionEvent] call _this;
					["addFunction", ["", format["%1_%2", _x select 0, _name]]] call _this;
				}else{
					["addFunction", format["%1_%2", _x select 0, _name]] call _this;
				};			
				_foundFnc = true;
			};
		} forEach MEMBER("EventArray", nil);
		if !(MEMBER("Visible", nil)) then {
			if (_foundFnc) then {
				_actionEvent = "MEMBER(%1, nil) ctrlShow false;";
				_f = format['"%1"',_name];
				_actionEvent = ["stringFormat", [_actionEvent, [_f]]] call MEMBER("HelperGui", nil);
				["addSuper", _actionEvent] call _this;
			}else{
				_actionEvent = "(MEMBER(%1, nil) displayCtrl %2) ctrlShow false;";
				_actionEvent = ["stringFormat", [_actionEvent, ['"Display"', str MEMBER("ID", nil)]]] call MEMBER("HelperGui", nil);
				["addSuper", _actionEvent] call _this;
			};
		};
		if (ctrlType MEMBER("Control", nil) isEqualTo 1) then {
			["addFunction", ["", format["%1_%2","btnAction", _name]]] call _this;
		};
	};

	PUBLIC FUNCTION("array","fillDisplayTree") {
		disableSerialization;
		private _tree = _this select 0;
		private _path = _this select 1;
		private _index = _tree tvAdd[_path, format["%1_#%2",MEMBER("getType", nil), MEMBER("getID", nil)]];
		private _nPath = _path + [_index];
		_tree tvSetData [_nPath, format["%1",_self]];
		if (MEMBER("Visible", nil)) then {
			_tree tvSetPictureRight [_nPath, "coreimg\visible.jpg"];
		}else{
			_tree tvSetPictureRight [_nPath, "coreimg\invisible.jpg"];
		};
	};	

	PUBLIC FUNCTION("","moveUpControl") {
		["moveUpInChilds", _self] call MEMBER("ParentLayer", nil);
	};

	PUBLIC FUNCTION("","moveDownControl") {
		["moveDownInChilds", _self] call MEMBER("ParentLayer", nil);
	};	
	
	PUBLIC FUNCTION("","getType") FUNC_GETVAR("Type");
	PUBLIC FUNCTION("","getTypeName") {_class;};
	PUBLIC FUNCTION("","getDisplay") FUNC_GETVAR("Display");
	PUBLIC FUNCTION("","getParentLayer") FUNC_GETVAR("ParentLayer");
	PUBLIC FUNCTION("","getControl") FUNC_GETVAR("Control");
	PUBLIC FUNCTION("","typeName") { ctrlType MEMBER("Control", nil); };
	PUBLIC FUNCTION("","getVisible") { MEMBER("Visible", nil); };
	PUBLIC FUNCTION("","getName") { MEMBER("Name", nil); };
	PUBLIC FUNCTION("","getID") FUNC_GETVAR("ID");
	PUBLIC FUNCTION("","getText") { ctrlText MEMBER("Control", nil); };
	PUBLIC FUNCTION("","getTooltip") { MEMBER("Tooltip", nil); };
	PUBLIC FUNCTION("","getTooltipColorBox") { MEMBER("TooltipColorBox", nil); };
	PUBLIC FUNCTION("","getTooltipColorShade") { MEMBER("TooltipColorShade", nil); };
	PUBLIC FUNCTION("","getTooltipColorText") {	MEMBER("TooltipColorText", nil); };
	PUBLIC FUNCTION("","getBackgroundColor") { MEMBER("BGColor", nil); };
	PUBLIC FUNCTION("","getForegroundColor") { MEMBER("FGColor", nil); };
	PUBLIC FUNCTION("","getTextColor") { MEMBER("TextColor", nil); };
	PUBLIC FUNCTION("","getPos") { ctrlPosition MEMBER("Control", nil); };
	PUBLIC FUNCTION("","getParentCountChilds") { "getCountChilds" call MEMBER("ParentLayer", nil); };
	PUBLIC FUNCTION("","getPositionInChilds") {	("getChilds" call MEMBER("ParentLayer", nil)) find _self; };
	PUBLIC FUNCTION("","isEnabled") { ctrlEnabled MEMBER("Control", nil); };

	PUBLIC FUNCTION("","ctrlDelete") { ctrlDelete MEMBER("Control", nil); };
	PUBLIC FUNCTION("string","setTooltip") { MEMBER("Tooltip", _this); MEMBER("Control", nil) ctrlSetTooltip _this;	};
	PUBLIC FUNCTION("string","setText") { MEMBER("Text", _this); MEMBER("Control", nil) ctrlSetText _this; };
	PUBLIC FUNCTION("control","setControl") { MEMBER("Control", _this);	};
	PUBLIC FUNCTION("bool","setVisible") { MEMBER("Visible", _this); MEMBER("Control", nil) ctrlShow _this; };
	PUBLIC FUNCTION("string","setName") { 
		private _name = ["trim", _this] call MEMBER("HelperGui", nil);
		if !(["stringContain", [_name, " "]] call MEMBER("HelperGui", nil)) exitWith {
			MEMBER("Name", _name);
			true;
		};
		false;		
	};

	PUBLIC FUNCTION("array","setTooltipColorBox") { 
		MEMBER("TooltipColorBox", _this); 
		if !(_this isEqualTo [-1,-1,-1,-1]) then {
			MEMBER("Control", nil) ctrlSetTooltipColorBox _this; 
		}else{
			"refreshAllCtrl" call MEMBER("ParentLayer", nil);
		};
	};

	PUBLIC FUNCTION("array","setTooltipColorText") { 
		MEMBER("TooltipColorText", _this); 
		if !(_this isEqualTo [-1,-1,-1,-1]) then {
			MEMBER("Control", nil) ctrlSetTooltipColorText _this; 
		}else{
			"refreshAllCtrl" call MEMBER("ParentLayer", nil);
		};
	};

	PUBLIC FUNCTION("array","setTooltipColorShade") {
		MEMBER("TooltipColorShade", _this);  
		if !(_this isEqualTo [-1,-1,-1,-1]) then {
			MEMBER("Control", nil) ctrlSetTooltipColorShade _this; 
		}else{
			"refreshAllCtrl" call MEMBER("ParentLayer", nil);
		};
	};

	PUBLIC FUNCTION("array","setBackgroundColor") { 
		MEMBER("BGColor", _this); 
		if !(_this isEqualTo [-1,-1,-1,-1]) then {
			MEMBER("Control", nil) ctrlSetBackgroundColor _this; 
		}else{
			"refreshAllCtrl" call MEMBER("ParentLayer", nil);
		};
	};

	PUBLIC FUNCTION("array","setForegroundColor") { 
		MEMBER("FGColor", _this);
		if !(_this isEqualTo [-1,-1,-1,-1]) then {
			MEMBER("Control", nil) ctrlSetForegroundColor _this; 
		}else{
			"refreshAllCtrl" call MEMBER("ParentLayer", nil);
		};
	};

	PUBLIC FUNCTION("array","setTextColor") { 
		MEMBER("TextColor", _this); 
		if !(_this isEqualTo [-1,-1,-1,-1]) then {
			MEMBER("Control", nil) ctrlSetTextColor _this;
		}else{
			"refreshAllCtrl" call MEMBER("ParentLayer", nil);
		};
	};
	PUBLIC FUNCTION("bool","ctrlEnable") {	MEMBER("Control", nil) ctrlEnable _this; };

	PUBLIC FUNCTION("","deconstructor") { 
		disableSerialization;
		["deleteCtrl", MEMBER("ID", nil)] call MEMBER("ParentLayer", nil);
		ctrlDelete MEMBER("Control", nil);
		DELETE_VARIABLE("ParentLayer");
		DELETE_VARIABLE("ID");
		DELETE_VARIABLE("Type");
		DELETE_UI_VARIABLE("Control");
		DELETE_VARIABLE("TextColor");
		DELETE_VARIABLE("BGColor");
		DELETE_VARIABLE("FGColor");
		DELETE_VARIABLE("Position");
		DELETE_VARIABLE("Tooltip");
		DELETE_VARIABLE("Text");
		DELETE_VARIABLE("TooltipColorBox");
		DELETE_VARIABLE("TooltipColorShade");
		DELETE_VARIABLE("TooltipColorText");
	};
ENDCLASS;