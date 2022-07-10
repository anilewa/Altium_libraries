#include <stdint.h>
#include "graphics.h"
#include <font.h>

#define BPMONO8_SPACE          7
#define BPMONO8_FIRST_CHAR     33
#define BPMONO8_CHARS          94
#define BPMONO8_HEIGHT         13
#define BPMONO8_WORDS_PER_LINE 1
#define BPMONO8_BITS_PER_PIXEL 2

const uint16_t bpmono8_data[BPMONO8_CHARS][BPMONO8_WORDS_PER_LINE * BPMONO8_HEIGHT + 1] =
{
    {  7, 0x0000,  0x0000,  0x0F00,  0x0F00,  0x0F00,  0x0F00,  0x0F00,  0x0000,  0x0F00,  0x0F00,  0x0000,  0x0000,  0x0000,},
    {  7, 0x0000,  0x0000,  0x3300,  0x3300,  0x3300,  0x0000,  0x0000,  0x0000,  0x0000,  0x0000,  0x0000,  0x0000,  0x0000,},
    {  7, 0x0000,  0x0000,  0x0000,  0x3300,  0x3300,  0xFFC0,  0x3300,  0xFFC0,  0x3300,  0x3300,  0x0000,  0x0000,  0x0000,},
    {  7, 0x0000,  0x0000,  0x0300,  0x0FC0,  0x3000,  0x0C00,  0x0300,  0x00C0,  0x3F00,  0x0C00,  0x0000,  0x0000,  0x0000,},
    {  7, 0x0000,  0x0000,  0x30C0,  0xCCC0,  0xCF00,  0x3300,  0x0CC0,  0x3330,  0x3330,  0xC0C0,  0x0000,  0x0000,  0x0000,},
    {  7, 0x0000,  0x0000,  0x3C00,  0xC300,  0xC300,  0x3C00,  0x3C30,  0xC330,  0xC0C0,  0x3F00,  0x0000,  0x0000,  0x0000,},
    {  7, 0x0000,  0x0000,  0x0300,  0x0300,  0x0300,  0x0000,  0x0000,  0x0000,  0x0000,  0x0000,  0x0000,  0x0000,  0x0000,},
    {  7, 0x0000,  0x0000,  0x0300,  0x0C00,  0x3000,  0x3000,  0x3000,  0x3000,  0x3000,  0x0C00,  0x0300,  0x0000,  0x0000,},
    {  7, 0x0000,  0x0000,  0x3000,  0x0C00,  0x0300,  0x0300,  0x0300,  0x0300,  0x0300,  0x0C00,  0x3000,  0x0000,  0x0000,},
    {  7, 0x0000,  0x0CC0,  0x0300,  0x0FC0,  0x0300,  0x0CC0,  0x0000,  0x0000,  0x0000,  0x0000,  0x0000,  0x0000,  0x0000,},
    {  7, 0x0000,  0x0000,  0x0000,  0x0000,  0x0C00,  0x0C00,  0xFFC0,  0x0C00,  0x0C00,  0x0000,  0x0000,  0x0000,  0x0000,},
    {  7, 0x0000,  0x0000,  0x0000,  0x0000,  0x0000,  0x0000,  0x0000,  0x0000,  0x0000,  0x0300,  0x0F00,  0x0C00,  0x0000,},
    {  7, 0x0000,  0x0000,  0x0000,  0x0000,  0x0000,  0x0000,  0xFFC0,  0x0000,  0x0000,  0x0000,  0x0000,  0x0000,  0x0000,},
    {  7, 0x0000,  0x0000,  0x0000,  0x0000,  0x0000,  0x0000,  0x0000,  0x0000,  0x0F00,  0x0F00,  0x0000,  0x0000,  0x0000,},
    {  7, 0x0000,  0x0000,  0x00C0,  0x00C0,  0x0300,  0x0300,  0x0C00,  0x0C00,  0x3000,  0x3000,  0x0000,  0x0000,  0x0000,},
    {  7, 0x0000,  0x0000,  0x3FC0,  0xC030,  0xC0F0,  0xC330,  0xCC30,  0xF030,  0xC030,  0x3FC0,  0x0000,  0x0000,  0x0000,},
    {  7, 0x0000,  0x0000,  0x0300,  0x0F00,  0x3300,  0x0300,  0x0300,  0x0300,  0x0300,  0x3FF0,  0x0000,  0x0000,  0x0000,},
    {  7, 0x0000,  0x0000,  0x3F00,  0xC0C0,  0x00C0,  0x0300,  0x0C00,  0x3000,  0xC000,  0xFFC0,  0x0000,  0x0000,  0x0000,},
    {  7, 0x0000,  0x0000,  0x0F00,  0x30C0,  0x00C0,  0x0F00,  0x00C0,  0x00C0,  0x30C0,  0x0F00,  0x0000,  0x0000,  0x0000,},
    {  7, 0x0000,  0x0000,  0x0300,  0x0F00,  0x3300,  0xC300,  0xC300,  0xFFC0,  0x0300,  0x0300,  0x0000,  0x0000,  0x0000,},
    {  7, 0x0000,  0x0000,  0x3FC0,  0xC000,  0xC000,  0xFF00,  0x00C0,  0x00C0,  0x00C0,  0xFF00,  0x0000,  0x0000,  0x0000,},
    {  7, 0x0000,  0x0000,  0x0F00,  0x3000,  0xC000,  0xCF00,  0xF0C0,  0xC0C0,  0xC0C0,  0x3F00,  0x0000,  0x0000,  0x0000,},
    {  7, 0x0000,  0x0000,  0x3FC0,  0x00C0,  0x0300,  0x0300,  0x0C00,  0x0C00,  0x3000,  0x3000,  0x0000,  0x0000,  0x0000,},
    {  7, 0x0000,  0x0000,  0x0F00,  0x30C0,  0x30C0,  0x0F00,  0x30C0,  0x30C0,  0x30C0,  0x0F00,  0x0000,  0x0000,  0x0000,},
    {  7, 0x0000,  0x0000,  0x3F00,  0xC0C0,  0xC0C0,  0xC0C0,  0x3FC0,  0x00C0,  0x0300,  0x3C00,  0x0000,  0x0000,  0x0000,},
    {  7, 0x0000,  0x0000,  0x0000,  0x0000,  0x0000,  0x3C00,  0x3C00,  0x0000,  0x3C00,  0x3C00,  0x0000,  0x0000,  0x0000,},
    {  7, 0x0000,  0x0000,  0x0000,  0x0000,  0x0000,  0x0F00,  0x0F00,  0x0000,  0x0000,  0x0F00,  0x0F00,  0x3C00,  0x0000,},
    {  7, 0x0000,  0x0000,  0x0000,  0x0000,  0x0000,  0x0300,  0x0C00,  0x3000,  0x0C00,  0x0300,  0x0000,  0x0000,  0x0000,},
    {  7, 0x0000,  0x0000,  0x0000,  0x0000,  0x0000,  0x3FF0,  0x0000,  0x0000,  0x3FF0,  0x0000,  0x0000,  0x0000,  0x0000,},
    {  7, 0x0000,  0x0000,  0x0000,  0x0000,  0x0000,  0x0C00,  0x0300,  0x00C0,  0x0300,  0x0C00,  0x0000,  0x0000,  0x0000,},
    {  7, 0x0000,  0x0000,  0x0F00,  0x30C0,  0x00C0,  0x00C0,  0x0300,  0x0C00,  0x0000,  0x0C00,  0x0000,  0x0000,  0x0000,},
    {  7, 0x0000,  0x0000,  0x0000,  0x0000,  0x3F00,  0xC0C0,  0xCFC0,  0xCCC0,  0xCFC0,  0xC000,  0x3F00,  0x0000,  0x0000,},
    {  7, 0x0000,  0x0000,  0x0F00,  0x0F00,  0x30C0,  0x30C0,  0x30C0,  0x3FC0,  0x30C0,  0x30C0,  0x0000,  0x0000,  0x0000,},
    {  7, 0x0000,  0x0000,  0xFF00,  0xC0C0,  0xC0C0,  0xFF00,  0xC0C0,  0xC0C0,  0xC0C0,  0xFF00,  0x0000,  0x0000,  0x0000,},
    {  7, 0x0000,  0x0000,  0x0FC0,  0x3000,  0xC000,  0xC000,  0xC000,  0xC000,  0x3000,  0x0FC0,  0x0000,  0x0000,  0x0000,},
    {  7, 0x0000,  0x0000,  0x3F00,  0x30C0,  0x3030,  0x3030,  0x3030,  0x3030,  0x30C0,  0x3F00,  0x0000,  0x0000,  0x0000,},
    {  7, 0x0000,  0x0000,  0x3FC0,  0x3000,  0x3000,  0x3F00,  0x3000,  0x3000,  0x3000,  0x3FC0,  0x0000,  0x0000,  0x0000,},
    {  7, 0x0000,  0x0000,  0x3FC0,  0x3000,  0x3000,  0x3F00,  0x3000,  0x3000,  0x3000,  0x3000,  0x0000,  0x0000,  0x0000,},
    {  7, 0x0000,  0x0000,  0x0FC0,  0x3000,  0xC000,  0xC000,  0xC3F0,  0xC030,  0x3030,  0x0FC0,  0x0000,  0x0000,  0x0000,},
    {  7, 0x0000,  0x0000,  0x30C0,  0x30C0,  0x30C0,  0x3FC0,  0x30C0,  0x30C0,  0x30C0,  0x30C0,  0x0000,  0x0000,  0x0000,},
    {  7, 0x0000,  0x0000,  0x3FF0,  0x0300,  0x0300,  0x0300,  0x0300,  0x0300,  0x0300,  0x3FF0,  0x0000,  0x0000,  0x0000,},
    {  7, 0x0000,  0x0000,  0x3FC0,  0x00C0,  0x00C0,  0x00C0,  0x00C0,  0x00C0,  0x00C0,  0xFF00,  0x0000,  0x0000,  0x0000,},
    {  7, 0x0000,  0x0000,  0xC0C0,  0xC0C0,  0xC300,  0xC300,  0xFF00,  0xC0C0,  0xC030,  0xC030,  0x0000,  0x0000,  0x0000,},
    {  7, 0x0000,  0x0000,  0x3000,  0x3000,  0x3000,  0x3000,  0x3000,  0x3000,  0x3000,  0x3FC0,  0x0000,  0x0000,  0x0000,},
    {  7, 0x0000,  0x0000,  0xC0C0,  0xC0C0,  0xF3C0,  0xFFC0,  0xCCC0,  0xC0C0,  0xC0C0,  0xC0C0,  0x0000,  0x0000,  0x0000,},
    {  7, 0x0000,  0x0000,  0x30C0,  0x30C0,  0x3CC0,  0x33C0,  0x30C0,  0x30C0,  0x30C0,  0x30C0,  0x0000,  0x0000,  0x0000,},
    {  7, 0x0000,  0x0000,  0x3F00,  0xC0C0,  0xC0C0,  0xC0C0,  0xC0C0,  0xC0C0,  0xC0C0,  0x3F00,  0x0000,  0x0000,  0x0000,},
    {  7, 0x0000,  0x0000,  0x3F00,  0x30C0,  0x30C0,  0x30C0,  0x30C0,  0x3F00,  0x3000,  0x3000,  0x0000,  0x0000,  0x0000,},
    {  7, 0x0000,  0x0000,  0x3F00,  0xC0C0,  0xC0C0,  0xC0C0,  0xC0C0,  0xC0C0,  0xC0C0,  0x3F00,  0x0C00,  0x03C0,  0x0000,},
    {  7, 0x0000,  0x0000,  0x3FC0,  0x3030,  0x3030,  0x3030,  0x3FC0,  0x30C0,  0x3030,  0x3030,  0x0000,  0x0000,  0x0000,},
    {  7, 0x0000,  0x0000,  0x0FC0,  0x3000,  0x3000,  0x0C00,  0x0300,  0x00C0,  0x00C0,  0x3F00,  0x0000,  0x0000,  0x0000,},
    {  7, 0x0000,  0x0000,  0xFFC0,  0x0C00,  0x0C00,  0x0C00,  0x0C00,  0x0C00,  0x0C00,  0x0C00,  0x0000,  0x0000,  0x0000,},
    {  7, 0x0000,  0x0000,  0x3030,  0x3030,  0x3030,  0x3030,  0x3030,  0x3030,  0x3030,  0x0FC0,  0x0000,  0x0000,  0x0000,},
    {  7, 0x0000,  0x0000,  0xC0C0,  0xC0C0,  0x3300,  0x3300,  0x3300,  0x3300,  0x0C00,  0x0C00,  0x0000,  0x0000,  0x0000,},
    {  7, 0x0000,  0x0000,  0xC0C0,  0xCCC0,  0xCCC0,  0xCCC0,  0xCCC0,  0xCCC0,  0x3F00,  0x3300,  0x0000,  0x0000,  0x0000,},
    {  7, 0x0000,  0x0000,  0x3030,  0x3030,  0x0CC0,  0x0300,  0x0300,  0x0CC0,  0x3030,  0x3030,  0x0000,  0x0000,  0x0000,},
    {  7, 0x0000,  0x0000,  0x3030,  0x3030,  0x3030,  0x0CC0,  0x0CC0,  0x0300,  0x0300,  0x0300,  0x0000,  0x0000,  0x0000,},
    {  7, 0x0000,  0x0000,  0x3FF0,  0x0030,  0x00C0,  0x0300,  0x0C00,  0x3000,  0x3000,  0x3FF0,  0x0000,  0x0000,  0x0000,},
    {  7, 0x0000,  0x3F00,  0x3000,  0x3000,  0x3000,  0x3000,  0x3000,  0x3000,  0x3000,  0x3000,  0x3F00,  0x0000,  0x0000,},
    {  7, 0x0000,  0x0000,  0x3000,  0x3000,  0x0C00,  0x0C00,  0x0300,  0x0300,  0x00C0,  0x00C0,  0x0000,  0x0000,  0x0000,},
    {  7, 0x0000,  0x0FC0,  0x00C0,  0x00C0,  0x00C0,  0x00C0,  0x00C0,  0x00C0,  0x00C0,  0x00C0,  0x0FC0,  0x0000,  0x0000,},
    {  7, 0x0000,  0x0000,  0x0300,  0x0CC0,  0x0000,  0x0000,  0x0000,  0x0000,  0x0000,  0x0000,  0x0000,  0x0000,  0x0000,},
    {  7, 0x0000,  0x0000,  0x0000,  0x0000,  0x0000,  0x0000,  0x0000,  0x0000,  0x0000,  0x0FC0,  0x0000,  0x0000,  0x0000,},
    {  7, 0x0000,  0x0000,  0x0C00,  0x0300,  0x0000,  0x0000,  0x0000,  0x0000,  0x0000,  0x0000,  0x0000,  0x0000,  0x0000,},
    {  7, 0x0000,  0x0000,  0x0000,  0x0000,  0x3F00,  0x00C0,  0x00C0,  0x0FC0,  0x30C0,  0x3FF0,  0x0000,  0x0000,  0x0000,},
    {  7, 0x0000,  0x0000,  0x3000,  0x3000,  0x3FC0,  0x3030,  0x3030,  0x3030,  0x3030,  0x3FC0,  0x0000,  0x0000,  0x0000,},
    {  7, 0x0000,  0x0000,  0x0000,  0x0000,  0x3FC0,  0xC000,  0xC000,  0xC000,  0xC000,  0x3FC0,  0x0000,  0x0000,  0x0000,},
    {  7, 0x0000,  0x0000,  0x00C0,  0x00C0,  0x3FC0,  0xC0C0,  0xC0C0,  0xC0C0,  0xC3C0,  0x3CC0,  0x0000,  0x0000,  0x0000,},
    {  7, 0x0000,  0x0000,  0x0000,  0x0000,  0x3FC0,  0xC030,  0xFFF0,  0xC000,  0xC000,  0x3FF0,  0x0000,  0x0000,  0x0000,},
    {  7, 0x0000,  0x03F0,  0x0C00,  0x0C00,  0x3FF0,  0x0C00,  0x0C00,  0x0C00,  0x0C00,  0x3FF0,  0x0000,  0x0000,  0x0000,},
    {  7, 0x0000,  0x0000,  0x0000,  0x0000,  0x3FC0,  0xC0C0,  0xC0C0,  0xC0C0,  0xC0C0,  0x3FC0,  0x00C0,  0x3F00,  0x0000,},
    {  7, 0x0000,  0x0000,  0xC000,  0xC000,  0xCF00,  0xF0C0,  0xC0C0,  0xC0C0,  0xC0C0,  0xC0C0,  0x0000,  0x0000,  0x0000,},
    {  7, 0x0000,  0x0000,  0x0300,  0x0000,  0x3F00,  0x0300,  0x0300,  0x0300,  0x0300,  0x3FF0,  0x0000,  0x0000,  0x0000,},
    {  7, 0x0000,  0x0000,  0x00C0,  0x0000,  0x3FC0,  0x00C0,  0x00C0,  0x00C0,  0x00C0,  0x00C0,  0x00C0,  0x00C0,  0x3F00,},
    {  7, 0x0000,  0x0000,  0x3000,  0x3000,  0x30C0,  0x30C0,  0x3F00,  0x3300,  0x30C0,  0x30C0,  0x0000,  0x0000,  0x0000,},
    {  7, 0x0000,  0x0000,  0xFC00,  0x0C00,  0x0C00,  0x0C00,  0x0C00,  0x0C00,  0x0C00,  0xFFC0,  0x0000,  0x0000,  0x0000,},
    {  7, 0x0000,  0x0000,  0x0000,  0x0000,  0xCCC0,  0xFFC0,  0xCCC0,  0xCCC0,  0xCCC0,  0xCCC0,  0x0000,  0x0000,  0x0000,},
    {  7, 0x0000,  0x0000,  0x0000,  0x0000,  0x33C0,  0x3C30,  0x3030,  0x3030,  0x3030,  0x3030,  0x0000,  0x0000,  0x0000,},
    {  7, 0x0000,  0x0000,  0x0000,  0x0000,  0x0FC0,  0x3030,  0x3030,  0x3030,  0x3030,  0x0FC0,  0x0000,  0x0000,  0x0000,},
    {  7, 0x0000,  0x0000,  0x0000,  0x0000,  0x33C0,  0x3C30,  0x3030,  0x3030,  0x3030,  0x3FC0,  0x3000,  0x3000,  0x0000,},
    {  7, 0x0000,  0x0000,  0x0000,  0x0000,  0x0FF0,  0x3030,  0x3030,  0x3030,  0x3030,  0x0FF0,  0x0030,  0x0030,  0x0000,},
    {  7, 0x0000,  0x0000,  0x0000,  0x0000,  0x3CF0,  0x0F00,  0x0C00,  0x0C00,  0x0C00,  0x3FC0,  0x0000,  0x0000,  0x0000,},
    {  7, 0x0000,  0x0000,  0x0000,  0x0000,  0x0FC0,  0x3000,  0x0C00,  0x0300,  0x00C0,  0x3F00,  0x0000,  0x0000,  0x0000,},
    {  7, 0x0000,  0x0000,  0x0000,  0x0C00,  0xFFC0,  0x0C00,  0x0C00,  0x0C00,  0x0C00,  0x03C0,  0x0000,  0x0000,  0x0000,},
    {  7, 0x0000,  0x0000,  0x0000,  0x0000,  0x30C0,  0x30C0,  0x30C0,  0x30C0,  0x30C0,  0x0F30,  0x0000,  0x0000,  0x0000,},
    {  7, 0x0000,  0x0000,  0x0000,  0x0000,  0x30C0,  0x30C0,  0x30C0,  0x30C0,  0x0F00,  0x0F00,  0x0000,  0x0000,  0x0000,},
    {  7, 0x0000,  0x0000,  0x0000,  0x0000,  0xC0C0,  0xCCC0,  0xCCC0,  0xCCC0,  0xFFC0,  0x3300,  0x0000,  0x0000,  0x0000,},
    {  7, 0x0000,  0x0000,  0x0000,  0x0000,  0x30C0,  0x30C0,  0x0F00,  0x0F00,  0x30C0,  0x30C0,  0x0000,  0x0000,  0x0000,},
    {  7, 0x0000,  0x0000,  0x0000,  0x0000,  0x30C0,  0x30C0,  0x30C0,  0x0CC0,  0x0F00,  0x0300,  0x0C00,  0x0C00,  0x0000,},
    {  7, 0x0000,  0x0000,  0x0000,  0x0000,  0x3FC0,  0x00C0,  0x0300,  0x0C00,  0x3000,  0x3FC0,  0x0000,  0x0000,  0x0000,},
    {  7, 0x0000,  0x0300,  0x0C00,  0x0C00,  0x0300,  0x0C00,  0x0300,  0x0300,  0x0C00,  0x0C00,  0x0300,  0x0000,  0x0000,},
    {  7, 0x0000,  0x0300,  0x0300,  0x0300,  0x0300,  0x0000,  0x0000,  0x0300,  0x0300,  0x0300,  0x0300,  0x0000,  0x0000,},
    {  7, 0x0000,  0x0C00,  0x0300,  0x0300,  0x0C00,  0x0300,  0x0C00,  0x0C00,  0x0300,  0x0300,  0x0C00,  0x0000,  0x0000,},
    {  7, 0x0000,  0x0000,  0x0000,  0x0000,  0x0000,  0x0000,  0x3000,  0xCCC0,  0x0300,  0x0000,  0x0000,  0x0000,  0x0000,}
};

const font_t bpmono8 = {BPMONO8_BITS_PER_PIXEL, BPMONO8_WORDS_PER_LINE, BPMONO8_HEIGHT, BPMONO8_HEIGHT - (BPMONO8_HEIGHT >> 2), BPMONO8_FIRST_CHAR, BPMONO8_CHARS, BPMONO8_SPACE, (uint16_t*)bpmono8_data[0] };

