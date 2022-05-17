%function [  ] = collisionTest( )
clc
clear
close

Axis_Control = gca;
Axis_Control.Clipping = "off";
set(Axis_Control,'CameraViewAngleMode','Manual');
set(0,'DefaultFigureWindowStyle','docked');


hold on
%% Central location
base = transl(0,0,0);

%% UR10e
u = UR10e();
u.model.animate(u.currentJoints);

%% Gripper
g = Gripper();
g.move_gripper(u.model.fkine(u.currentJoints))

%% Environment
environment = Environment(base);
[PuttingSimulatedObjectsIntoTheEnvironment] = environment.build(base);
objects = Create_Drinks();

%% Collision Object
colOffset = 0.55;
colObjectLoc = [-0.5,-0.4,-0.2];

colObject = R_Object("Objects/Parts/Ice_Bucket",0.15,0.5,transl(colObjectLoc)*trotz(90,"deg"),"Large");

%%
% poseAvoid1 = [256 80 240 220 270 0]*pi/180;
% poseAvoid2 = 
% u.move(poseAvoid1, g);

%% Testing
poseAvoid1 = [252 110 250 180 278 0]*pi/180;
qMatrix = jtraj(u.currentJoints, u.idle(3,:), 30); %traj from current position to new position
  
    for i = 1:size(qMatrix, 1)
        u.model.animate(qMatrix(i,:));u
        u.currentJoints = (qMatrix(i,:));
        g.move_gripper(u.model.fkine(u.currentJoints));
        
        eeLoc = (u.model.fkine(u.currentJoints));
        distance = sqrt(sum((colObjectLoc - eeLoc(1:3,4)').^2));
        
        if distance <= colOffset
            disp('Collision immininent!');
            break
        else
            disp(['Object distance to end-effector = ', num2str(distance), 'm']);
        end
        
        drawnow();
    end

u.move(poseAvoid1, g);
u.move(u.idle(2,:), g);
u.move(u.idle(1,:), g);
u.move(u.drinkIdle(1,:), g);
u.move(u.drinks(1,:), g);
g.animate(u.gripAng1);
u.moveWithObj(u.drinkIdle(1,:), objects(1), g);
u.moveWithObj(u.idle(1,:), objects(1), g);
u.moveWithObj(u.idle(2,:), objects(1), g);
u.moveWithObj(poseAvoid1, objects(1), g);
u.moveWithObj(u.pourPos(1,:), objects(1), g);
u.pour(0.5, objects(1), g);
u.moveWithObj(poseAvoid1, objects(1), g);
u.moveWithObj(u.idle(2,:), objects(1), g);
u.moveWithObj(u.idle(1,:), objects(1), g);
u.moveWithObj(u.drinkIdle(1,:), objects(1), g);
u.moveWithObj(u.drinks(1,:), objects(1), g);
g.idle();
objects(1).set_object(transl(0.6,0.6,0.4));
u.move(u.drinkIdle(1,:), g);

