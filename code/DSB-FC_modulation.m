%%% ELEN3024 Lab 3 
%{ 
    Tyson Cross 1239448
    Jason Parry 1046955
    Rashaad Cassim 1099797
%}
clc; clear all; set(0,'ShowHiddenHandles','on'); delete(get(0,'Children'));
interactive = 0;
export_on = 0;

%% Input
A_c = 1.0;
A_m = 1.0;


%% Constants
f_m = 1000.0;                               %  message frequency in Hz
f_c = 2000000.0;                            %  carrier frequency in Hz
f_e = f_m;                                  %  envelope frequency in Hz
T_m = 1/f_m;                                %  message period in seconds
T_c = 1/f_c;                                %  carrier period in seconds
T_e = T_m;                                  %  envelope period in seconds
plot_length = 2*T_m;                        %  length of plot (x-axis)

% output message sampling
mult = 2*500;                               %  oversampling
f_s = mult*f_c;                             %  sample / second (sample freq)
dt = 1.0/f_s;                               %  seconds / sample (time-step)
t = 0:dt:plot_length;                       %  time range
N = numel(t);                               %  number of samples
f = linspace(-f_s/2,f_s/2,N);               %  frequency range
a = 1;                                      %  modulation index

%% Equations
for i=3:-1:1
    message = A_m * cos(2 * pi * f_m * t);
    carrier = A_c * cos(2 * pi * f_c * t);
    aMessage = a * message;
    
    % Double Sideband with Full Carrier (Conventional AM):
    modulated_signal = (1 + aMessage) .* carrier;

    % Envelope:
    envelope1 = A_c * (1 + aMessage);
    envelope2 = -envelope1;

    % Frequency
    message_frequency = (A_m/N)  * abs(fftshift((fft(message))));
    modulated_frequency = (A_c*A_m/(2*N))  * abs(fftshift((fft(modulated_signal))));
    f_message = [-f_m 0 f_m];
    f_output = [-f_c-f_m -f_c -f_c+f_m 0 f_c-f_m f_c f_c+f_m];

    % Plot results
    DSB-FC_modulation_Plot;
    
    %% Export images
    export_fig(sprintf('plot%d.png', a));
    filename = ['../Report/images/Exercise2c_'];
    if export_on
%         export_fig(sprintf('%s%d.eps', filename, i), '-eps');
        export_fig(sprintf('%sC_%d.eps', filename, i),'-c[475,10,-310,10] ','-eps');
        export_fig(sprintf('%sE_%d.eps', filename, i),'-c[735,70,-10,750] ','-eps');
    end
end
    
    if export_on
        export_fig ../Report/images/Exercise2c_A.eps -c[50,10,-745,10] -eps;
        export_fig ../Report/images/Exercise2c_B.eps -c[265,10,-542,10] -eps;
        export_fig ../Report/images/Exercise2c_D.eps -c[735,820,-10,40] -eps;   
    end
