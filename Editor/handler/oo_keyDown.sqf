#include "..\..\oop.h"
CLASS("oo_keyDown")
	PUBLIC FUNCTION("","constructor") { 
		("getDisplay" call GuiObject) displayAddEventHandler["KeyDown", format["['KeyDown', _this] call %1;", _code] ];		
	};

	PUBLIC FUNCTION("array","KeyDown") {
		private _DikCode = param[1, -1, [-1]];
		MEMBER("CtrlPressing", _this select 3);
		MEMBER("AltPressing", _this select 4);
		private _arr = [0,0,0,0];
		private _noReturn = false;

		private _workground = "getWorkground" call GuiObject;
		private _selCtrl = "getSelCtrl" call GuiObject;
		private _size = "getSize" call MEMBER("GridObject", nil);
		private _sizeX = safezoneW/(_size select 0);
		private _sizeY = safezoneH/(_size select 1);
		switch (_DikCode) do { 
			case DIK_F1:{
				//Implement help
			};

			case DIK_F2 : {
				if !(_workground isEqualTo ("getView" call GuiObject)) then {
					private _parent = "getParent" call _workground;
					MEMBER("copyControl", {});
					["setActiveLayer", _parent] call GuiObject;
				};
			};
			
			case DIK_F3:{
				"openGeneralCfg" call GuiObject;
			};

			case DIK_F4:{
				"exportHPP" call GuiObject;
			};

			case DIK_F5:{
				"exportOOP" call GuiObject;
			};

			case DIK_O:{
				if!(_workground isEqualTo ("getView" call GuiObject)) then {
					"switchFullScreen" call _workground;
				};				
			};

			case DIK_I:{
				"importFromClipboard" call GuiObject;
			};

			case DIK_T:{
				"show" call MEMBER("TreeDialog", nil);
			};

			case DIK_F6:{
				["setAllEnable", true] call GuiObject;
			};

			case DIK_SPACE:{
				"colorizeControl" call _workground;
				_noReturn = true;
			};

			case DIK_NEXT:{
				if !(MEMBER("TreeDialog", nil) isEqualTo controlNull) then {
					private _path = tvCurSel MEMBER("TreeDialog", nil);
					private _item = call compile (MEMBER("TreeDialog", nil) tvData _path);
					if (_item isEqualTo ("getView" call GuiObject)) exitWith {};
						private _posChilds = "getPositionInChilds" call _item;
						if (_posChilds > 0) then {	
							"moveUpControl" call _item;
							MEMBER("fillDisplayTree", nil);
							_path set [(count _path) - 1, (_path select ((count _path) -1)) + 1];
							MEMBER("TreeDialog", nil) tvSetCurSel _path;
							"refreshDisplay" call GuiObject;
						};
					_noReturn = true;
				};
			};

			case DIK_PRIOR:{
				if !(MEMBER("TreeDialog", nil) isEqualTo controlNull) then {
					private _path = tvCurSel MEMBER("TreeDialog", nil);
					private _item = call compile (MEMBER("TreeDialog", nil) tvData _path);
					if (_item isEqualTo ("getView" call GuiObject)) exitWith {};
						private _posChilds = "getPositionInChilds" call _item;
						private _countChilds = "getParentCountChilds" call _item;
						if (_posChilds < _countChilds - 1) then {
							"moveDownControl" call _item;
							MEMBER("fillDisplayTree", nil);
							_path set [(count _path) - 1, (_path select ((count _path) -1)) - 1];
							MEMBER("TreeDialog", nil) tvSetCurSel _path;
							"refreshDisplay" call GuiObject;
						};
					_noReturn = true;
				};
			};

			case DIK_H: {
				if !(MEMBER("TreeDialog", nil) isEqualTo controlNull) exitWith {
					private _path = tvCurSel MEMBER("TreeDialog", nil);
					private _item = call compile (MEMBER("TreeDialog", nil) tvData _path);
					if (_item isEqualTo ("getView" call GuiObject)) exitWith {};

					private _control = "getControl" call _item;
					if (ctrlShown _control) then {
						["setVisible", false] call _item;
					}else{
						["setVisible", true] call _item;
					};
					MEMBER("fillDisplayTree", nil);
					MEMBER("TreeDialog", nil) tvSetCurSel _path;
				};
				private _res = ["findFirstAtPos", MEMBER("MousePos", nil)] call _workground;
				if!(_res isEqualTo {}) exitWith {
					private _control = "getControl" call _res;
					if (ctrlShown _control) then {
						["setVisible", false] call _res;
					}else{
						["setVisible", true] call _res;
					};
				};
			};

			case DIK_DELETE : {
				private _res = ["findFirstAtPos", MEMBER("MousePos", nil)] call _workground;
				
				if (_res isEqualTo {}) exitWith {
					private _ctrlSel = "getSelCtrl" call GuiObject;
					if !(_ctrlSel isEqualTo {}) then {
						diag_log format["ParentClass:%1", "getParentClass" call _workground];
						if (("getParentClass" call _workground) isEqualTo "oo_metaControl") exitWith {

							if (["isInConstChilds", _ctrlSel] call _workground) then {
								hint "You can't delete control inside meta control";
							}else{
								["delete", _ctrlSel] call oo_Control;
								["deleteCtrl", _ctrlSel] call _workground;
								MEMBER("fillDisplayTree", nil);
							};
						};
						["delete", _ctrlSel] call oo_Control;
						["deleteCtrl", _ctrlSel] call _workground;
						MEMBER("fillDisplayTree", nil);
					};
				};
				if !(_res isEqualTo ("getView" call GuiObject)) then {
					if (("getParentClass" call _workground) isEqualTo "oo_metaControl") exitWith {
						if (["isInConstChilds", _res] call _workground) then {
							hint "You can't delete control inside meta control";
						}else{
							["delete", _res] call oo_Control;
							["deleteCtrl", _res] call _workground;
							MEMBER("fillDisplayTree", nil);
						};
					};
					if ("getTypeName" call _res isEqualTo "oo_Control") then {
						["delete", _res] call oo_Control;
						["deleteCtrl", _res] call _workground;
					};
					if ("getTypeName" call _res isEqualTo "oo_Layer") then {
						["delete", _res] call oo_Layer;
						["deleteCtrl", _res] call _workground;
					};
				};				
				MEMBER("fillDisplayTree", nil);			
			};

			case DIK_C:{
				if (MEMBER("CtrlPressing", nil)) exitWith {
					private _res = ["findFirstAtPos", MEMBER("MousePos", nil)] call _workground;
					if (_res isEqualTo {}) exitWith {
						MEMBER("copyControl", {});
					};
					MEMBER("copyControl", _res);
				};
				if (_selCtrl isEqualTo {}) exitWith {
					private _res = ["findFirstAtPos", MEMBER("MousePos", nil)] call _workground;
					if !(_res isEqualTo {}) then {
						"centerH" call _res;
						["setSelCtrl", _res] call GuiObject;
					};
				};
				"centerH" call _selCtrl;
			};

			case DIK_V:{
				if (MEMBER("CtrlPressing", nil)) exitWith {
				 	if !(MEMBER("copyControl", nil) isEqualTo {}) then {
				 		if ("getParentClass" call _workground isEqualTo "oo_metaControl") exitWith {
				 			if (["isInConstChilds", MEMBER("copyControl", nil)] call _workground) then {
				 				hint "You can't copy/paste constant control";
				 			}else{
				 				private _pasteCtrl = ["ctrlCreate", "getType" call MEMBER("copyControl", nil)] call GuiObject;
						 		private _a = [MEMBER("copyControl", nil), _pasteCtrl];
						 		MEMBER("copyControl", _a);
						 		["setPos", MEMBER("MousePos", nil)] call _pasteCtrl;
						 		["pushChild", _pasteCtrl] call _workground;
				 			};				 			
				 		};
				 		if ("getParentClass" call MEMBER("copyControl", nil) isEqualTo "oo_metaControl") exitWith {
				 			diag_log format["Type:%1","getType" call MEMBER("copyControl", nil)];
					 		private _pasteCtrl = ["ctrlCreate", "getType" call MEMBER("copyControl", nil)] call GuiObject;
					 		["setPos", MEMBER("MousePos", nil)] call _pasteCtrl;
					 		["pushChild", _pasteCtrl] call _workground;
					 		"RefreshAllBoundBox" call GuiObject;
				 		};
				 		if ("getTypeName" call MEMBER("copyControl", nil) isEqualTo "oo_Control") exitWith {
					 		private _pasteCtrl = ["ctrlCreate", "getType" call MEMBER("copyControl", nil)] call GuiObject;
					 		private _a = [MEMBER("copyControl", nil), _pasteCtrl];
					 		MEMBER("copyControl", _a);
					 		["setPos", MEMBER("MousePos", nil)] call _pasteCtrl;
					 		["pushChild", _pasteCtrl] call _workground;
				 		};
				 		if ("getTypeName" call MEMBER("copyControl", nil) isEqualTo "oo_Layer") exitWith {
				 			private _newLayer = ["ctrlCreate", "getType" call MEMBER("copyControl", nil)] call GuiObject;
				 			private _a = [MEMBER("copyControl", nil), _newLayer];
				 			MEMBER("copyChilds", _a);
				 			["setPos", MEMBER("MousePos", nil)] call _newLayer;
				 			["pushChild", _newLayer] call _workground;
				 			"RefreshAllBoundBox" call GuiObject;
				 		};
				 	};
				};
				if (_selCtrl isEqualTo {}) then {
					private _res = ["findFirstAtPos", MEMBER("MousePos", nil)] call _workground;
					if !(_res isEqualTo {}) then {
						"centerV" call _res;
					};
				};
				"centerV" call _selCtrl;
			};

			case DIK_DOWNARROW:{
				if (MEMBER("AltPressing", nil)) exitWith {
					if (MEMBER("CtrlPressing", nil)) then {
						_arr = [0,0,0,_sizeY/2];
					}else{
						_arr = [0,0,0,_sizeY];
					};
					["relativeMove", _arr] call GuiObject;
				};
				if (MEMBER("CtrlPressing", nil)) then {
					_arr = [0,_sizeY/2,0,0];
				}else{
					_arr = [0,_sizeY,0,0];
				};
				["relativeMove", _arr] call GuiObject;
			};

			case DIK_UPARROW:{
				if (MEMBER("AltPressing", nil)) exitWith {
					if (MEMBER("CtrlPressing", nil)) then {
						_arr = [0,0,0,-_sizeY/2];
					}else{
						_arr = [0,0,0,-_sizeY];
					};
					["relativeMove", _arr] call GuiObject;
				};
				if (MEMBER("CtrlPressing", nil)) then {
					_arr = [0,-_sizeY/2,0,0];
				}else{
					_arr = [0,-_sizeY,0,0];
				};
				["relativeMove", _arr] call GuiObject;
			};

			case DIK_RIGHTARROW:{
				if (MEMBER("AltPressing", nil)) exitWith {
					if (MEMBER("CtrlPressing", nil)) then {
						_arr = [0,0,_sizeX/2,0];
					}else{
						_arr = [0,0,_sizeX,0];
					};
					["relativeMove", _arr] call GuiObject;
				};
				if (MEMBER("CtrlPressing", nil)) then {
					_arr = [_sizeX/2,0,0,0];
				}else{
					_arr = [_sizeX,0,0,0];
				};
				["relativeMove", _arr] call GuiObject;
			};

			case DIK_LEFTARROW:{
				if (MEMBER("AltPressing", nil)) exitWith {
					if (MEMBER("CtrlPressing", nil)) then {
						_arr = [0,0,-_sizeX/2,0];
					}else{
						_arr = [0,0,-_sizeX,0];
					};
					_arr = [0,0,-_sizeX,0];
					["relativeMove", _arr] call GuiObject;
				};
				if (MEMBER("CtrlPressing", nil)) then {
					_arr = [-_sizeX/2,0,0,0];
				}else{
					_arr = [-_sizeX,0,0,0];
				};
				["relativeMove", _arr] call GuiObject;
			};
			case DIK_ESCAPE : {
				closeDialog 0;	
			};			
			default {}; 
		};
		_noReturn;
	};
ENDCLASS;