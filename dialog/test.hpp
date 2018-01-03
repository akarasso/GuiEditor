class Test {
	idd = 5000;
	name= "Test";
	movingEnable = false;
	enableSimulation = true;
	class controlsBackground {
		class Layer_1 : OOP_SubLayer {
			idc = 1;
			x = -61.9078 * pixelGrid * pixelW;
			y = -35.5654 * pixelGrid * pixelH;
			w = 210.691 * pixelGrid * pixelW;
			h = 125.95 * pixelGrid * pixelH;
			class controls{
				class life_RscPicture_2: life_RscPicture {
					idc = 2;
					x = 68.4744 * pixelGrid * pixelW;
					y = 17.633 * pixelGrid * pixelH;
					w = 63.2072 * pixelGrid * pixelW;
					h = 90.684 * pixelGrid * pixelH;
					text = "#(rgb,8,8,3)color(0.2,0.2,0.2,0.8)";
				};
				class OOP_Text_3: OOP_Text {
					idc = 3;
					x = 68.4744 * pixelGrid * pixelW;
					y = 17.633 * pixelGrid * pixelH;
					w = 63.2072 * pixelGrid * pixelW;
					h = 7.557 * pixelGrid * pixelH;
					text = "I m your title";
					colorBackground[] = {1, 0, 0, 1};
					tooltip = "Look At me";
				};
				class OOP_Listbox_4: OOP_Listbox {
					idc = 4;
					x = 71.1081 * pixelGrid * pixelW;
					y = 25.19 * pixelGrid * pixelH;
					w = 57.9399 * pixelGrid * pixelW;
					h = 75.57 * pixelGrid * pixelH;
					text = "";
					onLBSelChanged = "['static', ['onLBSelChanged_OOP_Listbox_4', _this]] call oo_Test;";
				};
				class OOP_Button_5: OOP_Button {
					idc = 5;
					x = 107.979 * pixelGrid * pixelW;
					y = 100.76 * pixelGrid * pixelH;
					w = 18.4354 * pixelGrid * pixelW;
					h = 5.038 * pixelGrid * pixelH;
					text = "Valider";
					action = "['static', ['btnAction_btnValide', nil]] call oo_Test;";
				};
				class OOP_Button_6: OOP_Button {
					idc = 6;
					x = 76.3753 * pixelGrid * pixelW;
					y = 100.76 * pixelGrid * pixelH;
					w = 18.4354 * pixelGrid * pixelW;
					h = 5.038 * pixelGrid * pixelH;
					text = "Close";
					onMouseEnter = "['static', ['onMouseEnter_btnClose', _this]] call oo_Test;";
					onMouseExit = "['static', ['onMouseExit_btnClose', _this]] call oo_Test;";
					action = "['static', ['btnAction_btnClose', nil]] call oo_Test;";
				};
			};
		};
	};
	class controls {};
};
