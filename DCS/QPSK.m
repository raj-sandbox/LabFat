%QPSK
clc;
clear all;
close all;

fs = 1000;
num_cyc = 5;
fm = 5;
t = 0:1/fs:num_cyc/fm;

A = 5;
N = 8;
m = randi([0,1],[1,N]);

msgSine = A*sin(2*pi*fm*t);
msgCos = A*cos(2*pi*fm*t);
msg1 = msgSine + msgCos;
msg2 = msgSine - msgCos;
msg3 = -msgSine + msgCos;
msg4 = -msgSine - msgCos;

% QPSK Modulation
y=[];
for (i=1:2:length(m)-1)
 if m(i)==0 && m(i+1)==0
 y=[y msg1];
 elseif m(i)==0 && m(i+1)==1
 y=[y msg2];
 elseif m(i)==1 && m(i+1)==0
 y=[y msg3];
 elseif m(i)==1 && m(i+1)==1
 y=[y msg4];
 end
end

% QPSK Demodulation

demod=[];
for n=0:2:N-1
 k=y(((n*((length(msg1))/2))+1):((n+2)*((length(msg1))/2)));

 a=max(xcorr(k,msg1));
 b=max(xcorr(k,msg2));
 c=max(xcorr(k,msg3));
 d=max(xcorr(k,msg4));

 if a>b && a>c && a>d
 demod=[demod,0];
 demod=[demod,0];

 elseif b>a && b>c && b>d
 demod=[demod,0];
 demod=[demod,1];

 elseif c>a && c>b && c>d
 demod=[demod,1];
 demod=[demod,0];

 elseif d>a && d>b && d>c
 demod=[demod,1];
 demod=[demod,1];

 end
end

% Noise
y1=awgn(y,-2);

% Graph Plotting
figure(1);
subplot(2,2,1);
plot(msg1);
title('Signal 1');

subplot(2,2,2);
plot(msg2);
title('Signal 2');

subplot(2,2,3);
plot(msg3);
title('Signal 3');

subplot(2,2,4);
plot(msg4);
title('Signal 4');

figure(2);
subplot(2,2,1);
stem(m);
title('Binary Sequence');

subplot(2,2,2)
plot(y);
title("QPSK Modulation");

subplot(2,2,3);
stem(demod);
title('QPSK Demodulation');

subplot(2,2,4);
plot(y1);
title('Noise');