%% Drink Handler
function drinkHandler(code)
    codeArray = char(code);
    
    for i = 1:size(codeArray,2)
        action = codeArray(i);
        
        switch action
            case '0'
                disp('Drink action 0')
            case '1'
                disp('Drink action 1')
            case '2'
                disp('Drink action 2')
            case '3'
                disp('Drink action 3')
            case '4'
                disp('Drink action 4')
            case '5'
                disp('Drink action 5')
            case '6'
                disp('Drink action 6')
            case '7'
                disp('Drink action 7')
            case '8'
                disp('Drink action 8')
            case '9'
                disp('Drink action 9')
            otherwise
                disp('Error: Unassigned action code')
        end
    end
end