%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 基本参数
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc;clear;close all;

Fs=2000; % 采样频率
fs1=300;fs2=500;
fp1=200;fp2=600;
rs=40;


%% 归一化角频率
ws1=2*fs1/Fs*pi;ws2=2*fs2/Fs*pi;
wp1=2*fp1/Fs*pi;wp2=2*fp2/Fs*pi;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% fir窗函数设计
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

deltaw=max(ws1-wp1,wp2-ws2)/pi;
N=ceil(2*pi*3.3/deltaw);
N=mod(N,2)+N;

window=hamming(N+1);

Wn=[ws1+wp1,ws2+wp2]/2/pi;

b=fir1(N, Wn, 'stop', window);

figure;
freqz(b,1);
title('fir带阻滤波器');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% iir巴特沃斯设计
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
wo=sqrt(ws1*ws2)*Fs;
bw=(wp2-wp1)*Fs;
n=buttord([wp1,wp2]*Fs,[ws1,ws2]*Fs,1,rs,'s');
[z,p,k]=buttap(n);
[b,a]=zp2tf(z,p,k);
[b1,a1]=lp2bs(b,a,wo,bw);
figure;
freqs(b1,a1);
title('iir模拟巴特沃斯带阻滤波器');
[bz,az]=bilinear(b1,a1,Fs);
figure;
freqz(bz,az);
title('iir巴特沃斯数字滤波器')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% iir切比雪夫设计
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
wo=sqrt(ws1*ws2)*Fs;
bw=(wp2-wp1)*Fs;
[n,rp]=cheb1ord([wp1,wp2]*Fs,[ws1,ws2]*Fs,1,rs,'s');
[z,p,k]=cheb1ap(n,1);
[b,a]=zp2tf(z,p,k);
[b1,a1]=lp2bs(b,a,wo,bw);
figure;
freqs(b1,a1);
title('iir模拟切比雪夫带阻滤波器');
[bz,az]=bilinear(b1,a1,Fs);
figure;
freqz(bz,az);
title('iir数字切比雪夫滤波器')
