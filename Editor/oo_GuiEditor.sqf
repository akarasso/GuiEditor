#include "..\oop.h"
#include "..\dik_macro.hpp"

CLASS("oo_GuiEditor")
	PUBLIC UI_VARIABLE("display", "Display");
	PUBLIC VARIABLE("code", "GuiHelperDialog");
	PUBLIC VARIABLE("code", "GuiHelperEvent");
	PUBLIC UI_VARIABLE("code", "View");
	PUBLIC UI_VARIABLE("display", "DisplayCtrlCreate");

	PUBLIC VARIABLE("code", "Workground");
	PUBLIC VARIABLE("code", "selCtrl");
	PUBLIC VARIABLE("array", "MousePos");
	PUBLIC VARIABLE("array", "MouseClick");
	PUBLIC VARIABLE("array", "DeltaPosClick");

	PUBLIC VARIABLE("bool", "LBPressing");
	PUBLIC VARIABLE("bool", "AltPressing");
	PUBLIC VARIABLE("bool", "CtrlPressing");
	PUBLIC VARIABLE("code", "GridObject");

	PUBLIC FUNCTION("","constructor") {
		MEMBER("Workground", {});
		MEMBER("MousePos", []);
		MEMBER("MouseClick", []);
		MEMBER("DeltaPosClick", []);
		MEMBER("LBPressing", false);
		MEMBER("AltPressing", false);
		MEMBER("CtrlPressing", false);
		MEMBER("selCtrl", {});

		private _guiHelperDialog = ["new", _code] call oo_HelperGuiEditorDialog;
		MEMBER("GuiHelperDialog", _guiHelperDialog);

		disableSerialization;
		if(createDialog "Empty") then {
			MEMBER("Display", (findDisplay 4500));

			private _event = ["new", _self] call oo_HelperGuiEditorEvent;

			private _GRID = "new" call oo_GRIDLayer;
			MEMBER("GridObject", _GRID);
			private _GRIDLayer = ["createGridLayer", MEMBER("Display", nil)] call _GRID;
			"genGrid" call _GRID;

			private _VIEW = ["new", _code] call oo_Layer;
			MEMBER("View", _VIEW);
			["createLayer", [MEMBER("Display", nil), {}]] call _VIEW;
			["setPos", [safezoneX, safezoneY, safezoneW, safezoneH]] call MEMBER("View", nil);
			MEMBER("setActiveLayer", _VIEW);
		};
	};

	PUBLIC FUNCTION("","ctrlCreateDialog") {
		"openCtrlCreateDialog" call MEMBER("GuiHelperDialog", nil);
	};
	PUBLIC FUNCTION("","cfgCtrlDialog") {
		"openCfgCtrlDialog" call MEMBER("GuiHelperDialog", nil);
	};

	PUBLIC FUNCTION("string","ctrlCreate") {
		private _arr = [_this, -1];
		MEMBER("ctrlCreate", _arr);
	};

	PUBLIC FUNCTION("array","ctrlCreate") {
		disableSerialization;
		private _type = param[0, "NoType",[""]];
		private _idc = param[1, -1,[0]];
		if (_type isEqualTo "NoType") exitWith { hint "No Type ctrlCreate";	};
		private _layer = "getLayer" call MEMBER("Workground", nil);
		private _newCtrl = MEMBER("Display", nil) ctrlCreate[_type, _idc, _layer];
		if (ctrlType _newCtrl == 15) then {
			private _newInstance = ["new", _self] call oo_Layer;
			["setLayer", [MEMBER("Display", nil), MEMBER("Workground", nil), _newCtrl]] call _newInstance;
			private _parentPos = "getPos" call MEMBER("Workground", nil);
			["setPos", [MEMBER("MouseClick", nil) select 0, MEMBER("MouseClick", nil) select 1, (_parentPos select 2)/2,(_parentPos select 3)/2 ]] call _newInstance;
			["pushChild", _newInstance] call MEMBER("Workground", nil);
			MEMBER("RefreshAllBoundBox", nil);
		}else{
			_newInstance = ["new", [MEMBER("Workground", nil), _newCtrl, _type]] call oo_Control;
			["setPos", MEMBER("MouseClick", nil)] call _newInstance;
			["ctrlEnable", false] call _newInstance;
			["pushChild", _newInstance] call MEMBER("Workground", nil);
		};		
	};

	/*
	*	Fonction gérant la positions des éléments dans le gui
	*	@input:array input from EventHandler MouseMoving see: https://community.bistudio.com/wiki/User_Interface_Event_Handlers
	*/
	PUBLIC FUNCTION("array","MouseMoving") {
		private _pos = "getPos" call MEMBER("Workground", nil);
		private _relativePos = [
			(_this select 1) - (_pos select 0), 
			(_this select 2) - (_pos select 1)
		];
		MEMBER("MousePos", _relativePos);
		if (!(MEMBER("selCtrl", nil) isEqualTo {}) && MEMBER("LBPressing", nil)) then {
			private _pos = "getPos" call MEMBER("selCtrl", nil);
			private _delta = MEMBER("DeltaPosClick", nil);
			//Sticky move
			if !(MEMBER("CtrlPressing", nil)) then {
				private _size = "getSize" call MEMBER("GridObject", nil);
				private _modX = safezoneW/(_size select 0);
				private _modY = safezoneH/(_size select 1);
				if (MEMBER("AltPressing", nil)) exitWith {
					private _newPos = [
						(_pos select 0),
						(_pos select 1),
						(MEMBER("MousePos", nil) select 0) - ((MEMBER("MousePos", nil) select 0) % _modX) - (_pos select 0),
						(MEMBER("MousePos", nil) select 1) - ((MEMBER("MousePos", nil) select 1) % _modY) - (_pos select 1)
					];
					["setPos", _newPos] call MEMBER("selCtrl", nil);
				};
				private _newPos = [
					(MEMBER("MousePos", nil) select 0) - ((MEMBER("MousePos", nil) select 0) % _modX) - ((_delta select 0) - ((_delta select 0) % _modX)),
					(MEMBER("MousePos", nil) select 1) - ((MEMBER("MousePos", nil) select 1) % _modY) - ((_delta select 1) - ((_delta select 1) % _modY)),
					(_pos select 2),
					(_pos select 3)
				];
				["setPos", _newPos] call MEMBER("selCtrl", nil);
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
					["setPos", _newPos] call MEMBER("selCtrl", nil);
				};
				if (MEMBER("CtrlPressing", nil)) exitWith {
					private _newPos = [
						(MEMBER("MousePos", nil) select 0) - (_delta select 0), 
						(MEMBER("MousePos", nil) select 1) - (_delta select 1),
						_pos select 2,
						_pos select 3
					];
					["setPos", _newPos] call MEMBER("selCtrl", nil);
				};				
			};
		};
	};

	/*
	* 	Fonction qui définit quel layer est éditable
	* 	@input:code Class du futur layer a éditer
	*/
	PUBLIC FUNCTION("code","setActiveLayer") {
		["layerEnable", false] call MEMBER("Workground", nil);
		MEMBER("Workground", _this);
		["layerEnable", true] call MEMBER("Workground", nil);
		MEMBER("RefreshAllBoundBox", nil);
	};

	//setColorBoundBox _instance, couleur du parent, couleur du layer selectionne, couleur de l'enfant
	PUBLIC FUNCTION("","RefreshAllBoundBox") {
		["RefreshBoundBox", [MEMBER("Workground", nil), [1,0,0,1], [0,1,0,1], [0,0,1,1],  true]] call MEMBER("View", nil);
	};

	/*
	*	Fonction de récupation de l'évent handler MouseButtonDown cf arma...
	*/
	PUBLIC FUNCTION("array","MouseButtonDown") {
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
		private _res = ["findFirstAtPos", MEMBER("MouseClick", nil)] call MEMBER("Workground", nil);

		if (_btn == 0) exitWith {			
			if !(_res isEqualTo {}) then {
				hint format["FIND:%1", random 10000];
				private _pos = "getPos" call _res;
				private _a = [
					(MEMBER("MouseClick", nil) select 0) - (_pos select 0),
					(MEMBER("MouseClick", nil) select 1) - (_pos select 1)
				];
				MEMBER("DeltaPosClick", _a);
				MEMBER("selCtrl", _res);			
			}else{
				MEMBER("selCtrl", {});
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

		private _posLayer = "getPos" call MEMBER("Workground", nil);
		private _relativePos = [
			(_this select 2) - (_posLayer select 0), 
			(_this select 3) - (_posLayer select 1)
		];

		private _shift = _this select 4;
		private _ctrl = _this select 5;
		private _alt = _this select 6;

		MEMBER("MouseClick", _relativePos);
		private _res = ["findFirstAtPos", MEMBER("MouseClick", nil)] call MEMBER("Workground", nil);

		if (_btn == 0) exitWith {
			MEMBER("LBPressing", false);
			MEMBER("AltPressing", _alt);
			MEMBER("CtrlPressing", _ctrl);
		};

		if (_btn == 1) exitWith {
			if !(_res isEqualTo {}) then {
				MEMBER("selCtrl", _res);
				MEMBER("cfgCtrlDialog", nil);
			}else{
				MEMBER("ctrlCreateDialog", nil);
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
		private _res = ["findFirstAtPos", MEMBER("MouseClick", nil)] call MEMBER("Workground", nil);

		if (_btn == 0) exitWith {
			if !(_res isEqualTo {}) then {
				if (("getTypeName" call _res) isEqualTo "oo_Layer") then {
					MEMBER("setActiveLayer", _res);
				};
			};
		};
	};

	/*
	*	Fonction effectuant un déplacement au control relatif à son origine
	*/
	PUBLIC FUNCTION("array","relativeMove") {
		if !(MEMBER("selCtrl", nil) isEqualTo {}) then {
			private _pos = "getPos" call MEMBER("selCtrl", nil);
			private _npos = [
				(_pos select 0) + (_this select 0),
				(_pos select 1) + (_this select 1),
				(_pos select 2) + (_this select 2),
				(_pos select 3) + (_this select 3)
			];
			["setPos", _npos] call MEMBER("selCtrl", nil);
		};
	};

	PUBLIC FUNCTION("","centerH") {
		private _parentPos = "getPos" call MEMBER("Workground", nil);
		private _pos = "getPos" call MEMBER("selCtrl", nil);
		private _npos = [
			((_parentPos select 2)/2) - (_pos select 2)/2,
			_pos select 1,
			_pos select 2,
			_pos select 3
		];
		["setPos", _npos] call MEMBER("selCtrl", nil);
	};

	PUBLIC FUNCTION("","centerV") {
		private _parentPos = "getPos" call MEMBER("Workground", nil);
		private _pos = "getPos" call MEMBER("selCtrl", nil);
		private _npos = [
			_pos select 0,
			((_parentPos select 3)/2) - (_pos select 3)/2,
			_pos select 2,
			_pos select 3
		];
		["setPos", _npos] call MEMBER("selCtrl", nil);
	};


	PUBLIC FUNCTION("","getGridObject") { MEMBER("GridObject", nil); };
	PUBLIC FUNCTION("","getCtrlPressing") { MEMBER("CtrlPressing", nil); };
	PUBLIC FUNCTION("","getAltPressing") { MEMBER("AltPressing", nil); };
	PUBLIC FUNCTION("","getLBPressing") { MEMBER("LBPressing", nil); };
	PUBLIC FUNCTION("","getSelCtrl") { MEMBER("selCtrl", nil); };
	PUBLIC FUNCTION("","getDisplay") { MEMBER("Display", nil); };
	PUBLIC FUNCTION("","getView") { MEMBER("View", nil); };
	PUBLIC FUNCTION("","getMousePos") { MEMBER("MousePos", nil); };
	PUBLIC FUNCTION("","getMouseClick") { MEMBER("MouseClick", nil); };
	PUBLIC FUNCTION("","getDeltaPosClick") { MEMBER("DeltaPosClick", nil); };
	PUBLIC FUNCTION("","getWorkground") { MEMBER("Workground", nil); };
	PUBLIC FUNCTION("","getGuiHelperEvent") { MEMBER("GuiHelperEvent", nil); };

	PUBLIC FUNCTION("code","setSelCtrl") { MEMBER("selCtrl", _this); };
ENDCLASS;
