%---------------------------------------------------
% Dijkstra Algorithm
% author : Steve Liu
%
% usage
% [dist, prev] = dijkstra(AdjacencyMatrix, source, destination)
% 
% same example in slide
% G = [
%      0     3     0     0     0     2     0     0     4     0     0     0     0     0     0
%      3     0     1     0     0     1     0     4     0     0     0     0     0     0     0
%      0     1     0     3     0     0     0     0     0     0     0     0     0     0     0
%      0     0     3     0     2     0     0     1     0     0     0     2     0     0     0
%      0     0     0     2     0     0     0     0     0     0     0     8     0     0     3
%      2     1     0     0     0     0     1     0     1     0     0     0     0     0     0
%      0     0     0     0     0     1     0     3     0     1     1     0     0     0     0
%      0     4     0     1     0     0     3     0     0     0     4     0     0     0     0
%      4     0     0     0     0     1     0     0     0     3     0     0     5     0     0
%      0     0     0     0     0     0     1     0     3     0     2     0     0     0     0
%      0     0     0     0     0     0     1     4     0     2     0     1     3     0     0
%      0     0     0     2     8     0     0     0     0     0     1     0     0     4     2
%      0     0     0     0     0     0     0     0     5     0     3     0     0     6     0
%      0     0     0     0     0     0     0     0     0     0     0     4     6     0     0
%      0     0     0     0     3     0     0     0     0     0     0     2     0     0     0
%      ];
%
% [dist, prev] = dijkstra(G, 1, 12)
%---------------------------------------------------

function [dist, prev] = dijkstra(A, s, d)

A = setupgraph(A,inf,1); % change adjacency matrix 0 -> inf 

% Number of vertices in the graph
numNode = size(A, 1);

% Initialize all distances as infinite and previous vertices as undefined
dist = inf(numNode, 1);
prev = nan(numNode, 1);
% Distance from source to itself is zero
dist(s) = 0;
% Initialize the priority queue with all vertices
U = 1:numNode;

while ismember(d, U) % Judge if dist node in the queue U
    C = mindistnode(dist, U); % only in unvisited node
    U(C) = -1;
    
    % Find the neighbor of C, vi(index) of the node
    vi = findnodeneighbor(A, C);
    % For each neighbor v of C
    for j=1:size(vi,2)
        alt = dist(C) + A(C, vi(j)); % Dist between C and vi(j)
        if alt < dist(vi(j))
            dist(vi(j)) = alt;
            prev(vi(j)) = C;
        end
    end
end
end
