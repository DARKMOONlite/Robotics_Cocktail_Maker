classdef UR10e < handle
    properties
        %> Robot model
        model;
        
        %> workspace
        workspace = [0 0 0 0 0 0];   
               
%         %> If we have a tool model which will replace the final links model, combined ply file of the tool model and the final link models
%         toolModelFilename = []; % Available are: 'DabPrintNozzleTool.ply';        
%         toolParametersFilename = []; % Available are: 'DabPrintNozzleToolParameters.mat';    
        currentJoints = [];
%         safePosJoints1 = [];

        Estop = 0;
        
    end
    
    methods%% Class for UR10 robot simulation
        function self = UR10e()
            
            self.GetUR10eRobot();
            self.PlotAndColourRobot();%robot,workspace);
            % self.safePosJoints1 = ([]);
        
            self.model.base = transl(0,0,0)
            self.currentJoints = [-90 80 -110 180 -90 0]*pi/180;
%             self.model.plot(self.currentJoints, 'scale', 0.05, 'noarrow', 'nobase', 'nojoints','notiles','noshadow'); %comment out if using animate
%             camzoom(4)
%             view([122,14]);
%             camzoom(8)
%             teach(self.model);
        end

        %% GetUR10Robot
        % Given a name (optional), create and return a UR10 robot model
        function GetUR10eRobot(self)
            pause(0.001);
            name = ['UR_10_',datestr(now,'yyyymmddTHHMMSSFFF')];

            L1 = Link('d',0.1807,'a',0,'alpha',pi/2,'qlim',deg2rad([-360 360]), 'offset', 0);
            L2 = Link('d',0+0.15,'a',-0.6127,'alpha',0,'qlim', deg2rad([-30 210]), 'offset', pi); % was 'offset',pi/2
            L3 = Link('d',0-0.15,'a',-0.5716,'alpha',0,'qlim', deg2rad([-150 150]), 'offset', 0);
            L4 = Link('d',0.17415,'a',0,'alpha',pi/2,'qlim',deg2rad([-360 360]),'offset', 0); % was 'offset',pi/2
            L5 = Link('d',0.11985,'a',0,'alpha',-pi/2,'qlim',deg2rad([-120 120]), 'offset', 0);
            L6 = Link('d',0.11655,'a',0,'alpha',0,'qlim',deg2rad([-360 360]), 'offset', 0);

            self.model = SerialLink([L1 L2 L3 L4 L5 L6],'name',name);
            self.model.plotopt = ('noname');
        end

        %% PlotAndColourRobot
        % Given a robot index, add the glyphs (vertices and faces) and
        % colour them in if data is available 
        function PlotAndColourRobot(self)%robot,workspace)
            for linkIndex = 0:self.model.n
                [ faceData, vertexData, plyData{linkIndex + 1} ] = plyread(['UR10eLink',num2str(linkIndex),'.ply'],'tri'); %#ok<AGROW>
                self.model.faces{linkIndex + 1} = faceData;
                self.model.points{linkIndex + 1} = vertexData;
            end

