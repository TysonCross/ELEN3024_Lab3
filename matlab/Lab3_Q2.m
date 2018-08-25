% ELEN3024 Lab 3 - Exercise 2b
% Tyson Cross 1239448
% Jason Parry 1046955
% Rashaad Cassim 1099797

clc; clear all;  %delete(get(0,'Children'));
interactive = 0;
export_on = 0;

%% Constants
A_c = 1.0;
A_m = 1;
f_m = 1e3;                                  %  message frequency in Hz
f_c = 2e6;                                  %  carrier frequency in Hz
f_e = f_m;                                  %  envelope frequency in Hz
T_m = 1/f_m;                                %  message period in seconds
T_c = 1/f_c;                                %  carrier period in seconds
T_e = T_m;                                  %  envelope period in seconds
plot_length = 3*T_m;                        %  length of plot (x-axis)

% output message sampling
mult = 10*1000;                               %  oversampling
f_s = mult*f_m;                             %  sample / second (sample freq)
dt = 1.0/f_s;                               %  seconds / sample (time-step)
t = 0:dt:plot_length;                       %  time range
N = numel(t);                               %  number of samples
f = linspace(-f_s/2,f_s/2,N);               %  frequency range

%% Equations
phase = 0;
message_I = A_m * cos(2 * pi * f_m * t + phase);
message_Q = A_m * sin(2 * pi * f_m * t+ phase);
carrier_I = A_c * cos(2 * pi * f_c * t);
carrier_Q = A_c * sin(2 * pi * f_c * t);
message = message_I - 1i*message_Q;
carrier = carrier_I - 1i*carrier_Q;


% % DSB-SC:
modulated_signal_I = (1 + message_I) .* carrier_I;
modulated_signal_Q = (1 + message_Q) .* carrier_Q;
modulated_signal = modulated_signal_I + 1i.*modulated_signal_Q;

% LPF filter design
filterOrder = 60;
cutoffFreq = f_m;
LPF_stage = fdesign.lowpass('N,F3dB', filterOrder, cutoffFreq, 20*f_m);
LPF = design(LPF_stage);

% Demodulation
magnitude_signal = abs(modulated_signal);
filtered_signal = filter(LPF, magnitude_signal);
demodulated_signal = (1/sqrt(pi).*filtered_signal) ;

% Envelope:
envelope1 = max(abs(message_I),abs(message_Q));
envelope2 = -envelope1;

% Frequency
message_frequency = (A_m/N)  * abs(fftshift((fft(message_I))));
modulated_frequency = (A_c*A_m/N)  * abs(fftshift((fft(modulated_signal))));
demodulated_frequency =(A_m/N)  * abs(fftshift((fft(filtered_signal))));

f_message = [-f_m 0 f_m];
f_output = [-f_c-f_m -f_c+f_m 0 f_c-f_m f_c+f_m];
t= t*1000;

%% Plot results
Plot_Q2;