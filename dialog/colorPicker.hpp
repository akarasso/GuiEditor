class NewDialog {
	idd = 1000;
	name= "NewDialog";
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
				class OOP_SubLayer_2_2 : OOP_SubLayer {
					idc = 2;
					x = 94.8108 * pixelGrid * pixelW;
					y = 40.304 * pixelGrid * pixelH;
					w = 7.90089 * pixelGrid * pixelW;
					h = 47.861 * pixelGrid * pixelH;
					onMouseMoving = "['static', ['onMouseMoving_OOP_SubLayer_2', _this]] call oo_NewDialog;";
					onButtonDown = "['static', ['onButtonDown_OOP_SubLayer_2', _this]] call oo_NewDialog;";
					class controls{
						class OOP_Picture_3_3: OOP_Picture {
							idc = 3;
							x = 0 * pixelGrid * pixelW;
							y = 0 * pixelGrid * pixelH;
							w = 7.9009 * pixelGrid * pixelW;
							h = 7.557 * pixelGrid * pixelH;
							text = "#(rgb,8,8,3)color(0,1,0,1)";
						};
						class OOP_Picture_4_4: OOP_Picture {
							idc = 4;
							x = 0 * pixelGrid * pixelW;
							y = 40.304 * pixelGrid * pixelH;
							w = 7.9009 * pixelGrid * pixelW;
							h = 7.557 * pixelGrid * pixelH;
							text = "#(rgb,8,8,3)color(1,0,0,1)";
						};
						class OOP_Picture_5_5: OOP_Picture {
							idc = 5;
							x = 0 * pixelGrid * pixelW;
							y = 7.557 * pixelGrid * pixelH;
							w = 7.9009 * pixelGrid * pixelW;
							h = 7.557 * pixelGrid * pixelH;
							text = "#(rgb,8,8,3)color(0,0,0,1)";
						};
						class OOP_Picture_6_6: OOP_Picture {
							idc = 6;
							x = 0 * pixelGrid * pixelW;
							y = 15.114 * pixelGrid * pixelH;
							w = 7.9009 * pixelGrid * pixelW;
							h = 25.19 * pixelGrid * pixelH;
							text = "#(rgb,8,8,3)color(1,1,1,1)";
						};
					};
				};
			};
		};
	};
	class controls {};
};



/*
["NewDialog",1000,[[[["94.8108 * pixelGrid * pixelW","40.304 * pixelGrid * pixelH","7.90089 * pixelGrid * pixelW","47.861 * pixelGrid * pixelH"],"","","","OOP_SubLayer",true,["onMouseMoving","onButtonDown"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]],[[[["0 * pixelGrid * pixelW","0 * pixelGrid * pixelH","7.9009 * pixelGrid * pixelW","7.557 * pixelGrid * pixelH"],"#(rgb,8,8,3)color(0,1,0,1)","","","OOP_Picture",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["0 * pixelGrid * pixelW","40.304 * pixelGrid * pixelH","7.9009 * pixelGrid * pixelW","7.557 * pixelGrid * pixelH"],"#(rgb,8,8,3)color(1,0,0,1)","","","OOP_Picture",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["0 * pixelGrid * pixelW","7.557 * pixelGrid * pixelH","7.9009 * pixelGrid * pixelW","7.557 * pixelGrid * pixelH"],"#(rgb,8,8,3)color(0,0,0,1)","","","OOP_Picture",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["0 * pixelGrid * pixelW","15.114 * pixelGrid * pixelH","7.9009 * pixelGrid * pixelW","25.19 * pixelGrid * pixelH"],"#(rgb,8,8,3)color(1,1,1,1)","","","OOP_Picture",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]]]]]]
*/
