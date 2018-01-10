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
	PUBLIC UI_VARIABLE("display", "Display");
	
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
		disableSerialization;
		GuiObject = _code;
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

			private _event = "new" call oo_GuiEditorEvent;
			MEMBER("GuiHelperEvent", _event);

			private _VIEW = ["new", [MEMBER("Display", nil), {}, controlNull, "OOP_MainLayer", 0]] call oo_Layer;
			MEMBER("View", _VIEW);
			"createMainLayer" call _VIEW;	
			MEMBER("setActiveLayer", _VIEW);
		};
	};

	PUBLIC FUNCTION("scalar","findControlByID") {
		["findControlByID", _this] call MEMBER("View", nil);
	};	

	PUBLIC FUNCTION("","ctrlCreateDialog") {
		"new" call oo_ctrlCreateDialog;
	};

	PUBLIC FUNCTION("","ctrlModifyDialog") {
		"new" call oo_ctrlModifyDialog;
	};

	PUBLIC FUNCTION("","openGeneralCfg") {
		"openGeneralCfgDialog" call MEMBER("GuiHelperDialog", nil);
	};

	PUBLIC FUNCTION("string","ctrlCreate") {
		disableSerialization;
		private _display = MEMBER("Display", nil);
		private _workground = MEMBER("Workground", nil);
		private _layer = "getControl" call _workground;
		private _index = MEMBER("Index", nil) + 1;
		MEMBER("Index", _index);

		private _testMeta = call compile format["['static', ['getParentClass', nil]] call %1;", _this];
		if (!isNil "_testMeta") exitWith {
			private _constructor = format["['new', %2] call %1;", _this, _index];
			private _metaClass = call compile _constructor;
			["pushChild", _metaClass] call _workground;
			_metaClass;
		};

		
		private _newCtrl = _display ctrlCreate[_this, _index, _layer];
		if (ctrlType _newCtrl isEqualTo 15) then {
			_newInstance = ["new", [_display, _workground, _newCtrl, _this, _index]] call oo_Layer;
			["pushChild", _newInstance] call MEMBER("Workground", nil);
			"fillDisplayTree" call MEMBER("GuiHelperEvent", nil);
			MEMBER("RefreshAllBoundBox", nil);
			_newInstance;
		}else{
			_newInstance = ["new", [_display, _workground, _newCtrl, _this, _index]] call oo_Control;
			["pushChild", _newInstance] call MEMBER("Workground", nil);
			"fillDisplayTree" call MEMBER("GuiHelperEvent", nil);
			_newCtrl ctrlEnable false;
			_newInstance;
		};
	};

	/*
	* 	Fonction qui définit quel layer est éditable
	* 	@input:code Class du futur layer a éditer
	*/
	PUBLIC FUNCTION("code","setActiveLayer") {
		["workGroundEnable", false] call MEMBER("Workground", nil);
		MEMBER("Workground", _this);
		["workGroundEnable", true] call MEMBER("Workground", nil);
		MEMBER("RefreshAllBoundBox", nil);
	};

	PUBLIC FUNCTION("","RefreshAllBoundBox") {
		["RefreshBoundBox", [MEMBER("Workground", nil), [1,0,0,1], [0,1,0,1], [0,0,1,1],  true]] call MEMBER("View", nil);
	};



	PUBLIC FUNCTION("array","setEventState") {
		if ((_this select 1) isEqualTo 1) then {
			["addEvent", _this select 0] call MEMBER("selCtrl", nil);
		}else{
			["rmEvent", _this select 0] call MEMBER("selCtrl", nil);
		};
	};

	PUBLIC FUNCTION("string","addEvent") {
		["addEvent", _this] call MEMBER("selCtrl", nil);
	};

	PUBLIC FUNCTION("string","rmEvent") {
		["rmEvent", _this] call MEMBER("selCtrl", nil);
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

	PUBLIC FUNCTION("","exportHPP") {
		private _hppMaker = ["new", (MEMBER("DisplayName", nil) + ".hpp")] call oo_makeFile;
		["pushLine", format["class %1 {", MEMBER("DisplayName", nil)]] call _hppMaker;
		["modTab", +1] call _hppMaker;
		["pushLine", format["idd = %1;", MEMBER("IDD", nil)]] call _hppMaker;
		["pushLine", format['name= "%1";', MEMBER("DisplayName", nil)]] call _hppMaker;
		["pushLine", "movingEnable = false;"] call _hppMaker;
		["pushLine", "enableSimulation = true;"] call _hppMaker;
		["pushLine", 'onLoad = "with uiNamespace do { openDisplay = _this select 0; };";'] call _hppMaker;
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
		private _oopFile = ["new", [MEMBER("DisplayName", nil), MEMBER("IDD", nil)]] call oo_makeOOPFile;
		["exportOOP", _oopFile] call MEMBER("View", nil);
		"exec" call _oopFile;
		hint "Export OOP have been paste into your clipboard";	
	};

	PUBLIC FUNCTION("bool","setAllEnable") {
		if (_this) then {
			hint "All control are enable";
		}else{
			hint "All control are disable";
		};
		["setEnable", _this] call MEMBER("View", nil);
	};

	PUBLIC FUNCTION("","refreshDisplay") {
		"refreshAllCtrl" call MEMBER("View", nil);
	};

	PUBLIC FUNCTION("","importFromClipboard") {
		hint "Importing display";
		disableSerialization;
		private _display = MEMBER("Display", nil);
		private _copy = copyFromClipboard;
		private _view = MEMBER("View", nil);
		private _viewControl = "getControl" call _view;

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
		private _controlList = _guiSerialized select 2;

		for "_i" from 0 to count _controlList -1 do {

			private _ctrl = _controlList select _i;
			private _newData = _ctrl select 0;

			if ((count _ctrl) isEqualTo 1) then {
				private _index = MEMBER("Index", nil) + 1;
				MEMBER("Index", _index);
				_newInstance = ["new", [_display, _view, controlNull, (_newData select INDEX_CONTROL_CLASS), _index]] call oo_Control;
				["pushChild", _newInstance] call _view;
				{
					(_newData select INDEX_POSITION) set [_forEachIndex, call compile _x];
				} forEach (_newData select INDEX_POSITION);
				["setData", _newData] call _newInstance;
			};
			if ((count _ctrl) isEqualTo 2) then {
				private _index = MEMBER("Index", nil) + 1;
				MEMBER("Index", _index);
				_newInstance = ["new", [_display, _view, controlNull, (_newData select INDEX_CONTROL_CLASS), _index]] call oo_Layer;
				["pushChild", _newInstance] call _view;
				{
					(_newData select INDEX_POSITION) set [_forEachIndex, call compile _x];
				} forEach (_newData select INDEX_POSITION);

				["setData", _newData] call _newInstance;
				private _childs = _ctrl select 1;
				private _array = [_newInstance, _childs];
				MEMBER("loadLayer", _array);
			};
		};
		"fillDisplayTree" call MEMBER("GuiHelperEvent", nil);
		MEMBER("RefreshAllBoundBox", nil);
	};

	PUBLIC FUNCTION("array","loadLayer") {
		private _instance = _this select 0;
		private _childs = _this select 1;
		for "_i" from 0 to count _childs -1 do {
			private _child = _childs select _i;
			private _newData = _child select 0;

			if (count _child isEqualTo 1) then {
				private _index = MEMBER("Index", nil) + 1;
				MEMBER("Index", _index);
				_newInstance = ["new", [_display, _instance, controlNull, (_newData select INDEX_CONTROL_CLASS), _index]] call oo_Control;
				["pushChild", _newInstance] call _instance;
				{
					(_newData select INDEX_POSITION) set [_forEachIndex, call compile _x];
				} forEach (_newData select INDEX_POSITION);
				["setData", _newData] call _newInstance;
			};
			if (count _child isEqualTo 2) then {
				private _index = MEMBER("Index", nil) + 1;
				MEMBER("Index", _index);
				_newInstance = ["new", [_display, _instance, controlNull, (_newData select INDEX_CONTROL_CLASS), _index]] call oo_Layer;
				["pushChild", _newInstance] call _instance;
				{
					(_newData select INDEX_POSITION) set [_forEachIndex, call compile _x];
				} forEach (_newData select INDEX_POSITION);
				["setData", _newData] call _newInstance;

				private _childLayer = _child select 1;
				private _array = [_newInstance, _childLayer];
				MEMBER("loadLayer", _array);
			};
		};
		
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
		private _name = ["trim", _this] call HelperGui;
		if !(["stringContain", [_name, " "]] call HelperGui) exitWith {
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
