clc;
clf;
clear all;

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
%% Environment class 
environment = Environment(base);

 
[PuttingSimulatedObjectsIntoTheEnvironment] = environment.build(base);



hold on;


