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
	PUBLIC VARIABLE("code", "HPPMaker");
	PUBLIC VARIABLE("scalar", "Index");
	PUBLIC VARIABLE("scalar", "IDD");
	PUBLIC VARIABLE("string", "DisplayName");
	

	PUBLIC FUNCTION("","constructor") {
		MEMBER("Workground", {});		
		MEMBER("selCtrl", {});
		MEMBER("Index", 1);
		MEMBER("DisplayName", "NewDialog");
		MEMBER("IDD", 1000);
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
			["setNewID", MEMBER("getNewID", nil)] call _VIEW;
			["setPos", [safezoneX, safezoneY, safezoneW, safezoneH]] call MEMBER("View", nil);
			MEMBER("setActiveLayer", _VIEW);

			private _hppMaker = ["new", "dialog.hpp"] call oo_makeFile;
			MEMBER("HPPMaker", _hppMaker);
		};
	};

	PUBLIC FUNCTION("","showTreeDialog") {
		DEBUG(#, "oo_GuiEditor::ctrlCreateDialog")
		disableSerialization;
		private _tree = MEMBER("Display", nil) ctrlCreate["OOP_Tree",-2, "getLayer" call MEMBER("View", nil)];
		_tree ctrlSetPosition [0,0, safezoneW/5, safezoneH];
		_tree ctrlCommit 0;

		_tree tvAdd [[], MEMBER("DisplayName", nil)];
		private _path = [0];
		["fillDisplayTree", [_tree, _path]] call MEMBER("View", nil);
	};

	PUBLIC FUNCTION("","ctrlCreateDialog") {
		"openCtrlCreateDialog" call MEMBER("GuiHelperDialog", nil);
	};

	PUBLIC FUNCTION("","cfgCtrlDialog") {
		"openCfgCtrlDialog" call MEMBER("GuiHelperDialog", nil);
	};

	PUBLIC FUNCTION("","openGeneralCfg") {
		"openGeneralCfgDialog" call MEMBER("GuiHelperDialog", nil);
	};

	PUBLIC FUNCTION("string","ctrlCreate") {
		DEBUG(#, "oo_GuiEditor::ctrlCreate::array")
		disableSerialization;
		if (_this isEqualTo "NoType") exitWith { hint "No Type ctrlCreate";	};
		private _layer = "getLayer" call MEMBER("Workground", nil);
		private _newId = MEMBER("getNewID", nil);
		private _newCtrl = MEMBER("Display", nil) ctrlCreate[_this, _newId, _layer];
		//Layer
		if (ctrlType _newCtrl == 15) then {
			private _newInstance = ["new", _self] call oo_Layer;
			["setID", _newId] call _newInstance;
			_clickPos = "getMouseClick" call MEMBER("GuiHelperEvent", nil);
			["setLayer", [MEMBER("Display", nil), MEMBER("Workground", nil), _newCtrl]] call _newInstance;
			private _parentPos = "getPos" call MEMBER("Workground", nil);
			["setPos", [_clickPos select 0, _clickPos select 1, (_parentPos select 2)/2,(_parentPos select 3)/2 ]] call _newInstance;
			["pushChild", _newInstance] call MEMBER("Workground", nil);
			MEMBER("RefreshAllBoundBox", nil);
		}else{
			_newInstance = ["new", [MEMBER("Workground", nil), _newCtrl, _this]] call oo_Control;
			["setID", _newId] call _newInstance;
			_clickPos = "getMouseClick" call MEMBER("GuiHelperEvent", nil);
			["setPos", _clickPos] call _newInstance;
			["ctrlEnable", false] call _newInstance;
			["pushChild", _newInstance] call MEMBER("Workground", nil);
		};		
	};

	PUBLIC FUNCTION("","getNewID") {
		private _used = MEMBER("isUsedID", MEMBER("Index", nil));
		while {_used} do {
			MEMBER("Index", MEMBER("Index", nil) + 1);
			_used = MEMBER("isUsedID", MEMBER("Index", nil));
		};
		MEMBER("Index", nil);
	};

	PUBLIC FUNCTION("scalar","isUsedID") {
		private _a = [_this, []];
		MEMBER("isUsedID", _a);
	};

	PUBLIC FUNCTION("array","isUsedID") {
		["isUsedID", _this] call MEMBER("View", nil);
	};

	/*
	* 	Fonction qui définit quel layer est éditable
	* 	@input:code Class du futur layer a éditer
	*/
	PUBLIC FUNCTION("code","setActiveLayer") {
		DEBUG(#, "oo_GuiEditor::setActiveLayer")
		["layerEnable", false] call MEMBER("Workground", nil);
		MEMBER("Workground", _this);
		["layerEnable", true] call MEMBER("Workground", nil);
		MEMBER("RefreshAllBoundBox", nil);
	};

	//setColorBoundBox _instance, couleur du parent, couleur du layer selectionne, couleur de l'enfant
	PUBLIC FUNCTION("","RefreshAllBoundBox") {
		DEBUG(#, "oo_GuiEditor::RefreshAllBoundBox")
		["RefreshBoundBox", [MEMBER("Workground", nil), [1,0,0,1], [0,1,0,1], [0,0,1,1],  true]] call MEMBER("View", nil);
	};

	/*
	*	Fonction effectuant un déplacement au control relatif à son origine
	*/
	PUBLIC FUNCTION("array","relativeMove") {
		DEBUG(#, "oo_GuiEditor::relativeMove")
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
		DEBUG(#, "oo_GuiEditor::centerH")
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
		DEBUG(#, "oo_GuiEditor::centerV")
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

	PUBLIC FUNCTION("","exportHPP") {
		["pushLine", format["class %1 {", MEMBER("DisplayName", nil)]] call MEMBER("HPPMaker", nil);
		["modTab", +1] call MEMBER("HPPMaker", nil);
			["pushLine", format["idd = %1;", MEMBER("IDD", nil)]] call MEMBER("HPPMaker", nil);
			["pushLine", format['name= "%1";', MEMBER("DisplayName", nil)]] call MEMBER("HPPMaker", nil);
			["pushLine", "movingEnable = false;"] call MEMBER("HPPMaker", nil);
			["pushLine", "enableSimulation = true;"] call MEMBER("HPPMaker", nil);
			["pushLine", "class controlsBackground {"] call MEMBER("HPPMaker", nil);
			["modTab", +1] call MEMBER("HPPMaker", nil);
				//Inject layer class
				["exportHPP", MEMBER("HPPMaker", nil)] call MEMBER("View", nil);
			//End inject
			["modTab", -1] call MEMBER("HPPMaker", nil);
			["pushLine", "};"] call MEMBER("HPPMaker", nil);
			["pushLine", "class controls {};"] call MEMBER("HPPMaker", nil);
			["modTab", -1] call MEMBER("HPPMaker", nil);
		["pushLine", "};"] call MEMBER("HPPMaker", nil);

		"exec" call MEMBER("HPPMaker", nil);
	};


	PUBLIC FUNCTION("","getGridObject") { MEMBER("GridObject", nil); };
	PUBLIC FUNCTION("","getSelCtrl") { MEMBER("selCtrl", nil); };
	PUBLIC FUNCTION("","getDisplay") { MEMBER("Display", nil); };
	PUBLIC FUNCTION("","getView") { MEMBER("View", nil); };
	PUBLIC FUNCTION("","getDeltaPosClick") { MEMBER("DeltaPosClick", nil); };
	PUBLIC FUNCTION("","getWorkground") { MEMBER("Workground", nil); };
	PUBLIC FUNCTION("","getGuiHelperEvent") { MEMBER("GuiHelperEvent", nil); };
	PUBLIC FUNCTION("","getDisplayName") {MEMBER("DisplayName", nil);};
	PUBLIC FUNCTION("","getIDD") { MEMBER("IDD", nil); };

	PUBLIC FUNCTION("string","setDisplayName") { MEMBER("DisplayName", _this); };
	PUBLIC FUNCTION("scalar","setIDD") {MEMBER("IDD", _this)};
	PUBLIC FUNCTION("code","setSelCtrl") { MEMBER("selCtrl", _this); };
ENDCLASS;
