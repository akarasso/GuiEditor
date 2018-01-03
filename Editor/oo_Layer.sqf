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

CLASS("oo_Layer")
	PUBLIC STATIC_VARIABLE("code", "HelperGui");

	PUBLIC UI_VARIABLE("display", "Display");
	PUBLIC UI_VARIABLE("control", "Layer");
	PUBLIC VARIABLE("code", "GuiObject");
	PUBLIC VARIABLE("string", "Type");
	
	PUBLIC VARIABLE("code", "ParentLayer");
	PUBLIC VARIABLE("array", "Childs");	
	PUBLIC VARIABLE("scalar", "ID");
	PUBLIC VARIABLE("bool", "DefaultStatus");
	PUBLIC VARIABLE("string", "Type");
	PUBLIC VARIABLE("array", "BoundBox");
	PUBLIC VARIABLE("bool", "Visible");
	PUBLIC VARIABLE("string", "Name");
	PUBLIC VARIABLE("array", "EventArray");
	PUBLIC VARIABLE("array", "Position");

	PUBLIC FUNCTION("code","constructor") { 
		if (isNil {MEMBER("HelperGui", nil)}) then {
			private _g = "new" call oo_HelperGui;
			MEMBER("HelperGui", _g);
		};
		disableSerialization;
		MEMBER("GuiObject", _this);
		private _d = "getDisplay" call _this;
		MEMBER("Display", _d);
		MEMBER("Layer", controlNull);
		private _a = [1,0,0,1];
		MEMBER("colorBoundBox", _a);
		_a = [controlNull, controlNull,	controlNull, controlNull];
		MEMBER("BoundBox", _a);
		MEMBER("ID", -1);
		MEMBER("Visible", true);
		MEMBER("Childs", []);
	};

	PUBLIC FUNCTION("array","constructor") {
		if (isNil {MEMBER("HelperGui", nil)}) then {
			private _g = "new" call oo_HelperGui;
			MEMBER("HelperGui", _g);
		};
		disableSerialization; 
		private _guiObject = param[0, {}, [{}]];
		private _parent = param[1, {}, [{}]];
		private _control = param[2, controlNull, [controlNull]];
		private _type = param[3, "NoType", [""]];
		MEMBER("GuiObject", _guiObject);
		MEMBER("ParentLayer", _parent);
		MEMBER("Layer", _control);
		MEMBER("Type", _type);
		MEMBER("Display", "getDisplay" call _guiObject);
		MEMBER("Name", "");
		
		private _default_event = [];
		{
			_default_event pushBack [_x, false];
		} forEach ALL_EVENTS;
		MEMBER("EventArray", _default_event);
		private _a = [1,0,0,1];
		MEMBER("colorBoundBox", _a);
		_a = [controlNull, controlNull,	controlNull, controlNull];
		MEMBER("BoundBox", _a);
		MEMBER("ID", -1);
		MEMBER("Visible", true);
		MEMBER("Childs", []);
	};	

	PUBLIC FUNCTION("","createMainLayer") {
		disableSerialization;
		private _layer = MEMBER("Display", nil) ctrlCreate["OOP_SubLayer", MEMBER("ID", nil)];
		MEMBER("Layer", _layer);
		private _p = [safezoneX, safezoneY, safezoneW, safezoneH];
		MEMBER("setPos", _p);
		_layer;
	};

	PUBLIC FUNCTION("scalar","setNewID") {
		if (MEMBER("ID", nil) isEqualTo _this) exitWith {};		
		MEMBER("ID", _this); 
		MEMBER("refreshControl", nil);
	};

	PUBLIC FUNCTION("scalar","setID") {
		MEMBER("ID", _this);
	};

	PUBLIC FUNCTION("array","isUsedID") {
		if !(_this isEqualTypeParams [0, []]) exitWith {
			hint "send bad args to isUsedID";
		};
		private _id = _this select 0;
		private _exclude = _this select 1;
		private _return = false;

		if !(_self in _exclude) then {
			if (MEMBER("ID", nil) isEqualTo _id) then {
				_return = true;
			};
		};

		if !(_return) then {
			{
				if ("getTypeName" call _x isEqualTo "oo_Layer") then {
					_return = ["isUsedID", _this] call _x;
				};
				if !(_x in _exclude) then {
					if ("getTypeName" call _x isEqualTo "oo_Control") then {
						if (("getID" call _x) isEqualTo _id) then {
							_return = true;
						};
					};					
				};
			} forEach MEMBER("Childs", nil);
		};		
		_return;
	};

	PUBLIC FUNCTION("array","findFirstAtPos") {
		private _return = {};
		private "_pos";
		private "_ctrlXEnd";
		private "_ctrlYEnd";
		private _posX = param[0, -1, [0]];
		private _posY = param[1, -1, [0]];

		for "_i" from (count MEMBER("Childs", nil))-1 to 0 step -1 do {
			_item = MEMBER("Childs", nil) select _i;
			_pos = "getPos" call _item;
			_ctrlXEnd = (_pos select 0) + (_pos select 2);
			_ctrlYEnd = (_pos select 1) + (_pos select 3);
			if (_posX >= (_pos select 0) && { _posX <= _ctrlXEnd } && { _posY >= (_pos select 1) } && { _posY <= _ctrlYEnd} ) exitWith {
				_return = _item;
			};
		};
		_return;
	};	

	PUBLIC FUNCTION("code","pushChild") {	
		MEMBER("Childs", nil) pushBack _this;
	};

	PUBLIC FUNCTION("","moveUpControl") {
		["moveUpInChilds", _self] call MEMBER("ParentLayer", nil);
	};

	PUBLIC FUNCTION("","moveDownControl") {
		["moveDownInChilds", _self] call MEMBER("ParentLayer", nil);
	};

	PUBLIC FUNCTION("","getPositionInChilds") {
		("getChilds" call MEMBER("ParentLayer", nil)) find _self;
	};

	PUBLIC FUNCTION("code","moveUpInChilds") {
		private _pos = MEMBER("Childs", nil) find _this;
		private _tmp = MEMBER("Childs", nil) select (_pos - 1);
		MEMBER("Childs", nil) set [_pos - 1, MEMBER("Childs", nil) select _pos];
		MEMBER("Childs", nil) set [_pos, _tmp];
	};

	PUBLIC FUNCTION("code","moveDownInChilds") {
		private _pos = MEMBER("Childs", nil) find _this;
		private _tmp = MEMBER("Childs", nil) select (_pos + 1);
		MEMBER("Childs", nil) set [_pos + 1, MEMBER("Childs", nil) select _pos];
		MEMBER("Childs", nil) set [_pos, _tmp];
	};

	PUBLIC FUNCTION("bool","layerEnable") {
		if (!_this) then {
			MEMBER("Layer",nil) ctrlRemoveAllEventHandlers "MouseMoving";
			MEMBER("Layer",nil) ctrlRemoveAllEventHandlers "MouseButtonDown";
			MEMBER("Layer",nil) ctrlRemoveAllEventHandlers "MouseButtonUp";
			MEMBER("Layer",nil) ctrlRemoveAllEventHandlers "MouseButtonDblClick";
		}else{
			private _GuiEditorEvent = "getGuiHelperEvent" call MEMBER("GuiObject", nil);
			MEMBER("Layer",nil) ctrlAddEventHandler ["MouseMoving", format['["MouseMoving", _this] call %1', _GuiEditorEvent] ];
			MEMBER("Layer",nil) ctrlAddEventHandler ["MouseButtonDown", format['["MouseButtonDown", _this] call %1', _GuiEditorEvent] ];
			MEMBER("Layer",nil) ctrlAddEventHandler ["MouseButtonUp", format['["MouseButtonUp", _this] call %1', _GuiEditorEvent] ];
			MEMBER("Layer",nil) ctrlAddEventHandler ["MouseButtonDblClick", format['["MouseButtonDblClick", _this] call %1', _GuiEditorEvent] ];
		};
	};

	PUBLIC FUNCTION("","refreshAllCtrl") {
		{
			"refreshControl" call _x;
		} forEach MEMBER("Childs", nil);
		"RefreshAllBoundBox" call MEMBER("GuiObject", nil);
	};

	PUBLIC FUNCTION("","refreshControl") {
		disableSerialization;
		ctrlDelete MEMBER("Layer", nil);
		private _layer = "getLayer" call MEMBER("ParentLayer", nil);
		diag_log format["Parent:%1", MEMBER("ParentLayer", nil)];
		diag_log format["Type:%1, ID:%2, layer:%3", MEMBER("Type", nil), MEMBER("ID", nil), _layer];
		private _newCtrl = MEMBER("Display", nil) ctrlCreate[MEMBER("Type", nil), MEMBER("ID", nil), _layer];

		MEMBER("Layer", _newCtrl);
		MEMBER("Layer", nil) ctrlSetPosition MEMBER("Position", nil);
		MEMBER("Layer", nil) ctrlCommit 0;

		{
			"refreshControl" call _x;
		} forEach MEMBER("Childs", nil);
	};

	PUBLIC FUNCTION("","getPos") {
		ctrlPosition MEMBER("Layer", nil);
	};

	PUBLIC FUNCTION("array","setPos") {
		MEMBER("Position", _this);
		MEMBER("Layer", nil) ctrlSetPosition _this;
		MEMBER("Layer", nil) ctrlCommit 0;
		MEMBER("RefreshPosBoundBox", nil);
	};

	PUBLIC FUNCTION("","colorizeControl") {
		_self spawn {
			disableSerialization;
			if !("getVisible" call _this) exitWith {};
			private _guiObject = "getGuiObject" call _this;
			private _mainView = "getView" call _guiObject;
			if (_this isEqualTo _mainView) exitWith {};
			private _parent = "getParentLayer" call _this;
			private _ctrlGroup = "getLayer" call _parent;
			
			private _highlightControl = ("getDisplay" call _this) ctrlCreate["RscBackgroundGUI", -1, _ctrlGroup];
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

	PUBLIC FUNCTION("","colorizeYourSelf") {
		MEMBER("colorizeControl", nil);
		MEMBER("colorizeChilds", nil);
	};

	PUBLIC FUNCTION("","colorizeChilds") {
		{
			"colorizeControl" call _x;
		} forEach MEMBER("Childs", nil);
	};	

	PUBLIC FUNCTION("array","RefreshBoundBox") {
		private _active = param[0, {}, [{}]];
		private _parentColor = param[1, [], [[]]];
		private _activeColor = param[2, [], [[]]];
		private _childColor = param[3, [], [[]]];
		private _isParent = param[4, false, [false]];

		if (_self isEqualTo _active) exitWith {
			MEMBER("RemoveBoundBox", nil);
			MEMBER("MakeBoundBox", _activeColor);
			_this set[4, false];
			{
				if (("getTypeName" call _x) isEqualTo "oo_Layer") then {
					["RefreshBoundBox", _this] call _x;
				};
			} forEach MEMBER("Childs", nil);
		};

		if !(_self isEqualTo _active) then {
			if (_isParent) then {
				MEMBER("RemoveBoundBox", nil);
				MEMBER("MakeBoundBox", _parentColor);
			}else{
				MEMBER("RemoveBoundBox", nil);
				MEMBER("MakeBoundBox", _childColor);
			};
			{
				if (("getTypeName" call _x) isEqualTo "oo_Layer") then {
					["RefreshBoundBox", _this] call _x;
				};
			} forEach MEMBER("Childs", nil);
		};
	};

	PUBLIC FUNCTION("","RefreshPosBoundBox") {
		private _posLayer = ctrlPosition MEMBER("Layer", nil);
		private _thicknessX = 0.001 * safezoneH;
		private _thicknessY = _thicknessX * 4/3;
		(MEMBER("BoundBox", nil) select 0) ctrlSetPosition [
			0,
			0, 
			(_posLayer select 2), 
			2*_thicknessY
		];
		(MEMBER("BoundBox", nil) select 0) ctrlCommit 0;
		(MEMBER("BoundBox", nil) select 1) ctrlSetPosition [
			0,
			0, 
			2*_thicknessX, 
			_posLayer select 3
		];
		(MEMBER("BoundBox", nil) select 1) ctrlCommit 0;
		(MEMBER("BoundBox", nil) select 2) ctrlSetPosition [
			0,
			(_posLayer select 3) - (2*_thicknessY), 
			(_posLayer select 2), 
			2*_thicknessY
		];
		(MEMBER("BoundBox", nil) select 2) ctrlCommit 0;
		(MEMBER("BoundBox", nil) select 3) ctrlSetPosition [
			(_posLayer select 2) - (2*_thicknessX),
			0, 
			(2*_thicknessX), 
			_posLayer select 3
		];
		(MEMBER("BoundBox", nil) select 3) ctrlCommit 0;
	};

	PUBLIC FUNCTION("","RemoveBoundBox") {
		{
			ctrlDelete _x;
		} forEach MEMBER("BoundBox", nil);
	};

	PUBLIC FUNCTION("array","MakeBoundBox") {
		diag_log "Make";
		disableSerialization;
		private _thicknessX = 0.001 * safezoneH;
		private _thicknessY = _thicknessX * 4/3;
		private _layer = MEMBER("Layer", nil);
		private _posLayer = ctrlPosition _layer;

		//Top
		MEMBER("BoundBox", nil) set [0, MEMBER("Display", nil) ctrlCreate ["RscText", -40, _layer] ];
		(MEMBER("BoundBox", nil) select 0) ctrlSetPosition [
			0,
			0, 
			(_posLayer select 2), 
			2*_thicknessY
		];
		(MEMBER("BoundBox", nil) select 0) ctrlSetBackgroundColor _this;
		(MEMBER("BoundBox", nil) select 0) ctrlCommit 0;

		//Left
		MEMBER("BoundBox", nil) set [1, MEMBER("Display", nil) ctrlCreate ["RscText", -41, _layer] ];
		(MEMBER("BoundBox", nil) select 1) ctrlSetPosition [
			0,
			0, 
			2*_thicknessX, 
			_posLayer select 3
		];
		(MEMBER("BoundBox", nil) select 1) ctrlSetBackgroundColor _this;
		(MEMBER("BoundBox", nil) select 1) ctrlCommit 0;

		//Bottom
		MEMBER("BoundBox", nil) set [2, MEMBER("Display", nil) ctrlCreate ["RscText", -42, _layer] ];
		(MEMBER("BoundBox", nil) select 2) ctrlSetPosition [
			0,
			(_posLayer select 3) - (2*_thicknessY), 
			(_posLayer select 2), 
			2*_thicknessY
		];
		(MEMBER("BoundBox", nil) select 2) ctrlSetBackgroundColor _this;
		(MEMBER("BoundBox", nil) select 2) ctrlCommit 0;

		//Right
		MEMBER("BoundBox", nil) set [3, MEMBER("Display", nil) ctrlCreate ["RscText", -43, _layer] ];
		(MEMBER("BoundBox", nil) select 3) ctrlSetPosition [
			(_posLayer select 2) - (2*_thicknessX),
			0, 
			(2*_thicknessX), 
			_posLayer select 3
		];
		(MEMBER("BoundBox", nil) select 3) ctrlSetBackgroundColor _this;
		(MEMBER("BoundBox", nil) select 3) ctrlCommit 0;
	};

	PUBLIC FUNCTION("code","exportHPP") {
		["pushLine", format["class Layer_%1 : OOP_SubLayer {", MEMBER("ID", nil)]] call _this;
		["modTab", +1] call _this;
		private _pos = MEMBER("getPos", nil);
		["pushLine", format["idc = %1;", MEMBER("ID", nil)]] call _this;
		["pushLine", format["x = %1 * pixelGrid * pixelW;", (((_pos select 0))/(pixelGrid * pixelW))]] call _this;
		["pushLine", format["y = %1 * pixelGrid * pixelH;", (((_pos select 1))/(pixelGrid * pixelH))]] call _this;
		["pushLine", format["w = %1 * pixelGrid * pixelW;", (((_pos select 2))/(pixelGrid * pixelW))]] call _this;
		["pushLine", format["h = %1 * pixelGrid * pixelH;", (((_pos select 3))/(pixelGrid * pixelH))]] call _this;

		["pushLine", "class controls{"] call _this;
		["modTab", +1] call _this;
		{
			["exportHPP", _this] call _x;
		} forEach MEMBER("Childs", nil);
		["modTab", -1] call _this;
		["pushLine", "};"] call _this;
		["modTab", -1] call _this;
		["pushLine", "};"] call _this;
	};

	PUBLIC FUNCTION("code","exportOOP") {
		private _name = "";
		private _actionEvent = "";
		private _hasFunction = false;
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
		{
			["exportOOP", _this] call _x;
		} forEach MEMBER("Childs", nil);
	};

	PUBLIC FUNCTION("array","fillDisplayTree") {
		disableSerialization;
		private _tree = _this select 0;
		private _path = _this select 1;
		
		private _mainView = "getView" call MEMBER("GuiObject", nil); 

		private _index = _tree tvAdd [_path, format["Layer_#%1",MEMBER("ID", nil)]];
		private _nPath = _path + [_index];

		if (_self isEqualTo _mainView) then {
			_tree tvSetText  [_nPath, format["MainLayer_#%1",MEMBER("ID", nil)]];
		};		
		_tree tvSetData [_nPath, format["%1",_self]];
		if !(_self isEqualTo ("getView" call MEMBER("GuiObject", nil))) then {
			if (MEMBER("Visible", nil)) then {
				_tree tvSetPictureRight [_nPath, "coreimg\visible.jpg"];
			}else{
				_tree tvSetPictureRight [_nPath, "coreimg\invisible.jpg"];
			};	
		};
		{
			["fillDisplayTree", [_tree, _nPath]] call _x;
		} forEach MEMBER("Childs", nil);
	};

	PUBLIC FUNCTION("scalar","deleteCtrl") {
		{
			if ("getID" call _x isEqualTo _this) then {
				MEMBER("Childs", nil) deleteAt _forEachIndex;
			};
		} forEach MEMBER("Childs", nil);
		"fillDisplayTree" call MEMBER("GuiObject", nil);
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

	PUBLIC FUNCTION("","getParentCountChilds") {
		"getCountChilds" call MEMBER("ParentLayer", nil);
	};

	PUBLIC FUNCTION("","getCountChilds") {
		count MEMBER("Childs", nil);
	};

	PUBLIC FUNCTION("","ctrlDeleteChilds") {
		{
			"ctrlDelete" call _x;
		} forEach MEMBER("Childs", nil);
	};

	PUBLIC FUNCTION("","ctrlDelete") {
		ctrlDelete MEMBER("Layer", nil); 
	};

	PUBLIC FUNCTION("control","setControl") {
		MEMBER("Layer", _this);
	};

	PUBLIC FUNCTION("","getChilds") FUNC_GETVAR("Childs");
	PUBLIC FUNCTION("","getGuiObject") FUNC_GETVAR("GuiObject");
	PUBLIC FUNCTION("","getLayer") FUNC_GETVAR("Layer");
	PUBLIC FUNCTION("","getParentLayer") FUNC_GETVAR("ParentLayer");
	PUBLIC FUNCTION("","getDisplay") FUNC_GETVAR("Display");
	PUBLIC FUNCTION("","getTypeName") {	_class; };
	PUBLIC FUNCTION("","getID") FUNC_GETVAR("ID");
	PUBLIC FUNCTION("","getVisible") { MEMBER("Visible", nil); };
	PUBLIC FUNCTION("","getName") { MEMBER("Name", nil); };
	PUBLIC FUNCTION("","getType") { MEMBER("Type", nil); };
	
	PUBLIC FUNCTION("array","setColorBoundBox") { MEMBER("colorBoundBox", _this); };
	PUBLIC FUNCTION("bool","setVisible") { MEMBER("Visible", _this); MEMBER("Layer", nil) ctrlShow _this; };
	PUBLIC FUNCTION("string","setName") { MEMBER("Name", _this); };


	PUBLIC FUNCTION("","deconstructor") { 
		{
			if ("getTypeName" call _x isEqualTo "oo_Control") then {
				["delete", _x] call oo_Control;
			};
			if ("getTypeName" call _x isEqualTo "oo_Layer") then {
				["delete", _x] call oo_Layer;
			};
		} forEach MEMBER("Childs", nil);
		["deleteCtrl", MEMBER("ID", nil)] call MEMBER("ParentLayer", nil);
		ctrlDelete MEMBER("Layer", nil);
		DELETE_UI_VARIABLE("Display");
		DELETE_UI_VARIABLE("Layer");
		DELETE_VARIABLE("GuiObject");
		DELETE_VARIABLE("ParentLayer");
		DELETE_VARIABLE("Childs");
		DELETE_VARIABLE("ID");
		DELETE_VARIABLE("DefaultStatus");
		DELETE_VARIABLE("Type");
		DELETE_VARIABLE("BoundBox");
	};
ENDCLASS;