class NewDialog {
	idd = 1000;
	name= "NewDialog";
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
				class OOP_Picture_2: OOP_Picture {
					idc = 2;
					x = 39.5045 * pixelGrid * pixelW;
					y = 32.747 * pixelGrid * pixelH;
					w = 21.0691 * pixelGrid * pixelW;
					h = 50.38 * pixelGrid * pixelH;
					text = "#(rgb,8,8,3)color(1,1,1,1)";
				};
				class Layer_3 : OOP_SubLayer {
					idc = 3;
					x = 60.5735 * pixelGrid * pixelW;
					y = 32.747 * pixelGrid * pixelH;
					w = 60.5736 * pixelGrid * pixelW;
					h = 50.38 * pixelGrid * pixelH;
					class controls{
						class OOP_Button_4: OOP_Button {
							idc = 4;
							x = 2.63363 * pixelGrid * pixelW;
							y = 0 * pixelGrid * pixelH;
							w = 21.0691 * pixelGrid * pixelW;
							h = 12.595 * pixelGrid * pixelH;
							text = "Button..";
							action = "['static', ['btnAction_OOP_Button_4', nil]] call oo_NewDialog;";
						};
						class OOP_Button_5: OOP_Button {
							idc = 5;
							x = 26.3363 * pixelGrid * pixelW;
							y = 0 * pixelGrid * pixelH;
							w = 21.0691 * pixelGrid * pixelW;
							h = 12.595 * pixelGrid * pixelH;
							text = "Button..";
							action = "['static', ['btnAction_OOP_Button_5', nil]] call oo_NewDialog;";
						};
						class OOP_Button_6: OOP_Button {
							idc = 6;
							x = 15.8018 * pixelGrid * pixelW;
							y = 15.114 * pixelGrid * pixelH;
							w = 21.0691 * pixelGrid * pixelW;
							h = 12.595 * pixelGrid * pixelH;
							text = "Button..";
							action = "['static', ['btnAction_OOP_Button_6', nil]] call oo_NewDialog;";
						};
					};
				};
			};
		};
	};
	class controls {};
};



/*
["NewDialog",1000,[[[["39.5045 * pixelGrid * pixelW","32.747 * pixelGrid * pixelH","21.0691 * pixelGrid * pixelW","50.38 * pixelGrid * pixelH"],"#(rgb,8,8,3)color(1,1,1,1)","","","OOP_Picture",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["60.5735 * pixelGrid * pixelW","32.747 * pixelGrid * pixelH","60.5736 * pixelGrid * pixelW","50.38 * pixelGrid * pixelH"],"","","","OOP_SubLayer",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]],[[[["2.63363 * pixelGrid * pixelW","0 * pixelGrid * pixelH","21.0691 * pixelGrid * pixelW","12.595 * pixelGrid * pixelH"],"Button..","","","OOP_Button",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["26.3363 * pixelGrid * pixelW","0 * pixelGrid * pixelH","21.0691 * pixelGrid * pixelW","12.595 * pixelGrid * pixelH"],"Button..","","","OOP_Button",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["15.8018 * pixelGrid * pixelW","15.114 * pixelGrid * pixelH","21.0691 * pixelGrid * pixelW","12.595 * pixelGrid * pixelH"],"Button..","","","OOP_Button",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]]]]]]
*/
