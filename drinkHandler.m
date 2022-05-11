%% Drink Handler

function drinkHandler(code)
    posDrinks = [0.8,0.7,0.4;     % Vodka
                 0.6,0.7,0.4;     % Rum
                 0.2,0.7,0.4;     % Tonic Water
                 -0.2,0.7,0.4;    % Shaker T
                 -0.6,0.7,0.4;    % Shaker B
                 -0.8,0.7,0.4;    % Gin
                 0.0,-0.95,0.0;   % Glass
                 -1.0,-0.5,0.02;  % Sugar trotz(90)
                 -1.0,-0.1,0.02;  % Lime
                 -1.0,0.3,0.02;]; % Ice
         
    codeArray = char(code);
    
    for i = 1:size(codeArray,2)
        action = codeArray(i);
        
        switch action
            case '0' % Serve Drink
                disp('Drink action 0')
                
            case '1' % Pour Tonic
                disp('Drink action 1')
                
            case '2' % Pour Gin
                disp('Drink action 2')
                
            case '3' % Pour Rum
                disp('Drink action 3')
                
            case '4' % Pour Vodka
                disp('Drink action 4')
                
            case '5' % Add Sugar
                disp('Drink action 5')
                
            case '6'% Add Lime
                disp('Drink action 6')
                
            case '7' % Add Ice
                disp('Drink action 7')
                
            case '8' % Shake
                disp('Drink action 8')
                
            case '9' % Pour Shaker
                disp('Drink action 9')

            case 'a' % Change pour location to Glass
                disp('Drink action a')

            case 'b' %Change pour location to Shaker
                disp('Drink action b')
                
            otherwise
                disp('Error: Unassigned action code')
        end
    end
end