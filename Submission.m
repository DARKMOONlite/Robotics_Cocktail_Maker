clear all
clc
clear figure
close
addpath(genpath('Gripper'))
addpath(genpath('Arm'))
addpath(genpath("Objects"))
addpath(genpath("Assignment Documents"))
addpath(genpath("LightCurtain"))
addpath(genpath("GUI&Environment"))

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
UR10e.model.animate(UR10e.currentJoints);

%% Gripper

Gripper = Gripper();
Gripper.move_gripper(UR10e.model.fkine(UR10e.currentJoints))

%% Environment

% Environment class 
environment = Environment(base);

[PuttingSimulatedObjectsIntoTheEnvironment] = environment.build(base);

Objects = Create_Drinks();

%% Light curtains
pos = transl(0.5,-2,0.3) % Position of hand
L1 = LightCurtain(pos,[1.45,-1.2,0.3],[0,-1,0],[-1.45,1.45;0,0;0,0.3]);
% These are the positions of the light curtain positions. do not edit the values unless you KNOW they are wrong. 
% Just move this code elsewhere and use it as it.
% set(gcf, "Position",[100,100,900,900])

x = Gripper.grabObject(Objects(1));
% y= UR10e.model.ikine(x,UR10e.currentJoints);
% ikine
%  z = troty(-90,"deg")*transl(0.6,0.6,0.4) *trotx(-90,"deg")
 
% UR10e.move(y(1,:),Gripper)
% Seriallink
%  UR10e.model.plot(z2,'arrow','scale', 0.05)
%  Gripper.move_gripper(x(:,:,1)*troty(180,"deg")*trotx(-90,"deg"))
UR10e.move([57 140 240 160 270 0]*pi/180,Gripper);
% UR10e.model.teach
%   UR10e.model.plot([57 140 240 160 270 0]*pi/180,'arrow','scale', 0.05)
% % pause
%  z2 = UR10e.model.ikcon(x(:,:,1)*troty(180,"deg")*trotx(-90,"deg"));
%  UR10e.move(z2,Gripper);
%  UR10e.model.fkine(UR10e.currentJoints)
%   z2 = UR10e.model.ikcon(x(:,:,1)*troty(180,"deg")*trotx(-90,"deg"),UR10e.currentJoints);
%  UR10e.move(z2,Gripper);
% hold on;
% ikine
% for i = 1: size(Objects,2)
%     if Objects(i).Name == "Gin"
%         x = i;
%     end
% y = [138 140 240 160 270 0]*pi/180
% end
% x

%%
% UR10e.makeDrink("a56b34c", Objects, Gripper);

