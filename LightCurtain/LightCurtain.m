classdef LightCurtain < handle
    %LIGHTCURTAIN Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Plane_
        Plane_normal_
        LiHand
    end
    
    methods
        function self = LightCurtain(hand_pos,plane,plane_normal)
            
            self.Plane_ = plane;
            self.Plane_normal_ = plane_normal;
            self.LiHand = R_Object("LightCurtain\Hand",0,0,hand_pos,"Large");
            
        end
        
        function check = CheckIntersection(self)
            V(:,:) = get(self.LiHand.model,"Vertices");
   
            for i = 2:size(V,1)
                    %self.Light_Hand_.Vertices(i,:)
                    [~,check] = LinePlaneIntersection(self.Plane_normal_,self.Plane_, ...
                        (V(i,:)+self.LiHand.Position),(V(i-1,:))+self.LiHand.Position);
                    
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

