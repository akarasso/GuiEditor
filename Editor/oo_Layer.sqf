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

CLASS_EXTENDS("oo_Layer", "oo_Control")

	PUBLIC VARIABLE("array", "Childs");	
	PUBLIC VARIABLE("array", "BoundBox");

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
		private _layerParent = "getLayer" call _parent;
		if (isNil {_layerParent}) then {
			_layerParent = controlNull;
		};
		MEMBER("GuiObject", _guiObject);
		MEMBER("Display", _display);
		MEMBER("Parent", _parent);
		MEMBER("ParentLayer", _layerParent);
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
		private _a = [1,0,0,1];
		MEMBER("colorBoundBox", _a);
		_a = [controlNull, controlNull,	controlNull, controlNull];
		MEMBER("BoundBox", _a);
		MEMBER("Childs", []);
	};	

	PUBLIC FUNCTION("","createMainLayer") {
		disableSerialization;
		private _data = MEMBER("Data", nil);
		private _layer = MEMBER("Display", nil) ctrlCreate["OOP_SubLayer", (_data select INDEX_ID)];
		MEMBER("Control", _layer);
		private _p = [safezoneX, safezoneY, safezoneW, safezoneH];
		MEMBER("setPos", _p);
		_layer;
	};

	PUBLIC FUNCTION("array","isUsedID") {
		if !(_this isEqualTypeParams [0, []]) exitWith {
			hint "send bad args to isUsedID";
		};
		private _id = _this select 0;
		private _ownid = MEMBER("Data", nil) select INDEX_ID;
		private _exclude = _this select 1;
		private _return = false;
		private _childs = MEMBER("Childs", nil);

		if !(_self in _exclude) then {
			if (_ownid isEqualTo _id) then {
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
			} forEach _childs;
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
		_childs = MEMBER("Childs", nil);
		for "_i" from (count _childs)-1 to 0 step -1 do {
			_item = _childs select _i;
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
		["moveUpInChilds", _self] call MEMBER("Parent", nil);
	};

	PUBLIC FUNCTION("","moveDownControl") {
		["moveDownInChilds", _self] call MEMBER("Parent", nil);
	};

	PUBLIC FUNCTION("","getPositionInChilds") {
		("getChilds" call MEMBER("Parent", nil)) find _self;
	};

	PUBLIC FUNCTION("code","moveUpInChilds") {
		private _childs = MEMBER("Childs", nil);
		private _pos = _childs find _this;
		private _tmp = _childs select (_pos - 1);
		_childs set [_pos - 1, _childs select _pos];
		_childs set [_pos, _tmp];
	};

	PUBLIC FUNCTION("code","moveDownInChilds") {
		private _childs = MEMBER("Childs", nil);
		private _pos = _childs find _this;
		private _tmp = _childs select (_pos + 1);
		_childs set [_pos + 1, _childs select _pos];
		_childs set [_pos, _tmp];
	};

	PUBLIC FUNCTION("bool","layerEnable") {
		if (!_this) then {
			MEMBER("Control",nil) ctrlRemoveAllEventHandlers "MouseMoving";
			MEMBER("Control",nil) ctrlRemoveAllEventHandlers "MouseButtonDown";
			MEMBER("Control",nil) ctrlRemoveAllEventHandlers "MouseButtonUp";
			MEMBER("Control",nil) ctrlRemoveAllEventHandlers "MouseButtonDblClick";
		}else{
			private _GuiEditorEvent = "getGuiHelperEvent" call MEMBER("GuiObject", nil);
			MEMBER("Control",nil) ctrlAddEventHandler ["MouseMoving", format['["MouseMoving", _this] spawn %1', _GuiEditorEvent] ];
			MEMBER("Control",nil) ctrlAddEventHandler ["MouseButtonDown", format['["MouseButtonDown", _this] spawn %1', _GuiEditorEvent] ];
			MEMBER("Control",nil) ctrlAddEventHandler ["MouseButtonUp", format['["MouseButtonUp", _this] spawn %1', _GuiEditorEvent] ];
			MEMBER("Control",nil) ctrlAddEventHandler ["MouseButtonDblClick", format['["MouseButtonDblClick", _this] spawn %1', _GuiEditorEvent] ];
		};
	};

	PUBLIC FUNCTION("","refreshAllCtrl") {
		private _childs = MEMBER("Childs", nil);
		{
			"refreshControl" call _x;
		} forEach _childs;
		"RefreshAllBoundBox" call MEMBER("GuiObject", nil);
	};

	PUBLIC FUNCTION("","refreshControl") {
		disableSerialization;
		ctrlDelete MEMBER("Control", nil);
		private _layerParent = "getLayer" call MEMBER("Parent", nil);
		private _data = MEMBER("Data", nil);
		private _newCtrl = MEMBER("Display", nil) ctrlCreate[_data select INDEX_CONTROL_CLASS, _data select INDEX_ID, _layerParent];
		_newCtrl ctrlSetPosition (_data select INDEX_POSITION);
		_newCtrl ctrlCommit 0;
		MEMBER("Layer", _newCtrl);
		{
			"refreshControl" call _x;
		} forEach MEMBER("Childs", nil);
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
		MEMBER("RefreshPosBoundBox", nil);
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
			_this set[4, false];
			MEMBER("MakeBoundBox", _activeColor);
			diag_log format["Childs:%1", MEMBER("Childs", nil)];
			{
				["RefreshBoundBox", _this] call _x;
			} forEach MEMBER("Childs", nil);
		};
		if (_isParent) then {
			diag_log format["Parent box:%1",_self];
			MEMBER("MakeBoundBox", _parentColor);
		};
		if (!_isParent) then {
			diag_log format["Parent box:%1",_self];
			MEMBER("MakeBoundBox", _childColor);
		};
		{
			["RefreshBoundBox", _this] call _x;
		} forEach MEMBER("Childs", nil);
	};

	PUBLIC FUNCTION("","RefreshPosBoundBox") {
		private _posLayer = ctrlPosition MEMBER("Control", nil);
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


	PUBLIC FUNCTION("array","MakeBoundBox") {
		disableSerialization;
		private _thicknessX = 0.001 * safezoneH;
		private _thicknessY = _thicknessX * 4/3;
		private _layer = MEMBER("Control", nil);
		private _display = MEMBER("Display", nil);
		private _boundBox = MEMBER("BoundBox", nil);
		private _posLayer = ctrlPosition _layer;
		{
			ctrlDelete _x;
		} forEach _boundBox;
		//Top
		_boundBox set [0, _display ctrlCreate ["RscText", -40, _layer] ];
		(_boundBox select 0) ctrlSetPosition [
			0,
			0, 
			(_posLayer select 2), 
			2*_thicknessY
		];
		(_boundBox select 0) ctrlSetBackgroundColor _this;
		(_boundBox select 0) ctrlCommit 0;

		//Left
		_boundBox set [1, _display ctrlCreate ["RscText", -41, _layer] ];
		(_boundBox select 1) ctrlSetPosition [
			0,
			0, 
			2*_thicknessX, 
			_posLayer select 3
		];
		(_boundBox select 1) ctrlSetBackgroundColor _this;
		(_boundBox select 1) ctrlCommit 0;

		//Bottom
		_boundBox set [2, _display ctrlCreate ["RscText", -42, _layer] ];
		(_boundBox select 2) ctrlSetPosition [
			0,
			(_posLayer select 3) - (2*_thicknessY), 
			(_posLayer select 2), 
			2*_thicknessY
		];
		(_boundBox select 2) ctrlSetBackgroundColor _this;
		(_boundBox select 2) ctrlCommit 0;

		//Right
		_boundBox set [3, _display ctrlCreate ["RscText", -43, _layer] ];
		(_boundBox select 3) ctrlSetPosition [
			(_posLayer select 2) - (2*_thicknessX),
			0, 
			(2*_thicknessX), 
			_posLayer select 3
		];
		(_boundBox select 3) ctrlSetBackgroundColor _this;
		(_boundBox select 3) ctrlCommit 0;
	};

	PUBLIC FUNCTION("code","exportHPP") {
		private _data = MEMBER("Data", nil);
		private _id = _data select INDEX_ID;
		["pushLine", format["class Layer_%1 : OOP_SubLayer {", _id]] call _this;
		["modTab", +1] call _this;
		private _pos = MEMBER("getPos", nil);
		["pushLine", format["idc = %1;", _id]] call _this;
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
		private _data = MEMBER("Data", nil);
		private _name = _data select INDEX_NAME;
		private _idString = str (_data select INDEX_ID);
		private _hasFunction = false;
		private _actionEvent = "";
		private _f = "";
		private _foundFnc = false;
		private _helperGui = MEMBER("HelperGui", nil);
		private _name = "";
		private _actionEvent = "";
		private _hasFunction = false;
		private _f = "";
		private _foundFnc = false;

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
		{
			["exportOOP", _this] call _x;
		} forEach MEMBER("Childs", nil);
	};

	PUBLIC FUNCTION("array","fillDisplayTree") {
		disableSerialization;
		private _data = MEMBER("Data", nil);
		private _tree = _this select 0;
		private _path = _this select 1;
		private _guiObject = MEMBER("GuiObject", nil);
		private _mainView = "getView" call _guiObject; 
		private _childs = MEMBER("Childs", nil);
		private _index = _tree tvAdd [_path, format["Layer_#%1",(_data select INDEX_ID)]];
		private _nPath = _path + [_index];
		if (_self isEqualTo _mainView) then {
			_tree tvSetText  [_nPath, format["MainLayer_#%1",(_data select INDEX_ID)]];
		};		
		_tree tvSetData [_nPath, format["%1",_self]];
		if !(_self isEqualTo ("getView" call _guiObject)) then {
			if (MEMBER("Visible", nil)) then {
				_tree tvSetPictureRight [_nPath, "coreimg\visible.jpg"];
			}else{
				_tree tvSetPictureRight [_nPath, "coreimg\invisible.jpg"];
			};	
		};
		for "_i" from count _childs-1 to 0 step -1 do {
			_child = _childs select _i;
			["fillDisplayTree", [_tree, _nPath]] call _child;
		};
	};

	PUBLIC FUNCTION("code","deleteCtrl") {
		private _childs = MEMBER("Childs", nil);
		private _index = _childs find _this;
		_childs deleteAt _index;
		"fillDisplayTree" call MEMBER("GuiObject", nil);
	};

	PUBLIC FUNCTION("","getParentCountChilds") {
		"getCountChilds" call MEMBER("Parent", nil);
	};

	PUBLIC FUNCTION("","getCountChilds") {
		count MEMBER("Childs", nil);
	};

	PUBLIC FUNCTION("","ctrlDeleteChilds") {
		private _child;
		{	
			_child = "getControl" call _x;
			ctrlDelete _child;
		} forEach MEMBER("Childs", nil);
	};

	PUBLIC FUNCTION("","getChilds") FUNC_GETVAR("Childs");
	PUBLIC FUNCTION("","getLayer") FUNC_GETVAR("Layer");
	
	PUBLIC FUNCTION("array","setColorBoundBox") { MEMBER("colorBoundBox", _this); };

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