% ELEN3024 Lab 3 - Exercise 2b
% Tyson Cross 1239448
% Jason Parry 1046955
% Rashaad Cassim 1099797

clc; clear all;  delete(get(0,'Children'));
interactive = 0;
export_on = 1;


%% Constants
A_c = 1.0;
A_m = 1.0;
f_m = 1e3;                                  %  message frequency in Hz
f_c = 2e6;                                  %  carrier frequency in Hz
f_e = f_m;                                  %  envelope frequency in Hz
T_m = 1/f_m;                                %  message period in seconds
T_c = 1/f_c;                                %  carrier period in seconds
T_e = T_m;                                  %  envelope period in seconds
plot_length = 4*T_m;                        %  length of plot (x-axis)

% output message sampling
mult = 10*800;                               %  oversampling
f_s = mult*f_m;                             %  sample / second (sample freq)
dt = 1.0/f_s;                               %  seconds / sample (time-step)
t = 0:dt:plot_length;                       %  time range
tm = t*1e3;
N = numel(t);                               %  number of samples
f = linspace(-f_s/2,f_s/2,N);               %  frequency range

%% Equations
message = A_m * cos(2 * pi * f_m * t);
carrier = A_c * cos(2 * pi * f_c * t);

% DSB-SC modulation
modulated_signal = (1 + message) .* carrier;


% Demodulation
cutoffFreq = f_m;
mixed_signal = modulated_signal .* carrier;
filtered_signal = lowpass(mixed_signal,0.9,f_m);
demodulated_signal = 2*filtered_signal - 1 ;  %% remove DC offset: is (A_c/A_m) - (1/A_m)

% Envelope:
envelope1 = (1 + message);
envelope2 = (-message - 1);

% Frequency
message_frequency = (A_m/N)  * abs(fftshift((fft(message))));
modulated_frequency = (A_c*A_m/N)  * abs(fftshift((fft(modulated_signal))));
demodulated_frequency =(A_m/N)  * abs(fftshift((fft(demodulated_signal))));
f_message = [-f_m 0 f_m];
f_output = [-f_c-f_m -f_c+f_m 0 f_c-f_m f_c+f_m];


%% Plot results
Plot_Q1;

