#include "..\oop.h"
CLASS("oo_GRIDLayer")

	PUBLIC UI_VARIABLE("display", "Display");
	PUBLIC UI_VARIABLE("control", "GRIDLayer");
	PUBLIC UI_VARIABLE("array", "Childs");
	PUBLIC VARIABLE("array", "Size");
	PUBLIC VARIABLE("scalar", "SizeW");
	PUBLIC VARIABLE("scalar", "SizeH");

	PUBLIC FUNCTION("","constructor") {
		disableSerialization;
		MEMBER("Display", displayNull);
		MEMBER("GRIDLayer", controlNull);
		private _a = [80,50];
		MEMBER("Size", _a);
		MEMBER("Childs", []);
	};

	PUBLIC FUNCTION("display","createGridLayer") {
		disableSerialization;
		MEMBER("Display", _this);
		private _GRIDLayer = _this ctrlCreate["OOP_MainLayer", 3];
		MEMBER("GRIDLayer", _GRIDLayer);
		_GRIDLayer;
	};

	PUBLIC FUNCTION("","genGrid"){
		private _layer = MEMBER("GRIDLayer", nil);
		if (_layer isEqualTo controlNull) exitWith {
			diag_log "genGrid null layer";
		};
		private "_ctrl";
		private _pos = ctrlPosition MEMBER("GRIDLayer", nil);

		private _gridX = (_pos select 2)/(MEMBER("Size", nil) select 0);
		private _gridY = (_pos select 3)/(MEMBER("Size", nil) select 1);
		MEMBER("SizeW", _gridX);
		MEMBER("SizeH", _gridY);

		private _thicknessX = 0.001 * safezoneH;
		private _thicknessY = _thicknessX * 4/3;

		for "_x" from 0 to (_pos select 2) step _gridX do {
			_ctrl = MEMBER("Display", nil) ctrlCreate ["RscText", -1, MEMBER("GRIDLayer", nil)];
			_ctrl ctrlsetposition [
				_x,
				0,
				_thicknessX,
				_pos select 3
			];
			_ctrl ctrlsetbackgroundcolor [0,0,0,0.1];
			_ctrl ctrlcommit 0;
			MEMBER("Childs", nil) pushBack _ctrl;
		};

		for "_y" from 0 to (_pos select 3) step _gridY do {
			_ctrl = MEMBER("Display", nil) ctrlCreate ["RscText", -1, MEMBER("GRIDLayer", nil)];
			_ctrl ctrlsetposition [
				0,
				_y,
				_pos select 2,
				_thicknessY
			];
			_ctrl ctrlsetbackgroundcolor [0,0,0,0.5];
			_ctrl ctrlcommit 0;
			MEMBER("Childs", nil) pushBack _ctrl;
		};
	};

	PUBLIC FUNCTION("","getSize") {
		MEMBER("Size", nil);
	};

	PUBLIC FUNCTION("","getSizeW") {
		MEMBER("SizeW", nil);
	};
	PUBLIC FUNCTION("","getSizeH") {
		MEMBER("SizeH", nil);
	};
ENDCLASS;