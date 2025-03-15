% 非方波脉冲宽度为1ms，信号持续时间为2ms，在0~2ms区间外信号为0，求20此谐波的信号的频谱特性
clc;clear;close all;
N=256;                          % 采样点数
t=0:2e-3/N:2e-3;                % 生成时间序列
x=rectpuls(t-0.5e-3,1e-3);      % 生成非方波脉冲信号

f=-20/2e-3:40/2e-3/N:20/2e-3;   % 20次谐波的频谱范围
w=2*pi*f;                       % 频率序列
dt=2e-3/N;                      % 采样间隔
df=20/2e-3/N;                   % 频率间隔
dw=2*pi*df;                     % 角频率间隔

% 计算频谱
X=x*exp(-j*t'*w)*dt;            % 傅里叶变换
subplot(1, 2, 1);
plot(f, abs(X));
title('幅度谱');

y=1/pi*X*exp(j*w'*t)*dw;        % 逆傅里叶变换
subplot(1, 2, 2);
plot(t, y,'r',t,x,'b');
title('信号波形和重构波形');