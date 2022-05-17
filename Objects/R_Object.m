classdef R_Object < handle
    %OBJECT Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        
        Object_Type; %Object type should be 
        Radius; % Used by gripper to determine correct finger angles
        Height; %Used by gripper to grip in correct position
    
        model; % Storage for the ply file class

        Corner_Points;
        h;
        Name;
    end
    
    methods
        function self = R_Object(PLY_File,Radius,Height,Position,Type)
            hold on
            
            if size(Position,2) ~= 4 && size(Position,1) ~= 4
            error("Not enough values in Position")
            end
            if strcmp(Type,"Large") && strcmp(Type,"Small")
                error("Type not declared correctly. Object must be large or small")
            end
            self.Object_Type = Type;
            self.Name = PLY_File;

            hold on
            self.model = PlaceObject(PLY_File+".ply",[0,0,0]);
            
            self.h = hgtransform('Parent',gca)
            set(self.model,'Parent',self.h)

         

            self.Radius = Radius;
            self.Height = Height;


            drawnow
            
              self.set_object(Position);
              self.Corner_Points = self.boundingbox();
        end
%%
        function move_object(self,T_mat)

            dist = self.Radius + 0.09208;
%             T_mat_quat = quaternion(T_mat);
%             angles = quat2angle(T_mat_quat)
%             
%             theta = T_mat %atan2(obj.T_form(1,4),obj.T_form(2,4));
%             x = T_mat(1,4)
%             y = T_mat(2,4)
%             z = T_mat(3,4)
%             
%             angle = trotz(90-rad2deg(theta),"deg");%trotz(theta);
%             dx = dist*sin(theta);
%             dy = dist*cos(theta);
%             dz = obj.Height/2; 
            x = T_mat*transl(0,-self.Height/2,dist) * trotx(-pi/2);
            
            set(self.h,'Matrix',x); 

        end
%%
        function set_object(self,T_mat) 
            set(self.h,'Matrix',T_mat); 
            
        end
%% Creates corners of a bounding box around an object. for object avoidance 
        function corner_points = boundingbox(self)
            m = 0;
            dx = 0.03;
            corner_points = zeros(8,3);
            for i =-1:2:1
                for j = -1:2:1
                    for k = -1:2:1
                        m = m+1;
                        corner_points(m,:) = [k*(self.Radius/2+dx)+self.h.Matrix(1,4), j*(self.Radius/2+dx)+self.h.Matrix(2,4),i*(self.Height+dx)+self.h.Matrix(3,4)];
                    end 
                end    
            end
        end
    end
end

