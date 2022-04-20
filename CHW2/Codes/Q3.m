clc
clf
clear all
close all
%% Part 1
% Sampling the signal
fs = 10000;
t = 0:1/fs:1;
m = sin(25 * pi * t);
% FM Modulation 
A_c = 1;
fc = 200;
fd = 30;
x_c = A_c * fmmod(m, fc, fs, fd, 0);
% Demodulation using the first method
m_demod1 = fmdemod((x_c/A_c), fc, fs, fd, 0);

%% Part 2
% Differentiation of x_c
x_d(2:fs+1) = (x_c(2:fs+1) - x_c(1:fs))*fs; 
x_d(1) = x_d(2);
% Detecting the envelope
r = 1e3;
c = 9e-5;
x_envelope = EnvelopeDetector(x_d, t, r, c);
m_demod2 = ((x_envelope/(2*pi*A_c)) - fc)/fd;

%% Part 3
x_sign = sign(x_c);

% Differentiation of Sign
x_zero(2:fs+1) = (x_sign(2:fs+1) - x_sign(1:fs))*fs;

% Generating Pulse
x_pulse = zeros(1, length(t));
for i=1:length(t)-1
    if(x_zero(i) ~= 0)
        x_pulse(i) = 1;
        x_pulse(i+1) = 1;
    end
end

x_lowpass = lowpass(x_pulse, 30, fs, 'Steepness', 0.99);
x_dc_blocked = x_lowpass - mean(x_lowpass);
m_demod3 = x_dc_blocked / max(x_dc_blocked);
%% Part 4
figure(1)
set(gcf, 'Position', [100,100,700,500])
plot( t, m, t, m_demod1, t, m_demod2, t, m_demod3, 'LineWidth', 1.5)
ylim([-1.5 1.5])
legend('Message', 'First Method', 'Second Method', 'Third Method')
grid on
xlabel('Time')
ylabel('Amplitude')

saveas(gcf, '../pics/q3-1.png')