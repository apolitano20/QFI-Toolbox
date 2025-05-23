%%  UNIQUE_PERMS    Computes the unique permutations of a vector
%   This function has one required argument:
%     V: a vector
%
%   permList = uniquePerms(V) is list of unique permutations of a vector.
%   
%   This function does the same thing as unique(perms(v),'rows'), but is 
%   much faster and less memory-intensive in most cases.
%
%   URL: http://www.qetlab.com/unique_perms
 
%   requires: nothing
%   author: John D'Errico
%	package: QFIEntanglementToolbox.utils (Inspired by QETLAB)
 
function permList = uniquePerms( v )
 
uniqueV = unique(v);
n = length(v);
numUnique = length(uniqueV);
 
if numUnique <= 1
    permList = v;
elseif n == numUnique
    permList = perms(v);
else
    permList = cell(numUnique,1);
    for j = 1:numUnique
        vTemp = v;
        vTemp(find(vTemp==uniqueV(j),1)) = [];
        t = uniquePerms(vTemp);
        permList{j} = [repmat(uniqueV(j),size(t,1),1),t];
    end
    permList = cell2mat(permList);
end
 
end
