function index = mindistnode(dist, U)
    [~, indexlist] = sort(dist);
    for i = 1: size(indexlist,1)
        if U(indexlist(i)) == indexlist(i)
            index = indexlist(i);
            return;
        end
    end
    index = -1;
end
