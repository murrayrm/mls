function node = mincostnode(tot_cost, O)
    
    node = -1;
    cost = inf;
    for i = 1: size(O,2)
        if cost > tot_cost(O(i))
            cost = tot_cost(O(i));
            node = O(i);
        end
    end
    
end