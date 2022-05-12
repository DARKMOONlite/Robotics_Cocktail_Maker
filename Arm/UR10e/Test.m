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
Objects = Create_Drinks();

%%
u.moveBasicB((u.interJoints(1,:)),g)
%% glass 
u.moveBasicB(([281 60 250 230 270 0;]*pi/180), g)
%% idle
u.moveBasicB(([270 80 240 220 270 0;]*pi/180), g)
%% drink idle
u.moveBasicB(([90 140 240 160 270 0;]*pi/180), g)
%% vodka
u.moveBasicB(([57 140 240 160 270 0;]*pi/180), g)
u.moveBasicB(([57 82 256 202 272 0;]*pi/180), g)
u.moveBasicB(([57 140 240 160 270 0;]*pi/180), g)
%% rum
u.moveBasicB(([70 140 240 160 270 0;]*pi/180), g)
u.moveBasicB(([70 93 247 200 270 0;]*pi/180), g)
u.moveBasicB(([70 140 240 160 270 0;]*pi/180), g)
%% tonic water
u.moveBasicB(([88 140 240 160 270 0;]*pi/180), g)
u.moveBasicB(([88 104 240 196 270 0;]*pi/180), g)
u.moveBasicB(([88 140 240 160 270 0;]*pi/180), g)
%% gin
u.moveBasicB(([138 140 240 160 270 0;]*pi/180), g)
u.moveBasicB(([138 99 245 196 270 0;]*pi/180), g)
u.moveBasicB(([138 140 240 160 270 0;]*pi/180), g)
%% dispenser idle
u.moveBasicB(([180 140 240 160 270 0;]*pi/180), g)
u.moveBasicB(([208 80 240 220 298 0;]*pi/180), g)
%% ice
u.moveBasicB(([172 80 240 220 270 0;]*pi/180), g)
u.moveBasicB(([172 51 267 222 270 0;]*pi/180), g)
u.moveBasicB(([172 80 240 220 270 0;]*pi/180), g)
%% lime
u.moveBasicB(([208 80 240 220 298 0;]*pi/180), g)
u.moveBasicB(([200 53 264 222 290 0;]*pi/180), g)
u.moveBasicB(([208 80 240 220 298 0;]*pi/180), g)
%% sugar
u.moveBasicB(([217 80 240 220 270 0;]*pi/180), g)
u.moveBasicB(([223 42 278 220 310 0;]*pi/180), g)
u.moveBasicB(([217 80 240 220 270 0;]*pi/180), g)
%% TEST
u.moveBasicB(([223 42 278 220 310 0;]*pi/180), g)
%%
% x = g.grabObject(objects(1,7)) %4 needs trotz(pi/2)
% pos1 = x(:,:,2) * trotz(pi/2) %transl(objects(1,3).Position) * trotx(3*pi/2);
% %pos2 = transl(0.6, -0.4, 0.3) * trotx(3*pi/2) * troty(pi/2);  
% u.moveBasicA(pos1, g);
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