%             if ~isempty(self.toolModelFilename)
%                 [ faceData, vertexData, plyData{self.model.n + 1} ] = plyread(self.toolModelFilename,'tri'); 
%                 self.model.faces{self.model.n + 1} = faceData;
%                 self.model.points{self.model.n + 1} = vertexData;
%                 toolParameters = load(self.toolParametersFilename);
%                 self.model.tool = toolParameters.tool;
%                 self.model.qlim = toolParameters.qlim;
%                 warning('Please check the joint limits. They may be unsafe')
%             end
            % Display robot
            self.model.base = transl(0,0,0);
            self.model.plot3d(zeros(1,self.model.n),'noarrow','notiles');
            %self.model.plot3d(self.currentJoints, 'noarrow', 'notiles');
            if isempty(findobj(get(gca,'Children'),'Type','Light'))
                camlight
            end  
            self.model.delay = 0;

            % Try to correctly colour the arm (if colours are in ply file data)
            for linkIndex = 0:self.model.n
                handles = findobj('Tag', self.model.name);
                h = get(handles,'UserData');
                try 
                    h.link(linkIndex+1).Children.FaceVertexCData = [plyData{linkIndex+1}.vertex.red ...
                                                                  , plyData{linkIndex+1}.vertex.green ...
                                                                  , plyData{linkIndex+1}.vertex.blue]/255;
                    h.link(linkIndex+1).Children.FaceColor = 'interp';
                catch ME_1
                    disp(ME_1);
                    continue;
                end
            end
        end
        %% Animates UR10e from current EE position to another EE position using animate
        function moveBasicA(self, pos, g)
            step = 30;
            currentQ = self.currentJoints;
            
                    
            newQ = self.model.ikcon(pos, [1 1 1 1 1 1]);
            qMatrix = jtraj(currentQ, newQ, step); %traj from current position to new position

            for i = 1:size(qMatrix, 1)
                self.model.animate(qMatrix(i,:));
                self.currentJoints = (qMatrix(i,:))
                g.move_gripper(self.model.fkine(self.currentJoints));
                drawnow();
                pause(0.05);
            end
        end      
                %% Animates UR10e from current EE position to another EE position using plot
        function moveBasic(self, pos)
            step = 30;
            currentQ = self.currentJoints;
            
                    
            newQ = self.model.ikcon(pos, [1 1 1 1 1 1]);
            qMatrix = jtraj(currentQ, newQ, step); %traj from current position to new position

            for i = 1:size(qMatrix, 1)
                self.model.plot(qMatrix(i,:));
                self.currentJoints = (qMatrix(i,:))
            end
        end      
        %% Animates UR10e to go to a specific position based on obj_data **NOT COMPLETE**
        function move(self, gripper, obj_data)
            if obj_data.Object_Type == "Large"
                % determine position to move gripper to, therefore the
                % position to move end effector to
            else
                

            end

            step = 30;
            q1 = self.currentJoints;
            q2 = self.model.ikcon(pos);
            qMatrix = jtraj(q1, q2, step); %traj from current position to new position

            for i = 1:size(qMatrix, 1)
                self.model.plot(qMatrix(i,:));
                self.currentJoints = (qMatrix(i,:))
                T_Form = self.model.fkine(qMatrix(i,:))
                gripper.move_gripper(T_Form);
                obj_data.move_object(T_Form);
            end
                    
           
        end   
    %% Rotates final UR10e link to pour a drink
    function pour(self,seconds)
%   function pour(self, gripper, obj_data)
        step = 30;
        temp1 = self.currentJoints;
        temp2 = [self.currentJoints(1), self.currentJoints(2), self.currentJoints(3), self.currentJoints(4), self.currentJoints(5), self.currentJoints(6) + pi/3]
        q1 = temp1;
        q2 = temp2;
        
        qMatrix1 = jtraj(q1, q2, step);
        for i = 1:size(qMatrix1, 1)
                self.model.animate(qMatrix1(i,:));
                self.currentJoints = (qMatrix1(i,:))
%                 T_Form = self.model.fkine(qMatrix1(i,:))
%                 gripper.move_gripper(T_Form);
%                 obj_data.move_object(T_Form);
                drawnow();
        end
        
        pause(seconds);
        
        qMatrix2 = jtraj(q2, q1, step);
        for i = 1:size(qMatrix2, 1)
                self.model.animate(qMatrix2(i,:));
                self.currentJoints = (qMatrix2(i,:))
%                 T_Form = self.model.fkine(qMatrix2(i,:))
%                 gripper.move_gripper(T_Form);
%                 obj_data.move_object(T_Form);
                drawnow();
        end
    end
    %% Accepts a code from the GUI and runs the procedure to make a drink
        function run(self, gripper, code)

            

        end


        function is_safe = checkEStop(self)
            if self.Estop == 1
                is_safe = 0
            else
                is_safe = 1;

            end
        end



    end
%% Put methods in here if you want to make them private
    methods (Access = private)
    


    end
end