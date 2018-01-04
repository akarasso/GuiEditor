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
				class Layer_2 : OOP_SubLayer {
					idc = 2;
					x = 55.3063 * pixelGrid * pixelW;
					y = 32.747 * pixelGrid * pixelH;
					w = 105.345 * pixelGrid * pixelW;
					h = 62.975 * pixelGrid * pixelH;
					class controls{
						class OOP_Button_3: OOP_Button {
							idc = 3;
							x = 2.63363 * pixelGrid * pixelW;
							y = 25.19 * pixelGrid * pixelH;
							w = 23.7027 * pixelGrid * pixelW;
							h = 15.114 * pixelGrid * pixelH;
							text = "Button..";
							action = "['static', ['btnAction_btnValideDisplay', nil]] call oo_NewDialog;";
						};
						class OOP_Listbox_4: OOP_Listbox {
							idc = 4;
							x = 2.63363 * pixelGrid * pixelW;
							y = 2.519 * pixelGrid * pixelH;
							w = 23.7027 * pixelGrid * pixelW;
							h = 22.671 * pixelGrid * pixelH;
							text = "";
						};
					};
				};
			};
		};
	};
	class controls {};
};
