clc
clf
clear all
close all
%% Part 1
% Sampling
fs = 10e3;
t = 0:1/fs:1;
m = cos(5 * pi * t) + sin(8 * pi * t);
m_max = max(m);
m_norm = m / m_max;

% Creating x_c
A_c = 1;
mu = 0.8;
fc = 1000;
x_c = A_c * (1 + mu * m_norm) .* cos(2 * pi * fc * t);

%% Part 2
% the desired function is written in file EnvelopeDetector.m in the same
% directory as this code. This function gets 'x', 't', 'r' and 'c' as the 
% inputs and returns the envelope of signal, 'out' as the output.

%% Part 3
r = 1e3;
c = 4.2e-5;
x_env = EnvelopeDetector(x_c, t, r, c);
m_detected = (x_env/A_c - 1)/mu;

%% Part 4
% Plotting m(t), x_c(t), x_env(t), m_detected(t)
figure(1)
subplot(2,2,1)
plot(t, m, 'LineWidth', 1.5)
title('m(t) vs t')
xlabel('t')
ylabel('Amplitude')
grid on

subplot(2,2,2)
plot(t, x_c)
title('x_c(t) vs t')
xlabel('t')
ylabel('Amplitude')
grid on

subplot(2,2,3)
plot(t, x_env)
title('Envelope vs t')
xlabel('t')
ylabel('Amplitude')
grid on

subplot(2,2,4)
plot(t, m_detected)
title('Detected Message vs t')
xlabel('t')
ylabel('Amplitude')
grid on

saveas(gcf,'../pics/q1-1.png')

figure(2)
plot(t, x_c, 'Color', [57 106 177]./255)
hold on
plot(t, m, 'LineWidth', 1.5, 'Color', [62 150 81]./255)
plot(t, x_env, 'LineWidth', 1.5, 'Color', 'r')
plot(t, m_detected, 'LineWidth', 1.5, 'Color', [107 76 154]./255)
legend('Transmitted', 'Message', 'Envelope', 'Detected')
title('Intended Signals vs Time')
xlabel('Time')
ylabel('Amplitude')
grid on

saveas(gcf,'../pics/q1-2.png')


figure(3) 
plot(t, m_detected * m_max, 'LineWidth', 1.5, 'Color', 'red')
hold on
plot(t, m, 'LineWidth', 1.5, 'Color', [57 106 177]./255)
legend('Unnormalized Detected','Message')
xlabel('Time')
ylabel('Amplitude')
grid on
saveas(gcf,'../pics/q1-3.png')

