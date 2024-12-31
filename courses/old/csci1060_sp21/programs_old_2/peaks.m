function [ values, indices ] = peaks( v )

maxSoFar = v(1);
values = [ v(1) ];
indices = [ 1 ];

for i = 2:length(v)
    if v(i) > maxSoFar
       maxSoFar = v(i);
       values = [ values v(i) ];
       indices = [ indices i ];
    end
end

end
