function [out] = SourceGenerator(in)
out = zeros(1, length(in)*8);
for i=1:length(in)
    num = in(i);
    bi = de2bi(num,8);
    for j=1:8
        out(8*(i-1)+j) = bi(j);
    end
end
end

