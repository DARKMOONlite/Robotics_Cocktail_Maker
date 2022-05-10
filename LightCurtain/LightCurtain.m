classdef LightCurtain < handle
    %LIGHTCURTAIN Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Plane_
        Plane_normal_
        Light_Hand_
    end
    
    methods
        function self = LightCurtain(hand_pos,plane,plane_normal)
            
            self.Plane_ = plane;
            self.Plane_normal_ = plane_normal;
            self.Light_Hand_ = Hand(hand_pos);
            
        end
        
        function check = CheckIntersection(self)
            
   
            for i = 2:size(self.Light_Hand_.Vertices,1)
                    %self.Light_Hand_.Vertices(i,:)
                    [~,check] = LinePlaneIntersection(self.Plane_normal_,self.Plane_, ...
                        (self.Light_Hand_.Vertices(i,:)+self.Light_Hand_.Position),(self.Light_Hand_.Vertices(i-1,:))+self.Light_Hand_.Position);
                    
                    if check == 2 || check == 1
                        check = 1;
                        return
                    end
                   
                        
            end
            if check == 3
                check =0;
            end



        end
    end
end

