function [out] = OutputDecoder(in)
out = zeros(1, length(in)/8);
for i=1:length(out)
    bi = zeros(1, 8);
    for j=1:8
        bi(j) = in(8*(i-1) + j);
    end
    num = bi2de(bi);
    out(i) = num;
end
end

