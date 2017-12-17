#include "..\oop.h"

CLASS("oo_Layer")
	PUBLIC UI_VARIABLE("code", "GuiObject");

	PUBLIC UI_VARIABLE("display", "Display");

	PUBLIC UI_VARIABLE("code", "ParentLayer");
	PUBLIC UI_VARIABLE("control", "Layer");

	PUBLIC UI_VARIABLE("array", "Childs");	

	PUBLIC UI_VARIABLE("scalar", "ID");
	PUBLIC UI_VARIABLE("bool", "DefaultStatus");
	PUBLIC UI_VARIABLE("string", "Type");

	PUBLIC UI_VARIABLE("array", "BoundBox");	

	PUBLIC FUNCTION("code","constructor") { 
		MEMBER("GuiObject", _this);
		MEMBER("Display", displayNull);
		MEMBER("ParentLayer", {});
		MEMBER("Layer", controlNull);
		MEMBER("Childs", []);
		private _a = [1,0,0,1];
		MEMBER("colorBoundBox", _a);
		private _a = [controlNull, controlNull,	controlNull, controlNull];
		MEMBER("BoundBox", _a);
		MEMBER("ID", -1);
	};	

	PUBLIC FUNCTION("array","setLayer") {
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
			_layer = MEMBER("Display", nil) ctrlCreate["OOP_SubLayer", 2];
		}else{
			private _ctrlGroup = "getLayer" call _parentLayer;
			_layer = MEMBER("Display", nil) ctrlCreate["OOP_SubLayer", 2, _ctrlGroup];
		};
		MEMBER("ParentLayer", _parentLayer);
		MEMBER("Layer", _layer);
		MEMBER("MakeBoundBox", nil);
		_layer;
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
			if (_posX >= (_pos select 0) && _posX <= _ctrlXEnd && _posY >= (_pos select 1) && _posY <= _ctrlYEnd) exitWith {
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
			MEMBER("Layer",nil) ctrlAddEventHandler ["MouseMoving", format['["MouseMoving", _this] call %1', MEMBER("GuiObject", nil)] ];
			MEMBER("Layer",nil) ctrlAddEventHandler ["MouseButtonDown", format['["MouseButtonDown", _this] call %1', MEMBER("GuiObject", nil)] ];
			MEMBER("Layer",nil) ctrlAddEventHandler ["MouseButtonUp", format['["MouseButtonUp", _this] call %1', MEMBER("GuiObject", nil)] ];
			MEMBER("Layer",nil) ctrlAddEventHandler ["MouseButtonDblClick", format['["MouseButtonDblClick", _this] call %1', MEMBER("GuiObject", nil)] ];
		};
	};

	PUBLIC FUNCTION("","getPos") {
		ctrlPosition MEMBER("Layer", nil);
	};

	PUBLIC FUNCTION("array","setPos") {
		MEMBER("Layer", nil) ctrlSetPosition _this;
		MEMBER("Layer", nil) ctrlCommit 0;
		MEMBER("RefreshPosBoundBox", nil);
	};

	PUBLIC FUNCTION("","colorizeYourSelf") {
		_self spawn {
			disableSerialization;
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
		{
			"colorizeYourSelf" call _x;
		} forEach MEMBER("Childs", nil);
	};

	PUBLIC FUNCTION("","colorize") {
		{
			"colorizeYourSelf" call _x;
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

	PUBLIC FUNCTION("","getLayer") FUNC_GETVAR("Layer");
	PUBLIC FUNCTION("","getParentLayer") FUNC_GETVAR("ParentLayer");
	PUBLIC FUNCTION("","getDisplay") FUNC_GETVAR("Display");
	PUBLIC FUNCTION("","getTypeName") {	_class; };
	PUBLIC FUNCTION("","getID") FUNC_GETVAR("ID");

	PUBLIC FUNCTION("array","setColorBoundBox") { MEMBER("colorBoundBox", _this); };
ENDCLASS;