clc
clear
close

Axis_Control = gca;
Axis_Control.Clipping = "off";
set(Axis_Control,'CameraViewAngleMode','Manual');
set(0,'DefaultFigureWindowStyle','docked');


hold on
  

u = UR10e();
g = Gripper();
u.model.base = transl(0,0,0); %* trotz(pi);
u.model.animate(u.currentJoints);
g.move_gripper(u.model.fkine(u.currentJoints));
g.idle();

objects = Create_Drinks();

%% Drink Making Function

% 0 - Not used
% 1 =   Vodka
% 2 =   Rum
% 3 =   Tonic Water
% 4 =   Gin
% 5 =   Dispense Ice
% 6 =   Dispense Lime
% 7 =   Dispense Sugar
% 8 - Not used
% 9 - Not used
% 
% a =   Pick glass up - Needed before adding dispenser ingredients otherwise
%       things will teleport 
% b =   Return glass if last ingredient was from dispenser - Also needed if
%       need to add drinks to glass after adding dispenser ingredients
% c =   Return arm to idle if last igredient was drink

u.makeDrink("a56b34c", objects, g);

%% TEST
u.move(u.glass(1,:), g);

%%
u.moveWithObj(u.glass(1,:), objects(7), g);

%%
objects(7).set_object(transl(0,-0.95,0.0));

%%
u.moveWithObj(u.pourPos(1,:), objects(4), g);

%%
g.animate(u.gripAng2);
u.pour(0.3, objects(4), g);