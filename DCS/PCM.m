%PCM
clc;
clear all;
close all;

n = input('Number of Samples: ');
t = 0:(2*pi/n):4*pi;
t1 = 0:0.01:4*pi;

xmax = input('Amplitude of The Signal: ');
msg1 = xmax*sin(t);
y = xmax*sin(t);

m = input('Number of Bits: ');
L = 2^m;
xmin = -xmax;

del = (xmax-xmin)/L;
dec_lvl = xmin:del:xmax;
rep_lvl =xmin-(del/2):del:xmax+(del/2);
[ind,qua]= quantiz(msg1,dec_lvl,rep_lvl);

l1 = length(ind);
for i=1:l1
    if ind(i)~=0
        ind(i)=ind(i)-1;
    end
end
conv = de2bi(ind,'left-msb');
k=1;
for i=1:l1
    for j =1:m
        conv(k)=conv(i,j);
        j=j+1; k=k+1;
    end
    i=i+1;
end

% Plotting the Graphs
subplot(2,2,1);
plot(t,y);
xlim([0 4*pi]);
xlabel('Time');
ylabel('Amplitude');
title('Message Signal');

subplot(2,2,2);
stem(t,msg1);
xlabel('Time');
ylabel('Amplitude');
title('Sampled Signal');

subplot(2,2,3);
stem(qua);
xlabel('Time');
ylabel('Amplitude');
title('Quantized Signal');

subplot(2,2,4);
stairs(conv);
xlabel('Time');
ylabel('PCM');
title('Sampled Signal');