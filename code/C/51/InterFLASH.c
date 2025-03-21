#include <reg52.h>
#include <intrins.h>

sfr ISP_DATA = 0xe2;
sfr ISP_ADDRH = 0xe3;
sfr ISP_ADDRL = 0xe4;
sfr ISP_CMD = 0xe5;
sfr ISP_TRIG = 0xe6;
sfr ISP_CONTR = 0xe7;

/* -------------------------------------------------------------------------- */
/*                                 关闭ISP/IAP操作                                */
/* -------------------------------------------------------------------------- */
void Q0()
{
    ISP_CONTR = 0; // 关闭IAP功能
    ISP_CMD = 0;   // 待机模式，无ISP操作
    ISP_TRIG = 0;  // 关闭IAP功能, 清与ISP有关的特殊功能寄存器
    EA = 1;
}
/* -------------------------------------------------------------------------- */
/*                              擦除某一扇区（每个扇区512字节）                             */
/* -------------------------------------------------------------------------- */
void clearSector(unsigned int addr)
{
    // 打开 IAP 功能(ISP_CONTR.7)=1:允许编程改变Flash, 设置Flash操作等待时间
    // 0x83(晶振<5M)   0x82(晶振<10M)   0x81(晶振<20M)   0x80(晶振<40M)
    ISP_CONTR = 0x81;
    ISP_CMD = 0x03;        // 用户可以对"Data Flash/EEPROM区"进行扇区擦除
    ISP_ADDRL = addr;      // ISP/IAP操作时的地址寄存器低八位，
    ISP_ADDRH = addr >> 8; // ISP/IAP操作时的地址寄存器高八位。
    EA = 0;                //
    ISP_TRIG = 0x46;       // 在ISPEN(ISP_CONTR.7)=1时,对ISP_TRIG先写入46h，
    ISP_TRIG = 0xB9;       // 再写入B9h,ISP/IAP命令才会生效。
    _nop_();
    Q0(); // 关闭ISP/IAP
}
/* -------------------------------------------------------------------------- */
/*                                    写一字节                                    */
/* -------------------------------------------------------------------------- */
void writeByte(unsigned int addr, unsigned char dat)
{
    ISP_CONTR = 0x81;
    ISP_CMD = 0x02; // 用户可以对"Data Flash/EEPROM区"进行字节编程
    ISP_ADDRL = addr;
    ISP_ADDRH = addr >> 8;
    ISP_DATA = dat; // 数据进ISP_DATA
    EA = 0;
    ISP_TRIG = 0x46;
    ISP_TRIG = 0xB9;
    _nop_();
    Q0(); // 关闭ISP/IAP
}
/* -------------------------------------------------------------------------- */
/*                                    读一字节                                    */
/* -------------------------------------------------------------------------- */
unsigned char readByte(unsigned int addr)
{
    unsigned char dat;
    ISP_CONTR = 0x81;
    ISP_CMD = 0x01; // 用户可以对"Data Flash/EEPROM区"进行字节读
    ISP_ADDRL = addr;
    ISP_ADDRH = addr >> 8;
    EA = 0;
    ISP_TRIG = 0x46;
    ISP_TRIG = 0xB9;
    _nop_();
    dat = ISP_DATA; // 取出数据
    Q0();           // 关闭ISP/IAP
    return dat;
}

void main(){
    //写数据之前需要先擦除
    clearSector(0x2000);
    writeByte(0x2000, 1);
}