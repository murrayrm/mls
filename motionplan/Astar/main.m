clc; clear;

% same graph in the slide
G = [0     3     0     0     0     2     0     0     4     0     0     0     0     0     0
     3     0     1     0     0     1     0     4     0     0     0     0     0     0     0
     0     1     0     3     0     0     0     0     0     0     0     0     0     0     0
     0     0     3     0     2     0     0     1     0     0     0     2     0     0     0
     0     0     0     2     0     0     0     0     0     0     0     8     0     0     3
     2     1     0     0     0     0     1     0     1     0     0     0     0     0     0
     0     0     0     0     0     1     0     3     0     1     1     0     0     0     0
     0     4     0     1     0     0     3     0     0     0     4     0     0     0     0
     4     0     0     0     0     1     0     0     0     3     0     0     5     0     0
     0     0     0     0     0     0     1     0     3     0     2     0     0     0     0
     0     0     0     0     0     0     1     4     0     2     0     1     3     0     0
     0     0     0     2     8     0     0     0     0     0     1     0     0     4     2
     0     0     0     0     0     0     0     0     5     0     3     0     0     6     0
     0     0     0     0     0     0     0     0     0     0     0     4     6     0     0
     0     0     0     0     3     0     0     0     0     0     0     2     0     0     0];

% input start and destination node
dest = 14; start = 2;


[dist, prev] = astar(G, start, dest);
route = [dest];
cost = dist(dest);

while ~isnan(prev(dest))
    route = [route, prev(dest)];
    dest = prev(dest);
end

disp("the shortest route is: ");
disp(route);