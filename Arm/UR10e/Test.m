clc
clear
close

Axis_Control = gca;
Axis_Control.Clipping = "off";
set(Axis_Control,'CameraViewAngleMode','Manual');

hold on

UR10e = UR10e(0);

%%
pos = transl(0, 0, 1);

UR10e.animate(pos)