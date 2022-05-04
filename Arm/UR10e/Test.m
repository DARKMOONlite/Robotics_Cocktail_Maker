clc
clear
close

Axis_Control = gca;
Axis_Control.Clipping = "off";
set(Axis_Control,'CameraViewAngleMode','Manual');
set(0,'DefaultFigureWindowStyle','docked');

hold on

UR10e = UR10e();
%UR5 = UR5(false);

%%
pos = transl(0.2, 0.8, 0.5);

UR10e.animate(pos)