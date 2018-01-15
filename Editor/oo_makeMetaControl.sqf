#include "..\oop.h"
CLASS_EXTENDS("oo_makeMetaControl", "oo_makeOOPFile")
	
	PUBLIC VARIABLE("string", "MetaControl");

	PUBLIC VARIABLE("array", "StaticConstructorString"); // construct

	PUBLIC FUNCTION("string","constructor") {
		SUPER("constructor", nil);
		MEMBER("MetaControl", _this);
		MEMBER("FunctionList", []); // list de mes events
		MEMBER("VariableList", []); //Vars
		MEMBER("ConstructorString", []); // exec code du constructor
		MEMBER("StaticConstructorString", []); // set mes variables
		
		private _v = ["ui","code","Display"];
		MEMBER("addUIVar", _v);
		private _v = ["ui","control","MetaControl"];
		MEMBER("addUIVar", _v);
	};

	PUBLIC FUNCTION("array","addStaticConstructorString") {
		MEMBER("StaticConstructorString", nil) pushBack _this;
	};

	PUBLIC FUNCTION("","sort") {
		SUPER("sort", nil);
		MEMBER("StaticConstructorString", nil) sort true;
	};

	PUBLIC FUNCTION("","exec") {
		MEMBER("sort", nil);
		private _string = "", _doc = [], _complete = [];
		MEMBER("Buffer", "");
		MEMBER("pushLine", '#include "..\oop.h"');

		_string = "CLASS_EXTENDS(" + format['"oo_%1", "oo_metaControl")', MEMBER("MetaControl", nil)];
		MEMBER("pushLine", _string);
		MEMBER("modTab", +1);

		MEMBER("importVariableList", nil);
		MEMBER("pushLineBreak", nil);

		/*
		*	Constructor
		*/
		_string = "PUBLIC FUNCTION(" + '"scalar", "constructor"){';
		MEMBER("pushLine", _string );
		MEMBER("modTab", +1);
		MEMBER("pushLine", "disableSerialization;");
		_string = 'private _display = uiNamespace getVariable "openDisplay";';
		MEMBER("pushLine", _string);
		_string = "MEMBER(" + '"Display", _display);';
		MEMBER("pushLine", _string);
		
		{
			MEMBER("pushLine", (_x select 1));
		} forEach MEMBER("ConstructorString", nil);

		MEMBER("modTab", -1);
		MEMBER("pushLine", "};" );		

		/*
		*	Constructor static
		*/
		_string = "PUBLIC FUNCTION(" + '"array", "constructor"){';
		MEMBER("pushLine", _string );
		MEMBER("modTab", +1);
		_string = "SUPER("+ '"constructor", _this);';
		MEMBER("pushLine", _string);
		_string = '["setActiveLayer", _code] call GuiObject;';
		MEMBER("pushLine", _string);
		MEMBER("pushLineBreak", nil);

		{
			MEMBER("pushLine", (_x select 1));
		} forEach MEMBER("StaticConstructorString", nil);

		MEMBER("pushLineBreak", nil);
		_string = '["setActiveLayer",' + "MEMBER("+'"Parent", nil)] call GuiObject;';
		MEMBER("pushLine", _string );
		MEMBER("modTab", -1);
		MEMBER("pushLine", "};" );

		/*
		*	Functions
		*/
		MEMBER("importFunctionList", nil);

		/*
		*	Getter/Setter
		*/
		MEMBER("makeGetterAndSetter", nil);

		_string = "PUBLIC FUNCTION(" + format['"", "getParentClass"){ _parentClass; }; '];
		MEMBER("pushLine", _string);

		MEMBER("modTab", -1);
		
		MEMBER("pushLine", "ENDCLASS;" );
		copyToClipboard MEMBER("Buffer", nil);
		MEMBER("Buffer", "");
	};

	PUBLIC FUNCTION("string","setMetaControl") {
		MEMBER("MetaControl", _this);
	};

	PUBLIC FUNCTION("string","addSuper") {
		MEMBER("Super", nil) pushBack _this;
	};

	PUBLIC FUNCTION("string","addSuperSetter") {
		MEMBER("SuperSetter", nil) pushBack _this;
	};

	PUBLIC FUNCTION("string","addSuperStatic") {
		MEMBER("SuperStatic", nil) pushBack _this;
	};

	PUBLIC FUNCTION("string","addSuperStaticSetter") {
		MEMBER("SuperStaticSetter", nil) pushBack _this;
	};

	PUBLIC FUNCTION("array","addFunction") {
		MEMBER("Functions", nil) pushBack _this;
	};
	

	/*
	*	same as addVar but in uiNamespace
	*/
	PUBLIC FUNCTION("array","addUIVar") {
		private _level = toUpper (_this select 0);
		private _typeName = toLower (_this select 1);
		private _name = _this select 2;
		MEMBER("UIVariables", nil) pushBack [_level, _typeName, _name];
	};

	PUBLIC FUNCTION("array","addVar") {
		private _level = toUpper (_this select 0);
		private _typeName = toLower (_this select 1);
		private _name = _this select 2;
		MEMBER("Variables", nil) pushBack [_level, _typeName, _name];
	};

	PUBLIC FUNCTION("","getVar") {
		MEMBER("Variables", nil);
	};
	PUBLIC FUNCTION("","getUIVar") {
		MEMBER("UIVariables", nil);
	};
	PUBLIC FUNCTION("","getFunctions") {
		MEMBER("Functions", nil);
	};
	PUBLIC FUNCTION("","getSuperStatic") {
		MEMBER("SuperStatic", nil);
	};
	PUBLIC FUNCTION("","getSuper") {
		MEMBER("Super", nil);
	};
	PUBLIC FUNCTION("","getSuperSetter") {
		MEMBER("SuperSetter", nil);
	};

ENDCLASS;