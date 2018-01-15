#include "..\oop.h"
CLASS("oo_fakeDialog")

	PUBLIC STATIC_UI_VARIABLE("control", "MainLayer");
	PUBLIC STATIC_UI_VARIABLE("display", "Display");
	PUBLIC STATIC_UI_VARIABLE("code", "colorPicker");

	PUBLIC FUNCTION("", "constructor"){
		disableSerialization;
		if!(createDialog "FakeDialog") exitWith { hint "Failed to open NewDialog"; };
		private _display = findDisplay 1200;
		MEMBER("Display", _display);
		MEMBER("MainLayer", _display displayCtrl 0);

		MEMBER("Init", nil);
	};
	PUBLIC FUNCTION("", "Init"){
		// private _slider = ["new", [MEMBER("Display", nil), MEMBER("MainLayer", nil)]] call oo_sliderH;
		// ["setPos", [0.1,0.1,0.1,0.5]] call _slider;
		// private _callable = compile "['static', ['CallBackSlider', _this]] call oo_fakeDialog";
		// ["addCallBack", _callable]call _slider;

		private _colorPicker = ["new", [MEMBER("Display", nil), MEMBER("MainLayer", nil)]] call oo_ColorPicker;
		["setPos", [0.1,0.1,0.8,0.5]] call _colorPicker;
		private _callable = compile "['static', ['CallBackColorPicker', _this]] call oo_fakeDialog";
		["addCallBack", _callable]call _colorPicker;
		["setBackground", [1,0,0,1]] call _colorPicker;
	};

	PUBLIC FUNCTION("array","CallBackColorPicker") {
		hint format["Value:%1",_this];
	};

	PUBLIC FUNCTION("", "getDisplay") FUNC_GETVAR("Display");
	PUBLIC FUNCTION("", "getMainLayer") FUNC_GETVAR("MainLayer");
	PUBLIC FUNCTION("control", "setMainLayer"){ MEMBER("MainLayer", _this); };
	PUBLIC FUNCTION("display", "setDisplay"){ MEMBER("Display", _this); };
	PUBLIC FUNCTION("", "deconstructor"){
		closeDialog 0;
		DELETE_UI_VARIABLE("MainLayer");
		DELETE_UI_VARIABLE("Display");
	};
ENDCLASS;
