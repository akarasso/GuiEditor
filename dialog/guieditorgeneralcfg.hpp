#define GUI_GRID_X	(0)
#define GUI_GRID_Y	(0)
#define GUI_GRID_W	(0.025)
#define GUI_GRID_H	(0.04)
#define GUI_GRID_WAbs	(1)
#define GUI_GRID_HAbs	(1)

class GuiEditorGeneralCfg {
	idd = 5001;
	name= "GuiEditorGeneralCfg";
	movingEnable = false;
	enableSimulation = true;

	class controlsBackground {
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by Alex, v1.063, #Nujuvu)
		////////////////////////////////////////////////////////
		
		
		
		class IGUIBack_2200: OOP_IGUIBack
		{
			idc = 2200;
			x = 5 * GUI_GRID_W + GUI_GRID_X;
			y = 4 * GUI_GRID_H + GUI_GRID_Y;
			w = 29 * GUI_GRID_W;
			h = 13 * GUI_GRID_H;
		};
		
		
		
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////
	};

	class controls{
		class RscText_1000: TopBar
		{
			idc = 1000;
			text = "Config general"; //--- ToDo: Localize;
			x = 5 * GUI_GRID_W + GUI_GRID_X;
			y = 4 * GUI_GRID_H + GUI_GRID_Y;
			w = 29 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class RscText_1001: OOP_Text
		{
			idc = 1001;
			text = "Name :"; //--- ToDo: Localize;
			x = 7 * GUI_GRID_W + GUI_GRID_X;
			y = 7 * GUI_GRID_H + GUI_GRID_Y;
			w = 4.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class RscEdit_1400: OOP_Edit
		{
			idc = 1400;
			x = 12 * GUI_GRID_W + GUI_GRID_X;
			y = 7 * GUI_GRID_H + GUI_GRID_Y;
			w = 20 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class RscText_1002: OOP_Text
		{
			idc = 1002;
			text = "Id :"; //--- ToDo: Localize;
			x = 7 * GUI_GRID_W + GUI_GRID_X;
			y = 9 * GUI_GRID_H + GUI_GRID_Y;
			w = 4.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class RscEdit_1401: OOP_Edit
		{
			idc = 1401;
			x = 12 * GUI_GRID_W + GUI_GRID_X;
			y = 9 * GUI_GRID_H + GUI_GRID_Y;
			w = 20 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class RscButton_1600: OOP_Button
		{
			idc = 1600;
			text = "Annuler"; //--- ToDo: Localize;
			x = 11.5 * GUI_GRID_W + GUI_GRID_X;
			y = 13 * GUI_GRID_H + GUI_GRID_Y;
			w = 5.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class RscButton_1601: OOP_Button
		{
			idc = 1601;
			text = "Valider"; //--- ToDo: Localize;
			x = 21 * GUI_GRID_W + GUI_GRID_X;
			y = 13 * GUI_GRID_H + GUI_GRID_Y;
			w = 7 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
	};
};