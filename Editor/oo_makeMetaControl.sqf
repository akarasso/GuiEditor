#include "..\oop.h"
CLASS_EXTENDS("oo_makeMetaControl", "oo_makeFile")
	
	PUBLIC VARIABLE("string", "MetaControl");

	PUBLIC VARIABLE("array", "Variables");
	PUBLIC VARIABLE("array", "UIVariables");

	PUBLIC VARIABLE("array", "Super"); // construct
	PUBLIC VARIABLE("array", "SuperSetter"); 

	PUBLIC VARIABLE("array", "SuperStatic");
	PUBLIC VARIABLE("array", "SuperStaticSetter");
	
	PUBLIC VARIABLE("array", "Functions");
	PUBLIC VARIABLE("string", "Buffer");
	

	PUBLIC FUNCTION("","constructor") {
		diag_log "constructor make meta";
		MEMBER("Tab", 0);
		MEMBER("MetaControl", ""); // UIVars
		MEMBER("UIVariables", []); // UIVars
		MEMBER("Variables", []); //Vars
		MEMBER("Super", []); // exec code du constructor
		MEMBER("SuperSetter", []); // set mes variables
		MEMBER("SuperStatic", []); // exec code du constructor
		MEMBER("SuperStaticSetter", []); // set mes variables
		MEMBER("Functions", []); // list de mes events
		MEMBER("Buffer", ""); //buffer de sortie
		
		private _v = ["public","display","Display"];
		MEMBER("addUIVar", _v);
		private _v = ["public","control","MetaControl"];
		MEMBER("addUIVar", _v);
	};

	PUBLIC FUNCTION("","exec") {
		diag_log "exec";
		MEMBER("Functions", nil) sort true;
		private _string = "", _f = "", _doc = [], _complete = [];
		MEMBER("Buffer", "");
		MEMBER("pushLine", '#include "..\oop.h"');
		diag_log format["Buffer:%1",MEMBER("Buffer", nil)];
		_string = "CLASS_EXTENDS(" + format['"oo_%1", "oo_metaControl")', MEMBER("MetaControl", nil)];
		MEMBER("pushLine", _string);

		if (count MEMBER("UIVariables", nil) > 0) then {
			MEMBER("pushLineBreak", nil);
			PUBLIC UI_VARIABLE("control", "editTextColor");
			{
				_string = format["%1 UI_VARIABLE(", _x select 0] + format['"%1", "%2");',_x select 1, _x select 2];
				MEMBER("pushLine", _string);
			} forEach MEMBER("UIVariables", nil);
		};
		if (count MEMBER("Variables", nil) > 0) then {
			MEMBER("pushLineBreak", nil);
			PUBLIC UI_VARIABLE("control", "editTextColor");
			{
				_string = format["%1 VARIABLE(", _x select 0] + format['"%1", "%2");',_x select 1, _x select 2];
				MEMBER("pushLine", _string);
			} forEach MEMBER("Variables", nil);
		};
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
		{
			MEMBER("pushLine", _x);
		} forEach (MEMBER("SuperSetter", nil) +  MEMBER("Super", nil));
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
		_string = '["setActiveLayer", _code] call GuiObject';
		MEMBER("pushLine", _string);

		{
			MEMBER("pushLine", _x);
		} forEach (MEMBER("SuperStaticSetter", nil) +  MEMBER("SuperStatic", nil));
		_string = '["setActiveLayer",' + "MEMBER("+'"Parent", nil)] call GuiObject;';
		MEMBER("pushLine", _string );
		MEMBER("modTab", -1);
		MEMBER("pushLine", "};" );

		/*
		*	Functions
		*/
		{
			MEMBER("pushLineBreak", nil);
			if!(_f isEqualTo (_x select 0)) then {
				_f = _x select 0;
				_doc = MEMBER("documentFunction", _x select 0);
				_complete = MEMBER("completeFunction", _x select 0);
				for "_i" from 0 to count _doc -1 do {
					_item = _doc select _i;
					MEMBER("pushLine", _item );
				};
			};			
			_string = "PUBLIC FUNCTION(" + format['"%1", "%2_%3") {',_x select 2, _x select 0, _x select 1];
			MEMBER("pushLine", _string );
			MEMBER("modTab", +1);
			for "_i" from 0 to count _complete -1 do {
				_item = _complete select _i;
				MEMBER("pushLine", _item );
			};
			MEMBER("pushLineBreak", nil);
			MEMBER("modTab", -1);
			MEMBER("pushLine", '};' );
		} forEach MEMBER("Functions", nil);


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