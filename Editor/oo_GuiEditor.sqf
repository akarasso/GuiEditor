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
		MEMBER("Index", 100);
		MEMBER("DisplayName", "NewDialog");
		MEMBER("IDD", 1000);
		if(createDialog "Empty") then {
			MEMBER("Display", (findDisplay 4500));

			private _GRID = "new" call oo_GRIDLayer;
			MEMBER("GridObject", _GRID);

			private _GRIDLayer = ["createGridLayer", MEMBER("Display", nil)] call _GRID;
			"genGrid" call _GRID;

			private _event = "new" call oo_GuiEditorEvent;
			MEMBER("GuiHelperEvent", _event);

			private _mainLayer = MEMBER("Display", nil) ctrlCreate["OOP_MainLayer", 100];
			private _VIEW = ["new", [100, _mainLayer, "OOP_MainLayer"]] call oo_Layer;
			MEMBER("View", _VIEW);
			MEMBER("setActiveLayer", _VIEW);
		};
	};

	PUBLIC FUNCTION("scalar","findControlByID") {
		["findControlByID", _this] call MEMBER("View", nil);
	};	

	PUBLIC FUNCTION("string","ctrlCreate") {
		disableSerialization;
		private _display = MEMBER("Display", nil);
		private _workground = MEMBER("Workground", nil);
		private _layer = "getControl" call _workground;
		private _index = MEMBER("Index", nil) + 1;
		MEMBER("Index", _index);
		/*private _class = missionNamespace getVariable [_this, ""];
		if (_class isEqualType {}) exitWith {
			if (['static', ['getParentClass', nil]] call _class isEqualTo "oo_metaControl") exitWith {
				private _newCtrl = _display ctrlCreate["OOP_SubLayer", _index, _layer];
				private _metaClass = ["new", [_index, _newCtrl, _this]] call _class;
				["setColorBoundbox", "child"] call _metaClass;
				_metaClass;
			};
		};*/
		private _newCtrl = _display ctrlCreate[_this, _index, _layer];
		if (ctrlType _newCtrl isEqualTo 15) then {
			_newInstance = ["new", [_index, _newCtrl, _this]] call oo_Layer;
			MEMBER("Const", nil);
			_newInstance;
		}else{
			_newInstance = ["new", [_index, _newCtrl, _this]] call oo_Control;
			_newCtrl ctrlEnable false;
			_newInstance;
		};
	};

	PUBLIC FUNCTION("","requestIndex") {
		private _index = MEMBER("Index", nil) + 1;
		MEMBER("Index", _index);
		_index;
	};

	/*
	* 	Fonction qui définit quel layer est éditable
	* 	@input:code Class du futur layer a éditer
	*/
	PUBLIC FUNCTION("code","setActiveLayer") {
		["workGroundEnable", false] call MEMBER("Workground", nil);
		MEMBER("selCtrl", {});
		MEMBER("Workground", _this);
		["workGroundEnable", true] call MEMBER("Workground", nil);
		"refreshTree" call MEMBER("GuiHelperEvent", nil);
	};

	PUBLIC FUNCTION("","RefreshAllBoundBox") {
		["RefreshBoundBox", [MEMBER("Workground", nil),  true]] call MEMBER("View", nil);
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

	PUBLIC FUNCTION("string","nameExist") {
		["nameExist", _this] call MEMBER("View", nil);
	};

	PUBLIC FUNCTION("","exportHPP") {
		private _hppMaker = "new" call oo_makeFile;
		["pushLine", format["class %1 {", MEMBER("DisplayName", nil)]] call _hppMaker;
		["modTab", +1] call _hppMaker;
		["pushLine", format["idd = %1;", MEMBER("IDD", nil)]] call _hppMaker;
		["pushLine", format['name= "%1";', MEMBER("DisplayName", nil)]] call _hppMaker;
		["pushLine", "movingEnable = false;"] call _hppMaker;
		["pushLine", "enableSimulation = true;"] call _hppMaker;
		private _string = format["with missionNamespace do{%1 = ['new', _this select 0] call oo_%1;};", MEMBER("DisplayName", nil)];
		_string = format['onLoad = "%1";', _string];
		["pushLine", _string] call _hppMaker;


		_string = format["with missionNamespace do{['delete',%1] call oo_%1;};", MEMBER("DisplayName", nil)];
		_string = format['onUnload = "%1";', _string];
		["pushLine", _string] call _hppMaker;

		["pushLine", "class controlsBackground {"] call _hppMaker;
		["modTab", +1] call _hppMaker;
		["exportHPP", _hppMaker] call MEMBER("View", nil);
		["modTab", -1] call _hppMaker;
		["pushLine", "};"] call _hppMaker;
		["pushLine", "class controls {};"] call _hppMaker;
		["modTab", -1] call _hppMaker;
		["pushLine", "};"] call _hppMaker;

		"pushLineBreak" call _hppMaker;

		["pushLine","/*"] call _hppMaker;
		private _serializeGui = ["serializeChilds", []] call MEMBER("View", nil);
		private _a = [MEMBER("DisplayName", nil), MEMBER("IDD", nil), _serializeGui];
		["pushLine",str _a] call _hppMaker;
		["pushLine","*/"] call _hppMaker;
		"exec" call _hppMaker;	
		hint "Export HPP have been paste into your clipboard";
	};

	PUBLIC FUNCTION("","getSerializeChilds") {
		private _serializeGui = ["serializeChilds", []] call MEMBER("View", nil);
		private _a = [MEMBER("DisplayName", nil), MEMBER("IDD", nil), _serializeGui];
		copyToClipboard (str _a);
		hint "Controls are serialize into your clipboard. You could re-open gui editor when you press f1";
	};

	PUBLIC FUNCTION("","exportOOP") {
		private _oopFile = ["new", [MEMBER("DisplayName", nil), MEMBER("IDD", nil)]] call oo_makeOOPFile;
		["exportOOP", _oopFile] call MEMBER("View", nil);
		"exec" call _oopFile;
		hint "Export OOP have been paste into your clipboard";	
	};

	// PUBLIC FUNCTION("","exportMetaObject") {
	// 	private _workground = MEMBER("Workground", nil);
	// 	if (_workground isEqualTo MEMBER("View", nil)) exitWith {
	// 		hint "Main layer can't be export as meta control";
	// 	};
	// 	private _name = "getFormatedName" call _workground;
	// 	private _makeMetaControl = ["new", _name] call oo_makeMetaControl;
		
	// 	// ["pushLine", '#include "..\oop.h"'] call _makeMetaControl;
	// 	["exportMetaControl", _makeMetaControl] call _workground;
	// 	"exec" call _makeMetaControl;
	// 	hint "copy to your clipboard";
	// };

	PUBLIC FUNCTION("bool","setAllEnable") {
		if (_this) then {
			hint "All control are enable";
		}else{
			hint "All control are disable";
		};
		["setEnable", _this] call MEMBER("View", nil);
	};

	PUBLIC FUNCTION("","refreshDisplay") {
		private _childView = "getChilds" call MEMBER("View", nil);
		{
			"refreshControl" call _x;
		} forEach _childView;
		MEMBER("setActiveLayer", MEMBER("Workground", nil));
	};

	PUBLIC FUNCTION("","importFromClipboard") {
		if!((getPlayerUID player) isEqualTo "_SP_PLAYER_" || (getPlayerUID player) isEqualTo "_SP_AI_") exitWith {hint "You must be in SP";};
		hint "Importing display";
		disableSerialization;
		private _display = MEMBER("Display", nil);
		private _copy = copyFromClipboard;
		private _view = MEMBER("View", nil);
		private _viewControl = "getControl" call _view;
		if (_copy isEqualTo "") exitWith {hint "Empty clipboard.";};
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

		{
			private _ctrlData = _x select 0;
			private _controlClass = _ctrlData select INDEX_CONTROL_CLASS;
			private _pos = _ctrlData select INDEX_POSITION;
			private _instance = MEMBER("ctrlCreate", _controlClass);
			["pushChild", _instance] call MEMBER("View", nil);
			["setData", _ctrlData] call _instance;
			private _control = "getControl" call _instance;
			//layer
			if (ctrlType _control isEqualTo 15) then {
				private _array = [_instance, (_x select 1)];
				MEMBER("loadLayer", _array);
			};
		} forEach _controlList;
		"refreshTree" call MEMBER("GuiHelperEvent", nil);
		MEMBER("refreshDisplay", nil);
		MEMBER("RefreshAllBoundBox", nil);
	};

	PUBLIC FUNCTION("array","loadLayer") {
		private _currentLayer = _this select 0;
		private _childsLayer = _this select 1;
		MEMBER("Workground", _this select 0);
		{
			private _ctrlData = _x select 0;
			private _controlClass = _ctrlData select INDEX_CONTROL_CLASS;
			private _pos = _ctrlData select INDEX_POSITION;
			private _instance = MEMBER("ctrlCreate", _controlClass);
			["pushChild", _instance] call _currentLayer;
			["setData", _ctrlData] call _instance;
			private _control = "getControl" call _instance;
			//layer
			if (ctrlType _control isEqualTo 15) then {
				private _array = [_instance, (_x select 1)];
				MEMBER("loadLayer", _array);
			};
		} forEach _childsLayer;
		private _parentLayer = "getParent" call _currentLayer;
		MEMBER("Workground", _parentLayer);
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
	PUBLIC FUNCTION("","getDisplayIDD") { MEMBER("IDD", nil); };
	PUBLIC FUNCTION("scalar","setDisplayIDD") {
		if (_this > 0) exitWith {
			MEMBER("IDD", _this);
			true;
		};
		false;
	};
	PUBLIC FUNCTION("string","setDisplayName") { 
		private _name = ["trim", _this] call HelperGui;
		if !(["stringContain", [_name, " "]] call HelperGui) exitWith {
			MEMBER("DisplayName", _name);
			true;
		};
		false;
	};

	PUBLIC FUNCTION("code","setSelCtrl") { MEMBER("selCtrl", _this); };
ENDCLASS;
