%% Robotics
% Lab 11 - Question 2 skeleton code
clc
clear all
%% setup joystick
id = 1; % Note: may need to be changed if multiple joysticks present
joy = vrjoystick(id);
caps(joy) % display joystick information


%% Set up robot
mdl_puma560;                    % Load Puma560
robot = p560;                   % Create copy called 'robot'
robot.tool = transl(0.1,0,0);   % Define tool frame on end-effector


%% Start "real-time" simulation
q = qn;                 % Set initial robot configuration 'q'

HF = figure(1);         % Initialise figure to display robot
robot.plot(q);          % Plot robot in initial configuration
robot.delay = 0.001;    % Set smaller delay when animating
set(HF,'Position',[0.1 0.1 0.8 0.8]);

duration = 30;  % Set duration of the simulation (seconds)
dt = 0.15;      % Set time step for simulation (seconds)

n = 0;  % Initialise step count to zero 
tic;    % recording simulation start time



while( toc < duration)
    
    n=n+1; % increment step count

    % read joystick
    [axes, buttons, povs] = read(joy);
       
    % -------------------------------------------------------------
    % YOUR CODE GOES HERE
    % 1 - turn joystick input into an end-effector velocity command
    % 2 - use J inverse to calculate joint velocity
    % 3 - apply joint velocity to step robot joint angles 
    % -------------------------------------------------------------
    dx = 0.3*axes(1)
    dy = 0.3*axes(2)
    dz = 0.3*buttons(1)

    dwx = 0.8*axes(4)
    dwy = 0.8*axes(5)
    dwz = 0.8*buttons(2)

    J = p560.jacob0(q);
    
      x_1 = [dx;dy;dz;dwx;dwy;dwz;];

    
     IJ = inv(J)
      dq = (inv(J)*x_1)*dt
      dq = transpose(dq)
         q(1,:) = q+dq

    % Update plot
    robot.animate(q);  
    
    % wait until loop time elapsed
    if (toc > dt*n)
        warning('Loop %i took too much time - consider increating dt',n);
    end
    while (toc < dt*n); % wait until loop time (dt) has elapsed 
    end
end
      
