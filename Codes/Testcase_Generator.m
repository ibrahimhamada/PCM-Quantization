clc;
clear;
fm = 10;
t = 0:0.001:0.1;
m = 5*cos(2*pi*fm.*t );

writematrix(m,'M1.txt');
writematrix(t,'T1.txt');