%% Test for Joystick functionality
% run this script to test your joystick button/axis function
%
% To quit, press ctrl-C
%
%% setup joystick
id = 1; % NOTE: may need to change if multiple joysticks present

joy = vrjoystick(id);
joy_info = caps(joy); % print joystick information


fprintf('Your joystick has:\n');
fprintf(' - %i buttons\n',joy_info.Buttons);
fprintf(' - %i axes\n', joy_info.Axes);
pause(2);

%%
while(1)
    
    % Read joystick buttons
    [axes, buttons, povs] = read(joy);

    % Print buttons/axes info to command window
    str = sprintf('--------------\n');
    for i = 1:joy_info.Buttons
        str = [str sprintf('Button[%i]:%i\n',i,buttons(i))];
    end
    for i = 1:joy_info.Axes 
        str = [str sprintf('Axes[%i]:%1.3f\n',i,axes(i))]; 
    end
    str = [str sprintf('--------------\n')];
    fprintf('%s',str);
    pause(0.05);  
    
end
    
    
    
    