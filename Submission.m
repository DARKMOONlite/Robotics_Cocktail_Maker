clear all
clc
clear figure
close
addpath(genpath('Gripper'))
addpath(genpath('Arm'))
addpath(genpath("Objects"))
addpath(genpath("Assignment Documents"))
addpath(genpath("LightCurtain"))

Axis_Control = gca;
Axis_Control.Clipping = "off";
set(Axis_Control,'CameraViewAngleMode','Manual');
hold on


try
     Test = Link('d',0.03705,'a',0.02151,'alpha',pi/2,'offset',0);
catch
    addpath(genpath('robot-9.10Small_Modified_20220202_WithVisionTB'))
    run('robot-9.10Small_Modified_20220202_WithVisionTB\robot-9.10Small_Modified\rvctools\startup_rvc.m')

end

%% Central location
base = transl(0,0,0);
%% UR10e

UR10e = UR10e();
%UR10e.PlotAndColourRobot()


 

%% drink object





Environment class 
environment = Environment(base);

 
[PuttingSimulatedObjectsIntoTheEnvironment] = environment.build(base);
% 
Gripper = Gripper();
Gripper.move_gripper(UR10e.model.fkine(UR10e.currentJoints))
Objects = Create_Drinks();



%% these are the positions of the light curtain positions. do not edit the values unless you KNOW they are wrong. 
%Just move this code elsewhere and use it as it.
pos = transl(0.5,-2,0.3) % Position of hand
L1 = LightCurtain(pos,[1.45,-1.2,0.3],[-1,0,0]);
L1.CheckIntersection % Check intersection will return 1 if hand touches light curtain. otherwise 0;
pos2 = transl(2,0,0.3)*trotz(90,"deg");
L2 = LightCurtain(pos2,[1.45,0.4,0.3],[0,-1,0]);
L2.CheckIntersection;
% 
% 
% hold on;

for i = 1: size(Objects,2)
    if Objects(i).Name == "Gin"
        x = i;
    end

end
x
