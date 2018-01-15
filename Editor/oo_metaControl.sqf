#include "..\oop.h"
		
CLASS("oo_metaControl")

	PUBLIC UI_VARIABLE("display","Display");
	PUBLIC UI_VARIABLE("control","Parent");
	PUBLIC UI_VARIABLE("control","Control");
	PUBLIC UI_VARIABLE("control","Background");
	PUBLIC UI_VARIABLE("array","Border");
	PUBLIC UI_VARIABLE("scalar","BorderSize");
	PUBLIC UI_VARIABLE("string","BorderColor");

	PUBLIC VARIABLE("array","CallBack");

	PUBLIC FUNCTION("array","constructor") { 
		MEMBER("Display", _this select 0);
		MEMBER("Parent", _this select 1);
		MEMBER("Border", []);
		MEMBER("BorderSize", 0.005);
		MEMBER("BorderColor", "#(rgb,8,8,3)color(1,1,1,1)");
		private _control = if ((_this select 1) isEqualTo controlNull) then {
			(_this select 0) ctrlCreate["RscControlsGroupNoScrollbars", -10];
		}else{
			(_this select 0) ctrlCreate["RscControlsGroupNoScrollbars", -10, (_this select 1)];
		};
		MEMBER("Control", _control);
		private _bg = (_this select 0) ctrlCreate["OOP_Picture", -11, _control];
		_bg ctrlSetText "#(rgb,8,8,3)color(0,0,0,0)";
		MEMBER("Background", _bg);
		
		private _border = (_this select 0) ctrlCreate["RscPicture", -4, _control];
		_border ctrlSetText "#(rgb,8,8,3)color(0,0,0,0)";
		_border1 = (_this select 0) ctrlCreate["RscPicture", -4, _control];
		_border ctrlSetText "#(rgb,8,8,3)color(0,0,0,0)";
		_border2 = (_this select 0) ctrlCreate["RscPicture", -4, _control];
		_border ctrlSetText "#(rgb,8,8,3)color(0,0,0,0)";
		_border3 = (_this select 0) ctrlCreate["RscPicture", -4, _control];
		_border ctrlSetText "#(rgb,8,8,3)color(0,0,0,0)";
		
		MEMBER("Border", nil) pushBack _border;
		MEMBER("Border", nil) pushBack _border1;
		MEMBER("Border", nil) pushBack _border2;
		MEMBER("Border", nil) pushBack _border3;

		MEMBER("CallBack", []);
	};

	PUBLIC FUNCTION("array","setPos") {
		MEMBER("Control", nil) ctrlSetPosition _this;
		MEMBER("Control", nil) ctrlCommit 0;
		private _pos = ctrlPosition MEMBER("Control", nil);
		MEMBER("Background", nil) ctrlSetPosition [0, 0,_pos select 2, _pos select 3];
		MEMBER("Background", nil) ctrlCommit 0;
		MEMBER("setBorderSize", MEMBER("BorderSize", nil));
	};

	PUBLIC FUNCTION("","removeBorder") {
		{
			_x ctrlSetText "#(rgb,8,8,3)color(0,0,0,0)";
		} forEach MEMBER("Border", nil);
	};

	PUBLIC FUNCTION("scalar","setBorderSize") {
		MEMBER("BorderSize", _this);
		MEMBER("setBorderSizeX", _this);
		MEMBER("setBorderSizeY", _this);

		{
			_x ctrlCommit 0;
		} forEach MEMBER("Border", nil);
	};

	//Left Right
	PUBLIC FUNCTION("scalar","setBorderSizeX") {
		private _pos = ctrlPosition MEMBER("Control", nil);
		(MEMBER("Border", nil) select 0) ctrlSetPosition [0,0,_this,(_pos select 3)];
		(MEMBER("Border", nil) select 1) ctrlSetPosition [(_pos select 2)- _this,0,_this,(_pos select 3)];
	};
	//Top bottom
	PUBLIC FUNCTION("scalar","setBorderSizeY") {
		private _pos = ctrlPosition MEMBER("Control", nil);
		(MEMBER("Border", nil) select 2) ctrlSetPosition [0,0,_pos select 2, _this];
		(MEMBER("Border", nil) select 3) ctrlSetPosition [0,(_pos select 3) - _this, _pos select 2, _this];
	};
	PUBLIC FUNCTION("string","setBorderColor") {
		{
			_x ctrlSetText _this;
		} forEach MEMBER("Border", nil);
		MEMBER("setBorderSize", MEMBER("BorderSize", nil));
	};

	PUBLIC FUNCTION("array","setBorderColor") {
		private _texture = ["getTextureFromArray", _this] call HelperGui;
		MEMBER("setBorderColor", _texture);
	};
		

	PUBLIC FUNCTION("","getPos") {
		ctrlPosition MEMBER("Control", nil);
	};

	PUBLIC FUNCTION("","ctrlDelete") {
		ctrlDelete MEMBER("Control", nil);
	};

	PUBLIC FUNCTION("bool","ctrlShow") {
		MEMBER("Control", nil) ctrlShow _this;
	};

	PUBLIC FUNCTION("string","setBackground") {
		MEMBER("Background", nil) ctrlSetText _this;
	};

	PUBLIC FUNCTION("array","setBackground") {
		MEMBER("Background", nil) ctrlSetText (["getTextureFromArray", _this] call HelperGui);
	};
	/*
	*	Callback
	*/

	PUBLIC FUNCTION("code","addCallBack") {
		MEMBER("CallBack", nil) pushBack _this;
	};
	PUBLIC FUNCTION("string","addCallBack") {
		MEMBER("CallBack", nil) pushBack (compile _this);
	};

	PUBLIC FUNCTION("any","makeCallBack") {
		{
			_this call _x;
		} forEach MEMBER("CallBack", nil);
	};
	PUBLIC FUNCTION("","removeAllCallBack") {
		MEMBER("CallBack", []);
	};

ENDCLASS;
