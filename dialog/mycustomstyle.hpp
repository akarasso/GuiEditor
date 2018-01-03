#define ST_LEFT           0x00
#define ST_MULTI          0x10
#define GUI_GRID_CENTER_WAbs        ((safezoneW / safezoneH) min 1.2)
#define GUI_GRID_CENTER_HAbs        (GUI_GRID_CENTER_WAbs / 1.2)
#define GUI_GRID_CENTER_W        (GUI_GRID_CENTER_WAbs / 40)
#define GUI_GRID_CENTER_H        (GUI_GRID_CENTER_HAbs / 25)
#define GUI_GRID_CENTER_X        (safezoneX + (safezoneW - GUI_GRID_CENTER_WAbs)/2)
#define GUI_GRID_CENTER_Y        (safezoneY + (safezoneH - GUI_GRID_CENTER_HAbs)/2)


class life_RscPicture {
    shadow = 0;
    type = 0;
    style = 48;
    sizeEx = 0.023;
    font = "RobotoCondensed";
    text = "#(rgb,8,8,3)color(1,0,0,1)";
    colorBackground[] = {};
    colorText[] = {};
    x = 0;
    y = 0;
    w = 0.2;
    h = 0.15;
    tooltipColorText[] = {1,1,1,1};
    tooltipColorBox[] = {1,1,1,1};
    tooltipColorShade[] = {0,0,0,0.65};
};
