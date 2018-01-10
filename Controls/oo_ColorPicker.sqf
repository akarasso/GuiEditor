#include "..\oop.h"
CLASS("oo_ColorPicker")

	PUBLIC UI_VARIABLE("display", "Display");
	PUBLIC UI_VARIABLE("control", "controlParent");
	PUBLIC UI_VARIABLE("control", "ctrlGroup");
	PUBLIC UI_VARIABLE("control", "Background");
	PUBLIC UI_VARIABLE("control", "Rendu");
	PUBLIC UI_VARIABLE("control", "LBColor");
	PUBLIC UI_VARIABLE("control", "EditColor");
	PUBLIC UI_VARIABLE("array", "SubEVHList");

	PUBLIC VARIABLE("code", "Red");
	PUBLIC VARIABLE("code", "Green");
	PUBLIC VARIABLE("code", "Blue");
	PUBLIC VARIABLE("code", "Alpha");

	PUBLIC VARIABLE("string", "Texture");

	PUBLIC FUNCTION("display","constructor") {
		disableSerialization; 
		MEMBER("Display", _this);
		MEMBER("SubEVHList", []);
		private _ctrlGroup = _this ctrlCreate["RscControlsGroupNoScrollbars", -10];
		MEMBER("ctrlGroup", _ctrlGroup);	
		private _bg = _this ctrlCreate["RscPicture", -11, _ctrlGroup];
		MEMBER("Background", _bg);	
		MEMBER("setPos", []);	
		private _red = ["new", 	[_this, _ctrlGroup, [0, 0, 3.95045 * pixelGrid * pixelW, 22.671 * pixelGrid * pixelH]]] call oo_SliderH;
		private _green = ["new",[_this, _ctrlGroup, [5.26727 * pixelGrid * pixelW, 0, 3.95045 * pixelGrid * pixelW, 22.671 * pixelGrid * pixelH]]] call oo_SliderH;
		private _blue = ["new", [_this, _ctrlGroup, [10.5345 * pixelGrid * pixelW, 0, 3.95045 * pixelGrid * pixelW, 22.671 * pixelGrid * pixelH]]] call oo_SliderH;
		private _alpha = ["new",[_this, _ctrlGroup, [15.8018 * pixelGrid * pixelW, 0, 3.95045 * pixelGrid * pixelW, 22.671 * pixelGrid * pixelH]]] call oo_SliderH;
		["setValue", 0] call _red;
		["setValue", 0] call _green;
		["setValue", 0] call _blue;
		["setValue", 100] call _alpha;
		MEMBER("Red", _red);
		MEMBER("Green", _green);
		MEMBER("Blue", _blue);
		MEMBER("Alpha", _alpha);

		private _rendu = _this ctrlCreate["RscPicture", -10, _ctrlGroup];
		_rendu ctrlSetPosition [38.1877 * pixelGrid * pixelW, 0 * pixelGrid * pixelH, 10.5345 * pixelGrid * pixelW, 10.076 * pixelGrid * pixelH];
		_rendu ctrlCommit 0;
		MEMBER("Rendu", _rendu);
		private _listColor = _this ctrlCreate["RscListBox", -10, _ctrlGroup];
		_listColor ctrlSetPosition [21.0691 * pixelGrid * pixelW, 0 * pixelGrid * pixelH, 15.8018 * pixelGrid * pixelW, 17.633 * pixelGrid * pixelH];
		_listColor ctrlCommit 0;
		_listColor ctrlAddEventHandler["LBSelChanged", format["['onSelectColor',_this] call %1", _code]];
		MEMBER("LBColor", _listColor);

		private _editColor = _this ctrlCreate["RscEdit", -10, _ctrlGroup];
		_editColor ctrlSetPosition [21.0691 * pixelGrid * pixelW, 18.8925 * pixelGrid * pixelH, 15.8018 * pixelGrid * pixelW, 3.7785 * pixelGrid * pixelH];
		_editColor ctrlCommit 0;
		MEMBER("EditColor", _editColor);

		private _button = _this ctrlCreate["RscButton", -10, _ctrlGroup];
		_button ctrlSetPosition [38.1877 * pixelGrid * pixelW, 17.633 * pixelGrid * pixelH, 10.5345 * pixelGrid * pixelW, 5.038 * pixelGrid * pixelH];
		_button ctrlCommit 0;
		_button ctrlSetText "save";
		_button buttonSetAction format["'addColorToList' call %1;", _code];

		["subToEVH", compile format["'onSliderChange' call %1;",_code] ] call _red;
		["subToEVH", compile format["'onSliderChange' call %1;",_code] ] call _green;
		["subToEVH", compile format["'onSliderChange' call %1;",_code] ] call _blue;
		["subToEVH", compile format["'onSliderChange' call %1;",_code] ] call _alpha;
		MEMBER("onSliderChange", nil);
		MEMBER("refreshListColor", nil);

		private _arr = [0,0,0,0];
		MEMBER("setAllTopArrowSlider", _arr);
		MEMBER("setAllBottomArrowSlider", _arr);
		_arr = ["red", [1]];
		MEMBER("setFGSlider", _arr);
		_arr = ["blue", [0,0,1]];
		MEMBER("setFGSlider", _arr);
		_arr = ["green", [0,1]];
		MEMBER("setFGSlider", _arr);
	};

	PUBLIC FUNCTION("","getPos") {
		ctrlPosition MEMBER("ctrlGroup", nil);
	};

	PUBLIC FUNCTION("array","setPos") {
		private _default = [0, 0, (60 * pixelGrid * pixelW), (27.709 * pixelGrid * pixelH)];
		if (count _this isEqualTo 1) then {
			_default set[0, _this select 0];
		};
		if (count _this isEqualTo 2) then {
			_default set[0, _this select 0];
			_default set[1, _this select 1];
		};
		if (count _this isEqualTo 3) then {
			_default set[0, _this select 0];
			_default set[1, _this select 1];
			_default set[2, _this select 2];
		};
		if (count _this isEqualTo 4) then {
			_default = _this;
		};
		MEMBER("ctrlGroup", nil) ctrlSetPosition _default;
		MEMBER("ctrlGroup", nil) ctrlCommit 0;

		private _texture = ["getTextureFromArray", [0.20,0.20,0.22,0.28]] call HelperGui;
		MEMBER("Background", nil) ctrlSetText _texture;
		MEMBER("Background", nil) ctrlSetPosition [0, 0, _default select 2, _default select 3];
		MEMBER("Background", nil) ctrlCommit 0;
	};

	PUBLIC FUNCTION("code","subToEVH") {
		MEMBER("SubEVHList", nil) pushBackUnique _this;
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

	PUBLIC FUNCTION("","refreshListColor") {
		private _l = profileNamespace getVariable ["listColor", []];
		lbClear MEMBER("LBColor", nil);
		{
			_index = MEMBER("LBColor", nil) lbAdd (_x select 0);
			MEMBER("LBColor", nil) lbSetValue [_index, _forEachIndex];
		} forEach _l;
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
			{
				_color call _x;
			} forEach MEMBER("SubEVHList", nil);
		};		
	};

	PUBLIC FUNCTION("","refreshRendu") {
		MEMBER("Rendu", nil) ctrlSetText MEMBER("getTexture", nil);
	};

	PUBLIC FUNCTION("","onSliderChange") {
		private _vRed = ("getValue" call MEMBER("Red",nil))/100;
		private _vGreen = ("getValue" call MEMBER("Green",nil))/100;
		private _vBlue = ("getValue" call MEMBER("Blue",nil))/100;
		private _vAlpha = ("getValue" call MEMBER("Alpha",nil))/100;
		{
			[_vRed,_vGreen,_vBlue,_vAlpha] call _x;
		} forEach MEMBER("SubEVHList", nil);
		private _t = format["#(rgb,8,8,3)color(%1,%2,%3,%4)",_vRed, _vGreen, _vBlue, _vAlpha];
		MEMBER("Rendu", nil) ctrlSetText _t;
	};

	PUBLIC FUNCTION("","getTexture") {
		private _vRed = ("getValue" call MEMBER("Red",nil))/100;
		private _vGreen = ("getValue" call MEMBER("Green",nil))/100;
		private _vBlue = ("getValue" call MEMBER("Blue",nil))/100;
		private _vAlpha = ("getValue" call MEMBER("Alpha",nil))/100;
		format["#(rgb,8,8,3)color(%1,%2,%3,%4)",_vRed, _vGreen, _vBlue, _vAlpha];
	};

	PUBLIC FUNCTION("","getColor") {
		private _vRed = ("getValue" call MEMBER("Red",nil))/100;
		private _vGreen = ("getValue" call MEMBER("Green",nil))/100;
		private _vBlue = ("getValue" call MEMBER("Blue",nil))/100;
		private _vAlpha = ("getValue" call MEMBER("Alpha",nil))/100;
		[_vRed,_vGreen,_vBlue,_vAlpha];
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