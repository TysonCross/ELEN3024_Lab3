% ELEN3024 Lab 3 - Exercise 2b
% Tyson Cross 1239448
% Jason Parry 1046955
% Rashaad Cassim 1099797

clc; clear all;  %delete(get(0,'Children'));
interactive = 0;
export_on = 0;

%% Constants
A_c = 1.0;
A_m = 1.0;
f_m = 1e3;                                  %  message frequency in Hz
f_c = 2e6;                                  %  carrier frequency in Hz
f_e = f_m;                                  %  envelope frequency in Hz
T_m = 1/f_m;                                %  message period in seconds
T_c = 1/f_c;                                %  carrier period in seconds
T_e = T_m;                                  %  envelope period in seconds
plot_length = 3*T_m;                        %  length of plot (x-axis)

% output message sampling
mult = 2*800;                               %  oversampling
f_s = mult*f_m;                             %  sample / second (sample freq)
dt = 1.0/f_s;                               %  seconds / sample (time-step)
t = 0:dt:plot_length;                       %  time range
N = numel(t);                               %  number of samples
f = linspace(-f_s/2,f_s/2,N);               %  frequency range

%% Equations
rMessage = A_m * cos(2 * pi * f_m * t);
qMessage = A_m * sin(2 * pi * f_m * t);
rCarrier = A_c * cos(2 * pi * f_c * t);
qCarrier = A_m * sin(2 * pi * f_c * t);
message = rMessage - qMessage;
carrier = rCarrier - qCarrier;

% DSB-SC:
rModulated_signal = rMessage .* rCarrier;
qModulated_signal = qMessage .* qCarrier;
modulated_signal = rModulated_signal + qModulated_signal;

% LPF filter design
filterOrder = 60;
cutoffFreq = f_m;
LPF_stage = fdesign.lowpass('N,F3dB', filterOrder, cutoffFreq, 20*f_m);
LPF = design(LPF_stage);

% Demodulation
firstStageDemodulatedIP = modulated_signal.*rCarrier;
firstStageDemodulatedQP = modulated_signal.*qCarrier;

filtered_signal_I = filter(LPF,firstStageDemodulatedIP);
demodulated_signal_I = 2*filtered_signal_I; %% remove offset, is (A/a)-1/a

filtered_signal_Q = filter(LPF,firstStageDemodulatedQP);
demodulated_signal_Q = 2*(filtered_signal_Q);  %% remove offset, is (A/a)-1/a

% Envelope:
envelope1 = max(abs(rMessage),abs(qMessage));
envelope2 = -envelope1;

% Frequency
message_frequency = (A_m/N)  * abs(fftshift((fft(message))));
modulated_frequency = (A_c*A_m/N)  * abs(fftshift((fft(modulated_signal))));
demodulated_frequency =(A_m/N)  * abs(fftshift((fft(filtered_signal_I))));

f_message = [-f_m 0 f_m];
f_output = [-f_c-f_m -f_c+f_m 0 f_c-f_m f_c+f_m];

%% Plot results
Plot_Q2;