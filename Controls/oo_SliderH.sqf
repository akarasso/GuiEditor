#include "..\oop.h"
CLASS("oo_SliderH")
	PUBLIC UI_VARIABLE("display", "Display");
	PUBLIC UI_VARIABLE("control", "controlParent");
	PUBLIC UI_VARIABLE("control", "ctrlGroup");
	PUBLIC UI_VARIABLE("control", "TopArrow");
	PUBLIC UI_VARIABLE("control", "BottomArrow");
	PUBLIC UI_VARIABLE("control", "TopSlider");
	PUBLIC UI_VARIABLE("control", "BottomSlider");
	PUBLIC UI_VARIABLE("array", "SubEVHList");
	PUBLIC UI_VARIABLE("bool", "Pressing");
	
	PUBLIC VARIABLE("scalar", "Value");

	PUBLIC FUNCTION("array","constructor") {
		disableSerialization; 
		MEMBER("Display", _this select 0);
		MEMBER("controlParent", _this select 1);
		MEMBER("Pressing", false);
		MEMBER("SubEVHList", []);

		private _ctrlGroup = if ((_this select 1) isEqualTo controlNull) then {
			(_this select 0) ctrlCreate["RscControlsGroupNoScrollbars", -10];
		}else{
			(_this select 0) ctrlCreate["RscControlsGroupNoScrollbars", -10, (_this select 1)];
		};

		_ctrlGroup ctrlAddEventHandler["MouseMoving", format["['MouseMoving', _this] call %1;", _code] ];
		_ctrlGroup ctrlAddEventHandler["MouseButtonDown", format["['MouseButtonDown', _this] call %1;", _code] ];
		_ctrlGroup ctrlAddEventHandler["MouseButtonUp", format["['MouseButtonUp', _this] call %1;", _code] ];

		private _topArrow = (_this select 0) ctrlCreate["RscPicture", -2, _ctrlGroup];
		_topArrow ctrlSetText "#(rgb,8,8,3)color(0,1,0,1)";
		private _bottomArrow = (_this select 0) ctrlCreate["RscPicture", -3, _ctrlGroup];
		_bottomArrow ctrlSetText "#(rgb,8,8,3)color(1,0,0,1)";
		private _topSlider = (_this select 0) ctrlCreate["RscPicture", -4, _ctrlGroup];
		_topSlider ctrlSetText "#(rgb,8,8,3)color(0,0,0,1)";
		private _bottomSlider = (_this select 0) ctrlCreate["RscPicture", -5, _ctrlGroup];
		_bottomSlider ctrlSetText "#(rgb,8,8,3)color(1,1,1,1)";

		MEMBER("ctrlGroup", _ctrlGroup);
		MEMBER("TopArrow", _topArrow);
		MEMBER("BottomArrow", _bottomArrow);
		MEMBER("TopSlider", _topSlider);
		MEMBER("BottomSlider", _bottomSlider);
		MEMBER("Value", 20);
		MEMBER("setPos", _this select 2);
	};

	PUBLIC FUNCTION("string","setTopArrow") {
		MEMBER("TopArrow", nil) ctrlSetText _this;
	};
	PUBLIC FUNCTION("array","setTopArrow") {
		private _texture = ["getTextureFromArray", _this] call HelperGui;
		MEMBER("TopArrow", nil) ctrlSetText _texture;
	};

	PUBLIC FUNCTION("string","setBottomArrow") {
		MEMBER("BottomArrow", nil) ctrlSetText _this;
	};
	PUBLIC FUNCTION("array","setBottomArrow") {
		private _texture = ["getTextureFromArray", _this] call HelperGui;
		MEMBER("BottomArrow", nil) ctrlSetText _texture;
	};
	
	PUBLIC FUNCTION("array","setBG") {
		private _texture = ["getTextureFromArray", _this] call HelperGui;
		MEMBER("TopSlider", nil) ctrlSetText _texture;
	};

	PUBLIC FUNCTION("string","setBG") {
		MEMBER("TopSlider", nil) ctrlSetText _this;
	};

	PUBLIC FUNCTION("array","setFG") {
		private _texture = ["getTextureFromArray", _this] call HelperGui;
		MEMBER("BottomSlider", nil) ctrlSetText _texture;
	};

	PUBLIC FUNCTION("string","setFG") {
		MEMBER("BottomSlider", nil) ctrlSetText _this;
	};

	PUBLIC FUNCTION("array","MouseButtonDown") {
			if ((_this select 1) isEqualTo 0) then {
			MEMBER("Pressing", true);
		};
	};

	PUBLIC FUNCTION("array","MouseButtonUp") {
		if ((_this select 1) isEqualTo 0) then {
			MEMBER("Pressing", false);
		};
	};

	PUBLIC FUNCTION("array","MouseMoving") {
		if !(MEMBER("Pressing", nil)) exitWith {};

		private _pos = ctrlPosition MEMBER("ctrlGroup", nil);
		private _relativePos = [
			(_this select 1) - (_pos select 0), 
			(_this select 2) - (_pos select 1)
		];
		private _value = MEMBER("Value", nil);
		if (_relativePos select 1 < (_pos select 3) * 0.2) exitWith {
			if!(_value isEqualTo 100) then {
				MEMBER("setValue", 100);
				{
					call _x;
				} forEach MEMBER("SubEVHList", nil);
			};
		};
		if (_relativePos select 1 > (_pos select 3) - (_pos select 3) * 0.2) exitWith {
			if!(_value isEqualTo 0) then {
				MEMBER("setValue", 0);
				{
					call _x;
				} forEach MEMBER("SubEVHList", nil);
			};		
		};
		MEMBER("setValue", (1-(_relativePos select 1) / (_pos select 3))*100);
		{
			call _x;
		} forEach MEMBER("SubEVHList", nil);
	};

	PUBLIC FUNCTION("","refreshPosition") {
		private _ctrlGroup = MEMBER("ctrlGroup", nil);
		private _pos = ctrlPosition _ctrlGroup;

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
		_ctrlGroup ctrlSetPosition _pos;
	};

	PUBLIC FUNCTION("code","subToEVH") {
		MEMBER("SubEVHList", nil) pushBackUnique _this;
	};

	PUBLIC FUNCTION("array","setPos") {
		MEMBER("Position", _this);
		MEMBER("ctrlGroup", nil) ctrlSetPosition _this;
		MEMBER("ctrlGroup", nil) ctrlCommit 0;
		MEMBER("refreshPosition", nil);
	};

	PUBLIC FUNCTION("scalar","setValue") {
		MEMBER("Value", _this);
		MEMBER("refreshPosition", nil);
	};

	PUBLIC FUNCTION("","getValue") {
		MEMBER("Value", nil);
	};
ENDCLASS;
