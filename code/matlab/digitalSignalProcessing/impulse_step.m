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

T=1e-4;
t=0:T*2.5e-3:2.5e-3;
x=square(2*pi/T*t,50); % 方波信号作为输入信号

[h0,t0]=impulse(sys);
[h1,t1]=step(sys);
[h2,t2]=lsim(sys,x,t);

%画图
figure;
plot(t0,h0);
title('单位冲激响应');
figure;
plot(t1, h1);
title('单位阶跃响应');
figure;
subplot(2, 1, 1);
plot(t2, h2);
title('全响应');
subplot(2, 1, 2);
plot(t, x);
title('输入信号');
