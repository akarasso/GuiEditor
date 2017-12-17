#include "..\oop.h"
#include "..\dik_macro.hpp"

CLASS("oo_HelperGuiEditorEvent")
	PUBLIC VARIABLE("code","GuiObject");

	PUBLIC VARIABLE("bool", "LBPressing");
	PUBLIC VARIABLE("bool", "AltPressing");
	PUBLIC VARIABLE("bool", "CtrlPressing");

	PUBLIC FUNCTION("code","constructor") { 
		MEMBER("GuiObject", _this);
		
		("getDisplay" call _this) displayAddEventHandler["KeyDown", format["['KeyDown', _this] call %1;", _code] ];
	};

	/*
	*	Fonction de récupation de l'évent handler Keydown cf arma...
	*/
	PUBLIC FUNCTION("array","KeyDown") {
		private _layer = param[0, displayNull, [displayNull]];
		private _DikCode = param[1, -1, [-1]];
		private _shift = param[2, false, [false]];
		private _ctrl = param[3, false, [false]];
		private _alt = param[4, false, [false]];
		private _arr = [0,0,0,0];
		private _noReturn = true;

		private _ctrlPressing = "getCtrlPressing" call MEMBER("GuiObject", nil);
		private _altPressing = "getAltPressing" call MEMBER("GuiObject", nil);
		private _gridObject = "getGridObject" call MEMBER("GuiObject", nil);
		private _workground = "getWorkground" call MEMBER("GuiObject", nil);
		private _mousePos = "getMousePos" call MEMBER("GuiObject", nil);
		private _view = "getView" call MEMBER("GuiObject", nil);
		private _selCtrl = "getSelCtrl" call MEMBER("GuiObject", nil);

		private _size = "getSize" call _gridObject;
		private _sizeX = safezoneW/(_size select 0);
		private _sizeY = safezoneH/(_size select 1);

		switch (_DikCode) do { 
			case DIK_F1:{
				//Implement help
			};

			case DIK_SPACE:{
				"colorize" call _workground;
			};
			case DIK_C:{
				if (_selCtrl isEqualTo {}) then {
					private _res = ["findFirstAtPos", _mousePos] call _workground;
					if !(_res isEqualTo {}) then {
						["setSelCtrl", _res] call MEMBER("GuiObject", nil);
					};
				};
				"centerH" call MEMBER("GuiObject", nil);
			};
			case DIK_V:{
				hint "press";
				if (_selCtrl isEqualTo {}) then {
					private _res = ["findFirstAtPos", _mousePos] call _workground;
					if !(_res isEqualTo {}) then {
						["setSelCtrl", _res] call MEMBER("GuiObject", nil);
					};
				};
				"centerV" call MEMBER("GuiObject", nil);
			};
			case DIK_DOWNARROW:{
				if (_altPressing) exitWith {
					if (_ctrlPressing) then {
						_arr = [0,0,0,_sizeY/2];
					}else{
						_arr = [0,0,0,_sizeY];
					};
					["relativeMove", _arr] call MEMBER("GuiObject", nil);
				};
				if (_ctrlPressing) then {
					_arr = [0,_sizeY/2,0,0];
				}else{
					_arr = [0,_sizeY,0,0];
				};
				["relativeMove", _arr] call MEMBER("GuiObject", nil);
			};
			case DIK_UPARROW:{
				if (_altPressing) exitWith {
					if (_ctrlPressing) then {
						_arr = [0,0,0,-_sizeY/2];
					}else{
						_arr = [0,0,0,-_sizeY];
					};
					["relativeMove", _arr] call MEMBER("GuiObject", nil);
				};
				if (_ctrlPressing) then {
					_arr = [0,-_sizeY,0,0];
				}else{
					_arr = [0,-_sizeY,0,0];
				};
				["relativeMove", _arr] call MEMBER("GuiObject", nil);
			};
			case DIK_RIGHTARROW:{
				if (_altPressing) exitWith {
					if (_ctrlPressing) then {
						_arr = [0,0,_sizeX/2,0];
					}else{
						_arr = [0,0,_sizeX,0];
					};
					["relativeMove", _arr] call MEMBER("GuiObject", nil);
				};
				if (_ctrlPressing) then {
					_arr = [_sizeX/2,0,0,0];
				}else{
					_arr = [_sizeX,0,0,0];
				};
				["relativeMove", _arr] call MEMBER("GuiObject", nil);
			};

			case DIK_LEFTARROW:{
				if (_altPressing) exitWith {
					if (_ctrlPressing) then {
						_arr = [0,0,-_sizeX/2,0];
					}else{
						_arr = [0,0,-_sizeX,0];
					};
					_arr = [0,0,-_sizeX,0];
					["relativeMove", _arr] call MEMBER("GuiObject", nil);
				};
				if (_ctrlPressing) then {
					_arr = [-_sizeX/2,0,0,0];
				}else{
					_arr = [-_sizeX,0,0,0];
				};
				["relativeMove", _arr] call MEMBER("GuiObject", nil);
			};

			case DIK_ESCAPE : {
				closeDialog 0;	
			};

			case DIK_F2 : {
				if !(_workground isEqualTo _view) then {
					private _parent = "getParentLayer" call _workground;
					["setActiveLayer", _parent] call MEMBER("GuiObject", nil);
				};
			};
			case DIK_ESCAPE : {
				false;
				closeDialog 0;	
			};
			default {}; 
			_noReturn;
		};
	};
ENDCLASS;
