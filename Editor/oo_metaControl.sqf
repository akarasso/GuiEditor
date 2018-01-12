#include "..\oop.h"
		
CLASS_EXTENDS("oo_metaControl", "oo_Layer")
	PUBLIC VARIABLE("array","Childs");
	PUBLIC VARIABLE("array","ConstChilds");
	PUBLIC STATIC_VARIABLE("array","CallBack");

	PUBLIC FUNCTION("array","constructor") { 
		SUPER("constructor", _this);
		MEMBER("Callback", []);
		MEMBER("ConstChilds", []);
	};

	PUBLIC FUNCTION("array","findFirstAtPos") {
		private _return = {};
		private "_pos";
		private "_ctrlXEnd";
		private "_ctrlYEnd";
		private _posX = param[0, -1, [0]];
		private _posY = param[1, -1, [0]];
		_childs = MEMBER("Childs", nil) + MEMBER("ConstChilds", nil);
		for "_i" from (count _childs)-1 to 0 step -1 do {
			_child = _childs select _i;
			_data = "getData" call _child;
			_pos = "getPos" call _child;
			_ctrlXEnd = (_pos select 0) + (_pos select 2);
			_ctrlYEnd = (_pos select 1) + (_pos select 3);
			if (_posX >= (_pos select 0) && { _posX <= _ctrlXEnd } && { _posY >= (_pos select 1) } && { _posY <= _ctrlYEnd} && _data select INDEX_VISIBLE) exitWith {
				_return = _child;
			};
		};
		_return;
	};

	PUBLIC FUNCTION("code","isInConstChilds") {
		private _r = false;
		{
			if (_x isEqualTo _this) exitWith {
				_r = true;
			};
		} forEach MEMBER("ConstChilds", nil);
		_r;
	};

	/*
	*	Callback
	*/
	PUBLIC FUNCTION("array","addCallBack") {
		if (_this isEqualTypeParams ["", {}]) exitWith {
			MEMBER("Callback", nil) pushBack _this;
		};
		if (_this isEqualTypeParams ["", ""]) exitWith {
			private _action = _this select 0;
			private _call = compile (_this select 1);
			MEMBER("Callback", nil) pushBack [_action, _call];
		};	
	};

	PUBLIC FUNCTION("string","makeCallback") {
		private _action = _this;
		{
			if ((_x select 0) isEqualTo _action) then {
				call (_x select 1);
			};
		}forEach MEMBER("CallBack", nil);
	};

	PUBLIC FUNCTION("string","deleteAction") {
		for "_i" from count MEMBER("Callback", nil) -1 to 0 step -1 do {
			_item = MEMBER("Callback", nil) select _i;
			if (_item select 0 isEqualTo _this) then {
				MEMBER("CallBack", nil) deleteAt _i;
			};
		};
	};
	PUBLIC FUNCTION("scalar","deleteCallBack") {
		MEMBER("CallBack", nil) deleteAt _this;
	};
	PUBLIC FUNCTION("string","deleteCallBack") {
		_this = compile _this;
		MEMBER("deleteCallBack", _this);
	};
	PUBLIC FUNCTION("code","deleteCallBack") {
		{
			if ((_x select 1) isEqualTo _this) then {
				MEMBER("CallBack", nil) deleteAt _forEachIndex;
			};
		}forEach MEMBER("CallBack", nil);
	};

	PUBLIC FUNCTION("","getCallBack") {
		MEMBER("CallBack", nil);
	};
	PUBLIC FUNCTION("string","getCallBack") {
		private _return = [];
		{
			if ((_x select 0) isEqualTo _this) then {
				_return pushBack _x;
			};
		} forEach MEMBER("CallBack", nil);
		_return;
	};
	
	PUBLIC FUNCTION("","resetCallBack") {
		MEMBER("CallBack", []);
	};
ENDCLASS;
