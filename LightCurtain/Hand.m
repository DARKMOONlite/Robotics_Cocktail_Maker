classdef Hand < handle
    %HAND Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        T_form; % 4x4 matrix of position
        Position; % position in x,y,z terms should only be used for reference
        model; % Storage for the ply file class
        Vertices %required to move object

    end
    
    methods
        function self = Hand(Position)
            hold on
            
            if size(Position,2) ~= 4 && size(Position,1) ~= 4
            error("Not enough values in Position")
            end


            


       
            self.T_form = transl(0,0,0);
            self.Position = [self.T_form(1,4),self.T_form(2,4), self.T_form(3,4)]


            hold on
            self.model = PlaceObject("LightCurtain/Hand.ply",self.Position);

            self.Vertices(:,:) = get(self.model,'Vertices')


              self.move_object(Position);
        end
        
        function move_object(self,T_mat)
               
            Verticies = [self.Vertices,ones(size(self.Vertices,1),1)]
            
                
                transformed_Vertices = [self.Vertices,ones(size(self.Vertices,1),1)]/self.T_form' *T_mat';
                set(self.model,'Vertices',transformed_Vertices(:,1:3))
                
                drawnow
                pause(0.01);
                self.T_form = T_mat;
                self.Position = [T_mat(1,4),T_mat(2,4),T_mat(3,4)];

        end
    end
end

