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
					x = 60.5735 * pixelGrid * pixelW;
					y = 32.747 * pixelGrid * pixelH;
					w = 65.8408 * pixelGrid * pixelW;
					h = 62.975 * pixelGrid * pixelH;
					text = "#(rgb,8,8,3)color(1,0,0,1)";
					onMouseButtonDown = "['static', ['onMouseButtonDown_life_RscPicture_2', _this]] call oo_NewDialog;";
				};
			};
		};
	};
	class controls {};
};
