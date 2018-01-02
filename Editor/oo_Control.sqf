#include "..\oop.h"
#define ALL_EVENTS [ \
	"Action", \
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

	PUBLIC FUNCTION("array","constructor") { 
		disableSerialization;
		private _parentLayer = param[0, {}, [{}]];
		private _control = param[1, controlNull, [controlNull]];
		private _type = param[2, "NoType", [""]];
		MEMBER("ParentLayer", _parentLayer);
		MEMBER("ID", -1);
		MEMBER("Type", _type);
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

	PUBLIC FUNCTION("","isEnabled") {
		ctrlEnabled MEMBER("Control", nil);
	};

	PUBLIC FUNCTION("bool","ctrlEnable") {
		MEMBER("Control", nil) ctrlEnable _this;
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
		MEMBER("Position", _this);
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

	PUBLIC FUNCTION("scalar","setNewID") {
		if (MEMBER("ID", nil) isEqualTo _this) exitWith {};		
		MEMBER("ID", _this); 
		"refreshAllCtrl" call MEMBER("ParentLayer", nil);
	};

	PUBLIC FUNCTION("scalar","setID") {	
		MEMBER("ID", _this);
	};

	PUBLIC FUNCTION("","refreshControl") {
		disableSerialization;
		ctrlDelete MEMBER("Control", nil);
		private _layer = "getLayer" call MEMBER("ParentLayer", nil);
		private _display = "getDisplay" call MEMBER("ParentLayer", nil);
		private _newCtrl = _display ctrlCreate[MEMBER("Type", nil), MEMBER("ID", nil), _layer];

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
	};

	PUBLIC FUNCTION("","getID") FUNC_GETVAR("ID");

	PUBLIC FUNCTION("string","setText") {
		MEMBER("Text", _this);
		MEMBER("Control", nil) ctrlSetText _this;
	};
	PUBLIC FUNCTION("","getText") {
		ctrlText MEMBER("Control", nil); 
	};

	PUBLIC FUNCTION("string","setTooltip") { 
		MEMBER("Tooltip", _this); 
		MEMBER("Control", nil) ctrlSetTooltip _this;
	};

	PUBLIC FUNCTION("","getTooltip") {
		MEMBER("Tooltip", nil);
	};

	PUBLIC FUNCTION("array","setTooltipColorBox") { 
		MEMBER("TooltipColorBox", _this); 
		if !(_this isEqualTo [-1,-1,-1,-1]) then {
			MEMBER("Control", nil) ctrlSetTooltipColorBox _this; 
		}else{
			"refreshAllCtrl" call MEMBER("ParentLayer", nil);
		};
	};
	PUBLIC FUNCTION("","getTooltipColorBox") {
		MEMBER("TooltipColorBox", nil);
	};

	PUBLIC FUNCTION("array","setTooltipColorShade") {
		MEMBER("TooltipColorShade", _this);  
		if !(_this isEqualTo [-1,-1,-1,-1]) then {
			MEMBER("Control", nil) ctrlSetTooltipColorShade _this; 
		}else{
			"refreshAllCtrl" call MEMBER("ParentLayer", nil);
		};
	};
	PUBLIC FUNCTION("","getTooltipColorShade") {
		MEMBER("TooltipColorShade", nil);
	};

	PUBLIC FUNCTION("array","setTooltipColorText") { 
		MEMBER("TooltipColorText", _this); 
		if !(_this isEqualTo [-1,-1,-1,-1]) then {
			MEMBER("Control", nil) ctrlSetTooltipColorText _this; 
		}else{
			"refreshAllCtrl" call MEMBER("ParentLayer", nil);
		};
	};

	PUBLIC FUNCTION("","getTooltipColorText") {
			MEMBER("TooltipColorText", nil); 
	};

	PUBLIC FUNCTION("array","setBackgroundColor") { 
		MEMBER("BGColor", _this); 
		if !(_this isEqualTo [-1,-1,-1,-1]) then {
			MEMBER("Control", nil) ctrlSetBackgroundColor _this; 
		}else{
			"refreshAllCtrl" call MEMBER("ParentLayer", nil);
		};
	};

	PUBLIC FUNCTION("","getBackgroundColor") {
		MEMBER("BGColor", nil);
	};

	PUBLIC FUNCTION("array","setForegroundColor") { 
		MEMBER("FGColor", _this);
		if !(_this isEqualTo [-1,-1,-1,-1]) then {
			MEMBER("Control", nil) ctrlSetForegroundColor _this; 
		}else{
			"refreshAllCtrl" call MEMBER("ParentLayer", nil);
		};
	};

	PUBLIC FUNCTION("","getForegroundColor") {
		MEMBER("FGColor", nil);
	};

	PUBLIC FUNCTION("array","setTextColor") { 
		MEMBER("TextColor", _this); 
		if !(_this isEqualTo [-1,-1,-1,-1]) then {
			MEMBER("Control", nil) ctrlSetTextColor _this;
		}else{
			"refreshAllCtrl" call MEMBER("ParentLayer", nil);
		};
	};	

	PUBLIC FUNCTION("","getTextColor") {
		MEMBER("TextColor", nil);
	};

	PUBLIC FUNCTION("","getPos") { 
		ctrlPosition MEMBER("Control", nil); 
	};

	PUBLIC FUNCTION("code","exportHPP") {
		["pushLine", format[("class %1_%2: " + MEMBER("getType", nil) + " {"), MEMBER("getType",nil), MEMBER("ID", nil)]] call _this;
		["modTab", +1] call _this;

		["pushLine", format["idc = %1;", MEMBER("ID", nil)]] call _this;
		private _pos = MEMBER("getPos", nil);
		["pushLine", format["x = %1 * pixelGrid * pixelW;", (((_pos select 0))/(pixelGrid * pixelW))]] call _this;
		["pushLine", format["y = %1 * pixelGrid * pixelH;", (((_pos select 1))/(pixelGrid * pixelW))]] call _this;
		["pushLine", format["w = %1 * pixelGrid * pixelW;", (((_pos select 2))/(pixelGrid * pixelW))]] call _this;
		["pushLine", format["h = %1 * pixelGrid * pixelH;", (((_pos select 3))/(pixelGrid * pixelH))]] call _this;
		{
			if (_x select 1) then {
				private _s =  format['%1 = "STATIC_FUNCTION(oo_DIALOG,', _x select 0] + format["'functionName'", _x select 0] +', '+"'_this'"+')";';
				["pushLine", _s] call _this;
			};
		} forEach MEMBER("EventArray", nil);
		["modTab", -1] call _this;
		["pushLine", "};"] call _this;
	};

	PUBLIC FUNCTION("array","fillDisplayTree") {
		disableSerialization;
		private _tree = _this select 0;
		private _path = _this select 1;
		private _index = _tree tvAdd[_path, format["%1_#%2",MEMBER("getType", nil), MEMBER("getID", nil)]];
		private _nPath = _path + [_index];
		_tree tvSetData [_nPath, format["%1",_self]];
	};

	PUBLIC FUNCTION("","getType") FUNC_GETVAR("Type");
	PUBLIC FUNCTION("","getTypeName") {_class;};
	PUBLIC FUNCTION("","getDisplay") FUNC_GETVAR("Display");
	PUBLIC FUNCTION("","getParentLayer") FUNC_GETVAR("ParentLayer");
	PUBLIC FUNCTION("","getControl") FUNC_GETVAR("Control");
	PUBLIC FUNCTION("","typeName") { ctrlType MEMBER("Control", nil); };
	PUBLIC FUNCTION("","getVisible") { MEMBER("Visible", nil); };
	PUBLIC FUNCTION("bool","setVisible") { MEMBER("Visible", _this); };


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