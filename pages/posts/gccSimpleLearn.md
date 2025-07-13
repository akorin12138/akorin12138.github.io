---
title: C++学习记录
date: 2025-07-10
updated: 2025-07-12
categories: 笔记
tags:
  - 学习
  - 编程
  - C++
cover: 'https://pic.akorin.icu/c++cover.jpg'
codeHeightLimit: 350
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

::: info 总结
头文件只做变量的声明，不能做变量的定义  
头文件声明变量可以采用extern的方式
:::

### 变量作用域
与C不同C++多了几种作用域。作用域决定了变量的生命周期和可见性。

1. 全局作用域：在函数外部声明变量，一般只在需要的时候才使用，便于代码维护
2. 局部作用域：在函数内部、`if`语句或`for`循环内声明的变量。它们只在声明的代码块内被访问。
3. 命名空间作用域：在命名空间中声明的变量
4. 类作用域：在类内部声明的变量和成员函数。成员变量和成员函数只能通过类的对象访问，而在某些情况（如静态成员）可以直接通过类名访问。
5. 块作用域：是局部作用域的一个特例，在函数中额外用大括号`{}`来包围的代码块内声明的变量，这些变量只能在代码块内被访问，即使在函数内但是超出代码块也依旧不能访问。


:::code-group
```C++ [命名空间作用域]
namespace MyNamespace {
  int namespaceVar = 10;
}

int main(){
  int a = MyNamespace::namespaceVar;
}
```
```C++ [类作用域]
class MyClass {
  public:
    int classVar;
}

int main(){
  MyClass obj;
  obj.classVar = 10;
}
```
```C++ [块作用域]
void fun() {
  {
    int a = 1;
  }
  // 下列代码尝试块外访问块内变量会导致编译错误
  // int b = a;
}
```
:::

### 存储空间
C++通过存储的数据类型、生命周期和作用域来划分。

1. 代码区（Code Segment/Text Segment）：存储程序执行代码（机器指令）的内存区域，只读，在执行程序时不会改变。
2. 全局/静态存储区（Global/Static Storage Area）：存储全局变量和静态变量的区域。
3. 栈区（Stack Segment）：存储局部变量、函数参数、返回地址等的内存区域。栈是后进先出的数据结构，存储函数调用和自动变量。
4. 堆区（Heap Segment）：由程序员通过动态分配函数（`new`或`malloc`）分配的内存区域。堆的内存分配和释放是手动的，由程序员需要负责管理的内存，避免内存泄漏或野指针等问题。
5. 常量区（Constant Area）：存储如字符串常量、`const`修饰的全局变量的区域，这部分内存也是只读的。在C++中，使用双引号括起来的字符串字面量通常存储在常量区。若`const`修饰的全局变量的值在编译时就已确定，则也可能存储在常量区。

:::tip 
`const`修饰的变量是只读的，编译器处理时一般时直接将`const`修饰的变量替换成其初始化的值。默认情况下`const`对象被设定为仅在文件内有效，因此当多个文件中出现了同名的`const`修饰的变量时，其实相当于在不同的文件中定义了不同的变量。比如filea.c和fileb.c都包含了fileh.h文件，而fileh.h中声明了一个`const`修饰的变量var，filea.c和fileb.c中引用该变量其实是不同的，即filea.c中的var与fileb.c中的var地址不相同。
:::

