% ELEN3024 Lab 3 - Exercise 2b
% Tyson Cross 1239448
% Jason Parry 1046955
% Rashaad Cassim 1099797

clc; clear all; set(0,'ShowHiddenHandles','on'); %delete(get(0,'Children'));
interactive = 0;
export_on = 0;

%% Input
if (interactive)
    prompt = 'Enter a value for message signal amplitude: ';
    A_m = input(prompt);
    prompt = 'Enter a value for carrier signal amplitude: ';
    A_c = input(prompt);
else
    A_c = 1.0;
    A_m = 1.0;
end

%% Constants
f_m = 1e3;                                  %  message frequency in Hz
f_c = 2e6;                                  %  carrier frequency in Hz
f_e = f_m;                                  %  envelope frequency in Hz
T_m = 1/f_m;                                %  message period in seconds
T_c = 1/f_c;                                %  carrier period in seconds
T_e = T_m;                                  %  envelope period in seconds
plot_length = 2*T_m;                        %  length of plot (x-axis)

% output message sampling
mult = 2*1000;                               %   oversampling
f_s = mult*f_m;                             %  sample / second (sample freq)
dt = 1.0/f_s;                               %  seconds / sample (time-step)
t = 0:dt:plot_length;                       %  time range
N = numel(t);                               %  number of samples
f = linspace(-f_s/2,f_s/2,N);               %  frequency range

%% Equations
message = A_m * cos(2 * pi * f_m * t);
carrier = A_c * cos(2 * pi * f_c * t);

% Double Sideband with Suppressed Carrier (DSB-SC):
modulated_signal = (1+message) .* carrier;

filterOrder=50;
cutoffFreq=f_m;

firstStageDemodulated=modulated_signal.*carrier;

LPF_stage=fdesign.lowpass('N,F3dB', filterOrder, cutoffFreq, 20*f_m);
LPF=design(LPF_stage);
demodulated=filter(LPF,firstStageDemodulated);

demodulated = (demodulated)/(1*1) - 1/1;  %% remove offset, is (A/a)-1/a


figure,
subplot(2,2,1);
plot(demodulated);
subplot(2,2,2);
plot(message);

% Envelope:
envelope1 = A_c * message;
envelope2 = -envelope1;

% Frequency
message_frequency = (A_m/N)  * abs(fftshift((fft(message))));
modulated_frequency = (A_c*A_m/N)  * abs(fftshift((fft(modulated_signal))));
f_message = [-f_m 0 f_m];
f_output = [-f_c-f_m -f_c+f_m 0 f_c-f_m f_c+f_m];


demodulated_frequency =(A_m/N)  * abs(fftshift((fft(demodulated))));
x_lim_4 = [-f_m f_m]*1.5;
ax2=subplot(2,2,3);
stem(f,demodulated_frequency);
set(ax2, 'XLim',x_lim_4);

ax=subplot(2,2,4);
stem(f,message_frequency);
x_lim_4 = [-f_m f_m]*1.5;
set(ax, 'XLim',x_lim_4);
%% Plot results

% Exercise1c_Plot;

% %% Export images
% if export_on
% %     export_fig ../Report/images/Exercise1b.eps -eps ;
%     export_fig ../Report/images/Exercise1b_A.eps -c[50,10,-745,10] -eps ;
%     export_fig ../Report/images/Exercise1b_B.eps -c[265,10,-542,10] -eps ;
%     export_fig ../Report/images/Exercise1b_C.eps -c[475,10,-310,10] -eps ;
%     export_fig ../Report/images/Exercise1b_D.eps -c[735,820,-10,40] -eps ;
%     export_fig ../Report/images/Exercise1b_E.eps -c[735,70,-10,750] -eps ;
% end