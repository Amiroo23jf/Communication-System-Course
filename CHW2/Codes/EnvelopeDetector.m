function [out] = EnvelopeDetector(x, t, r, c)
%This function finds the envelope of a signal for a given R and C
out = zeros(1, length(t));
local_peak = 0;
t_peak = 0;
for i=1:length(t)
    out_exp = local_peak * exp(-(t(i) - t_peak)/(r * c));
    if out_exp < x(i)
        local_peak = x(i);
        t_peak = t(i);
        out(i) = x(i);
    else
        out(i) = out_exp;
    end
end
