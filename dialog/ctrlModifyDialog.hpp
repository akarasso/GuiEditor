class ctrlModifyDialog {
	idd = 9001;
	name= "ctrlModifyDialog";
	movingEnable = false;
	enableSimulation = true;
	onLoad = "with uiNamespace do { openDisplay = _this select 0; };";
	class controlsBackground {
		class OOP_MainLayer_0_0 : OOP_MainLayer {
			idc = 0;
			x = -61.9078 * pixelGrid * pixelW;
			y = -28.35 * pixelGrid * pixelH;
			w = 210.691 * pixelGrid * pixelW;
			h = 125.95 * pixelGrid * pixelH;
			class controls{
				class OOP_Picture_2_2: OOP_Picture {
					idc = 2;
					x = 57.9399 * pixelGrid * pixelW;
					y = 27.709 * pixelGrid * pixelH;
					w = 94.8108 * pixelGrid * pixelW;
					h = 70.532 * pixelGrid * pixelH;
					text = "#(rgb,8,8,3)color(0.2,0.2,0.2,0.8)";
				};
				class title_3: OOP_Text {
					idc = 3;
					x = 57.9399 * pixelGrid * pixelW;
					y = 27.709 * pixelGrid * pixelH;
					w = 94.8108 * pixelGrid * pixelW;
					h = 5.038 * pixelGrid * pixelH;
					text = "Modify control:";
					colorText[] = {1, 1, 1, 1};
					colorBackground[] = {0.2, 0.7, 0.2, 1};
					tooltipColorText[] = {1, 1, 1, 1};
				};
				class btnStyle_4: OOP_Button {
					idc = 4;
					x = 57.9399 * pixelGrid * pixelW;
					y = 35.266 * pixelGrid * pixelH;
					w = 18.4354 * pixelGrid * pixelW;
					h = 3.7785 * pixelGrid * pixelH;
					text = "Style";
					action = "['static', ['btnAction_btnStyle', nil]] call oo_ctrlModifyDialog;";
				};
				class btnGen_5: OOP_Button {
					idc = 5;
					x = 57.9399 * pixelGrid * pixelW;
					y = 40.304 * pixelGrid * pixelH;
					w = 18.4354 * pixelGrid * pixelW;
					h = 3.97614 * pixelGrid * pixelH;
					text = "Gen EVH";
					action = "['static', ['btnAction_btnGen', nil]] call oo_ctrlModifyDialog;";
				};
				class btnMouse_6: OOP_Button {
					idc = 6;
					x = 57.9399 * pixelGrid * pixelW;
					y = 45.342 * pixelGrid * pixelH;
					w = 18.4354 * pixelGrid * pixelW;
					h = 3.97614 * pixelGrid * pixelH;
					text = "Mouse EVH";
					action = "['static', ['btnAction_btnMouse', nil]] call oo_ctrlModifyDialog;";
				};
				class btnKB_7: OOP_Button {
					idc = 7;
					x = 57.9399 * pixelGrid * pixelW;
					y = 50.38 * pixelGrid * pixelH;
					w = 18.4354 * pixelGrid * pixelW;
					h = 3.97614 * pixelGrid * pixelH;
					text = "Keyboard EVH";
					action = "['static', ['btnAction_btnKB', nil]] call oo_ctrlModifyDialog;";
				};
				class btnLB_8: OOP_Button {
					idc = 8;
					x = 57.9399 * pixelGrid * pixelW;
					y = 55.418 * pixelGrid * pixelH;
					w = 18.4354 * pixelGrid * pixelW;
					h = 3.97614 * pixelGrid * pixelH;
					text = "LB EVH";
					action = "['static', ['btnAction_btnLB', nil]] call oo_ctrlModifyDialog;";
				};
				class btnTree_9: OOP_Button {
					idc = 9;
					x = 57.9399 * pixelGrid * pixelW;
					y = 60.456 * pixelGrid * pixelH;
					w = 18.4354 * pixelGrid * pixelW;
					h = 3.97614 * pixelGrid * pixelH;
					text = "Tree EVH";
					action = "['static', ['btnAction_btnTree', nil]] call oo_ctrlModifyDialog;";
				};
				class btnTool_10: OOP_Button {
					idc = 10;
					x = 57.9399 * pixelGrid * pixelW;
					y = 65.494 * pixelGrid * pixelH;
					w = 18.4354 * pixelGrid * pixelW;
					h = 3.97614 * pixelGrid * pixelH;
					text = "Tool/Cb EVH";
					action = "['static', ['btnAction_btnTool', nil]] call oo_ctrlModifyDialog;";
				};
				class btnOther_11: OOP_Button {
					idc = 11;
					x = 57.9399 * pixelGrid * pixelW;
					y = 70.532 * pixelGrid * pixelH;
					w = 18.4354 * pixelGrid * pixelW;
					h = 3.97614 * pixelGrid * pixelH;
					text = "Other EVH";
					action = "['static', ['btnAction_btnOther', nil]] call oo_ctrlModifyDialog;";
				};
				class btnValider_12: OOP_Button {
					idc = 12;
					x = 115.88 * pixelGrid * pixelW;
					y = 89.4245 * pixelGrid * pixelH;
					w = 18.4354 * pixelGrid * pixelW;
					h = 5.038 * pixelGrid * pixelH;
					text = "Valider";
					action = "['static', ['btnAction_btnValider', nil]] call oo_ctrlModifyDialog;";
				};
				class btnClose_13: OOP_Button {
					idc = 13;
					x = 73.7417 * pixelGrid * pixelW;
					y = 89.4245 * pixelGrid * pixelH;
					w = 18.4354 * pixelGrid * pixelW;
					h = 5.038 * pixelGrid * pixelH;
					text = "Fermer";
					action = "['static', ['btnAction_btnClose', nil]] call oo_ctrlModifyDialog;";
				};
				class layerGen_14 : OOP_SubLayer {
					idc = 14;
					x = 79.009 * pixelGrid * pixelW;
					y = 35.266 * pixelGrid * pixelH;
					w = 70.2302 * pixelGrid * pixelW;
					h = 50.38 * pixelGrid * pixelH;
					class controls{
						class OOP_TextRight_15_15: OOP_TextRight {
							idc = 15;
							x = 7.9009 * pixelGrid * pixelW;
							y = 5.038 * pixelGrid * pixelH;
							w = 15.8018 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							text = "Init";
						};
						class OOP_TextRight_16_16: OOP_TextRight {
							idc = 16;
							x = 7.9009 * pixelGrid * pixelW;
							y = 10.076 * pixelGrid * pixelH;
							w = 15.8018 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							text = "onDestroy";
						};
						class OOP_TextRight_17_17: OOP_TextRight {
							idc = 17;
							x = 7.9009 * pixelGrid * pixelW;
							y = 15.114 * pixelGrid * pixelH;
							w = 15.8018 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							text = "onLoad";
						};
						class OOP_TextRight_18_18: OOP_TextRight {
							idc = 18;
							x = 7.9009 * pixelGrid * pixelW;
							y = 20.152 * pixelGrid * pixelH;
							w = 15.8018 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							text = "onUnload";
						};
						class OOP_TextRight_19_19: OOP_TextRight {
							idc = 19;
							x = 36.8709 * pixelGrid * pixelW;
							y = 5.038 * pixelGrid * pixelH;
							w = 15.8018 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							text = "onSetFocus";
						};
						class OOP_TextRight_20_20: OOP_TextRight {
							idc = 20;
							x = 36.8709 * pixelGrid * pixelW;
							y = 10.076 * pixelGrid * pixelH;
							w = 15.8018 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							text = "onKillFocus";
						};
						class OOP_TextRight_21_21: OOP_TextRight {
							idc = 21;
							x = 36.8709 * pixelGrid * pixelW;
							y = 15.114 * pixelGrid * pixelH;
							w = 15.8018 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							text = "onTimer";
						};
						class OOP_TextRight_22_22: OOP_TextRight {
							idc = 22;
							x = 36.8709 * pixelGrid * pixelW;
							y = 20.152 * pixelGrid * pixelH;
							w = 15.8018 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							text = "onCanDestroy";
						};
						class cbInit_23: OOP_Checkbox {
							idc = 23;
							x = 23.7027 * pixelGrid * pixelW;
							y = 5.038 * pixelGrid * pixelH;
							w = 2.63363 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							onCheckedChanged = "['static', ['onCheckedChanged_cbInit', _this]] call oo_ctrlModifyDialog;";
						};
						class cbOnDestroy_24: OOP_Checkbox {
							idc = 24;
							x = 23.7027 * pixelGrid * pixelW;
							y = 10.076 * pixelGrid * pixelH;
							w = 2.63363 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							onCheckedChanged = "['static', ['onCheckedChanged_cbOnDestroy', _this]] call oo_ctrlModifyDialog;";
						};
						class cbOnLoad_25: OOP_Checkbox {
							idc = 25;
							x = 23.7027 * pixelGrid * pixelW;
							y = 15.114 * pixelGrid * pixelH;
							w = 2.63363 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							onCheckedChanged = "['static', ['onCheckedChanged_cbOnLoad', _this]] call oo_ctrlModifyDialog;";
						};
						class cbOnUnload_26: OOP_Checkbox {
							idc = 26;
							x = 23.7027 * pixelGrid * pixelW;
							y = 20.152 * pixelGrid * pixelH;
							w = 2.63363 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							onCheckedChanged = "['static', ['onCheckedChanged_cbOnUnload', _this]] call oo_ctrlModifyDialog;";
						};
						class cbOnSetFocus_27: OOP_Checkbox {
							idc = 27;
							x = 52.6727 * pixelGrid * pixelW;
							y = 5.038 * pixelGrid * pixelH;
							w = 2.63363 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							onCheckedChanged = "['static', ['onCheckedChanged_cbOnSetFocus', _this]] call oo_ctrlModifyDialog;";
						};
						class cbOnKillFocus_28: OOP_Checkbox {
							idc = 28;
							x = 52.6727 * pixelGrid * pixelW;
							y = 10.076 * pixelGrid * pixelH;
							w = 2.63363 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							onCheckedChanged = "['static', ['onCheckedChanged_cbOnKillFocus', _this]] call oo_ctrlModifyDialog;";
						};
						class cbOnTimer_29: OOP_Checkbox {
							idc = 29;
							x = 52.6727 * pixelGrid * pixelW;
							y = 15.114 * pixelGrid * pixelH;
							w = 2.63363 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							onCheckedChanged = "['static', ['onCheckedChanged_cbOnTimer', _this]] call oo_ctrlModifyDialog;";
						};
						class cbOnCanDestroy_30: OOP_Checkbox {
							idc = 30;
							x = 52.6727 * pixelGrid * pixelW;
							y = 20.152 * pixelGrid * pixelH;
							w = 2.63363 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							onCheckedChanged = "['static', ['onCheckedChanged_cbOnCanDestroy', _this]] call oo_ctrlModifyDialog;";
						};
					};
				};
				class layerMouse_31 : OOP_SubLayer {
					idc = 31;
					x = 79.009 * pixelGrid * pixelW;
					y = 35.266 * pixelGrid * pixelH;
					w = 70.2302 * pixelGrid * pixelW;
					h = 50.38 * pixelGrid * pixelH;
					class controls{
						class OOP_TextRight_32_32: OOP_TextRight {
							idc = 32;
							x = 2.63363 * pixelGrid * pixelW;
							y = 5.038 * pixelGrid * pixelH;
							w = 21.0691 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							text = "onMouseButtonDown";
						};
						class OOP_TextRight_33_33: OOP_TextRight {
							idc = 33;
							x = 2.63363 * pixelGrid * pixelW;
							y = 10.076 * pixelGrid * pixelH;
							w = 21.0691 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							text = "onMouseButtonUp";
						};
						class OOP_TextRight_34_34: OOP_TextRight {
							idc = 34;
							x = 2.63363 * pixelGrid * pixelW;
							y = 15.114 * pixelGrid * pixelH;
							w = 21.0691 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							text = "onMouseButtonClick";
						};
						class OOP_TextRight_35_35: OOP_TextRight {
							idc = 35;
							x = 2.63363 * pixelGrid * pixelW;
							y = 20.152 * pixelGrid * pixelH;
							w = 21.0691 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							text = "onMouseButtonDblClick";
						};
						class OOP_TextRight_36_36: OOP_TextRight {
							idc = 36;
							x = 36.8709 * pixelGrid * pixelW;
							y = 5.038 * pixelGrid * pixelH;
							w = 15.8018 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							text = "onMouseMoving";
						};
						class OOP_TextRight_37_37: OOP_TextRight {
							idc = 37;
							x = 36.8709 * pixelGrid * pixelW;
							y = 10.076 * pixelGrid * pixelH;
							w = 15.8018 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							text = "onMouseHolding";
						};
						class OOP_TextRight_38_38: OOP_TextRight {
							idc = 38;
							x = 36.8709 * pixelGrid * pixelW;
							y = 15.114 * pixelGrid * pixelH;
							w = 15.8018 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							text = "onMouseZChanged";
						};
						class OOP_TextRight_39_39: OOP_TextRight {
							idc = 39;
							x = 36.8709 * pixelGrid * pixelW;
							y = 20.152 * pixelGrid * pixelH;
							w = 15.8018 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							text = "onButtonDblClick";
						};
						class cbOnMouseButtonDown_40: OOP_Checkbox {
							idc = 40;
							x = 23.7027 * pixelGrid * pixelW;
							y = 5.038 * pixelGrid * pixelH;
							w = 2.63363 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							onCheckedChanged = "['static', ['onCheckedChanged_cbOnMouseButtonDown', _this]] call oo_ctrlModifyDialog;";
						};
						class cbOnMouseButtonUp_41: OOP_Checkbox {
							idc = 41;
							x = 23.7027 * pixelGrid * pixelW;
							y = 10.076 * pixelGrid * pixelH;
							w = 2.63363 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							onCheckedChanged = "['static', ['onCheckedChanged_cbOnMouseButtonUp', _this]] call oo_ctrlModifyDialog;";
						};
						class cbOnMouseButtonClick_42: OOP_Checkbox {
							idc = 42;
							x = 23.7027 * pixelGrid * pixelW;
							y = 15.114 * pixelGrid * pixelH;
							w = 2.63363 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							onCheckedChanged = "['static', ['onCheckedChanged_cbOnMouseButtonClick', _this]] call oo_ctrlModifyDialog;";
						};
						class cbOnMouseButtonDblClick_43: OOP_Checkbox {
							idc = 43;
							x = 23.7027 * pixelGrid * pixelW;
							y = 20.152 * pixelGrid * pixelH;
							w = 2.63363 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							onCheckedChanged = "['static', ['onCheckedChanged_cbOnMouseButtonDblClick', _this]] call oo_ctrlModifyDialog;";
						};
						class cbOnMouseMoving_44: OOP_Checkbox {
							idc = 44;
							x = 52.6727 * pixelGrid * pixelW;
							y = 5.038 * pixelGrid * pixelH;
							w = 2.63363 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							onCheckedChanged = "['static', ['onCheckedChanged_cbOnMouseMoving', _this]] call oo_ctrlModifyDialog;";
						};
						class cbOnMouseHolding_45: OOP_Checkbox {
							idc = 45;
							x = 52.6727 * pixelGrid * pixelW;
							y = 10.076 * pixelGrid * pixelH;
							w = 2.63363 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							onCheckedChanged = "['static', ['onCheckedChanged_cbOnMouseHolding', _this]] call oo_ctrlModifyDialog;";
						};
						class cbOnMouseZChanged_46: OOP_Checkbox {
							idc = 46;
							x = 52.6727 * pixelGrid * pixelW;
							y = 15.114 * pixelGrid * pixelH;
							w = 2.63363 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							onCheckedChanged = "['static', ['onCheckedChanged_cbOnMouseZChanged', _this]] call oo_ctrlModifyDialog;";
						};
						class cbOnButtonDblClick_47: OOP_Checkbox {
							idc = 47;
							x = 52.6727 * pixelGrid * pixelW;
							y = 20.152 * pixelGrid * pixelH;
							w = 2.63363 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							onCheckedChanged = "['static', ['onCheckedChanged_cbOnButtonDblClick', _this]] call oo_ctrlModifyDialog;";
						};
						class OOP_TextRight_48_48: OOP_TextRight {
							idc = 48;
							x = 2.63363 * pixelGrid * pixelW;
							y = 25.19 * pixelGrid * pixelH;
							w = 21.0691 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							text = "onButtonDown";
						};
						class OOP_TextRight_49_49: OOP_TextRight {
							idc = 49;
							x = 2.63363 * pixelGrid * pixelW;
							y = 30.228 * pixelGrid * pixelH;
							w = 21.0691 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							text = "onButtonUp";
						};
						class OOP_TextRight_50_50: OOP_TextRight {
							idc = 50;
							x = 2.63363 * pixelGrid * pixelW;
							y = 35.266 * pixelGrid * pixelH;
							w = 21.0691 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							text = "onButtonClick";
						};
						class OOP_TextRight_51_51: OOP_TextRight {
							idc = 51;
							x = 31.6036 * pixelGrid * pixelW;
							y = 25.19 * pixelGrid * pixelH;
							w = 21.0691 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							text = "onMouseEnter";
						};
						class OOP_TextRight_52_52: OOP_TextRight {
							idc = 52;
							x = 31.6036 * pixelGrid * pixelW;
							y = 30.228 * pixelGrid * pixelH;
							w = 21.0691 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							text = "onMouseExit";
						};
						class cbOnButtonDown_53: OOP_Checkbox {
							idc = 53;
							x = 23.7027 * pixelGrid * pixelW;
							y = 25.19 * pixelGrid * pixelH;
							w = 2.63363 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							onCheckedChanged = "['static', ['onCheckedChanged_cbOnButtonDown', _this]] call oo_ctrlModifyDialog;";
						};
						class cbOnButtonUp_54: OOP_Checkbox {
							idc = 54;
							x = 23.7027 * pixelGrid * pixelW;
							y = 30.228 * pixelGrid * pixelH;
							w = 2.63363 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							onCheckedChanged = "['static', ['onCheckedChanged_cbOnButtonUp', _this]] call oo_ctrlModifyDialog;";
						};
						class cbOnButtonClick_55: OOP_Checkbox {
							idc = 55;
							x = 23.7027 * pixelGrid * pixelW;
							y = 35.266 * pixelGrid * pixelH;
							w = 2.63363 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							onCheckedChanged = "['static', ['onCheckedChanged_cbOnButtonClick', _this]] call oo_ctrlModifyDialog;";
						};
						class cbOnMouseEnter_56: OOP_Checkbox {
							idc = 56;
							x = 52.6727 * pixelGrid * pixelW;
							y = 25.19 * pixelGrid * pixelH;
							w = 2.63363 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							onCheckedChanged = "['static', ['onCheckedChanged_cbOnMouseEnter', _this]] call oo_ctrlModifyDialog;";
						};
						class cbOnMouseExit_57: OOP_Checkbox {
							idc = 57;
							x = 52.6727 * pixelGrid * pixelW;
							y = 30.228 * pixelGrid * pixelH;
							w = 2.63363 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							onCheckedChanged = "['static', ['onCheckedChanged_cbOnMouseExit', _this]] call oo_ctrlModifyDialog;";
						};
					};
				};
				class layerKB_58 : OOP_SubLayer {
					idc = 58;
					x = 79.009 * pixelGrid * pixelW;
					y = 35.266 * pixelGrid * pixelH;
					w = 70.2302 * pixelGrid * pixelW;
					h = 50.38 * pixelGrid * pixelH;
					class controls{
						class OOP_TextRight_59_59: OOP_TextRight {
							idc = 59;
							x = 2.63363 * pixelGrid * pixelW;
							y = 5.038 * pixelGrid * pixelH;
							w = 21.0691 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							text = "onKeyDown";
						};
						class OOP_TextRight_60_60: OOP_TextRight {
							idc = 60;
							x = 2.63363 * pixelGrid * pixelW;
							y = 10.076 * pixelGrid * pixelH;
							w = 21.0691 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							text = "onKeyUp";
						};
						class OOP_TextRight_61_61: OOP_TextRight {
							idc = 61;
							x = 2.63363 * pixelGrid * pixelW;
							y = 15.114 * pixelGrid * pixelH;
							w = 21.0691 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							text = "onChar";
						};
						class OOP_TextRight_62_62: OOP_TextRight {
							idc = 62;
							x = 36.8709 * pixelGrid * pixelW;
							y = 5.038 * pixelGrid * pixelH;
							w = 15.8018 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							text = "onIMEChar";
						};
						class OOP_TextRight_63_63: OOP_TextRight {
							idc = 63;
							x = 36.8709 * pixelGrid * pixelW;
							y = 10.076 * pixelGrid * pixelH;
							w = 15.8018 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							text = "onIMEComposition";
						};
						class cbOnKeyDown_64: OOP_Checkbox {
							idc = 64;
							x = 23.7027 * pixelGrid * pixelW;
							y = 5.038 * pixelGrid * pixelH;
							w = 2.63363 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							onCheckedChanged = "['static', ['onCheckedChanged_cbOnKeyDown', _this]] call oo_ctrlModifyDialog;";
						};
						class cbOnKeyUp_65: OOP_Checkbox {
							idc = 65;
							x = 23.7027 * pixelGrid * pixelW;
							y = 10.076 * pixelGrid * pixelH;
							w = 2.63363 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							onCheckedChanged = "['static', ['onCheckedChanged_cbOnKeyUp', _this]] call oo_ctrlModifyDialog;";
						};
						class cbOnChar_66: OOP_Checkbox {
							idc = 66;
							x = 23.7027 * pixelGrid * pixelW;
							y = 15.114 * pixelGrid * pixelH;
							w = 2.63363 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							onCheckedChanged = "['static', ['onCheckedChanged_cbOnChar', _this]] call oo_ctrlModifyDialog;";
						};
						class cbOnIMEChar_67: OOP_Checkbox {
							idc = 67;
							x = 52.6727 * pixelGrid * pixelW;
							y = 5.038 * pixelGrid * pixelH;
							w = 2.63363 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							onCheckedChanged = "['static', ['onCheckedChanged_cbOnIMEChar', _this]] call oo_ctrlModifyDialog;";
						};
						class cbOnIMEComposition_68: OOP_Checkbox {
							idc = 68;
							x = 52.6727 * pixelGrid * pixelW;
							y = 10.076 * pixelGrid * pixelH;
							w = 2.63363 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							onCheckedChanged = "['static', ['onCheckedChanged_cbOnIMEComposition', _this]] call oo_ctrlModifyDialog;";
						};
						class OOP_TextRight_69_69: OOP_TextRight {
							idc = 69;
							x = 36.8709 * pixelGrid * pixelW;
							y = 15.114 * pixelGrid * pixelH;
							w = 15.8018 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							text = "onJoystickButton";
						};
						class cbOnJoystickButton_70: OOP_Checkbox {
							idc = 70;
							x = 52.6727 * pixelGrid * pixelW;
							y = 15.114 * pixelGrid * pixelH;
							w = 2.63363 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							onCheckedChanged = "['static', ['onCheckedChanged_cbOnJoystickButton', _this]] call oo_ctrlModifyDialog;";
						};
					};
				};
				class layerLB_71 : OOP_SubLayer {
					idc = 71;
					x = 79.009 * pixelGrid * pixelW;
					y = 35.266 * pixelGrid * pixelH;
					w = 70.2302 * pixelGrid * pixelW;
					h = 50.38 * pixelGrid * pixelH;
					class controls{
						class OOP_TextRight_72_72: OOP_TextRight {
							idc = 72;
							x = 2.63363 * pixelGrid * pixelW;
							y = 5.038 * pixelGrid * pixelH;
							w = 21.0691 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							text = "OnLBSelChanged";
						};
						class OOP_TextRight_73_73: OOP_TextRight {
							idc = 73;
							x = 2.63363 * pixelGrid * pixelW;
							y = 10.076 * pixelGrid * pixelH;
							w = 21.0691 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							text = "OnLBListSelChanged";
						};
						class OOP_TextRight_74_74: OOP_TextRight {
							idc = 74;
							x = 2.63363 * pixelGrid * pixelW;
							y = 15.114 * pixelGrid * pixelH;
							w = 21.0691 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							text = "OnLBDblClick";
						};
						class OOP_TextRight_75_75: OOP_TextRight {
							idc = 75;
							x = 36.8709 * pixelGrid * pixelW;
							y = 5.038 * pixelGrid * pixelH;
							w = 15.8018 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							text = "OnLBDrag";
						};
						class OOP_TextRight_76_76: OOP_TextRight {
							idc = 76;
							x = 36.8709 * pixelGrid * pixelW;
							y = 10.076 * pixelGrid * pixelH;
							w = 15.8018 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							text = "OnLBDragging";
						};
						class cbOnLBSelChanged_77: OOP_Checkbox {
							idc = 77;
							x = 23.7027 * pixelGrid * pixelW;
							y = 5.038 * pixelGrid * pixelH;
							w = 2.63363 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							onCheckedChanged = "['static', ['onCheckedChanged_cbOnLBSelChanged', _this]] call oo_ctrlModifyDialog;";
						};
						class cbOnLBListSelChanged_78: OOP_Checkbox {
							idc = 78;
							x = 23.7027 * pixelGrid * pixelW;
							y = 10.076 * pixelGrid * pixelH;
							w = 2.63363 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							onCheckedChanged = "['static', ['onCheckedChanged_cbOnLBListSelChanged', _this]] call oo_ctrlModifyDialog;";
						};
						class cbOnLBDblClick_79: OOP_Checkbox {
							idc = 79;
							x = 23.7027 * pixelGrid * pixelW;
							y = 15.114 * pixelGrid * pixelH;
							w = 2.63363 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							onCheckedChanged = "['static', ['onCheckedChanged_cbOnLBDblClick', _this]] call oo_ctrlModifyDialog;";
						};
						class cbOnLBDrag_80: OOP_Checkbox {
							idc = 80;
							x = 52.6727 * pixelGrid * pixelW;
							y = 5.038 * pixelGrid * pixelH;
							w = 2.63363 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							onCheckedChanged = "['static', ['onCheckedChanged_cbOnLBDrag', _this]] call oo_ctrlModifyDialog;";
						};
						class cbOnLBDragging_81: OOP_Checkbox {
							idc = 81;
							x = 52.6727 * pixelGrid * pixelW;
							y = 10.076 * pixelGrid * pixelH;
							w = 2.63363 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							onCheckedChanged = "['static', ['onCheckedChanged_cbOnLBDragging', _this]] call oo_ctrlModifyDialog;";
						};
						class OOP_TextRight_82_82: OOP_TextRight {
							idc = 82;
							x = 36.8709 * pixelGrid * pixelW;
							y = 15.114 * pixelGrid * pixelH;
							w = 15.8018 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							text = "OnLBDrop";
						};
						class cbOnLBDrop_83: OOP_Checkbox {
							idc = 83;
							x = 52.6727 * pixelGrid * pixelW;
							y = 15.114 * pixelGrid * pixelH;
							w = 2.63363 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							onCheckedChanged = "['static', ['onCheckedChanged_cbOnLBDrop', _this]] call oo_ctrlModifyDialog;";
						};
					};
				};
				class layerTree_84 : OOP_SubLayer {
					idc = 84;
					x = 79.009 * pixelGrid * pixelW;
					y = 35.266 * pixelGrid * pixelH;
					w = 70.2302 * pixelGrid * pixelW;
					h = 50.38 * pixelGrid * pixelH;
					class controls{
						class OOP_TextRight_85_85: OOP_TextRight {
							idc = 85;
							x = 2.63363 * pixelGrid * pixelW;
							y = 5.038 * pixelGrid * pixelH;
							w = 21.0691 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							text = "OnTreeSelChanged";
						};
						class OOP_TextRight_86_86: OOP_TextRight {
							idc = 86;
							x = 2.63363 * pixelGrid * pixelW;
							y = 10.076 * pixelGrid * pixelH;
							w = 21.0691 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							text = "OnTreeLButtonDown";
						};
						class OOP_TextRight_87_87: OOP_TextRight {
							idc = 87;
							x = 2.63363 * pixelGrid * pixelW;
							y = 15.114 * pixelGrid * pixelH;
							w = 21.0691 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							text = "OnTreeDblClickk";
						};
						class OOP_TextRight_88_88: OOP_TextRight {
							idc = 88;
							x = 36.8709 * pixelGrid * pixelW;
							y = 5.038 * pixelGrid * pixelH;
							w = 15.8018 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							text = "OnTreeExpanded";
						};
						class OOP_TextRight_89_89: OOP_TextRight {
							idc = 89;
							x = 36.8709 * pixelGrid * pixelW;
							y = 10.076 * pixelGrid * pixelH;
							w = 15.8018 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							text = "OnTreeCollapsed";
						};
						class cbOnTreeSelChanged_90: OOP_Checkbox {
							idc = 90;
							x = 23.7027 * pixelGrid * pixelW;
							y = 5.038 * pixelGrid * pixelH;
							w = 2.63363 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							onCheckedChanged = "['static', ['onCheckedChanged_cbOnTreeSelChanged', _this]] call oo_ctrlModifyDialog;";
						};
						class cbOnTreeLButtonDown_91: OOP_Checkbox {
							idc = 91;
							x = 23.7027 * pixelGrid * pixelW;
							y = 10.076 * pixelGrid * pixelH;
							w = 2.63363 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							onCheckedChanged = "['static', ['onCheckedChanged_cbOnTreeLButtonDown', _this]] call oo_ctrlModifyDialog;";
						};
						class cbOnTreeDblClick_92: OOP_Checkbox {
							idc = 92;
							x = 23.7027 * pixelGrid * pixelW;
							y = 15.114 * pixelGrid * pixelH;
							w = 2.63363 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							onCheckedChanged = "['static', ['onCheckedChanged_cbOnTreeDblClick', _this]] call oo_ctrlModifyDialog;";
						};
						class cbOnTreeExpanded_93: OOP_Checkbox {
							idc = 93;
							x = 52.6727 * pixelGrid * pixelW;
							y = 5.038 * pixelGrid * pixelH;
							w = 2.63363 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							onCheckedChanged = "['static', ['onCheckedChanged_cbOnTreeExpanded', _this]] call oo_ctrlModifyDialog;";
						};
						class cbOnTreeCollapsed_94: OOP_Checkbox {
							idc = 94;
							x = 52.6727 * pixelGrid * pixelW;
							y = 10.076 * pixelGrid * pixelH;
							w = 2.63363 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							onCheckedChanged = "['static', ['onCheckedChanged_cbOnTreeCollapsed', _this]] call oo_ctrlModifyDialog;";
						};
						class OOP_TextRight_95_95: OOP_TextRight {
							idc = 95;
							x = 36.8709 * pixelGrid * pixelW;
							y = 15.114 * pixelGrid * pixelH;
							w = 15.8018 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							text = "OnTreeMouseMove";
						};
						class cbOnTreeMouseMove_96: OOP_Checkbox {
							idc = 96;
							x = 52.6727 * pixelGrid * pixelW;
							y = 15.114 * pixelGrid * pixelH;
							w = 2.63363 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							onCheckedChanged = "['static', ['onCheckedChanged_cbOnTreeMouseMove', _this]] call oo_ctrlModifyDialog;";
						};
						class OOP_TextRight_97_97: OOP_TextRight {
							idc = 97;
							x = 2.63363 * pixelGrid * pixelW;
							y = 20.152 * pixelGrid * pixelH;
							w = 21.0691 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							text = "OnTreeMouseHold";
						};
						class cbOnTreeMouseHold_98: OOP_Checkbox {
							idc = 98;
							x = 23.7027 * pixelGrid * pixelW;
							y = 20.152 * pixelGrid * pixelH;
							w = 2.63363 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							onCheckedChanged = "['static', ['onCheckedChanged_cbOnTreeMouseHold', _this]] call oo_ctrlModifyDialog;";
						};
						class cbOnTreeMouseExit_99: OOP_Checkbox {
							idc = 99;
							x = 52.6727 * pixelGrid * pixelW;
							y = 20.152 * pixelGrid * pixelH;
							w = 2.63363 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							onCheckedChanged = "['static', ['onCheckedChanged_cbOnTreeMouseExit', _this]] call oo_ctrlModifyDialog;";
						};
						class OOP_TextRight_100_100: OOP_TextRight {
							idc = 100;
							x = 36.8709 * pixelGrid * pixelW;
							y = 20.152 * pixelGrid * pixelH;
							w = 15.8018 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							text = "OnTreeMouseExit";
						};
					};
				};
				class layerToolCB_101 : OOP_SubLayer {
					idc = 101;
					x = 79.009 * pixelGrid * pixelW;
					y = 35.266 * pixelGrid * pixelH;
					w = 70.2302 * pixelGrid * pixelW;
					h = 50.38 * pixelGrid * pixelH;
					class controls{
						class OOP_TextRight_102_102: OOP_TextRight {
							idc = 102;
							x = 2.63363 * pixelGrid * pixelW;
							y = 5.038 * pixelGrid * pixelH;
							w = 21.0691 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							text = "OnToolBoxSelChanged";
						};
						class OOP_TextRight_103_103: OOP_TextRight {
							idc = 103;
							x = 2.63363 * pixelGrid * pixelW;
							y = 10.076 * pixelGrid * pixelH;
							w = 21.0691 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							text = "OnChecked";
						};
						class OOP_TextRight_104_104: OOP_TextRight {
							idc = 104;
							x = 28.97 * pixelGrid * pixelW;
							y = 5.038 * pixelGrid * pixelH;
							w = 23.7027 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							text = "OnCheckedChanged";
						};
						class OOP_TextRight_105_105: OOP_TextRight {
							idc = 105;
							x = 28.97 * pixelGrid * pixelW;
							y = 10.076 * pixelGrid * pixelH;
							w = 23.7027 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							text = "OnCheckBoxesSelChanged";
						};
						class cbOnToolBoxSelChanged_106: OOP_Checkbox {
							idc = 106;
							x = 23.7027 * pixelGrid * pixelW;
							y = 5.038 * pixelGrid * pixelH;
							w = 2.63363 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							onCheckedChanged = "['static', ['onCheckedChanged_cbOnToolBoxSelChanged', _this]] call oo_ctrlModifyDialog;";
						};
						class cbOnChecked_107: OOP_Checkbox {
							idc = 107;
							x = 23.7027 * pixelGrid * pixelW;
							y = 10.076 * pixelGrid * pixelH;
							w = 2.63363 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							onCheckedChanged = "['static', ['onCheckedChanged_cbOnChecked', _this]] call oo_ctrlModifyDialog;";
						};
						class cbOnCheckedChanged_108: OOP_Checkbox {
							idc = 108;
							x = 52.6727 * pixelGrid * pixelW;
							y = 5.038 * pixelGrid * pixelH;
							w = 2.63363 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							onCheckedChanged = "['static', ['onCheckedChanged_cbOnCheckedChanged', _this]] call oo_ctrlModifyDialog;";
						};
						class cbOnCheckBoxesSelChanged_109: OOP_Checkbox {
							idc = 109;
							x = 52.6727 * pixelGrid * pixelW;
							y = 10.076 * pixelGrid * pixelH;
							w = 2.63363 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							onCheckedChanged = "['static', ['onCheckedChanged_cbOnCheckBoxesSelChanged', _this]] call oo_ctrlModifyDialog;";
						};
					};
				};
				class layerOther_110 : OOP_SubLayer {
					idc = 110;
					x = 79.009 * pixelGrid * pixelW;
					y = 35.266 * pixelGrid * pixelH;
					w = 71.1081 * pixelGrid * pixelW;
					h = 50.38 * pixelGrid * pixelH;
					class controls{
						class OOP_TextRight_111_111: OOP_TextRight {
							idc = 111;
							x = 2.63363 * pixelGrid * pixelW;
							y = 5.038 * pixelGrid * pixelH;
							w = 21.0691 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							text = "OnHTMLLink";
						};
						class OOP_TextRight_112_112: OOP_TextRight {
							idc = 112;
							x = 2.63363 * pixelGrid * pixelW;
							y = 10.076 * pixelGrid * pixelH;
							w = 21.0691 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							text = "OnSliderPosChanged";
						};
						class OOP_TextRight_113_113: OOP_TextRight {
							idc = 113;
							x = 28.97 * pixelGrid * pixelW;
							y = 5.038 * pixelGrid * pixelH;
							w = 23.7027 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							text = "OnObjectMoved";
						};
						class OOP_TextRight_114_114: OOP_TextRight {
							idc = 114;
							x = 28.97 * pixelGrid * pixelW;
							y = 10.076 * pixelGrid * pixelH;
							w = 23.7027 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							text = "OnMenuSelected";
						};
						class cbOnHTMLLink_115: OOP_Checkbox {
							idc = 115;
							x = 23.7027 * pixelGrid * pixelW;
							y = 5.038 * pixelGrid * pixelH;
							w = 2.63363 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							onCheckedChanged = "['static', ['onCheckedChanged_cbOnHTMLLink', _this]] call oo_ctrlModifyDialog;";
						};
						class cbOnSliderPosChanged_116: OOP_Checkbox {
							idc = 116;
							x = 23.7027 * pixelGrid * pixelW;
							y = 10.076 * pixelGrid * pixelH;
							w = 2.63363 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							onCheckedChanged = "['static', ['onCheckedChanged_cbOnSliderPosChanged', _this]] call oo_ctrlModifyDialog;";
						};
						class cbOnObjectMoved_117: OOP_Checkbox {
							idc = 117;
							x = 52.6727 * pixelGrid * pixelW;
							y = 5.038 * pixelGrid * pixelH;
							w = 2.63363 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							onCheckedChanged = "['static', ['onCheckedChanged_cbOnObjectMoved', _this]] call oo_ctrlModifyDialog;";
						};
						class cbOnMenuSelected_118: OOP_Checkbox {
							idc = 118;
							x = 52.6727 * pixelGrid * pixelW;
							y = 10.076 * pixelGrid * pixelH;
							w = 2.63363 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							onCheckedChanged = "['static', ['onCheckedChanged_cbOnMenuSelected', _this]] call oo_ctrlModifyDialog;";
						};
						class OOP_TextRight_119_119: OOP_TextRight {
							idc = 119;
							x = 2.63363 * pixelGrid * pixelW;
							y = 15.114 * pixelGrid * pixelH;
							w = 21.0691 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							text = "OnDraw";
						};
						class OOP_TextRight_120_120: OOP_TextRight {
							idc = 120;
							x = 31.6036 * pixelGrid * pixelW;
							y = 15.114 * pixelGrid * pixelH;
							w = 21.0691 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							text = "OnVideoStopped";
						};
						class cbOnVideoStopped_121: OOP_Checkbox {
							idc = 121;
							x = 52.6727 * pixelGrid * pixelW;
							y = 15.114 * pixelGrid * pixelH;
							w = 2.63363 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							onCheckedChanged = "['static', ['onCheckedChanged_cbOnVideoStopped', _this]] call oo_ctrlModifyDialog;";
						};
						class cbOnDraw_122: OOP_Checkbox {
							idc = 122;
							x = 23.7027 * pixelGrid * pixelW;
							y = 15.114 * pixelGrid * pixelH;
							w = 2.63363 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							onCheckedChanged = "['static', ['onCheckedChanged_cbOnDraw', _this]] call oo_ctrlModifyDialog;";
						};
					};
				};
				class layerStyle_123 : OOP_SubLayer {
					idc = 123;
					x = 79.009 * pixelGrid * pixelW;
					y = 35.266 * pixelGrid * pixelH;
					w = 71.1081 * pixelGrid * pixelW;
					h = 52.899 * pixelGrid * pixelH;
					class controls{
						class OOP_TextRight_124_124: OOP_TextRight {
							idc = 124;
							x = 2.63363 * pixelGrid * pixelW;
							y = 2.519 * pixelGrid * pixelH;
							w = 21.0691 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							text = "ID Control";
						};
						class editID_125: OOP_Edit {
							idc = 125;
							x = 26.3363 * pixelGrid * pixelW;
							y = 2.519 * pixelGrid * pixelH;
							w = 42.1381 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
						};
						class OOP_TextRight_126_126: OOP_TextRight {
							idc = 126;
							x = 2.63363 * pixelGrid * pixelW;
							y = 7.557 * pixelGrid * pixelH;
							w = 21.0691 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							text = "Name";
						};
						class editName_127: OOP_Edit {
							idc = 127;
							x = 26.3363 * pixelGrid * pixelW;
							y = 7.557 * pixelGrid * pixelH;
							w = 42.1381 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
						};
						class OOP_TextRight_128_128: OOP_TextRight {
							idc = 128;
							x = 2.63363 * pixelGrid * pixelW;
							y = 12.595 * pixelGrid * pixelH;
							w = 21.0691 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							text = "Text";
						};
						class editText_129: OOP_Edit {
							idc = 129;
							x = 26.3363 * pixelGrid * pixelW;
							y = 12.595 * pixelGrid * pixelH;
							w = 42.1381 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
						};
						class OOP_TextRight_130_130: OOP_TextRight {
							idc = 130;
							x = 2.63363 * pixelGrid * pixelW;
							y = 17.633 * pixelGrid * pixelH;
							w = 21.0691 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							text = "Background Color";
						};
						class editBGColor_131: OOP_Edit {
							idc = 131;
							x = 26.3363 * pixelGrid * pixelW;
							y = 17.633 * pixelGrid * pixelH;
							w = 42.1381 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							text = "[-1,-1,-1,-1]";
							onSetFocus = "['static', ['onSetFocus_editBGColor', _this]] call oo_ctrlModifyDialog;";
							onKillFocus = "['static', ['onKillFocus_editBGColor', _this]] call oo_ctrlModifyDialog;";
						};
						class OOP_TextRight_132_132: OOP_TextRight {
							idc = 132;
							x = 2.63363 * pixelGrid * pixelW;
							y = 22.671 * pixelGrid * pixelH;
							w = 21.0691 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							text = "Text Color";
						};
						class editTextColor_133: OOP_Edit {
							idc = 133;
							x = 26.3363 * pixelGrid * pixelW;
							y = 22.671 * pixelGrid * pixelH;
							w = 42.1381 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							text = "[-1,-1,-1,-1]";
						};
						class OOP_TextRight_134_134: OOP_TextRight {
							idc = 134;
							x = 2.63363 * pixelGrid * pixelW;
							y = 27.709 * pixelGrid * pixelH;
							w = 21.0691 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							text = "Foreground Color";
						};
						class editFGColor_135: OOP_Edit {
							idc = 135;
							x = 26.3363 * pixelGrid * pixelW;
							y = 27.709 * pixelGrid * pixelH;
							w = 42.1381 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							text = "[-1,-1,-1,-1]";
						};
						class OOP_TextRight_136_136: OOP_TextRight {
							idc = 136;
							x = 2.63363 * pixelGrid * pixelW;
							y = 32.747 * pixelGrid * pixelH;
							w = 21.0691 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							text = "Tooltip";
						};
						class editTooltip_137: OOP_Edit {
							idc = 137;
							x = 26.3363 * pixelGrid * pixelW;
							y = 32.747 * pixelGrid * pixelH;
							w = 42.1381 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
						};
						class editTooltipColorBoX_138: OOP_Edit {
							idc = 138;
							x = 26.3363 * pixelGrid * pixelW;
							y = 37.785 * pixelGrid * pixelH;
							w = 42.1381 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							text = "[-1,-1,-1,-1]";
						};
						class editTooltipColorShade_139: OOP_Edit {
							idc = 139;
							x = 26.3363 * pixelGrid * pixelW;
							y = 42.823 * pixelGrid * pixelH;
							w = 42.1381 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							text = "[-1,-1,-1,-1]";
						};
						class editTooltipColorText_140: OOP_Edit {
							idc = 140;
							x = 26.3363 * pixelGrid * pixelW;
							y = 47.861 * pixelGrid * pixelH;
							w = 42.1381 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							text = "[-1,-1,-1,-1]";
						};
						class OOP_TextRight_141_141: OOP_TextRight {
							idc = 141;
							x = 2.63363 * pixelGrid * pixelW;
							y = 37.785 * pixelGrid * pixelH;
							w = 21.0691 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							text = "Tooltip Color Box";
						};
						class OOP_TextRight_142_142: OOP_TextRight {
							idc = 142;
							x = 2.63363 * pixelGrid * pixelW;
							y = 42.823 * pixelGrid * pixelH;
							w = 21.0691 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							text = "Tooltip Color Shade";
						};
						class OOP_TextRight_143_143: OOP_TextRight {
							idc = 143;
							x = 2.63363 * pixelGrid * pixelW;
							y = 47.861 * pixelGrid * pixelH;
							w = 21.0691 * pixelGrid * pixelW;
							h = 2.519 * pixelGrid * pixelH;
							text = "Tooltip Color Text";
						};
					};
				};
			};
		};
	};
	class controls {};
};



