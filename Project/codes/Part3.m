clc
clf
clear all
close all
%% Sim
src = InformationSource(10);
display(['Source sequence is:', src]);
enc = SourceEncoder(10, src);
figure(1)
stem(1:length(enc), enc, 'filled');
xlabel('n')
ylabel('bit')
grid on;
saveas(gcf,'../report/pics/p5-1.png')
dec = SourceDecoder(enc);
display(['Decoded sequence is:', dec])
%% Hn vs n
N = 500;
h_list = zeros(1,N);
for n=1:N
    src = InformationSource(n);
    enc = SourceEncoder(n, src);
    l_b = length(enc);
    h_n = l_b/n;
    h_list(n) = h_n;
end
figure(2)
clf
set(gcf, 'Position', [100 100 800 500])
plot(1:N, h_list,'LineWidth', 1.5);
xlabel('n'); ylabel('H_n(X)');
title('H_n(X) vs n');
grid on; grid minor;
saveas(gcf,'../report/pics/p5-2.png')