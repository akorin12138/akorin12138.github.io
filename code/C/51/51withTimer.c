// 1ms@11.0592Mhz
void Timer0Init()
{
    EA = 0;
    TMOD &= 0xF0;
    TMOD |= 0x01; // 设定定时模式1

    // 计算公式：(2^16 - X) * 12 / 晶振频率 = 定时时间（us）
    TL0 = (65536 - 922) * 256;
    TH0 = (65536 - 922) / 256;
    TF0 = 0;
    TR0 = 0;
    ET0 = 1;
    TR0 = 1;
    EA = 1;
}

// 外部中断0
void EX0Init()
{
    // 中断允许寄存器IE
    EX0 = 1; // 开启0号外部中断
    // 控制寄存器TCON
    IT0 = 1; // 设置外部中断触发方式.  // 0-低电平触发  // 1-负跳变触发
    EA = 1;  // 开启总中断
}

void EX0Interrupt() interrupt 0
{
}
void timer0Interrupt() interrupt 1
{
    TF0 = 0;
    TL0 = (65536 - 922) * 256;
    TH0 = (65536 - 922) / 256;
}