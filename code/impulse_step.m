%   求解系统函数的单位阶跃响应和单位冲激响应

clc;clear;close all;

% 系统函数
L=22e-3; % 电感
C=2000e-12; % 电容
R=100; % 电阻

a=[L*C,R*C,1];  % 系统函数的分母
b=1;        % 系统函数的分子
% t=0:1e-6:2.5e-3;

sys=tf(b,a);

[h0,t0]=impulse(sys);
[h1,t1]=step(sys);

%画图
figure;
plot(t0,h0);
title('单位冲激响应');
figure;
plot(t1, h1);
title('单位阶跃响应');
