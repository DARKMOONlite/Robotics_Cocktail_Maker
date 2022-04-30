classdef Object
    %OBJECT Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        T_form;
        Object_Type;
        Diameter;
        Height;
        model;
    end
    
    methods
        function self = Object(PLY_file,Diameter,Height,Position,Type);
            if size(Position,1) ~= 3
            error("Not enough values in Position")
            end
            self.Position = Position
            self.T_form = transl(Position(1),Position(2),Position(3));

            self.model_obj(PLY_file);


            self.Diameter = Diameter;
            self.Height = Height;
            self.Object_Type = Type;
              
        end
        
        function model_obj(PLY_File)
                PlaceObject("Gripper_Objects/",PLY_File,".ply",self.Position);
                
        end
    end
end

