classdef RogueObject <handle
    %ROGUEOBJECT Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Object
        Joy
        Plane_
        Plane_normal_
    end
    
    methods
        function self = RogueObject(Object)
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

        function control(self)
        [axes, buttons, povs] = read(self.Joy);
            dx = 0.1*axes(1);
            dy = -0.1*axes(2);
            mtx = get(self.Object.h,"matrix");
            mtx(1,4) =mtx(1,4)+ dx;
            mtx(2,4) =mtx(2,4)+ dy;
            
            pause(0.05);
                
            set(self.Object.h,'Matrix',mtx)
        end


        function Show_Plane(self,Index)
            w = null(self.Plane_normal_(Index,:));
            [P,Q] = meshgrid(-5:5);
            X = self.Plane_(1)+w(1,1)*P+w(1,2)*Q;
            Y = self.Plane_(2)+w(2,1)*P+w(2,2)*Q; %   using the two vectors in w
            Z = self.Plane_(3)+w(3,1)*P+w(3,2)*Q;
            surf(X,Y,Z);
        end
    end
end

