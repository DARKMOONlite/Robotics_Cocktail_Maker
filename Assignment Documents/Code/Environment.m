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
    transformationMatrix = makehgtform('translate',[0,0,1.1]); % new transform
            rotationMatrix = makehgtform('xrotate',deg2rad(90)); % new rotation
            Points = [transformationMatrix * rotationMatrix * [tableVerts,ones(tableVertexCount,1)]']';
            tableMesh_h.Vertices = Points(:,1:3); % Plots these new points
    % clf
    %% Load cabinet
    [f,v,data] = plyread('cabinet.ply','tri');
    % Scale the colours to be 0-to-1 (they are originally 0-to-255
    vertexColours = [data.vertex.red, data.vertex.green, data.vertex.blue] / 255;
    % Then plot the trisurf
    tableMesh_h = trisurf(f,v(:,1)-2,v(:,2) -2, v(:,3) ...
        ,'FaceVertexCData',vertexColours,'EdgeColor','interp','EdgeLighting','flat');
    %% Load Fire Extinguisher
    [f,v,data] = plyread('fire_ext.ply','tri');
    % Scale the colours to be 0-to-1 (they are originally 0-to-255
    vertexColours = [data.vertex.red, data.vertex.green, data.vertex.blue] / 255;
    % Then plot the trisurf
    Fire_extMesh_h = trisurf(f,v(:,1) +1,v(:,2) -1.6, v(:,3) ...
        ,'FaceVertexCData',vertexColours,'EdgeColor','interp','EdgeLighting','flat');

    %% Load fence from blender w/ rotations

    %% Load Killswitch
    [f,v,data] = plyread('Barricade.ply','tri');
    
    StopButtonVertexCount = size(v,1);
    midPoint = sum(v)/StopButtonVertexCount;
            StopButtonVerts = v - repmat(midPoint,StopButtonVertexCount,1);
    % Scale the colours to be 0-to-1 (they are originally 0-to-255
    vertexColours = [data.vertex.red, data.vertex.green, data.vertex.blue] / 255;
    % Then plot the trisurf
    StopButtonMesh_h = trisurf(f,v(:,1) -0.5 ,v(:,2) -1.6, v(:,3) + 2 ...
        ,'FaceVertexCData',vertexColours,'EdgeColor','interp','EdgeLighting','flat');
    transformationMatrix = makehgtform('translate',[0,2,1.2]); % new transform
            rotationMatrix = makehgtform('xrotate',deg2rad(90)); % new rotation
            Points = [transformationMatrix * rotationMatrix * [StopButtonVerts,ones(StopButtonVertexCount,1)]']';
            StopButtonMesh_h.Vertices = Points(:,1:3); % Plots these new points

            %% Load goggles
            [f,v,data] = plyread('SafetyGoggles.ply','tri');
    % Scale the colours to be 0-to-1 (they are originally 0-to-255
    vertexColours = [data.vertex.red, data.vertex.green, data.vertex.blue] / 255;
    % Then plot the trisurf
    gogglesMesh_h = trisurf(f,v(:,1) -2.35,v(:,2) -2, v(:,3) +0.4 ...
        ,'FaceVertexCData',vertexColours,'EdgeColor','interp','EdgeLighting','flat');
    %% Load Hard Hat
     [f,v,data] = plyread('HardHat.ply','tri');
    % Scale the colours to be 0-to-1 (they are originally 0-to-255
    vertexColours = [data.vertex.red, data.vertex.green, data.vertex.blue] / 255;
    % Then plot the trisurf
    HardHatMesh_h = trisurf(f,v(:,1) -2,v(:,2) -2, v(:,3) +0.4 ...
        ,'FaceVertexCData',vertexColours,'EdgeColor','interp','EdgeLighting','flat');
%% Load floor
 
        x = [-2.5 2.5]; %plot image these coordinates on x axis 
        y = [-2.5 2.5]; %plot image with these coordinates on y axis
        z = [0 0; 0 0]; %plot image with these coordinates on z axis 
        surf(x, y, z,'CData',imread('floor2.jpg'),'FaceColor','texturemap');

%% Load Lab
 
        x = [2.5 -2.5];
        y = [2.5 2.5];
        z = [2.5 2.5; 0 0];
        surf(x, y, z,'CData',imread('bar.jfif'),'FaceColor','texturemap');
%% Load stop button
[f,v,data] = plyread('StopButton.ply','tri');

StopButtonVertexCount = size(v,1);
midPoint = sum(v)/StopButtonVertexCount;
        StopButtonVerts = v - repmat(midPoint,StopButtonVertexCount,1);
% Scale the colours to be 0-to-1 (they are originally 0-to-255
vertexColours = [data.vertex.red, data.vertex.green, data.vertex.blue] / 255;
% Then plot the trisurf
StopButtonMesh_h = trisurf(f,v(:,1) -2 ,v(:,2) -1, v(:,3)  ...
    ,'FaceVertexCData',vertexColours,'EdgeColor','interp','EdgeLighting','flat');
transformationMatrix = makehgtform('translate',[0.85,-0.35,0.7]); % new transform
        rotationMatrix = makehgtform('xrotate',deg2rad(90)); % new rotation
        Points = [transformationMatrix * rotationMatrix * [StopButtonVerts,ones(StopButtonVertexCount,1)]']';
        StopButtonMesh_h.Vertices = Points(:,1:3); % Plots these new points
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
        
%% Stop Button
[f,v,data] = plyread('StopButton.ply','tri');

StopButtonVertexCount = size(v,1);
midPoint = sum(v)/StopButtonVertexCount;
        StopButtonVerts = v - repmat(midPoint,StopButtonVertexCount,1);
% Scale the colours to be 0-to-1 (they are originally 0-to-255
vertexColours = [data.vertex.red, data.vertex.green, data.vertex.blue] / 255;
% Then plot the trisurf
StopButtonMesh_h = trisurf(f,v(:,1) -2 ,v(:,2) -1, v(:,3) + 2 ...
    ,'FaceVertexCData',vertexColours,'EdgeColor','interp','EdgeLighting','flat');
transformationMatrix = makehgtform('translate',[0.85,-0.35,0.7]); % new transform
        rotationMatrix = makehgtform('xrotate',deg2rad(90)); % new rotation
        Points = [transformationMatrix * rotationMatrix * [StopButtonVerts,ones(StopButtonVertexCount,1)]']';
        StopButtonMesh_h.Vertices = Points(:,1:3); % Plots these new points
end
end
end

