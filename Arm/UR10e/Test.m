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
UR10e.model.base = transl(0,0,0);

posDrinks = [-1.35 0.4 1.7;
             -0.7 0.4 1.7;
             -0.25 0.4 1.7;
             0.2 0.4 1.7;
             0.7 0.4 1.7;
             1.35 0.4 1.7;];
%%
pos = transl(0.6, 0.8, 0.5)* trotx(3*pi/2);;
UR10e.moveBasic(pos)

%%
pos2 = transl(posDrinks(6,:)) * trotx(pi/2) * troty(2*pi/2);;
%pos2 = transl(0.6, -0.4, 0.3) * trotx(3*pi/2) * troty(pi/2);  
UR10e.moveBasic(pos2);

%%
UR10e.pour(1);

%%
