function [out0, out1, estimated] = MatchedFilt(in, pulse0, pulse1)
pulse0 = str2num(pulse0);
pulse1 = str2num(pulse1);
matched0 = flip(pulse0);
matched1 = flip(pulse1);
out0 = conv(in, matched0, 'same');
out1 = conv(in, matched1, 'same');
pulse_len = length(pulse1);
k = round(pulse_len/2):pulse_len:length(out1);
check = out1>out0;
out1 = out1(k);
out0 = out0(k);
out1 = out1 / max(abs(out1));
out0 = out0 / max(abs(out0));
estimated = check(k);
end


