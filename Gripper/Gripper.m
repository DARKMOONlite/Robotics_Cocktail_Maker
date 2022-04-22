classdef Gripper < handle
    %GRIPPER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
 
        models;
        model;
        workspace = [-1 1 -1 1 -0.5 0.5];
        plyData

        x;
    end
    
    methods
        %% Constructor
        function self = Gripper()
            
            hold on
            %self.models = [self.Finger(0), self.Finger(1), self.Finger(2)];
            self.model = self.Finger(1)
            self.Model_Fingers
             
%             self.Finger(1)
%             self.Finger(2)
            hold off
        end
        %% Creates Individual Finger

        
        function finger = Finger(self,finger_num)
            pause(0.001);
            L1 = Link('d',0.03705,'a',0.02151,'alpha',pi/2,'offset',0)
            L2 = Link('d',0,'a',0.05715,'alpha',0,'offset',0)
            L3 = Link('d',0,'a',0.0381,'alpha',0,'offset',0)
            L4 = Link('d',0,'a',0.0382,'alpha',pi/2,'offset',0)

            if(finger_num)
            L1.qlim = [-16 16]*pi/180;
            else
            L1.qlim = [0 0];
            end
            L2.qlim = [-25 0]*pi/180;
            L3.qlim = [-45 0]*pi/180;
            L4.qlim = [-45 45]*pi/180;
            if(finger_num==0)
            model = SerialLink([L1 L2 L3 L4], 'name', 'finger0');
            model.base = transl(-0.01416,0.03651,0.06112)*troty(-pi/2)
            

            end
            if(finger_num==1)
            model = SerialLink([L1 L2 L3 L4], 'name', 'finger1');
            model.base = transl(0.01413,0,0.06112)*troty(-pi/2)*trotx(pi)
            

            end
            if(finger_num==2)
            model = SerialLink([L1 L2 L3 L4], 'name', 'finger2');
            model.base = transl(-0.01416,-0.03651,0.06112)*troty(-pi/2)
           
            
            end
            
            finger = model;
           
        end
%% This function places the ply models of the gripper onto the arms
function Model_Fingers(self)
%  [x,y] = size(self.models)
% for finger_count = 1:y
%  finger_count
%         for linkIndex = 0:self.models(finger_count).n
%             linkIndex
%             [ faceData, vertexData, plyData{linkIndex + 1} ] = plyread(['Gripper/PLY_Files/Part',num2str(linkIndex),'.PLY'],'tri'); %#ok<AGROW>
%              self.models(finger_count).faces{linkIndex + 1} = faceData;
%              self.models(finger_count).points{linkIndex + 1} = vertexData;
%         end
%             
%             self.models(finger_count).plot3d(zeros(1,self.models(finger_count).n));
%             if isempty(findobj(get(gca,'Children'),'Type','Light'))
%                 camlight
%             end  
%     for linkIndex = 0:self.models(finger_count).n
%         linkIndex
%         handles = findobj('Tag', self.models(finger_count).name);
% 
%         h = get(handles,'UserData')
% 
%         %try 
%             %self.h = h.link(linkIndex+1).Children
%             h.link(linkIndex+1).Children.FaceVertexCData = [plyData{linkIndex+1}.vertex.red ...
%                                                           , plyData{linkIndex+1}.vertex.green ...
%                                                           , plyData{linkIndex+1}.vertex.blue]/255;
% %             h.link(linkIndex+1).Children.FaceColor = [plyData{linkIndex+1}.face.red ...
% %                                                           , plyData{linkIndex+1}.face.green ...
% %                                                           , plyData{linkIndex+1}.face.blue]/255;
%             h.link(linkIndex+1).Children.FaceColor = 'interp';
%         %catch ME_1
%             %disp(ME_1);
%             %continue;
%        % end
%     end
% 
% s
% end




self.model.n
 for linkIndex = 0:self.model.n
 
  [ faceData, vertexData, plyData{linkIndex+1} ] = plyread(['Gripper/PLY_Files/Part',num2str(linkIndex),'.PLY'],'tri'); %#ok<AGROW>

   self.model.faces{linkIndex+1} = faceData;
   self.model.points{linkIndex+1} = vertexData;
   self.plyData{linkIndex+1} = plyData{linkIndex+1};
 end

    % Display robot
    
                       
                        self.model.plot3d(zeros(1,self.model.n),'noarrow','workspace',self.workspace);
                        if isempty(findobj(get(gca,'Children'),'Type','Light'))
                            camlight
                        end  
                        self.model.delay = 0;

%  for linkIndex = 0:self.model.n
%         handles = findobj('Tag', self.model.name);
% 
%         h = get(handles,'UserData')
% 
%         %try 
%             %self.h = h.link(linkIndex+1).Children
%             h.link(linkIndex+1).Children.FaceVertexCData = [plyData{linkIndex+1}.vertex.red ...
%                                                           , plyData{linkIndex+1}.vertex.green ...
%                                                           , plyData{linkIndex+1}.vertex.blue]/255;
% %             h.link(linkIndex+1).Children.FaceColor = [plyData{linkIndex+1}.face.red ...
% %                                                           , plyData{linkIndex+1}.face.green ...
% %                                                           , plyData{linkIndex+1}.face.blue]/255;
%             h.link(linkIndex+1).Children.FaceColor = 'interp';
%         %catch ME_1
%             %disp(ME_1);
%             %continue;
%        % end
%   end


end
    end
end

