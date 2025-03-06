%   生成一个阶跃信号

clc;clear;close all;

%编写主程序调用该函数
t=-3:0.01:5;
t0=1;
i=0;

y=(t>=t0);

plot(t,y)
axis([-3,5,-0.2,1.2])