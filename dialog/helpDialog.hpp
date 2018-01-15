class helpDialog {
	idd = 9009;
	name= "helpDialog";
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
					x = 39.5045 * pixelGrid * pixelW;
					y = 17.633 * pixelGrid * pixelH;
					w = 131.682 * pixelGrid * pixelW;
					h = 80.608 * pixelGrid * pixelH;
					text = "#(rgb,8,8,3)color(0.2,0.2,0.2,0.8)";
				};
				class OOP_Text_3_3: OOP_Text {
					idc = 3;
					x = 39.5045 * pixelGrid * pixelW;
					y = 17.633 * pixelGrid * pixelH;
					w = 131.682 * pixelGrid * pixelW;
					h = 5.038 * pixelGrid * pixelH;
					text = "Help";
					colorBackground[] = {0, 0.96, 0.17, 1};
				};
				class OOP_Picture_7_7: OOP_Picture {
					idc = 7;
					x = 104.687 * pixelGrid * pixelW;
					y = 22.671 * pixelGrid * pixelH;
					w = 1.31682 * pixelGrid * pixelW;
					h = 75.57 * pixelGrid * pixelH;
					text = "#(rgb,8,8,3)color(1,1,1,1)";
				};
				class OOP_Text_8_8: OOP_Text {
					idc = 8;
					x = 47.4054 * pixelGrid * pixelW;
					y = 30.228 * pixelGrid * pixelH;
					w = 21.0691 * pixelGrid * pixelW;
					h = 2.519 * pixelGrid * pixelH;
					text = "F1 => Show help";
				};
				class OOP_Text_9_9: OOP_Text {
					idc = 9;
					x = 47.4054 * pixelGrid * pixelW;
					y = 32.747 * pixelGrid * pixelH;
					w = 21.0691 * pixelGrid * pixelW;
					h = 2.519 * pixelGrid * pixelH;
					text = "F2 => Config display ";
				};
				class OOP_Text_10_10: OOP_Text {
					idc = 10;
					x = 47.4054 * pixelGrid * pixelW;
					y = 35.266 * pixelGrid * pixelH;
					w = 21.0691 * pixelGrid * pixelW;
					h = 2.519 * pixelGrid * pixelH;
					text = "F3 => Export as HPP";
				};
				class OOP_Text_11_11: OOP_Text {
					idc = 11;
					x = 47.4054 * pixelGrid * pixelW;
					y = 37.785 * pixelGrid * pixelH;
					w = 21.0691 * pixelGrid * pixelW;
					h = 2.519 * pixelGrid * pixelH;
					text = "F4 => Export as OOP";
				};
				class OOP_Text_12_12: OOP_Text {
					idc = 12;
					x = 47.4054 * pixelGrid * pixelW;
					y = 40.304 * pixelGrid * pixelH;
					w = 39.5045 * pixelGrid * pixelW;
					h = 2.519 * pixelGrid * pixelH;
					text = "F5 => Enable all control  (usefull to get real color)";
				};
				class OOP_Text_13_13: OOP_Text {
					idc = 13;
					x = 47.4054 * pixelGrid * pixelW;
					y = 45.342 * pixelGrid * pixelH;
					w = 39.5045 * pixelGrid * pixelW;
					h = 2.519 * pixelGrid * pixelH;
					text = "O => Open layer as fullscreen mod ";
				};
				class OOP_Text_14_14: OOP_Text {
					idc = 14;
					x = 47.4054 * pixelGrid * pixelW;
					y = 47.861 * pixelGrid * pixelH;
					w = 39.5045 * pixelGrid * pixelW;
					h = 2.519 * pixelGrid * pixelH;
					text = "I => Import your display from clipboard";
				};
				class OOP_Text_15_15: OOP_Text {
					idc = 15;
					x = 47.4054 * pixelGrid * pixelW;
					y = 50.38 * pixelGrid * pixelH;
					w = 39.5045 * pixelGrid * pixelW;
					h = 2.519 * pixelGrid * pixelH;
					text = "Space => Colorize all control in layer";
				};
				class OOP_Text_16_16: OOP_Text {
					idc = 16;
					x = 47.4054 * pixelGrid * pixelW;
					y = 52.899 * pixelGrid * pixelH;
					w = 39.5045 * pixelGrid * pixelW;
					h = 2.519 * pixelGrid * pixelH;
					text = "T => Show/Hide Tree dialog";
				};
				class OOP_Text_17_17: OOP_Text {
					idc = 17;
					x = 110.613 * pixelGrid * pixelW;
					y = 25.19 * pixelGrid * pixelH;
					w = 39.5045 * pixelGrid * pixelW;
					h = 2.519 * pixelGrid * pixelH;
					text = "Tree dialog";
					colorText[] = {0.92, 0.52, 0, 1};
					tooltipColorText[] = {0.92, 0.52, 0, 1};
				};
				class OOP_Text_18_18: OOP_Text {
					idc = 18;
					x = 44.7718 * pixelGrid * pixelW;
					y = 25.19 * pixelGrid * pixelH;
					w = 39.5045 * pixelGrid * pixelW;
					h = 2.519 * pixelGrid * pixelH;
					text = "In display";
					colorText[] = {0.92, 0.52, 0, 1};
					tooltipColorText[] = {0.92, 0.52, 0, 1};
				};
				class OOP_Text_19_19: OOP_Text {
					idc = 19;
					x = 113.246 * pixelGrid * pixelW;
					y = 30.228 * pixelGrid * pixelH;
					w = 39.5045 * pixelGrid * pixelW;
					h = 2.519 * pixelGrid * pixelH;
					text = "PageUp => Put control over other";
				};
				class OOP_Text_20_20: OOP_Text {
					idc = 20;
					x = 113.246 * pixelGrid * pixelW;
					y = 32.747 * pixelGrid * pixelH;
					w = 39.5045 * pixelGrid * pixelW;
					h = 2.519 * pixelGrid * pixelH;
					text = "PageDown => Put control under other";
				};
				class OOP_Text_21_21: OOP_Text {
					idc = 21;
					x = 113.246 * pixelGrid * pixelW;
					y = 40.304 * pixelGrid * pixelH;
					w = 39.5045 * pixelGrid * pixelW;
					h = 2.519 * pixelGrid * pixelH;
					text = "H => Show/Hide control";
				};
				class OOP_Text_22_22: OOP_Text {
					idc = 22;
					x = 47.4054 * pixelGrid * pixelW;
					y = 57.937 * pixelGrid * pixelH;
					w = 39.5045 * pixelGrid * pixelW;
					h = 2.519 * pixelGrid * pixelH;
					text = "H => Hide control";
				};
				class OOP_Text_23_23: OOP_Text {
					idc = 23;
					x = 47.4054 * pixelGrid * pixelW;
					y = 60.456 * pixelGrid * pixelH;
					w = 39.5045 * pixelGrid * pixelW;
					h = 2.519 * pixelGrid * pixelH;
					text = "Del. => Delete control";
				};
				class OOP_Text_24_24: OOP_Text {
					idc = 24;
					x = 113.246 * pixelGrid * pixelW;
					y = 42.823 * pixelGrid * pixelH;
					w = 39.5045 * pixelGrid * pixelW;
					h = 2.519 * pixelGrid * pixelH;
					text = "Del. => Delete control";
				};
				class OOP_Text_25_25: OOP_Text {
					idc = 25;
					x = 47.4054 * pixelGrid * pixelW;
					y = 65.494 * pixelGrid * pixelH;
					w = 39.5045 * pixelGrid * pixelW;
					h = 2.519 * pixelGrid * pixelH;
					text = "C => Center horizontally control";
				};
				class OOP_Text_26_26: OOP_Text {
					idc = 26;
					x = 47.4054 * pixelGrid * pixelW;
					y = 70.532 * pixelGrid * pixelH;
					w = 39.5045 * pixelGrid * pixelW;
					h = 2.519 * pixelGrid * pixelH;
					text = "Ctrl + C => Copy";
				};
				class OOP_Text_27_27: OOP_Text {
					idc = 27;
					x = 47.4054 * pixelGrid * pixelW;
					y = 73.051 * pixelGrid * pixelH;
					w = 39.5045 * pixelGrid * pixelW;
					h = 2.519 * pixelGrid * pixelH;
					text = "Ctrl + V => Paste";
				};
				class OOP_Text_28_28: OOP_Text {
					idc = 28;
					x = 47.4054 * pixelGrid * pixelW;
					y = 68.013 * pixelGrid * pixelH;
					w = 39.5045 * pixelGrid * pixelW;
					h = 2.519 * pixelGrid * pixelH;
					text = "V => Center vertically control";
				};
				class OOP_Text_29_29: OOP_Text {
					idc = 29;
					x = 47.4054 * pixelGrid * pixelW;
					y = 78.089 * pixelGrid * pixelH;
					w = 39.5045 * pixelGrid * pixelW;
					h = 2.519 * pixelGrid * pixelH;
					text = "Arrow => move control";
				};
				class OOP_Text_30_30: OOP_Text {
					idc = 30;
					x = 47.4054 * pixelGrid * pixelW;
					y = 80.608 * pixelGrid * pixelH;
					w = 39.5045 * pixelGrid * pixelW;
					h = 2.519 * pixelGrid * pixelH;
					text = "Arrow + alt => resize control";
				};
				class OOP_Text_31_31: OOP_Text {
					idc = 31;
					x = 47.4054 * pixelGrid * pixelW;
					y = 85.646 * pixelGrid * pixelH;
					w = 39.5045 * pixelGrid * pixelW;
					h = 2.519 * pixelGrid * pixelH;
					text = "Right click => Control create/Control config";
				};
				class OOP_Text_32_32: OOP_Text {
					idc = 32;
					x = 47.4054 * pixelGrid * pixelW;
					y = 88.165 * pixelGrid * pixelH;
					w = 39.5045 * pixelGrid * pixelW;
					h = 2.519 * pixelGrid * pixelH;
					text = "Left click => select control";
				};
				class OOP_Text_33_33: OOP_Text {
					idc = 33;
					x = 113.246 * pixelGrid * pixelW;
					y = 47.861 * pixelGrid * pixelH;
					w = 39.5045 * pixelGrid * pixelW;
					h = 2.519 * pixelGrid * pixelH;
					text = "DblClick => Show config";
				};
				class OOP_Text_34_34: OOP_Text {
					idc = 34;
					x = 110.613 * pixelGrid * pixelW;
					y = 52.899 * pixelGrid * pixelH;
					w = 39.5045 * pixelGrid * pixelW;
					h = 2.519 * pixelGrid * pixelH;
					text = "Tips";
					colorText[] = {0.92, 0.52, 0, 1};
					tooltipColorText[] = {0.92, 0.52, 0, 1};
				};
				class OOP_Text_35_35: OOP_Text {
					idc = 35;
					x = 113.246 * pixelGrid * pixelW;
					y = 57.937 * pixelGrid * pixelH;
					w = 52.6727 * pixelGrid * pixelW;
					h = 2.519 * pixelGrid * pixelH;
					text = "Give name to control create variable in oop class to use them";
				};
				class OOP_Text_36_36: OOP_Text {
					idc = 36;
					x = 113.246 * pixelGrid * pixelW;
					y = 60.456 * pixelGrid * pixelH;
					w = 55.3063 * pixelGrid * pixelW;
					h = 2.519 * pixelGrid * pixelH;
					text = "Ex: give 'title' to RscText will create you MEMBER('control','title')";
				};
				class OOP_Text_37_37: OOP_Text {
					idc = 37;
					x = 113.246 * pixelGrid * pixelW;
					y = 62.975 * pixelGrid * pixelH;
					w = 50.039 * pixelGrid * pixelW;
					h = 2.519 * pixelGrid * pixelH;
					text = "Add event on control will also create to you a new variable";
				};
				class OOP_Text_38_38: OOP_Text {
					idc = 38;
					x = 113.246 * pixelGrid * pixelW;
					y = 65.494 * pixelGrid * pixelH;
					w = 50.039 * pixelGrid * pixelW;
					h = 2.519 * pixelGrid * pixelH;
					text = "If you don't give name. Name Variable will be generate";
				};
				class OOP_Text_39_39: OOP_Text {
					idc = 39;
					x = 113.246 * pixelGrid * pixelW;
					y = 68.013 * pixelGrid * pixelH;
					w = 50.039 * pixelGrid * pixelW;
					h = 2.519 * pixelGrid * pixelH;
					text = "And you won't do that if you wan't read your script later";
				};
				class OOP_Text_40_40: OOP_Text {
					idc = 40;
					x = 113.246 * pixelGrid * pixelW;
					y = 73.051 * pixelGrid * pixelH;
					w = 50.039 * pixelGrid * pixelW;
					h = 2.519 * pixelGrid * pixelH;
					text = "All event handler will call function as STATIC";
				};
				class OOP_Text_41_41: OOP_Text {
					idc = 41;
					x = 113.246 * pixelGrid * pixelW;
					y = 75.57 * pixelGrid * pixelH;
					w = 57.9399 * pixelGrid * pixelW;
					h = 2.519 * pixelGrid * pixelH;
					text = "Then you could only read/write static variable inside those function";
				};
				class OOP_Text_42_42: OOP_Text {
					idc = 42;
					x = 113.246 * pixelGrid * pixelW;
					y = 80.608 * pixelGrid * pixelH;
					w = 57.9399 * pixelGrid * pixelW;
					h = 2.519 * pixelGrid * pixelH;
					text = "You could export into your mission HelperGui";
				};
				class OOP_Text_43_43: OOP_Text {
					idc = 43;
					x = 113.246 * pixelGrid * pixelW;
					y = 83.127 * pixelGrid * pixelH;
					w = 57.9399 * pixelGrid * pixelW;
					h = 2.519 * pixelGrid * pixelH;
					text = "Which is class to manage easier your control";
				};
				class OOP_Text_44_44: OOP_Text {
					idc = 44;
					x = 113.246 * pixelGrid * pixelW;
					y = 85.646 * pixelGrid * pixelH;
					w = 57.9399 * pixelGrid * pixelW;
					h = 2.519 * pixelGrid * pixelH;
					text = "You could export SliderH, ColorPicker(which need sliderH)";
				};
				class OOP_Text_45_45: OOP_Text {
					idc = 45;
					x = 113.246 * pixelGrid * pixelW;
					y = 90.684 * pixelGrid * pixelH;
					w = 57.9399 * pixelGrid * pixelW;
					h = 2.519 * pixelGrid * pixelH;
					text = "THIS IS BETA VERSION";
					colorText[] = {1, 0, 0, 1};
					tooltipColorText[] = {1, 0, 0, 1};
				};
			};
		};
	};
	class controls {};
};



