classdef Gripper < handle
    %GRIPPER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
 
        models;
        palm_model;
        workspace = [-1 1 -1 1 -0.5 0.5];
        relative_finger_t = cat(3,cat(3,[0,0,-1,-0.01421;0,1,0,0.0365;1,0,0,0.0611;0,0,0,1],[0,0,1,0.0141;0,-1,0,0;1,0,0,0.0611;0,0,0,1]),[0,0,-1,-0.01421;0,1,0,-0.0365;1,0,0,0.0611;0,0,0,1])
       palm_width = 0.089;
       finger_joint_lengths = [0.05715,0.0381,0.0382]


       joint_pos;

        x;
    end
    
    methods



        %% Constructor
        function self = Gripper()
            
            


            hold on
            self.models = [self.Finger(0), self.Finger(1), self.Finger(2)];
            %self.model = self.Finger(1)
            self.Model_Fingers
             self.Palm
             
%             self.Finger(1)
%             self.Finger(2)
            hold off
        end



        %% Creates Individual Finger

        
        function finger = Finger(self,finger_num)
            pause(0.001);
            L1 = Link('d',0.03705,'a',0.02151,'alpha',pi/2,'offset',0);
            L2 = Link('d',0,'a',0.05715,'alpha',0,'offset',0);
            L3 = Link('d',0,'a',0.0381,'alpha',0,'offset',0);
            L4 = Link('d',0,'a',0.0381,'alpha',pi/2,'offset',0);

            if(finger_num~=1)
            L1.qlim = [-16 16]*pi/180;
            else
            L1.qlim = [0 0];
            end
            L2.qlim = [-25 20.96]*pi/180;
            L3.qlim = [-45 0]*pi/180;
            L4.qlim = [-45 45]*pi/180;
            if(finger_num==0)
            model = SerialLink([L1 L2 L3 L4], 'name', 'finger0');
            model.base = self.relative_finger_t(:,:,1);
%             model.base = transl(-0.01416,0.03651,0.06112)*troty(-pi/2);
            

            end
            if(finger_num==1)
            model = SerialLink([L1 L2 L3 L4], 'name', 'finger1');
            model.base = self.relative_finger_t(:,:,2);
           % model.base = transl(0.01413,0,0.06112)*troty(-pi/2)*trotx(pi);
            

            end
            if(finger_num==2)
            model = SerialLink([L1 L2 L3 L4], 'name', 'finger2');
            model.base = self.relative_finger_t(:,:,3);
            %model.base = transl(-0.01416,-0.03651,0.06112)*troty(-pi/2);
           
            
            end
            
            finger = model;
           
        end


%% Function to create a template that the palm will fit on as well as model the palm
function Palm(self)
L1 = Link('d',0.001,'a',0.001,'alpha',0,'offset',0);
self.palm_model = SerialLink([L1],'name','palm');
self.Model_Palm;
end


%% This function places the ply models of the gripper onto the arms
function Model_Fingers(self)
 [~,y] = size(self.models)
for count = 1:y


            for linkIndex = 0:self.models(1,count).n
                [ faceData, vertexData, plyData{linkIndex + 1} ] =plyread(['Gripper/PLY_Files/Part',num2str(linkIndex),'.PLY'],'tri'); 
                self.models(1,count).faces{linkIndex + 1} = faceData;
                self.models(1,count).points{linkIndex + 1} = vertexData;
            end

            
            % Display robot
            self.models(1,count).plot3d(zeros(1,self.models(1,count).n),'noarrow','workspace',self.workspace);
            if isempty(findobj(get(gca,'Children'),'Type','Light'))
                camlight
            end  
            self.models(1,count).delay = 0;

            % Try to correctly colour the arm (if colours are in ply file data)
            for linkIndex = 0:self.models(1,count).n
                handles = findobj('Tag', self.models(1,count).name);
                h = get(handles,'UserData');
                try 
