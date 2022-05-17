classdef RogueObject
    %ROGUEOBJECT Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Object
        Joy
    end
    
    methods
        function self = RogueObject(Object,inputArg2)
            self.Object = Object
        end
        
        function outputArg = Move_Object(self)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            outputArg = obj.Property1 + inputArg;
        end
        function Connect_Joystick(self)
            self.Joy = vrjoystick(1);
        end

        function control_hand(self)
        [axes, buttons, povs] = read(self.Joy);
            dx = 0.1*axes(1);
            dy = -0.1*axes(2);
            mtx = get(self.Object.h,"matrix");
            mtx(1,4) =mtx(1,4)+ dx;
            mtx(2,4) =mtx(2,4)+ dy;
            
            pause(0.05);
                
            set(self.Object.h,'Matrix',mtx)
        end
    end
end

