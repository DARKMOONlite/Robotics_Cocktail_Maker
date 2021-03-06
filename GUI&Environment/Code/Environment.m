%Environment class

%% Plot environment 
classdef Environment < handle
    properties
      
        
        workspace = [-2.5 2.5 -2.5 2.5 0 2.5];  %workspace area 
        

       
          
    end

methods

function self = Environment(base)
          
 
    %self.PuttingSimulatedObjectsIntoTheEnvironment(base);


end

function [PuttingSimulatedObjectsIntoTheEnvironment] = build(self,base)
    % Turn on a light (only turn on 1, don't keep turning them on), and make axis equal
    camlight;
    axis equal;
    view(3);
    hold on;

PuttingSimulatedObjectsIntoTheEnvironment = 0;


% clf
%% Load the table downloaded from http://tf3dm.com/3d-model/wooden-table-49763.html vertex colours added with Blender
    [f,v,data] = plyread('Bar.ply','tri');

    tableVertexCount = size(v,1);
    % Scale the colours to be 0-to-1 (they are originally 0-to-255
    vertexColours = [data.vertex.red, data.vertex.green, data.vertex.blue] / 255;
    % Then plot the trisurf
    midPoint = sum(v)/tableVertexCount;
            tableVerts = v - repmat(midPoint,tableVertexCount,1);
    
            tableMesh_h = trisurf(f,v(:,1) ,v(:,2), v(:,3) ...
        ,'FaceVertexCData',vertexColours,'EdgeColor','interp','EdgeLighting','flat');
    transformationMatrix = makehgtform('translate',[0,0.2,-0.2]); % new transform
            rotationMatrix = makehgtform('xrotate',deg2rad(90)); % new rotation
            Points = [transformationMatrix * rotationMatrix * [tableVerts,ones(tableVertexCount,1)]']';
            tableMesh_h.Vertices = Points(:,1:3); % Plots these new points
    % clf
%     %% Load cabinet
%     [f,v,data] = plyread('cabinet.ply','tri');
%     % Scale the colours to be 0-to-1 (they are originally 0-to-255
%     vertexColours = [data.vertex.red, data.vertex.green, data.vertex.blue] / 255;
%     % Then plot the trisurf
%     tableMesh_h = trisurf(f,v(:,1)-2,v(:,2) -2, v(:,3) ...
%         ,'FaceVertexCData',vertexColours,'EdgeColor','interp','EdgeLighting','flat');
    %% Load Fire Extinguisher
    [f,v,data] = plyread('fire_ext.ply','tri');
    FireExtinguisherVertexCount = size(v,1);
        midPoint = sum(v)/ FireExtinguisherVertexCount;
        FireExtinguisherVerts = v - repmat(midPoint, FireExtinguisherVertexCount,1);
    % Scale the colours to be 0-to-1 (they are originally 0-to-255
    vertexColours = [data.vertex.red, data.vertex.green, data.vertex.blue] / 255;
    % Then plot the trisurf
    Fire_extMesh_h = trisurf(f,v(:,1) +1,v(:,2) -1.6, v(:,3) ...
        ,'FaceVertexCData',vertexColours,'EdgeColor','interp','EdgeLighting','flat');
transformationMatrix = makehgtform('translate',[-1.5,-1,-0.6]); % new transform
%rotationMatrix = makehgtform('xrotate',deg2rad(90)); % new rotation
Points = [transformationMatrix  * [FireExtinguisherVerts,ones(FireExtinguisherVertexCount,1)]']';
        Fire_extMesh_h.Vertices = Points(:,1:3); % Plots these new points
    %% Load fence from blender w/ rotations

%     %% Load Killswitch
%     [f,v,data] = plyread('Barricade.ply','tri');
%     
%     StopButtonVertexCount = size(v,1);
%     midPoint = sum(v)/StopButtonVertexCount;
%             StopButtonVerts = v - repmat(midPoint,StopButtonVertexCount,1);
%     % Scale the colours to be 0-to-1 (they are originally 0-to-255
%     vertexColours = [data.vertex.red, data.vertex.green, data.vertex.blue] / 255;
%     % Then plot the trisurf
%     StopButtonMesh_h = trisurf(f,v(:,1) -0.5 ,v(:,2) -1.6, v(:,3) + 2 ...
%         ,'FaceVertexCData',vertexColours,'EdgeColor','interp','EdgeLighting','flat');
%     transformationMatrix = makehgtform('translate',[0,2,1.2]); % new transform
%             rotationMatrix = makehgtform('xrotate',deg2rad(90)); % new rotation
%             Points = [transformationMatrix * rotationMatrix * [StopButtonVerts,ones(StopButtonVertexCount,1)]']';
%             StopButtonMesh_h.Vertices = Points(:,1:3); % Plots these new points
% 
%             %% Load goggles
%             [f,v,data] = plyread('SafetyGoggles.ply','tri');
%     % Scale the colours to be 0-to-1 (they are originally 0-to-255
%     vertexColours = [data.vertex.red, data.vertex.green, data.vertex.blue] / 255;
%     % Then plot the trisurf
%     gogglesMesh_h = trisurf(f,v(:,1) -2.35,v(:,2) -2, v(:,3) +0.4 ...
%         ,'FaceVertexCData',vertexColours,'EdgeColor','interp','EdgeLighting','flat');
%     %% Load Hard Hat
%      [f,v,data] = plyread('HardHat.ply','tri');
%     % Scale the colours to be 0-to-1 (they are originally 0-to-255
%     vertexColours = [data.vertex.red, data.vertex.green, data.vertex.blue] / 255;
%     % Then plot the trisurf
%     HardHatMesh_h = trisurf(f,v(:,1) -2,v(:,2) -2, v(:,3) +0.4 ...
%         ,'FaceVertexCData',vertexColours,'EdgeColor','interp','EdgeLighting','flat');
%% Load floor
 
        x = [-2.5 2.5]; %plot image these coordinates on x axis 
        y = [-4.5 1.5]; %plot image with these coordinates on y axis
        z = [-1.25 -1.25; -1.25 -1.25]; %plot image with these coordinates on z axis 
        surf(x, y, z,'CData',imread('floor2.jpg'),'FaceColor','texturemap');

%% Load Lab
 
        x = [2.5 -2.5];
        y = [-4.5 -4.5];
        z = [1.25 1.25; -1.25 -1.25];
        surf(x, y, z,'CData',imread('bar.jfif'),'FaceColor','texturemap');


%% Load Bar Wall
 
        x = [1.5 -1.5];
        y = [1.4 1.4];
        z = [1.25 1.25; -0.25 -0.25];
        surf(x, y, z,'CData',imread('Bar_Wall.jpg'),'FaceColor','texturemap');
%% stop button 1
[f,v,data] = plyread('StopButton.ply','tri');

StopButtonVertexCount = size(v,1);
midPoint = sum(v)/StopButtonVertexCount;
        StopButtonVerts = v - repmat(midPoint,StopButtonVertexCount,1);
% Scale the colours to be 0-to-1 (they are originally 0-to-255
vertexColours = [data.vertex.red, data.vertex.green, data.vertex.blue] / 255;
% Then plot the trisurf
StopButtonMesh_h = trisurf(f,v(:,1) -2 ,v(:,2) -1, v(:,3)  ...
    ,'FaceVertexCData',vertexColours,'EdgeColor','interp','EdgeLighting','flat');
transformationMatrix = makehgtform('translate',[-1.2,-0.8,0.02]); % new transform
        rotationMatrix = makehgtform('xrotate',deg2rad(90)); % new rotation
        Points = [transformationMatrix * rotationMatrix * [StopButtonVerts,ones(StopButtonVertexCount,1)]']';
        StopButtonMesh_h.Vertices = Points(:,1:3); % Plots these new points

%% Stop Button 2
[f,v,data] = plyread('StopButton.ply','tri');

StopButtonVertexCount = size(v,1);
midPoint = sum(v)/StopButtonVertexCount;
        StopButtonVerts = v - repmat(midPoint,StopButtonVertexCount,1);
% Scale the colours to be 0-to-1 (they are originally 0-to-255
vertexColours = [data.vertex.red, data.vertex.green, data.vertex.blue] / 255;
% Then plot the trisurf
StopButtonMesh_h = trisurf(f,v(:,1) -2 ,v(:,2) -1, v(:,3) + 2 ...
    ,'FaceVertexCData',vertexColours,'EdgeColor','interp','EdgeLighting','flat');
transformationMatrix = makehgtform('translate',[1.2,-0.8,0.02]); % new transform
        rotationMatrix = makehgtform('xrotate',deg2rad(90)); % new rotation
        Points = [transformationMatrix * rotationMatrix * [StopButtonVerts,ones(StopButtonVertexCount,1)]']';
        StopButtonMesh_h.Vertices = Points(:,1:3); % Plots these new points

 %% Load Light Curtain 1
[f,v,data] = plyread('Light_Curtain.ply','tri');

LCVertexCount = size(v,1);
midPoint = sum(v)/LCVertexCount;
        LCVerts = v - repmat(midPoint,LCVertexCount,1);
% Scale the colours to be 0-to-1 (they are originally 0-to-255
vertexColours = [data.face.red, data.face.green, data.face.blue] / 255;   
% Then plot the trisurf
LCMesh_h = trisurf(f,v(:,1) -2 ,v(:,2) -1, v(:,3)  ...
    ,'FaceVertexCData',vertexColours,'EdgeColor','none','EdgeLighting','none');
transformationMatrix = makehgtform('translate',[1.45,-1.2,0.3]); % new transform
        rotationMatrix = makehgtform('zrotate',deg2rad(180)); % new rotation
        Points = [transformationMatrix * rotationMatrix * [LCVerts,ones(LCVertexCount,1)]']';
        LCMesh_h.Vertices = Points(:,1:3); % Plots these new points
%% Load Light Curtain 2
[f,v,data] = plyread('Light_Curtain.ply','tri');

LCVertexCount = size(v,1);
midPoint = sum(v)/LCVertexCount;
        LCVerts = v - repmat(midPoint,LCVertexCount,1);
% Scale the colours to be 0-to-1 (they are originally 0-to-255
vertexColours = [data.face.red, data.face.green, data.face.blue] / 255;   
% Then plot the trisurf
LCMesh_h = trisurf(f,v(:,1) -2 ,v(:,2) -1, v(:,3)  ...
    ,'FaceVertexCData',vertexColours,'EdgeColor','none','EdgeLighting','none');
transformationMatrix = makehgtform('translate',[-1.45,-1.2,0.3]); % new transform
        rotationMatrix = makehgtform('zrotate',deg2rad(0)); % new rotation
        Points = [transformationMatrix * rotationMatrix * [LCVerts,ones(LCVertexCount,1)]']';
        LCMesh_h.Vertices = Points(:,1:3); % Plots these new points


        %% Load Light Curtain 3
[f,v,data] = plyread('Light_Curtain.ply','tri');

LCVertexCount = size(v,1);
midPoint = sum(v)/LCVertexCount;
        LCVerts = v - repmat(midPoint,LCVertexCount,1);
% Scale the colours to be 0-to-1 (they are originally 0-to-255
vertexColours = [data.face.red, data.face.green, data.face.blue] / 255;   
% Then plot the trisurf
LCMesh_h = trisurf(f,v(:,1) -2 ,v(:,2) -1, v(:,3)  ...
    ,'FaceVertexCData',vertexColours,'EdgeColor','none','EdgeLighting','none');
transformationMatrix = makehgtform('translate',[1.45,-1.15,0.3]); % new transform
        rotationMatrix = makehgtform('zrotate',deg2rad(90)); % new rotation
        Points = [transformationMatrix * rotationMatrix * [LCVerts,ones(LCVertexCount,1)]']';
        LCMesh_h.Vertices = Points(:,1:3); % Plots these new points


        %% Load Light Curtain 4
[f,v,data] = plyread('Light_Curtain.ply','tri');

LCVertexCount = size(v,1);
midPoint = sum(v)/LCVertexCount;
        LCVerts = v - repmat(midPoint,LCVertexCount,1);
% Scale the colours to be 0-to-1 (they are originally 0-to-255
vertexColours = [data.face.red, data.face.green, data.face.blue] / 255;   
% Then plot the trisurf
LCMesh_h = trisurf(f,v(:,1) -2 ,v(:,2) -1, v(:,3)  ...
    ,'FaceVertexCData',vertexColours,'EdgeColor','none','EdgeLighting','none');
transformationMatrix = makehgtform('translate',[1.45,0.4,0.3]); % new transform
        rotationMatrix = makehgtform('zrotate',deg2rad(-90)); % new rotation
        Points = [transformationMatrix * rotationMatrix * [LCVerts,ones(LCVertexCount,1)]']';
        LCMesh_h.Vertices = Points(:,1:3); % Plots these new points
%% Load Bar table 
% [f,v,data] = plyread('table.ply','tri');
% 
% StopButtonVertexCount = size(v,1);
% midPoint = sum(v)/StopButtonVertexCount;
%         StopButtonVerts = v - repmat(midPoint,StopButtonVertexCount,1);
% % Scale the colours to be 0-to-1 (they are originally 0-to-255
% vertexColours = [data.vertex.red, data.vertex.green, data.vertex.blue] / 255;
% % Then plot the trisurf
% StopButtonMesh_h = trisurf(f,v(:,1)  ,v(:,2) , v(:,3)   ...
%     ,'FaceVertexCData',vertexColours,'EdgeColor','interp','EdgeLighting','flat');
% transformationMatrix = makehgtform('translate',[2,0,0.3]); % new transform
%         rotationMatrix = makehgtform('zrotate',deg2rad(90)); % new rotation
%         Points = [transformationMatrix * rotationMatrix * [StopButtonVerts,ones(StopButtonVertexCount,1)]']';
%         StopButtonMesh_h.Vertices = Points(:,1:3); % Plots these new points
        
end
end
end

