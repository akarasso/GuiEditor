#include "..\oop.h"
#include "..\dik_macro.hpp"

CLASS("oo_GuiEditor")
	PUBLIC UI_VARIABLE("display", "Display");
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
		disableSerialization;
		if(createDialog "Empty") then {
			MEMBER("Display", (findDisplay 4500));

			MEMBER("Display", nil) displayAddEventHandler["KeyDown", format["['KeyDown', _this] call %1;", _code] ];

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
		disableSerialization;
		private _child = (findDisplay 4500) createDisplay "RscDisplayEmpty";
		MEMBER("DisplayCtrlCreate", _child);
		private _control = _child ctrlCreate["RscBackgroundGUIDark", -1];
		_control ctrlSetPosition [safezoneX+safezoneW*0.25, safezoneY+safezoneH*0.25, safezoneW*0.5, safezoneH*0.5];
		_control ctrlCommit 0;

		private _topBar = _child ctrlCreate["TopBar", -1];
		_topBar ctrlSetText "Create control on layer";
		_topBar ctrlSetPosition [safezoneX+safezoneW*0.25, safezoneY+safezoneH*0.25, safezoneW*0.5, safezoneH*0.02];
		_topBar ctrlCommit 0;

		private _listBox = _child ctrlCreate["OOP_Listbox", 10];
		_listBox ctrlSetPosition[
			safezoneX+safezoneW*0.3, safezoneY+safezoneH*0.3, safezoneW*0.4, safezoneH*0.4
		];
		_listBox ctrlCommit 0;

		{
			_listBox lbAdd _x;
			_listBox lbSetData[_forEachIndex, _x];
		} forEach OOP_GuiEditor_ListControl;

		private _closeBtn = _child ctrlCreate["OOP_Button", -1];
		_closeBtn ctrlSetText "Fermer";
		_closeBtn buttonSetAction format["%1 closeDisplay 1;", MEMBER("DisplayCtrlCreate", nil)];
		_closeBtn ctrlSetPosition [
			safezoneX+safezoneW*0.4, safezoneY+safezoneH*0.71, safezoneW*0.05, safezoneH*0.03
		];
		_closeBtn ctrlCommit 0;

		private _valideBtn = _child ctrlCreate["OOP_Button", -1];
		_valideBtn ctrlSetText "Valider";
		diag_log format["%1", _self];
		_valideBtn buttonSetAction format["'valideCtrlCreateDialog' call %1", _self];
		_valideBtn ctrlSetPosition [
			safezoneX+safezoneW*0.5, safezoneY+safezoneH*0.71, safezoneW*0.05, safezoneH*0.03
		];
		_valideBtn ctrlCommit 0;
	};

	PUBLIC FUNCTION("","cfgCtrlDialog") {
		disableSerialization;
		private _child = (findDisplay 4500) createDisplay "RscDisplayEmpty";
		MEMBER("DisplayCtrlCreate", _child);

		private _control = _child ctrlCreate["RscBackgroundGUIDark", -1];
		_control ctrlSetPosition [safezoneX+safezoneW*0.25, safezoneY+safezoneH*0.25, safezoneW*0.5, safezoneH*0.5];
		_control ctrlCommit 0;

		private _topBar = _child ctrlCreate["TopBar", -1];
		_topBar ctrlSetText "Config your control";
		_topBar ctrlSetPosition [safezoneX+safezoneW*0.25, safezoneY+safezoneH*0.25, safezoneW*0.5, safezoneH*0.02];
		_topBar ctrlCommit 0;
		
		private _helperControl = ["new", _child] call oo_HelperControl;

		["setPos", [safezoneX+safezoneW*0.35, safezoneY+safezoneH*0.30, safezoneH*0.02] ] call _helperControl;
		["setLineSpaceY", safezoneH*0.011 ] call _helperControl;

		["createTextInput", ["IDControl :", safezoneW*0.08, safezoneW*0.21, 10]] call _helperControl;
		["createTextInput", ["Text :", safezoneW*0.08, safezoneW*0.21, 10]] call _helperControl;
		["createTextInput", ["Background Color :", safezoneW*0.08, safezoneW*0.21, 30]] call _helperControl;
		["createTextInput", ["Text Color :", safezoneW*0.08, safezoneW*0.21, 40]] call _helperControl;
		["createTextInput", ["Foreground Color :", safezoneW*0.08, safezoneW*0.21, 50]] call _helperControl;
		["createTextInput", ["Tooltip :", safezoneW*0.08, safezoneW*0.21, 60]] call _helperControl;
		["createTextInput", ["Tooltip Color Box :", safezoneW*0.08, safezoneW*0.21, 70]] call _helperControl;
		["createTextInput", ["Tooltip Color Shade :", safezoneW*0.08, safezoneW*0.21, 80]] call _helperControl;
		["createTextInput", ["Tooltip Color Text :", safezoneW*0.08, safezoneW*0.21, 90]] call _helperControl;

		private _pos = "getPos" call _helperControl;
		_pos set[0, (_pos select 0)-0.12*safezoneW];
		["setPos", _pos] call _helperControl;

		["setMode", 1] call _helperControl;
		["setLineSpaceX", 0] call _helperControl;

		["createTextCheckbox", ["Action", safezoneW*0.12, safezoneW*0.015, 100, false]] call _helperControl;
		["createTextCheckbox", ["Init", safezoneW*0.12, safezoneW*0.015, 110, false]] call _helperControl;
		["createTextCheckbox", ["onKeyDown", safezoneW*0.12, safezoneW*0.015, 110, false]] call _helperControl;
		["createTextCheckbox", ["onKeyDown", safezoneW*0.12, safezoneW*0.015, 110, false]] call _helperControl;

		"breakLine" call _helperControl;
		["createTextCheckbox", ["onMouseButtonDown", safezoneW*0.12, safezoneW*0.015, 110, false]] call _helperControl;
		["createTextCheckbox", ["onMouseButtonUp", safezoneW*0.12, safezoneW*0.015, 110, false]] call _helperControl;
		["createTextCheckbox", ["onMouseButtonClick ", safezoneW*0.12, safezoneW*0.015, 110, false]] call _helperControl;
		["createTextCheckbox", ["onMouseButtonDblClick ", safezoneW*0.12, safezoneW*0.015, 110, false]] call _helperControl;

		"breakLine" call _helperControl;
		["createTextCheckbox", ["onMouseMoving", safezoneW*0.12, safezoneW*0.015, 110, false]] call _helperControl;
		["createTextCheckbox", ["onMouseHolding", safezoneW*0.12, safezoneW*0.015, 110, false]] call _helperControl;
		["createTextCheckbox", ["onMouseButtonDblClick", safezoneW*0.12, safezoneW*0.015, 110, false]] call _helperControl;
		["createTextCheckbox", ["onMouseZChanged", safezoneW*0.12, safezoneW*0.015, 110, false]] call _helperControl;

		"breakLine" call _helperControl;
		["createTextCheckbox", ["onDestroy", safezoneW*0.12, safezoneW*0.015, 100, false]] call _helperControl;
		["createTextCheckbox", ["onButtonClick", safezoneW*0.12, safezoneW*0.015, 100, false]] call _helperControl;
		["createTextCheckbox", ["onButtonDblClick", safezoneW*0.12, safezoneW*0.015, 100, false]] call _helperControl;
		["createTextCheckbox", ["onButtonDown", safezoneW*0.12, safezoneW*0.015, 110, false]] call _helperControl;

		"breakLine" call _helperControl;
		["createTextCheckbox", ["onButtonUp", safezoneW*0.12, safezoneW*0.015, 100, false]] call _helperControl;
		["createTextCheckbox", ["onLBSelChanged", safezoneW*0.12, safezoneW*0.015, 100, false]] call _helperControl;
		["createTextCheckbox", ["onLBListSelChanged", safezoneW*0.12, safezoneW*0.015, 100, false]] call _helperControl;
		["createTextCheckbox", ["onLBDblClick:", safezoneW*0.12, safezoneW*0.015, 110, false]] call _helperControl;

		"breakLine" call _helperControl;
		["createTextCheckbox", ["onLBDrag", safezoneW*0.12, safezoneW*0.015, 100, false]] call _helperControl;
		["createTextCheckbox", ["onLBDragging", safezoneW*0.12, safezoneW*0.015, 100, false]] call _helperControl;
		["createTextCheckbox", ["onLBDrop", safezoneW*0.12, safezoneW*0.015, 100, false]] call _helperControl;
		["createTextCheckbox", ["onTreeSelChanged:", safezoneW*0.12, safezoneW*0.015, 110, false]] call _helperControl;
		["createTextCheckbox", ["onTreeLButtonDown:", safezoneW*0.12, safezoneW*0.015, 110, false]] call _helperControl;
		["createTextCheckbox", ["onTreeDblClick:", safezoneW*0.12, safezoneW*0.015, 110, false]] call _helperControl;
		["createTextCheckbox", ["onTreeExpanded:", safezoneW*0.12, safezoneW*0.015, 110, false]] call _helperControl;
		["createTextCheckbox", ["onTreeCollapsed:", safezoneW*0.12, safezoneW*0.015, 110, false]] call _helperControl;
		["createTextCheckbox", ["onTreeMouseMove:", safezoneW*0.12, safezoneW*0.015, 110, false]] call _helperControl;
		["createTextCheckbox", ["onTreeMouseHold:", safezoneW*0.12, safezoneW*0.015, 110, false]] call _helperControl;
		["createTextCheckbox", ["onTreeMouseExit:", safezoneW*0.12, safezoneW*0.015, 110, false]] call _helperControl;
		["createTextCheckbox", ["onToolBoxSelChanged:", safezoneW*0.12, safezoneW*0.015, 110, false]] call _helperControl;
		["createTextCheckbox", ["onChecked:", safezoneW*0.12, safezoneW*0.015, 110, false]] call _helperControl;
		["createTextCheckbox", ["onCheckedChanged:", safezoneW*0.12, safezoneW*0.015, 110, false]] call _helperControl;
		["createTextCheckbox", ["onCheckBoxesSelChanged:", safezoneW*0.12, safezoneW*0.015, 110, false]] call _helperControl;
		["createTextCheckbox", ["onTreeMouseExit:", safezoneW*0.12, safezoneW*0.015, 110, false]] call _helperControl;
		/*//Action
		private _actionLabel = _child ctrlCreate["OOP_TextRight", -1];
		_actionLabel ctrlSetText "Action :";
		_actionLabel ctrlSetPosition [safezoneX+safezoneW*0.28, safezoneY+safezoneH*0.45, safezoneW*0.08, safezoneH*0.02];
		_actionLabel ctrlCommit 0;
		private _actionInput = _child ctrlCreate["OOP_Edit", 60];
		_actionInput ctrlSetText ("getAction" call MEMBER("selCtrl", nil));
		_actionInput ctrlSetPosition [safezoneX+safezoneW*0.37, safezoneY+safezoneH*0.45, safezoneW*0.21, safezoneH*0.02];
		_actionInput ctrlCommit 0;*/

		private _closeBtn = _child ctrlCreate["OOP_Button", -1];
		_closeBtn ctrlSetText "Fermer";
		_closeBtn buttonSetAction "closeDialog 0;";
		_closeBtn ctrlSetPosition [
			safezoneX+safezoneW*0.4, safezoneY+safezoneH*0.71, safezoneW*0.05, safezoneH*0.03
		];
		_closeBtn ctrlCommit 0;

		private _valideBtn = _child ctrlCreate["OOP_Button", -1];
		_valideBtn ctrlSetText "Valider";
		_valideBtn buttonSetAction format["'valideCfgCtrlDialog' call %1", _self];
		_valideBtn ctrlSetPosition [
			safezoneX+safezoneW*0.5, safezoneY+safezoneH*0.71, safezoneW*0.05, safezoneH*0.03
		];
		_valideBtn ctrlCommit 0;
	};

	PUBLIC FUNCTION("","valideCfgCtrlDialog") {
		disableSerialization;
		private _idc = parseNumber ( ctrlText ((findDisplay -1) displayCtrl 10));

		private _bgColor = call compile format["%1", ctrlText ((findDisplay -1) displayCtrl 30) ];
		if ((typeName _bgColor) != "ARRAY") then { _bgColor = [-1,-1,-1,-1]; };

		private _textColor = call compile format["%1", ctrlText ((findDisplay -1) displayCtrl 40) ];
		if ((typeName _textColor) != "ARRAY") then { _textColor = [-1,-1,-1,-1]; };

		private _fgColor = call compile format["%1", ctrlText ((findDisplay -1) displayCtrl 50) ];
		if ((typeName _fgColor) != "ARRAY") then { _fgColor = [-1,-1,-1,-1]; };

		private _tlColorBox = call compile format["%1", ctrlText ((findDisplay -1) displayCtrl 70) ];
		if ((typeName _tlColorBox) != "ARRAY") then { _tlColorBox = [-1,-1,-1,-1]; };

		private _tlColorShade = call compile format["%1", ctrlText ((findDisplay -1) displayCtrl 70) ];
		if ((typeName _tlColorShade) != "ARRAY") then { _tlColorShade = [-1,-1,-1,-1]; };

		private _tlColorText = call compile format["%1", ctrlText ((findDisplay -1) displayCtrl 70) ];
		if ((typeName _tlColorText) != "ARRAY") then { _tlColorText = [-1,-1,-1,-1]; };
			
		if (_idc isEqualTo "") then { _idc = -1; };
		//IDC
		["setID", _idc] call MEMBER("selCtrl", nil);
		//TEXT
		["setText", (ctrlText ((findDisplay -1) displayCtrl 20))] call MEMBER("selCtrl", nil);
		//BGCOLOR
		["setBGColor", _bgColor] call MEMBER("selCtrl", nil);
		//TEXTCOLOR
		["setTextColor", _textColor] call MEMBER("selCtrl", nil);
		//FOREGROUND COLOR
		["setFGColor", _fgColor] call MEMBER("selCtrl", nil);
		//ACTION
		["setAction", (ctrlText ((findDisplay -1) displayCtrl 60))] call MEMBER("selCtrl", nil);
		//Tooltip
		["setTooltip", (ctrlText ((findDisplay -1) displayCtrl 70))] call MEMBER("selCtrl", nil);
		// Tooltip color box
		["setTooltipColorBox", _tlColorBox] call MEMBER("selCtrl", nil);
		//ctrlSetTooltipColorShade
		["setTooltipColorShade", _tlColorShade] call MEMBER("selCtrl", nil);
		//ctrlSetTooltipColorText
		["setTooltipColorText", _tlColorText] call MEMBER("selCtrl", nil);

		["setAction", _action] call MEMBER("selCtrl", nil);
		["setDefaultStatus", _status] call MEMBER("selCtrl", nil);

		closeDialog 0;
	};

	PUBLIC FUNCTION("","valideCtrlCreateDialog") {
		disableSerialization;
		private _listBox = (findDisplay -1) displayCtrl 10;
		private _s = _listBox lbData (lbCurSel _listBox);
		MEMBER("ctrlCreate", _s);
		closeDialog 0;
	};

	PUBLIC FUNCTION("string","ctrlCreate") {
		private _arr = [_this, -1];
		MEMBER("ctrlCreate", _arr);
	};

	PUBLIC FUNCTION("array","ctrlCreate") {
		disableSerialization;
		private _type = param[0, "NoType",[""]];
		private _idc = param[1, -1,[0]];
		if (_type isEqualTo "NoType") exitWith { diag_log "No Type ctrlCreate";	};
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

		MEMBER("CtrlPressing", _ctrl);
		MEMBER("AltPressing", _alt);

		private _size = "getSize" call MEMBER("GridObject", nil);
		
		private _sizeX = safezoneW/(_size select 0);
		private _sizeY = safezoneH/(_size select 1);

		switch (_DikCode) do { 
			case DIK_F1:{
				//Implement help
			};

			case DIK_SPACE:{
				"colorize" call MEMBER("Workground", nil);
			};
			case DIK_C:{
				if (MEMBER("selCtrl", nil) isEqualTo {}) then {
					private _res = ["findFirstAtPos", MEMBER("MousePos", nil)] call MEMBER("Workground", nil);
					if !(_res isEqualTo {}) then {
						MEMBER("selCtrl", _res);
					};
				};
				MEMBER("centerH", nil);
			};
			case DIK_V:{
				if (MEMBER("selCtrl", nil) isEqualTo {}) then {
					private _res = ["findFirstAtPos", MEMBER("MousePos", nil)] call MEMBER("Workground", nil);
					if !(_res isEqualTo {}) then {
						MEMBER("selCtrl", _res);
					};
				};
				MEMBER("centerV", nil);
			};
			case DIK_END:{

			};	
			case DIK_DOWNARROW:{
				if (MEMBER("AltPressing", nil)) exitWith {
					if (MEMBER("CtrlPressing", nil)) then {
						_arr = [0,0,0,_sizeY/2];
					}else{
						_arr = [0,0,0,_sizeY];
					};
					MEMBER("relativeMove", _arr);
				};
				if (MEMBER("CtrlPressing", nil)) then {
					_arr = [0,_sizeY/2,0,0];
				}else{
					_arr = [0,_sizeY,0,0];
				};
				MEMBER("relativeMove", _arr);
			};
			case DIK_UPARROW:{
				if (MEMBER("AltPressing", nil)) exitWith {
					if (MEMBER("CtrlPressing", nil)) then {
						_arr = [0,0,0,-_sizeY/2];
					}else{
						_arr = [0,0,0,-_sizeY];
					};
					MEMBER("relativeMove", _arr);
				};
				if (MEMBER("CtrlPressing", nil)) then {
					_arr = [0,-_sizeY,0,0];
				}else{
					_arr = [0,-_sizeY,0,0];
				};
				MEMBER("relativeMove", _arr);
			};
			case DIK_RIGHTARROW:{
				if (MEMBER("AltPressing", nil)) exitWith {
					if (MEMBER("CtrlPressing", nil)) then {
						_arr = [0,0,_sizeX/2,0];
					}else{
						_arr = [0,0,_sizeX,0];
					};
					MEMBER("relativeMove", _arr);
				};
				if (MEMBER("CtrlPressing", nil)) then {
					_arr = [_sizeX/2,0,0,0];
				}else{
					_arr = [_sizeX,0,0,0];
				};
				MEMBER("relativeMove", _arr);
			};

			case DIK_LEFTARROW:{
				if (MEMBER("AltPressing", nil)) exitWith {
					if (MEMBER("CtrlPressing", nil)) then {
						_arr = [0,0,-_sizeX/2,0];
					}else{
						_arr = [0,0,-_sizeX,0];
					};
					_arr = [0,0,-_sizeX,0];
					MEMBER("relativeMove", _arr);
				};
				if (MEMBER("CtrlPressing", nil)) then {
					_arr = [-_sizeX/2,0,0,0];
				}else{
					_arr = [-_sizeX,0,0,0];
				};
				MEMBER("relativeMove", _arr);
			};

			case DIK_ESCAPE : {
				if (MEMBER("Workground", nil) isEqualTo MEMBER("View", nil)) then {
					diag_log "Close editor";
					closeDialog 0;	
				}else{
					private _parent = "getParentLayer" call MEMBER("Workground", nil);
					diag_log format["Parent:%1", _parent];
					MEMBER("setActiveLayer", _parent);

				};
			};

			case DIK_F2 : {
				private _parent = "getParentLayer" call MEMBER("Workground", nil);
				diag_log format["Parent:%1", _parent];
				MEMBER("setActiveLayer", _parent);	
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
