#include "..\oop.h"

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

CLASS_EXTENDS("oo_newMeta", "oo_metaControl")
	

	PUBLIC FUNCTION("scalar","constructor") { 
		disableSerialization;
		private _display = "getDisplay" call GuiObject;
		private _workground = "getWorkground" call GuiObject;
		private _control = controlNull;
		private _type = _class;
		private _id = _this;
		private _layer = "getControl" call _workground;
		private _control = _display ctrlCreate["OOP_SubLayer", _id, _layer];
		_control ctrlSetPosition [0,0,1,1];
		_control ctrlCommit 0;
		private _picture = _display ctrlCreate["OOP_Picture", -50, _control];

		MEMBER("Display", _display);
		MEMBER("Parent", _workground);
		MEMBER("Control", _control);
		MEMBER("ID", _id);
		
		private _noColor = [-1,-1,-1,-1], _data = [];
		_data set [INDEX_POSITION, (ctrlPosition _control)];
		_data set [INDEX_TEXT, (ctrlText _control)];
		_data set [INDEX_NAME, ""];
		_data set [INDEX_TP, ""];
		_data set [INDEX_CONTROL_CLASS, _type];
		_data set [INDEX_VISIBLE, true];
		_data set [INDEX_EVH, []];
		
		_data set [INDEX_TEXT_COLOR, +_noColor];
		_data set [INDEX_BGCOLOR, +_noColor];
		_data set [INDEX_FGCOLOR, +_noColor];
		_data set [INDEX_TP_COLOR_BOX, +_noColor];
		_data set [INDEX_TP_COLOR_SHADE, +_noColor];
		_data set [INDEX_TP_COLOR_TEXT, +_noColor];
		MEMBER("Data", _data);
	};

	
 
	PUBLIC FUNCTION("","getParentClass") {
		_parentClass;
	};
ENDCLASS;