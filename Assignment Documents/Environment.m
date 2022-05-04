%Environment class

%% Plot environment 
classdef Environment < handle
    properties
      
     
        workspace = [-5 5 -5 5 0 5];  %workspace area 
        
       
          
    end

methods

function PuttingSimulatedObjectsIntoTheEnvironment(base)
% Turn on a light (only turn on 1, don't keep turning them on), and make axis equal
 camlight;
 axis equal;
 view(3);
 hold on;




% clf
%% Load the table downloaded from http://tf3dm.com/3d-model/wooden-table-49763.html vertex colours added with Blender
[f,v,data] = plyread('table.ply','tri');
% Scale the colours to be 0-to-1 (they are originally 0-to-255
vertexColours = [data.vertex.red, data.vertex.green, data.vertex.blue] / 255;
% Then plot the trisurf
tableMesh_h = trisurf(f,v(:,1),v(:,2), v(:,3) + 0.6...
    ,'FaceVertexCData',vertexColours,'EdgeColor','interp','EdgeLighting','flat');

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
%% Brick from blender
% After saving in blender then load the triangle mesh
[f,v,data] = plyread('Brick.ply','tri');
% Get vertex count
BrickVertexCount = size(v,1);
% Move center point to origin
midPoint = sum(v)/BrickVertexCount;
BrickVerts = v - repmat(midPoint,BrickVertexCount,1);
% Create a transform to describe the location (at the origin, since it's centered
BrickPose = eye(4);
% Scale the colours to be 0-to-1 (they are originally 0-to-255
vertexColours = [data.vertex.red, data.vertex.green, data.vertex.blue] / 255;
% Then plot the trisurf
BrickMesh_h = trisurf(f,BrickVerts(:,1) +0.5,BrickVerts(:,2) +0.2,BrickVerts(:,3) + 0.7 ...
    ,'FaceVertexCData',vertexColours,'EdgeColor','interp','EdgeLighting','flat');
%% Load fence from blender w/ rotations
[f,v,data] = plyread('Barricade.ply','tri');
BarricadeVertexCount = size(v,1);
midPoint = sum(v)/BarricadeVertexCount;
        BarricadeVerts = v - repmat(midPoint,BarricadeVertexCount,1);
% Scale the colours to be 0-to-1 (they are originally 0-to-255
vertexColours = [data.vertex.red, data.vertex.green, data.vertex.blue] / 255;
% Then plot the trisurf
BarricadeMesh_h = trisurf(f,v(:,1) -0.5 ,v(:,2) -1.6 , v(:,3) +2 ...
    ,'FaceVertexCData',vertexColours,'EdgeColor','interp','EdgeLighting','flat');
transformationMatrix = makehgtform('translate',[0,2,1.2]); %new transformation
        rotationMatrix = makehgtform('xrotate',deg2rad(90)); %new rotation 
        Points = [rotationMatrix * transformationMatrix [BarricadeVerts,ones(BarricadeVertexCount,1)]']'; %plot new points
        BarricadeMesh_h.Vertices = Points(:,1:3); %assign new points to vertices
%% Load Killswitch
[f,v,data] = plyread('StopButton.ply','tri');

StopButtonVertexCount = size(v,1);
midPoint = sum(v)/StopButtonVertexCount;
        StopButtonVerts = v - repmat(midPoint,StopButtonVertexCount,1);
% Scale the colours to be 0-to-1 (they are originally 0-to-255
vertexColours = [data.vertex.red, data.vertex.green, data.vertex.blue] / 255;
% Then plot the trisurf
StopButtonMesh_h = trisurf(f,v(:,1) +1 ,v(:,2) -1, v(:,3) + 1 ...
    ,'FaceVertexCData',vertexColours,'EdgeColor','interp','EdgeLighting','flat');
transformationMatrix = makehgtform('translate',[0.85,-0.35,0.7]); % new transform
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
 
        x = [-5 5]; %plot image these coordinates on x axis 
        y = [-5 5]; %plot image with these coordinates on y axis
        z = [0 0; 0 0]; %plot image with these coordinates on z axis 
        surf(x, y, z,'CData',imread('floor.jpg'),'FaceColor','texturemap');

%% Load Lab
 
        x = [5 -5];
        y = [5 5];
        z = [5 5; 0 0];
        surf(x, y, z,'CData',imread('Lab.jpg'),'FaceColor','texturemap');
       

end
end
end
