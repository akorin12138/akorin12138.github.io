#include <reg51.h>

typedef unsigned char u8;
typedef unsigned int u32;

u8 LEDNum[10] = {0xc0, 0xf9, 0xa4, 0xb0, // 数码管显示值０－Ｆ对应的段码值//
                 0x99, 0x92, 0x82, 0xf8,
                 0x80, 0x90};

void SoftDelay(u32 time)
{
    while (time--)
        ;
}

void main()
{
    u8 cursor = 0;
    while (1)
    {
        SoftDelay(0xabcd);
        cursor++;
        cursor %= 10;
        P0 = LEDNum[cursor];
    }
}