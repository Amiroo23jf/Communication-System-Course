function [out] = InformationSource(n)
x = randi(32, [1, n]);
out = repmat('a', 1, n);
out(x<=16) = 'a';
out((x>16) & (x<=24)) = 'b';
out((x>24) & (x<=28)) = 'c';
out((x>28) & (x<=30)) = 'd';
out(x==31) = 'e';
out(x==32) = 'f';
end

