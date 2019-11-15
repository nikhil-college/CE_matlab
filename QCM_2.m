%Given values
Ts = 0.001;
t1 = 0:Ts:0.2;
t2 = 0.2:Ts:0.5;
t = [t1 t2];
Ac = 5;
fc = 250;
lt = length(t);
lt = 2^ceil(log2(lt));
f = ((-lt/2):(lt/2)-1)/(lt*Ts);

%Modulation
m1 = [5*t1 zeros(1,length(t2))];
m2 = sin(20*pi*t);

s = m1.*(Ac*cos(2*pi*fc*t)) + m2.*(Ac*sin(2*pi*fc*t));

M1 = fft(m1,lt);
M1 = fftshift(M1);
M2 = fft(m2,lt);
M2 = fftshift(M2);
S = fft(s,lt);
S = fftshift(S);

%Demodulation
Nlpf = 50;%length of fir filter
B = 150;
h = fir1(Nlpf, 2*B*Ts);

v1 = s.*(Ac*cos(2*pi*fc*t));
v2 = s.*(Ac*sin(2*pi*fc*t));
%V1 = fftshift(fft(v1,lt));
%V2 = fftshift(fft(v2,lt));
md1 = filter(h,1,v1);%m - demodulated - 1
md2 = filter(h,1,v2);%m - demodulated - 2
MD1 = fftshift(fft(md1,lt));
MD2 = fftshift(fft(md2,lt));


%plots
figure;
subplot(311);
plot(t,m1);
subplot(312);
plot(t,m2);
subplot(313);
plot(t,s);

figure;
subplot(411);
plot(f,abs(M1));
subplot(412);
plot(f,abs(M2));
subplot(413);
plot(f,real(S));
subplot(414);
plot(f,imag(S));

figure;
subplot(411);
plot(t,md1);
subplot(412);
plot(t,md2);
subplot(413);
plot(f,abs(MD1));
subplot(414);
plot(f,abs(MD2));