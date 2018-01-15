#include "..\oop.h"
CLASS_EXTENDS("oo_SliderH", "oo_metaControl")

	PUBLIC UI_VARIABLE("control", "TopArrow");
	PUBLIC UI_VARIABLE("control", "BottomArrow");
	PUBLIC UI_VARIABLE("control", "TopSlider");
	PUBLIC UI_VARIABLE("control", "BottomSlider");
	PUBLIC UI_VARIABLE("bool", "Pressing");
	PUBLIC VARIABLE("scalar", "Value");
	PUBLIC VARIABLE("scalar", "Decimal");

	PUBLIC FUNCTION("array","constructor") {
		disableSerialization; 
		SUPER("constructor", _this);
		MEMBER("Value", 0);
		MEMBER("Pressing", false);
		MEMBER("Decimal", 0);
		
		MEMBER("Control", nil) ctrlAddEventHandler["MouseMoving", format["['MouseMoving', _this] call %1;", _code] ];
		MEMBER("Control", nil) ctrlAddEventHandler["MouseButtonDown", format["['MouseButtonDown', _this] call %1;", _code] ];
		MEMBER("Control", nil) ctrlAddEventHandler["MouseButtonUp", format["['MouseButtonUp', _this] call %1;", _code] ];

		private _topArrow = (_this select 0) ctrlCreate["OOP_Picture", -2, MEMBER("Control", nil)];
		_topArrow ctrlSetText "#(rgb,8,8,3)color(0,1,0,1)";
		private _bottomArrow = (_this select 0) ctrlCreate["OOP_Picture", -3, MEMBER("Control", nil)];
		_bottomArrow ctrlSetText "#(rgb,8,8,3)color(1,0,0,1)";
		private _topSlider = (_this select 0) ctrlCreate["OOP_Picture", -4, MEMBER("Control", nil)];
		_topSlider ctrlSetText "#(rgb,8,8,3)color(0,0,0,1)";
		private _bottomSlider = (_this select 0) ctrlCreate["OOP_Picture", -5, MEMBER("Control", nil)];
		_bottomSlider ctrlSetText "#(rgb,8,8,3)color(1,1,1,1)";

		MEMBER("TopArrow", _topArrow);
		MEMBER("BottomArrow", _bottomArrow);
		MEMBER("TopSlider", _topSlider);
		MEMBER("BottomSlider", _bottomSlider);
	};

	PUBLIC FUNCTION("scalar","setDecimal") {
		if (_this > -1) then {
			MEMBER("Decimal", _this);
		};		
	};

	PUBLIC FUNCTION("array","setPos") {
		SUPER("setPos", _this);
		MEMBER("TopArrow", nil) ctrlSetPosition [0,0, _this select 2, (_this select 3)*0.2];
		MEMBER("BottomArrow", nil) ctrlSetPosition [0,(_this select 3)*0.8, _this select 2, (_this select 3)*0.2];
		MEMBER("TopSlider", nil) ctrlSetPosition [0,(_this select 3) * 0.2,	(_this select 3) * 0.2,	((_this select 3)-2*((_this select 3) * 0.2))*(1-(MEMBER("Value", nil)/100))];
		MEMBER("BottomSlider", nil) ctrlSetPosition[0,((_this select 3)*0.2)+((_this select 3)-2*((_this select 3)*0.2))*(1-(MEMBER("Value", nil)/100)),(_this select 3)*0.2,((_this select 3) - 2*((_this select 3) * 0.2)) - ((_this select 3) - 2*((_this select 3) * 0.2)) * (1-(MEMBER("Value", nil)/100))];

		MEMBER("TopArrow", nil) ctrlCommit 0;
		MEMBER("BottomArrow", nil) ctrlCommit 0;
		MEMBER("TopSlider", nil) ctrlCommit 0;
		MEMBER("BottomSlider", nil) ctrlCommit 0;
	};

	PUBLIC FUNCTION("string","setTopArrow") {
		MEMBER("TopArrow", nil) ctrlSetText _this;
	};
	PUBLIC FUNCTION("array","setTopArrow") {
		private _texture = ["getTextureFromArray", _this] call HelperGui;
		MEMBER("TopArrow", nil) ctrlSetText _texture;
	};

	/*
	*	Bottom Arrow
	*/
	PUBLIC FUNCTION("string","setBottomArrow") {
		MEMBER("BottomArrow", nil) ctrlSetText _this;
	};
	PUBLIC FUNCTION("array","setBottomArrow") {
		private _texture = ["getTextureFromArray", _this] call HelperGui;
		MEMBER("BottomArrow", nil) ctrlSetText _texture;
	};
	
	/*
	*	Background
	*/
	PUBLIC FUNCTION("array","setBackgroundSlider") {
		private _texture = ["getTextureFromArray", _this] call HelperGui;
		MEMBER("TopSlider", nil) ctrlSetText _texture;
	};

	PUBLIC FUNCTION("string","setBackgroundSlider") {
		MEMBER("TopSlider", nil) ctrlSetText _this;
	};

	/*
	*	Foreground
	*/
	PUBLIC FUNCTION("array","setForegroundSlider") {
		private _texture = ["getTextureFromArray", _this] call HelperGui;
		MEMBER("BottomSlider", nil) ctrlSetText _texture;
	};

	PUBLIC FUNCTION("string","setForegroundSlider") {
		MEMBER("BottomSlider", nil) ctrlSetText _this;
	};

	PUBLIC FUNCTION("array","MouseButtonDown") {
		if ((_this select 1) isEqualTo 0) then {
			MEMBER("Pressing", true);
			_this deleteAt 1;
			MEMBER("MouseMoving", _this);
		};
	};

	/*
	* EVH
	*/
	PUBLIC FUNCTION("array","MouseButtonUp") {
		if ((_this select 1) isEqualTo 0) then {
			MEMBER("Pressing", false);
		};
	};
	
	PUBLIC FUNCTION("array","MouseMoving") {
		if !(MEMBER("Pressing", nil)) exitWith {};
		private _pos = ctrlPosition MEMBER("Control", nil);
		private _relativePos = (_this select 2) - (_pos select 1);
		if (_relativePos < (_pos select 3) * 0.2) exitWith { MEMBER("setValue", 100); };
		if (_relativePos > (_pos select 3) - (_pos select 3) * 0.2) exitWith { MEMBER("setValue", 0); };
		MEMBER("setValue", (1-(_relativePos - ((_pos select 3)*0.2)) / ((_pos select 3)-2*((_pos select 3)*0.2)))*100);
	};

	PUBLIC FUNCTION("","refreshPosition") {
		private _control = MEMBER("Control", nil);
		private _pos = ctrlPosition _control;

		MEMBER("TopArrow", nil) ctrlSetPosition [
			0,
			0,
			(_pos select 3) * 0.2,
			(_pos select 3) * 0.2
		];
		MEMBER("TopArrow", nil) ctrlCommit 0;
		MEMBER("BottomArrow", nil) ctrlSetPosition [
			0,
			(_pos select 3) - ((_pos select 3) * 0.2),
			(_pos select 3) * 0.2,
			(_pos select 3) * 0.2
		];
		MEMBER("BottomArrow", nil) ctrlCommit 0;

		MEMBER("TopSlider", nil) ctrlSetPosition [
			0,
			(_pos select 3) * 0.2,
			(_pos select 3) * 0.2,
			((_pos select 3) - 2*((_pos select 3) * 0.2)) * (1-(MEMBER("Value", nil)/100))
		];
		MEMBER("TopSlider", nil) ctrlCommit 0;

		MEMBER("BottomSlider", nil) ctrlSetPosition[
			0,
			((_pos select 3) * 0.2) + ((_pos select 3) - 2*((_pos select 3) * 0.2)) * (1-(MEMBER("Value", nil)/100)),
			(_pos select 3) * 0.2,
			((_pos select 3) - 2*((_pos select 3) * 0.2)) - ((_pos select 3) - 2*((_pos select 3) * 0.2)) * (1-(MEMBER("Value", nil)/100))
		];
		MEMBER("BottomSlider", nil) ctrlCommit 0;
		_pos set [2, (_pos select 3)*0.2];
		_control ctrlSetPosition _pos;
	};

	PUBLIC FUNCTION("scalar","setValue") {
		private _n = parseNumber (_this toFixed MEMBER("Decimal", nil));
		MEMBER("Value", _n);
		MEMBER("refreshPosition", nil);
		MEMBER("makeCallBack", _n);
	};

	PUBLIC FUNCTION("","getValue") {
		MEMBER("Value", nil);
	};
ENDCLASS;
