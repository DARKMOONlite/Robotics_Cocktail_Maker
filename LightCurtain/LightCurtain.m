classdef LightCurtain < handle
    %LIGHTCURTAIN Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Plane_;
        Plane_normal_;
        LiHand;
        Joy;
        check_dimensions;
    end
    
    methods
        function self = LightCurtain(hand_pos,plane,plane_normal,check_dimensions)
            self.check_dimensions = check_dimensions
            self.Plane_ = plane;
            self.Plane_normal_ = plane_normal;
            self.LiHand = R_Object("LightCurtain\Hand",0,0,hand_pos,"Large");
        
                self.Joy = vrjoystick(1);

       
        end
        
        function check = CheckIntersection(self)
            V(:,:) = get(self.LiHand.model,"Vertices");
            mtx = get(self.LiHand.h,"matrix");

            Pos = [mtx(1,4),mtx(2,4),mtx(3,4)];
            for i = 2:size(V,1)
                    %self.Light_Hand_.Vertices(i,:)
                    [point,check] = LinePlaneIntersection(self.Plane_normal_,self.Plane_, ...
                        (V(i,:)+Pos),(V(i-1,:))+Pos);
                    point;
                    

                    if check==1 || check==2
                        size(self.check_dimensions,1)
                       for j = 1:size(self.check_dimensions,1)
                           
                            if self.check_dimensions(j,1) ~= 0 || self.check_dimensions(j,2) ~= 0

                                if mtx(j,4) > self.check_dimensions(j,2) || mtx(j,4) < self.check_dimensions(j,1)
                                    check=0;
                                    break;
                                end

                            end

                       end

                    end

                    if check == 2 || check == 1
                        check = 1;
                        return
                    end
                   
                        
            end
            if check == 3
                check =0;
            end



        end

        function control_hand(self)
        [axes, buttons, povs] = read(self.Joy);
            dx = 0.1*axes(1);
            dy = -0.1*axes(2);
            mtx = get(self.LiHand.h,"matrix");
            mtx(1,4) =mtx(1,4)+ dx;
            mtx(2,4) =mtx(2,4)+ dy;
            
            pause(0.05);
                
            set(self.LiHand.h,'Matrix',mtx)
        end


        function Show_Plane(self)
            w = null(self.Plane_normal_);
            [P,Q] = meshgrid(-5:5);
            X = self.Plane_(1)+w(1,1)*P+w(1,2)*Q;
            Y = self.Plane_(2)+w(2,1)*P+w(2,2)*Q; %   using the two vectors in w
            Z = self.Plane_(3)+w(3,1)*P+w(3,2)*Q;
            surf(X,Y,Z);
        end
    end
end

