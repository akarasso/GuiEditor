#include "..\oop.h"

CLASS("oo_HelperGuiEditorDialog")

	PUBLIC VARIABLE("code", "GuiObject");
	

	
	PUBLIC FUNCTION("code","constructor") { 
		MEMBER("GuiObject", _this);
	};

	PUBLIC FUNCTION("","openCtrlCreateDialog") {
		disableSerialization;
		private _child = (findDisplay 4500) createDisplay "RscDisplayEmpty";
		MEMBER("DisplayCtrlCreate", _child);
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
		MEMBER("DisplayCtrlCreate", _child);

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
		["createTextCheckbox", ["Action", safezoneW*0.12, safezoneW*0.015, 100]] call _helperControl;
		["createTextCheckbox", ["Init", safezoneW*0.12, safezoneW*0.015, 101]] call _helperControl;
		["createTextCheckbox", ["onDestroy", safezoneW*0.12, safezoneW*0.015, 102]] call _helperControl;
		"breakLine" call _helperControl;
		["createTextCheckbox", ["onLoad", safezoneW*0.12, safezoneW*0.015, 103]] call _helperControl;
		["createTextCheckbox", ["onUnload", safezoneW*0.12, safezoneW*0.015, 104]] call _helperControl;
		["createTextCheckbox", ["onSetFocus", safezoneW*0.12, safezoneW*0.015, 105]] call _helperControl;
		"breakLine" call _helperControl;
		["createTextCheckbox", ["onKillFocus", safezoneW*0.12, safezoneW*0.015, 106]] call _helperControl;
		["createTextCheckbox", ["onTimer", safezoneW*0.12, safezoneW*0.015, 107]] call _helperControl;
		["createTextCheckbox", ["onCanDestroy", safezoneW*0.12, safezoneW*0.015, 108]] call _helperControl;
		"breakLine" call _helperControl;
		
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
		["createTextCheckbox", ["onMouseButtonDown", safezoneW*0.12, safezoneW*0.015, 109]] call _helperControl;
		["createTextCheckbox", ["onMouseButtonUp", safezoneW*0.12, safezoneW*0.015, 110]] call _helperControl;
		["createTextCheckbox", ["onMouseButtonClick", safezoneW*0.12, safezoneW*0.015, 111]] call _helperControl;
		"breakLine" call _helperControl;
		["createTextCheckbox", ["onMouseButtonDblClick", safezoneW*0.12, safezoneW*0.015, 112]] call _helperControl;
		["createTextCheckbox", ["onMouseMoving", safezoneW*0.12, safezoneW*0.015, 113]] call _helperControl;
		["createTextCheckbox", ["onMouseHolding", safezoneW*0.12, safezoneW*0.015, 114]] call _helperControl;
		"breakLine" call _helperControl;
		["createTextCheckbox", ["onMouseZChanged", safezoneW*0.12, safezoneW*0.015, 115]] call _helperControl;
		["createTextCheckbox", ["onButtonDblClick", safezoneW*0.12, safezoneW*0.015, 116]] call _helperControl;
		["createTextCheckbox", ["onButtonDown", safezoneW*0.12, safezoneW*0.015, 117]] call _helperControl;
		"breakLine" call _helperControl;
		["createTextCheckbox", ["onButtonUp", safezoneW*0.12, safezoneW*0.015, 118]] call _helperControl;
		["createTextCheckbox", ["onButtonClick", safezoneW*0.12, safezoneW*0.015, 119]] call _helperControl;
		["createTextCheckbox", ["onMouseEnter", safezoneW*0.12, safezoneW*0.015, 120]] call _helperControl;
		"breakLine" call _helperControl;
		["createTextCheckbox", ["onMouseExit", safezoneW*0.12, safezoneW*0.015, 121]] call _helperControl;

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
		["createTextCheckbox", ["onKeyDown", safezoneW*0.12, safezoneW*0.015, 122]] call _helperControl;
		["createTextCheckbox", ["onKeyUp", safezoneW*0.12, safezoneW*0.015, 123]] call _helperControl;
		["createTextCheckbox", ["onChar", safezoneW*0.12, safezoneW*0.015, 124]] call _helperControl;
		"breakLine" call _helperControl;
		["createTextCheckbox", ["onIMEChar", safezoneW*0.12, safezoneW*0.015, 125]] call _helperControl;
		["createTextCheckbox", ["onIMEComposition", safezoneW*0.12, safezoneW*0.015, 126]] call _helperControl;
		["createTextCheckbox", ["onJoystickButton", safezoneW*0.12, safezoneW*0.015, 127]] call _helperControl;

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
		["createTextCheckbox", ["onLBSelChanged", safezoneW*0.12, safezoneW*0.015, 128]] call _helperControl;
		["createTextCheckbox", ["onLBListSelChanged", safezoneW*0.12, safezoneW*0.015, 129]] call _helperControl;
		["createTextCheckbox", ["onLBDblClick:", safezoneW*0.12, safezoneW*0.015, 130]] call _helperControl;
		"breakLine" call _helperControl;
		["createTextCheckbox", ["onLBDrag", safezoneW*0.12, safezoneW*0.015, 131]] call _helperControl;
		["createTextCheckbox", ["onLBDragging", safezoneW*0.12, safezoneW*0.015, 132]] call _helperControl;
		["createTextCheckbox", ["onLBDrop", safezoneW*0.12, safezoneW*0.015, 133]] call _helperControl;
		
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
		["createTextCheckbox", ["onTreeSelChanged", safezoneW*0.12, safezoneW*0.015, 134]] call _helperControl;
		["createTextCheckbox", ["onTreeLButtonDown", safezoneW*0.12, safezoneW*0.015, 135]] call _helperControl;
		["createTextCheckbox", ["onTreeDblClick", safezoneW*0.12, safezoneW*0.015, 136]] call _helperControl;
		"breakLine" call _helperControl;
		["createTextCheckbox", ["onTreeExpanded", safezoneW*0.12, safezoneW*0.015, 137]] call _helperControl;
		["createTextCheckbox", ["onTreeCollapsed", safezoneW*0.12, safezoneW*0.015, 138]] call _helperControl;
		["createTextCheckbox", ["onTreeMouseMove", safezoneW*0.12, safezoneW*0.015, 139]] call _helperControl;
		"breakLine" call _helperControl;
		["createTextCheckbox", ["onTreeMouseHold", safezoneW*0.12, safezoneW*0.015, 140]] call _helperControl;
		["createTextCheckbox", ["onTreeMouseExit", safezoneW*0.12, safezoneW*0.015, 141]] call _helperControl;
		
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
		["createTextCheckbox", ["onToolBoxSelChanged:", safezoneW*0.12, safezoneW*0.015, 142]] call _helperControl;
		["createTextCheckbox", ["onChecked:", safezoneW*0.12, safezoneW*0.015, 143]] call _helperControl;
		["createTextCheckbox", ["onCheckedChanged:", safezoneW*0.12, safezoneW*0.015, 144]] call _helperControl;
		"breakLine" call _helperControl;
		["createTextCheckbox", ["onCheckBoxesSelChanged:", safezoneW*0.12, safezoneW*0.015, 145, false]] call _helperControl;

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
		["createTextCheckbox", ["onHTMLLink", safezoneW*0.12, safezoneW*0.015, 146]] call _helperControl;
		["createTextCheckbox", ["onSliderPosChanged", safezoneW*0.12, safezoneW*0.015, 147]] call _helperControl;
		["createTextCheckbox", ["onObjectMoved", safezoneW*0.12, safezoneW*0.015, 148]] call _helperControl;
		"breakLine" call _helperControl;
		["createTextCheckbox", ["onMenuSelected", safezoneW*0.12, safezoneW*0.015, 149]] call _helperControl;
		["createTextCheckbox", ["onDraw", safezoneW*0.12, safezoneW*0.015, 150]] call _helperControl;
		["createTextCheckbox", ["onVideoStopped", safezoneW*0.12, safezoneW*0.015, 151]] call _helperControl;

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
		private _ctrl = "getSelCtrl" call MEMBER("GuiObject", nil);

		closeDialog 0;
	};
ENDCLASS;