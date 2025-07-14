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
codeHeightLimit: 550
time_warning: false
end: false
---

## 怎么这么难啊
在C语言的基础上继续学习CPP

<!-- more -->

## C++基础知识

### `extern` 的用法

在预编译的过程中，会自动展开头文件。因此定义在头文件的变量就会被多次定义。  
`extern` 关键字用于声明一个变量或函数，使其可以在其他文件中访问，而不在当前文件中分配内存。  

::: info 总结
头文件只做变量的声明，不能做变量的定义  
头文件声明变量可以采用extern的方式
:::

### 变量作用域
与C不同C++多了几种作用域。作用域决定了变量的生命周期和可见性。

1. 全局作用域：在函数外部声明变量，一般只在需要的时候才使用，便于代码维护
2. 局部作用域：在函数内部、 `if` 语句或 `for` 循环内声明的变量。它们只在声明的代码块内被访问。
3. 命名空间作用域：在命名空间中声明的变量
4. 类作用域：在类内部声明的变量和成员函数。成员变量和成员函数只能通过类的对象访问，而在某些情况（如静态成员）可以直接通过类名访问。
5. 块作用域：是局部作用域的一个特例，在函数中额外用大括号 `{}` 来包围的代码块内声明的变量，这些变量只能在代码块内被访问，即使在函数内但是超出代码块也依旧不能访问。


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
4. 堆区（Heap Segment）：由程序员通过动态分配函数（ `new` 或 `malloc` ）分配的内存区域。堆的内存分配和释放是手动的，由程序员需要负责管理的内存，避免内存泄漏或野指针等问题。
5. 常量区（Constant Area）：存储如字符串常量、 `const` 饰的全局变量的区域，这部分内存也是只读的。在C++中，使用双引号括起来的字符串字面量通常存储在常量区。若 `const` 修饰的全局变量的值在编译时就已确定，则也可能存储在常量区。

:::tip 
`const` 修饰的变量是只读的，编译器处理时一般时直接将 `const` 修饰的变量替换成其初始化的值。默认情况下 `const` 对象被设定为仅在文件内有效，因此当多个文件中出现了同名的 `const` 修饰的变量时，其实相当于在不同的文件中定义了不同的变量。比如filea.c和fileb.c都包含了fileh.h文件，而fileh.h中声明了一个 `const` 修饰的变量var，filea.c和fileb.c中引用该变量其实是不同的，即filea.c中的var与fileb.c中的var地址不相同。
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
使用符号 `&` 表示引用，此时变量 `a` 和 `b` 的地址相同。此时修改b的值相当于修改a的值，b就是a的别名。

:::warning 注意
1. 必须初始化。在创建引用时，必须指向一个已存在的对象。
2. 一旦引用绑定后就不能再修改。
3. 不能存在空引用。
:::

#### 左值引用和右值引用
在C++中左值( `lvalue` )和右值( `rvalue` )是表达式的两种基本分类，它们决定了表达式的结果在内存中的位置和状态。  
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
`nullptr` 为空指针，在C++中 0为 `false` ，非0为 `true`。  
指针存储的是地址，因此指针有两种赋值方式：
1. **直接赋值**，但是这不常用。
2. 利用**取地址符号** `&` 获取变量的地址并将其传给指针。取地址符号 `&` 获取的地址只能传给指针类型的变量，否则会报错。

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

#### 万能指针和指向指针的指针

`void*` 是一种特殊的指针类型，能够存放任意对象的地址。`void*` 指针存放一个地址，但是该地址存放的数据类型是不知道的。  
由于不知道 `void*` 指向的对象的类型，因此不能利用 `void*` 直接去操作指向的对象。

`void*` 主要用来和别的指针进行比较、作为函数的输入或输出，或赋给另一个 `void*` 指针。

除了万能指针还有指向指针的指针，即`**ptr`，指向指针的指针存取的是另一个指针的地址。

#### 指针和数组

指针能够通过自增和自减来控制指针存取的地址，通过这种特性，将指针指向一个数组，并让指针自增自减就能起到指针选取不同数组内的元素。  
当指针指向数组时，一般指向数组的第一个元素。  

