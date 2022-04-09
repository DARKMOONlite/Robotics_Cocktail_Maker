classdef LinearUR5 < handle & Arm
    properties
        %> Robot model
        model;
        
        %>
        workspace = [-4 4 -4 5 -1 4];   
        
        %> Flag to indicate if gripper is used
        useGripper = false;      
        Base_Position = [0.45,-0.3,0];
    end
    
    methods%% Class for UR5 robot simulation
function self = LinearUR5(useGripper)
    self.useGripper = useGripper;
    
%> Define the boundaries of the workspace

        
% robot = 
self.GetUR5Robot();
% robot = 
self.PlotAndColourRobot();%robot,workspace);
end

%% GetUR5Robot
% Given a name (optional), create and return a UR5 robot model
function GetUR5Robot(self)
%     if nargin < 1
        % Create a unique name (ms timestamp after 1ms pause)
        pause(0.001);
        name = ['LinearUR_5_',datestr(now,'yyyymmddTHHMMSSFFF')];
%     end

    % Create the UR5 model mounted on a linear rail
    L(1) = Link([pi     0       0       pi/2    1]); % PRISMATIC Link
    L(2) = Link([0      0.1599  0       -pi/2   0]);
    L(3) = Link([0      0.1357  0.425   -pi     0]);
    L(4) = Link([0      0.1197  0.39243 pi      0]);
    L(5) = Link([0      0.093   0       -pi/2   0]);
    L(6) = Link([0      0.093   0       -pi/2	0]);
    L(7) = Link([0      0       0       0       0]);
    
    % Incorporate joint limits
    L(1).qlim = [-0.8 0];
    L(2).qlim = [-360 360]*pi/180;
    L(3).qlim = [0 90]*pi/180; %  Changed from -90 to 0
    L(4).qlim = [-170 170]*pi/180;
    L(5).qlim = [-360 360]*pi/180;
    L(6).qlim = [-360 360]*pi/180;
    L(7).qlim = [-360 360]*pi/180;



%     L(1).qlim = [-0.8 0];
%     L(2).qlim = [-360 360]*pi/180;
%     L(3).qlim = [-90 90]*pi/180;
%     L(4).qlim = [-170 170]*pi/180;
%     L(5).qlim = [-360 360]*pi/180;
%     L(6).qlim = [-360 360]*pi/180;
%     L(7).qlim = [-360 360]*pi/180;

    L(3).offset = -pi/2;
    L(5).offset = -pi/2;
    
    self.model = SerialLink(L,'name',name);
    
    % Rotate robot to the correct orientation
    self.model.base = transl(self.Base_Position(1), self.Base_Position(2),self.Base_Position(3))*trotx(pi/2); 

    self.model.plot([0,0,0,0,0,0,0],'workspace',self.workspace,'scale',0.25)
end
%% PlotAndColourRobot
% Given a robot index, add the glyphs (vertices and faces) and
% colour them in if data is available 
function PlotAndColourRobot(self)%robot,workspace)
%     for linkIndex = 0:self.model.n
%         if self.useGripper && linkIndex == self.model.n
%             [ faceData, vertexData, plyData{linkIndex+1} ] = plyread(['LinUR5Link',num2str(linkIndex),'Gripper.ply'],'tri'); %#ok<AGROW>
%         else
%             [ faceData, vertexData, plyData{linkIndex+1} ] = plyread(['LinUR5Link',num2str(linkIndex),'.ply'],'tri'); %#ok<AGROW>
%         end
%         self.model.faces{linkIndex+1} = faceData;
%         self.model.points{linkIndex+1} = vertexData;
%     end

   % % Display robot
    %self.model.plot3d(zeros(1,self.model.n),'workspace',self.workspace);%'noarrow'
%     if isempty(findobj(get(gca,'Children'),'Type','Light'))
%         camlight
%     end  
%     self.model.delay = 0;
% 
%     % Try to correctly colour the arm (if colours are in ply file data)
%     for linkIndex = 0:self.model.n
%         handles = findobj('Tag', self.model.name);
%         h = get(handles,'UserData');
%         try 
%             h.link(linkIndex+1).Children.FaceVertexCData = [plyData{linkIndex+1}.vertex.red ...
%                                                           , plyData{linkIndex+1}.vertex.green ...
%                                                           , plyData{linkIndex+1}.vertex.blue]/255;
%             h.link(linkIndex+1).Children.FaceColor = 'interp';
%         catch ME_1
%             disp(ME_1);
%             continue;
%         end
%     end
 end        
    end
end