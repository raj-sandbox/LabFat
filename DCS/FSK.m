% FSK
clc;
clear all;
close all;

fs=1000;
num_cyc=10;
f1=200;
f2=20;
fc=100;
t=0:1/fs:num_cyc/fc;
N=8;
m=randi([0,1],[1,N]);

high=5*sin(2*pi*f1*t);
low=5*sin(2*pi*f2*t) ;

% FSK Modulation
op=[];
for i=1:N
 if m(i)==0
 op=[op,low];
 else
 op=[op,high];
 end
end

% FSK Demodulation
demod=[]; 
for n=0:N-1
 k=op(((n*length(high))+1):((n+1)*length(high)));
 a=max(xcorr(k,high)); 
 if a>(max(xcorr(high,low)))
 demod=[demod,1];
 else
 demod=[demod,0];
 end
end

% FFT
y = fft(op);
Ts = 1/50;
fs = 1/Ts;
f = (0:length(op)-1)*fs/length(op);


% Graph Plotting
subplot(3,2,1);
plot(t,high)
title('HIGH Freq Signal')

subplot(3,2,2);
plot(t,low)
title('LOW Freq Signal')

subplot(3,2,3)
stem(m)
title('Binary Sequence')

subplot(3,2,4);
plot(op)
title('FSK Modulation')

subplot(3,2,5);
stem(demod);
title('FSK Demodulation');

subplot(3,2,6);
plot(f,abs(y));
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('FFT');