class displayConfig {
	idd = 9008;
	name= "displayConfig";
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
					x = 73.7417 * pixelGrid * pixelW;
					y = 47.861 * pixelGrid * pixelH;
					w = 63.2072 * pixelGrid * pixelW;
					h = 30.228 * pixelGrid * pixelH;
					text = "#(rgb,8,8,3)color(0.2,0.2,0.2,0.8)";
				};
				class OOP_Text_3_3: OOP_Text {
					idc = 3;
					x = 73.7417 * pixelGrid * pixelW;
					y = 47.861 * pixelGrid * pixelH;
					w = 63.2072 * pixelGrid * pixelW;
					h = 5.03801 * pixelGrid * pixelH;
					text = "Config";
					colorBackground[] = {0, 0.96, 0.17, 1};
				};
				class OOP_TextRight_5_5: OOP_TextRight {
					idc = 5;
					x = 79.6336 * pixelGrid * pixelW;
					y = 56.1675 * pixelGrid * pixelH;
					w = 13.1682 * pixelGrid * pixelW;
					h = 2.519 * pixelGrid * pixelH;
					text = "Name:";
				};
				class OOP_TextRight_6_6: OOP_TextRight {
					idc = 6;
					x = 79.8834 * pixelGrid * pixelW;
					y = 61.6635 * pixelGrid * pixelH;
					w = 13.1682 * pixelGrid * pixelW;
					h = 2.519 * pixelGrid * pixelH;
					text = "Display ID:";
				};
				class OOP_Edit_7_7: OOP_Edit {
					idc = 7;
					x = 94.8108 * pixelGrid * pixelW;
					y = 55.418 * pixelGrid * pixelH;
					w = 21.0691 * pixelGrid * pixelW;
					h = 3.7785 * pixelGrid * pixelH;
				};
				class OOP_Edit_8_8: OOP_Edit {
					idc = 8;
					x = 94.8108 * pixelGrid * pixelW;
					y = 60.456 * pixelGrid * pixelH;
					w = 21.0691 * pixelGrid * pixelW;
					h = 3.7785 * pixelGrid * pixelH;
				};
				class btnValider_9: OOP_Button {
					idc = 9;
					x = 115.88 * pixelGrid * pixelW;
					y = 68.013 * pixelGrid * pixelH;
					w = 10.5345 * pixelGrid * pixelW;
					h = 5.03799 * pixelGrid * pixelH;
					text = "OK";
					action = "['static', ['btnAction_btnValider', nil]] call oo_displayConfig;";
				};
				class btnClose_10: OOP_Button {
					idc = 10;
					x = 86.9099 * pixelGrid * pixelW;
					y = 68.013 * pixelGrid * pixelH;
					w = 10.5345 * pixelGrid * pixelW;
					h = 5.03799 * pixelGrid * pixelH;
					text = "Close";
					action = "['static', ['btnAction_btnClose', nil]] call oo_displayConfig;";
				};
			};
		};
	};
	class controls {};
};



/*
["DisplayConfig",1000,[[[["73.7417 * pixelGrid * pixelW","47.861 * pixelGrid * pixelH","63.2072 * pixelGrid * pixelW","30.228 * pixelGrid * pixelH"],"#(rgb,8,8,3)color(0.2,0.2,0.2,0.8)","","","OOP_Picture",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["73.7417 * pixelGrid * pixelW","47.861 * pixelGrid * pixelH","63.2072 * pixelGrid * pixelW","5.03801 * pixelGrid * pixelH"],"Config","","","OOP_Text",true,[],[-1,-1,-1,-1],[0,0.96,0.17,1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["79.6336 * pixelGrid * pixelW","56.1675 * pixelGrid * pixelH","13.1682 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"Name:","","","OOP_TextRight",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["79.8834 * pixelGrid * pixelW","61.6635 * pixelGrid * pixelH","13.1682 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH"],"Display ID:","","","OOP_TextRight",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["94.8108 * pixelGrid * pixelW","55.418 * pixelGrid * pixelH","21.0691 * pixelGrid * pixelW","3.7785 * pixelGrid * pixelH"],"","","","OOP_Edit",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["94.8108 * pixelGrid * pixelW","60.456 * pixelGrid * pixelH","21.0691 * pixelGrid * pixelW","3.7785 * pixelGrid * pixelH"],"","","","OOP_Edit",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["115.88 * pixelGrid * pixelW","68.013 * pixelGrid * pixelH","10.5345 * pixelGrid * pixelW","5.03799 * pixelGrid * pixelH"],"OK","btnValider","","OOP_Button",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["86.9099 * pixelGrid * pixelW","68.013 * pixelGrid * pixelH","10.5345 * pixelGrid * pixelW","5.03799 * pixelGrid * pixelH"],"Close","btnClose","","OOP_Button",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]]]]
*/
