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

hold on         

% for i=1:size(posDrinks,1)
%         x = transl(posDrinks(i,:));
%         trplot(x)1
% end
objects = Create_Drinks();

%% TEST
u.moveBasicB(u.idle(4,:), g)
%%
x = g.grabObject(objects(1,7)) %4 needs trotz(pi/2)
pos1 = x(:,:,1) * trotz(pi/2)
%pos2 = transl(0.6, -0.4, 0.3) * trotx(3*pi/2) * troty(pi/2);  
u.moveBasicA(pos1, g);
% %%
% y = g.grabObject(objects(1,4));
% pos2 = y(:,:,1) * trotz(pi/2)%* troty(2*pi);
% u.moveBasicA(pos2, g);
% %%
% pos3 = transl(0, 0.2, 0.5) * trotx(3*pi/2);
% u.moveBasicA(pos3, g);
% %%
% pos4 = transl(objects(1,1).Position) * trotx(3*pi/2);
% u.moveBasicA(pos4, g);
%%
u.pour(g, 1);

%%
u.makeDrink("1",g);
