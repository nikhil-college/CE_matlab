% To demonstrate DSBSC modulation
close all
clear all

% Set the parameters for the simulation

Ts = 0.001; % Time resolution
Ac = 10;    % Carrier amplitude
fc = 200;   % Carrier frequency in Hz
Nlpf = 50;  % Length of the FIR LPF at the receiver
Bm = 150;   % Bandwidth of the FIR LPF

% Generating m(t)

t = [-0.1:Ts:0.3];          % The time range for displaying the signals
mt = zeros(1,length(t));

% Defining m(t) according to the given expression
mt(t >= 0 & t < 0.1) = 10 * t(t >= 0 & t < 0.1);
mt(t >= 0.1 & t <= 0.2) = 10 * (0.2 - t(t >= 0.1 & t <= 0.2));

% Multiplying m(t) with the carrier to generate s(t)
st = mt .* (Ac * cos(2*pi*fc*t));

% To compute and plot the spectra of m(t) and s(t). We will use the fft command to compute the spectrum
Nfft = length(t);               % Find the length of m(t)
Nfft = 2^(ceil(log2(Nfft)));    % Set the FFT length as the next higher power of 2

f = ((-Nfft/2):(Nfft/2)-1)/(Nfft*Ts); % Set the frequency scale, to display the FFT output in terms of analog frequency (in Hz)

Mf = fft(mt,Nfft);              % Spectrum of m(t)
Mf = fftshift(Mf);              % Circularly shift the FFT output to bring the dc component to the center, so that the spectrum plot will be from -pi to pi

Sf = fft(st,Nfft);              % Spectrum of s(t)
Sf = fftshift(Sf);

% Demodulation

% Multiply s(t) with the local carrier to generate v(t)
vt = st .* cos(2*pi*fc*t);

% We need to apply an LPF on v(t) to obtain m1(t), the recovered version of
% m(t). We will use an FIR LPF for this purpose.

% Design the LPF using fir1. The cutoff frequency is to be specified as a
% fraction of the sampling frequency (fs = 1/Ts)
h = fir1(Nlpf, 2*Bm*Ts);

% Filter v(t) with the LPF
m1t = filter(h,1,vt);

% Find the spectra of v(t) and m1(t)
Vf = fft(vt,Nfft);
Vf = fftshift(Vf);

M1f = fft(m1t,Nfft);
M1f = fftshift(M1f);

% Plot the results

figure;
subplot(221)
plot(t,mt);
title('Message Signal');
xlabel('{\it t} (sec)');
ylabel('{\it m(t)}');

subplot(223)
plot(t,st);
title('Modulated Signal');
xlabel('{\it t} (sec)');
ylabel('{\it s(t)}');

subplot(222)
plot(f,abs(Mf));
title('Message Spectrum');
xlabel('{\it f} (Hz)');
ylabel('{\it |M|(f)}');

subplot(224)
plot(f,abs(Sf));
title('DSBSC Spectrum');
xlabel('{\it f} (Hz)');
ylabel('{\it |S|(f)}');

figure;
subplot(221)
plot(t,vt);
title('After multiplying with local carrier');
xlabel('{\it t} (sec)');
ylabel('{\it v(t)}');

subplot(223)
plot(t,m1t);
title('Recovered message Signal');
xlabel('{\it t} (sec)');
ylabel('{\it m1(t)}');

subplot(222)
plot(f,abs(Vf));
title('Spectrum of v(t)');
xlabel('{\it f} (Hz)');
ylabel('{\it |V|(f)}');

subplot(224)
plot(f,abs(M1f));
title('Spectrum of m_1(t)');
xlabel('{\it f} (Hz)');
ylabel('{\it |M1|(f)}');



