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
	PUBLIC UI_VARIABLE("code", "ParentLayer");
	PUBLIC UI_VARIABLE("scalar", "ID");
	PUBLIC UI_VARIABLE("string", "Type");
	PUBLIC UI_VARIABLE("control", "Control");

	PUBLIC UI_VARIABLE("array", "TextColor");
	PUBLIC UI_VARIABLE("array", "BGColor");
	PUBLIC UI_VARIABLE("array", "FGColor");
	PUBLIC UI_VARIABLE("string", "Tooltip");
	PUBLIC UI_VARIABLE("array", "TooltipColorBox");
	PUBLIC UI_VARIABLE("array", "TooltipColorShade");
	PUBLIC UI_VARIABLE("array", "TooltipColorText");

	PUBLIC VARIABLE("array", "EventArray");
	

	PUBLIC FUNCTION("array","constructor") { 
		private _parentLayer = param[0, {}, [{}]];
		private _control = param[1, controlNull, [controlNull]];
		private _type = param[2, "NoType", [""]];
		MEMBER("ParentLayer", _parentLayer);
		MEMBER("ID", -1);
		MEMBER("Type", _type);
		MEMBER("Control", _control);

		private _default_event = [];
		{
			_default_event pushBack [_x, false];
		} forEach ALL_EVENTS;
		MEMBER("EventArray", _default_event);
		
		private _noColor = [0,0,0,0];
		MEMBER("BGColor", _noColor);
		MEMBER("FGColor", _noColor);
		MEMBER("TooltipColorBox", _noColor);
		MEMBER("TooltipColorShade", _noColor);
		MEMBER("TooltipColorText", _noColor);
		MEMBER("TextColor", _noColor);
		MEMBER("Tooltip", "");
	};

	PUBLIC FUNCTION("","isEnabled") {
		ctrlEnabled MEMBER("Control", nil);
	};

	PUBLIC FUNCTION("bool","ctrlEnable") {
		MEMBER("Control", nil) ctrlEnable _this;
	};

	PUBLIC FUNCTION("","colorizeYourSelf") {
		_self spawn {
			disableSerialization;
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

	PUBLIC FUNCTION("string","setAction") {	MEMBER("Control", nil) buttonSetAction _this; };
	PUBLIC FUNCTION("scalar","setID") {	MEMBER("ID", _this); };
	PUBLIC FUNCTION("string","setText") { MEMBER("Control", nil) ctrlSetText _this;	};
	PUBLIC FUNCTION("string","setTooltip") { MEMBER("Tooltip", _this); MEMBER("Control", nil) ctrlSetTooltip _this;	};
	PUBLIC FUNCTION("array","setTooltipColorBox") { MEMBER("TooltipColorBox", _this); MEMBER("Control", nil) ctrlSetTooltipColorBox _this; };
	PUBLIC FUNCTION("array","setTooltipColorShade") { MEMBER("TooltipColorShade", _this); MEMBER("Control", nil) ctrlSetTooltipColorShade _this; };
	PUBLIC FUNCTION("array","setTooltipColorText") { MEMBER("TooltipColorText", _this); MEMBER("Control", nil) ctrlSetTooltipColorText _this; };
	PUBLIC FUNCTION("array","setBGColor") { MEMBER("BGColor", _this); MEMBER("Control", nil) ctrlSetBackgroundColor _this; };
	PUBLIC FUNCTION("array","setFGColor") { MEMBER("FGColor", _this); MEMBER("Control", nil) ctrlSetForegroundColor _this; };	
	PUBLIC FUNCTION("array","setTextColor") { MEMBER("TextColor", _this); MEMBER("Control", nil) ctrlSetTextColor _this; };	

	PUBLIC FUNCTION("","getText") {	ctrlText MEMBER("Control", nil); };
	PUBLIC FUNCTION("","getPos") { ctrlPosition MEMBER("Control", nil); };
	PUBLIC FUNCTION("","getAction") { buttonAction MEMBER("Control", nil); };
	PUBLIC FUNCTION("","getID") FUNC_GETVAR("ID");
	PUBLIC FUNCTION("","getTypeName") {_class;};
	PUBLIC FUNCTION("","getDisplay") FUNC_GETVAR("Display");
	PUBLIC FUNCTION("","getParentLayer") FUNC_GETVAR("ParentLayer");
	PUBLIC FUNCTION("","getControl") FUNC_GETVAR("Control");
	PUBLIC FUNCTION("","typeName") { ctrlType MEMBER("Control", nil); };
ENDCLASS;