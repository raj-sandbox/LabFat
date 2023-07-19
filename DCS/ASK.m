% ASK
clc;
clear all;
close all;

N=10;
fs = 500;
fm = 50;
numcycl = 10;
t = 0:1/fs:numcycl*1/fm;
w = 2*pi*fm;
A1 = 1;
A2 = 2;


% Generating the 10bits of binary data
ranBinary = randi([0,1],[1,N]);

% Creating two carrier wave
c1_sin = A1*sin(w*t);
c2_sin = A2*sin(w*t);

% Checking the given condition
op = [];
for i = ranBinary
    if i == 0
        op = [op c1_sin];
    else
        op = [op c2_sin];
    end
end

% Demodulation of ASK
demod=[]; 
for n=0:N-1
 k=op(((n*length(c2_sin))+1):((n+1)*length(c2_sin)));
 a=max(xcorr(k,c2_sin)); 
 if a>(max(xcorr(c2_sin,c1_sin)))
 demod=[demod,1];
 else
 demod=[demod,0];
 end
end


% Creating Noise Signal
noise1 = awgn(op,0,1);

% Plot
figure;
subplot(3,2,1);
plot(t,c1_sin);
title('Signal 1');
hold on;

subplot(3,2,2);
plot(t,c2_sin);
title('Signal 2');
hold on;

subplot(3,2,3);
stem(ranBinary);
title('Binary Sequence');
hold on;

subplot(3,2,4);
plot(noise1);
title('Noise');
hold on;

subplot(3,2,5);
plot(op);
title('ASK Modulation');
hold on;

subplot(3,2,6);
stem(demod);
title('ASK Demodulation');
hold on;

