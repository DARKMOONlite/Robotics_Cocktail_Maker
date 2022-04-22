clear all
clc
clear figure


Axis_Control = gca;
Axis_Control.Clipping = "off";
set(Axis_Control,'CameraViewAngleMode','Manual');
hold on
% robot = UR10

x = 0:pi/100:2*pi;



g = Gripper;


%g.Finger(1);

hold off
%matlab.graphics.primitive.Patch


 g.encompassing_grip(0.03)


