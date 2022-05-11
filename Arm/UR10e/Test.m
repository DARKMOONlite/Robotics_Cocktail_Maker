clc
clear
close

Axis_Control = gca;
Axis_Control.Clipping = "off";
set(Axis_Control,'CameraViewAngleMode','Manual');
set(0,'DefaultFigureWindowStyle','docked');

hold on
  
UR10e = UR10e();
g = Gripper();
UR10e.model.base = transl(0,0,0); %* trotz(pi);
UR10e.model.animate(UR10e.currentJoints);
g.move_gripper(UR10e.model.fkine(UR10e.currentJoints));

posDrinks = [0.8,0.7,0.4;   % Vodka
             0.6,0.7,0.4;   % Rum
             0.2,0.7,0.4;   % Tonic Water
             -0.2,0.7,0.4;  % Shaker T
             -0.6,0.7,0.4;  % Shaker B
             -0.8,0.7,0.4;  % Gin
             0,-0.95,0.0;   % Glass
             -1,-0.5,0.02;  % Sugar trotz(90)
             -1,-0.1,0.02;  % Lime
             -1,0.3,0.02;]; % Ice
         
safeJoints = [1.8352 1.2034 1.9025 6.2679 1.8369 3.1237;
              0.0589 1.6302 1.6794 4.5169 0.0038 4.7397;
              0 0 0 0 0 0;];

%%
pos = transl(0.6, 0.8, 0.5)* trotx(3*pi/2);;
UR10e.moveBasicA(pos)

%%
pos2 = transl(posDrinks(5,:)) * trotx(pi/2) * troty(2*pi/2) %* trotz(pi);;
%pos2 = transl(0.6, -0.4, 0.3) * trotx(3*pi/2) * troty(pi/2);  
UR10e.moveBasicA(pos2, g);

%%
UR10e.pour(1);

%%
drinkHandler("123a");
