#include "..\oop.h"

CLASS("oo_GuiEditorDialog")

	PUBLIC VARIABLE("code", "GuiObject");
	PUBLIC UI_VARIABLE("display", "DisplayChild");
	

	
	PUBLIC FUNCTION("code","constructor") { 
		MEMBER("GuiObject", _this);
	};

	PUBLIC FUNCTION("","openCtrlCreateDialog") {
		disableSerialization;
		private _child = (findDisplay 4500) createDisplay "RscDisplayEmpty";
		MEMBER("DisplayChild", _child);
		private _control = _child ctrlCreate["RscBackgroundGUIDark", -1];
		_control ctrlSetPosition [safezoneX+safezoneW*0.25, safezoneY+safezoneH*0.25, safezoneW*0.5, safezoneH*0.5];
		_control ctrlCommit 0;

		private _topBar = _child ctrlCreate["TopBar", -1];
		_topBar ctrlSetText "Create control on layer";
		_topBar ctrlSetPosition [safezoneX+safezoneW*0.25, safezoneY+safezoneH*0.25, safezoneW*0.5, safezoneH*0.02];
		_topBar ctrlCommit 0;

		private _listBox = _child ctrlCreate["OOP_Listbox", 10];
		_listBox ctrlSetPosition[
			safezoneX+safezoneW*0.3, safezoneY+safezoneH*0.3, safezoneW*0.4, safezoneH*0.4
		];
		_listBox ctrlCommit 0;

		{
			_listBox lbAdd _x;
			_listBox lbSetData[_forEachIndex, _x];
		} forEach OOP_GuiEditor_ListControl;

		private _closeBtn = _child ctrlCreate["OOP_Button", -1];
		_closeBtn ctrlSetText "Fermer";
		_closeBtn buttonSetAction "closeDialog 0;";
		_closeBtn ctrlSetPosition [
			safezoneX+safezoneW*0.4, safezoneY+safezoneH*0.71, safezoneW*0.05, safezoneH*0.03
		];
		_closeBtn ctrlCommit 0;

		private _valideBtn = _child ctrlCreate["OOP_Button", -1];
		_valideBtn ctrlSetText "Valider";

		_valideBtn buttonSetAction format["'valideCtrlCreateDialog' call %1", _self];
		_valideBtn ctrlSetPosition [
			safezoneX+safezoneW*0.5, safezoneY+safezoneH*0.71, safezoneW*0.05, safezoneH*0.03
		];
		_valideBtn ctrlCommit 0;
	};

	PUBLIC FUNCTION("","valideCtrlCreateDialog") {
		disableSerialization;
		private _listBox = (findDisplay -1) displayCtrl 10;
		private _s = _listBox lbData (lbCurSel _listBox);
		["ctrlCreate", _s] call MEMBER("GuiObject", nil);
		closeDialog 0;
	};

	PUBLIC FUNCTION("","openCfgCtrlDialog") {
		disableSerialization;
		private _child = (findDisplay 4500) createDisplay "RscDisplayEmpty";
		MEMBER("DisplayChild", _child);

		private _selCtrl = "getSelCtrl" call MEMBER("GuiObject", nil);

		private _control = _child ctrlCreate["RscBackgroundGUIDark", -1];
		_control ctrlSetPosition [safezoneX+safezoneW*0.25, safezoneY+safezoneH*0.25, safezoneW*0.5, safezoneH*0.5];
		_control ctrlCommit 0;

		private _topBar = _child ctrlCreate["TopBar", -1];
		_topBar ctrlSetText "Config your control";
		_topBar ctrlSetPosition [safezoneX+safezoneW*0.25, safezoneY+safezoneH*0.25, safezoneW*0.5, safezoneH*0.02];
		_topBar ctrlCommit 0;
		
		private _helperControl = ["new", _child] call oo_HelperControl;
		["setLineSpaceY", safezoneH*0.011 ] call _helperControl;
	
		private _btnStyle = _child ctrlCreate["OOP_Button", 5];
		_btnStyle ctrlSetText "Style";
		_btnStyle buttonSetAction "{((findDisplay -1) displayCtrl _x) ctrlShow false;}forEach[500,501,502,503,504,505,506,507]; ((findDisplay -1) displayCtrl 500) ctrlShow true;";
		_btnStyle ctrlSetPosition[safezoneX+safezoneW*0.25, safezoneY+safezoneH*0.30, safezoneW*0.10,safezoneH*0.02];
		_btnStyle ctrlCommit 0;
		private _ctrlGroupStyle = _child ctrlCreate["OOP_SubLayer", 500];
		_ctrlGroupStyle ctrlSetPosition [safezoneX+safezoneW*0.37, safezoneY+safezoneH*0.30, safezoneW*0.4, safezoneH*0.5];
		_ctrlGroupStyle ctrlCommit 0;
		["setTarget", _ctrlGroupStyle] call _helperControl;
		["setPos", [0,0, safezoneH*0.02] ] call _helperControl;
		["createTextInput", ["IDControl :", safezoneW*0.08, safezoneW*0.21, 10]] call _helperControl;
		["createTextInput", ["Text :", safezoneW*0.08, safezoneW*0.21, 11]] call _helperControl;
		["createTextInput", ["Background Color :", safezoneW*0.08, safezoneW*0.21, 12]] call _helperControl;
		["createTextInput", ["Text Color :", safezoneW*0.08, safezoneW*0.21, 13]] call _helperControl;
		["createTextInput", ["Foreground Color :", safezoneW*0.08, safezoneW*0.21, 14]] call _helperControl;
		["createTextInput", ["Tooltip :", safezoneW*0.08, safezoneW*0.21, 15]] call _helperControl;
		["createTextInput", ["Tooltip Color Box :", safezoneW*0.08, safezoneW*0.21, 16]] call _helperControl;
		["createTextInput", ["Tooltip Color Shade :", safezoneW*0.08, safezoneW*0.21, 17]] call _helperControl;
		["createTextInput", ["Tooltip Color Text :", safezoneW*0.08, safezoneW*0.21, 18]] call _helperControl;

		private _btnGen = _child ctrlCreate["OOP_Button", 5];
		_btnGen ctrlSetText "Gen Event";
		_btnGen buttonSetAction "{((findDisplay -1) displayCtrl _x) ctrlShow false;}forEach[500,501,502,503,504,505,506,507]; ((findDisplay -1) displayCtrl 501) ctrlShow true;";
		_btnGen ctrlSetPosition[safezoneX+safezoneW*0.25, safezoneY+safezoneH*0.33, safezoneW*0.10,safezoneH*0.02];
		_btnGen ctrlCommit 0;
		private _ctrlGroupGen = _child ctrlCreate["OOP_SubLayer", 501];
		_ctrlGroupGen ctrlSetPosition [safezoneX+safezoneW*0.37, safezoneY+safezoneH*0.30, safezoneW*0.4, safezoneH*0.5];
		_ctrlGroupGen ctrlShow false;
		_ctrlGroupGen ctrlCommit 0;
		["setTarget", _ctrlGroupGen] call _helperControl;
		["setPos", [0,0, safezoneH*0.02]] call _helperControl;
		["setMode", 1] call _helperControl;
		["setLineSpaceX", 0] call _helperControl;
		"resetCountControlRow" call _helperControl;
		["setMaxControlRow", 3] call _helperControl;

		{
			private _ctrl = ["createTextCheckbox", [_x, safezoneW*0.12, safezoneW*0.015]] call _helperControl;
			_ctrl ctrlAddEventHandler["CheckedChanged", format["['setEvent', ['%1', (_this select 1)]] call %2", _x, _selCtrl]];
		} forEach ["Action", "Init", "onDestroy", "onLoad", "onUnload", "onSetFocus", "onKillFocus", "onTimer", "onCanDestroy"];
		
		private _btnEvent = _child ctrlCreate["OOP_Button", 5];
		_btnEvent ctrlSetText "Mouse Event";
		_btnEvent buttonSetAction "{((findDisplay -1) displayCtrl _x) ctrlShow false;}forEach[500,501,502,503,504,505,506,507]; ((findDisplay -1) displayCtrl 502) ctrlShow true;";
		_btnEvent ctrlSetPosition[safezoneX+safezoneW*0.25, safezoneY+safezoneH*0.36, safezoneW*0.10,safezoneH*0.02];
		_btnEvent ctrlCommit 0;
		private _ctrlGroupEvent = _child ctrlCreate["OOP_SubLayer", 502];
		_ctrlGroupEvent ctrlSetPosition [safezoneX+safezoneW*0.37, safezoneY+safezoneH*0.30, safezoneW*0.4, safezoneH*0.5];
		_ctrlGroupEvent ctrlShow false;
		_ctrlGroupEvent ctrlCommit 0;
		["setTarget", _ctrlGroupEvent] call _helperControl;
		["setPos", [0,0, safezoneH*0.02]] call _helperControl;
		"resetCountControlRow" call _helperControl;
		{
			private _ctrl = ["createTextCheckbox", [_x, safezoneW*0.12, safezoneW*0.015]] call _helperControl;
			_ctrl ctrlAddEventHandler["CheckedChanged", format["['setEvent', ['%1', (_this select 1)]] call %2", _x, _selCtrl]];
		} forEach ["onMouseButtonDown","onMouseButtonUp","onMouseButtonClick","onMouseButtonDblClick","onMouseMoving","onMouseHolding","onMouseZChanged","onButtonDblClick","onButtonDown","onButtonUp","onButtonClick","onMouseEnter","onMouseExit"];

		private _btnKey = _child ctrlCreate["OOP_Button", 5];
		_btnKey ctrlSetText "Keyboard Event";
		_btnKey buttonSetAction "{((findDisplay -1) displayCtrl _x) ctrlShow false;}forEach[500,501,502,503,504,505,506,507]; ((findDisplay -1) displayCtrl 503) ctrlShow true;";
		_btnKey ctrlSetPosition[safezoneX+safezoneW*0.25, safezoneY+safezoneH*0.39, safezoneW*0.10,safezoneH*0.02];
		_btnKey ctrlCommit 0;
		private _ctrlGRoupKeyboard = _child ctrlCreate["OOP_SubLayer", 503];
		_ctrlGRoupKeyboard ctrlSetPosition [safezoneX+safezoneW*0.37, safezoneY+safezoneH*0.30, safezoneW*0.4, safezoneH*0.5];
		_ctrlGRoupKeyboard ctrlShow false;
		_ctrlGRoupKeyboard ctrlCommit 0;
		["setTarget", _ctrlGRoupKeyboard] call _helperControl;
		["setPos", [0,0, safezoneH*0.02]] call _helperControl;
		"resetCountControlRow" call _helperControl;

		{
			private _ctrl = ["createTextCheckbox", [_x, safezoneW*0.12, safezoneW*0.015]] call _helperControl;
			_ctrl ctrlAddEventHandler["CheckedChanged", format["['setEvent', ['%1', (_this select 1)]] call %2", _x, _selCtrl]];
		} forEach ["onKeyDown","onKeyUp","onChar","onIMEChar","onIMEComposition","onJoystickButton"];

		private _btnLB = _child ctrlCreate["OOP_Button", 5];
		_btnLB ctrlSetText "LB Event";
		_btnLB buttonSetAction "{((findDisplay -1) displayCtrl _x) ctrlShow false;}forEach[500,501,502,503,504,505,506,507]; ((findDisplay -1) displayCtrl 504) ctrlShow true;";
		_btnLB ctrlSetPosition[safezoneX+safezoneW*0.25, safezoneY+safezoneH*0.42, safezoneW*0.10,safezoneH*0.02];
		_btnLB ctrlCommit 0;
		private _ctrlGroupLB = _child ctrlCreate["OOP_SubLayer", 504];
		_ctrlGroupLB ctrlSetPosition [safezoneX+safezoneW*0.37, safezoneY+safezoneH*0.30, safezoneW*0.4, safezoneH*0.5];
		_ctrlGroupLB ctrlShow false;
		_ctrlGroupLB ctrlCommit 0;
		["setTarget", _ctrlGroupLB] call _helperControl;
		["setPos", [0,0, safezoneH*0.02]] call _helperControl;
		"resetCountControlRow" call _helperControl;

		{
			private _ctrl = ["createTextCheckbox", [_x, safezoneW*0.12, safezoneW*0.015]] call _helperControl;
			_ctrl ctrlAddEventHandler["CheckedChanged", format["['setEvent', ['%1', (_this select 1)]] call %2", _x, _selCtrl]];
		} forEach ["onLBSelChanged","onLBListSelChanged","onLBDblClick","onLBDrag","onLBDragging","onLBDrop"];
				
		private _btnTree = _child ctrlCreate["OOP_Button", 5];
		_btnTree ctrlSetText "LB Event";
		_btnTree buttonSetAction "{((findDisplay -1) displayCtrl _x) ctrlShow false;}forEach[500,501,502,503,504,506,507]; ((findDisplay -1) displayCtrl 505) ctrlShow true;";
		_btnTree ctrlSetPosition[safezoneX+safezoneW*0.25, safezoneY+safezoneH*0.45, safezoneW*0.10,safezoneH*0.02];
		_btnTree ctrlCommit 0;
		private _ctrlGroupTree = _child ctrlCreate["OOP_SubLayer", 505];
		_ctrlGroupTree ctrlSetPosition [safezoneX+safezoneW*0.37, safezoneY+safezoneH*0.30, safezoneW*0.4, safezoneH*0.5];
		_ctrlGroupTree ctrlShow false;
		_ctrlGroupTree ctrlCommit 0;
		["setTarget", _ctrlGroupTree] call _helperControl;
		["setPos", [0,0, safezoneH*0.02]] call _helperControl;
		"resetCountControlRow" call _helperControl;

		{
			private _ctrl = ["createTextCheckbox", [_x, safezoneW*0.12, safezoneW*0.015]] call _helperControl;
			_ctrl ctrlAddEventHandler["CheckedChanged", format["['setEvent', ['%1', (_this select 1)]] call %2", _x, _selCtrl]];
		} forEach ["onTreeSelChanged","onTreeLButtonDown","onTreeDblClick","onTreeExpanded","onTreeCollapsed","onTreeMouseMove","onTreeMouseHold","onTreeMouseExit"];

		private _btnTB = _child ctrlCreate["OOP_Button", 5];
		_btnTB ctrlSetText "Tool/Check box Event";
		_btnTB buttonSetAction "{((findDisplay -1) displayCtrl _x) ctrlShow false;}forEach[500,501,502,503,504,505,506,507]; ((findDisplay -1) displayCtrl 506) ctrlShow true;";
		_btnTB ctrlSetPosition[safezoneX+safezoneW*0.25, safezoneY+safezoneH*0.48, safezoneW*0.10,safezoneH*0.02];
		_btnTB ctrlCommit 0;
		private _ctrlGroupToolbox = _child ctrlCreate["OOP_SubLayer", 506];
		_ctrlGroupToolbox ctrlSetPosition [safezoneX+safezoneW*0.37, safezoneY+safezoneH*0.30, safezoneW*0.4, safezoneH*0.5];
		_ctrlGroupToolbox ctrlShow false;
		_ctrlGroupToolbox ctrlCommit 0;
		["setTarget", _ctrlGroupToolbox] call _helperControl;
		["setPos", [0,0, safezoneH*0.02]] call _helperControl;
		"resetCountControlRow" call _helperControl;

		{
			private _ctrl = ["createTextCheckbox", [_x, safezoneW*0.12, safezoneW*0.015]] call _helperControl;
			_ctrl ctrlAddEventHandler["CheckedChanged", format["['setEvent', ['%1', (_this select 1)]] call %2", _x, _selCtrl]];
		} forEach ["onToolBoxSelChanged","onChecked","onCheckedChanged","onCheckBoxesSelChanged"];

		private _btnOther = _child ctrlCreate["OOP_Button", 5];
		_btnOther ctrlSetText "Other...";
		_btnOther buttonSetAction "{((findDisplay -1) displayCtrl _x) ctrlShow false;}forEach[500,501,502,503,504,505,506,507]; ((findDisplay -1) displayCtrl 507) ctrlShow true;";
		_btnOther ctrlSetPosition[safezoneX+safezoneW*0.25, safezoneY+safezoneH*0.51, safezoneW*0.10,safezoneH*0.02];
		_btnOther ctrlCommit 0;
		private _ctrlGroupOther = _child ctrlCreate["OOP_SubLayer", 507];
		_ctrlGroupOther ctrlSetPosition [safezoneX+safezoneW*0.37, safezoneY+safezoneH*0.30, safezoneW*0.4, safezoneH*0.5];
		_ctrlGroupOther ctrlShow false;
		_ctrlGroupOther ctrlCommit 0;
		["setTarget", _ctrlGroupOther] call _helperControl;
		["setPos", [0,0, safezoneH*0.02]] call _helperControl;
		"resetCountControlRow" call _helperControl;
		{
			private _ctrl = ["createTextCheckbox", [_x, safezoneW*0.12, safezoneW*0.015]] call _helperControl;
			_ctrl ctrlAddEventHandler["CheckedChanged", format["['setEvent', ['%1', (_this select 1)]] call %2", _x, _selCtrl]];
		} forEach ["onHTMLLink","onSliderPosChanged","onObjectMoved","onMenuSelected","onDraw","onVideoStopped"];

		private _closeBtn = _child ctrlCreate["OOP_Button", -1];
		_closeBtn ctrlSetText "Fermer";
		_closeBtn buttonSetAction "closeDialog 0;";
		_closeBtn ctrlSetPosition [
			safezoneX+safezoneW*0.4, safezoneY+safezoneH*0.71, safezoneW*0.05, safezoneH*0.03
		];
		_closeBtn ctrlCommit 0;

		private _valideBtn = _child ctrlCreate["OOP_Button", -1];
		_valideBtn ctrlSetText "Valider";
		_valideBtn buttonSetAction format["'valideCfgCtrlDialog' call %1", _self];
		_valideBtn ctrlSetPosition [
			safezoneX+safezoneW*0.5, safezoneY+safezoneH*0.71, safezoneW*0.05, safezoneH*0.03
		];
		_valideBtn ctrlCommit 0;
	};

	PUBLIC FUNCTION("","valideCfgCtrlDialog") {
		private _helper = ["new", MEMBER("DisplayChild", nil)] call oo_HelperGui;
		private _selCtrl = "getSelCtrl" call MEMBER("GuiObject", nil);

		// "IDControl"
		// "Text"
		// "Background Color"
		// "Text Color"
		// "Foreground Color"
		// "Tooltip"
		// "Tooltip Color Box"
		// "Tooltip Color Shade"
		// "Tooltip Color Text"

		closeDialog 0;
	};
ENDCLASS;