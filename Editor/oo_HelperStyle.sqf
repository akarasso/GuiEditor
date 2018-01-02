#include "..\oop.h"

CLASS("oo_HelperStyle")
	PUBLIC UI_VARIABLE("display", "Display");

	PUBLIC FUNCTION("display","constructor") { 
		MEMBER("Display", _this);
	};

	PUBLIC FUNCTION("array","close") {
		disableSerialization;
		private _control = _this select 0;
		private _second = _this select 1;
		private _from = _this select 2;
		private _position = ctrlPosition _control;
		
		switch (_from) do { 
			case "left" : {
				_npos = [_position select 0, _position select 1, 0, _position select 3];
				_control ctrlSetPosition _npos;
				_control ctrlCommit _second;
			};
			case "right" : {
				_npos = [(_position select 0) + (_position select 2), _position select 1, 0, _position select 3];
				_control ctrlSetPosition _npos;
				_control ctrlCommit _second;
			}; 
			case "bottom" : {
				_npos = [(_position select 0), (_position select 1) - (_position select 3), _position select 2, 0];
				_control ctrlSetPosition _npos;
				_control ctrlCommit _second;
			}; 
			case "top" : {
				_npos = [(_position select 0), (_position select 1) + (_position select 3), _position select 2, 0];
				_control ctrlSetPosition _npos;
				_control ctrlCommit _second;
			};
			default {  /*...code...*/ }; 
		};
	};
ENDCLASS;

