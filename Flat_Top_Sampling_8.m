tr = 0.001;
Ts = 0.02;
t1 = -5 : tr : 0-tr;
t2 = 0 : tr : 1;
t3 = 1+tr : tr : 5;
t = [t1 t2 t3];
lt = length(t);

x = [zeros(1,length(t1)) cos(2*pi*t2)+2*sin(4*pi*t2) zeros(1,length(t3))];
h = zeros(1,lt);
for k = 1 : lt
    if(rem(t(k),Ts) == 0)
        if(t(k) ~= 5)
            h(k : k+4) = 1;
        end
    end
end
im_train = zeros(1,lt);
for k = 1 : lt
    if(rem(t(k),Ts) == 0)
        im_train(k) = 1;
    end
end


x_delta = x.*im_train;
s = conv(x_delta,h);
%disp(length(x));
%disp(length(im_train));
%disp(length(x_delta));
%disp(length(s));
%disp(lt)

ts = -10 : tr : 10;

figure;
subplot(2,1,1); plot(t,x);
subplot(2,1,2); plot(ts,s);



lt = 2^ceil(log2(lt));
f = ((-lt/2) : (lt/2)-1)/(lt*tr);
X = fftshift(fft(x,lt));
S = fftshift(fft(x_delta,lt)).*fftshift(fft(h,lt));

figure;
subplot(2,1,1); plot(f,abs(X));
subplot(2,1,2); plot(f,abs(S));





