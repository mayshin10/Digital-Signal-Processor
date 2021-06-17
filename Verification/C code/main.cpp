#define _CRT_SECURE_NO_WARNINGS

#include <iostream>
#include <vector>
#include <algorithm>
#include "hex.h"
using namespace std;
char conv_char[3][480 * 272 * 50];
char filename[3][10] = { "edge.txt", "sharp.txt", "blur.txt" };

int main() {
	unsigned int conv[3][480 * 272 / 2];

	int mode;
	float window[3][5] = { {-1, -2, 6, -2, -1},{-1, -2, 7, -2, -1},{0.1, 0.2, 0.4, 0.2, 0.1} };

	for (mode = 0; mode < 3; mode++) {
		unsigned int store = 0;
		for (int i = 0; i < 480 * 272; i++) {
			float r = 0;
			float g = 0;
			float b = 0;

			for (int j = 0; j < 5; j++) {
				if ((i == 0 && j <= 1))
					continue;
				else if ((i == 1 && j == 0))
					continue;
				else if ((i == 480 * 272 - 2 && j == 4))
					continue;
				else if ((i == 480 * 272 - 1 && j >= 3))
					continue;

				r += (float)(((arr[i + j - 2] & 0xf800) >> 11) * window[mode][j]);
				g += (float)(((arr[i + j - 2] & 0x7e0) >> 5) * window[mode][j]);
				b += (float)((arr[i + j - 2] & 0x1f) * window[mode][j]);
			}
			if (r > 31 || r < 0)
				r = 0;
			if (g > 63 || g < 0)
				g = 0;
			if (b > 31 || b < 0)
				b = 0;
			unsigned short r_t = (unsigned short)round(r);
			r_t = r_t << 11;
			unsigned short g_t = (unsigned short)round(g);
			g_t = g_t << 5;
			unsigned short b_t = (unsigned short)round(b);

			if (i % 2 == 0)
				store = r_t | g_t | b_t;
			else {
				store = store | ((r_t | g_t | b_t) << 16);
				conv[mode][i / 2] = store;
			}
		}
		FILE* fp;
		fp = fopen(filename[mode], "wb+");
		int cnt = 0;

		for (int j = 0; j < 480 * 272 / 2; j++) {
			for (int k = 0; k < 2; k++) {

				unsigned int a = (conv[mode][j] >> (16 * k)) & 0xffff;
				char temp[10];
				sprintf(temp, "%x", a);
				for (int m = 0; m < 4; m++) {
					if ((temp[m] >= '0' && temp[m] <= '9') || (temp[m] >= 'a' && temp[m] <= 'f'))
						continue;
					else
						temp[m] = '0';
				}
				char hex[8];
				hex[0] = '0';
				hex[1] = 'x';
				hex[2] = temp[0];
				hex[3] = temp[1];
				hex[4] = temp[2];
				hex[5] = temp[3];
				hex[6] = ',';
				hex[7] = ' ';
				fwrite(hex, 1, sizeof(hex), fp);
				cnt++;
				if (cnt % 8 == 0)
					fwrite("\n", 1, sizeof("\n"), fp);

			}
		}
	}


		/*
	char str[20];
	sprintf(str, "%x", conv[mode][0]);
	printf("%s\n", str);
	for (int i = 0; i < 10; i++)
	//	printf("%x\n", conv[mode][480 * 272 / 2-1-9+i]);
		printf("%x\n", conv[mode][ i]);
		*/
	return 0;
}