/*
["helpDialog",9009,[[[["39.5045 * pixelGrid * pixelW","17.633 * pixelGrid * pixelH","131.682 * pixelGrid * pixelW","80.608 * pixelGrid * pixelH"],"#(rgb,8,8,3)color(0.2,0.2,0.2,0.8)","","","OOP_Picture",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["39.5045 * pixelGrid * pixelW","17.633 * pixelGrid * pixelH","131.682 * pixelGrid * pixelW","5.038 * pixelGrid * pixelH"],"Help","","","OOP_Text",true,[],[-1,-1,-1,-1],[0,0.96,0.17,1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["104.687 * pixelGrid * pixelW","22.671 * pixelGrid * pixelH","1.31682 * pixelGrid * pixelW","75.57 * pixelGrid * pixelH"],"#(rgb,8,8,3)color(1,1,1,1)","","","OOP_Picture",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["47.4054 * pixelGrid * pixelW","30.228 * pixelGrid * pixelH","21.0691 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"F1 => Show help","","","OOP_Text",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["47.4054 * pixelGrid * pixelW","32.747 * pixelGrid * pixelH","21.0691 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"F2 => Config display ","","","OOP_Text",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["47.4054 * pixelGrid * pixelW","35.266 * pixelGrid * pixelH","21.0691 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"F3 => Export as HPP","","","OOP_Text",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["47.4054 * pixelGrid * pixelW","37.785 * pixelGrid * pixelH","21.0691 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"F4 => Export as OOP","","","OOP_Text",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["47.4054 * pixelGrid * pixelW","40.304 * pixelGrid * pixelH","39.5045 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"F5 => Enable all control  (usefull to get real color)","","","OOP_Text",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["47.4054 * pixelGrid * pixelW","45.342 * pixelGrid * pixelH","39.5045 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"O => Open layer as fullscreen mod ","","","OOP_Text",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["47.4054 * pixelGrid * pixelW","47.861 * pixelGrid * pixelH","39.5045 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"I => Import your display from clipboard","","","OOP_Text",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["47.4054 * pixelGrid * pixelW","50.38 * pixelGrid * pixelH","39.5045 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"Space => Colorize all control in layer","","","OOP_Text",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["47.4054 * pixelGrid * pixelW","52.899 * pixelGrid * pixelH","39.5045 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"T => Show/Hide Tree dialog","","","OOP_Text",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["110.613 * pixelGrid * pixelW","25.19 * pixelGrid * pixelH","39.5045 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"Tree dialog","","","OOP_Text",true,[],[0.92,0.52,0,1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["44.7718 * pixelGrid * pixelW","25.19 * pixelGrid * pixelH","39.5045 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"In display","","","OOP_Text",true,[],[0.92,0.52,0,1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["113.246 * pixelGrid * pixelW","30.228 * pixelGrid * pixelH","39.5045 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"PageUp => Put control over other","","","OOP_Text",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["113.246 * pixelGrid * pixelW","32.747 * pixelGrid * pixelH","39.5045 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"PageDown => Put control under other","","","OOP_Text",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["113.246 * pixelGrid * pixelW","40.304 * pixelGrid * pixelH","39.5045 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"H => Show/Hide control","","","OOP_Text",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["47.4054 * pixelGrid * pixelW","57.937 * pixelGrid * pixelH","39.5045 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"H => Hide control","","","OOP_Text",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["47.4054 * pixelGrid * pixelW","60.456 * pixelGrid * pixelH","39.5045 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"Del. => Delete control","","","OOP_Text",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["113.246 * pixelGrid * pixelW","42.823 * pixelGrid * pixelH","39.5045 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"Del. => Delete control","","","OOP_Text",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["47.4054 * pixelGrid * pixelW","65.494 * pixelGrid * pixelH","39.5045 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"C => Center horizontally control","","","OOP_Text",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["47.4054 * pixelGrid * pixelW","70.532 * pixelGrid * pixelH","39.5045 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"Ctrl + C => Copy","","","OOP_Text",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["47.4054 * pixelGrid * pixelW","73.051 * pixelGrid * pixelH","39.5045 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"Ctrl + V => Paste","","","OOP_Text",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["47.4054 * pixelGrid * pixelW","68.013 * pixelGrid * pixelH","39.5045 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"V => Center vertically control","","","OOP_Text",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["47.4054 * pixelGrid * pixelW","78.089 * pixelGrid * pixelH","39.5045 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"Arrow => move control","","","OOP_Text",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["47.4054 * pixelGrid * pixelW","80.608 * pixelGrid * pixelH","39.5045 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"Arrow + alt => resize control","","","OOP_Text",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["47.4054 * pixelGrid * pixelW","85.646 * pixelGrid * pixelH","39.5045 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"Right click => Control create/Control config","","","OOP_Text",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["47.4054 * pixelGrid * pixelW","88.165 * pixelGrid * pixelH","39.5045 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"Left click => select control","","","OOP_Text",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["113.246 * pixelGrid * pixelW","47.861 * pixelGrid * pixelH","39.5045 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"DblClick => Show config","","","OOP_Text",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["110.613 * pixelGrid * pixelW","52.899 * pixelGrid * pixelH","39.5045 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"Tips","","","OOP_Text",true,[],[0.92,0.52,0,1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["113.246 * pixelGrid * pixelW","57.937 * pixelGrid * pixelH","52.6727 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"Give name to control create variable in oop class to use them","","","OOP_Text",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["113.246 * pixelGrid * pixelW","60.456 * pixelGrid * pixelH","55.3063 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"Ex: give ""title"" to RscText will create you MEMBER(""control"",""title"")","","","OOP_Text",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["113.246 * pixelGrid * pixelW","62.975 * pixelGrid * pixelH","50.039 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"Add event on control will also create to you a new variable","","","OOP_Text",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["113.246 * pixelGrid * pixelW","65.494 * pixelGrid * pixelH","50.039 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"If you don't give name. Name Variable will be generate","","","OOP_Text",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["113.246 * pixelGrid * pixelW","68.013 * pixelGrid * pixelH","50.039 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"And you won't do that if you wan't read your script later","","","OOP_Text",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["113.246 * pixelGrid * pixelW","73.051 * pixelGrid * pixelH","50.039 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"All event handler will call function as STATIC","","","OOP_Text",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["113.246 * pixelGrid * pixelW","75.57 * pixelGrid * pixelH","57.9399 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"Then you could only read/write static variable inside those function","","","OOP_Text",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["113.246 * pixelGrid * pixelW","80.608 * pixelGrid * pixelH","57.9399 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"You could export into your mission HelperGui","","","OOP_Text",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["113.246 * pixelGrid * pixelW","83.127 * pixelGrid * pixelH","57.9399 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"Which is class to manage easier your control","","","OOP_Text",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["113.246 * pixelGrid * pixelW","85.646 * pixelGrid * pixelH","57.9399 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"You could export SliderH, ColorPicker(which need sliderH)","","","OOP_Text",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["113.246 * pixelGrid * pixelW","90.684 * pixelGrid * pixelH","57.9399 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"THIS IS BETA VERSION","","","OOP_Text",true,[],[1,0,0,1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]]]]
*/
