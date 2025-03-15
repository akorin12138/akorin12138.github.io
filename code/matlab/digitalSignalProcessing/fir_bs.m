%{

设计一个fir数字带阻滤波器，阻带上下截止频率分别为0.3π和0.5π
通带上下截止频率分别为0.1π和0.8π，采样频率为Fs=2000Hz
通带最大衰减Rp=1dB，阻带最小衰减Rs=15dB

 %}

clc;
clear;  % 清除工作区变量
close all;  % 关闭所有图形窗口
ws1=0.1*pi; % 通带上截止频率
ws2=0.8*pi; % 通带下截止频率
wp1=0.3*pi; % 阻带上截止频率
wp2=0.5*pi; % 阻带下截止频率

Fs=2000; % 采样频率
Rp=1; % 通带最大衰减
Rs=15; % 阻带最小衰减

wd1=wp1-ws1;
wd2=ws2-wp2; 
wc1=(ws1+wp1)/2;
wc2=(ws2+wp2)/2;
wc=[wc1,wc2]/pi; % 通带截止频率

wd=max(wd1,wd2);

N=ceil(6.6*pi/wd); % N=3.3*2*pi/wd
N=mod(N, 2)+N; % 确保N+1长为奇数

window=hamming(N+1); % 汉明窗

H=fir1(N, wc,'stop',window);

freqz(H,1);   % 求频率响应
