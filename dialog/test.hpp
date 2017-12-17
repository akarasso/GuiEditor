class Test {
	idd = 5000;
	name= "Test";
	movingEnable = false;
	enableSimulation = true;

	class controlsBackground
	{
		class IGUIBack_2200: IGUIBack
		{
			idc = 2200;
			x = 0 * GUI_GRID_W + GUI_GRID_X;
			y = 0 * GUI_GRID_H + GUI_GRID_Y;
			w = 20 * GUI_GRID_W;
			h = 23.5 * GUI_GRID_H;
			onMouseButtonClick="hint 'ij';";
		};
	};
	class controls
	{	
	};
};