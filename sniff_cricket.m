% Joseph Clements
% COMPE 490L: Criquit

% Load the reference sample:
refSample = audioread('fallfieldcricket.wav');
refSampleF = fft(refSample);
[m, n] = size(refSample); % size of the ref sample

Fs = 44100; % Sampling frequency:
f = Fs*(0:m/2-1)/(m); % Frequency vector, for plotting FFT (0 to samp frq.)

% rSF2 = (20*log10(abs(refSampleF((1:m/2), 1) / (m)))); 
rSF2 = abs(refSampleF((1:m/2), 1) / (m)); % Magnitude of fft

% Configure comm port 
sniff_len = 20000; % number of samples to get from comm port
nucleo = serial('COM3'); % change to right comm port if necessary
set(nucleo, 'BaudRate', 240000);
samp = ones(1,sniff_len); % Allocate array of needed size (see next lines)
s = whos('samp');
nucleo.InputBufferSize = s.bytes; % size input buffer appropriately

% Ref sample time domain plot
subplot(2,2,1)
plot((1:floor(m/2))/floor(m/2), refSample((1:m/2), 1))
title('Sample Cricket Sound (44KHz)')
xlabel('time (s)')
ylabel('Amplitude')
axis('tight')

% Ref sample frequency domain plot 
subplot(2,2,2)
plot(f, rSF2)
title('Sample Cricket Sound (frequency domain)')
xlabel('Frequency (Hz)')
ylabel('Amplitude')
axis('tight')

% Open the comm port object, read data
fopen(nucleo);
samp = fread(nucleo, sniff_len);
[v, b] = size(samp);

% Recorded sample time domain plot
subplot(2,2,3)
plot((1:v)/v, samp)
title('Recorded Cricket Sound (20KHz)')
xlabel('time (s)')
ylabel('Amplitude')
axis('tight')

% Prepare fft of recorded sample
sampF = fft(samp);
fs2 = 20e3; % 20k sampling f
f2 = fs2*(0:v-1)/v;
rSFs = abs(sampF(:, 1)/v);

% Recorded sample frequency domain plot
subplot(2,2,4)
plot(f2, rSFs)
title('Recorded Cricket Sound (Frequency domain)')
xlabel('Frequency (Hz)')
ylabel('Amplitude')
axis('tight')

% clean up (stays open and causes problems if not closed)
fclose(nucleo);