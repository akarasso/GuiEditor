#include "..\oop.h"
#include "..\dik_macro.hpp"

CLASS("oo_GuiEditorEvent")
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
		MEMBER("GuiObject", _this);
		private _gridObject = "getGridObject" call _this;
		MEMBER("GridObject", _gridObject);

		MEMBER("cornerGrab", "top|left");
		MEMBER("LBPressing", false);
		MEMBER("AltPressing", false);
		MEMBER("CtrlPressing", false);

		MEMBER("MousePos", []);
		MEMBER("MouseClick", []);
		MEMBER("DeltaPosClick", []);

		("getDisplay" call _this) displayAddEventHandler["KeyDown", format["['KeyDown', _this] call %1;", _code] ];
	};


	PUBLIC FUNCTION("","showTreeDialog") {
		DEBUG(#, "oo_GuiEditor::ctrlCreateDialog")
		disableSerialization;
		if !(MEMBER("TreeDialog", nil) isEqualTo controlNull) exitWith {};
		private _tree = MEMBER("Display", nil) ctrlCreate["OOP_Tree",-2, "getLayer" call MEMBER("View", nil)];
		MEMBER("TreeDialog", _tree);
		_tree ctrlSetPosition [0,0, safezoneW/5, safezoneH];
		_tree ctrlCommit 0;
		MEMBER("fillDisplayTree", nil);
		_tree ctrlAddEventHandler ["MouseExit", format["['TreeExit', _this] spawn %1", _self]];
		_tree ctrlAddEventHandler ["TreeSelChanged", format["['TreeSelChanged', _this] spawn %1", _self]];
		_tree ctrlAddEventHandler ["TreeDblClick", format["['TreeDblClick', _this] spawn %1", _self]];
	};

	PUBLIC FUNCTION("","fillDisplayTree") {
		disableSerialization;
		if (MEMBER("TreeDialog", nil) isEqualTo controlNull) exitWith {};
		tvClear MEMBER("TreeDialog", nil);
		["fillDisplayTree", [MEMBER("TreeDialog", nil), []]] call MEMBER("View", nil);
		tvExpandAll MEMBER("TreeDialog", nil);
	};

	PUBLIC FUNCTION("array","TreeExit") {
		disableSerialization;
		private _tree = _this select 0;
		private _helperStyle = ["new", MEMBER("Display", nil)] call oo_HelperStyle;
		["close", [_tree, 0.5, "left"]] call _helperStyle;
		sleep 0.5;
		MEMBER("TreeDialog", controlNull);
		ctrlDelete _tree;
	};

	PUBLIC FUNCTION("array","TreeDblClick") {
		disableSerialization;
		private _item = call compile ((_this select 0) tvData (_this select 1));
		if ("getTypeName" call _item isEqualTo "oo_Layer") exitWith {
			MEMBER("setActiveLayer", _item);
		};
		MEMBER("setActiveLayer", ("getParentLayer" call _item));
		MEMBER("selCtrl", _item);
		MEMBER("cfgCtrlDialog", nil);
	};

	PUBLIC FUNCTION("array","TreeSelChanged") {
		disableSerialization;
		private _item = call compile ((_this select 0) tvData (_this select 1));
		"colorizeControl" spawn _item;
	};

	/*
	*	Fonction de récupation de l'évent handler Keydown cf arma...
	*/
	PUBLIC FUNCTION("array","KeyDown") {
		// private _layer = param[0, displayNull, [displayNull]];
		private _DikCode = param[1, -1, [-1]];
		// private _shift = param[2, false, [false]];
		MEMBER("CtrlPressing", _this select 3);
		MEMBER("AltPressing", _this select 4);
		private _arr = [0,0,0,0];
		private _noReturn = true;

		private _workground = "getWorkground" call MEMBER("GuiObject", nil);
		private _view = "getView" call MEMBER("GuiObject", nil);
		private _selCtrl = "getSelCtrl" call MEMBER("GuiObject", nil);

		private _size = "getSize" call MEMBER("GridObjet", nil);
		private _sizeX = safezoneW/(_size select 0);
		private _sizeY = safezoneH/(_size select 1);

		switch (_DikCode) do { 
			case DIK_F1:{
				//Implement help
			};
			case DIK_F2 : {
				if !(_workground isEqualTo _view) then {
					private _parent = "getParentLayer" call _workground;
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
				"showTreeDialog" call MEMBER("GuiObject", nil);
			};
			case DIK_SPACE:{
				"colorizeChilds" call _workground;
			};
			case DIK_DELETE : {
				private _res = ["findFirstAtPos", MEMBER("MousePos", nil)] call _workground;
				if (_res isEqualTo {}) exitWith {
					private _ctrlSel = "getSelCtrl" call MEMBER("GuiObject", nil);
					if !(_ctrlSel isEqualTo {}) then {
						["delete", _ctrlSel] call oo_Control;
					};
				};
				if ("getTypeName" call _res isEqualTo "oo_Control") then {
					["delete", _res] call oo_Control;
				};				
				if ("getTypeName" call _res isEqualTo "oo_Layer") then {
					["delete", _res] call oo_Layer;
				};				
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
				 			private _pos = "getPos" call MEMBER("copyControl", nil);
				 			private _npos = [
				 				MEMBER("MousePos", nil) select 0,
				 				MEMBER("MousePos", nil) select 1,
				 				_pos select 2,
				 				_pos select 3
				 			];
				 			["setPos", _npos] call _newLayer;
				 			private _a = [MEMBER("copyControl", nil), _newLayer];
				 			MEMBER("copyChilds", _a);
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
			_noReturn;
		};
	};

	PUBLIC FUNCTION("array","copyChilds") {
		private _layerOrigin = _this select 0;
		private _childs = "getChilds" call _layerOrigin;
		private _layerDestination = _this select 1;
		private "_newChild", "_a";
		["setActiveLayer", _layerDestination] call MEMBER("GuiObject", nil);
		{
			if ("getTypeName" call _x isEqualTo "oo_Control") then {
				_newChild = ["ctrlCreate", "getType" call _x] call MEMBER("GuiObject", nil);
				_a = [_x, _newChild];
				MEMBER("copyControl", _a);
				["setPos", "getPos" call _x] call _newChild;
			};
			if ("getTypeName" call _x isEqualTo "oo_Layer") then {
				_newChild = ["ctrlCreate", "getType" call _x] call MEMBER("GuiObject", nil);
				_a = [_x, _newChild];
				MEMBER("copyChilds", _a);
				["setPos", "getPos" call _x] call _newChild;
			};
		} forEach _childs;
		["setActiveLayer", "getParentLayer" call _layerDestination] call MEMBER("GuiObject", nil);
	};

	PUBLIC FUNCTION("array","copyControl") {
		private _ctrlOrigin = _this select 0;
		private _ctrlDest = _this select 1;
	 	["setTextColor", "getTextColor" call _x] call _ctrlDest;
	 	["setBackgroundColor", "getBackgroundColor" call _x] call _ctrlDest;
	 	["setForegroundColor", "getForegroundColor" call _x] call _ctrlDest;
	 	["setTooltip", "getTooltip" call _x] call _ctrlDest;
	 	["setText", "getText" call _x] call _ctrlDest;
	 	["setTooltipColorBox", "getTooltipColorBox" call _x] call _ctrlDest;
	 	["setTooltipColorShade", "getTooltipColorShade" call _x] call _ctrlDest;
	 	["setTooltipColorText", "getTooltipColorText" call _x] call _ctrlDest;
	 	["setPos", "getPos" call _ctrlOrigin] call _ctrlDest;
	 	_ctrlDest;
	};

	/*
	*	Fonction gérant la positions des éléments dans le gui
	*	@input:array input from EventHandler MouseMoving see: https://community.bistudio.com/wiki/User_Interface_Event_Handlers
	*/
	PUBLIC FUNCTION("array","MouseMoving") {
		private _workground = "getWorkground" call MEMBER("GuiObject", nil);
		private _pos = "getPos" call _workground;
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
			
			if !(MEMBER("CtrlPressing", nil)) then {
				private _modX = safezoneW/(_size select 0);
				private _modY = safezoneH/(_size select 1);
				if (MEMBER("AltPressing", nil)) exitWith {
					private _newPos = switch (MEMBER("cornerGrab", nil)) do { 
						case "bottom|right" : {
							[
								_pos select 0,
								_pos select 1,
								((MEMBER("MousePos", nil) select 0) - ((MEMBER("MousePos", nil) select 0) % _modX) - (_pos select 0)) max _minW,
								((MEMBER("MousePos", nil) select 1) - ((MEMBER("MousePos", nil) select 1) % _modY) - (_pos select 1)) max _minH
							];
						}; 
						case "top|right" : {
							[
								_pos select 0,
								((MEMBER("MousePos", nil) select 1) - ((MEMBER("MousePos", nil) select 1) % _modY)),
								((MEMBER("MousePos", nil) select 0) - ((MEMBER("MousePos", nil) select 0) % _modX) - (_pos select 0)) max _minW,
								(_pos select 1) + (_pos select 3) - ((MEMBER("MousePos", nil) select 1) - ((MEMBER("MousePos", nil) select 1) % _modY)) max _minH
							];
						};
						case "top|left" : {
							[
								((MEMBER("MousePos", nil) select 0) - ((MEMBER("MousePos", nil) select 0) % _modX)),
								((MEMBER("MousePos", nil) select 1) - ((MEMBER("MousePos", nil) select 1) % _modY)),
								(_pos select 2) + (_pos select 0) - ((MEMBER("MousePos", nil) select 0) - ((MEMBER("MousePos", nil) select 0) % _modX)) max _minW,
								(_pos select 1) + (_pos select 3) - ((MEMBER("MousePos", nil) select 1) - ((MEMBER("MousePos", nil) select 1) % _modY)) max _minH
							];
						};
						case "bottom|left" : {
							[
								((MEMBER("MousePos", nil) select 0) - (MEMBER("MousePos", nil) select 0) % _modX),
								(_pos select 1),
								(_pos select 0) + (_pos select 2) - ((MEMBER("MousePos", nil) select 0) - (MEMBER("MousePos", nil) select 0) % _modX) max _minW,
								((MEMBER("MousePos", nil) select 1) - (MEMBER("MousePos", nil) select 1) % _modY) - (_pos select 1) max _minH 
							];
						};
						default {
							hint "Unrecognize corner";
						}; 
					};
					["setPos", _newPos] call _selCtrl;
				};
				private _newPos = [
					(MEMBER("MousePos", nil) select 0) - ((MEMBER("MousePos", nil) select 0) % _modX) - ((_delta select 0) - ((_delta select 0) % _modX)),
					(MEMBER("MousePos", nil) select 1) - ((MEMBER("MousePos", nil) select 1) % _modY) - ((_delta select 1) - ((_delta select 1) % _modY)),
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
								(MEMBER("MousePos", nil) select 0) - (_pos select 0) max _minW,
								(MEMBER("MousePos", nil) select 1) - (_pos select 1) max _minH
							];
						}; 
						case "top|right" : {
							[
								_pos select 0,
								(MEMBER("MousePos", nil) select 1),
								(MEMBER("MousePos", nil) select 0) - (_pos select 0) max _minW,
								(_pos select 1) + (_pos select 3) - (MEMBER("MousePos", nil) select 1) max _minH
							];
						};
						case "top|left" : {
							[
								(MEMBER("MousePos", nil) select 0),
								(MEMBER("MousePos", nil) select 1),
								(_pos select 2) + (_pos select 0) - (MEMBER("MousePos", nil) select 0) max _minW,
								(_pos select 1) + (_pos select 3) - (MEMBER("MousePos", nil) select 1) max _minH
							];
						};
						case "bottom|left" : {
							[
								(MEMBER("MousePos", nil) select 0),
								(_pos select 1),
								(_pos select 0) + (_pos select 2) - (MEMBER("MousePos", nil) select 0) max _minW,
								(MEMBER("MousePos", nil) select 1) - (_pos select 1) max _minH
							];
						};
						default {
							hint "Unrecognize corner";
						}; 
					};
					["setPos", _newPos] call _selCtrl;
				};
				if (MEMBER("CtrlPressing", nil)) exitWith {
					private _newPos = [
						(MEMBER("MousePos", nil) select 0) - (_delta select 0), 
						(MEMBER("MousePos", nil) select 1) - (_delta select 1),
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
		private _relativePos = [
			(_this select 2) - (_posLayer select 0), 
			(_this select 3) - (_posLayer select 1)
		];

		MEMBER("ShiftPressing",  _this select 4);
		MEMBER("CtrlPressing", _this select 5);
		MEMBER("AltPressing", _this select 6);
		MEMBER("setMouseClick", _relativePos);
		private _res = ["findFirstAtPos", MEMBER("MouseClick", nil)] call _workground;
		if ((_this select 1) == 0) exitWith {			
			if !(_res isEqualTo {}) then {
				private _pos = "getPos" call _res;
				private _dTopLeft = MEMBER("MouseClick", nil) distance2D [_pos select 0, _pos select 1];
				private _dTopRight = MEMBER("MouseClick", nil) distance2D [(_pos select 0) + (_pos select 2), _pos select 1];
				private _dBottomLeft = MEMBER("MouseClick", nil) distance2D [(_pos select 0), (_pos select 1) + (_pos select 3)];
				private _dBottomRight = MEMBER("MouseClick", nil) distance2D [(_pos select 0) + (_pos select 2), (_pos select 1) + (_pos select 3)];
				private _dmin = _dTopLeft min _dTopRight min _dBottomLeft min _dBottomRight;

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
		private _relativePos = [
			(_this select 2) - (_posLayer select 0), 
			(_this select 3) - (_posLayer select 1)
		];
		MEMBER("ShiftPressing",  _this select 4);
		MEMBER("CtrlPressing", _this select 5);
		MEMBER("AltPressing", _this select 6);
		MEMBER("setMouseClick", _relativePos);
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
		private _relativePos = [
			(_this select 2) - (_posLayer select 0), 
			(_this select 3) - (_posLayer select 1)
		];
		MEMBER("ShiftPressing",  _this select 4);
		MEMBER("CtrlPressing", _this select 5);
		MEMBER("AltPressing", _this select 6);
		MEMBER("setMouseClick", _relativePos);
		private _res = ["findFirstAtPos", MEMBER("MouseClick", nil)] call _workground;
		if ((_this select 1) == 0) exitWith {
			if !(_res isEqualTo {}) then {
				if (("getTypeName" call _res) isEqualTo "oo_Layer") then {
					["setActiveLayer", _res] call MEMBER("GuiObject", nil);
				};
			};
		};
	};

	PUBLIC FUNCTION("array","setMouseClick") { MEMBER("MouseClick", _this); };
	PUBLIC FUNCTION("","getCtrlPressing") { MEMBER("CtrlPressing", nil); };
	PUBLIC FUNCTION("","getAltPressing") { MEMBER("AltPressing", nil); };
	PUBLIC FUNCTION("","getLBPressing") { MEMBER("LBPressing", nil); };
	PUBLIC FUNCTION("","getMousePos") { MEMBER("MousePos", nil); };
	PUBLIC FUNCTION("","getMouseClick") { MEMBER("MouseClick", nil); };
ENDCLASS;
