---
title: C++学习记录
date: 2025-07-10
updated: 2025-07-11
categories: 笔记
tags:
  - 学习
  - 编程
  - C++
cover: 'https://pic.akorin.icu/c++cover.jpg'
time_warning: false
end: false
---

## 怎么这么难啊
在C语言的基础上继续学习CPP

<!-- more -->

## C++基础知识

### `extern`的用法

在预编译的过程中，会自动展开头文件。因此定义在头文件的变量就会被多次定义。  
`extern`关键字用于声明一个变量或函数，使其可以在其他文件中访问，而不在当前文件中分配内存。  

:::info
- 头文件只做变量的声明，不能做变量的定义
- 头文件声明变量可以采用extern的方式
:::