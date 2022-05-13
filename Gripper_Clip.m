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


Gripper = Gripper();

campos([1,2,0.5])
set(gcf, "Position",[100,100,900,900])

b = [0,0,0,0;
    0,0,0,0;
    0,0,0,0;]

Gripper.animate(b);
pause
dq = Gripper.encompassing_grip(0.03);
q = [dq;dq;dq];
Gripper.animate(q);
Gripper.animate(b);
q = [dq*0.6;b(2,:);b(3,:)];
Gripper.animate(q);

q = [b(1,:);dq*0.6;b(3,:)];
Gripper.animate(q);
q = [b(1,:);b(2,:);dq*(0.6)];
Gripper.animate(q);
q = [dq;dq;dq];
Gripper.animate(q);
q = [dq;dq; dq];
q(:,2) = -q(:,2)
q(:,3:4) = 0.4*q(:,3:4)
Gripper.animate(q);
q(:,2) = -q(:,2)
Gripper.animate(q);

Gripper.animate(b)
db = b
db(1,1) = 0.15
db(3,1) = -0.15
Gripper.animate(db)
db(1,1) = -0.15
db(3,1) = 0.15
Gripper.animate(db)
Gripper.animate(b)