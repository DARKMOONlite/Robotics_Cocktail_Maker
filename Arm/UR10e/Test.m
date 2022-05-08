clc
clear
close

Axis_Control = gca;
Axis_Control.Clipping = "off";
set(Axis_Control,'CameraViewAngleMode','Manual');
set(0,'DefaultFigureWindowStyle','docked');

hold on
  
UR10e = UR10e();
%g = Gripper;
UR10e.model.base = transl(0,0,1) * trotz(pi);

posDrinks = [-1.35 0.4 1.7;
             -0.7 0.4 1.7;
             -0.25 0.4 1.7;
             0.2 0.4 1.7;
             0.7 0.4 1.7;
             1.35 0.4 1.7;];
         
safeJoints = [1.8352 1.2034 1.9025 6.2679 1.8369 3.1237;
              0.0589 1.6302 1.6794 4.5169 0.0038 4.7397;
              0 0 0 0 0 0;];

%%
pos = transl(0.6, 0.8, 0.5)* trotx(3*pi/2);;
UR10e.moveBasicA(pos)

%%
pos2 = transl(posDrinks(2,:)) * trotx(pi/2) * troty(2*pi/2) %* trotz(pi);;
%pos2 = transl(0.6, -0.4, 0.3) * trotx(3*pi/2) * troty(pi/2);  
UR10e.moveBasicA(pos2);

%%
UR10e.pour(1);

%%