[代码源](https://gitbookcpp.llfc.club/sections/cpp/base/cppbase02.html)
:::code-group
```C++ [示例代码]
#include <iostream>
#include <cstring> // 用于strlen

// 全局变量，存储在全局/静态存储区
int globalVar = 10;

// 静态变量，也存储在全局/静态存储区，但仅在其声明的文件或函数内部可见
static int staticVar = 20;

void func() {
    // 局部变量，存储在栈区
    int localVar = 30;

    // 静态局部变量，虽然声明在函数内部，但存储在全局/静态存储区，且只在第一次调用时初始化
    static int staticLocalVar = 40;

    std::cout << "Inside func:" << std::endl;
    std::cout << "localVar = " << localVar << std::endl;
    std::cout << "staticLocalVar = " << staticLocalVar << std::endl;

    // 尝试通过动态内存分配在堆区分配内存
    int* heapVar = new int(50);

    std::cout << "heapVar = " << *heapVar << std::endl;

    // 释放堆区内存（重要：实际使用中不要忘记释放不再使用的堆内存）
    delete heapVar;
}

int main() {
    // 访问全局变量
    std::cout << "Inside main:" << std::endl;
    std::cout << "globalVar = " << globalVar << std::endl;
    std::cout << "staticVar = " << staticVar << std::endl; // 注意：staticVar在外部不可见（除非在同一个文件中或通过特殊方式）

    // 调用函数，展示栈区和堆区的使用
    func();

    // 字符串常量通常存储在常量区，但直接访问其内存地址并不是标准C++的做法
    // 这里我们仅通过指针来展示其存在
    const char* strConst = "Hello, World!";
    // 注意：不要尝试修改strConst指向的内容，因为它是只读的
    std::cout << "strConst = " << strConst << std::endl;
    // 尝试获取字符串常量的长度（这不会修改常量区的内容）
    std::cout << "Length of strConst = " << strlen(strConst) << std::endl;

    return 0;
}
```
```[输出结果]
Inside main:
globalVar = 10
staticVar = 20
Inside func:
localVar = 30
staticLocalVar = 40
heapVar = 50
```
:::
从下图中可以看出字符串都存储在了常量区。
![alt text](https://pic.akorin.icu/20250712171019110.png)


### 引用

引用可以看作是另一个变量的别名，其用法也较为简单：
```C++
int a = 1;
int &b = a;
```
使用符号`&`表示引用，此时变量`a`和`b`的地址相同。此时修改b的值相当于修改a的值，b就是a的别名。

:::warning 注意
1. 必须初始化。在创建引用时，必须指向一个已存在的对象。
2. 一旦引用绑定后就不能再修改。
3. 不能存在空引用。
:::

#### 左值引用和右值引用
在C++中左值(`lvalue`)和右值(`rvalue`)是表达式的两种基本分类，它们决定了表达式的结果在内存中的位置和状态。  
**左值**通常指具有持久状态的对象，有明确的内存地址，可以被多次赋值。左值引用是C++98就有的特性。  
**右值**是临时、没有持久状态的值（临时对象或即将被销毁的对象），通常没有内存地址，或其内存地址在表达式结束后变得无效。右值引用是C++11新增的特性。

:::code-group
```C++[左值引用]
int a = 10;
int& b = a; // b是a的左值引用
```
```C++[右值引用]
int&& c = 20; // c是整数字面量20的右值引用（但这种情况不常见，通常用于函数参数或返回值）

std::string foo() {
    return std::string("Hello, World!"); // 返回的临时字符串是一个右值
}

std::string &&d = foo(); // d是foo()返回的临时字符串的右值引用
```
:::
右值引用的主要用途是作为函数参数（实现移动语义）和返回值（允许链式调用等）。

### 指针

指针是一种特殊变量。它存储的是另一个变量的地址，而不是该变量本身。通过操作指针可以直接操作内存的数据。  
指针存储的是地址，因此指针有两种赋值方式：
1. **直接赋值**，但是这不常用。
2. 利用**取地址符号**`&`获取变量的地址并将其传给指针。取地址符号`&`获取的地址只能传给指针类型的变量，否则会报错。

```C++
int var = 10;
int *ptr = &var;
```
指针本身也是个变量，其存储的是另一个变量的地址，因此计算机也会为指针开辟空间，指针有自己的地址。  
再看下面的代码：
```C++
int var = 10;
int *ptr1 = &var;
int *ptr2 = ptr1;
```
ptr1是指针，存储的是var的地址，ptr2也是指针，获取了ptr1存储的值也就是var的地址，此时ptr2也指向了var。

#### 指针和引用的区别

指针与引用类似，都能够对其它对象进行间接地访问，但是指针又与引用有许多不同。
1. 指针本身就是一个对象，允许对指针赋值和拷贝，在指针地生命周期内可以指向不同的对象，而引用在初始化时就已固定。
2. 指针无须初始化。在指针未初始化时其存储的值是不确定的。
