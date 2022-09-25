function [out] = SourceDecoder(in)
i=1;
out = [];
while i<=length(in)
    if(in(i) == 1)
        out = [out, 'a'];
        i = i + 1;
    elseif(in(i+1)==1)
        out = [out, 'b'];
        i = i + 2;
    elseif(in(i+2)==1)
        out = [out, 'c'];
        i = i + 3;
    elseif(in(i+3)==1)
        out = [out, 'd'];
        i = i + 4;
    elseif(in(i+4)==1)
        out = [out, 'e'];
        i = i + 5;
    else
        out = [out, 'f'];
        i = i + 5;
    end
end

