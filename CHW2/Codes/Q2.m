clc
clf
clear all
close all
%% Part 1
fs = 10000;
t = 0:1/fs:9;
x1 = (cos(10*pi*t) + sin(12*pi*t));
x1(t>=3) = 0;

x2 = (cos(14*pi*t) + sin(8*pi*t));
x2(t<3) = 0;
x2(t>=6) = 0;

x3 = (cos(5*pi*t) + sin(15*pi*t));
x3(t<6) = 0;
x3(t>=9) = 0;

figure(1)
plot(t, x1, t, x2, t, x3, 'LineWidth', 1.5)
title('Signals vs Time')
legend('x_1','x_2','x_3')
xlabel('Time')
ylabel('Amplitude')
grid on

%% Part 2
fc = [500, 650, 800];
x1_ussb = ssbmod(x1, fc(1), fs, 0, 'upper');
x2_ussb = ssbmod(x2, fc(2), fs, 0, 'upper');
x3_ussb = ssbmod(x3, fc(3), fs, 0, 'upper');

x_trans = x1_ussb + x2_ussb + x3_ussb;

%% Part 3
% Plotting the requested signals
figure(2)
set(gcf, 'Position', [100, 100, 1100, 800])
subplot(3,1,1)
plot(t, x1, t, x2, t, x3, 'LineWidth', 1.5)
legend('x_1', 'x_2', 'x_3')
xlabel('Time')
ylabel('Amplitude')
grid on

subplot(3,1,2)
plot(t, x1_ussb, t, x2_ussb, t, x3_ussb, 'LineWidth', 1.5)
legend('x_1(ussb)', 'x_2(ussb)', 'x_3(ussb)')
xlabel('Time')
ylabel('Amplitude')
grid on

subplot(3,1,3)
plot(t, x_trans, 'LineWidth', 1.5)
legend('x_{transmitted}')
xlabel('Time')
ylabel('Amplitude')
grid on

saveas(gcf, '../pics/q2-1.png')
%% Part 4
x1_fft = abs(fftshift(fft(x1)));
x2_fft = abs(fftshift(fft(x2)));
x3_fft = abs(fftshift(fft(x3)));
x1_ussb_fft = abs(fftshift(fft(x1_ussb)));
x2_ussb_fft = abs(fftshift(fft(x2_ussb)));
x3_ussb_fft = abs(fftshift(fft(x3_ussb)));
x_trans_fft = abs(fftshift(fft(x_trans)));

f = fs/2 * linspace(-1, 1, length(t));

figure(3)
set(gcf, 'Position', [100, 100, 1100, 800])
subplot(3,1,1)
plot(f, x1_fft, f, x2_fft, f, x3_fft, 'LineWidth', 1.5);
xlim([-100 100])
xlabel('Frequency')
ylabel('Amplitude')
legend('X_1', 'X_2', 'X_3')
grid on

subplot(3,1,2)
plot(f, x1_ussb_fft, f, x2_ussb_fft, f, x3_ussb_fft, 'LineWidth', 1.5);
xlim([-1000 1000])
xlabel('Frequency')
ylabel('Amplitude')
legend('X_1(USSB)', 'X_2(USSB)', 'X_3(USSB)')
grid on

subplot(3,1,3)
plot(f, x_trans_fft, 'LineWidth', 1.5)
xlim([-1000 1000])
xlabel('Frequency')
ylabel('Amplitude')
legend('X_{Transmitted}')
grid on

saveas(gcf, '../pics/q2-2.png')

%% Part 4
SNR = 5;
noise = randn(size(t)) * std(x_trans)/db2mag(SNR);
x_channel = x_trans + noise;
% Filtering
x_filtered = bandpass(x_channel, [480 820], fs);
% FFT of The Signals
x_channel_fft = abs(fftshift(fft(x_channel)));
x_filtered_fft = abs(fftshift(fft(x_filtered)));

% Plotting 
figure(4)
set(gcf, 'Position', [100, 100, 1100, 800])
plot(f, x_channel_fft, f, x_filtered_fft, 'LineWidth', 1.5)
xlim([-1000 1000])
xlabel('Frequency')
ylabel('Amplitude')
legend('Recieved', 'Filtered')
grid on

saveas(gcf, '../pics/q2-3.png')

%% Part 5
x1_ussb_recieved = bandpass(x_filtered, [480 520], fs);
x2_ussb_recieved = bandpass(x_filtered, [630 670], fs);
x3_ussb_recieved = bandpass(x_filtered, [780 820], fs);

x1_demod = ssbdemod(x1_ussb_recieved, fc(1), fs);
x2_demod = ssbdemod(x2_ussb_recieved, fc(2), fs);
x3_demod = ssbdemod(x3_ussb_recieved, fc(3), fs);

figure(5)
set(gcf, 'Position', [100, 100, 1100, 800])
plot(t, x1, t, x2, t, x3, t, x1_demod, t, x2_demod, t, x3_demod, ...
    'LineWidth', 1.5)
xlabel('Time')
ylabel('Amplitude')
legend('x_1', 'x_2', 'x_3', 'x_1(demod)', 'x_2(demod)', 'x_3(demod)')
grid on

saveas(gcf, '../pics/q2-4-1.png')

figure(6)
set(gcf, 'Position', [100, 100, 1100, 800])
subplot(2,1,1)
plot(t, x1, t, x2, t, x3, 'LineWidth', 1.5)
xlabel('Time')
ylabel('Amplitude')
legend('x_1', 'x_2', 'x_3')
grid on

subplot(2,1,2)
plot(t, x1_demod, t, x2_demod, t, x3_demod, 'LineWidth', 1.5)
xlabel('Time')
ylabel('Amplitude')
legend('x_1(demod)', 'x_2(demod', 'x_3(demod)')
grid on

saveas(gcf, '../pics/q2-4-2.png')