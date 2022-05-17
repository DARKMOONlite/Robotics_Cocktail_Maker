classdef UR10e < handle
    properties
        %> Robot model
        model;    
        %> workspace
        workspace = [0 0 0 0 0 0];   

        arm_intrinsic_offset = 0.15;
         
        currentJoints = [];
        
        idle = [90 140 240 160 270 0; % Drinks
                180 140 240 160 270 0; % Dispenser high 
                208 80 240 220 298 0; % Dispenser low
                270 80 240 220 270 0;]*pi/180; % Glass/Default
            
        drinkIdle = [57 140 240 160 270 0; % Vodka
                     70 140 240 160 270 0; % Rum
                     88 140 240 160 270 0; % Tonic 
                     138 140 240 160 270 0;]*pi/180; % Gin
                 
        drinks = [57 88 261 190 272 0;
                  70 99 248 191 270 0;
                  88 109 243 188 270 0;
                  138 99 245 196 270 0;] * pi/180; 
        
        dispenserIdle = [172 80 240 220 270 0; % Ice
                         208 80 240 220 298 0; % Lime
                         217 80 240 220 270 0;]*pi/180; % Sugar
                     
        dispensers = [172 51 267 222 270 0;
                      200 53 264 222 290 0;
                      223 42 278 220 310 0;]*pi/180;
        
        glass = [281 54 252 234 270 0;]*pi/180;
        
        pourPos = [270 65 255 220 270 0; % Glass
                   0 0 0 0 0 0;]*pi/180; % Shaker
        
        gripAng1 = [0 0.2379 0.6936 1.2574;
                    0 0.2379 0.6936 1.2574;
                    0 0.2379 0.6936 1.2574;
                    0 0.2379 0.6936 1.2574;];
                
        gripAng2 = [0 0.0578 0.5851 1.0896;
                    0 0.0578 0.5851 1.0896;
                    0 0.0578 0.5851 1.0896;
                    0 0.0578 0.5851 1.0896;];
                
        Estop = 0;
        spotlight;
        
    end
    
    methods%% Class for UR10 robot simulation
        function self = UR10e()
            
            self.GetUR10eRobot();
            self.PlotAndColourRobot();%robot,workspace);
            %self.model.plot([0 0 0 0 0 0], 'scale', 0.05, 'noarrow', 'nobase', 'nojoints','notiles','noshadow'); %comment out if using animate
            
            self.model.base = transl(0,0,0);
            self.currentJoints = [270 80 240 220 270 0]*pi/180;

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

            L1 = Link('d',0.1807,'a',0,'alpha',pi/2,'qlim',deg2rad([40 320]), 'offset', 0);
            L2 = Link('d',0+0.15,'a',-0.6127,'alpha',0,'qlim', deg2rad([40 180]), 'offset', pi); % was 'offset',pi/2
            L3 = Link('d',0-0.15,'a',-0.5716,'alpha',0,'qlim', deg2rad([200 300]), 'offset', 0);     L3 = Link('d',0- self.arm_intrinsic_offset,'a',-0.5716,'alpha',0,'qlim', deg2rad([200 300]), 'offset', 0);
            L4 = Link('d',0.17415,'a',0,'alpha',pi/2,'qlim',deg2rad([150 250]),'offset', 0); % was 'offset',pi/2
            L5 = Link('d',0.11985,'a',0,'alpha',-pi/2,'qlim',deg2rad([-360 360]), 'offset', 0);
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
            self.model.plot3d(zeros(1,self.model.n),'noarrow','workspace',self.workspace,'scale', 0.05);
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
        %% Animates UR10e from current pose/position to another position
        function moveBasicA(self, pos, g)
            step = 30;
            currentQ = self.currentJoints;             
            [newQ, error] = self.model.ikcon(pos, [1 1 1 1 1 1]);
            error

            qMatrix = jtraj(currentQ, newQ, step); %traj from current position to new position
  
            for i = 1:size(qMatrix, 1)

                    self.model.animate(qMatrix(i,:));
                    self.currentJoints = (qMatrix(i,:));
                    g.move_gripper(self.model.fkine(self.currentJoints));
                    drawnow();
            end
        end      
        %% Animates UR10e from current pose/position to another pose
        function move(self, pos, g)
            step = 30;
            currentQ = self.currentJoints;             
            newQ = pos;
            
            qMatrix = jtraj(currentQ, newQ, step); %traj from current position to new position
  
            for i = 1:size(qMatrix, 1)
                    self.model.animate(qMatrix(i,:));
                    self.currentJoints = (qMatrix(i,:))
                    g.move_gripper(self.model.fkine(self.currentJoints));
                    drawnow();
            end
        end  
        %%
        function moveWithObj(self, pos, obj, g)
            step = 30;
            currentQ = self.currentJoints; 
            newQ = pos;
            
            qMatrix = jtraj(currentQ, newQ, step); %traj from current position to new position
  
            for i = 1:size(qMatrix, 1)
                    self.model.animate(qMatrix(i,:));
                    self.currentJoints = (qMatrix(i,:))
                    g.move_gripper(self.model.fkine(self.currentJoints));
                    obj.move_object(self.model.fkine(self.currentJoints));
                    drawnow();
            end
        end   
    %% Rotates final UR10e link to pour a drink
    function pour(self, seconds, obj, g)
