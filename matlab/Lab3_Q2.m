% ELEN3024 Lab 3 - Exercise 2b
% Tyson Cross 1239448
% Jason Parry 1046955
% Rashaad Cassim 1099797

clc; clear all;  %delete(get(0,'Children'));
interactive = 0;
export_on = 0;

%% Constants
A_c = 1.0;
A_m = 1.0;                                  %  modulation Index
f_m = 1e3;                                  %  message frequency in Hz
f_c = 2e6;                                  %  carrier frequency in Hz
f_e = f_m;                                  %  envelope frequency in Hz
T_m = 1/f_m;                                %  message period in seconds
T_c = 1/f_c;                                %  carrier period in seconds
T_e = T_m;                                  %  envelope period in seconds
plot_length = 4*T_m;                        %  length of plot (x-axis)

% output message sampling
mult = 10*1000;                             %  oversampling
f_s = mult*f_m;                             %  sample / second (sample freq)
dt = 1.0/f_s;                               %  seconds / sample (time-step)
t = 0:dt:plot_length;                       %  time range
tm = t*1e3;
N = numel(t);                               %  number of samples
f = linspace(-f_s/2,f_s/2,N);               %  frequency range

%% Equations (normal DSB-FC as per Lab 1)
phase = pi/4;
message = A_m * cos(2 * pi * f_m * t + phase);
carrier = A_c * cos(2 * pi * f_c * t + phase);

% DSB-SC modulation
modulated_signal = (1 + message) .* carrier;

% Demodulation (Using a QI structure)
local_oscillator_I = cos(2 * pi * f_c * t);
local_oscillator_Q = imag(hilbert(local_oscillator_I)); % 90 degree out of phase

demod_I = modulated_signal.*local_oscillator_I;
demod_Q = modulated_signal.*local_oscillator_Q;

filtered_signal_I = lowpass(demod_I,1,f_m);
filtered_signal_Q = lowpass(demod_Q,1,f_m);

envelope = sqrt(filtered_signal_I.^2 + filtered_signal_Q.^2);
phase_recovered = atan2(filtered_signal_Q,filtered_signal_I);

% Restore the amplitude and remove the DC offset from the demodulated signal:
demodulated_signal = 2*(envelope) - 1;

% Frequency
message_frequency =     (A_m/N)  * abs(fftshift((fft(message))));
modulated_frequency =   (A_c*A_m/N)  * abs(fftshift((fft(modulated_signal))));
% remove the DC offset from the demodulated signal for the FFT:
demodulated_frequency = (A_m/N)  * abs(fftshift((fft(demodulated_signal-mean(demodulated_signal)))));

f_message = [-f_m 0 f_m];
f_output = [-f_c-f_m -f_c+f_m 0 f_c-f_m f_c+f_m];

%% Plot results
Plot_Q2;