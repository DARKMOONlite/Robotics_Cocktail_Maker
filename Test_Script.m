clear all
clc
clear figure


Axis_Control = gca;
Axis_Control.Clipping = "off";
set(Axis_Control,'CameraViewAngleMode','Manual');
hold on


g = Gripper;
g.model.plot([0,0,0,0])
g.model.teach

%g.Finger(1);

hold off