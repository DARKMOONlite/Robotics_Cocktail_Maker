clear all
clc
clear figure
close
addpath(genpath('Gripper'))
addpath(genpath('Arm'))
addpath(genpath("Objects"))

try
     Test = Link('d',0.03705,'a',0.02151,'alpha',pi/2,'offset',0);
catch
    addpath(genpath('robot-9.10Small_Modified_20220202_WithVisionTB'))
    run('robot-9.10Small_Modified_20220202_WithVisionTB\robot-9.10Small_Modified\rvctools\startup_rvc.m')

end

Axis_Control = gca;
Axis_Control.Clipping = "off";
set(Axis_Control,'CameraViewAngleMode','Manual');
hold on
% robot = UR10
% 
% g = Gripper;
% 
% UR10e =  UR10e();
% Objects_(1) = R_Object("Gin",10,10,[0,0,1],"Large");
% T = transl(0,0,2)
% Objects_(1).move_object(T)

% g = Gripper;
% 
% g.move_gripper(T)
% drawnow
% hold off
%matlab.graphics.primitive.Patch


%  g.encompassing_grip(0.077)

      m=0;
      dx = 0.03;
      corner_points = zeros(8,3);
                for i =-1:2:1
                    for j = -1:2:1
                        for k = -1:2:1
                            m = m+1;
                            corner_points(m,:) = [k*(0.1/2+dx)+1, j*(0.1/2+dx)+1,i*(0.3+dx)+0];


                        end

                    end

                end








% Q = [0,0.5,0.5,0.5;0,0,0,0;0,0,0,0];
% g.animate(Q);
% Q = [0,0,0,0;0,0,0.5,0.5;0,0,0,0];
% g.animate(Q);
% Q = [0,0.5,0.5,0.5;0,0.5,0.5,0.5;0,0.5,0.5,0.5]
% g.animate(Q);
% Q = [0,0,0,0;0,0,0,0;0,0,0,0]
% g.animate(Q);
% Q = [9*pi/180,0.38,0,-0.38;0,0.38,0,-0.38;-9*pi/180,0.38,0,-0.38]
% g.animate(Q);