```C++
//指针可以进行算术运算，如递增（++）和递减（--），
// 这些操作会改变指针所指向的内存地址。但是，这种操作仅限于指向数组元素的指针。
int arr[5] = {1, 2, 3, 4, 5};
int *ptr_arr = arr;
std::cout << "ptr_arr is : " << ptr_arr << std::endl;
int firstElement = *ptr_arr;
std::cout << "firstElement is " << firstElement << std::endl;
// 递增指针
++ptr_arr; // ptr 现在指向 arr[1]
std::cout << "ptr_arr is : " << ptr_arr << std::endl;
// 访问新位置的值
int secondElement = *ptr_arr; // secondElement 等于 2
std::cout << "secondElement is " << secondElement;
```
上面的代码可以看出指针指向数组时，**数组不用取地址符号**。因为数组名在表达式中会自动转换为**指向其首元素的指针**，即 `arr` 是一个指针并指向数组的第一个元素，也即 `arr` 存取数组第一个元素的地址。在上面的代码中 `arr` 表示数组的首地址，类型为 `int*` 等价于
```C++
arr = &arr[0];
int *ptr_arr = &arr[0];
```

### `const`

`const` 修饰的变量为常量，必须初始化且在不能修改。通过 `const` 提高代码的安全性和可读性。

指针本身也是变量，因此也能够被`const`修饰。

#### `const` 在声明变量中的位置

`const` 关键字一般放在变量类型之前：
```C++
const int a =10;
```
也可以放在变量类型之后，但比较少见：
```C++
int const a = 10;
```

#### `const`引用

当有 `const` 关键词修饰变量时，其引用也必须是 `const` 修饰的；被引用地变量没有 `const` 修饰时，其引用也可以用 `const` 修饰。  
`const` 修饰的引用变量类型可以与被引用的变量类型不同，在编译过程中会进行隐式地类型转换。  
C++ 允许常量引用绑定到类型不同的右值或临时变量。

```C++
double dval = 3.14;
int &rd = dval;       // [!code error] 错误
const int &rt = dval; // 正确
// 相当于
const int temp = dval;
const int &rt = temp;
```
此时 `rt` 绑定了一个临时对象 `temp`， 对象 `temp` 进行类型转换。临时对象常常被称作**临时量**。

#### 常量指针

指针也能够被 `const` 修饰，类似于常量对象，在初始化后指向的对象就不能被改变。  
要指向常量对象，必须使用常量指针：
```C++
const double PI = 3.14;
double * ptr = &PI;       // [!code error] 错误
const double *cptr0 = &PI; // 正确  普通指针
const double *const cptr1 = &PI; // 正确  常量指针
```
`cptr0` 是指向常量的指针，可以修改指向的对象。  
`cptr1` 是指向常量的**常量指针**，不能修改指向的对象。

```C++
const int a = 10;
const int b = 20;
int c = 30;
const int *ptra = &a;
ptra = &b;  // 正确
const int *const ptrb = &a;
ptrb = &b;  // [!code error] 错误
const int *ptrc = &c;  // 正确
const double *ptrc = &c;  // [!code error] 错误
```
在上面代码中 
```C++
const int *const ptrb = &a;
```
前一个 `const` 称作底层 `const` ，后一个 `const` 称作顶层 `const`。

1. **顶层** `const` 表示任意的对象是常量，这一点对任何数据类型都适用，如算术类型、类、指针等。
2. **底层** `const` 则与指针和引用等复合类型的基本类型部分有关。比较特殊的是，指针类型既可以是顶层 `const` 也可以是底层 `const` ，这一点和其他类型相比区别明显。

```C++
const int *ptrc = &c;
const double *ptrc = &c;// [!code error]
```
C++ **不允许**不同类型的指针直接相互赋值，即使都是常量指针，这点与常量引用不同。  
只有底层 `const` 修饰指针，表示该指针不能修改指向对象的值，但是可以修改指向的对象。

#### `constexpr` 和常量表达式

`constexpr` 是 **C++11**新标准引入的新类型。C++11允许将变量声明为 `constexpr` 类型，让编译器在编译期间就将该类型的值转换成字面量。 `constexpr` 修饰的变量也一定是常量。

`constexpr` 修饰的指针其初始值必须是0或 `nullprt` ，也可以是某个固定地址中的对象（全局对象等）。  
