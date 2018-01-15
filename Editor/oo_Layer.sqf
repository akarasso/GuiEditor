#include "..\oop.h"

#define PARENT_BOUNDBOX [1,0,0,1]
#define FULLSCREEN_BOUNDBOX [1,1,0,1]
#define CHILD_BOUNDBOX [0,0,1,1]
#define ACTIVE_BOUNDBOX [0,1,0,1]

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

CLASS_EXTENDS("oo_Layer", "oo_Control")
	PUBLIC VARIABLE("array", "BoundBox");
	PUBLIC VARIABLE("array", "Childs");
	PUBLIC VARIABLE("bool", "FullScreen");

	PUBLIC FUNCTION("array","constructor") {
		SUPER("constructor",_this);
		MEMBER("BoundBox", []);
		MEMBER("Childs", []);
		MEMBER("FullScreen", false);
		MEMBER("boundboxEnable", true);
		MEMBER("setColorBoundbox", CHILD_BOUNDBOX);
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
			_child = _childs select _i;
			_data = "getData" call _child;
			_pos = "getPos" call _child;
			_ctrlXEnd = (_pos select 0) + (_pos select 2);
			_ctrlYEnd = (_pos select 1) + (_pos select 3);
			if (_posX >= (_pos select 0) && { _posX <= _ctrlXEnd } && { _posY >= (_pos select 1) } && { _posY <= _ctrlYEnd} && _data select INDEX_VISIBLE) exitWith {
				_return = _child;
			};
		};
		_return;
	};

	PUBLIC FUNCTION("code","pushChild") {	
		MEMBER("Childs", nil) pushBack _this;
	};

	PUBLIC FUNCTION("","switchFullScreen") {
		if (MEMBER("FullScreen", nil)) then {
			MEMBER("FullScreen", false);
			"refreshDisplay" call GuiObject;
			MEMBER("refreshEVH", nil);
		}else{
			private _view = "getView" call GuiObject;
			["ctrlShowAllCtrl", false] call _view;
			MEMBER("renderInlayer", _view);
			MEMBER("refreshEVH", nil);
			MEMBER("FullScreen", true);
			private _control = MEMBER("Control", nil);
			_control ctrlSetPosition [safezoneW*0.1, safezoneH*0.1, safezoneW*0.8, safezoneH*0.8];
			_control ctrlCommit 0;
			MEMBER("boundboxEnable", true);
			MEMBER("refreshPosBoundbox",nil);
			private _a = [FULLSCREEN_BOUNDBOX, [1,1,1,1]];
			MEMBER("setColorBoundbox", _a);
		};
	};

	/*
	*	Render functions
	*/
	PUBLIC FUNCTION("code","renderInlayer") {
		disableSerialization;
		MEMBER("ctrlDelete", nil);
		private _layerParent = "getControl" call _this;
		if (_layerParent isEqualTo controlNull) exitWith {};
		private _data = MEMBER("Data", nil);
		private _newCtrl = ("getDisplay" call GuiObject) ctrlCreate[_data select INDEX_CONTROL_CLASS, MEMBER("ID", nil), _layerParent];
		MEMBER("Control", _newCtrl);
		{
			"refreshControl" call _x;
		} forEach MEMBER("Childs", nil);
	};

	PUBLIC FUNCTION("","refreshControl") {
		disableSerialization;
		ctrlDelete MEMBER("Control", nil);
		MEMBER("Control", controlNull);
		private _data = MEMBER("Data", nil);
		private _layerParent = "getControl" call MEMBER("Parent", nil);
		if (_layerParent isEqualTo controlNull) exitWith {};		
		private _newCtrl = ("getDisplay" call GuiObject) ctrlCreate[_data select INDEX_CONTROL_CLASS, MEMBER("ID", nil), _layerParent];
		{
			if (_x isEqualType "") then {
				(_data select INDEX_POSITION) set [_forEachIndex, call compile _x];
			};
		} forEach (_data select INDEX_POSITION);
		_newCtrl ctrlSetPosition (_data select INDEX_POSITION);
		_newCtrl ctrlCommit 0;
		if!(_data select INDEX_VISIBLE) then {
			_newCtrl ctrlShow false;
		};
		MEMBER("Control", _newCtrl);
		{
			"refreshControl" call _x;
		} forEach MEMBER("Childs", nil);
	};	

	PUBLIC FUNCTION("array","setPos") {
		SUPER("setPos", _this);
		MEMBER("refreshPosBoundBox", nil);
	};

	/*
	*	Boundbox functions
	*/
	PUBLIC FUNCTION("bool","boundboxEnable") {
		disableSerialization;
		if (_this) exitWith {
			private _display = ("getDisplay" call GuiObject);
			private _control = MEMBER("Control", nil);
			if (_control isEqualTo controlNull) exitWith {diag_log "can't create bound box";};
			private _boundBox = MEMBER("BoundBox", nil);
			if !(_boundBox isEqualType []) then {
				_boundBox = [];
			};
			if (count _boundBox > 0) then {
				{
					ctrlDelete _x;
				} forEach _boundBox;
				_boundBox = [];
			};
			private _controlCon = _display ctrlCreate ["RscText", 666666, _control];
			_boundBox pushBack (_display ctrlCreate ["RscText", -40, _control]);
			_boundBox pushBack (_display ctrlCreate ["RscText", -41, _control]);
			_boundBox pushBack (_display ctrlCreate ["RscText", -42, _control]);
			_boundBox pushBack (_display ctrlCreate ["RscText", -43, _control]);
			if (MEMBER("FullScreen", nil)) then {
				_boundBox pushBack (_display ctrlCreate ["RscText", -44, _control]);
				_boundBox pushBack (_display ctrlCreate ["RscText", -45, _control]);
			};
			MEMBER("BoundBox", _boundBox);
			MEMBER("refreshPosBoundbox", nil);
		};
		if (!_this) then {
			private _boundBox = MEMBER("BoundBox", nil);
			{
				ctrlDelete _x;
			} forEach _boundBox;
			MEMBER("BoundBox", []);
		};
	};

	PUBLIC FUNCTION("array","RefreshBoundBox") {
		private _active = param[0, {}, [{}]];
		private _isParent = param[1, false, [false]];
		private _boundbox = MEMBER("Boundbox", nil);
		if !(MEMBER("couldActiveBoundbox", nil)) exitWith {};
		MEMBER("boundboxEnable", true);
		MEMBER("refreshPosBoundbox", nil);
		
		if (MEMBER("this", nil) isEqualTo _active) then {
			_this set[1, false];
			MEMBER("setColorBoundbox", ACTIVE_BOUNDBOX);
		}else{
			if (_isParent) then {
				MEMBER("setColorBoundbox", PARENT_BOUNDBOX);
			};
			if (!_isParent) then {
				MEMBER("setColorBoundbox", CHILD_BOUNDBOX);
			};
		};

		{
			["RefreshBoundBox", _this] call _x;
		} forEach MEMBER("Childs", nil);
	};

	PUBLIC FUNCTION("string","setColorBoundbox") {
		switch (toLower _this) do { 
			case "child" : {MEMBER("setColorBoundbox", CHILD_BOUNDBOX);}; 
			case "active" : {MEMBER("setColorBoundbox", ACTIVE_BOUNDBOX);}; 
			case "parent" : {MEMBER("setColorBoundbox", PARENT_BOUNDBOX);}; 
			default {}; 
		};
	};

	PUBLIC FUNCTION("array","setColorBoundbox") {
		if (count _this isEqualTo 4) then {
			{
				_x ctrlSetBackgroundColor _this;
			} forEach MEMBER("Boundbox", nil);
		};
		if (count _this isEqualTo 2) then {
			{
				if (_forEachIndex < 4) then {
					_x ctrlSetBackgroundColor (_this select 0);
				}else{
					_x ctrlSetBackgroundColor (_this select 1);
				};
			} forEach MEMBER("Boundbox", nil);
		};
	};

	PUBLIC FUNCTION("","refreshPosBoundbox") {
		private _boundBox = MEMBER("Boundbox", nil);
		if (count _boundBox > 0) exitWith {
			private _thicknessX = 0.001 * safezoneH;
			private _thicknessY = _thicknessX * 4/3;
			private _control = MEMBER("Control", nil);
			private _posControl = ctrlPosition _control;
			//Top
			(_boundBox select 0) ctrlSetPosition [
				0,
				0, 
				(_posControl select 2), 
				2*_thicknessY
			];
			//Left
			(_boundBox select 1) ctrlSetPosition [
				0,
				0, 
				2*_thicknessX, 
				_posControl select 3
			];
			//Bottom
			(_boundBox select 2) ctrlSetPosition [
				0,
				(_posControl select 3) - (2*_thicknessY), 
				(_posControl select 2), 
				2*_thicknessY
			];
			//Right
			(_boundBox select 3) ctrlSetPosition [
				(_posControl select 2) - (2*_thicknessX),
				0, 
				(2*_thicknessX), 
				_posControl select 3
			];
			if (MEMBER("FullScreen", nil)) then {
				private _data = MEMBER("Data", nil);
				private _dataPos = _data select INDEX_POSITION;
				(_boundBox select 4) ctrlSetPosition [
					0,
					(_dataPos select 3) - (2*_thicknessY), 
					(_dataPos select 2), 
					2*_thicknessY
				];
				(_boundBox select 5) ctrlSetPosition [
					(_dataPos select 2) - (2*_thicknessX),
					0, 
					(2*_thicknessX), 
					_dataPos select 3
				];
			};
			{
				_x ctrlCommit 0;
			} forEach _boundBox;
		};
		diag_log "Unable to find any boundbox";
	};


	/*
	*	Colorize
	*/
	PUBLIC FUNCTION("","colorizeControl") {
		{
			"colorize" call _x;
		} forEach MEMBER("Childs", nil);
	};

	/**
	*	Export
	**/
	PUBLIC FUNCTION("code","exportHPP") {
		private _data = MEMBER("Data", nil);
		private _id = MEMBER("ID", nil);
		private _name = _data select INDEX_NAME;
		private _controlClass = _data select INDEX_CONTROL_CLASS;
		private _idString = str (_id);
		private _evhArray = (_data select INDEX_EVH);
		private _display = ("getDisplay" call GuiObject);
		private _displayName = "getDisplayName" call GuiObject;
		private _actionEvent = "";
		if ((_data select INDEX_NAME) isEqualTo "") then {
			_name = _controlClass + "_" + (str _id);
		};
		["pushLine", format["class %1_%2 : %3 {", _name, _id, _controlClass]] call _this;
		["modTab", +1] call _this;
		private _pos = MEMBER("getPos", nil);
		["pushLine", format["idc = %1;", _id]] call _this;
		["pushLine", format["x = %1 * pixelGrid * pixelW;", (((_pos select 0))/(pixelGrid * pixelW))]] call _this;
		["pushLine", format["y = %1 * pixelGrid * pixelH;", (((_pos select 1))/(pixelGrid * pixelH))]] call _this;
		["pushLine", format["w = %1 * pixelGrid * pixelW;", (((_pos select 2))/(pixelGrid * pixelW))]] call _this;
		["pushLine", format["h = %1 * pixelGrid * pixelH;", (((_pos select 3))/(pixelGrid * pixelH))]] call _this;
		{
			if !(_x isEqualTo "Init") then {
				_actionEvent = "['static', ['%1', _this]] call oo_%2;";
				_actionEvent = ["stringFormat", [_actionEvent ,[(_x+"_"+_name), _displayName]]] call HelperGui;
				_actionEvent = format['%1 = "%2";', _x, _actionEvent];
				["pushLine", _actionEvent] call _this;
			};
		} forEach _evhArray;

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
		private _name = MEMBER("getFormatedName", nil);;
		private _id = MEMBER("ID", nil);
		private _string = "";

		if (!((_data select INDEX_NAME) isEqualTo "") || (count (_data select INDEX_EVH)) > 0 || !(_data select INDEX_VISIBLE) || "Init" in (_data select INDEX_EVH)) then {
			["addVariable", ["ui", "control", _name]] call _this;
			_string = "MEMBER(" + format['"%1", _display displayCtrl %2);', _name, _id];
			["addConstructorString", [1,_string]] call _this;
		};		
		{
			if!(_x isEqualTo "Init") then {
				_string = "MEMBER(" + format['"Init_%1", nil);', _name];
				["addConstructorString", [10,_string]] call _this;
				["addFunction", [_x, _name, "any", []]] call _this;
			}else{
				["addFunction", [_x, _name, "array", []]] call _this;
			};
		} forEach (_data select INDEX_EVH);

		if!(_data select INDEX_VISIBLE) then {
			_string = "MEMBER(" +format['"%1", nil) ctrlShow false;',_name];
			["addConstructorString", [9,_string]] call _this;
		};
		
		{
			["exportOOP", _this] call _x;
		} forEach MEMBER("Childs", nil);
	};

	PUBLIC FUNCTION("code","exportMetaControl") {
		private _data = MEMBER("Data", nil);
		private _name = _data select INDEX_NAME;
		private _id = str (MEMBER("ID", nil));
		if (_name isEqualTo "") then {
			_name = ((_data select INDEX_CONTROL_CLASS) + "_" + (_id));
		};
		
		["setMetaControl", _name] call _this;

		private _pos = MEMBER("getPos", nil);
		private _string = format["private _arr = [%1*pixelGrid*pixelW, %2*pixelGrid*pixelH, %3*pixelGrid*pixelW, %4*pixelGrid*pixelH];", (((_pos select 0))/(pixelGrid * pixelW)), (((_pos select 1))/(pixelGrid * pixelH)), (((_pos select 2))/(pixelGrid * pixelW)), (((_pos select 3))/(pixelGrid * pixelH))];
		["addSuperStatic", _string]call _this;
		private _string = "MEMBER(" + '"setPos", _arr);';
		["addSuperStatic", _string]call _this;
		{
			if (("getTypeName" call _x) isEqualTo "oo_Control") then {
				["exportMetaControl", [_this, MEMBER("ID", nil)]] call _x;
			};
		} forEach MEMBER("Childs", nil);
	};

	/*
	*	Arbre
	*/
	PUBLIC FUNCTION("array","addInTree") {
		private _childs = MEMBER("Childs", nil);
		private _tree = _this select 0;
		private _nPath = SUPER("addInTree", _this);
		for "_i" from count _childs-1 to 0 step -1 do {
			_child = _childs select _i;
			["addInTree", [_tree, _nPath]] call _child;
		};
		if (MEMBER("this", nil) isEqualTo ("getWorkground" call GuiObject)) then {
			_tree tvSetPicture  [_nPath, "#(rgb,8,8,3)color(0,1,0,1)"];
			_tree tvExpand _nPath;
			_nPath deleteAt ((count _nPath) -1);
			while {!(_nPath isEqualTo [])} do {
				_tree tvExpand _nPath;
				_tree tvSetPicture  [_nPath, "#(rgb,8,8,3)color(1,0,0,1)"];
				_nPath deleteAt ((count _nPath) -1);
			};
		};
	};

	PUBLIC FUNCTION("code","deleteChild") {
		private _childs = MEMBER("Childs", nil);
		private _index = _childs find _this;
		_childs deleteAt _index;
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

	PUBLIC FUNCTION("array","serializeChilds") {
		private _a = [];
		{
			["serializeControl", _a] call _x;
		} forEach MEMBER("Childs", nil);
		_a;
	};

	PUBLIC FUNCTION("array","serializeControl") {
		private _a = [];
		for "_i" from 0 to count MEMBER("Childs", nil)-1 do {
			_child = MEMBER("Childs", nil) select _i;
			["serializeControl", _a] call _child;
		};
		private _serialyze = MEMBER("getSerializeData", nil); 
		_serialyze pushBack _a;
		_this pushBack _serialyze;
		_this;
	};

	PUBLIC FUNCTION("","getChilds") FUNC_GETVAR("Childs");
	PUBLIC FUNCTION("","getTypeName") { _class; };
	
	PUBLIC FUNCTION("bool","setEnable") {
		{
			["setEnable", _this] call _x;
		} forEach MEMBER("Childs", nil);
	};

	PUBLIC FUNCTION("code","moveDown") {
		private _childs = MEMBER("Childs", nil);
		private _indexChild = _childs find _this;
		if (_indexChild > 0) exitWith {
			private _tmp = _childs select (_indexChild - 1);
			_childs set [_indexChild - 1, _childs select _indexChild];
			_childs set [_indexChild, _tmp];
			MEMBER("Childs", _childs);
			true;
		};
		false;
	};

	PUBLIC FUNCTION("code","moveUp") {
		private _childs = MEMBER("Childs", nil);
		private _indexChild = _childs find _this;
		if (_indexChild < count _childs -1) exitWith {
			private _tmp = _childs select (_indexChild + 1);
			_childs set [_indexChild + 1, _childs select _indexChild];
			_childs set [_indexChild, _tmp];
			MEMBER("Childs", _childs);
			true;
		};
		false;
	};

	PUBLIC FUNCTION("","ctrlDelete") {
		ctrlDelete MEMBER("Control", nil);
		MEMBER("BoundBox", []);
	};

	/*
	*	EVH Function
	*/
	PUBLIC FUNCTION("","refreshEVH") {
		MEMBER("workGroundEnable", false);
		MEMBER("workGroundEnable", true);
	};

	PUBLIC FUNCTION("bool","workGroundEnable") {
		disableSerialization;
		private _control = MEMBER("Control", nil);
		if (!_this) then {
			_control ctrlRemoveAllEventHandlers "MouseMoving";
			_control ctrlRemoveAllEventHandlers "MouseButtonDown";
			_control ctrlRemoveAllEventHandlers "MouseButtonUp";
			_control ctrlRemoveAllEventHandlers "MouseButtonDblClick";
			MEMBER("setAllChildColorBoundbox", PARENT_BOUNDBOX);
		}else{
			private _GuiEditorEvent = "getGuiHelperEvent" call GuiObject;
			_control ctrlAddEventHandler ["MouseMoving", format['["MouseMoving", _this] call %1', _GuiEditorEvent] ];
			_control ctrlAddEventHandler ["MouseButtonDown", format['["MouseButtonDown", _this] call %1', _GuiEditorEvent] ];
			_control ctrlAddEventHandler ["MouseButtonUp", format['["MouseButtonUp", _this] call %1', _GuiEditorEvent] ];
			_control ctrlAddEventHandler ["MouseButtonDblClick", format['["MouseButtonDblClick", _this] call %1', _GuiEditorEvent] ];
			{
				["setAllChildColorBoundbox", CHILD_BOUNDBOX] call _x;
			} forEach MEMBER("Childs", nil);
			MEMBER("setColorBoundbox", ACTIVE_BOUNDBOX);
		};
	};

	PUBLIC FUNCTION("array","setAllChildColorBoundbox") {
		MEMBER("setColorBoundbox", _this);
		{
			["setAllChildColorBoundbox", _this] call _x;
		} forEach MEMBER("Childs", nil);
	};

	/**
	*	Interface
	**/
	PUBLIC FUNCTION("","couldBeWorkground") {
		true;
	};
	PUBLIC FUNCTION("","couldActiveBoundbox") {
		true;
	};

	/*
	*	Main View Function
	*/
	PUBLIC FUNCTION("bool","ctrlShowAllCtrl") {
		{
			["ctrlShow", _this] call _x;
		} forEach MEMBER("Childs", nil);
	};

	PUBLIC FUNCTION("","deconstructor") { 
		{
			if ("getTypeName" call _x isEqualTo "oo_Control") then {
				["delete", _x] call oo_Control;
			};
			if ("getTypeName" call _x isEqualTo "oo_Layer") then {
				["delete", _x] call oo_Layer;
			};
		} forEach MEMBER("Childs", nil);
		ctrlDelete MEMBER("Control", nil);
		DELETE_VARIABLE("Parent");
		DELETE_VARIABLE("Data");
		DELETE_UI_VARIABLE("Control");
		DELETE_UI_VARIABLE("Layer");
		DELETE_VARIABLE("BoundBox");
		DELETE_VARIABLE("Childs");
	};
ENDCLASS;