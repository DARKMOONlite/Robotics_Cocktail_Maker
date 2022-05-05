clc
clear
close

Axis_Control = gca;
Axis_Control.Clipping = "off";
set(Axis_Control,'CameraViewAngleMode','Manual');
set(0,'DefaultFigureWindowStyle','docked');

hold on

UR10e = UR10e();
%g = Gripper;

%%
pos = transl(0.6, 0.8, 0.5)* trotx(3*pi/2);;
UR10e.moveBasic(pos)

%%
%pos2 = transl(0.6, -0.4, 0.3) * trotx(3*pi/2) * troty(pi/2) * trotz(pi);;
pos2 = transl(0.6, -0.4, 0.3) * trotx(3*pi/2) * troty(pi/2);
UR10e.moveBasic(pos2);

%%
UR10e.pour(1);

%%
