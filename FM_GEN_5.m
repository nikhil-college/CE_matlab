Ts = 0.001;
t = 0 : Ts : 5;
Ac = 1;
fc = 10;
beta = 10;
fm = 1;

%Modulation
s = Ac*cos(2*pi*fc*t + beta*sin(2*pi*fm*t));

%Demodulation
ds = diff(s);
m1 = abs(hilbert(ds));
t1 = 0 : Ts : 5-Ts;
%plot
subplot(3,1,1); plot(t,s);
subplot(3,1,2); plot(t1,ds);
subplot(3,1,3); plot(t1,m1);