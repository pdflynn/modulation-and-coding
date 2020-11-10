clear;clc;

Fs = 1000e3; % sampling frequency
dt = 1/Fs; % sampling period
stop_time = 3e-3; % 3 ms
x = 0:dt:stop_time; % approximate continuous time
N = size(x, 1);

% Message - create some Fourier-series thing consisting of three sinusoids
message_frequency_1 = 900;
message_frequency_2 = 1400;
message_frequency_3 = 1900;
M = 0.25; % Amplitude of modulation
data_to_transmit = M.*cos(2 .* pi .* message_frequency_1 .* x) + ...
    (0.3.*M).*cos(2 .* pi .* message_frequency_2 .* x) + ...
    (0.2.*M).*cos(2 .* pi .* message_frequency_3 .* x);

% Carrier wave
carrier_frequency = 10e3;
amplitude = 1;
c = @(t) amplitude .* sin(2 .* pi .* carrier_frequency .* t);

% The amplitude-modulated signal
y = @(t) (1 + (data_to_transmit ./ amplitude)) .* c(t);

% Calculate the carrier waveform and the AM signal
carrier_waveform = c(x);
amplitude_modulated_signal = y(x);

% Display the time-domain of message, carrier, and AM signal
figure
plot(x, data_to_transmit, ".b");
title("Signal");
xlabel("t (sec)");
ylabel("m(t)");
hold on
plot(x, carrier_waveform, ".g");
plot(x, amplitude_modulated_signal, ".r");
legend("Message", "Carrier", "AM Signal");

% Reconstruct the original signal m(t)
