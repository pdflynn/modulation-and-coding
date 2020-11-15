clear;clc;

%% Constants & Time Vector
fs = 2e6; % Sampling frequency
fb = 10e3; % Baseband Frequency
fc = 100e3; % Carrier Frequency
t = (0:1/fs:3e-4); % Time vector
fDev = 75e3; % Deviation frequency for FM modulation
figure

%% Compute & Plot the Message Signal
x=0.35.*sin(2.*pi.*fb.*t) + 0.2.*cos(4.*pi.*fb.*t) + 0.1.*cos(6.*pi.*fb.*t);
subplot(3, 1, 1);
plot(t, x, 'b', 'LineWidth', 2);
title('Original Signal');
xlabel('t (s)');
ylim([(min(x)-.5) (max(x)+.5)]);

%% Compute & Plot the FM Signal
y = fmmod(x, fc, fs, fDev);
subplot(3, 1, 2);
plot(t, y, 'r', 'LineWidth', 2);
title('Frequency Modulated Signal');
xlabel('t (s)');
ylim([(min(y)-.5) (max(y)+.5)]);

%% Demodulate & Plot Original Signal
orig = fmdemod(y, fc, fs, fDev);
subplot(3, 1, 3);
plot(t, orig, 'g', 'LineWidth', 2);
title('Demodulated Signal');
ylim([(min(orig)-.5) (max(orig)+.5)]);
xlabel('t (s)');