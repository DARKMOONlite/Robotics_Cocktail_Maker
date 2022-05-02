clear all
clc
clear figure

addpath(genpath('Gripper'))

try
     Test = Link('d',0.03705,'a',0.02151,'alpha',pi/2,'offset',0);
catch
    addpath(genpath('robot-9.10Small_Modified_20220202_WithVisionTB'))
    run('robot-9.10Small_Modified_20220202_WithVisionTB\robot-9.10Small_Modified\rvctools\startup_rvc.m')

end

Axis_Control = gca;
Axis_Control.Clipping = "off";
set(Axis_Control,'CameraViewAngleMode','Manual');
hold on
% robot = UR10

x = 0:pi/100:2*pi;



g = Gripper;

% g.move_gripper(T)

hold off
%matlab.graphics.primitive.Patch


%  g.encompassing_grip(0.077)



% Q = [0,0.5,0.5,0.5;0,0,0,0;0,0,0,0];
% g.animate(Q);
% Q = [0,0,0,0;0,0,0.5,0.5;0,0,0,0];
% g.animate(Q);
% Q = [0,0.5,0.5,0.5;0,0.5,0.5,0.5;0,0.5,0.5,0.5]
% g.animate(Q);
% Q = [0,0,0,0;0,0,0,0;0,0,0,0]
% g.animate(Q);
Q = [9*pi/180,0.38,0,-0.38;0,0.38,0,-0.38;-9*pi/180,0.38,0,-0.38]
g.animate(Q);
