Ts = 0.001;
Ac = 10;
Ka = 0.5;
fc = 200;

%Nlpf = 50;
%B = 150;

t = 0:Ts:0.5;
m = 2*cos(50*pi*t);
s = Ac*(1+Ka*m).*cos(2*pi*fc*t);

figure;
subplot(411); plot(t,m);
subplot(412); plot(t,s);

lt = length(t);
lt = 2^ceil(log2(lt));
f = ((-lt/2):(lt/2)-1)/(lt*Ts);

M = fftshift(fft(m,lt));
S = fftshift(fft(s,lt));

subplot(413); plot(f,abs(M));
subplot(414); plot(f,abs(S));

m1 = hilbert(s);
M1 = fftshift(fft(abs(m1),lt));

figure;
subplot(211);plot(t,abs(m1));
subplot(212);plot(f,abs(M1));