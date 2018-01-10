class ctrlCreateDialog {
	idd = 9000;
	name= "ctrlCreateDialog";
	movingEnable = false;
	enableSimulation = true;
	class controlsBackground {
		class Layer_0 : OOP_SubLayer {
			idc = 0;
			x = -61.9078 * pixelGrid * pixelW;
			y = -28.35 * pixelGrid * pixelH;
			w = 210.691 * pixelGrid * pixelW;
			h = 125.95 * pixelGrid * pixelH;
			class controls{
				class OOP_Picture_7: OOP_Picture {
					idc = 7;
					x = 65.8408 * pixelGrid * pixelW;
					y = 32.747 * pixelGrid * pixelH;
					w = 79.009 * pixelGrid * pixelW;
					h = 60.456 * pixelGrid * pixelH;
					text = "#(rgb,8,8,3)color(0.2,0.2,0.2,1)";
				};
				class OOP_Text_3: OOP_Text {
					idc = 3;
					x = 65.8408 * pixelGrid * pixelW;
					y = 32.747 * pixelGrid * pixelH;
					w = 79.009 * pixelGrid * pixelW;
					h = 5.038 * pixelGrid * pixelH;
					text = "Ajouter un control";
					colorText[] = {1, 1, 1, 1};
					colorBackground[] = {0.1, 0.7, 0.1, 0.9};
					tooltipColorText[] = {1, 1, 1, 1};
				};
				class OOP_Listbox_4: OOP_Listbox {
					idc = 4;
					x = 68.4744 * pixelGrid * pixelW;
					y = 40.304 * pixelGrid * pixelH;
					w = 73.7417 * pixelGrid * pixelW;
					h = 42.823 * pixelGrid * pixelH;
					text = "";
					onLBDblClick = "['static', ['onLBDblClick_listControl', _this]] call oo_ctrlCreateDialog;";
					onLBSelChanged = "['static', ['onLBSelChanged_listControl', _this]] call oo_ctrlCreateDialog;";
				};
				class OOP_Button_5: OOP_Button {
					idc = 5;
					x = 113.246 * pixelGrid * pixelW;
					y = 85.646 * pixelGrid * pixelH;
					w = 21.0691 * pixelGrid * pixelW;
					h = 5.038 * pixelGrid * pixelH;
					text = "Valider";
					action = "['static', ['btnAction_btnValider', nil]] call oo_ctrlCreateDialog;";
				};
				class OOP_Button_6: OOP_Button {
					idc = 6;
					x = 76.3753 * pixelGrid * pixelW;
					y = 85.646 * pixelGrid * pixelH;
					w = 21.0691 * pixelGrid * pixelW;
					h = 5.038 * pixelGrid * pixelH;
					text = "Fermer";
					action = "['static', ['btnAction_btnClose', nil]] call oo_ctrlCreateDialog;";
				};
			};
		};
	};
	class controls {};
};



/*
["ctrlCreateDialog",9000,[[[["65.8408 * pixelGrid * pixelW","32.747 * pixelGrid * pixelH","79.009 * pixelGrid * pixelW","60.456 * pixelGrid * pixelH"],"#(rgb,8,8,3)color(0.2,0.2,0.2,1)","","","OOP_Picture",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["65.8408 * pixelGrid * pixelW","32.747 * pixelGrid * pixelH","79.009 * pixelGrid * pixelW","5.038 * pixelGrid * pixelH"],"Ajouter un control","title","","OOP_Text",true,[],[1,1,1,1],[0.1,0.7,0.1,0.9],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["68.4744 * pixelGrid * pixelW","40.304 * pixelGrid * pixelH","73.7417 * pixelGrid * pixelW","42.823 * pixelGrid * pixelH"],"","listControl","","OOP_Listbox",true,["Init","onLBDblClick","onLBSelChanged"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["113.246 * pixelGrid * pixelW","85.646 * pixelGrid * pixelH","21.0691 * pixelGrid * pixelW","5.038 * pixelGrid * pixelH"],"Valider","btnValider","","OOP_Button",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["76.3753 * pixelGrid * pixelW","85.646 * pixelGrid * pixelH","21.0691 * pixelGrid * pixelW","5.038 * pixelGrid * pixelH"],"Fermer","btnClose","","OOP_Button",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]]]]
*/
