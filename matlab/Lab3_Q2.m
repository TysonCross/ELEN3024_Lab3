% ELEN3024 Lab 3 - Exercise 2b
% Tyson Cross 1239448
% Jason Parry 1046955
% Rashaad Cassim 1099797

clc; clear all;  %delete(get(0,'Children'));
interactive = 0;
export_on = 0;

%% Constants
A_c = 1.0;
A_m = 1;                                    % 0.7071 to producy unity gain output
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

%% Equations
%{
message_I = A_m * cos(2 * pi * f_m * t );
message_Q = A_m * sin(2 * pi * f_m * t );
% message_Q = imag(hilbert(message_I));

carrier_I = A_c * cos(2 * pi * f_c * t);
carrier_Q = A_c * sin(2 * pi * f_c * t);

message = message_I - message_Q;
carrier = carrier_I - carrier_Q;

%  IQ DSB-SC:
modulated_signal_I = (1 + message_I) .* carrier_I;
modulated_signal_Q = (1 + message_Q) .* carrier_Q;
modulated_signal = modulated_signal_I - modulated_signal_Q;

% Demodulation
magnitude_signal = abs(modulated_signal);
% compensate for MATLAB complex signal magnitude:
% filtered_signal = (1/sqrt(2)).*lowpass(magnitude_signal,1,f_m)-0.2;
filtered_signal = lowpass(magnitude_signal,1,f_m);
demodulated_signal = 2*filtered_signal - 2;

% Envelope:
envelope1 = message_I + 1;
envelope2 = -envelope1;
%}

%% Equations
message = A_m * cos(2 * pi * f_m * t);
carrier = A_c * cos(2 * pi * f_c * t);

% DSB-SC modulation
modulated_signal = (1 + message) .* carrier;

% Demodulation
local_oscillator_I = cos(2 * pi * f_c * t);
local_oscillator_Q = imag(hilbert(local_oscillator_I));

demod_I = modulated_signal.*local_oscillator_I;
demod_Q = modulated_signal.*local_oscillator_Q;

filtered_signal_I = lowpass(demod_I,1,f_m);
filtered_signal_Q = lowpass(demod_Q,1,f_m);

envelope = sqrt(acos(filtered_signal_I).^2 + asin(filtered_signal_Q).^2);
phase = atan(asin(filtered_signal_Q)/acos(filtered_signal_I));

% Frequency
message_frequency =     (A_m/N)  * abs(fftshift((fft(message))));
modulated_frequency =   (A_c*A_m/N)  * abs(fftshift((fft(modulated_signal))));
demodulated_frequency = (A_m/N)  * abs(fftshift((fft(filtered_signal_I-mean(filtered_signal_I)))));

f_message = [-f_m 0 f_m];
f_output = [-f_c-f_m -f_c+f_m 0 f_c-f_m f_c+f_m];

%% Plot results
Plot_Q2;