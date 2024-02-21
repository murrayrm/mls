function points_set = arc_and_line(start,endpoint,length,type,ratio)
% turn the strokes into lines and arcs
% input start, end should be 2x1 vector and length should be double figure
% ouptput is pointsets
% type = 0 line; start point, end point and length
% type = 1 arc; start point is the same, end point is the center point, and
% length is the angle, note that postive is counterclock

% default length of line is divided into 10 points for speed
line_set = 10;% 10 points for line
arc_set = 20; %20 points for arc
start = start*ratio; %start point should be scaled
endpoint = endpoint*ratio; %end point should be scaled
if type == 0 
    points_set = zeros(line_set,3);
    points_set(:,1) = linspace(start(1),endpoint(1),line_set)';
    points_set(:,2) = linspace(start(2),endpoint(2),line_set)';
end

% default length of line is divided into 20 points for accuracy
if type == 1
    points_set = zeros(arc_set,3);
    r = norm(start-endpoint); 
    if (start(1)-endpoint(1)) == 0 % avoid vertical situation
        if (start(2) - endpoint(2)) > 0 
            theta_original = pi/2;
        else
            theta_original = -pi/2;
        end
    else
        theta_original = atan2((start(2)-endpoint(2)),(start(1)-endpoint(1)));
    end 
    theta = linspace(0,abs(length),arc_set);
    if length > 0  
        for i = 1:arc_set
            points_set(i,1) = endpoint(1)+r*(cos(theta(i)+theta_original));
            points_set(i,2) = endpoint(2)+r*(sin(theta(i)+theta_original));
        end
    else
        for i = 1:arc_set
            points_set(i,1) = endpoint(1)+r*(cos(-theta(i)+theta_original));
            points_set(i,2) = endpoint(2)+r*(sin(-theta(i)+theta_original));
        end
    end
end

end