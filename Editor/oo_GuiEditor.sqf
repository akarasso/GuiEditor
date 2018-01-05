#include "..\oop.h"
#include "..\dik_macro.hpp"

#define INDEX_POSITION 0
#define INDEX_TEXT 1
#define INDEX_NAME 2
#define INDEX_TP 3
#define INDEX_CONTROL_CLASS 4
#define INDEX_VISIBLE 5
#define INDEX_EVH 6

#define INDEX_TEXT_COLOR 7
#define INDEX_BGCOLOR 8
#define INDEX_FGCOLOR 9
#define INDEX_TP_COLOR_BOX 10
#define INDEX_TP_COLOR_SHADE 11
#define INDEX_TP_COLOR_TEXT 12

CLASS("oo_GuiEditor")
	PUBLIC STATIC_VARIABLE("code", "HelperGui");
	PUBLIC UI_VARIABLE("display", "Display");
	PUBLIC UI_VARIABLE("display", "DisplayCtrlCreate");
	
	PUBLIC VARIABLE("code", "GuiHelperDialog");
	PUBLIC VARIABLE("code", "GuiHelperEvent");
	PUBLIC VARIABLE("code", "View");
	PUBLIC VARIABLE("code", "Workground");
	PUBLIC VARIABLE("code", "selCtrl");
	PUBLIC VARIABLE("code", "GridObject");
	PUBLIC VARIABLE("code", "MakeFile");
	PUBLIC VARIABLE("string", "DisplayName");	
	PUBLIC VARIABLE("scalar", "IDD");
	PUBLIC VARIABLE("scalar", "Index");	


	PUBLIC FUNCTION("","constructor") {
		if (isNil {MEMBER("HelperGui", nil)}) then {
			private _g = "new" call oo_HelperGui;
			MEMBER("HelperGui", _g);
		};
		disableSerialization;
		MEMBER("Workground", {});		
		MEMBER("selCtrl", {});
		MEMBER("Index", 1);
		MEMBER("DisplayName", "NewDialog");
		MEMBER("IDD", 1000);
		private _guiHelperDialog = ["new", _code] call oo_GuiEditorDialog;
		MEMBER("GuiHelperDialog", _guiHelperDialog);
		if(createDialog "Empty") then {
			MEMBER("Display", (findDisplay 4500));

			private _GRID = "new" call oo_GRIDLayer;
			MEMBER("GridObject", _GRID);

			private _GRIDLayer = ["createGridLayer", MEMBER("Display", nil)] call _GRID;
			"genGrid" call _GRID;

			private _event = ["new", _self] call oo_GuiEditorEvent;
			MEMBER("GuiHelperEvent", _event);

			private _VIEW = ["new", [_self, MEMBER("Display", nil), {}, controlNull, "OOP_MainLayer", 0]] call oo_Layer;
			MEMBER("View", _VIEW);
			["setID", MEMBER("getNewID", nil)] call _VIEW;
			"createMainLayer" call _VIEW;	
			MEMBER("setActiveLayer", _VIEW);
		};
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
		disableSerialization;
		private _display = MEMBER("Display", nil);
		private _layer = "getControl" call MEMBER("Workground", nil);
		private _newId = MEMBER("getNewID", nil);
		private _newCtrl = _display ctrlCreate[_this, _newId, _layer];
		private _ctrlType = ctrlType _newCtrl;
		private _newInstance = switch (_ctrlType) do { 
			case 15 : {["new", [_self, _display, MEMBER("Workground", nil), _newCtrl, _this, _newId]] call oo_Layer;}; 
			default {["new", [_self, _display, MEMBER("Workground", nil), _newCtrl, _this, _newId]] call oo_Control;}; 
		};
		_clickPos = "getMouseClick" call MEMBER("GuiHelperEvent", nil);
		["setPos", _clickPos] call _newInstance;
		["pushChild", _newInstance] call MEMBER("Workground", nil);
		"fillDisplayTree" call MEMBER("GuiHelperEvent", nil);
		if (_ctrlType isEqualTo 15) then {
			MEMBER("RefreshAllBoundBox", nil);
		}else{
			_newCtrl ctrlEnable false;
		};
		_newInstance;
	};

	PUBLIC FUNCTION("array","ctrlRecreate") {
		disableSerialization;
		private _index = MEMBER("Index", nil);
		_index = _index + 1;
		private _newCtrl = MEMBER("Display", nil) ctrlCreate[(_this select 0) select INDEX_CONTROL_CLASS, _index, _this select 2];
		private _newInstance = switch (ctrlType _newCtrl) do { 
			case 15 : {["new", [_self, MEMBER("Display", nil), (_this select 1), _newCtrl, ((_this select 0) select INDEX_CONTROL_CLASS), _index]] call oo_Layer;}; 
			default {["new", [_self, MEMBER("Display", nil), (_this select 1), _newCtrl, ((_this select 0) select INDEX_CONTROL_CLASS), _index]] call oo_Control;}; 
		};
		["pushChild", _newInstance] call (_this select 1);
		MEMBER("Index", _index);
		_newInstance;
	};

	PUBLIC FUNCTION("","getNewID") {
		MEMBER("Index", MEMBER("Index", nil) + 1);
		MEMBER("Index", nil);
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
		["setPos", [((_parentPos select 2)/2) - (_pos select 2)/2, _pos select 1, _pos select 2, _pos select 3]] call MEMBER("selCtrl", nil);
	};

	PUBLIC FUNCTION("","centerV") {
		private _parentPos = "getPos" call MEMBER("Workground", nil);
		private _pos = "getPos" call MEMBER("selCtrl", nil);
		["setPos", [_pos select 0, ((_parentPos select 3)/2) - (_pos select 3)/2, _pos select 2, _pos select 3]] call MEMBER("selCtrl", nil);
	};

	PUBLIC FUNCTION("","exportHPP") {
		private _hppMaker = ["new", (MEMBER("DisplayName", nil) + ".hpp")] call oo_makeFile;
		["pushLine", format["class %1 {", MEMBER("DisplayName", nil)]] call _hppMaker;
		["modTab", +1] call _hppMaker;
		["pushLine", format["idd = %1;", MEMBER("IDD", nil)]] call _hppMaker;
		["pushLine", format['name= "%1";', MEMBER("DisplayName", nil)]] call _hppMaker;
		["pushLine", "movingEnable = false;"] call _hppMaker;
		["pushLine", "enableSimulation = true;"] call _hppMaker;
		["pushLine", "class controlsBackground {"] call _hppMaker;
		["modTab", +1] call _hppMaker;
		["exportHPP", _hppMaker] call MEMBER("View", nil);
		["modTab", -1] call _hppMaker;
		["pushLine", "};"] call _hppMaker;
		["pushLine", "class controls {};"] call _hppMaker;
		["modTab", -1] call _hppMaker;
		["pushLine", "};"] call _hppMaker;

		"pushLineBreak" call _hppMaker;
		"pushLineBreak" call _hppMaker;
		"pushLineBreak" call _hppMaker;

		["pushLine","/*"] call _hppMaker;
		private _serializeGui = ["serializeChilds", []] call MEMBER("View", nil);
		private _a = [MEMBER("DisplayName", nil), MEMBER("IDD", nil), _serializeGui];
		["pushLine",str _a] call _hppMaker;
		["pushLine","*/"] call _hppMaker;

		"exec" call _hppMaker;	
		hint "Export HPP have been paste into your clipboard";
	};

	PUBLIC FUNCTION("","exportOOP") {
		private _oopFile = ["new", MEMBER("DisplayName", nil) + ".sqf"] call oo_makeOOPFile;
		["setIDD", MEMBER("IDD", nil)] call _oopFile;
		["setClassName", MEMBER("DisplayName", nil)] call _oopFile;
		["exportOOP", _oopFile] call MEMBER("View", nil);
		"exec" call _oopFile;
		hint "Export OOP have been paste into your clipboard";	
	};

	PUBLIC FUNCTION("","refreshDisplay") {
		"refreshAllCtrl" call MEMBER("View", nil);
	};

	PUBLIC FUNCTION("","importFromClipboard") {
		hint "Importing display";
		private _copy = copyFromClipboard;
		private _oldWg = MEMBER("Workground", nil);
		MEMBER("setActiveLayer", MEMBER("View", nil));

		_copy = toArray _copy;
		if (_copy select (count _copy -1) isEqualTo 10) then {
			_copy deleteAt (count _copy -1);
		};
		if (_copy select (count _copy -1) isEqualTo 13) then {
			_copy deleteAt (count _copy -1);
		};
		_copy = toString _copy;
		private _guiSerialized = parseSimpleArray _copy;
		MEMBER("DisplayName", _guiSerialized select 0);
		MEMBER("IDD", _guiSerialized select 1);
		private "_idc", "_data", "_arr","_new", "_newControl";
		{
			if (((_x select 0) select INDEX_POSITION) isEqualTypeAll "") then {
				((_x select 0) select INDEX_POSITION) set [0, call compile (((_x select 0) select INDEX_POSITION) select 0)];
				((_x select 0) select INDEX_POSITION) set [1, call compile (((_x select 0) select INDEX_POSITION) select 1)];
				((_x select 0) select INDEX_POSITION) set [2, call compile (((_x select 0) select INDEX_POSITION) select 2)];
				((_x select 0) select INDEX_POSITION) set [3, call compile (((_x select 0) select INDEX_POSITION) select 3)];
			};
			_arr = [(_x select 0), MEMBER("View", nil), "getControl" call MEMBER("View", nil)];
			_new = MEMBER("ctrlRecreate", _arr);
			["setData", (_x select 0)] call _new;
			_newControl = "getControl" call _new;
			if (ctrlType _newControl isEqualTo 15) then {
				_arr = [_new, _newControl, _x select 1];
				MEMBER("loadChilds", (_arr));
			};
		} forEach (_guiSerialized select 2);
		MEMBER("setActiveLayer", _oldWg);
		"fillDisplayTree" call MEMBER("GuiHelperEvent", nil);
	};

	PUBLIC FUNCTION("array","loadChilds") {
		private "_arr","_new", "_newControl", "_workground";
		private _workground = _this select 0;
		private _layer = _this select 1;
		private _childs = _this select 2;
		{
			if (((_x select 0) select INDEX_POSITION) isEqualTypeAll "" ) then {
				((_x select 0) select INDEX_POSITION) set [0, call compile (((_x select 0) select INDEX_POSITION) select 0)];
				((_x select 0) select INDEX_POSITION) set [1, call compile (((_x select 0) select INDEX_POSITION) select 1)];
				((_x select 0) select INDEX_POSITION) set [2, call compile (((_x select 0) select INDEX_POSITION) select 2)];
				((_x select 0) select INDEX_POSITION) set [3, call compile (((_x select 0) select INDEX_POSITION) select 3)];
			};
			_arr = [(_x select 0), _workground, _layer];
			_new = MEMBER("ctrlRecreate", _arr);
			["setData", (_x select 0)] call _new;
			_newControl = "getControl" call _new;
			if (ctrlType _newControl isEqualTo 15) then {
				_arr = [_new, _newControl, _x select 1];
				MEMBER("loadChilds", _arr);
			};
		} forEach _childs;
	};

	PUBLIC FUNCTION("","getGridObject") { MEMBER("GridObject", nil); };
	PUBLIC FUNCTION("","getSelCtrl") { MEMBER("selCtrl", nil); };
	PUBLIC FUNCTION("","getDisplay") { MEMBER("Display", nil); };
	PUBLIC FUNCTION("","getView") { MEMBER("View", nil); };
	PUBLIC FUNCTION("","getDeltaPosClick") { MEMBER("DeltaPosClick", nil); };
	PUBLIC FUNCTION("","getWorkground") { MEMBER("Workground", nil); };
	PUBLIC FUNCTION("","getPosWorkground") {
		disableSerialization;
		private _w = "getControl" call MEMBER("Workground", nil);
		ctrlPosition _w;
	};
	PUBLIC FUNCTION("","getGuiHelperEvent") { MEMBER("GuiHelperEvent", nil); };
	PUBLIC FUNCTION("","getDisplayName") {MEMBER("DisplayName", nil);};
	PUBLIC FUNCTION("","getIDD") { MEMBER("IDD", nil); };

	PUBLIC FUNCTION("string","setDisplayName") { 
		private _name = ["trim", _this] call MEMBER("HelperGui", nil);
		if !(["stringContain", [_name, " "]] call MEMBER("HelperGui", nil)) exitWith {
			MEMBER("DisplayName", _name);
			true;
		};
		false;
	};

	PUBLIC FUNCTION("scalar","setIDD") {
		if (_this > 0) exitWith {
			MEMBER("IDD", _this);
			true;
		};
		false;
	};
	
	PUBLIC FUNCTION("code","setSelCtrl") { MEMBER("selCtrl", _this); };
ENDCLASS;
