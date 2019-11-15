tr = 0.001;
Ts = 0.02;
t1 = -5 : tr : 0-tr;
t2 = 0 : tr : 1;
t3 = 1+tr : tr : 5;
t = [t1 t2 t3];
lt = length(t);

x = [zeros(1,length(t1)) cos(2*pi*t2)+2*sin(4*pi*t2) zeros(1,length(t3))];
im_train = zeros(1,lt);
for k = 1 : lt
    if(rem(t(k),Ts) == 0)
        im_train(k) = 1;
    end
end

x_delta = x.*im_train;

figure;
subplot(2,1,1); plot(t,x);
subplot(2,1,2); plot(t,x_delta);



lt = 2^ceil(log2(lt));
f = ((-lt/2) : (lt/2)-1)/(lt*tr);
X = fftshift(fft(x,lt));
X_DELTA = fftshift(fft(x_delta,lt));

figure;
subplot(2,1,1); plot(f,abs(X));
subplot(2,1,2); plot(f,abs(X_DELTA));



R = zeros(1,length(f));
for k = 1 : length(f)
    if(f(k)>-10 & f(k)<10)
        R(k) = Ts/tr;
    end
end
X_RE = X_DELTA.*R;
x_re = ifft(X_RE);

figure;
plot(f,x_re);








