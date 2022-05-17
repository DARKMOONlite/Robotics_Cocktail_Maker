%% CheckIntersections
% Check each of the cone end rays for intersection with a UFO
function ufoHitIndex = CheckIntersections(endEffectorTr,coneEnds,ufoFleet)
ufoHitIndex = [];
for rayIndex = 1:size(coneEnds,1)
    for ufoIndex = 1:size(ufoFleet.model,2)
        % Ray from this part of the cone
        rayStart = endEffectorTr(1:3,4)';
        rayEnd = coneEnds(rayIndex,:);
        
        % Disk representing the UFO
        ufoPoint = ufoFleet.model{ufoIndex}.base(1:3,4)';
        ufoNormal = ufoFleet.model{ufoIndex}.base(3,1:3);

        % Check intersection of the line with the plane.
        [intersectionPoint,check] = LinePlaneIntersection(ufoNormal,ufoPoint,rayStart,rayEnd);
        % Check for an intersection which is also close to the ufoCenter
        if check ~= 1 || ufoFleet.shipRadius < DistanceBetweenTwoPoints(intersectionPoint,ufoPoint) 
            continue;
        end
        ufoHitIndex = [ufoHitIndex,ufoIndex];          %#ok<AGROW>
    end
end
end

%% LinePlaneIntersection
% Given a plane (normal and point) and two points that make up another line, get the intersection
% Check == 0 if there is no intersection
% Check == 1 if there is a line plane intersection between the two points
% Check == 2 if the segment lies in the plane (always intersecting)
% Check == 3 if there is intersection point which lies outside line segment
function [intersectionPoint,check] = LinePlaneIntersection(planeNormal,pointOnPlane,point1OnLine,point2OnLine)

intersectionPoint = [0 0 0];
u = point2OnLine - point1OnLine;
w = point1OnLine - pointOnPlane;
D = dot(planeNormal,u);
N = -dot(planeNormal,w);
check = 0; %#ok<NASGU>
if abs(D) < 10^-7        % The segment is parallel to plane
    if N == 0           % The segment lies in plane
        check = 2;
        return
    else
        check = 0;       %no intersection
        return
    end
end

%compute the intersection parameter
sI = N / D;
intersectionPoint = point1OnLine + sI.*u;

if (sI < 0 || sI > 1)
    check= 3;          %The intersection point  lies outside the segment, so there is no intersection
else
    check=1;
end
end

%% DistanceBetweenTwoPoints
%
% *Description:*  Function for find the distance between 2 or the same number of 3D points

%% Function Call
% 
% *Inputs:* 
%
% _pt1_ (many*(2||3||6) double) x,y || x,y,z cartesian point ||Q Joint angle
%
% _pt2_ (many*(2||3||6) double) x,y || x,y,z cartesian point ||Q Joint angle
%
% *Returns:* 
%
% _dist_ (double) distance from pt1 to pt2

function dist=DistanceBetweenTwoPoints(pt1,pt2)

%% Calculate distance (dist) between consecutive points
% If 2D
if size(pt1,2) == 2
    dist=sqrt((pt1(:,1)-pt2(:,1)).^2+...
              (pt1(:,2)-pt2(:,2)).^2);
% If 3D          
elseif size(pt1,2) == 3
    dist=sqrt((pt1(:,1)-pt2(:,1)).^2+...
              (pt1(:,2)-pt2(:,2)).^2+...
              (pt1(:,3)-pt2(:,3)).^2);
% If 6D like two poses
elseif size(pt1,2) == 6
    dist=sqrt((pt1(:,1)-pt2(:,1)).^2+...
              (pt1(:,2)-pt2(:,2)).^2+...
              (pt1(:,3)-pt2(:,3)).^2+...
              (pt1(:,4)-pt2(:,4)).^2+...
              (pt1(:,5)-pt2(:,5)).^2+...
              (pt1(:,6)-pt2(:,6)).^2);
end
end