%                     h.link(linkIndex+1).Children.FaceVertexCData = [plyData{linkIndex+1}.vertex.red ...
%                                                                   , plyData{linkIndex+1}.vertex.green ...
%                                                                   , plyData{linkIndex+1}.vertex.blue]/255;
                    h.link(linkIndex+1).Children.FaceVertexCData = [plyData{linkIndex+1}.face.red ...
                                                                  , plyData{linkIndex+1}.face.green ...
                                                                  , plyData{linkIndex+1}.face.blue]/255;
                    h.link(linkIndex+1).Children.FaceColor = 'flat';
                catch ME_1
                    disp(ME_1);
                    continue;
                end
            end
end
end


%% Function to model the Palm
    function Model_Palm(self)
            for linkIndex = 0:self.palm_model.n
                [ faceData, vertexData, plyData{linkIndex + 1} ] =plyread(['Gripper/PLY_Files/Base',num2str(linkIndex),'.PLY'],'tri'); 
                self.palm_model.faces{linkIndex + 1} = faceData;
                self.palm_model.points{linkIndex + 1} = vertexData;
            end

            
            % Display robot
            self.palm_model.plot3d(zeros(1,self.palm_model.n),'noarrow','workspace',self.workspace);
            if isempty(findobj(get(gca,'Children'),'Type','Light'))
                camlight
            end  
            self.palm_model.delay = 0;

            % Try to correctly colour the arm (if colours are in ply file data)
            for linkIndex = 0:self.palm_model.n
                handles = findobj('Tag', self.palm_model.name);
                h = get(handles,'UserData');
                try 
%                     h.link(linkIndex+1).Children.FaceVertexCData = [plyData{linkIndex+1}.vertex.red ...
%                                                                   , plyData{linkIndex+1}.vertex.green ...
%                                                                   , plyData{linkIndex+1}.vertex.blue]/255;
                    h.link(linkIndex+1).Children.FaceVertexCData = [plyData{linkIndex+1}.face.red ...
                                                                  , plyData{linkIndex+1}.face.green ...
                                                                  , plyData{linkIndex+1}.face.blue]/255;
                    h.link(linkIndex+1).Children.FaceColor = 'flat';
                catch ME_1
                    disp(ME_1);
                    continue;
                end
            end


    end
    
    
    %% Updates the bases of the fingers to be relative to the base of the palm 
    %so that all the fingers stay in the same spot as the gripper moves.
    function update_finger_bases(self)
         [~,i] = size(self.models);
        for count = 1:i
            self.models(1,i).base = self.palm_model.base * self.relative_finger_t(:,:,i);
%         end 
        end
    end


    
    
    %% A function to pick up small objects by pinching them with the fingers
    function pinch_grip(self)


    end


    %% function to grip a large object by wrapping the fingers around it.
    function encompassing_grip(self,radius)
        if radius >= self.palm_width/2
            error("the Provided Radius is too large at : %f m",radius)
        end
    %Step 1 move the 1st joint to be in contact with the object assuming
    % the object is a cylinder
    angle = zeros(1,3);

    object = [0,radius];
    self.joint_pos = zeros(3,4);

    self.joint_pos(:,1) = [self.palm_width/2,0,0,];

 % itterate through each finger joint
for num = 1:3
    [angle(num)] = self.encomp_finger_angle(object,self.finger_joint_lengths(num),num);

end


%Requires animation to do smooth movement
    

  
    



    end



%% Function to determine how much a finger has to bend to grab something
function [angle] = encomp_finger_angle(self,object,length,count)

dist_centroid = sqrt((self.joint_pos(1,count)-object(1))^2+(self.joint_pos(2,count)-object(2))^2)
    tangental = sqrt(dist_centroid^2-object(2)^2)
    angle =  2*acos(tangental/dist_centroid);

    if count == 1 % if this is the first joint (behaves differently)
        angle = pi/2-angle;
    else
        angle = pi - angle;
    end
    self.joint_pos(3,count+1) = angle;
   self.joint_pos(:,count+1) = [self.joint_pos(1,count)+length*sin(2*pi-sum(self.joint_pos(3,:))),self.joint_pos(2,count)+length*cos(2*pi-sum(self.joint_pos(3,:))),angle];
    
    
  


end










    end



    end

