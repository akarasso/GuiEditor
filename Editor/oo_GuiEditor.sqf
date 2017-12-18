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
	
	PUBLIC VARIABLE("code", "GridObject");

	PUBLIC FUNCTION("","constructor") {
		MEMBER("Workground", {});		
		MEMBER("selCtrl", {});

		private _guiHelperDialog = ["new", _code] call oo_GuiEditorDialog;
		MEMBER("GuiHelperDialog", _guiHelperDialog);

		disableSerialization;
		if(createDialog "Empty") then {
			MEMBER("Display", (findDisplay 4500));

			private _event = ["new", _self] call oo_GuiEditorEvent;
			MEMBER("GuiHelperEvent", _event);
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
			_clickPos = "getMouseClick" call MEMBER("GuiHelperEvent", nil);
			["setPos", _clickPos] call _newInstance;
			["ctrlEnable", false] call _newInstance;
			["pushChild", _newInstance] call MEMBER("Workground", nil);
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
	PUBLIC FUNCTION("","getSelCtrl") { MEMBER("selCtrl", nil); };
	PUBLIC FUNCTION("","getDisplay") { MEMBER("Display", nil); };
	PUBLIC FUNCTION("","getView") { MEMBER("View", nil); };
	PUBLIC FUNCTION("","getDeltaPosClick") { MEMBER("DeltaPosClick", nil); };
	PUBLIC FUNCTION("","getWorkground") { MEMBER("Workground", nil); };
	PUBLIC FUNCTION("","getGuiHelperEvent") { MEMBER("GuiHelperEvent", nil); };

	PUBLIC FUNCTION("code","setSelCtrl") { MEMBER("selCtrl", _this); };
ENDCLASS;
