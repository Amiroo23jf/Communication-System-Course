clc
clf
clear all
close all

fs = 1e6;
pulse_length = 10e-3;
fc = 10e3;
fchannel = 10e3;
bw_channel = 1e3;

pulse_N = pulse_length*fs;
signal_length = 1000; %this parameter is the length of the message sequence
b = rand(1, signal_length) - 0.5; %the message sequence
b(b>=0) = 1;
b(b<=0) = 0;

[b1, b2] = Divide(b);
t_p = 0:1/fs:(pulse_N-1)/fs;
pulse1 = cos(2*pi*1e3*t_p);
pulse0 = cos(2*pi*1.5e3*t_p);

pulse1 = num2str(pulse1);
pulse0 = num2str(pulse0);

x1 = PulseShaping(b1, pulse0, pulse1);
x2 = PulseShaping(b2, pulse0, pulse1);
t = 0:1/fs:(length(x1)-1)/fs;

x_c = AnalogMod(x1,x2,fs,fc);
y_c = Channel(x_c, fs, fchannel, bw_channel);

%% calculations and plots
sigma_list = [1 , 2, 4, 6, 8, 20];
figure(1)
clf;
set(gcf, 'Position', [100 100 900 900]);
for i=1:length(sigma_list)
    E = sum(y_c.^2);
    SNR = 20*log10(E/sigma_list(i)^2);
    y = awgn(y_c, SNR, 20*log10(E));
    bw_message = 100;
    [y1, y2] = AnalogDemod(y, fs, fc, bw_message);
    [b10,b11,b_hat1] = MatchedFilt(y1, pulse0, pulse1);
    [b20,b21,b_hat2] = MatchedFilt(y2, pulse0, pulse1);
    b_hat = Combine(b_hat1, b_hat2);
    subplot(3,2,i)
    scatter(b11, b21);
    sigma = sigma_list(i);
    title(['\sigma = ',num2str(sigma)])
    xlabel('b_1');
    ylabel('b_2');
    grid on;
end  
saveas(gcf,'../report/pics/p3-c.png')
    