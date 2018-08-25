%This script aims to demonutrate the use of DSB-FC modulation. a sample
%tone us used to domonstrate these effects. by changing the k values, the
%modulation index is effected, resulting in diffrent output waveforms
%
clear all;
close all;
%%
%again, we need to define the message, carrier and sample frequencies 
fm = 10^3;
fc = 2*10^6;
fs = 10^7;
ac = 1;
 
%as before, we define the sample period
samples = 1000000;
t = 0:1/fs:(samples-1)/fs;  % generate a time vector to calculate the results
mt = cos(2*pi*fm*t);    % define the message signal as standard cos signa
 
percentage = 100;    %modulation index percentage input
k = percentage/100;    % calculates as a fraction of 1
 
 
message_I = cos(2*pi*fm*t);
message_Q = sin(2*pi*fm*t);
carrier_I = cos(2*pi*fc*t);
carrier_Q = sin(2*pi*fc*t); %This must be 90deg out of phase of the carrier 
 
m1 = 1 + message_I;
m2 = 1 + message_Q;
 
%Plot the original message signals
 
figure;
plot(t,m1);
xlabel('time(s)');
ylabel('m1(t)');
grid;
axis([0 2/fm -2.1 2.1]);
 
figure;
plot(t,m2);
xlabel('time(s)');
ylabel('m2(t)');
grid;
axis([0 2/fm -2.1 2.1]);
 
%Modulation with IQ
 
modulated_message = (m1.*carrier_I) + (m2.*carrier_Q);
 
%plot of modulated signal
figure;
plot(t,modulated_message);
xlabel('time(s)');
ylabel('u(t)');
grid;
axis([0 2/fm -2.1 2.1]);
 
%next, we need to take the FFT of the signal. again, we normalise the
%result
u_fft = abs(fft(modulated_message,samples))/samples; 
u_fft = fftshift(u_fft);    % Shift the FFT to the correct position
F = [-samples/2:samples/2-1]*fs/samples;  % Generate the F space of samples
%to plot the resultant output
 
%as before, we now plot the resultant waveform
%Frequency graph
figure;
plot(F,u_fft);
axis([-2.5*10^6 2.5*10^6 0 0.6]);
grid;
xlabel('frequency (Hz)');
ylabel('s(f)');
 
%Frequency graph, zoomed in
figure;
plot(F,u_fft);
axis([1.9985*10^6 2.0015*10^6 0 0.6]);
grid;
xlabel('frequency (Hz)');
ylabel('s(f)');
 
 
%Demodulation of Message 1
 
z = modulated_message.*cos(2*pi*fc*t);
 
%Filter design taken from:  http://www.mathworks.com/help/dsp/examples/designing-low-pass-fir-filters.html
N   = 100;          % FIR filter order
Fp  = 5e3;          % 5 kHz passband-edge frequency
Fs  = 1/0.0000001;  % 10 MHz sampling frequency
Rp  = 0.00057565;   % Corresponds to 0.01 dB peak-to-peak ripple
Rst = 1e-4;         % Corresponds to 80 dB stopband attenuation
 
coeffVec = firceqrip(N,Fp/(Fs/2),[Rp Rst],'passedge');
demodulated=filter(coeffVec,1,z);
 
figure;
plot(t,demodulated);
grid;
axis([0 2/fm -2.1 2.1]);
xlabel('time (s)');
ylabel('r(t)');
 
%Demodulation of Message 2
 
z = modulated_message.*sin(2*pi*fc*t);
 
%Filter design taken from:  http://www.mathworks.com/help/dsp/examples/designing-low-pass-fir-filters.html
N   = 100;          % FIR filter order
Fp  = 5e3;          % 5 kHz passband-edge frequency
Fs  = 1/0.0000001;  % 10 MHz sampling frequency
Rp  = 0.00057565;   % Corresponds to 0.01 dB peak-to-peak ripple
Rst = 1e-4;         % Corresponds to 80 dB stopband attenuation
 
coeffVec = firceqrip(N,Fp/(Fs/2),[Rp Rst],'passedge');
demodulated=filter(coeffVec,1,z);
 
figure;
plot(t,demodulated);
grid;
axis([0 2/fm -2.1 2.1]);
xlabel('time (s)');
ylabel('r(t)');