%   function pour(self, gripper, obj_data)
        step = 30;
        temp1 = self.currentJoints;
        temp2 = [self.currentJoints(1), self.currentJoints(2), self.currentJoints(3), self.currentJoints(4), self.currentJoints(5), self.currentJoints(6) - pi/3];
        q1 = temp1;
        q2 = temp2;
        
        qMatrix1 = jtraj(q1, q2, step);
        for i = 1:size(qMatrix1, 1)
                self.model.animate(qMatrix1(i,:));
                self.currentJoints = (qMatrix1(i,:));
                endpos = self.model.fkine(self.currentJoints);
                
                g.move_gripper(endpos);
                obj.move_object(endpos);
%                T_Form = self.model.fkine(qMatrix1(i,:))
%                gripper.move_gripper(T_Form);
%                obj_data.move_object(T_Form);
                drawnow();
        end
        
        pause(seconds);
        
        qMatrix2 = jtraj(q2, q1, step);
        for i = 1:size(qMatrix2, 1)
                self.model.animate(qMatrix2(i,:));
                self.currentJoints = (qMatrix2(i,:));
                g.move_gripper(self.model.fkine(self.currentJoints));
                obj.move_object(self.model.fkine(self.currentJoints));
%                T_Form = self.model.fkine(qMatrix2(i,:))
%                gripper.move_gripper(T_Form);
%                obj_data.move_object(T_Form);
                drawnow();
        end
    end

%%
    function  EStop(self,state)
        self.Estop = state;
        if size(self.spotlight,1)==0
            self.spotlight = light;
        end
        if state==1 
            
            self.spotlight.Color = [1,0,0];

        else
            self.spotlight.Color = [1,1,1];



        end
        
    end
%%
    function makeDrink(self, code, obj, g)

        codeArray = char(code);

        for i = 1:size(codeArray,2)
            action = codeArray(i);

            switch action
                case '0' % Pick Glass Up *Required if using dispensers*
                    disp('Drink action 0')
%                     self.move(self.idle(2,:), g);
                    self.move(self.idle(4,:), g);
                    
                    self.move(self.glass(1,:), g);
                    g.animate(self.gripAng1);
                    self.moveWithObj(self.idle(4,:), obj(7), g);

                case '1' % Pour Vodka
                    disp('Drink action 1')
%                     self.move(self.idle(3,:), g);
                    self.move(self.idle(2,:), g);
                    self.move(self.idle(1,:), g);
                    
                    self.move(self.drinkIdle(1,:), g);
                    self.move(self.drinks(1,:), g);
%                     call encompassing grip to pickup
                    g.animate(self.gripAng1);
                    self.moveWithObj(self.drinkIdle(1,:), obj(1), g);
                    
                    self.moveWithObj(self.idle(1,:), obj(1), g);
                    self.moveWithObj(self.idle(2,:), obj(1), g);
