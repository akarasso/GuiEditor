#include "..\oop.h"
#include "..\dik_macro.hpp"

CLASS("oo_GuiEditorEvent")
	PUBLIC UI_VARIABLE("control", "TreeDialog");
	PUBLIC VARIABLE("code","GuiObject");
	PUBLIC VARIABLE("code","GridObject");
	PUBLIC VARIABLE("bool", "LBPressing");
	PUBLIC VARIABLE("bool", "AltPressing");
	PUBLIC VARIABLE("bool", "CtrlPressing");
	PUBLIC VARIABLE("array", "MousePos");
	PUBLIC VARIABLE("array", "MouseClick");
	PUBLIC VARIABLE("array", "DeltaPosClick");
	PUBLIC VARIABLE("code", "copyControl");
	PUBLIC VARIABLE("string", "cornerGrab");

	PUBLIC FUNCTION("code","constructor") {
		disableSerialization; 
		MEMBER("GuiObject", _this);
		private _gridObject = "getGridObject" call _this;
		MEMBER("GridObject", _gridObject);
		MEMBER("TreeDialog", controlNull);
		MEMBER("cornerGrab", "top|left");
		MEMBER("LBPressing", false);
		MEMBER("AltPressing", false);
		MEMBER("CtrlPressing", false);
		MEMBER("MousePos", []);
		MEMBER("MouseClick", []);
		MEMBER("DeltaPosClick", []);
		("getDisplay" call _this) displayAddEventHandler["KeyDown", format["['KeyDown', _this] call %1;", _code] ];
	};

	PUBLIC FUNCTION("","fillDisplayTree") {
		disableSerialization;
		if (MEMBER("TreeDialog", nil) isEqualTo controlNull) exitWith {};
		tvClear MEMBER("TreeDialog", nil);
		["fillDisplayTree", [MEMBER("TreeDialog", nil), []]] call ("getView" call MEMBER("GuiObject", nil));
		tvExpandAll MEMBER("TreeDialog", nil);
	};

	PUBLIC FUNCTION("","showTreeDialog") {
		disableSerialization;
		if !(MEMBER("TreeDialog", nil) isEqualTo controlNull) exitWith {
			SPAWN_MEMBER("TreeExit", nil);
		};
		private _tree = ("getDisplay" call MEMBER("GuiObject", nil)) ctrlCreate["OOP_Tree",-2, "getControl" call ("getView" call MEMBER("GuiObject", nil))];
		MEMBER("TreeDialog", _tree);
		_tree ctrlSetPosition [0,0, safezoneW/5, safezoneH];
		_tree ctrlCommit 0;
		MEMBER("fillDisplayTree", nil);
		_tree ctrlAddEventHandler ["TreeSelChanged", format["['TreeSelChanged', _this] spawn %1", _self]];
		_tree ctrlAddEventHandler ["TreeDblClick", format["['TreeDblClick', _this] spawn %1", _self]];
	};

	PUBLIC FUNCTION("","TreeExit") {
		disableSerialization;
		if (MEMBER("TreeDialog", nil) isEqualTo controlNull) exitWith {};
		private _tree = MEMBER("TreeDialog", nil);
		MEMBER("TreeDialog", controlNull);
		private _helperStyle = ["new", "getDisplay" call MEMBER("GuiObject", nil)] call oo_HelperStyle;
		["close", [_tree, 0.5, "left"]] call _helperStyle;
		sleep 0.5;
		ctrlDelete _tree;
	};

	PUBLIC FUNCTION("array","TreeDblClick") {
		disableSerialization;
		private _item = call compile ((_this select 0) tvData (_this select 1));
		if ("getTypeName" call _item isEqualTo "oo_Layer") exitWith {
			["setActiveLayer", _item] call MEMBER("GuiObject", nil);
		};
		["setActiveLayer", ("getParentLayer" call _item)] call MEMBER("GuiObject", nil);
		["setSelCtrl", _item] call MEMBER("GuiObject", nil);
		"cfgCtrlDialog" call MEMBER("GuiObject", nil);
	};

	PUBLIC FUNCTION("array","TreeSelChanged") {
		disableSerialization;
		private _item = call compile ((_this select 0) tvData (_this select 1));
		if (isNil {_item}) exitWith {};
		"colorizeControl" spawn _item;
	};

	/*
	*	Fonction de récupation de l'évent handler Keydown cf arma...
	*/
	PUBLIC FUNCTION("array","KeyDown") {
		private _DikCode = param[1, -1, [-1]];
		MEMBER("CtrlPressing", _this select 3);
		MEMBER("AltPressing", _this select 4);
		private _arr = [0,0,0,0];
		private _noReturn = false;

		private _workground = "getWorkground" call MEMBER("GuiObject", nil);
		private _view = "getView" call MEMBER("GuiObject", nil);
		private _selCtrl = "getSelCtrl" call MEMBER("GuiObject", nil);

		private _size = "getSize" call MEMBER("GridObject", nil);
		private _sizeX = safezoneW/(_size select 0);
		private _sizeY = safezoneH/(_size select 1);
		switch (_DikCode) do { 
			case DIK_F1:{
				//Implement help
			};
			case DIK_F2 : {
				if !(_workground isEqualTo _view) then {
					private _parent = "getParent" call _workground;
					["setActiveLayer", _parent] call MEMBER("GuiObject", nil);
				};
			};
			case DIK_F3:{
				"openGeneralCfg" call MEMBER("GuiObject", nil);
			};
			case DIK_F4:{
				"exportHPP" call MEMBER("GuiObject", nil);
			};
			case DIK_F5:{
				"exportOOP" call MEMBER("GuiObject", nil);
			};

			case DIK_I:{
				"importFromClipboard" call MEMBER("GuiObject", nil);
			};
			case DIK_T:{
				MEMBER("showTreeDialog", nil);
			};
			case DIK_SPACE:{
				"colorizeChilds" call _workground;
			};
			case DIK_NEXT:{
				if !(MEMBER("TreeDialog", nil) isEqualTo controlNull) then {
					hint "next";
					private _path = tvCurSel MEMBER("TreeDialog", nil);
					private _item = call compile (MEMBER("TreeDialog", nil) tvData _path);
					if (_item isEqualTo ("getView" call MEMBER("GuiObject", nil))) exitWith {};
						private _posChilds = "getPositionInChilds" call _item;
						if (_posChilds > 0) then {	
							"moveUpControl" call _item;
							MEMBER("fillDisplayTree", nil);
							_path set [(count _path) - 1, (_path select ((count _path) -1)) + 1];
							MEMBER("TreeDialog", nil) tvSetCurSel _path;
							"refreshDisplay" call MEMBER("GuiObject", nil);
						};
					_noReturn = true;
				};
			};
			case DIK_PRIOR:{
				if !(MEMBER("TreeDialog", nil) isEqualTo controlNull) then {
					private _path = tvCurSel MEMBER("TreeDialog", nil);
					private _item = call compile (MEMBER("TreeDialog", nil) tvData _path);
					if (_item isEqualTo ("getView" call MEMBER("GuiObject", nil))) exitWith {};
						private _posChilds = "getPositionInChilds" call _item;
						private _countChilds = "getParentCountChilds" call _item;
						if (_posChilds < _countChilds - 1) then {
							"moveDownControl" call _item;
							MEMBER("fillDisplayTree", nil);
							_path set [(count _path) - 1, (_path select ((count _path) -1)) - 1];
							MEMBER("TreeDialog", nil) tvSetCurSel _path;
							"refreshDisplay" call MEMBER("GuiObject", nil);
						};
					_noReturn = true;
				};
			};
			case DIK_H: {
				if !(MEMBER("TreeDialog", nil) isEqualTo controlNull) then {
					private _path = tvCurSel MEMBER("TreeDialog", nil);
					private _item = call compile (MEMBER("TreeDialog", nil) tvData _path);
					if (_item isEqualTo ("getView" call MEMBER("GuiObject", nil))) exitWith {};
					if ("getTypeName" call _item isEqualTo "oo_Control") then {
						private _control = "getControl" call _item;
						if (ctrlShown _control) then {
							["setVisible", false] call _item;
						}else{
							["setVisible", true] call _item;
						};
						MEMBER("fillDisplayTree", nil);
						// MEMBER("TreeDialog", nil) tvSetCurSel _path;
					};
					if ("getTypeName" call _item isEqualTo "oo_Layer") then {
						private _control = "getLayer" call _item;
						if (ctrlShown _control) then {
							["setVisible", false] call _item;
						}else{
							["setVisible", true] call _item;
						};
						MEMBER("fillDisplayTree", nil);
						// MEMBER("TreeDialog", nil) tvSetCurSel _path;
					};
				};
			};
			case DIK_DELETE : {
				private _res = ["findFirstAtPos", MEMBER("MousePos", nil)] call _workground;
				if (_res isEqualTo {}) exitWith {
					private _ctrlSel = "getSelCtrl" call MEMBER("GuiObject", nil);
					if !(_ctrlSel isEqualTo {}) then {
						["delete", _ctrlSel] call oo_Control;
						["deleteCtrl", _ctrlSel] call _workground;
						MEMBER("fillDisplayTree", nil);
					};
				};
				if ("getTypeName" call _res isEqualTo "oo_Control") then {
					["delete", _res] call oo_Control;
					["deleteCtrl", _res] call _workground;
				};
				if !(_res isEqualTo ("getView" call MEMBER("GuiObject", nil))) then {
					if ("getTypeName" call _res isEqualTo "oo_Layer") then {
						["delete", _res] call oo_Layer;
						["deleteCtrl", _res] call _workground;
					};
				};				
				MEMBER("fillDisplayTree", nil);			
			};
			case DIK_C:{
				if (MEMBER("CtrlPressing", nil)) exitWith {
					private _res = ["findFirstAtPos", MEMBER("MousePos", nil)] call _workground;
					if (_res isEqualTo {}) exitWith {
						MEMBER("copyControl", {});
					};
					MEMBER("copyControl", _res);
				};
				if (_selCtrl isEqualTo {}) then {
					private _res = ["findFirstAtPos", MEMBER("MousePos", nil)] call _workground;
					if !(_res isEqualTo {}) then {
						["setSelCtrl", _res] call MEMBER("GuiObject", nil);
					};
				};
				"centerH" call MEMBER("GuiObject", nil);
			};
			case DIK_V:{
				if (MEMBER("CtrlPressing", nil)) exitWith {
				 	if !(MEMBER("copyControl", nil) isEqualTo {}) then {
				 		if ("getTypeName" call MEMBER("copyControl", nil) isEqualTo "oo_Control") exitWith {
					 		private _pasteCtrl = ["ctrlCreate", "getType" call MEMBER("copyControl", nil)] call MEMBER("GuiObject", nil);
					 		private _a = [MEMBER("copyControl", nil), _pasteCtrl];
					 		MEMBER("copyControl", _a);
					 		["setPos", MEMBER("MousePos", nil)] call _pasteCtrl;
				 		};
				 		if ("getTypeName" call MEMBER("copyControl", nil) isEqualTo "oo_Layer") exitWith {
				 			private _newLayer = ["ctrlCreate", "getType" call MEMBER("copyControl", nil)] call MEMBER("GuiObject", nil);
				 			private _a = [MEMBER("copyControl", nil), _newLayer];
				 			MEMBER("copyChilds", _a);
				 			["setPos", MEMBER("MousePos", nil)] call _newLayer;
				 		};
				 	};
				};
				if (_selCtrl isEqualTo {}) then {
					private _res = ["findFirstAtPos", MEMBER("MousePos", nil)] call _workground;
					if !(_res isEqualTo {}) then {
						["setSelCtrl", _res] call MEMBER("GuiObject", nil);
					};
				};
				"centerV" call MEMBER("GuiObject", nil);
			};
			case DIK_DOWNARROW:{
				if (MEMBER("AltPressing", nil)) exitWith {
					if (MEMBER("CtrlPressing", nil)) then {
						_arr = [0,0,0,_sizeY/2];
					}else{
						_arr = [0,0,0,_sizeY];
					};
					["relativeMove", _arr] call MEMBER("GuiObject", nil);
				};
				if (MEMBER("CtrlPressing", nil)) then {
					_arr = [0,_sizeY/2,0,0];
				}else{
					_arr = [0,_sizeY,0,0];
				};
				["relativeMove", _arr] call MEMBER("GuiObject", nil);
			};
			case DIK_UPARROW:{
				if (MEMBER("AltPressing", nil)) exitWith {
					if (MEMBER("CtrlPressing", nil)) then {
						_arr = [0,0,0,-_sizeY/2];
					}else{
						_arr = [0,0,0,-_sizeY];
					};
					["relativeMove", _arr] call MEMBER("GuiObject", nil);
				};
				if (MEMBER("CtrlPressing", nil)) then {
					_arr = [0,-_sizeY,0,0];
				}else{
					_arr = [0,-_sizeY,0,0];
				};
				["relativeMove", _arr] call MEMBER("GuiObject", nil);
			};
			case DIK_RIGHTARROW:{
				if (MEMBER("AltPressing", nil)) exitWith {
					if (MEMBER("CtrlPressing", nil)) then {
						_arr = [0,0,_sizeX/2,0];
					}else{
						_arr = [0,0,_sizeX,0];
					};
					["relativeMove", _arr] call MEMBER("GuiObject", nil);
				};
				if (MEMBER("CtrlPressing", nil)) then {
					_arr = [_sizeX/2,0,0,0];
				}else{
					_arr = [_sizeX,0,0,0];
				};
				["relativeMove", _arr] call MEMBER("GuiObject", nil);
			};
			case DIK_LEFTARROW:{
				if (MEMBER("AltPressing", nil)) exitWith {
					if (MEMBER("CtrlPressing", nil)) then {
						_arr = [0,0,-_sizeX/2,0];
					}else{
						_arr = [0,0,-_sizeX,0];
					};
					_arr = [0,0,-_sizeX,0];
					["relativeMove", _arr] call MEMBER("GuiObject", nil);
				};
				if (MEMBER("CtrlPressing", nil)) then {
					_arr = [-_sizeX/2,0,0,0];
				}else{
					_arr = [-_sizeX,0,0,0];
				};
				["relativeMove", _arr] call MEMBER("GuiObject", nil);
			};
			case DIK_ESCAPE : {
				closeDialog 0;	
			};			
			default {}; 
		};
		_noReturn;
	};

	PUBLIC FUNCTION("array","copyChilds") {
		private _layerOrigin = _this select 0;
		private _childs = "getChilds" call _layerOrigin;
		private _layerDestination = _this select 1;
		private _guiObject = MEMBER("GuiObject", nil);
		private "_newChild", "_a";
		["setData", "getDuplicateData" call _layerOrigin] call _layerDestination;

		["setActiveLayer", _layerDestination] call _guiObject;
		{
			if ("getTypeName" call _x isEqualTo "oo_Control") then {
				_newChild = ["ctrlCreate", "getType" call _x] call _guiObject;
				_a = [_x, _newChild];
				MEMBER("copyControl", _a);
				["setPos", "getPos" call _x] call _newChild;
			};
			if ("getTypeName" call _x isEqualTo "oo_Layer") then {
				_newChild = ["ctrlCreate", "getType" call _x] call _guiObject;
				_a = [_x, _newChild];
				MEMBER("copyChilds", _a);
				["setPos", "getPos" call _x] call _newChild;
			};
		} forEach _childs;
		["setActiveLayer", "getParent" call _layerDestination] call _guiObject
	};

	PUBLIC FUNCTION("array","copyControl") {
		private _ctrlOrigin = _this select 0;
		private _ctrlDest = _this select 1;
		["setData", "getDuplicateData" call _ctrlOrigin] call _ctrlDest;
	 	_ctrlDest;
	};

	/*
	*	Fonction gérant la positions des éléments dans le gui
	*	@input:array input from EventHandler MouseMoving see: https://community.bistudio.com/wiki/User_Interface_Event_Handlers
	*/
	PUBLIC FUNCTION("array","MouseMoving") {
		private _pos = "getPosWorkground" call MEMBER("GuiObject", nil);
		private _relativePos = [
			(_this select 1) - (_pos select 0), 
			(_this select 2) - (_pos select 1)
		];
		MEMBER("MousePos", _relativePos);
		private _selCtrl = "getSelCtrl" call MEMBER("GuiObject", nil);
		if (!(_selCtrl isEqualTo {}) && MEMBER("LBPressing", nil)) then {
			private _pos = "getPos" call _selCtrl;
			private _delta = MEMBER("DeltaPosClick", nil);
			private _size = "getSize" call MEMBER("GridObject", nil);
			private _minW = ("getSizeW" call MEMBER("GridObject", nil)) * 2;
			private _minH = ("getSizeH" call MEMBER("GridObject", nil)) * 1;
			private _modX = safezoneW/(_size select 0);
			private _modY = safezoneH/(_size select 1);
			if !(MEMBER("CtrlPressing", nil)) then {
				if (MEMBER("AltPressing", nil)) exitWith {
					private _newPos = switch (MEMBER("cornerGrab", nil)) do { 
						case "bottom|right" : {
							[
								_pos select 0,
								_pos select 1,
								((_relativePos select 0) - ((_relativePos select 0) % _modX) - (_pos select 0)) max _minW,
								((_relativePos select 1) - ((_relativePos select 1) % _modY) - (_pos select 1)) max _minH
							];
						}; 
						case "top|right" : {
							[
								_pos select 0,
								((_relativePos select 1) - ((_relativePos select 1) % _modY)),
								((_relativePos select 0) - ((_relativePos select 0) % _modX) - (_pos select 0)) max _minW,
								(_pos select 1) + (_pos select 3) - ((_relativePos select 1) - ((_relativePos select 1) % _modY)) max _minH
							];
						};
						case "top|left" : {
							[
								((_relativePos select 0) - ((_relativePos select 0) % _modX)),
								((_relativePos select 1) - ((_relativePos select 1) % _modY)),
								(_pos select 2) + (_pos select 0) - ((_relativePos select 0) - ((_relativePos select 0) % _modX)) max _minW,
								(_pos select 1) + (_pos select 3) - ((_relativePos select 1) - ((_relativePos select 1) % _modY)) max _minH
							];
						};
						case "bottom|left" : {
							[
								((_relativePos select 0) - (_relativePos select 0) % _modX),
								(_pos select 1),
								(_pos select 0) + (_pos select 2) - ((_relativePos select 0) - (_relativePos select 0) % _modX) max _minW,
								((_relativePos select 1) - (_relativePos select 1) % _modY) - (_pos select 1) max _minH 
							];
						};
						case "top|mid" : {
							[
								_pos select 0,
								((_relativePos select 1) - ((_relativePos select 1) % _modY)),
								_pos select 2,
								(_pos select 1) + (_pos select 3) - ((_relativePos select 1) - ((_relativePos select 1) % _modY)) max _minH
							];
						};
						case "bottom|mid" : {
							[
								_pos select 0,
								_pos select 1,
								_pos select 2,
								((_relativePos select 1) - (_relativePos select 1) % _modY) - (_pos select 1) max _minH 
							];
						};
						case "right|mid" : {
							[
								_pos select 0,
								_pos select 1,
								((_relativePos select 0) - ((_relativePos select 0) % _modX) - (_pos select 0)) max _minW,
								_pos select 3
							];
						};
						case "left|mid" : {
							[
								((_relativePos select 0) - ((_relativePos select 0) % _modX)),
								_pos select 1,
								(_pos select 2) + (_pos select 0) - ((_relativePos select 0) - ((_relativePos select 0) % _modX)) max _minW,
								_pos select 3
							];
						};
						default {
							hint ("Unrecognize corner " + MEMBER("cornerGrab", nil));
						}; 
					};
					["setPos", _newPos] call _selCtrl;
				};
				private _newPos = [
					(_relativePos select 0) - ((_relativePos select 0) % _modX) - ((_delta select 0) - ((_delta select 0) % _modX)),
					(_relativePos select 1) - ((_relativePos select 1) % _modY) - ((_delta select 1) - ((_delta select 1) % _modY)),
					(_pos select 2),
					(_pos select 3)
				];
				["setPos", _newPos] call _selCtrl;
			};
			//Static move/resize
			if (MEMBER("CtrlPressing", nil)) then {
				if (MEMBER("AltPressing", nil)) exitWith {
					private _newPos = switch (MEMBER("cornerGrab", nil)) do { 
						case "bottom|right" : {
							[
								_pos select 0,
								_pos select 1,
								(_relativePos select 0) - (_pos select 0) max _minW,
								(_relativePos select 1) - (_pos select 1) max _minH
							];
						}; 
						case "top|right" : {
							[
								_pos select 0,
								(_relativePos select 1),
								(_relativePos select 0) - (_pos select 0) max _minW,
								(_pos select 1) + (_pos select 3) - (_relativePos select 1) max _minH
							];
						};
						case "top|left" : {
							[
								(_relativePos select 0),
								(_relativePos select 1),
								(_pos select 2) + (_pos select 0) - (_relativePos select 0) max _minW,
								(_pos select 1) + (_pos select 3) - (_relativePos select 1) max _minH
							];
						};
						case "bottom|left" : {
							[
								(_relativePos select 0),
								(_pos select 1),
								(_pos select 0) + (_pos select 2) - (_relativePos select 0) max _minW,
								(_relativePos select 1) - (_pos select 1) max _minH
							];
						};

						case "top|mid" : {
							[
								_pos select 0,
								(_relativePos select 1),
								_pos select 2,
								(_pos select 1) + (_pos select 3) - (_relativePos select 1) max _minH
							];
						};
						case "bottom|mid" : {
							[
								_pos select 0,
								_pos select 1,
								_pos select 2,
								(_relativePos select 1) - (_pos select 1) max _minH 
							];
						};
						case "right|mid" : {
							[
								_pos select 0,
								_pos select 1,
								(_relativePos select 0) - (_pos select 0) max _minW,
								_pos select 3
							];
						};
						case "left|mid" : {
							[
								(_relativePos select 0),
								_pos select 1,
								(_pos select 2) + (_pos select 0) - (_relativePos select 0) max _minW,
								_pos select 3
							];
						};

						default {
							hint ("Unrecognize corner " + MEMBER("cornerGrab", nil));
						}; 
					};
					["setPos", _newPos] call _selCtrl;
				};
				if (MEMBER("CtrlPressing", nil)) exitWith {
					private _newPos = [
						(_relativePos select 0) - (_delta select 0), 
						(_relativePos select 1) - (_delta select 1),
						_pos select 2,
						_pos select 3
					];
					["setPos", _newPos] call _selCtrl;
				};				
			};
		};
	};

	/*
	*	Fonction de récupation de l'évent handler MouseButtonDown cf arma...
	*	Input:
	*		0:control: control clicked
	*		1:scalar: mouse button pushed
	*		2:scalar: mouseX
	*		3:scalar: mouseY
	*		4:bool: shift press
	*		5:bool:	ctrl press
	*		6:bool:	alt press
	*/
	PUBLIC FUNCTION("array","MouseButtonDown") {
		private _workground = "getWorkground" call MEMBER("GuiObject", nil);
		private _posLayer = "getPos" call _workground;
		MEMBER("ShiftPressing",  _this select 4);
		MEMBER("CtrlPressing", _this select 5);
		MEMBER("AltPressing", _this select 6);
		private _relativePos = [
				(_this select 2) - (_posLayer select 0), 
				(_this select 3) - (_posLayer select 1)
			];
		
		MEMBER("MouseClick", _relativePos);
		private _res = ["findFirstAtPos", MEMBER("MouseClick", nil)] call _workground;
		if ((_this select 1) == 0) exitWith {			
			if !(_res isEqualTo {}) then {
				private _pos = "getPos" call _res;
				private _dTopLeft = MEMBER("MouseClick", nil) distance2D [_pos select 0, _pos select 1];
				private _dTopRight = MEMBER("MouseClick", nil) distance2D [(_pos select 0) + (_pos select 2), _pos select 1];
				private _dBottomLeft = MEMBER("MouseClick", nil) distance2D [(_pos select 0), (_pos select 1) + (_pos select 3)];
				private _dBottomRight = MEMBER("MouseClick", nil) distance2D [(_pos select 0) + (_pos select 2), (_pos select 1) + (_pos select 3)];
				
				private _dMidRight = MEMBER("MouseClick", nil) distance2D [(_pos select 0) + (_pos select 2), (_pos select 1) + ((_pos select 3)/2)];
				private _dMidLeft = MEMBER("MouseClick", nil) distance2D [(_pos select 0), (_pos select 1) + ((_pos select 3)/2)];
				private _dMidTop = MEMBER("MouseClick", nil) distance2D [(_pos select 0) + ((_pos select 2)/2), _pos select 1];
				private _dMidBottom = MEMBER("MouseClick", nil) distance2D [(_pos select 0) + ((_pos select 2)/2), (_pos select 1) + (_pos select 3)];

				private _dmin = _dTopLeft min _dTopRight min _dBottomLeft min _dBottomRight min _dMidRight min _dMidLeft min _dMidTop min _dMidBottom;

				if (_dmin isEqualTo _dTopLeft) then {
					MEMBER("cornerGrab", "top|left");
				};
				if (_dmin isEqualTo _dTopRight) then {
					MEMBER("cornerGrab", "top|right");
				};
				if (_dmin isEqualTo _dBottomLeft) then {
					MEMBER("cornerGrab", "bottom|left");
				};
				if (_dmin isEqualTo _dBottomRight) then {
					MEMBER("cornerGrab", "bottom|right");
				};

				if (_dmin isEqualTo _dMidRight) then {
					MEMBER("cornerGrab", "right|mid");
				};
				if (_dmin isEqualTo _dMidLeft) then {
					MEMBER("cornerGrab", "left|mid");
				};
				if (_dmin isEqualTo _dMidTop) then {
					MEMBER("cornerGrab", "top|mid");
				};
				if (_dmin isEqualTo _dMidBottom) then {
					MEMBER("cornerGrab", "bottom|mid");
				};

				private _a = [
					(MEMBER("MouseClick", nil) select 0) - (_pos select 0),
					(MEMBER("MouseClick", nil) select 1) - (_pos select 1)
				];
				MEMBER("DeltaPosClick", _a);
				["setSelCtrl", _res] call MEMBER("GuiObject", nil);
			}else{
				["setSelCtrl", {}] call MEMBER("GuiObject", nil);
			};			
			MEMBER("LBPressing", true);
		};
	};

	/*
	*	Fonction de récupation de l'évent handler MouseButtonUp cf arma...
	*	Input:
	*		0:control: control clicked
	*		1:scalar: mouse button pushed
	*		2:scalar: mouseX
	*		3:scalar: mouseY
	*		4:bool: shift press
	*		5:bool:	ctrl press
	*		6:bool:	alt press
	*/
	PUBLIC FUNCTION("array","MouseButtonUp") {
		private _workground = "getWorkground" call MEMBER("GuiObject", nil);
		private _posLayer = "getPos" call _workground;
		MEMBER("ShiftPressing",  _this select 4);
		MEMBER("CtrlPressing", _this select 5);
		MEMBER("AltPressing", _this select 6);
		private "_relativePos";
		if (!(_this select 5)) then {
			private _size = "getSize" call MEMBER("GridObject", nil);
			private _modX = safezoneW/(_size select 0);
			private _modY = safezoneH/(_size select 1);
			_relativePos = [
				(_this select 2) - (_posLayer select 0) - (((_this select 2) - (_posLayer select 0)) mod _modX), 
				(_this select 3) - (_posLayer select 1) - (((_this select 3) - (_posLayer select 1)) mod _modY)
			];		
		}else{
			_relativePos = [
				(_this select 2) - (_posLayer select 0), 
				(_this select 3) - (_posLayer select 1)
			];
		};
		MEMBER("MouseClick", _relativePos);
		private _res = ["findFirstAtPos", MEMBER("MouseClick", nil)] call _workground;
		if ((_this select 1) == 0) exitWith {
			MEMBER("LBPressing", false);
		};
		if ((_this select 1) == 1) exitWith {
			if !(_res isEqualTo {}) then {
				["setSelCtrl", _res] call MEMBER("GuiObject", nil);
				"cfgCtrlDialog" call MEMBER("GuiObject", nil);
				MEMBER("LBPressing", false);
			}else{
				"ctrlCreateDialog" call MEMBER("GuiObject", nil);
				MEMBER("LBPressing", false);
			};
		};
	};

	/*
	*	Fonction de récupation de l'évent handler MouseButtonDblClick cf arma...
	*	Input:
	*		0:control: control clicked
	*		1:scalar: mouse button pushed
	*		2:scalar: mouseX
	*		3:scalar: mouseY
	*		4:bool: shift press
	*		5:bool:	ctrl press
	*		6:bool:	alt press
	*/
	PUBLIC FUNCTION("array","MouseButtonDblClick") {
		private _workground = "getWorkground" call MEMBER("GuiObject", nil);
		private _posLayer = "getPos" call _workground;
		MEMBER("ShiftPressing",  _this select 4);
		MEMBER("CtrlPressing", _this select 5);
		MEMBER("AltPressing", _this select 6);
		private _relativePos = [
			(_this select 2) - (_posLayer select 0), 
			(_this select 3) - (_posLayer select 1)
		];
		MEMBER("MouseClick", _relativePos);
		private _res = ["findFirstAtPos", MEMBER("MouseClick", nil)] call _workground;
		if ((_this select 1) == 0) exitWith {
			if !(_res isEqualTo {}) then {
				if (("getTypeName" call _res) isEqualTo "oo_Layer") then {
					["setActiveLayer", _res] call MEMBER("GuiObject", nil);
				};
			};
		};
	};

	PUBLIC FUNCTION("","getMouseClick") { +MEMBER("MouseClick", nil); };
ENDCLASS;
