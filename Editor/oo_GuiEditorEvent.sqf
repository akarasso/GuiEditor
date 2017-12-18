#include "..\oop.h"
#include "..\dik_macro.hpp"

CLASS("oo_GuiEditorEvent")
	PUBLIC VARIABLE("code","GuiObject");

	PUBLIC VARIABLE("bool", "LBPressing");
	PUBLIC VARIABLE("bool", "AltPressing");
	PUBLIC VARIABLE("bool", "CtrlPressing");
	PUBLIC VARIABLE("array", "MousePos");
	PUBLIC VARIABLE("array", "MouseClick");
	PUBLIC VARIABLE("array", "DeltaPosClick");


	PUBLIC FUNCTION("code","constructor") { 
		MEMBER("GuiObject", _this);

		MEMBER("LBPressing", false);
		MEMBER("AltPressing", false);
		MEMBER("CtrlPressing", false);

		MEMBER("MousePos", []);
		MEMBER("MouseClick", []);
		MEMBER("DeltaPosClick", []);

		("getDisplay" call _this) displayAddEventHandler["KeyDown", format["['KeyDown', _this] call %1;", _code] ];
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

		private _gridObject = "getGridObject" call MEMBER("GuiObject", nil);
		private _workground = "getWorkground" call MEMBER("GuiObject", nil);
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
					private _res = ["findFirstAtPos", MEMBER("MousePos", nil)] call _workground;
					if !(_res isEqualTo {}) then {
						["setSelCtrl", _res] call MEMBER("GuiObject", nil);
					};
				};
				"centerH" call MEMBER("GuiObject", nil);
			};
			case DIK_V:{
				hint "press";
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
			//Sticky move
			if !(MEMBER("CtrlPressing", nil)) then {
				private _gridObject = "getGridObject" call MEMBER("GuiObject", nil);
				private _size = "getSize" call _gridObject;
				private _modX = safezoneW/(_size select 0);
				private _modY = safezoneH/(_size select 1);
				if (MEMBER("AltPressing", nil)) exitWith {
					private _newPos = [
						(_pos select 0),
						(_pos select 1),
						(MEMBER("MousePos", nil) select 0) - ((MEMBER("MousePos", nil) select 0) % _modX) - (_pos select 0),
						(MEMBER("MousePos", nil) select 1) - ((MEMBER("MousePos", nil) select 1) % _modY) - (_pos select 1)
					];
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

			//Static move
			if (MEMBER("CtrlPressing", nil)) then {
				if (MEMBER("AltPressing", nil)) exitWith {
					private _newPos = [
						_pos select 0,
						_pos select 1,
						(MEMBER("MousePos", nil) select 0) - (_pos select 0),
						(MEMBER("MousePos", nil) select 1) - (_pos select 1)
					];
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
	*/
	PUBLIC FUNCTION("array","MouseButtonDown") {
		private _ctrlClick = _this select 0;
		private _btn = _this select 1;

		private _workground = "getWorkground" call MEMBER("GuiObject", nil);
		private _posLayer = "getPos" call _workground;
		private _relativePos = [
			(_this select 2) - (_posLayer select 0), 
			(_this select 3) - (_posLayer select 1)
		];

		private _shift = _this select 4;
		private _ctrl = _this select 5;
		private _alt = _this select 6;

		MEMBER("MouseClick", _relativePos);
		private _res = ["findFirstAtPos", MEMBER("MouseClick", nil)] call _workground;

		if (_btn == 0) exitWith {			
			if !(_res isEqualTo {}) then {
				private _pos = "getPos" call _res;
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
			MEMBER("AltPressing", _alt);
			MEMBER("CtrlPressing", _ctrl);
		};
		if (_btn == 1) exitWith {

		};
	};

	/*
	*	Fonction de récupation de l'évent handler MouseButtonUp cf arma...
	*/
	PUBLIC FUNCTION("array","MouseButtonUp") {
		private _ctrlClick = _this select 0;
		private _btn = _this select 1;

		private _workground = "getWorkground" call MEMBER("GuiObject", nil);
		private _posLayer = "getPos" call _workground;
		private _relativePos = [
			(_this select 2) - (_posLayer select 0), 
			(_this select 3) - (_posLayer select 1)
		];

		private _shift = _this select 4;
		private _ctrl = _this select 5;
		private _alt = _this select 6;

		MEMBER("MouseClick", _relativePos);
		private _res = ["findFirstAtPos", MEMBER("MouseClick", nil)] call _workground;

		if (_btn == 0) exitWith {
			MEMBER("LBPressing", false);
			MEMBER("AltPressing", _alt);
			MEMBER("CtrlPressing", _ctrl);
		};

		if (_btn == 1) exitWith {
			if !(_res isEqualTo {}) then {
				["setSelCtrl", _res] call MEMBER("GuiObject", nil);
				"cfgCtrlDialog" call MEMBER("GuiObject", nil);
			}else{
				"ctrlCreateDialog" call MEMBER("GuiObject", nil);
			};
		};
	};

	PUBLIC FUNCTION("array","MouseButtonDblClick") {
		private _ctrlClick = _this select 0;
		private _btn = _this select 1;
		private _posLayer = "getPos" call MEMBER("Workground", nil);
		private _relativePos = [
			(_this select 2) - (_posLayer select 0), 
			(_this select 3) - (_posLayer select 1)
		];
		private _shift = _this select 4;
		private _ctrl = _this select 5;
		private _alt = _this select 6;

		MEMBER("MouseClick", _relativePos);
		private _workground = "getWorkground" call MEMBER("GuiObject", nil);
		private _res = ["findFirstAtPos", MEMBER("MouseClick", nil)] call _workground;

		if (_btn == 0) exitWith {
			if !(_res isEqualTo {}) then {
				if (("getTypeName" call _res) isEqualTo "oo_Layer") then {
					["setActiveLayer", _res] call MEMBER("GuiObject", nil);
				};
			};
		};
	};

	PUBLIC FUNCTION("","getCtrlPressing") { MEMBER("CtrlPressing", nil); };
	PUBLIC FUNCTION("","getAltPressing") { MEMBER("AltPressing", nil); };
	PUBLIC FUNCTION("","getLBPressing") { MEMBER("LBPressing", nil); };
	PUBLIC FUNCTION("","getMousePos") { MEMBER("MousePos", nil); };
	PUBLIC FUNCTION("","getMouseClick") { MEMBER("MouseClick", nil); };

ENDCLASS;
