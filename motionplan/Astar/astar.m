%---------------------------------------------------
% A* Algorithm
% author : Steve Liu
%
% usage
% [cost route] = astar(Graph, source, destination)
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

% [e, L] = astar(G, 2, 14)
%
%---------------------------------------------------
function [dist, prev] = astar(A,s,d)

    numNode = size(A, 1);
    A = setupgraph(A, inf, 1); % Adjacency matrix change 0 -> inf

    % initialize values of distance and heuristic cost
    dist = inf * ones(1, numNode); % g(n)
    tot_cost = inf * ones(1, numNode); % f(n)
    prev = nan * ones(1, numNode);
    % initialize ninit
    dist(s) = 0;
    tot_cost(s) = heuristic_cost_estimate(A, s, d, 1);
    
    O = [s]; % node going to visit
    C = []; % node visited
    
    while ~isempty(O)

        active_node = mincostnode(tot_cost, O);
        if ismember(d, O) % is active node == destination, then end
            break;
        end

        C = [C, active_node]; % add to visited list (close set)
        O(find(O == active_node)) = []; % remove from open set
        vi = findnodeneighbor(A, active_node);
        
        for i=1 : size(vi, 2) % loop the neighbor nodes
            if ismember(vi(i), C)
                continue;
            end
            
            g_temp = dist(active_node) + A(active_node, vi(i));

            if ~ismember(vi(i), O)
                O = [O, vi(i)];
            elseif g_temp >= dist(vi(i))
                continue
            end
            prev(vi(i)) = active_node;
            dist(vi(i)) = g_temp;
            tot_cost(vi(i)) = dist(vi(i)) + heuristic_cost_estimate(A, vi(i), d, 1);
        end   
    end

end
