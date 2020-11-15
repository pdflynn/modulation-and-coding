clear;clc;

%% Message, Constants, Etc
message_str = '0101011001010110';
fs = 2e6;
fc = 100e3;
ts = 1/fs;
t = (0:ts:5e-4); % Time vector
message = [];
for i=1:length(message_str)
    for j=1:round(length(t) ./ length(message_str))
        message = [message str2num(message_str(i))];
    end
end
t = t(1:end-1);
figure

%% Plot Original Binary Signal
subplot(3, 1, 1);
plot(message, 'LineWidth', 1.2);
ylim([0 1.1])
xlim([1 length(message)+1]);
xlabel("Bit Number");
set(gca, 'xtick', []);
title("Message");

%% Plot Carrier
subplot(3, 1, 2);
y_c = 0.25.*cos(2.*pi.*fc.*t);
samples_per_bit = length(y_c) ./ length(message);
plot(t, y_c);
xlim([0 t(end)]);
ylim([-1.5 1.5]);
title("Carrier");
xlabel('Time');

%% Compute & Plot ASK Signal
subplot(3, 1, 3);
y = zeros(1, length(y_c));
for i=1:length(y)
    if message(i) > 0
        y(i) = message(i).*y_c(i).*4;
    else
        y(i) = y_c(i);
    end
end
plot(t, y);
xlim([0 t(end)]);
ylim([-1.5 1.5]);
title("ASK Modulation");
xlabel('Time');
