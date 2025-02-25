---
title: 信号的Matlab编程
date: 2025-02-25
updated: 2025-02-25
categories: 笔记
tags:
  - 笔记
  - 信号与系统
  - 速通
  - matlab
top: 3
cover: 'https://pic.akorin.icu/封面3.png'
---

记录基于Matlab的有关信号的编程

<!-- more -->

# 绘制图像
### 连续信号

$$
f(t)=5e^{-0.8t}\sin(\pi t),0<t<5
$$

```matlab
a=5;
b=0.8;
t=0:0.01:5;
x=b*exp(-a*t).*sin(pi*t);
figure(1);
plot(t, x);
```
![](https://pic.akorin.icu/20250225210740529.png)

### 离散信号

$$
f(t)=2(0.8)^{k},-5<k<5
$$

```matlab
c=2;
d=0.8;
k=-5:5;
y=c*(0.8).^k;
figure(2);
stem(k, y);
```

![](https://pic.akorin.icu/20250225210818824.png)

### 总结

```matlab
t=0:0.01:5;
```
取值范围从0到5，且步长取0.01，当省略步长，则默认为1

```matlab
x=b*exp(-a*t).*sin(pi*t);
```
与括号相邻的乘除（*或/）前面都要加点号（.*或./）

:::warning

矩阵和矩阵之间对应的元素之间的运算，在运算符(*、/、^)前也要加点号(.*、./、.^)

:::


### 函数

- plot(t,x);绘制连续曲线图像
- stem(k,y);绘制离散图像
- ezplot(表达式);绘制使字符表达式等于0的隐函数曲线
- figure(n);简历画布
- subplot(a,b,c);将画布分为a行b列并在c块上绘制

# 利用卷积与变换（拉氏变换、Z变换）求解
### 拉普拉斯变换

计算
$$
f_1(t)=e^{-t}\varepsilon(t),f_2(t)=te^{-\frac{1}{2}t}\varepsilon(t)
$$
的卷积

```matlab
syms t;                     %新建一个符号变量
t=sym('t','positive');      %设置符号变量的属性：字符串t为符号变量且为正
fs1=laplace(exp(-t));       %求函数f1的拉氏变换fs1
fs2=laplace(t*exp(-t));     %求函数f1的拉氏变换fs1
yt=simplify(ilaplace(fs1*fs2)); %求拉式反变换
ezplot(yt);                     %绘制变换后的图像
```
![](https://pic.akorin.icu/20250225211440024.png)


### 离散信号Z变换

求函数
$$
f(k)=\cos(ak)\varepsilon(k)
$$
的Z变换

```matlab
syms k a;
k=sym('k','positive');
f=cos(a*k);
F=ztrans(f)
```
输出：
```matlab
(z*(z - cos(a)))/(z^2 - 2*cos(a)*z + 1)

```
---
求函数

$$
F(z)=\frac{1}{(z+1)^2}
$$

的逆Z变换
```matlab
syms z;
F=1/(1+z)^2;
f=iztrans(F)
```

输出：

```matlab
kroneckerDelta(n, 0) + (-1)^n*(n - 1)
```

### 函数

- syms  定义符号变量，即一个自变量，不带入具体数值，是一个字符或字符串，最后的计算结果也不是固定值，而是表达式，
- laplace(表达式);求拉氏变换，输出一个字符串表达式
- ilaplace(表达式);求拉氏反变换，输出一个字符串表达式
- simplify(表达式);将表达式化为最简形式
- ztrans(表达式);求Z变换，返回一个字符串表达式
- iztrans(表达式);求逆Z变换，返回一个字符串表达式

# 求卷积（利用变换求）

$$
f_1(t)=
\begin{cases}
    2,0<t<1 \\
    0,else
\end{cases},
f_2(t)=
\begin{cases}
    t,0<t<2 \\
    0,else
\end{cases}
$$
用MATLAB画出 $f_1(t)*f_2(t)$

```matlab
t1=0:0.001:1;
t2=0:0.001:2;
ft1=2*rectpuls(t1-0.5,1);
ft2=t2;
ft3=0.001*conv(ft1,ft2);
t3=0:0.001:3;
plot(t3,ft3);
title('ft1(t)*ft2(t)')
```
![](https://pic.akorin.icu/20250225214019300.png)


求
$$
x_1(k)=\sin(k),0\le k\le 10 \quad x_2(k)=0.8^k,0\le k\le 15
$$
的卷积
```matlab
k1=0:10;k2=0:15;
x1=sin(k1);
x2=0.8.^k2;
y=conv(x1,x2);
k=0:25;
subplot(3, 1, 1);stem(k1,x1);
subplot(3, 1, 2);stem(k2,x2);
subplot(3, 1, 3);stem(k,y);
```
![](https://pic.akorin.icu/20250225215129580.png)

```matlab
x2=0.8.^k2;  
x2=0.8^k2;  %[!code error]
```
由于k2是一个矩阵，不能直接用运算符与之做运算，需要在运算符前加一个点号表明将矩阵的每个元素分别做运算

### 函数

- rectpuls(t-a,1); 产生方波信号，宽度为1，中心点移到t=a处，幅度默认为1，在函数前乘系数可得不同幅度
- square(a*t,duty); 产生**周期**方波信号，a=1时，周期为 $2\pi$ ，峰值为 $\pm1$ ；duty为占比单位是%，取0-100
- conv(ft1,ft2); 求这两个函数的卷积结果

:::warning

Matlab中的卷积函数conv(f1,f2)不区分离散和连续，都按照离散的形式来计算

:::

# 绘制零极点图
### 连续系统

$$
H(s)=\frac{s^2+4s+3}{s^4+3s^3+4s^2+6s+4}
$$

```matlab
b=[1 4 3];          %分子系数矩阵，且为高次向低次
a=[1 3 4 6 4];      %分母系数矩阵
sys=tf(b,a);
pzmap(sys);
sgrid;
zap=roots(a);
```
![](https://pic.akorin.icu/20250225225143483.png)

### 离散系统

$$
H(z)=\frac{z^{-1}+2z^{-2}+z^{-3}}{1-0.5z^{-1}-0.005z^{-2}+0.3z^{-3}}
$$

```matlab
b=[1 2 1];
a=[1 -0.5 -0.005 0.3];
figure(1);
zplane(b,a);
title('零极点分布图');
num=[0 1 2 1];
den=[1 -0.5 -0.005 0.3];
h=impz(num,den);
figure(2);
stem(h,'.');
title('冲激响应图');
[H,w]=freqz(num,den);
figure(3);
plot(w/pi,abs(H));
title('幅频响应');
```

<div class="flex flex-col">

<div class="flex grid-cols-2 justify-center items-center">

![](https://pic.akorin.icu/20250225235445908.png)

![](https://pic.akorin.icu/20250225235457967.png)

![](https://pic.akorin.icu/20250225235507923.png)

</div>

</div>

```matlab
stem(h,'.');
```
h是要绘制的离散数据；'.'表示一个字符串，指定绘制数据点的标记样式

### 函数

- tf(b,a); 生成系统函数，b为分子系数向量，a为分母系数向量
- pzmap(sys); 绘制系统函数sys的零极点图
- sgrid; 绘制极坐标网格
- zap=roots(a); 求出零极点
- zplane(b,a); 绘制零极点分布图，分子不含常数项
- h=impz(num,den); 计算和绘制离散时间系统的单位脉冲响应（冲激响应），分子包含常数项
- [H,w]=freqz(num,den); 求频率响应，分子包含常数项，结果有幅值及对应的角频率

# 求响应
