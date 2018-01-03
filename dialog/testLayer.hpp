class NewDialog {
	idd = 1000;
	name= "NewDialog";
	movingEnable = false;
	enableSimulation = true;
	class controlsBackground {
		class Layer_1 : OOP_SubLayer {
			idc = 1;
			x = -61.9078 * pixelGrid * pixelW;
			y = -28.35 * pixelGrid * pixelH;
			w = 210.691 * pixelGrid * pixelW;
			h = 125.95 * pixelGrid * pixelH;
			class controls{
				class life_RscPicture_2: life_RscPicture {
					idc = 2;
					x = 71.1081 * pixelGrid * pixelW;
					y = 27.709 * pixelGrid * pixelH;
					w = 50.039 * pixelGrid * pixelW;
					h = 70.532 * pixelGrid * pixelH;
					text = "#(rgb,8,8,3)color(0.1,0.1,0.1,1)";
				};
				class OOP_Text_3: OOP_Text {
					idc = 3;
					x = 71.1081 * pixelGrid * pixelW;
					y = 27.709 * pixelGrid * pixelH;
					w = 50.039 * pixelGrid * pixelW;
					h = 7.557 * pixelGrid * pixelH;
					text = "Test";
					colorBackground[] = {1, 0, 0, 1};
					tooltip = "ZZZ";
				};
				class OOP_Button_4: OOP_Button {
					idc = 4;
					x = 73.7417 * pixelGrid * pixelW;
					y = 37.785 * pixelGrid * pixelH;
					w = 13.1682 * pixelGrid * pixelW;
					h = 7.557 * pixelGrid * pixelH;
					text = "Layer 1";
					action = "['static', ['btnAction_OOP_Button_4', nil]] call oo_NewDialog;";
				};
				class OOP_Button_5: OOP_Button {
					idc = 5;
					x = 89.5435 * pixelGrid * pixelW;
					y = 37.785 * pixelGrid * pixelH;
					w = 13.1682 * pixelGrid * pixelW;
					h = 7.557 * pixelGrid * pixelH;
					text = "Layer 2";
					action = "['static', ['btnAction_OOP_Button_5', nil]] call oo_NewDialog;";
				};
				class OOP_Button_6: OOP_Button {
					idc = 6;
					x = 105.345 * pixelGrid * pixelW;
					y = 37.785 * pixelGrid * pixelH;
					w = 13.1682 * pixelGrid * pixelW;
					h = 7.557 * pixelGrid * pixelH;
					text = "Layer 3";
					action = "['static', ['btnAction_OOP_Button_6', nil]] call oo_NewDialog;";
				};
				class Layer_7 : OOP_SubLayer {
					idc = 7;
					x = 73.7417 * pixelGrid * pixelW;
					y = 47.861 * pixelGrid * pixelH;
					w = 44.7717 * pixelGrid * pixelW;
					h = 40.304 * pixelGrid * pixelH;
					class controls{
						class OOP_Listbox_10: OOP_Listbox {
							idc = 10;
							x = 2.63363 * pixelGrid * pixelW;
							y = 2.519 * pixelGrid * pixelH;
							w = 39.5045 * pixelGrid * pixelW;
							h = 35.266 * pixelGrid * pixelH;
							text = "";
							onLBSelChanged = "['static', ['onLBSelChanged_OOP_Listbox_10', _this]] call oo_NewDialog;";
						};
					};
				};
				class Layer_8 : OOP_SubLayer {
					idc = 8;
					x = 73.7417 * pixelGrid * pixelW;
					y = 47.861 * pixelGrid * pixelH;
					w = 44.7717 * pixelGrid * pixelW;
					h = 40.304 * pixelGrid * pixelH;
					class controls{
						class life_RscPicture_10: life_RscPicture {
							idc = 10;
							x = 2.63363 * pixelGrid * pixelW;
							y = 2.519 * pixelGrid * pixelH;
							w = 39.5045 * pixelGrid * pixelW;
							h = 35.266 * pixelGrid * pixelH;
							text = "#(rgb,8,8,3)color(1,0,0,1)";
							onMouseEnter = "['static', ['onMouseEnter_life_RscPicture_10', _this]] call oo_NewDialog;";
						};
					};
				};
				class Layer_9 : OOP_SubLayer {
					idc = 9;
					x = 73.7417 * pixelGrid * pixelW;
					y = 47.861 * pixelGrid * pixelH;
					w = 44.7717 * pixelGrid * pixelW;
					h = 40.304 * pixelGrid * pixelH;
					class controls{
						class OOP_Text_10: OOP_Text {
							idc = 10;
							x = 2.63363 * pixelGrid * pixelW;
							y = 2.519 * pixelGrid * pixelH;
							w = 20.9438 * pixelGrid * pixelW;
							h = 4.82978 * pixelGrid * pixelH;
							text = "TestTestTest";
							colorBackground[] = {0, 0, 1, 1};
						};
						class OOP_Text_11: OOP_Text {
							idc = 11;
							x = 2.63363 * pixelGrid * pixelW;
							y = 10.076 * pixelGrid * pixelH;
							w = 20.9438 * pixelGrid * pixelW;
							h = 4.82978 * pixelGrid * pixelH;
							text = "TestTestTest";
							colorBackground[] = {0, 0, 1, 1};
						};
						class OOP_Text_12: OOP_Text {
							idc = 12;
							x = 2.63363 * pixelGrid * pixelW;
							y = 17.633 * pixelGrid * pixelH;
							w = 20.9438 * pixelGrid * pixelW;
							h = 4.82978 * pixelGrid * pixelH;
							text = "TestTestTest";
							colorBackground[] = {0, 0, 1, 1};
						};
					};
				};
				class OOP_Button_13: OOP_Button {
					idc = 13;
					x = 100.078 * pixelGrid * pixelW;
					y = 88.165 * pixelGrid * pixelH;
					w = 15.8018 * pixelGrid * pixelW;
					h = 7.557 * pixelGrid * pixelH;
					text = "Valider";
					action = "['static', ['btnAction_btnV', nil]] call oo_NewDialog;";
				};
				class OOP_Button_14: OOP_Button {
					idc = 14;
					x = 79.009 * pixelGrid * pixelW;
					y = 88.165 * pixelGrid * pixelH;
					w = 15.8018 * pixelGrid * pixelW;
					h = 7.557 * pixelGrid * pixelH;
					text = "Close";
					action = "['static', ['btnAction_btnClose', nil]] call oo_NewDialog;";
				};
			};
		};
	};
	class controls {};
};
