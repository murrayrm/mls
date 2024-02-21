function cost = heuristic_cost_estimate(A, ninit, ngoal, m) % m(mode) indicate which heuristic function to use
    
    if ninit == ngoal
        cost = 0;
        return;
    end
    
    set = [];
    cost = 0;
    start = ninit;
    
    % initialize set
    for i=1 : size(A, 2)
        if ~isequal(A(start, i), inf) && ~ismember(i, set)
            set = [set, i];
        end
    end
    cost = cost + 1;

    while ~ismember(ngoal, set)
        for j=1 : size(set, 2) % traverse set
            start = set(j);
            for i=1 : size(A, 2)
                if ~isequal(A(start, i), inf) && ~ismember(i, set)
                    set = [set, i];
                end
            end
        end
        cost = cost + 1;
    end
    

end