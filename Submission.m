clear all
clc
clear figure
close
addpath(genpath('Gripper'))
addpath(genpath('Arm'))
addpath(genpath("Objects"))
addpath(genpath("Assignment Documents"))

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
% Gin = R_Object("Vodka",1,1,[0,0,1.9],"Large");
% Transform = transl(-1.35,0.4,1.7)
% % Transform = transl(-0.7,0.4,1.7)
% % Transform = transl(-0.25,0.4,1.7)
% % Transform = transl(0.2,0.4,1.7)
% % Transform = transl(0.7,0.4,1.7)
% % Transform = transl(1.35,0.4,1.7)
% Gin.move_object(Transform)
% Environment class 
environment = Environment();

 
[PuttingSimulatedObjectsIntoTheEnvironment] = environment.build(base);



hold on;


