---
title: 51单片机编程
date: 2025-03-15
updated: 2025-03-21
categories: 笔记
tags:
  - 笔记
  - 51单片机
  - C
top: 5
codeHeightLimit: 350
cover: 'https://pic.akorin.icu/20250315185018179.png'
end: false
---

51单片机主要使用的函数
 
<!-- more -->

## 定时器&中断
- 定时器
  - Timer0
  - Timer1
- 定时模式
  - 模式0：13位定时/计数器
  - 模式1：16位定时/计数器
  - 模式2：8位自动重载/定时计数器
  - 模式3：仅限定时器0，Timer0分为两个8位计数器
- 中断
  - 外部中断0，使用中断号0
  - 定时中断0，使用中断号1
  - 外部中断1，使用中断号2
  - 定时中断1，使用中断号3
  - 串口中断

> **计算定时时间公式**

$$
(2^{16}-X)\times \frac{12}{f_n}=Time
$$

> 其中X为定时器初始计数值（填装进Tlx，Thx寄存器）， $f_n$ 为晶振频率


:::code-group
<<< @/code/C/51/51withTimer.c{c}[51单片机定时器及外部中断设计]
:::

## 写内部FLASH

STC89C52/AT89C52内部FLASH扇区地址：
