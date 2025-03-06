% 生成锯齿波和三角波

T=1; % 周期]
Fs=100; % 采样频率
f=1/T; % 频率

dt=0:T/Fs:T*2; % 时间序列

x1=sawtooth(2*pi*f*dt);
x2=sawtooth(2*pi*f*dt,0.5);
plot(dt,x1);
title('锯齿波');
figure;
plot(dt,x2);
title('三角波');