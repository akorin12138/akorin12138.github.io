%{

设计iir带通滤波器，要求：
1. 采样频率Fs=2000Hz
2. 分别利用切比雪夫I型滤波器的冲激响应不变法和双线性变换法设计
3. 通带截止频率分别为200Hz,400Hz
4. 阻带截止频率分别为100Hz,500Hz
5. 通带最大衰减Rp=0.4dB
6. 阻带最小衰减Rs=40dB

%}

clc;clear;close all;

Fs=2000; % 采样频率
Rp=1; % 通带最大衰减
Rs=40; % 阻带最小衰减
ws1=200/(Fs/2)*pi; % 通带截止归一化频率
ws2=400/(Fs/2)*pi; % 通带截止归一化频率
wp1=100/(Fs/2)*pi; % 阻带截止归一化频率
wp2=500/(Fs/2)*pi; % 阻带截止归一化频率

ws=[ws1,ws2];
wp=[wp1,wp2];

bw=(ws2-ws1)*Fs;

Ws=ws.*Fs;
Wp=wp.*Fs;

W0=sqrt(ws1*ws2)*Fs;

% 切比雪夫I型滤波器的冲激响应不变法

[N1,Wn]=cheb1ord(Wp, Ws, Rp, Rs,'s');
[z,p,k]=cheb1ap(N1, Rp);
[num1,den1]=zp2tf(z, p, k);
[B1,A1]=lp2bp(num1, den1, W0, bw);

[bz1,az1]=impinvar(B1,A1,Fs);   % 冲激响应不变法

% 切比雪夫I型滤波器的双线性变换法

[bz2,az2]=bilinear(B1,A1,Fs);   % 双线性变换法

% 画图
figure;
freqz(bz1,az1); % 冲激响应不变法
title('冲激响应不变法');
[h1,w1]=freqz(bz1,az1);
figure;
plot(w1*Fs/2/pi,20*log(abs(h1)));   % 幅频响应
title('幅频响应');
xlabel('Hz');
ylabel('dB');
figure;
plot(w1*Fs/2/pi,angle(h1)/pi);  % 相频响应
title('相频响应');
xlabel('Hz');
ylabel('pi rad');
figure;
freqz(bz2,az2); % 双线性变换法
title('双线性变换法');

