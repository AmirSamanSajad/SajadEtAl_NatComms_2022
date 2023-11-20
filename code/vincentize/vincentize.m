function [Voutput, meanA_binned, Idx] = vincentize(Ainput, nBins, col)
% A should already be sorted if you want correct vincentization! 
if nargin<3
    col = 1;
end

if istable(Ainput)
    A = table2array(Ainput);
    tname = Ainput.Properties.VariableNames;
else
    A = Ainput;
end
range = 1:size(A,1);
[A_sorted idx_sorted] = sortrows(A,col);
rangeBounds = linspace(range(1)-1, range(end) ,nBins+1);
for bin = 1:nBins
    binRange_start = floor(rangeBounds(bin))+1;
    binRange_end = floor(rangeBounds(bin+1));
    V{bin} = A_sorted(binRange_start:binRange_end, :);
    if istable(Ainput)
    Voutput{bin} = array2table(V{bin}, 'VariableNames', tname);
    else
        Voutput{bin} = V{bin};
    end
    Idx{bin} = idx_sorted(binRange_start:binRange_end, :);
    meanA_binned(bin,:) = mean(V{bin},1);
end

    
    
%%