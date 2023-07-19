% Delta Modulation
clc;
clear all;
close all;

am = input("Maximum Amplitude: ");
fm = input("Maximum Frequency: ");
fs = 20*fm;
t = 0:(1/fs):(2/fm);
x = am*cos(2*pi*fm*t);

% DM (No Slope Overload Distortion)
del = 2*pi*am*fm*(1/fs);
xs = 0;
y = 0;
for i =1:length(x)
    if xs(i)<=x(i)
        xs(i+1)=xs(i)+del;
        b=1;
    else
        xs(i+1)=xs(i)-del;
        b=0;
    end
    y=[y,b];
end

% DM (No Slope Overload Distortion)
del1 = 4*pi*am*fm*(1/fs);
xs1=0;
y1 = 0;
for i = 1:length(x)
    if xs1(i)<=x(i)
        xs1(i+1)=xs1(i)+del1;
        b1 = 1;
    else
        xs1(i+1)=xs1(i)-del1;
        b1 = 0;
    end
    y1=[y1,b1];
end

% Plotting the Graphs
subplot(2,2,1);
plot(x);
title('DM (No Slope Overload Distortion)');
hold on
stairs(xs)
hold off

subplot(2,2,2);
stairs(y);
title('Delta Modulated Signal (No Overload)');

subplot(2,2,3);
plot(x)
title('DM (Slope Overload Distortion)')
hold on
stairs(xs1)
hold off
grid on

subplot(2,2,4);
stairs(y1);
title('Delta Modulated Signal (Overload)');