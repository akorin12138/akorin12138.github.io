%%  计算全响应、离散时间系统
clc;clear;close all;
% 构造离散时间系统
b=[0.1321,0.3963,0.3963,0.1321];
a=[1,-0.34319,0.60439,-0.20407];

k2=-5:1:5;
N=10;
x=sin(2*pi/N*k2);    % 生成输入信号

% 计算冲激响应

[h0,k0]=impz(b,a);

% 计算阶跃响应

h1=dstep(b,a);

% 计算全响应

h2=dlsim(b,a,x);

k1=0:length(h1)-1;


% 画图
figure;
subplot(3,1,1);
stem(k0,h0);
title('单位冲激响应');
subplot(3,1,2);
stem(k1,h1);
title('单位阶跃响应');
subplot(3,1,3);
stem(k2,h2);
title('全响应');