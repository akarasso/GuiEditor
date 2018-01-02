#include "..\oop.h"

CLASS("oo_Layer")
	PUBLIC UI_VARIABLE("display", "Display");
	PUBLIC UI_VARIABLE("control", "Layer");
	PUBLIC VARIABLE("code", "GuiObject");
	PUBLIC VARIABLE("code", "ParentLayer");
	PUBLIC VARIABLE("array", "Childs");	
	PUBLIC VARIABLE("scalar", "ID");
	PUBLIC VARIABLE("bool", "DefaultStatus");
	PUBLIC VARIABLE("string", "Type");
	PUBLIC VARIABLE("array", "BoundBox");
	PUBLIC VARIABLE("bool", "Visible");
	PUBLIC VARIABLE("string", "Name");

	PUBLIC FUNCTION("code","constructor") { 
		MEMBER("GuiObject", _this);
		MEMBER("Visible", true);
		MEMBER("Display", displayNull);
		MEMBER("ParentLayer", {});
		MEMBER("Name", "");
		MEMBER("Layer", controlNull);
		MEMBER("Childs", []);
		private _a = [1,0,0,1];
		MEMBER("colorBoundBox", _a);
		private _a = [controlNull, controlNull,	controlNull, controlNull];
		MEMBER("BoundBox", _a);
		MEMBER("ID", -1);
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

	PUBLIC FUNCTION("array","setLayer") {
		disableSerialization;
		private _mainDisplay = param[0, displayNull, [displayNull]];
		private _parentLayer = param[1, {}, [{}]];
		private _layer = param[2, controlNull, [controlNull]];
		MEMBER("Display", _mainDisplay);
		MEMBER("ParentLayer", _parentLayer);
		MEMBER("Layer", _layer);
	};

	PUBLIC FUNCTION("array","createLayer") {
		private _mainDisplay = param[0, displayNull, [displayNull]];
		private _parentLayer = param[1, {}, [{}]];
		private _layer = controlNull;
		disableSerialization;
		MEMBER("Display", _mainDisplay);
		if (_parentLayer isEqualTo {}) then {
			_layer = MEMBER("Display", nil) ctrlCreate["OOP_SubLayer", MEMBER("ID", nil)];
		}else{
			private _ctrlGroup = "getLayer" call _parentLayer;
			_layer = MEMBER("Display", nil) ctrlCreate["OOP_SubLayer", MEMBER("ID", nil), _ctrlGroup];
		};
		MEMBER("ParentLayer", _parentLayer);
		MEMBER("Layer", _layer);
		MEMBER("MakeBoundBox", nil);
		_layer;
	};

	PUBLIC FUNCTION("","refreshLayer") {
		disableSerialization;
		if (MEMBER("ParentLayer", nil) isEqualTo {}) then {
			ctrlDelete MEMBER("Layer", nil);
			private _layer = MEMBER("Display", nil) ctrlCreate["OOP_SubLayer", MEMBER("ID", nil)];
		}else{
			private _ctrlGroup = "getLayer" call MEMBER("ParentLayer", nil);
			_layer = MEMBER("Display", nil) ctrlCreate["OOP_SubLayer", MEMBER("ID", nil), _ctrlGroup];
		};
		MEMBER("refreshAllCtrl",nil);
	};

	PUBLIC FUNCTION("scalar","setNewID") {
		if (MEMBER("ID", nil) isEqualTo _this) exitWith {};		
		MEMBER("ID", _this); 
		MEMBER("resfreshLayer", nil);
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
	};

	PUBLIC FUNCTION("","getPos") {
		ctrlPosition MEMBER("Layer", nil);
	};

	PUBLIC FUNCTION("array","setPos") {
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
				if (("getTypeName" call _x)isEqualTo "oo_Layer") then {
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
		} forEach MEMBER("BoundBox", nil);;
	};

	PUBLIC FUNCTION("array","MakeBoundBox") {
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
		["pushLine", format["y = %1 * pixelGrid * pixelH;", (((_pos select 1))/(pixelGrid * pixelW))]] call _this;
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

	PUBLIC FUNCTION("","getChilds") FUNC_GETVAR("Childs");
	PUBLIC FUNCTION("","getGuiObject") FUNC_GETVAR("GuiObject");
	PUBLIC FUNCTION("","getLayer") FUNC_GETVAR("Layer");
	PUBLIC FUNCTION("","getParentLayer") FUNC_GETVAR("ParentLayer");
	PUBLIC FUNCTION("","getDisplay") FUNC_GETVAR("Display");
	PUBLIC FUNCTION("","getTypeName") {	_class; };
	PUBLIC FUNCTION("","getID") FUNC_GETVAR("ID");
	PUBLIC FUNCTION("","getVisible") { MEMBER("Visible", nil); };
	PUBLIC FUNCTION("","getName") { MEMBER("Name", nil); };
	
	PUBLIC FUNCTION("array","setColorBoundBox") { MEMBER("colorBoundBox", _this); };
	PUBLIC FUNCTION("bool","setVisible") { MEMBER("Visible", _this); };
	PUBLIC FUNCTION("string","setName") { MEMBER("Name", _this); };
ENDCLASS;