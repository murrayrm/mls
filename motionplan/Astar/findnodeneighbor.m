function vi = findnodeneighbor(A,C)
    numNode = size(A,1);
    vi = [];
    for i=1 : numNode
        if A(C, i) ~= inf
            vi = [vi, i];
        end
    end
end