/*
["ctrlModifyDialog",9001,[[[["57.9399 * pixelGrid * pixelW","27.709 * pixelGrid * pixelH","94.8108 * pixelGrid * pixelW","70.532 * pixelGrid * pixelH"],"#(rgb,8,8,3)color(0.2,0.2,0.2,0.8)","","","OOP_Picture",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["57.9399 * pixelGrid * pixelW","27.709 * pixelGrid * pixelH","94.8108 * pixelGrid * pixelW","5.038 * pixelGrid * pixelH"],"Modify control:","title","","OOP_Text",true,[],[1,1,1,1],[0.2,0.7,0.2,1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["57.9399 * pixelGrid * pixelW","35.266 * pixelGrid * pixelH","18.4354 * pixelGrid * pixelW","3.7785 * pixelGrid * pixelH"],"Style","btnStyle","","OOP_Button",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["57.9399 * pixelGrid * pixelW","40.304 * pixelGrid * pixelH","18.4354 * pixelGrid * pixelW","3.97614 * pixelGrid * pixelH"],"Gen EVH","btnGen","","OOP_Button",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["57.9399 * pixelGrid * pixelW","45.342 * pixelGrid * pixelH","18.4354 * pixelGrid * pixelW","3.97614 * pixelGrid * pixelH"],"Mouse EVH","btnMouse","","OOP_Button",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["57.9399 * pixelGrid * pixelW","50.38 * pixelGrid * pixelH","18.4354 * pixelGrid * pixelW","3.97614 * pixelGrid * pixelH"],"Keyboard EVH","btnKB","","OOP_Button",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["57.9399 * pixelGrid * pixelW","55.418 * pixelGrid * pixelH","18.4354 * pixelGrid * pixelW","3.97614 * pixelGrid * pixelH"],"LB EVH","btnLB","","OOP_Button",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["57.9399 * pixelGrid * pixelW","60.456 * pixelGrid * pixelH","18.4354 * pixelGrid * pixelW","3.97614 * pixelGrid * pixelH"],"Tree EVH","btnTree","","OOP_Button",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["57.9399 * pixelGrid * pixelW","65.494 * pixelGrid * pixelH","18.4354 * pixelGrid * pixelW","3.97614 * pixelGrid * pixelH"],"Tool/Cb EVH","btnTool","","OOP_Button",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["57.9399 * pixelGrid * pixelW","70.532 * pixelGrid * pixelH","18.4354 * pixelGrid * pixelW","3.97614 * pixelGrid * pixelH"],"Other EVH","btnOther","","OOP_Button",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["115.88 * pixelGrid * pixelW","89.4245 * pixelGrid * pixelH","18.4354 * pixelGrid * pixelW","5.038 * pixelGrid * pixelH"],"Valider","btnValider","","OOP_Button",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["73.7417 * pixelGrid * pixelW","89.4245 * pixelGrid * pixelH","18.4354 * pixelGrid * pixelW","5.038 * pixelGrid * pixelH"],"Fermer","btnClose","","OOP_Button",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["79.009 * pixelGrid * pixelW","35.266 * pixelGrid * pixelH","70.2302 * pixelGrid * pixelW","50.38 * pixelGrid * pixelH"],"","layerGen","","OOP_SubLayer",false,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]],[[[["7.9009 * pixelGrid * pixelW","5.038 * pixelGrid * pixelH","15.8018 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"Init","","","OOP_TextRight",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["7.9009 * pixelGrid * pixelW","10.076 * pixelGrid * pixelH","15.8018 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"onDestroy","","","OOP_TextRight",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["7.9009 * pixelGrid * pixelW","15.114 * pixelGrid * pixelH","15.8018 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"onLoad","","","OOP_TextRight",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["7.9009 * pixelGrid * pixelW","20.152 * pixelGrid * pixelH","15.8018 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"onUnload","","","OOP_TextRight",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["36.8709 * pixelGrid * pixelW","5.038 * pixelGrid * pixelH","15.8018 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"onSetFocus","","","OOP_TextRight",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["36.8709 * pixelGrid * pixelW","10.076 * pixelGrid * pixelH","15.8018 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"onKillFocus","","","OOP_TextRight",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["36.8709 * pixelGrid * pixelW","15.114 * pixelGrid * pixelH","15.8018 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"onTimer","","","OOP_TextRight",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["36.8709 * pixelGrid * pixelW","20.152 * pixelGrid * pixelH","15.8018 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"onCanDestroy","","","OOP_TextRight",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["23.7027 * pixelGrid * pixelW","5.038 * pixelGrid * pixelH","2.63363 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"","cbInit","","OOP_Checkbox",true,["onCheckedChanged"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["23.7027 * pixelGrid * pixelW","10.076 * pixelGrid * pixelH","2.63363 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"","cbOnDestroy","","OOP_Checkbox",true,["onCheckedChanged"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["23.7027 * pixelGrid * pixelW","15.114 * pixelGrid * pixelH","2.63363 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"","cbOnLoad","","OOP_Checkbox",true,["onCheckedChanged"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["23.7027 * pixelGrid * pixelW","20.152 * pixelGrid * pixelH","2.63363 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"","cbOnUnload","","OOP_Checkbox",true,["onCheckedChanged"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["52.6727 * pixelGrid * pixelW","5.038 * pixelGrid * pixelH","2.63363 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"","cbOnSetFocus","","OOP_Checkbox",true,["onCheckedChanged"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["52.6727 * pixelGrid * pixelW","10.076 * pixelGrid * pixelH","2.63363 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"","cbOnKillFocus","","OOP_Checkbox",true,["onCheckedChanged"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["52.6727 * pixelGrid * pixelW","15.114 * pixelGrid * pixelH","2.63363 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"","cbOnTimer","","OOP_Checkbox",true,["onCheckedChanged"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["52.6727 * pixelGrid * pixelW","20.152 * pixelGrid * pixelH","2.63363 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"","cbOnCanDestroy","","OOP_Checkbox",true,["onCheckedChanged"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]]]],[[["79.009 * pixelGrid * pixelW","35.266 * pixelGrid * pixelH","70.2302 * pixelGrid * pixelW","50.38 * pixelGrid * pixelH"],"","layerMouse","","OOP_SubLayer",false,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]],[[[["2.63363 * pixelGrid * pixelW","5.038 * pixelGrid * pixelH","21.0691 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"onMouseButtonDown","","","OOP_TextRight",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["2.63363 * pixelGrid * pixelW","10.076 * pixelGrid * pixelH","21.0691 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"onMouseButtonUp","","","OOP_TextRight",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["2.63363 * pixelGrid * pixelW","15.114 * pixelGrid * pixelH","21.0691 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"onMouseButtonClick","","","OOP_TextRight",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["2.63363 * pixelGrid * pixelW","20.152 * pixelGrid * pixelH","21.0691 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"onMouseButtonDblClick","","","OOP_TextRight",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["36.8709 * pixelGrid * pixelW","5.038 * pixelGrid * pixelH","15.8018 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"onMouseMoving","","","OOP_TextRight",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["36.8709 * pixelGrid * pixelW","10.076 * pixelGrid * pixelH","15.8018 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"onMouseHolding","","","OOP_TextRight",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["36.8709 * pixelGrid * pixelW","15.114 * pixelGrid * pixelH","15.8018 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"onMouseZChanged","","","OOP_TextRight",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["36.8709 * pixelGrid * pixelW","20.152 * pixelGrid * pixelH","15.8018 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"onButtonDblClick","","","OOP_TextRight",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["23.7027 * pixelGrid * pixelW","5.038 * pixelGrid * pixelH","2.63363 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"","cbOnMouseButtonDown","","OOP_Checkbox",true,["onCheckedChanged"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["23.7027 * pixelGrid * pixelW","10.076 * pixelGrid * pixelH","2.63363 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"","cbOnMouseButtonUp","","OOP_Checkbox",true,["onCheckedChanged"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["23.7027 * pixelGrid * pixelW","15.114 * pixelGrid * pixelH","2.63363 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"","cbOnMouseButtonClick","","OOP_Checkbox",true,["onCheckedChanged"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["23.7027 * pixelGrid * pixelW","20.152 * pixelGrid * pixelH","2.63363 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"","cbOnMouseButtonDblClick","","OOP_Checkbox",true,["onCheckedChanged"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["52.6727 * pixelGrid * pixelW","5.038 * pixelGrid * pixelH","2.63363 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"","cbOnMouseMoving","","OOP_Checkbox",true,["onCheckedChanged"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["52.6727 * pixelGrid * pixelW","10.076 * pixelGrid * pixelH","2.63363 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"","cbOnMouseHolding","","OOP_Checkbox",true,["onCheckedChanged"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["52.6727 * pixelGrid * pixelW","15.114 * pixelGrid * pixelH","2.63363 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"","cbOnMouseZChanged","","OOP_Checkbox",true,["onCheckedChanged"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["52.6727 * pixelGrid * pixelW","20.152 * pixelGrid * pixelH","2.63363 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"","cbOnButtonDblClick","","OOP_Checkbox",true,["onCheckedChanged"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["2.63363 * pixelGrid * pixelW","25.19 * pixelGrid * pixelH","21.0691 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"onButtonDown","","","OOP_TextRight",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["2.63363 * pixelGrid * pixelW","30.228 * pixelGrid * pixelH","21.0691 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"onButtonUp","","","OOP_TextRight",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["2.63363 * pixelGrid * pixelW","35.266 * pixelGrid * pixelH","21.0691 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"onButtonClick","","","OOP_TextRight",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["31.6036 * pixelGrid * pixelW","25.19 * pixelGrid * pixelH","21.0691 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"onMouseEnter","","","OOP_TextRight",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["31.6036 * pixelGrid * pixelW","30.228 * pixelGrid * pixelH","21.0691 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"onMouseExit","","","OOP_TextRight",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["23.7027 * pixelGrid * pixelW","25.19 * pixelGrid * pixelH","2.63363 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"","cbOnButtonDown","","OOP_Checkbox",true,["onCheckedChanged"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["23.7027 * pixelGrid * pixelW","30.228 * pixelGrid * pixelH","2.63363 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"","cbOnButtonUp","","OOP_Checkbox",true,["onCheckedChanged"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["23.7027 * pixelGrid * pixelW","35.266 * pixelGrid * pixelH","2.63363 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"","cbOnButtonClick","","OOP_Checkbox",true,["onCheckedChanged"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["52.6727 * pixelGrid * pixelW","25.19 * pixelGrid * pixelH","2.63363 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"","cbOnMouseEnter","","OOP_Checkbox",true,["onCheckedChanged"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["52.6727 * pixelGrid * pixelW","30.228 * pixelGrid * pixelH","2.63363 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"","cbOnMouseExit","","OOP_Checkbox",true,["onCheckedChanged"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]]]],[[["79.009 * pixelGrid * pixelW","35.266 * pixelGrid * pixelH","70.2302 * pixelGrid * pixelW","50.38 * pixelGrid * pixelH"],"","layerKB","","OOP_SubLayer",false,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]],[[[["2.63363 * pixelGrid * pixelW","5.038 * pixelGrid * pixelH","21.0691 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"onKeyDown","","","OOP_TextRight",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["2.63363 * pixelGrid * pixelW","10.076 * pixelGrid * pixelH","21.0691 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"onKeyUp","","","OOP_TextRight",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["2.63363 * pixelGrid * pixelW","15.114 * pixelGrid * pixelH","21.0691 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"onChar","","","OOP_TextRight",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["36.8709 * pixelGrid * pixelW","5.038 * pixelGrid * pixelH","15.8018 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"onIMEChar","","","OOP_TextRight",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["36.8709 * pixelGrid * pixelW","10.076 * pixelGrid * pixelH","15.8018 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"onIMEComposition","","","OOP_TextRight",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["23.7027 * pixelGrid * pixelW","5.038 * pixelGrid * pixelH","2.63363 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"","cbOnKeyDown","","OOP_Checkbox",true,["onCheckedChanged"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["23.7027 * pixelGrid * pixelW","10.076 * pixelGrid * pixelH","2.63363 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"","cbOnKeyUp","","OOP_Checkbox",true,["onCheckedChanged"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["23.7027 * pixelGrid * pixelW","15.114 * pixelGrid * pixelH","2.63363 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"","cbOnChar","","OOP_Checkbox",true,["onCheckedChanged"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["52.6727 * pixelGrid * pixelW","5.038 * pixelGrid * pixelH","2.63363 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"","cbOnIMEChar","","OOP_Checkbox",true,["onCheckedChanged"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["52.6727 * pixelGrid * pixelW","10.076 * pixelGrid * pixelH","2.63363 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"","cbOnIMEComposition","","OOP_Checkbox",true,["onCheckedChanged"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["36.8709 * pixelGrid * pixelW","15.114 * pixelGrid * pixelH","15.8018 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"onJoystickButton","","","OOP_TextRight",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["52.6727 * pixelGrid * pixelW","15.114 * pixelGrid * pixelH","2.63363 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"","cbOnJoystickButton","","OOP_Checkbox",true,["onCheckedChanged"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]]]],[[["79.009 * pixelGrid * pixelW","35.266 * pixelGrid * pixelH","70.2302 * pixelGrid * pixelW","50.38 * pixelGrid * pixelH"],"","layerLB","","OOP_SubLayer",false,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]],[[[["2.63363 * pixelGrid * pixelW","5.038 * pixelGrid * pixelH","21.0691 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"OnLBSelChanged","","","OOP_TextRight",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["2.63363 * pixelGrid * pixelW","10.076 * pixelGrid * pixelH","21.0691 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"OnLBListSelChanged","","","OOP_TextRight",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["2.63363 * pixelGrid * pixelW","15.114 * pixelGrid * pixelH","21.0691 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"OnLBDblClick","","","OOP_TextRight",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["36.8709 * pixelGrid * pixelW","5.038 * pixelGrid * pixelH","15.8018 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"OnLBDrag","","","OOP_TextRight",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["36.8709 * pixelGrid * pixelW","10.076 * pixelGrid * pixelH","15.8018 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"OnLBDragging","","","OOP_TextRight",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["23.7027 * pixelGrid * pixelW","5.038 * pixelGrid * pixelH","2.63363 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"","cbOnLBSelChanged","","OOP_Checkbox",true,["onCheckedChanged"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["23.7027 * pixelGrid * pixelW","10.076 * pixelGrid * pixelH","2.63363 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"","cbOnLBListSelChanged","","OOP_Checkbox",true,["onCheckedChanged"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["23.7027 * pixelGrid * pixelW","15.114 * pixelGrid * pixelH","2.63363 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"","cbOnLBDblClick","","OOP_Checkbox",true,["onCheckedChanged"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["52.6727 * pixelGrid * pixelW","5.038 * pixelGrid * pixelH","2.63363 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"","cbOnLBDrag","","OOP_Checkbox",true,["onCheckedChanged"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["52.6727 * pixelGrid * pixelW","10.076 * pixelGrid * pixelH","2.63363 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"","cbOnLBDragging","","OOP_Checkbox",true,["onCheckedChanged"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["36.8709 * pixelGrid * pixelW","15.114 * pixelGrid * pixelH","15.8018 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"OnLBDrop","","","OOP_TextRight",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["52.6727 * pixelGrid * pixelW","15.114 * pixelGrid * pixelH","2.63363 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"","cbOnLBDrop","","OOP_Checkbox",true,["onCheckedChanged"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]]]],[[["79.009 * pixelGrid * pixelW","35.266 * pixelGrid * pixelH","70.2302 * pixelGrid * pixelW","50.38 * pixelGrid * pixelH"],"","layerTree","","OOP_SubLayer",false,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]],[[[["2.63363 * pixelGrid * pixelW","5.038 * pixelGrid * pixelH","21.0691 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"OnTreeSelChanged","","","OOP_TextRight",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["2.63363 * pixelGrid * pixelW","10.076 * pixelGrid * pixelH","21.0691 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"OnTreeLButtonDown","","","OOP_TextRight",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["2.63363 * pixelGrid * pixelW","15.114 * pixelGrid * pixelH","21.0691 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"OnTreeDblClickk","","","OOP_TextRight",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["36.8709 * pixelGrid * pixelW","5.038 * pixelGrid * pixelH","15.8018 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"OnTreeExpanded","","","OOP_TextRight",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["36.8709 * pixelGrid * pixelW","10.076 * pixelGrid * pixelH","15.8018 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"OnTreeCollapsed","","","OOP_TextRight",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["23.7027 * pixelGrid * pixelW","5.038 * pixelGrid * pixelH","2.63363 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"","cbOnTreeSelChanged","","OOP_Checkbox",true,["onCheckedChanged"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["23.7027 * pixelGrid * pixelW","10.076 * pixelGrid * pixelH","2.63363 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"","cbOnTreeLButtonDown","","OOP_Checkbox",true,["onCheckedChanged"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["23.7027 * pixelGrid * pixelW","15.114 * pixelGrid * pixelH","2.63363 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"","cbOnTreeDblClick","","OOP_Checkbox",true,["onCheckedChanged"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["52.6727 * pixelGrid * pixelW","5.038 * pixelGrid * pixelH","2.63363 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"","cbOnTreeExpanded","","OOP_Checkbox",true,["onCheckedChanged"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["52.6727 * pixelGrid * pixelW","10.076 * pixelGrid * pixelH","2.63363 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"","cbOnTreeCollapsed","","OOP_Checkbox",true,["onCheckedChanged"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["36.8709 * pixelGrid * pixelW","15.114 * pixelGrid * pixelH","15.8018 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"OnTreeMouseMove","","","OOP_TextRight",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["52.6727 * pixelGrid * pixelW","15.114 * pixelGrid * pixelH","2.63363 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"","cbOnTreeMouseMove","","OOP_Checkbox",true,["onCheckedChanged"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["2.63363 * pixelGrid * pixelW","20.152 * pixelGrid * pixelH","21.0691 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"OnTreeMouseHold","","","OOP_TextRight",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["23.7027 * pixelGrid * pixelW","20.152 * pixelGrid * pixelH","2.63363 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"","cbOnTreeMouseHold","","OOP_Checkbox",true,["onCheckedChanged"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["52.6727 * pixelGrid * pixelW","20.152 * pixelGrid * pixelH","2.63363 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"","cbOnTreeMouseExit","","OOP_Checkbox",true,["onCheckedChanged"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["36.8709 * pixelGrid * pixelW","20.152 * pixelGrid * pixelH","15.8018 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"OnTreeMouseExit","","","OOP_TextRight",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]]]],[[["79.009 * pixelGrid * pixelW","35.266 * pixelGrid * pixelH","70.2302 * pixelGrid * pixelW","50.38 * pixelGrid * pixelH"],"","layerToolCB","","OOP_SubLayer",false,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]],[[[["2.63363 * pixelGrid * pixelW","5.038 * pixelGrid * pixelH","21.0691 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"OnToolBoxSelChanged","","","OOP_TextRight",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["2.63363 * pixelGrid * pixelW","10.076 * pixelGrid * pixelH","21.0691 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"OnChecked","","","OOP_TextRight",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["28.97 * pixelGrid * pixelW","5.038 * pixelGrid * pixelH","23.7027 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"OnCheckedChanged","","","OOP_TextRight",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["28.97 * pixelGrid * pixelW","10.076 * pixelGrid * pixelH","23.7027 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"OnCheckBoxesSelChanged","","","OOP_TextRight",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["23.7027 * pixelGrid * pixelW","5.038 * pixelGrid * pixelH","2.63363 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"","cbOnToolBoxSelChanged","","OOP_Checkbox",true,["onCheckedChanged"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["23.7027 * pixelGrid * pixelW","10.076 * pixelGrid * pixelH","2.63363 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"","cbOnChecked","","OOP_Checkbox",true,["onCheckedChanged"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["52.6727 * pixelGrid * pixelW","5.038 * pixelGrid * pixelH","2.63363 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"","cbOnCheckedChanged","","OOP_Checkbox",true,["onCheckedChanged"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["52.6727 * pixelGrid * pixelW","10.076 * pixelGrid * pixelH","2.63363 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"","cbOnCheckBoxesSelChanged","","OOP_Checkbox",true,["onCheckedChanged"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]]]],[[["79.009 * pixelGrid * pixelW","35.266 * pixelGrid * pixelH","71.1081 * pixelGrid * pixelW","50.38 * pixelGrid * pixelH"],"","layerOther","","OOP_SubLayer",false,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]],[[[["2.63363 * pixelGrid * pixelW","5.038 * pixelGrid * pixelH","21.0691 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"OnHTMLLink","","","OOP_TextRight",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["2.63363 * pixelGrid * pixelW","10.076 * pixelGrid * pixelH","21.0691 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"OnSliderPosChanged","","","OOP_TextRight",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["28.97 * pixelGrid * pixelW","5.038 * pixelGrid * pixelH","23.7027 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"OnObjectMoved","","","OOP_TextRight",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["28.97 * pixelGrid * pixelW","10.076 * pixelGrid * pixelH","23.7027 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"OnMenuSelected","","","OOP_TextRight",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["23.7027 * pixelGrid * pixelW","5.038 * pixelGrid * pixelH","2.63363 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"","cbOnHTMLLink","","OOP_Checkbox",true,["onCheckedChanged"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["23.7027 * pixelGrid * pixelW","10.076 * pixelGrid * pixelH","2.63363 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"","cbOnSliderPosChanged","","OOP_Checkbox",true,["onCheckedChanged"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["52.6727 * pixelGrid * pixelW","5.038 * pixelGrid * pixelH","2.63363 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"","cbOnObjectMoved","","OOP_Checkbox",true,["onCheckedChanged"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["52.6727 * pixelGrid * pixelW","10.076 * pixelGrid * pixelH","2.63363 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"","cbOnMenuSelected","","OOP_Checkbox",true,["onCheckedChanged"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["2.63363 * pixelGrid * pixelW","15.114 * pixelGrid * pixelH","21.0691 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"OnDraw","","","OOP_TextRight",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["31.6036 * pixelGrid * pixelW","15.114 * pixelGrid * pixelH","21.0691 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"OnVideoStopped","","","OOP_TextRight",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["52.6727 * pixelGrid * pixelW","15.114 * pixelGrid * pixelH","2.63363 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"","cbOnVideoStopped","","OOP_Checkbox",true,["onCheckedChanged"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["23.7027 * pixelGrid * pixelW","15.114 * pixelGrid * pixelH","2.63363 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"","cbOnDraw","","OOP_Checkbox",true,["onCheckedChanged"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]]]],[[["79.009 * pixelGrid * pixelW","35.266 * pixelGrid * pixelH","71.1081 * pixelGrid * pixelW","52.899 * pixelGrid * pixelH"],"","layerStyle","","OOP_SubLayer",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]],[[[["2.63363 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH","21.0691 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"ID Control","","","OOP_TextRight",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["26.3363 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH","42.1381 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"","editID","","OOP_Edit",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["2.63363 * pixelGrid * pixelW","7.557 * pixelGrid * pixelH","21.0691 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"Name","","","OOP_TextRight",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["26.3363 * pixelGrid * pixelW","7.557 * pixelGrid * pixelH","42.1381 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"","editName","","OOP_Edit",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["2.63363 * pixelGrid * pixelW","12.595 * pixelGrid * pixelH","21.0691 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"Text","","","OOP_TextRight",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["26.3363 * pixelGrid * pixelW","12.595 * pixelGrid * pixelH","42.1381 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"","editText","","OOP_Edit",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["2.63363 * pixelGrid * pixelW","17.633 * pixelGrid * pixelH","21.0691 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"Background Color","","","OOP_TextRight",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["26.3363 * pixelGrid * pixelW","17.633 * pixelGrid * pixelH","42.1381 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"[-1,-1,-1,-1]","editBGColor","","OOP_Edit",true,["onSetFocus","onKillFocus"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["2.63363 * pixelGrid * pixelW","22.671 * pixelGrid * pixelH","21.0691 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"Text Color","","","OOP_TextRight",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["26.3363 * pixelGrid * pixelW","22.671 * pixelGrid * pixelH","42.1381 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"[-1,-1,-1,-1]","editTextColor","","OOP_Edit",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["2.63363 * pixelGrid * pixelW","27.709 * pixelGrid * pixelH","21.0691 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"Foreground Color","","","OOP_TextRight",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["26.3363 * pixelGrid * pixelW","27.709 * pixelGrid * pixelH","42.1381 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"[-1,-1,-1,-1]","editFGColor","","OOP_Edit",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["2.63363 * pixelGrid * pixelW","32.747 * pixelGrid * pixelH","21.0691 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"Tooltip","","","OOP_TextRight",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["26.3363 * pixelGrid * pixelW","32.747 * pixelGrid * pixelH","42.1381 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"","editTooltip","","OOP_Edit",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["26.3363 * pixelGrid * pixelW","37.785 * pixelGrid * pixelH","42.1381 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"[-1,-1,-1,-1]","editTooltipColorBoX","","OOP_Edit",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["26.3363 * pixelGrid * pixelW","42.823 * pixelGrid * pixelH","42.1381 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"[-1,-1,-1,-1]","editTooltipColorShade","","OOP_Edit",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["26.3363 * pixelGrid * pixelW","47.861 * pixelGrid * pixelH","42.1381 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"[-1,-1,-1,-1]","editTooltipColorText","","OOP_Edit",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["2.63363 * pixelGrid * pixelW","37.785 * pixelGrid * pixelH","21.0691 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"Tooltip Color Box","","","OOP_TextRight",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["2.63363 * pixelGrid * pixelW","42.823 * pixelGrid * pixelH","21.0691 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"Tooltip Color Shade","","","OOP_TextRight",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["2.63363 * pixelGrid * pixelW","47.861 * pixelGrid * pixelH","21.0691 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"Tooltip Color Text","","","OOP_TextRight",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]]]]]]
*/
