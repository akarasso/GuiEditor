#include "..\oop.h"
CLASS_EXTENDS("oo_ColorPicker", "oo_metaControl")
	PUBLIC UI_VARIABLE("control", "EditColor");
	PUBLIC UI_VARIABLE("control", "RenderColor");
	PUBLIC UI_VARIABLE("control", "ProfileColorList");
	PUBLIC VARIABLE("code", "Red");
	PUBLIC VARIABLE("code", "Green");
	PUBLIC VARIABLE("code", "Blue");
	PUBLIC VARIABLE("code", "Alpha");
	

	PUBLIC FUNCTION("array","constructor") {
		SUPER("constructor", _this);
		private _arr = [0,0, 44.7718 * pixelGrid * pixelW, 27.709 * pixelGrid * pixelH];
		MEMBER("setPos", _arr);
		
		private _red = ["new", 	[(_this select 0), MEMBER("Control", nil)]] call oo_SliderH;

		["setPos", [2.63363 * pixelGrid * pixelW, 2.519 * pixelGrid * pixelH, 3.95045 * pixelGrid * pixelW, 15.114 * pixelGrid * pixelH]] call _red;
		private _green = ["new",[(_this select 0), MEMBER("Control", nil)]] call oo_SliderH;
		["setPos", [7.9009 * pixelGrid * pixelW, 2.519 * pixelGrid * pixelH, 3.95045 * pixelGrid * pixelW, 15.114 * pixelGrid * pixelH]] call _green;
		private _blue = ["new", [(_this select 0), MEMBER("Control", nil)]] call oo_SliderH;
		["setPos", [13.1682 * pixelGrid * pixelW, 2.519 * pixelGrid * pixelH, 3.95045 * pixelGrid * pixelW, 15.114 * pixelGrid * pixelH]] call _blue;
		private _alpha = ["new",[(_this select 0), MEMBER("Control", nil)]] call oo_SliderH;
		["setPos", [18.4354 * pixelGrid * pixelW, 2.519 * pixelGrid * pixelH, 3.95045 * pixelGrid * pixelW, 15.114 * pixelGrid * pixelH]] call _alpha;
		["setValue", 100]call _alpha;

		MEMBER("Red", _red);
		MEMBER("Green", _green);
		MEMBER("Blue", _blue);
		MEMBER("Alpha", _alpha);

		private _renderColorPicker = (_this select 0) ctrlCreate["OOP_Picture", -10, MEMBER("Control", nil)];
		_renderColorPicker ctrlSetPosition [23.7027 * pixelGrid * pixelW, 2.519 * pixelGrid * pixelH, 10.5345 * pixelGrid * pixelW, 5.038 * pixelGrid * pixelH];
		_renderColorPicker ctrlCommit 0;
		MEMBER("RenderColor", _renderColorPicker);

		private _listColor = (_this select 0) ctrlCreate["OOP_ListBox", -10, MEMBER("Control", nil)];
		_listColor ctrlSetPosition [23.7027 * pixelGrid * pixelW, 7.557 * pixelGrid * pixelH, 13.1682 * pixelGrid * pixelW, 10.076 * pixelGrid * pixelH];
		_listColor ctrlCommit 0;
		_listColor ctrlAddEventHandler["LBSelChanged", format["['onSelectColor',_this] call %1", _code]];
		MEMBER("ProfileColorList", _listColor);

		private _editColor = (_this select 0) ctrlCreate["OOP_Edit", -10, MEMBER("Control", nil)];
		_editColor ctrlSetPosition [2.63363 * pixelGrid * pixelW, 20.152 * pixelGrid * pixelH, 21.0691 * pixelGrid * pixelW, 5.038 * pixelGrid * pixelH];
		_editColor ctrlCommit 0;
		MEMBER("EditColor", _editColor);

		private _btnSave = (_this select 0) ctrlCreate["OOP_Button", -10, MEMBER("Control", nil)];
		_btnSave ctrlSetPosition [23.7027 * pixelGrid * pixelW, 20.152 * pixelGrid * pixelH, 5.26727 * pixelGrid * pixelW, 5.038 * pixelGrid * pixelH];
		_btnSave ctrlCommit 0;
		_btnSave ctrlSetText "Save";
		_btnSave buttonSetAction format["'addColorToList' call %1;", _code];

		private _btnDel = (_this select 0) ctrlCreate["OOP_Button", -10, MEMBER("Control", nil)];
		_btnDel ctrlSetPosition [31.6036 * pixelGrid * pixelW, 20.152 * pixelGrid * pixelH, 5.26727 * pixelGrid * pixelW, 5.038 * pixelGrid * pixelH];
		_btnDel ctrlCommit 0;
		_btnDel ctrlSetText "Del";
		_btnDel buttonSetAction format["'delColorFromList' call %1;", _code];

		private _btnClose = (_this select 0) ctrlCreate["OOP_Button", -10, MEMBER("Control", nil)];
		_btnClose ctrlSetPosition [37.8929 * pixelGrid * pixelW, 2.519 * pixelGrid * pixelH, 5.26727 * pixelGrid * pixelW, 5.038 * pixelGrid * pixelH];
		_btnClose ctrlCommit 0;
		_btnClose ctrlSetText "Close";
		_btnClose buttonSetAction format["['ctrlShow', false] call %1;", _code];

		private _callable = compile format["['onOneSliderChange', _this] call %1;", _code];
		["setForegroundSlider", [1,0,0,1]] call _red;
		["setForegroundSlider", [0,1,0,1]] call _green;
		["setForegroundSlider", [0,0,1,1]] call _blue;
		["setForegroundSlider", [0.8,0.8,0.8,1]] call _alpha;
		["addCallBack", _callable]call _red;
		["addCallBack", _callable]call _green;
		["addCallBack", _callable]call _blue;
		["addCallBack", _callable]call _alpha;

		private _arr = [1,1,1,1];
		MEMBER("setBorderColor", _arr);
		MEMBER("refreshListColor", nil);
	};

	/*
	*	List color event/action
	*/
	PUBLIC FUNCTION("","refreshListColor") {
		private _l = profileNamespace getVariable ["listColor", []];
		lbClear MEMBER("ProfileColorList", nil);
		{
			_index = MEMBER("ProfileColorList", nil) lbAdd (_x select 0);
			MEMBER("ProfileColorList", nil) lbSetValue [_index, _forEachIndex];
		} forEach _l;
	};

	PUBLIC FUNCTION("","addColorToList") {
		if (ctrlText MEMBER("EditColor", nil) isEqualTo "") exitWith {};
		private _l = profileNamespace getVariable ["listColor", []];
		private _text = ctrlText MEMBER("EditColor", nil);
		private _color = MEMBER("getColor",nil);
		_l pushBack [_text, _color];
		profileNamespace setVariable ["listColor", _l];
		MEMBER("refreshListColor", nil);
	};

	PUBLIC FUNCTION("array","onSelectColor") {
		private _index = _this select 1;
		private _list = profileNamespace getVariable ["listColor", []];
		if (_index < count _list) then {
			private _data = _list select _index;
			private _color = _data select 1;
			["setValue", (_color select 0)*100] call MEMBER("Red", nil);
			["setValue", (_color select 1)*100] call MEMBER("Green", nil);
			["setValue", (_color select 2)*100] call MEMBER("Blue", nil);
			["setValue", (_color select 3)*100] call MEMBER("Alpha", nil);
			MEMBER("refreshRendu", nil);
		};		
	};

	PUBLIC FUNCTION("","delColorFromList") {
		private _l = profileNamespace getVariable ["listColor", []];
		private _index = lbCurSel MEMBER("ProfileColorList", nil);
		if!(_index isEqualTo -1) then {
			_l deleteAt _index;
			profileNamespace setVariable ["listColor", _l];
			MEMBER("refreshListColor", nil);
		};
	};

	/*
	*	Return as array
	*/
	PUBLIC FUNCTION("","getColor") {
		private _vRed = ("getValue" call MEMBER("Red",nil))/100;
		private _vGreen = ("getValue" call MEMBER("Green",nil))/100;
		private _vBlue = ("getValue" call MEMBER("Blue",nil))/100;
		private _vAlpha = ("getValue" call MEMBER("Alpha",nil))/100;
		[_vRed,_vGreen,_vBlue,_vAlpha];
	};	

	/*
	*	Return as texture
	*/
	PUBLIC FUNCTION("","getTexture") {
		private _vRed = (("getValue" call MEMBER("Red",nil))/100);
		private _vGreen = (("getValue" call MEMBER("Green",nil))/100);
		private _vBlue = (("getValue" call MEMBER("Blue",nil))/100);
		private _vAlpha = (("getValue" call MEMBER("Alpha",nil))/100);
		format["#(rgb,8,8,3)color(%1,%2,%3,%4)",_vRed, _vGreen, _vBlue, _vAlpha];
	};

	PUBLIC FUNCTION("","refreshRendu") {
		MEMBER("RenderColor", nil) ctrlSetText MEMBER("getTexture", nil);
	};

	/*
	*	Callback
	*/
	PUBLIC FUNCTION("scalar","onOneSliderChange") {
		private _color = MEMBER("getColor", nil);
		MEMBER("makeCallBack", _color);
		MEMBER("RenderColor", nil) ctrlSetText MEMBER("getTexture", nil);
	};	


	/*
	* Setter Arrow up
	*/
	PUBLIC FUNCTION("array","setAllTopArrowSlider") {
		{
			["setTopArrow", _this] call _x;
		} forEach [MEMBER("Red", nil), MEMBER("Green", nil), MEMBER("Blue", nil), MEMBER("Alpha", nil)];
	};
	PUBLIC FUNCTION("string","setAllTopArrowSlider") {
		{
			["setTopArrow", _this] call _x;
		} forEach [MEMBER("Red", nil), MEMBER("Green", nil), MEMBER("Blue", nil), MEMBER("Alpha", nil)];
	};
	PUBLIC FUNCTION("array","setTopArrowSlider") {
		switch (toLower (_this select 0)) do { 
			case "red" : { ["setTopArrow", _this select 1] call MEMBER("Red", nil); }; 
			case "green" : {  ["setTopArrow", _this select 1] call MEMBER("Green", nil); }; 
			case "blue" : {  ["setTopArrow", _this select 1] call MEMBER("Blue", nil); }; 
			case "alpha" : {  ["setTopArrow", _this select 1] call MEMBER("Alpha", nil); }; 
			default {  /*...code...*/ }; 
		};
	};
	
	/*
	* Setter Arrow up
	*/
	PUBLIC FUNCTION("string","setAllBottomArrowSlider") {
		{
			["setBottomArrow", _this] call _x;
		} forEach [MEMBER("Red", nil), MEMBER("Green", nil), MEMBER("Blue", nil), MEMBER("Alpha", nil)];
	};
	PUBLIC FUNCTION("array","setAllBottomArrowSlider") {
		{
			["setBottomArrow", _this] call _x;
		} forEach [MEMBER("Red", nil), MEMBER("Green", nil), MEMBER("Blue", nil), MEMBER("Alpha", nil)];
	};
	PUBLIC FUNCTION("array","setBottomArrowSlider") {
		switch (toLower (_this select 0)) do { 
			case "red" : { ["setBottomArrow", _this select 1] call MEMBER("Red", nil); }; 
			case "green" : {  ["setBottomArrow", _this select 1] call MEMBER("Green", nil); }; 
			case "blue" : {  ["setBottomArrow", _this select 1] call MEMBER("Blue", nil); }; 
			case "alpha" : {  ["setBottomArrow", _this select 1] call MEMBER("Alpha", nil); }; 
			default {  /*...code...*/ }; 
		};
	};

	/*
	* Setter BG
	*/
	PUBLIC FUNCTION("array","setAllBGSlider") {
		{
			["setBG", _this] call _x;
		} forEach [MEMBER("Red", nil), MEMBER("Green", nil), MEMBER("Blue", nil), MEMBER("Alpha", nil)];
	};
	PUBLIC FUNCTION("string","setAllBGSlider") {
		{
			["setBG", _this] call _x;
		} forEach [MEMBER("Red", nil), MEMBER("Green", nil), MEMBER("Blue", nil), MEMBER("Alpha", nil)];
	};
	PUBLIC FUNCTION("array","setBGSlider") {
		switch (toLower (_this select 0)) do { 
			case "red" : { ["setBG", _this select 1] call MEMBER("Red", nil); }; 
			case "green" : {  ["setBG", _this select 1] call MEMBER("Green", nil); }; 
			case "blue" : {  ["setBG", _this select 1] call MEMBER("Blue", nil); }; 
			case "alpha" : {  ["setBG", _this select 1] call MEMBER("Alpha", nil); }; 
			default {  /*...code...*/ }; 
		};
	};

	/*
	* Setter FG
	*/
	PUBLIC FUNCTION("string","setAllFGSlider") {
		{
			["setFGColor", _this] call _x;
		} forEach [MEMBER("Red", nil), MEMBER("Green", nil), MEMBER("Blue", nil), MEMBER("Alpha", nil)];
	};
	PUBLIC FUNCTION("array","setAllFGSlider") {
		{
			["setFGColor", _this] call _x;
		} forEach [MEMBER("Red", nil), MEMBER("Green", nil), MEMBER("Blue", nil), MEMBER("Alpha", nil)];
	};

	PUBLIC FUNCTION("array","setFGSlider") {
		switch (toLower (_this select 0)) do { 
			case "red" : { ["setFG", _this select 1] call MEMBER("Red", nil); }; 
			case "green" : {  ["setFG", _this select 1] call MEMBER("Green", nil); }; 
			case "blue" : {  ["setFG", _this select 1] call MEMBER("Blue", nil); }; 
			case "alpha" : {  ["setFG", _this select 1] call MEMBER("Alpha", nil); }; 
			default {  /*...code...*/ }; 
		};
	};
ENDCLASS;