classdef R_Object
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
        function self = R_Object(PLY_File,Radius,Height,Position,Type);
            Position
            if size(Position,2) ~= 3
            error("Not enough values in Position")
            end
            if strcmp(Type,"Large") && strcmp(Type,"Small")
                error("Type not declared correctly. Object must be large or small")
            end
            self.Object_Type = Type;



            self.Position = Position
            self.T_form = transl(Position(1),Position(2),Position(3));


            hold on
            self.model = PlaceObject("Objects/Parts/"+PLY_File+".ply",self.Position);

            self.Vertices(:,:) = get(self.model,'Vertices')

            self.Diameter = Radius;
            self.Height = Height;
            
              
        end

        function move_object(self,T_mat)
               
                
                transformed_Vertices = [self.Vertices,ones(size(self.Vertices,1),1)]/self.T_form' *T_mat';
                set(self.model,'Vertices',transformed_Vertices(:,1:3))
                
                drawnow
                pause(0.01);

        end


%% Creates corners of a bounding box around an object. for object avoidance 
        function corner_points = boundingbox(self)
                m=0;
                dx = 0.03;
            corner_points = zeros(8,3);
                for i =-1:2:1
                    for j = -1:2:1
                        for k = -1:2:1
                            m = m+1;
                            corner_points(m,:) = [k*(self.Diameter/2+dx)+self.T_form(1,4), j*(self.Diameter/2+dx)+self.T_form(2,4),i*(self.Height+dx)+self.T_form(3,4)];


                        end

                    end

                end

            





        
    end
end

