Ts = 0.001;
fc = 200;

nlpf = 50;
B = 150;

t1 = 0:Ts:0.05;
t2 = 0.05:Ts:0.1;

t = [t1 t2];
mt = [20*t1 20*(0.1-t2)];

mcap = imag(hilbert(mt));
st = mt.*cos(2*pi*fc*t) - mcap.*sin(2*pi*fc*t);

lt = length(t);
lt = 2^ceil(log2(lt));
f = (-lt/2:(lt/2)- 1)/(lt*Ts);

Mf = fftshift(fft(mt,lt));
Sf = fftshift(fft(st,lt));

figure;
subplot(411); plot(t,mt);
subplot(412); plot(t,st);
subplot(413); plot(f, abs(Mf));
subplot(414); plot(f, abs(Sf));

m1 = st.*cos(2*pi*fc*t);
h = fir1(nlpf, 2*B*Ts);
m1 = filter(h,1,m1);        %2nd parameter indicates 1st order LPF
M1 = fftshift(fft(m1,lt));

figure;
subplot(211); plot(t,m1);
subplot(212); plot(f,abs(M1));

