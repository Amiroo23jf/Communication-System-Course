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

%% Divide
[b1, b2] = Divide(b);
figure(1)
set(gcf, 'Position', [100 100 1200 800])
subplot(2,1,1)
stem(0:signal_length/10-1, b(1:signal_length/10), 'filled');
grid on; 
xlabel('n')
ylabel('b[n]')

subplot(2,2,3)
stem(0:signal_length/20 - 1, b1(1:signal_length/20), 'filled');
grid on; 
xlabel('n'); ylabel('b_1[n]')

subplot(2,2,4)
stem(0:signal_length/20 - 1, b2(1:signal_length/20), 'filled');
grid on; 
xlabel('n'); ylabel('b_2[n]');

saveas(gcf,'../report/pics/p1-a-1.png')
%% Pulse Shaping
pulse1 = ones(1, pulse_N);
pulse0 = -pulse1;

pulse1 = num2str(pulse1);
pulse0 = num2str(pulse0);

x1 = PulseShaping(b1, pulse0, pulse1);
x2 = PulseShaping(b2, pulse0, pulse1);
t = 0:1/fs:(length(x1)-1)/fs;

figure(2)
set(gcf, 'Position', [100 100 1200 800])
subplot(2,1,1)
plot(t(1:end/10), x1(1:end/10), 'LineWidth', 1.5)
grid on; grid minor; xlabel('t(s)'); ylabel('x_1(t)'); ylim([-1.5,1.5]);

subplot(2,1,2)
plot(t(1:end/10), x2(1:end/10), 'LineWidth', 1.5)
grid on; grid minor; xlabel('t(s)'); ylabel('x_2(t)'); ylim([-1.5,1.5]);

saveas(gcf,'../report/pics/p1-a-2.png')
%% Analog Modulation
x_c = AnalogMod(x1,x2,fs,fc);
figure(3)
set(gcf, 'Position', [100 100 1200 450])
plot(t(1:round(length(x_c)/1000)), x_c(1:round(length(x_c)/1000)), 'LineWidth', 1.5);
grid on; grid minor; xlabel('t(s)'); ylabel('x_c(t)'); ylim([-1.5,1.5]);

saveas(gcf,'../report/pics/p1-a-3.png')
%% Channel 
y = Channel(x_c, fs, fchannel, bw_channel);

figure(4)
set(gcf, 'Position', [100 100 1200 450])
plot(t(1:round(length(y)/1000)), y(1:round(length(y)/1000)), 'LineWidth', 1.5);
grid on; grid minor; xlabel('t(s)'); ylabel('y(t)'); ylim([-1.5,1.5]);

saveas(gcf,'../report/pics/p1-a-4.png')
%% Analog Demod
bw_message = 100;
[y1, y2] = AnalogDemod(y, fs, fc, bw_message);

figure(5)
set(gcf, 'Position', [100 100 1200 800])
subplot(2,1,1)
plot(t(1:end/10), y1(1:end/10), 'LineWidth', 1.5);
grid on; grid minor; xlabel('t(s)'); ylabel('y_1(t)'); ylim([-1.5,1.5]);

subplot(2,1,2)
plot(t(1:end/10), y2(1:end/10), 'LineWidth', 1.5);
grid on; grid minor; xlabel('t(s)'); ylabel('y_2(t)'); ylim([-1.5,1.5]);

saveas(gcf,'../report/pics/p1-a-5.png')
%% Matched Filter
[b10,b11,b_hat1] = MatchedFilt(y1, pulse0, pulse1);
[b20,b21,b_hat2] = MatchedFilt(y2, pulse0, pulse1);

%% Combine 
b_hat = Combine(b_hat1, b_hat2);
figure(6)
set(gcf, 'Position', [100 100 1200 800])
subplot(2,1,1)
stem(0:signal_length/10-1, b_hat(1:signal_length/10), 'filled');
grid on; 
xlabel('n')
ylabel('$$\hat{b}[n]$$','Interpreter','Latex')

subplot(2,2,3)
stem(0:signal_length/20 - 1, b_hat1(1:signal_length/20), 'filled');
grid on; 
xlabel('n'); ylabel('$$\hat{b}_1[n]$$','Interpreter','Latex')

subplot(2,2,4)
stem(0:signal_length/20 - 1, b_hat2(1:signal_length/20), 'filled');
grid on; 
xlabel('n'); ylabel('$$\hat{b}_2[n]$$','Interpreter','Latex');

saveas(gcf,'../report/pics/p1-a-6.png')
