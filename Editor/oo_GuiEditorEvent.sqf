#include "..\oop.h"
#include "..\dik_macro.hpp"

CLASS("oo_GuiEditorEvent")
	PUBLIC VARIABLE("code","this");
	PUBLIC VARIABLE("code","GridObject");
	PUBLIC VARIABLE("code", "copySelection");
	PUBLIC VARIABLE("bool", "LBPressing");
	PUBLIC VARIABLE("bool", "AltPressing");
	PUBLIC VARIABLE("bool", "CtrlPressing");
	PUBLIC VARIABLE("array", "MousePos");
	PUBLIC VARIABLE("array", "MouseClick");
	PUBLIC VARIABLE("array", "DeltaPosClick");
	PUBLIC VARIABLE("string", "cornerGrab");
	PUBLIC VARIABLE("code", "TreeDialog");

	PUBLIC VARIABLE("script", "CopyLimiter");
	
	PUBLIC FUNCTION("","constructor") {
		disableSerialization; 
		private _gridObject = "getGridObject" call GuiObject;
		MEMBER("GridObject", _gridObject);
		MEMBER("cornerGrab", "top|left");
		MEMBER("LBPressing", false);
		MEMBER("AltPressing", false);
		MEMBER("CtrlPressing", false);
		MEMBER("MousePos", []);
		MEMBER("MouseClick", []);
		MEMBER("DeltaPosClick", []);
		MEMBER("copySelection", {});
		MEMBER("CopyLimiter", scriptNull);
		("getDisplay" call GuiObject) displayAddEventHandler["KeyDown", format["['KeyDown', _this] call %1;", _code] ];
		("getDisplay" call GuiObject) displayAddEventHandler["KeyUp", format["['KeyUp', _this] call %1;", _code] ];
		private _tree = "new" call oo_TreeDialog;
		MEMBER("TreeDialog", _tree);
	};	

	PUBLIC FUNCTION("array","KeyUp") {
		private _DikCode = param[1, -1, [-1]];
		MEMBER("CtrlPressing", _this select 3);
		MEMBER("AltPressing", _this select 4);
		switch (_DikCode) do { 
			case DIK_F5:{
				["setAllEnable", false] call GuiObject;
			};
		};
	};

	/*
	*	Fonction de récupation de l'évent handler Keydown cf arma...
	*/
	PUBLIC FUNCTION("array","KeyDown") {
		private _DikCode = param[1, -1, [-1]];
		MEMBER("CtrlPressing", _this select 3);
		MEMBER("AltPressing", _this select 4);
		private _arr = [0,0,0,0];
		private _noReturn = true;

		private _workground = "getWorkground" call GuiObject;
		private _selCtrl = "getSelCtrl" call GuiObject;
		private _size = "getSize" call MEMBER("GridObject", nil);
		private _sizeX = safezoneW/(_size select 0);
		private _sizeY = safezoneH/(_size select 1);
		switch (_DikCode) do { 
			case DIK_F1:{
				"new" call oo_helpDialog;
			};
			case DIK_F2:{
				"new" call oo_displayConfig;
			};

			case DIK_F3:{
				"exportHPP" call GuiObject;
			};

			case DIK_F4:{
				"exportOOP" call GuiObject;
			};
			case DIK_F5:{
				["setAllEnable", true] call GuiObject;
			};

			case DIK_O:{
				if!(_workground isEqualTo ("getView" call GuiObject)) then {
					"switchFullScreen" call _workground;
				};				
			};

			case DIK_I:{
				"importFromClipboard" call GuiObject;
			};

			case DIK_SPACE:{
				"colorizeControl" call _workground;
				_noReturn = true;
			};

			case DIK_T:{
				"show" call MEMBER("TreeDialog", nil);
			};	

			case DIK_NEXT:{
				if ("isOpen" call MEMBER("TreeDialog", nil)) then {
					disableSerialization;
					private _tree = "getControl" call MEMBER("TreeDialog", nil);
					private _path = tvCurSel _tree;
					private _item = call compile (_tree tvData _path);
					if (_item isEqualTo ("getView" call GuiObject)) exitWith {true;};
					private _parent = "getParent" call _item;
					diag_log format["Parent:%1",_parent];
					if(["moveDown", _item] call _parent) then{
						"refreshDisplay" call GuiObject;
						"fill" call MEMBER("TreeDialog", nil);
						_path set [(count _path) - 1, (_path select ((count _path) -1)) + 1];
						_tree tvSetCurSel _path;
						true;
					}else{
						hint "Can't put child more down";
					};					
				};
				_noReturn = true;
			};

			case DIK_PRIOR:{
				if ("isOpen" call MEMBER("TreeDialog", nil)) then {
					disableSerialization;
					private _tree = "getControl" call MEMBER("TreeDialog", nil);
					private _path = tvCurSel _tree;
					private _item = call compile (_tree tvData _path);
					if (_item isEqualTo ("getView" call GuiObject)) exitWith {};
					private _parent = "getParent" call _item;
					if(["moveUp", _item] call _parent) then{
						"refreshDisplay" call GuiObject;
						"fill" call MEMBER("TreeDialog", nil);
						_path set [(count _path) - 1, (_path select ((count _path) -1)) - 1];
						_tree tvSetCurSel _path;
					}else{
						hint "Can't put child more up";
					};
				};
				_noReturn = true;
			};

			case DIK_H: {
				private _res = ["findFirstAtPos", MEMBER("MousePos", nil)] call _workground;
				if!(_res isEqualTo {}) exitWith {
					private _control = "getControl" call _res;
					if (ctrlShown _control) then {
						["setVisible", false] call _res;
					}else{
						["setVisible", true] call _res;
					};
					["fill", _path] call MEMBER("TreeDialog", nil);
				};
				private _path = "getPath" call MEMBER("TreeDialog", nil);
				private _item = "getSel" call MEMBER("TreeDialog", nil);
				if!(_item isEqualTo {}) then {
					private _control = "getControl" call _item;
					if (ctrlShown _control) then {
						["setVisible", false] call _item;
					}else{
						["setVisible", true] call _item;
					};
					if (_item isEqualTo ("getWorkground" call GuiObject)) then {
						private _parent = "getParent" call _item;
						["setActiveLayer", _parent] call GuiObject;
					};
					["fill", _path] call MEMBER("TreeDialog", nil);
				};
				
			};

			case DIK_DELETE : {
				private _res = ["findFirstAtPos", MEMBER("MousePos", nil)] call _workground;
				
				if (_res isEqualTo {}) exitWith {
					private _ctrlSel = "getSelCtrl" call GuiObject;
					if !(_ctrlSel isEqualTo {}) then {
						if (("getParentClass" call _workground) isEqualTo "oo_metaControl") exitWith {
							if (["isInConstChilds", _ctrlSel] call _workground) then {
								hint "You can't delete control inside meta control";
							}else{
								["delete", _ctrlSel] call oo_Control;
								["deleteChild", _ctrlSel] call _workground;
								"fill" call MEMBER("TreeDialog", nil);
							};
						};
						["delete", _ctrlSel] call oo_Control;
						["deleteChild", _ctrlSel] call _workground;
						"fill" call MEMBER("TreeDialog", nil);
					};
				};
				if !(_res isEqualTo ("getView" call GuiObject)) then {
					if (("getParentClass" call _workground) isEqualTo "oo_metaControl") exitWith {
						if (["isInConstChilds", _res] call _workground) then {
							hint "You can't delete control inside meta control";
						}else{
							["delete", _res] call oo_Control;
							["deleteChild", _res] call _workground;
							MEMBER("fillDisplayTree", nil);
						};
					};
					if ("getTypeName" call _res isEqualTo "oo_Control") then {
						["delete", _res] call oo_Control;
						["deleteChild", _res] call _workground;
					};
					if ("getTypeName" call _res isEqualTo "oo_Layer") then {
						["delete", _res] call oo_Layer;
						["deleteChild", _res] call _workground;
					};
					"fill" call MEMBER("TreeDialog", nil);
				};
			};

			case DIK_C:{
				if (MEMBER("CtrlPressing", nil)) exitWith {
					private _res = ["findFirstAtPos", MEMBER("MousePos", nil)] call _workground;
					if (_res isEqualTo {}) exitWith {
						MEMBER("copySelection", {});
					};
					MEMBER("copySelection", _res);
				};
				if (_selCtrl isEqualTo {}) exitWith {
					private _res = ["findFirstAtPos", MEMBER("MousePos", nil)] call _workground;
					if !(_res isEqualTo {}) then {
						"centerH" call _res;
						["setSelCtrl", _res] call GuiObject;
					};
				};
				"centerH" call _selCtrl;
			};

			case DIK_V:{
				if (MEMBER("CtrlPressing", nil)) exitWith {
						if (scriptDone MEMBER("CopyLimiter", nil)) then {
							private _handle = MEMBER("this", nil) spawn {
								private _copySel = "getCopySelection" call _this;
								if !(_copySel isEqualTo {}) then {
									private _workground = "getWorkground" call GuiObject;
									private _mousePos = "getMousePos" call _this;

									if ("getParentClass" call _workground isEqualTo "oo_metaControl") exitWith {
							 			if (["isInConstChilds", _copySel] call _workground) then {
							 				hint "You can't copy/paste constant control";
							 			}else{
							 				private _pasteCtrl = ["ctrlCreate", "getType" call _copySel] call GuiObject;
									 		private _a = [_copySel, _pasteCtrl];
									 		["copyControl", _a] call _this;
									 		["setPos", _mousePos] call _pasteCtrl;
									 		["pushChild", _pasteCtrl] call _workground;
									 		"refreshTree" call _this;
							 			};
							 			sleep 0.3;		 			
							 		};

							 		if ("getParentClass" call _copySel isEqualTo "oo_metaControl") exitWith {
								 		private _pasteCtrl = ["ctrlCreate", "getType" call _copySel] call GuiObject;
								 		["setPos", _mousePos] call _pasteCtrl;
								 		["pushChild", _pasteCtrl] call _workground;
								 		"refreshTree" call _this;
								 		sleep 0.3;
							 		};

							 		if ("getTypeName" call _copySel isEqualTo "oo_Control") exitWith {
								 		private _pasteCtrl = ["ctrlCreate", "getType" call _copySel] call GuiObject;
								 		private _a = [_copySel, _pasteCtrl];
								 		["copyControl", _a] call _this;
								 		["setPos", _mousePos] call _pasteCtrl;
								 		["pushChild", _pasteCtrl] call _workground;
								 		"refreshTree" call _this;
								 		sleep 0.3;
							 		};
							 		if ("getTypeName" call _copySel isEqualTo "oo_Layer") exitWith {
							 			private _newLayer = ["ctrlCreate", "getType" call _copySel] call GuiObject;
							 			private _a = [_copySel, _newLayer];
							 			["copyChilds", _a] call _this;
							 			["setPos", _mousePos] call _newLayer;
							 			["pushChild", _newLayer] call _workground;
							 			"refreshTree" call _this;
							 			sleep 0.3;
							 		};							 		
							 	};
						 	};
						 	MEMBER("CopyLimiter", _handle);
						};
				};
				if (_selCtrl isEqualTo {}) then {
					private _res = ["findFirstAtPos", MEMBER("MousePos", nil)] call _workground;
					if !(_res isEqualTo {}) then {
						"centerV" call _res;
					};
				};
				"centerV" call _selCtrl;
			};

			case DIK_DOWNARROW:{
				if (MEMBER("AltPressing", nil)) exitWith {
					if (MEMBER("CtrlPressing", nil)) then {
						_arr = [0,0,0,_sizeY/2];
					}else{
						_arr = [0,0,0,_sizeY];
					};
					["relativeMove", _arr] call GuiObject;
				};
				if (MEMBER("CtrlPressing", nil)) then {
					_arr = [0,_sizeY/2,0,0];
				}else{
					_arr = [0,_sizeY,0,0];
				};
				["relativeMove", _arr] call GuiObject;
			};

			case DIK_UPARROW:{
				if (MEMBER("AltPressing", nil)) exitWith {
					if (MEMBER("CtrlPressing", nil)) then {
						_arr = [0,0,0,-_sizeY/2];
					}else{
						_arr = [0,0,0,-_sizeY];
					};
					["relativeMove", _arr] call GuiObject;
				};
				if (MEMBER("CtrlPressing", nil)) then {
					_arr = [0,-_sizeY/2,0,0];
				}else{
					_arr = [0,-_sizeY,0,0];
				};
				["relativeMove", _arr] call GuiObject;
			};

			case DIK_RIGHTARROW:{
				if (MEMBER("AltPressing", nil)) exitWith {
					if (MEMBER("CtrlPressing", nil)) then {
						_arr = [0,0,_sizeX/2,0];
					}else{
						_arr = [0,0,_sizeX,0];
					};
					["relativeMove", _arr] call GuiObject;
				};
				if (MEMBER("CtrlPressing", nil)) then {
					_arr = [_sizeX/2,0,0,0];
				}else{
					_arr = [_sizeX,0,0,0];
				};
				["relativeMove", _arr] call GuiObject;
			};

			case DIK_LEFTARROW:{
				if (MEMBER("AltPressing", nil)) exitWith {
					if (MEMBER("CtrlPressing", nil)) then {
						_arr = [0,0,-_sizeX/2,0];
					}else{
						_arr = [0,0,-_sizeX,0];
					};
					_arr = [0,0,-_sizeX,0];
					["relativeMove", _arr] call GuiObject;
				};
				if (MEMBER("CtrlPressing", nil)) then {
					_arr = [-_sizeX/2,0,0,0];
				}else{
					_arr = [-_sizeX,0,0,0];
				};
				["relativeMove", _arr] call GuiObject;
			};
			case DIK_ESCAPE : {
				if (_workground isEqualTo ("getView" call GuiObject)) then {
					[] spawn {
						_result = ["Are you sure?", "Confirm", true, true] call BIS_fnc_guiMessage;
						if (_result) then {
							"getSerializeChilds" call GuiObject;
							closeDialog 0;
						};
					};
					
				}else{
					MEMBER("copySelection", {});
					["setActiveLayer", ("getParent" call _workground)] call GuiObject;
				};				
			};			
			default {}; 
		};
		_noReturn;
	};

	PUBLIC FUNCTION("array","copyChilds") {
		private "_newChild", "_a";
		["setData", "getDuplicateData" call (_this select 0)] call (_this select 1);
		{
			if ("getTypeName" call _x isEqualTo "oo_Control") then {
				_newChild = ["ctrlCreate", "getType" call _x] call GuiObject;
				_a = [_x, _newChild];
				MEMBER("copyControl", _a);
				["setPos", "getPos" call _x] call _newChild;
				["pushChild", _newChild] call (_this select 1);
			};
			if ("getTypeName" call _x isEqualTo "oo_Layer") then {
				_newChild = ["ctrlCreate", "getType" call _x] call GuiObject;
				_a = [_x, _newChild];
				MEMBER("copyChilds", _a);
				["setPos", "getPos" call _x] call _newChild;
				["pushChild", _newChild] call (_this select 1);
			};
		} forEach ("getChilds" call (_this select 0));
	};

	// _ctrlOrigin = _this select 0;
	// _ctrlDest = _this select 1;
	PUBLIC FUNCTION("array","copyControl") {
		["setData", "getDuplicateData" call (_this select 0)] call (_this select 1);
	 	(_this select 1);
	};

	PUBLIC FUNCTION("","getCopySelection") {
		MEMBER("copySelection", nil);
	};

	/*
	*	Fonction gérant la positions des éléments dans le gui
	*	@input:array input from EventHandler MouseMoving see: https://community.bistudio.com/wiki/User_Interface_Event_Handlers
	*/
	PUBLIC FUNCTION("array","MouseMoving") {
		private _workground = "getWorkground" call GuiObject;
		private _selCtrl = "getSelCtrl" call GuiObject;
		if (_workground isEqualTo _selCtrl) exitWith {};
		private _workgroundControl = "getControl" call _workground;
		private _pos = ctrlPosition _workgroundControl;
		private _relativePos = [
			(_this select 1) - (_pos select 0), 
			(_this select 2) - (_pos select 1)
		];
		MEMBER("MousePos", _relativePos);
		if (!(_selCtrl isEqualTo {}) && MEMBER("LBPressing", nil)) then {
			private _pos = "getPos" call _selCtrl;
			private _delta = MEMBER("DeltaPosClick", nil);
			private _size = "getSize" call MEMBER("GridObject", nil);
			private _minW = ("getSizeW" call MEMBER("GridObject", nil)) * 1;
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
							// ("Unrecognize corner " + MEMBER("cornerGrab", nil));
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
							// ("Unrecognize corner " + MEMBER("cornerGrab", nil));
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
		private _workground = "getWorkground" call GuiObject;
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
				["setSelCtrl", _res] call GuiObject;
			}else{
				["setSelCtrl", {}] call GuiObject;
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
		private _workground = "getWorkground" call GuiObject;
		private _posLayer = "getPos" call _workground;
		MEMBER("ShiftPressing",  _this select 4);
		MEMBER("CtrlPressing", _this select 5);
		MEMBER("AltPressing", _this select 6);
		private	_relativePos = [
			(_this select 2) - (_posLayer select 0), 
			(_this select 3) - (_posLayer select 1)
		];
		MEMBER("MouseClick", _relativePos);
		private _res = ["findFirstAtPos", MEMBER("MouseClick", nil)] call _workground;
		if ((_this select 1) == 0) exitWith {
			MEMBER("LBPressing", false);
		};
		if ((_this select 1) == 1) exitWith {
			if !(_res isEqualTo {}) then {
				["setSelCtrl", _res] call GuiObject;
				"ctrlModifyDialog" call GuiObject;
				MEMBER("LBPressing", false);
			}else{
				"ctrlCreateDialog" call GuiObject;
				if (!(_this select 5)) then {
					private _size = "getSize" call MEMBER("GridObject", nil);
					private _modX = safezoneW/(_size select 0);
					private _modY = safezoneH/(_size select 1);
					_relativePos = [
						(_this select 2) - (_posLayer select 0) - (((_this select 2) - (_posLayer select 0)) mod _modX), 
						(_this select 3) - (_posLayer select 1) - (((_this select 3) - (_posLayer select 1)) mod _modY)
					];
					MEMBER("MouseClick", _relativePos);
				};
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
		private _workground = "getWorkground" call GuiObject;
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
				if ("couldBeWorkground" call _res) then {
					["setActiveLayer", _res] call GuiObject;
				};
			};
		};
	};

	PUBLIC FUNCTION("","refreshTree") {
		"fill" call MEMBER("TreeDialog", nil);
	};

	PUBLIC FUNCTION("","getMouseClick") { +MEMBER("MouseClick", nil); };
	PUBLIC FUNCTION("","getMousePos") { MEMBER("MousePos", nil); };
	PUBLIC FUNCTION("","getTree") { MEMBER("TreeDialog", nil); };
ENDCLASS;
