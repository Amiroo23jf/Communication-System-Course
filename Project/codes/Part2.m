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
source_seq = randi(256,[1 signal_length]) - 1;
b = SourceGenerator(source_seq);

[b1, b2] = Divide(b);
pulse1 = ones(1, pulse_N);
pulse0 = -pulse1;

pulse1 = num2str(pulse1);
pulse0 = num2str(pulse0);

x1 = PulseShaping(b1, pulse0, pulse1);
x2 = PulseShaping(b2, pulse0, pulse1);
t = 0:1/fs:(length(x1)-1)/fs;

x_c = AnalogMod(x1,x2,fs,fc);
y_c = Channel(x_c, fs, fchannel, bw_channel);

%% Part 2
% calculations
bw_message = 100;
sigma_list = 0:2:40;
var_list = zeros(1, length(sigma_list));
for i=1:length(sigma_list)
    E = sum(y_c.^2);
    SNR = 20*log10(E/sigma_list(i)^2);
    y = awgn(y_c, SNR, 20*log10(E));
    [y1, y2] = AnalogDemod(y, fs, fc, bw_message);
    [b10,b11,b_hat1] = MatchedFilt(y1, pulse0, pulse1);
    [b20,b21,b_hat2] = MatchedFilt(y2, pulse0, pulse1);
    b_hat = Combine(b_hat1, b_hat2);
    recieve_seq = OutputDecoder(b_hat);
    var_list(i) = mean((source_seq - recieve_seq).^2);
end

%% Plotting
figure(1)
clf
set(gcf, 'Position', [100 100 800 500])
plot(sigma_list.^2, var_list, 'LineWidth', 1.5);
grid on; grid minor;
xlabel('$$\sigma^2_n$$','Interpreter', 'Latex')
ylabel('$$\sigma^2_{error}$$','Interpreter', 'Latex')
title('Error Variance vs Noise Variance')

saveas(gcf,'../report/pics/p4-2.png')

%% Part 3
bw_message = 100;
sigma_list = [1, 2, 8, 16, 32, 40];
figure(2)
clf;
set(gcf, 'Position', [100 100 900 900]);
for i=1:length(sigma_list)
    E = sum(y_c.^2);
    SNR = 20*log10(E/sigma_list(i)^2);
    y = awgn(y_c, SNR, 20*log10(E));
    [y1, y2] = AnalogDemod(y, fs, fc, bw_message);
    [b10,b11,b_hat1] = MatchedFilt(y1, pulse0, pulse1);
    [b20,b21,b_hat2] = MatchedFilt(y2, pulse0, pulse1);
    b_hat = Combine(b_hat1, b_hat2);
    recieve_seq = OutputDecoder(b_hat);
    error = source_seq - recieve_seq;
    subplot(3,2,i)
    histogram(error, 'Normalization','probability', 'BinEdges', -255:30:255);
    ylabel('Error Probability'); xlabel('Error');
    title('Error Probability Distribution');
    disp(['iteration ',num2str(i), ' completed']);
end
saveas(gcf,'../report/pics/p4-3.png')


