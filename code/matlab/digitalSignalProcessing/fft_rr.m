% ------------------------------------------------------------------ %
%                            用fft求x和y的互相关                            %
% ------------------------------------------------------------------ %
clc;clear;close all;

xn=[-4,-3,-2,-1,0,1,2,3];   % 设计输入函数
yn=[4,2,-2,-1,0,2,2,-3];

k=length(xn);

xk=fft(xn,2*k);
yk=fft(yn,2*k);

rk=conj(xk).*yk;    % conj为求输入的共轭
rn=real(ifft(rk));

rn=[rn(k+2:2*k),rn(1:k)];   % 循环移位，前一半取k个放到后面，后一半取k-1个放到前面
m=-k+1:k-1;
stem(m,rn);