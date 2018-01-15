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
					x = 76.3754 * pixelGrid * pixelW;
					y = 40.304 * pixelGrid * pixelH;
					w = 44.7718 * pixelGrid * pixelW;
					h = 27.709 * pixelGrid * pixelH;
					class controls{
						class r_3: OOP_Picture {
							idc = 3;
							x = 2.63363 * pixelGrid * pixelW;
							y = 2.519 * pixelGrid * pixelH;
							w = 3.95045 * pixelGrid * pixelW;
							h = 15.114 * pixelGrid * pixelH;
							text = "#(rgb,8,8,3)color(1,1,1,1)";
						};
						class v_4: OOP_Picture {
							idc = 4;
							x = 7.9009 * pixelGrid * pixelW;
							y = 2.519 * pixelGrid * pixelH;
							w = 3.95045 * pixelGrid * pixelW;
							h = 15.114 * pixelGrid * pixelH;
							text = "#(rgb,8,8,3)color(1,1,1,1)";
						};
						class b_5: OOP_Picture {
							idc = 5;
							x = 13.1682 * pixelGrid * pixelW;
							y = 2.519 * pixelGrid * pixelH;
							w = 3.95045 * pixelGrid * pixelW;
							h = 15.114 * pixelGrid * pixelH;
							text = "#(rgb,8,8,3)color(1,1,1,1)";
						};
						class aplha_6: OOP_Picture {
							idc = 6;
							x = 18.4354 * pixelGrid * pixelW;
							y = 2.519 * pixelGrid * pixelH;
							w = 3.95045 * pixelGrid * pixelW;
							h = 15.114 * pixelGrid * pixelH;
							text = "#(rgb,8,8,3)color(1,1,1,1)";
						};
						class OOP_Listbox_7_7: OOP_Listbox {
							idc = 7;
							x = 23.7027 * pixelGrid * pixelW;
							y = 7.557 * pixelGrid * pixelH;
							w = 13.1682 * pixelGrid * pixelW;
							h = 10.076 * pixelGrid * pixelH;
						};
						class OOP_Edit_8_8: OOP_Edit {
							idc = 8;
							x = 2.63363 * pixelGrid * pixelW;
							y = 20.152 * pixelGrid * pixelH;
							w = 21.0691 * pixelGrid * pixelW;
							h = 5.038 * pixelGrid * pixelH;
						};
						class btnSave_9: OOP_Button {
							idc = 9;
							x = 23.7027 * pixelGrid * pixelW;
							y = 20.152 * pixelGrid * pixelH;
							w = 5.26727 * pixelGrid * pixelW;
							h = 5.038 * pixelGrid * pixelH;
							text = "SAve";
							action = "['static', ['btnAction_btnSave', nil]] call oo_NewDialog;";
						};
						class btnDelete_10: OOP_Button {
							idc = 10;
							x = 31.6036 * pixelGrid * pixelW;
							y = 20.152 * pixelGrid * pixelH;
							w = 5.26727 * pixelGrid * pixelW;
							h = 5.038 * pixelGrid * pixelH;
							text = "del";
							action = "['static', ['btnAction_btnDelete', nil]] call oo_NewDialog;";
						};
						class btnClose_11: OOP_Button {
							idc = 11;
							x = 36.8709 * pixelGrid * pixelW;
							y = 2.519 * pixelGrid * pixelH;
							w = 5.26727 * pixelGrid * pixelW;
							h = 5.038 * pixelGrid * pixelH;
							text = "del";
							action = "['static', ['btnAction_btnClose', nil]] call oo_NewDialog;";
						};
						class rendu_12: OOP_Picture {
							idc = 12;
							x = 23.7027 * pixelGrid * pixelW;
							y = 2.519 * pixelGrid * pixelH;
							w = 10.5345 * pixelGrid * pixelW;
							h = 5.038 * pixelGrid * pixelH;
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
["NewDialog",1000,[[[["76.3754 * pixelGrid * pixelW","40.304 * pixelGrid * pixelH","44.7718 * pixelGrid * pixelW","27.709 * pixelGrid * pixelH"],"","","","OOP_SubLayer",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]],[[[["2.63363 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH","3.95045 * pixelGrid * pixelW","15.114 * pixelGrid * pixelH"],"#(rgb,8,8,3)color(1,1,1,1)","r","","OOP_Picture",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["7.9009 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH","3.95045 * pixelGrid * pixelW","15.114 * pixelGrid * pixelH"],"#(rgb,8,8,3)color(1,1,1,1)","v","","OOP_Picture",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["13.1682 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH","3.95045 * pixelGrid * pixelW","15.114 * pixelGrid * pixelH"],"#(rgb,8,8,3)color(1,1,1,1)","b","","OOP_Picture",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["18.4354 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH","3.95045 * pixelGrid * pixelW","15.114 * pixelGrid * pixelH"],"#(rgb,8,8,3)color(1,1,1,1)","aplha","","OOP_Picture",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["23.7027 * pixelGrid * pixelW","7.557 * pixelGrid * pixelH","13.1682 * pixelGrid * pixelW","10.076 * pixelGrid * pixelH"],"","","","OOP_Listbox",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["2.63363 * pixelGrid * pixelW","20.152 * pixelGrid * pixelH","21.0691 * pixelGrid * pixelW","5.038 * pixelGrid * pixelH"],"","","","OOP_Edit",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["23.7027 * pixelGrid * pixelW","20.152 * pixelGrid * pixelH","5.26727 * pixelGrid * pixelW","5.038 * pixelGrid * pixelH"],"SAve","btnSave","","OOP_Button",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["31.6036 * pixelGrid * pixelW","20.152 * pixelGrid * pixelH","5.26727 * pixelGrid * pixelW","5.038 * pixelGrid * pixelH"],"del","btnDelete","","OOP_Button",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["36.8709 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH","5.26727 * pixelGrid * pixelW","5.038 * pixelGrid * pixelH"],"del","btnClose","","OOP_Button",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]],[[["23.7027 * pixelGrid * pixelW","2.519 * pixelGrid * pixelH","10.5345 * pixelGrid * pixelW","5.038 * pixelGrid * pixelH"],"#(rgb,8,8,3)color(1,1,1,1)","rendu","","OOP_Picture",true,[],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1]]]]]]]
*/
