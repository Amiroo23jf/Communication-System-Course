function [out] = SourceEncoder(n, in)
out = [];
for i=1:n
    symbol = in(i);
    if(symbol=='a')
        out = [out,1];
    elseif(symbol=='b')
        out = [out,0,1];
    elseif(symbol=='c')
        out = [out,0,0,1];
    elseif(symbol=='d')
        out = [out,0,0,0,1];
    elseif(symbol=='e')
        out = [out,0,0,0,0,1];
    elseif(symbol=='f')
        out = [out,0,0,0,0,0];
    end   
end
end

