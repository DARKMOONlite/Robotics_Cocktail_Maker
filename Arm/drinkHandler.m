%% Drink Handler

function drinkHandler(code)

    codeArray = char(code);
    
    for i = 1:size(codeArray,2)
        action = codeArray(i);
        
        switch action
            case '0' % Serve Drink
                disp('Drink action 0')
                
            case '1' % Pour Tonic
                disp('Drink action 1')
                u.moveBasicB(u.idle(4,:));
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