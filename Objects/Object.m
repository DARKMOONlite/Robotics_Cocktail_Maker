classdef Object
    %OBJECT Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        T_form; % 4x4 matrix of position
        Object_Type; %Object type should be 
        Diameter; % Used by gripper to determine correct finger angles
        Height; %Used by gripper to grip in correct position
        Position; % position in x,y,z terms should only be used for reference
        model; % Storage for the ply file class
        Vertices %required to move object
    end
    
    methods
        function self = Object(PLY_file,Radius,Height,Position,Type);
            if size(Position,1) ~= 3
            error("Not enough values in Position")
            end
            if strcmp(Type,"Large") && strcmp(Type,"Small")
                error("Type not declared correctly. Object must be large or small")
            end
            self.Object_Type = Type;



            self.Position = Position
            self.T_form = transl(Position(1),Position(2),Position(3));


            
            self.model_obj(PLY_file);
            self.Vertices(:,:) = get(self.model,'Vertices')

            self.Diameter = Radius;
            self.Height = Height;
            
              
        end
        
        function model_obj(self,PLY_File)
                self.model = PlaceObject("Gripper_Objects/Parts/",PLY_File,".ply",self.Position);
                
        end

        function move_object(self,T_mat)
               
                
                transformed_Vertices = [Bricks.Vertices,ones(size(self.Vertices,1),1)]/self.T_form' *T_mat';
                set(self.Vertices,'Vertices',transformed_Vertices(:,1:3))
                
                drawnow
                pause(0.01);

        end
    end
end

