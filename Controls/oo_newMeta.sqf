#include "..\oop.h"

CLASS_EXTENDS("oo_newMeta", "oo_metaControl")

	PUBLIC FUNCTION("scalar","constructor") { 
		//
		// MEMBER("name", _display displayCtrl (_this + 123));
	};

	PUBLIC FUNCTION("array","constructor") {
		// SUPER("constructor", _this);
		// ["setActiveLayer", _code] call GuiObject;
		
		// private _picture = ["ctrlCreate", "OOP_Picture"] call GuiObject;
		// ["setPos", [0,0,0.1,0.1]]call _picture;
		// MEMBER("ConstChilds", nil) pushBack _picture;

		// ["setActiveLayer", MEMBER("Parent", nil)] call GuiObject;
	};

	PUBLIC FUNCTION("","onClick_pictureleft") {
		//doing shit
		// private _arr = [
		// 	"eventName",
		// 	controlNull,
		// 	[]
		// ];
		// MEMBER("emitEvent", nil);
		// [controlNull, ""
	};

	PUBLIC FUNCTION("","getParentClass") {
		_parentClass;
	};
ENDCLASS;