%                     self.move(self.idle(3,:), g);
                    self.moveWithObj(self.idle(4,:), obj(1), g);
                    
                    self.moveWithObj(self.pourPos(1,:), obj(1), g);
                    self.pour(0.5, obj(1), g);
                    self.moveWithObj(self.idle(4,:), obj(1), g);
                    
                    self.moveWithObj(self.idle(2,:), obj(1), g);
                    self.moveWithObj(self.idle(1,:), obj(1), g);
                    
                    self.moveWithObj(self.drinkIdle(1,:), obj(1), g);
                    self.moveWithObj(self.drinks(1,:), obj(1), g);
%                     call encompassing grip to release
                    g.idle();
                    obj(1).set_object(transl(0.6,0.6,0.4));
                    self.move(self.drinkIdle(1,:), g);
                    
                    self.move(self.idle(1,:), g);
%                     self.move(self.idle(2,:), g);
%                     self.move(self.idle(3,:), g);
%                     self.move(self.idle(4,:), g);
                    
                case '2' % Pour Rum
                    self.move(self.idle(2,:), g);
                    self.move(self.idle(1,:), g);
                    
                    self.move(self.drinkIdle(2,:), g);
                    self.move(self.drinks(2,:), g);
%                     call encompassing grip to pickup
                    g.animate(self.gripAng1);
                    self.moveWithObj(self.drinkIdle(2,:), obj(2), g);
                    
                    self.moveWithObj(self.idle(1,:), obj(2), g);
                    self.moveWithObj(self.idle(2,:), obj(2), g);
%                     self.move(self.idle(3,:), g);
                    self.moveWithObj(self.idle(4,:), obj(2), g);
                    
                    self.moveWithObj(self.pourPos(1,:), obj(2), g);
                    self.pour(0.5, obj(2), g);
                    self.moveWithObj(self.idle(4,:), obj(2), g);
                    
                    self.moveWithObj(self.idle(2,:), obj(2), g);
                    self.moveWithObj(self.idle(1,:), obj(2), g);
                    
                    self.moveWithObj(self.drinkIdle(2,:), obj(2), g);
                    self.moveWithObj(self.drinks(2,:), obj(2), g);
%                     call encompassing grip to release
                    g.idle();
                    obj(2).set_object(transl(0.4,0.6,0.4));
                    self.move(self.drinkIdle(2,:), g);
                    
                    self.move(self.idle(1,:), g);
%                     self.move(self.idle(2,:), g);
%                     self.move(self.idle(3,:), g);
%                     self.move(self.idle(4,:), g);
                    
                case '3' % Pour Tonic
                    disp('Drink action 3')
                    self.move(self.idle(2,:), g);
                    self.move(self.idle(1,:), g);
                    
                    self.move(self.drinkIdle(3,:), g);
                    self.move(self.drinks(3,:), g);
%                     call encompassing grip to pickup
                    g.animate(self.gripAng2);
                    self.moveWithObj(self.drinkIdle(3,:), obj(3), g);
                    
                    self.moveWithObj(self.idle(1,:), obj(3), g);
                    self.moveWithObj(self.idle(2,:), obj(3), g);
%                     self.move(self.idle(3,:), g);
                    self.moveWithObj(self.idle(4,:), obj(3), g);
                    
                    self.moveWithObj(self.pourPos(1,:), obj(3), g);
                    self.pour(0.5, obj(3), g);
                    self.moveWithObj(self.idle(4,:), obj(3), g);
                    
                    self.moveWithObj(self.idle(2,:), obj(3), g);
                    self.moveWithObj(self.idle(1,:), obj(3), g);
                    
                    self.moveWithObj(self.drinkIdle(3,:), obj(3), g);
                    self.moveWithObj(self.drinks(3,:), obj(3), g);
%                     call encompassing grip to release
                    g.idle();
                    obj(3).set_object(transl(0.2,0.6,0.4));
                    self.move(self.drinkIdle(3,:), g);
                    
                    self.move(self.idle(1,:), g);
%                     self.move(self.idle(2,:), g);
%                     self.move(self.idle(3,:), g);
%                     self.move(self.idle(4,:), g);

                case '4' % Pour Gin
                    disp('Drink action 4')
                    %self.move(self.idle(3,:), g);
                    %self.move(self.idle(2,:), g);
                    self.move(self.idle(1,:), g);
                    
                    self.move(self.drinkIdle(4,:), g);
                    self.move(self.drinks(4,:), g);
%                     call encompassing grip to pickup
                    g.animate(self.gripAng2);
                    self.moveWithObj(self.drinkIdle(4,:), obj(4), g);
                    
%                     self.moveWithObj(self.idle(1,:), obj(4), g);
                    self.moveWithObj(self.idle(2,:), obj(4), g);
%                     self.move(self.idle(3,:), g);
                    self.moveWithObj(self.idle(4,:), obj(4), g);
                    
                    self.moveWithObj(self.pourPos(1,:), obj(4), g);
                    self.pour(0.5, obj(4), g);
                    self.moveWithObj(self.idle(4,:), obj(4), g);
                    
                    self.moveWithObj(self.idle(2,:), obj(4), g);
%                     self.moveWithObj(self.idle(1,:), obj(4), g);
                    
                    self.moveWithObj(self.drinkIdle(4,:), obj(4), g);
                    self.moveWithObj(self.drinks(4,:), obj(4), g);
%                     call encompassing grip to release
                    g.idle();
                    obj(4).set_object(transl(-0.4,0.6,0.4));
                    self.move(self.drinkIdle(4,:), g);
                    
                    self.move(self.idle(1,:), g);
%                     self.move(self.idle(2,:), g);
%                     self.move(self.idle(3,:), g);
%                     self.move(self.idle(4,:), g);
                    

                case '5' % Add Ice
                    disp('Drink action 5')
                    
                    self.moveWithObj(self.idle(3,:), obj(7), g);
                    self.moveWithObj(self.dispenserIdle(1,:), obj(7), g);
                    self.moveWithObj(self.dispensers(1,:), obj(7), g);
                    pause(1);
                    self.moveWithObj(self.dispenserIdle(1,:), obj(7), g);
                    self.moveWithObj(self.idle(3,:), obj(7), g);
%                     self.moveWithObj(self.idle(4,:), obj(7), g);
%                     self.moveWithObj(self.glass(1,:), obj(7), g);
%                     g.idle();
%                     self.move(self.idle(4,:), g);
                    
                case '6'% Add Lime
                    disp('Drink action 6')
%                     self.moveWithObj(self.idle(3,:), obj(7), g);
                    self.moveWithObj(self.dispenserIdle(2,:), obj(7), g);
                    self.moveWithObj(self.dispensers(2,:), obj(7), g);
                    pause(1);
                    self.moveWithObj(self.dispenserIdle(2,:), obj(7), g);
                    self.moveWithObj(self.idle(3,:), obj(7), g);
                    
                case '7' % Add Sugar
                    disp('Drink action 7')
                    self.moveWithObj(self.idle(3,:), obj(7), g);
                    self.moveWithObj(self.dispenserIdle(3,:), obj(7), g);
                    self.moveWithObj(self.dispensers(3,:), obj(7), g);
                    pause(1);
                    self.moveWithObj(self.dispenserIdle(3,:), obj(7), g);
                    self.moveWithObj(self.idle(3,:), obj(7), g);
                    
                case '8' % Shake
                    disp('Drink action 8')

                case '9' % Pour Shaker
                    disp('Drink action 9')

                case 'a' % Pick glass up
                    disp('Drink action a')
                    %self.move(self.idle(2,:), g);
                    self.move(self.idle(4,:), g);
                    
                    self.move(self.glass(1,:), g);
                    g.animate(self.gripAng1);
                    self.moveWithObj(self.idle(4,:), obj(7), g)
                    
                case 'b' % Return drink if dispensers used
                    self.moveWithObj(self.idle(4,:), obj(7), g);
                    self.moveWithObj(self.glass(1,:), obj(7), g);
                    g.idle();
                    obj(7).set_object(transl(0,-0.95,0.0));
                    self.move(self.idle(4,:), g);
                    
                case 'c' % Return arm to idle if drinks used last
                    self.move(self.idle(4,:), g);
                    
                otherwise
                    disp('Error: Unassigned action code')
            end
        end
    end
end
%% Put methods in here if you want to make them private
    methods (Access = private)
    


    end
end